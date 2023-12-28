# Introduzione

*messagebroker* è la comopnente che riceve le notifiche inviate dai servizi e li inserisce sul message broker in modo che i consumer di ciascuna canalità possano inviarli.

# Getting Started

Per rendere operativo il sistema occorre:
1. impostare gli opportuni valori delle variabili d'ambiente
1. editare il file di configurazione
1. avviare l'applicazione

## Prerequisites

* Istanza di [Redis](https://redis.io/) attiva e in ascolto sulla porta impostata sulla conf (o quella di default, 6379, se omessa)

## Configuration
La configurazione è basata su variabili d'ambiente e file di configurazione. Una variabile può essere presente sia su variabile d'ambiente che nel file di conf specifico dell'ambiente che nel file di conf generico della componente. All'avvio della comopnente viene effettuato il merge di questi tre entry point. Le variabili se prensenti in più punti (file o env) vengono gestite con la seguente priorità (dalla più alta alla più bassa):
* variabile d'ambiente
* file di conf specifico dell'ambiente
* file di conf generico della componente

Le variabili d'ambiente da valorizzare sono:
* `ENVIRONMENT`: rappresenta l'ambiente di esecuzione (ad esempio dev, tst o prod). Serve per individuare il file di configurazione secondario.

I file di configurazione sono `conf/mb.json` e`conf/mb-{ENVIRONMENT}.json`. Ove lo stesso parametro sia presente su entrambi i file il valore in `conf/mb-{ENVIRONMENT}.json` ha la precedenza.

I principali attributi presenti nei file di configurazione sono elencati di seguito (per l'elenco completo visualizzare il contenuto dei file presenti nella cartella src/conf):

* `app_name` : nome dell'applicazione (obbligatorio per tracciatura degli eventi e check sicurezza)
* `server_port`: porta che utilizzerà l'istanza del server
* `request_limit`: dimensione massima del payload in ingresso
* `redis`: configurazioni del server Redis
    * `keyPrefix`: prefisso delle chiavi in Redis
    * `do_setup`: se true, crea la struttura dati di default su redis
* `security`: contiene la configurazione della sicurezza
    * `secret`: password per verificare firma del token auth utilizzato per chiamare la comopnente
    * `blacklist`: contiene la url per recuperare i token in blacklist
        *`url`: url per recupero token in blacklist
* `log4js`: la configurazione di log4js (vedi https://www.npmjs.com/package/log4js)

# Token JWT

La sicurezza è gestita tramite token JWT, il token contiene, oltre ai parametri di default (come `iat`, `exp`, ...):
* `preference_service_name`: il nome del servizio
* `applications`: contiene le appicazioni della suite Notify con i relativi permessi assegnati.
* `preferences`: contiene le configurazioni delle eventuali canalità abilitate per il servizio (come ad esempio l'indirizzo email con cui inviare le notifiche email, il token push con cui inviare le notifiche push, ecc...).

La passphrase usata verificare la correttezza della firma del token è contenuta nella variabile d'ambiente `MB_SECURITY_SECRET` oppure nel file di configurazione.
Il token JWT viene letto nell'header `x-authentication`.

# Running

Avviare messagebroker server 
```
cd src && node messagebroker.js
```

or

```
npm start
```

## Use case

Vedere file **UseCase.md**.