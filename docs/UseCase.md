## Messagebroker

Un servizio per inviare un messaggio ad un cittadino deve effettuare una chiamata al message broker come mostrato di seguito.

1. Il servizio invia una singola notifica su tutte le canalità (è possibile omettere le canalità che non interessano); il cittadino riceverà le notifiche sulle canalità sulle quali ha espressamente impostato una preferenza:
	
	**POST /api/v1/topics/messages**

	Headers:
	```
	x-authentication: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzViMTYwNTAtY2MzMS00YTJlLTgxOTMtYWI1ZjM3MGQ2OTM1IiwicHJlZmVyZW5jZV9zZXJ2aWNlX25hbWUiOiJkZW1vX2ZlIiwiZXhwIjoyNTM0MDIyOTcxNDAsImlhdCI6MTYxNjQyNzc4MCwiYXBwbGljYXRpb25zIjp7InByZWZlcmVuY2VzIjpbInJlYWQiLCJ3cml0ZSJdLCJtZXgiOlsicmVhZCIsIndyaXRlIl0sImV2ZW50cyI6WyJyZWFkIl19LCJwcmVmZXJlbmNlcyI6e319.akQYdm0kPqqdtKUM1y2NSJxMMqCLYUsdS7Nh4xsqlTQ
	```

	Body:
	```
	{
		"uuid": "67e79131-d1b4-46bb-8e7f-e69eaeb807a6",
		"expire_at": "2019-04-23T20:00:00",
		"payload": {
			"id": "df5fc799-4ebd-403f-8145-af164fd158a5",
			"user_id": "PPPPLT80R10M082K",
			"tag": "appuntamenti,urgente,c_l219",
			"push": {
				"title":"conferma appuntamento anagrafe",
				"body":"Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe",
				"call_to_action":"https://servizi.torinofacile.it/cgi-bin/accesso/base/index.cgi?cod_servizio=SPOT&realm=torinofacile"
			},
			"email": {
				"subject":"conferma appuntamento anagrafe",
				"body":"Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
				"template_id":"template-spff.html"
			},
			"sms": {
				"content":"Ricorda l'appuntamento presso l'anagrafe di Torino per il 24 Aprile 2019 ore 09:00. per maggiori info www.torinofacile.it"
			},
			"mex": {
				"title": "conferma appuntamento anagrafe",
				"body" : "Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
				"call_to_action": "https://servizi.torinofacile.it/cgi-bin/accesso/base/index.cgi?cod_servizio=SPOT&realm=torinofacile"
			},
			"io": {
				"time_to_live": 3600,
				"content": {
					"subject": "conferma appuntamento anagrafe",
					"markdown": "# memo appuntamento## presso ufficio Anagrafe di Città di TorinoTi ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
					"due_date": "2019-04-24T00:00:00"
				}
			},
			"memo":{
				"start": "2019-04-24 09:00:00",
				"end": "2019-04-24 09:45:00",
				"summary": "appuntamento Anagrafe Città di Torino",
				"description": "Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe",
				"location": "Via della Consolata, 23, 10122 Torino",
				"organizer": "Torino Facile <noreply.torinofacile@csi.it>"
			}
		}
	}
	```

1. Il servizio invia un gruppo di notifiche, identificate dallo stesso bulk_id:

    **POST /api/v1/topics/messages**

	Headers:
	```
	x-authentication: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzViMTYwNTAtY2MzMS00YTJlLTgxOTMtYWI1ZjM3MGQ2OTM1IiwicHJlZmVyZW5jZV9zZXJ2aWNlX25hbWUiOiJkZW1vX2ZlIiwiZXhwIjoyNTM0MDIyOTcxNDAsImlhdCI6MTYxNjQyNzc4MCwiYXBwbGljYXRpb25zIjp7InByZWZlcmVuY2VzIjpbInJlYWQiLCJ3cml0ZSJdLCJtZXgiOlsicmVhZCIsIndyaXRlIl0sImV2ZW50cyI6WyJyZWFkIl19LCJwcmVmZXJlbmNlcyI6e319.akQYdm0kPqqdtKUM1y2NSJxMMqCLYUsdS7Nh4xsqlTQ
	```

	Body:
	```
	[
		{
		"uuid": "db2b5681-87af-4bff-95ed-b1b22f4c2f2d",
		"expire_at": "2019-04-23T20:00:00",
		"payload": {
			"id": "db2b5681-87af-4bff-95ed-b1b22f4c2f2d",
			"bulk_id": "fbede27f-3dc1-4b73-8d8a-c452b8f377ec",
			"user_id": "PPPPLT80R10M082K",
			"tag": "appuntamenti,urgente,c_l219",
			"push": {
						"title":"conferma appuntamento anagrafe",
						"body":"Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe",
						"call_to_action":"https://servizi.torinofacile.it/cgi-bin/accesso/base/index.cgi?cod_servizio=SPOT&realm=torinofacile"
			},
			"email": {
				"subject":"conferma appuntamento anagrafe",
				"body":"Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
				"template_id":"template-spff.html"
			},
			"sms": {
				"content":"Ricorda l'appuntamento presso l'anagrafe di Torino per il 24 Aprile 2019 ore 09:00. per maggiori info www.torinofacile.it"
			},
			"mex": {
				"title": "conferma appuntamento anagrafe",
				"body" : "Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
				"call_to_action": "https://servizi.torinofacile.it/cgi-bin/accesso/base/index.cgi?cod_servizio=SPOT&realm=torinofacile"
			},
			"io": {
				"time_to_live": 3600,
				"content": {
					"subject": "conferma appuntamento anagrafe",
					"markdown": "# memo appuntamento## presso ufficio Anagrafe di Città di TorinoTi ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
					"due_date": "2019-04-24T00:00:00"
				}
			},
			"memo":{
				"start": "2019-04-24 09:00:00",
				"end": "2019-04-24 09:45:00",
				"summary": "appuntamento Anagrafe Città di Torino",
				"description": "Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe",
				"location": "Via della Consolata, 23, 10122 Torino",
				"organizer": "Torino Facile <noreply.torinofacile@csi.it>"
			}
		}
	},
		{
			"uuid": "d7255707-dd47-4d49-8189-f795a2c1a542",
			"payload": {
				"id": "d7255707-dd47-4d49-8189-f795a2c1a542",
				"bulk_id":"fbede27f-3dc1-4b73-8d8a-c452b8f377ec",
				"user_id": "CNZCNE92R10R082Z",
				"push": {
							"title":"Titolo push 2",
							"body":" corpo push 2",
							"call_to_action":"https://servizi.torinofacile.it/cgi-bin/accesso/base/index.cgi?cod_servizio=SPOT&realm=torinofacile"
				},
				"email": {
					"subject":"subject email 2",
					"body":" corpo del messaggio HTML",
					"template_id":"default-template.html"
				},
				"sms": {
					"content":"corpo sms 2"
				},
				"mex": {
					"title": "titolo mex 2",
					"body" : " corpo mex 2",
					"call_to_action": "https://servizi.torinofacile.it/cgi-bin/accesso/base/index.cgi?cod_servizio=SPOT&realm=torinofacile"
				}
			}
		},
		{
		"uuid": "b04581a8-6a39-4b86-99f9-336940a60ebf",
		"expire_at": "2019-04-23T20:00:00",
		"payload": {
			"id": "b04581a8-6a39-4b86-99f9-336940a60ebf",
			"bulk_id":"fbede27f-3dc1-4b73-8d8a-c452b8f377ec",
			"user_id": "TTTSRN81R10M082G",
			"tag": "appuntamenti,urgente,c_l219",
			"push": {
						"title":"conferma appuntamento anagrafe",
						"body":"Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe",
						"call_to_action":"https://servizi.torinofacile.it/cgi-bin/accesso/base/index.cgi?cod_servizio=SPOT&realm=torinofacile"
			},
			"email": {
				"subject":"conferma appuntamento anagrafe",
				"body":"Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
				"template_id":"template-spff.html"
			},
			"sms": {
				"content":"Ricorda l'appuntamento presso l'anagrafe di Torino per il 24 Aprile 2019 ore 09:00. per maggiori info www.torinofacile.it"
			},
			"mex": {
				"title": "conferma appuntamento anagrafe",
				"body" : "Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
				"call_to_action": "https://servizi.torinofacile.it/cgi-bin/accesso/base/index.cgi?cod_servizio=SPOT&realm=torinofacile"
			},
			"io": {
				"time_to_live": 3600,
				"content": {
					"subject": "conferma appuntamento anagrafe",
					"markdown": "# memo appuntamento## presso ufficio Anagrafe di Città di TorinoTi ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe per il 24 Aprile 2019 ore 09:00",
					"due_date": "2019-04-24T00:00:00"
				}
			},
			"memo":{
				"start": "2019-04-24 09:00:00",
				"end": "2019-04-24 09:45:00",
				"summary": "appuntamento Anagrafe Città di Torino",
				"description": "Ti ricordiamo l'appuntamento prenotato presso l'ufficio anagrafe",
				"location": "Via della Consolata, 23, 10122 Torino",
				"organizer": "Torino Facile <noreply.torinofacile@csi.it>"
			}
		}
	}
	]

	```