# start from base
FROM ubuntu:18.04

LABEL maintainer="Prakhar Srivastav <prakhar@prakhar.me>"

# install system-wide deps for python and node
RUN apt-get -yqq update; \
    apt-get -yqq install python3-pip python3-dev curl gnupg; \
    curl -sL https://deb.nodesource.com/setup_10.x | bash; \
    apt-get install -yq nodejs

# copy our application code
ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

# fetch app specific deps
RUN npm install; \
    npm run build; \
    pip3 install -r requirements.txt

# expose port
EXPOSE 5000

# start app
CMD [ "python3", "./app.py" ]
