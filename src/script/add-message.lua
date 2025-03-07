local function c(o)
 return cmsgpack.pack(o)
end

local ns = ARGV[1]
local queue_or_topic = ARGV[2]
local msgs = cjson.decode(ARGV[3])
local is_topic = ARGV[4]
local keys = redis.call('SMEMBERS',ns .. "consumers:" .. queue_or_topic)
local score = 1
local maxRetries = 120
if table.getn(msgs) > 1 then
 score = 100
end

if is_topic == "true"
then
    if(table.getn(keys) == 0)
    then
        return "the topic '" .. queue_or_topic .. "' does not exist"
    end
    for j,msgKey in ipairs(msgs) do
        local uuid = msgs[j].uuid
        redis.call('HSET', ns .. "coda:queues:" .. queue_or_topic, uuid, c(msgs[j]))
        if score ~= 100 then
          local priority = msgs[j].priority
          if priority == "high" then
            score = 0
          end
        end
        for i, key in ipairs(keys) do
          local key_priority = key
          redis.call('HINCRBY', ns .. "counter:queues:" .. queue_or_topic, uuid, 1)
          redis.call('ZADD',ns .. "queues:" .. queue_or_topic .. ":" .. key, score, uuid)
        end
    end
else
    for i,msgKey in ipairs(msgs) do
        local queue = queue_or_topic
        local hashset = string.gsub(queue, ":.*:to_be_retried", "")
        local counter = string.gsub(queue, ":.*:to_be_retried", "")
        local uuid = msgKey.uuid

        local i = string.find(queue, "to_be_retried");
        local channelqueue = string.gsub(queue, ":to_be_retried", "")
        if(i ~= nil) then
          local retryNum = tonumber(redis.call('HGET', ns .. "retries:" .. channelqueue, uuid));
          if(retryNum == nil or retryNum+1 < maxRetries) then
            redis.call('HINCRBY', ns .. "retries:" .. channelqueue, uuid, 1);

            redis.call('HSET', ns .. "coda:queues:" .. hashset, uuid, c(msgKey));
            redis.call('HINCRBY', ns .. "counter:queues:" .. counter, uuid, 1);
            local priority = msgKey.priority
            if priority == "high" then
              score = 0
            end
            redis.call('ZADD',ns .. "queues:" .. queue, score, uuid);
          else
            redis.call('HDEL', ns .. "retries:" .. channelqueue, uuid);

            redis.call('HSET', ns .. "coda:queues:" .. hashset .. ":dead", uuid, c(msgKey));
            redis.call('HINCRBY', ns .. "counter:queues:" .. counter .. ":dead", uuid, 1);
            local priority = msgKey.priority
            if priority == "high" then
              score = 0
            end
            redis.call('ZADD',ns .. "queues:" .. channelqueue .. ":dead", score, uuid);
          end
        else
          redis.call('HSET', ns .. "coda:queues:" .. hashset, uuid, c(msgKey));
          redis.call('HINCRBY', ns .. "counter:queues:" .. counter, uuid, 1);
          local priority = msgKey.priority
          if priority == "high" then
            score = 0
          end
          redis.call('ZADD',ns .. "queues:" .. queue, score, uuid);
        end
    end
end

return "OK"
