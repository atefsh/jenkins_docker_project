FROM ubuntu

WORKDIR /app

ADD main.sh .
RUN chmod +x main.sh
CMD ./main.sh 
