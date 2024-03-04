FROM busybox

COPY custom-go /fb/custom-go
COPY store /fb/store
COPY upload /fb/upload

CMD [ "cp", "-rfT", "/fb", "/app" ]
