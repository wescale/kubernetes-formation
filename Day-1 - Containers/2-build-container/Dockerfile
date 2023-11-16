FROM python:3.11-alpine

# A LABEL is just metadata
LABEL maintainer="Wescale Formation <training@wescale.fr>"


# We create the `worker` user with an Alpine command
RUN addgroup -S worker && adduser -S worker -G worker
# Change the default user for following RUN commands to `worker`
USER ...
# Change the current directory to /code
WORKDIR ...
# Copy the directory python-code to the current directory. 
# Leave the --chown option to ensure `worker` user can access the files.
COPY --chown=worker:worker ...
# Execute the command: pip install
RUN ...

CMD python app.py
EXPOSE 5000