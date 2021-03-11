FROM alpine

RUN apk update && apk add bash &&\
    echo '#!/usr/bin/env bash' > /usr/bin/entrypoint.sh &&\
    echo 'echo "Hi from Bud!"' >> /usr/bin/entrypoint.sh &&\
    chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT /usr/bin/entrypoint.sh
