docker run -ti \
-p 4567:3000 \
-v /home/alex/repos/ff/dockerenv/nodejs-4.1/nodejs-4.1.0/app/package.json:/app/package.json \
-v /home/alex/repos/ff/dockerenv/nodejs-4.1/nodejs-4.1.0/app/src:/app/src \
de-nodejs-4.1.0-4.1.0 \
/bin/bash
