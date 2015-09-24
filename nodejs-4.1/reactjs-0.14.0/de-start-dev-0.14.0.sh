docker run -ti \
-p 4567:3000 \
-v /home/sasha/repos/ff/dockerenv/nodejs-4.1/reactjs-0.14.0/app/package.json:/app/package.json \
-v /home/sasha/repos/ff/dockerenv/nodejs-4.1/reactjs-0.14.0/app/src:/app/src \
de-reactjs-0.14.0-0.14.0 \
/bin/bash
