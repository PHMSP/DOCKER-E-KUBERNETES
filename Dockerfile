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