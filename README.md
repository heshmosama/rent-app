# Life Vision Task application
Life vision flutter task application. it presents some accounts data from Microsoft dataverse. users allowed to review, search and filter accounts' data. the flutter app calls a backend middleware service and the middleware service call Microsoft dataverse.

## To Run Docker file:
```bash
$ docker-compose up -d
```
### This will generate two services :
   1. Rent-flutter:
      this for the flutter app and it is mapped to port :8000
   2. Rent-service:
      this backend middleware api and it is mapped to port :3000
