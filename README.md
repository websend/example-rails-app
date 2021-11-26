# example-rails-app
Example Rails app voor de DevOps assessment.

Om de applicatie lokaal (http://localhost:3000/) te bekijken kan je het volgende uitvoeren: `bin/rails server`.

De applicatie is zo minimaal mogelijk opgezet, het is nu alleen mogelijk om een artikel met een naam en omschrijving aan te maken.

### PostgresQL
De applicatie maakt gebruik van een PostgresQL database server. De configuratie van de database (naam, gebruikersnaam en wachtwoord) staat in de file database.yml.

### Docker entrypoint
Als de connectie goed is tussen de Rails applicatie en de Postgres instance dan kan de applicatie starten en wordt de migratie automatisch uitgevoerd. De scripts hiervoor staan in de ./docker folder.
