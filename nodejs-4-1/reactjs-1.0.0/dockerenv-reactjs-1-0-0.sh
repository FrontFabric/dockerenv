#
BASEURL="https://raw.githubusercontent.com/nodejs/docker-node/master/4.1/Dockerfile"
BASEIMG="ff-nodejs-4-1"
VERSION="1.0.0"
IMAGE="ff-reactjs-$VERSION"
APPNAME=${PWD##*/}
APPIMG="ff-$APPNAME-$VERSION"
USERID=$(id -u)
START_DEV="dockerenv-start-dev-$VERSION.sh"

#
mkdir -p app/src
if [ ! -e "app/package.json" ] 
then
    echo "{}" > app/package.json
fi

#
mkdir -p dockerenv/$BASEIMG
mkdir -p dockerenv/$IMAGE
mkdir -p dockerenv/$APPIMG

#
cd dockerenv/$BASEIMG
rm Dockerfile
wget $BASEURL

docker build -t $BASEIMG .
echo "Dockerfile" > .gitignore
cd ../..

#
cd dockerenv/$IMAGE
echo "FROM $BASEIMG:latest" > Dockerfile
echo "" >> Dockerfile
echo "RUN apt-get -y update \\" >> Dockerfile
echo "&& apt-get -y upgrade \\" >> Dockerfile
echo "&& apt-get -y install bash \\" >> Dockerfile
echo "&& apt-get clean autoclean \\" >> Dockerfile
echo "&& apt-get -y autoremove \\" >> Dockerfile
echo "&& rm -rf /var/lib/{apt,dpkg,cache,log}/" >> Dockerfile

docker build -t $IMAGE .
echo "Dockerfile" > .gitignore
cd ../..

#
cp -f app/package.json dockerenv/$APPIMG/package.json
cd dockerenv/$APPIMG
echo "FROM $IMAGE:latest" > Dockerfile
echo "" >> Dockerfile
echo "RUN mkdir /app \\" >> Dockerfile
echo "&& useradd -u $USERID appuser \\" >> Dockerfile
echo "&& mkdir /home/appuser \\" >> Dockerfile
echo "&& chown appuser /app \\" >> Dockerfile
echo "&& chown appuser /home/appuser" >> Dockerfile
echo "USER $USERID" >> Dockerfile
echo "ADD package.json /app/package.json" >> Dockerfile
echo "RUN cd /app \\" >> Dockerfile
echo "&& npm install" >> Dockerfile
echo "" >> Dockerfile
echo "WORKDIR /app" >> Dockerfile

docker build -t $APPIMG .
echo "Dockerfile" > .gitignore
rm package.json
cd ../..

#
echo "docker run -ti \\" > $START_DEV
echo "-v $PWD/app/src:/app/src \\" >> $START_DEV
echo "$APPIMG \\" >> $START_DEV
echo "/bin/bash" >> $START_DEV
