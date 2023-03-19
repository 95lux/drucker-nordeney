# drucker-nordeney
Simple printer service written in python.
Evaluates POST Request body.

## POST Request

The server application gets its commands via POST request. It listens on  ``ipaddress:5555/print`` 

The POST body has to be in following JSON format:

```
{
    "name": "jonas",
    "score": 100
}
```

## config.ini

Various configuration takes places in config.ini

### *sentences* section

Sentences which are printed on the ticket. Follows with *"name!"*
4 is most points, 1 is least points.

### *printer* section

printername: Windows hardware name of the used printer. As long as the printer is not exchanged, it is: "Boca BIDI FGL 26/46 200 DPI"  

maxjobs: Sets the maximum number of printer jobs, that get queued when the printer is not connected or not available due to errors/misfunction (e.g. paper jam). The oldest jobs get deleted, the new jobs get added. The job queue contains always the most recent added jobs.

