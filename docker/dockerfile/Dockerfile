FROM python:3.10
WORKDIR /usr/src/app
EXPOSE 8888
COPY requirements.txt ./
RUN pip3 install -r requirements.txt
COPY app.py ./
CMD python3 app.py