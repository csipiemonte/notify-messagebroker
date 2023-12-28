## Descrizione

Componente Message Broker per il progetto Notify (Piattaforma di notifica regionale). Si occupa di ricevere le notifiche inviate dai servizi e di inserirle nel message broker ([Redis](https://redis.io/)).

## Configurazione

Per una corretta configurazione della componente vedere il file **README.md** presente nella cartella *docs*.

## Installazione

* Clonare il repository in una cartella. (Il modulo dipende dalla componente [notify-commons](https://github.com/csipiemonte/notify-commons), pertanto nella cartella deve essere presente tale componente)
* Posizionarsi nella cartella del repository: `cd notify-messagebroker`
* Eseguire il comando `npm install` per installare le dipendenze
* Eseguire lo script `./messagebroker` per avviare la componente
