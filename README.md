# example-rails-app
Example Rails app voor de DevOps assessment.

Om de applicatie lokaal (http://localhost:3000/) te bekijken kan je het volgende uitvoeren: `bin/rails server`.

De applicatie is zo minimaal mogelijk opgezet, het is nu alleen mogelijk om een artikel met een naam en omschrijving aan te maken.

### PostgresQL
De applicatie maakt gebruik van een PostgresQL database server. De configuratie van de database (naam, gebruikersnaam en wachtwoord) staat in de file database.yml.

### Docker entrypoint
Als de connectie goed is tussen de Rails applicatie en de Postgres instance dan kan de applicatie starten en wordt de migratie automatisch uitgevoerd. De scripts hiervoor staan in de ./docker folder.

### Opdracht
De opdracht bestaat uit 2 onderdelen:
1. Maak een Kubernetes cluster (m.b.v. Terraform of Ansible).
2. Deploy de Rails applicatie naar het cluster.

#### Onderdeel 1
Maak met Terraform (https://www.terraform.io/) een nieuw cluster in AWS Elastic Kubernetes Service (Amazon EKS), Azure Cloud of Google Cloud (GKE). Een andere mogelijke optie is IBM Cloud. Eventueel mag ook gebruik worden gemaakt van Ansible (https://docs.ansible.com/ansible/latest/index.html), maar Terraform heeft de voorkeur.

Je kunt hiervoor gebruik maken van een Free Tier of Free Trial account.
- AWS EKS: https://aws.amazon.com/free/
- Azure: https://azure.microsoft.com/en-us/offers/ms-azr-0044p/
- GKE: https://cloud.google.com/free
- IBM: https://www.ibm.com/cloud/free

De Terraform-code moet door ons uitgevoerd kunnen worden met ons eigen account.

#### Onderdeel 2
Zorg ervoor dat de aangeleverde Rails applicatie op het cluster draait. De applicatie maakt gebruikt van een databaseserver (MySQL of Postgres) die ook in het cluster moet draaien. Voor het deployen dient het bestand ci/deployment.yml te worden gevuld met de juiste informatie.

Bovenaan deze file wordt uitgelegd hoe de applicatie lokaal gedraaid kan worden om een gevoel te krijgen wat te applicatie doet. Er kan gebruik worden gemaakt van de dockerfile in deze applicatie om een image te bouwen die in het cluster gedraaid kan worden.
