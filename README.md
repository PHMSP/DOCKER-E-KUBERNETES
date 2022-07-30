# DevOps - TESTE DOCKER E KUBERNETES

# Teste 1

Clusterizar uma aplicação criada pelo candidato que fique exibindo no log do pod a cada vinte segundos um valor de uma secret de Kubernetes.

## Dockerfile 
contendo Ubuntu e Python, onde python-dotenv foi instalado para se trabalhar com as váriaveis de ambiente

```bash
FROM python:3

#instalações necessárias para rodar o script
RUN apt-get update 

RUN sudo apt install python3-pip -y

RUN pip3 install python-dotenv

WORKDIR /usr/app/src
# copiar arquivo remoto para a root
COPY app.py ./
COPY .env ./

# rodar comando no start do container
CMD ["python" , "./app.py"]
```

## Python

Script que fique exibindo o valor de uma variável de ambiente do sistema operacional de 20 em 20 segundos
o nome da variável deve ser "TWORPTEST" e o valor desta variável deve ser "true100%".

```bash
import os
import time
from dotenv import load_dotenv

load_dotenv()
var1 = os.getenv('TWORPTEST')
print(var1)

while True:
    time.sleep(20)
    print(var1)
```

Documento .env criado para se trabalhar com as váriaveis de ambiente

```bash
TWORPTEST=true100%
```

Container rodando

![dockertest](https://user-images.githubusercontent.com/100800875/181860426-61ec1db9-e7f3-42a1-a5e5-caa886edc3f7.jpg)

Docker HUB

![image](https://user-images.githubusercontent.com/100800875/181860582-7fb98311-98a2-4474-8b8b-72a5d25abd8d.png)

Docker HUB: https://hub.docker.com/repository/docker/phmsp/tworptest

Documento: https://pypi.org/project/python-dotenv/

# Kubernetes

## Deployment
```yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  name: tworptest
  labels:
    app: tworp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tworp
  template:
    metadata:
      labels:
        app: tworp
    spec:
      containers:
        - name: tworptest
          image: docker.io/phmsp/tworptest:1.0
          env:
            - name: TWORPTEST
              valueFrom:
                secretKeyRef:
                  key: TWORPTEST
                  name: tworpsecret
```

## Secret
```yaml
kind: Secret
apiVersion: v1
metadata:
  name: tworpsecret
type: Opaque
data:
  TWORPTEST: dHJ1ZTEwMCU=
```
Codificado por Base64 dHJ1ZTEwMCU = true100%

## Services

```yaml
kind: Service
apiVersion: v1
metadata:
  labels:
    app: tworp
  name: tworptest-service
spec:
  type: ClusterIP 
  ports:
    - port: 8080
      targetPort: 8080        
  selector:
    app: tworp
```

