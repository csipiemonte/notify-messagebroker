local ns = ARGV[1]

local keys = redis.call("KEYS", ns .. "retries:*");
for i, key in ipairs(keys) do
    local uuids = redis.call("HKEYS", key);
    local queue = string.gsub(key, ns .. "retries:(%w+):%w+", ns .. "coda:queues:%1");
    for y, uuid in ipairs(uuids) do
        local message_exists = redis.call("HGET", queue, uuid)
        if not message_exists then
            redis.call("HDEL", key, uuid);
        end
    end
end
