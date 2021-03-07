FROM alpine:latest
WORKDIR /opt/student-exam2
COPY ./* .
RUN apk add python3 \
    && python3 -m venv venv \
    && . venv/bin/activate \
    && pip install -e .
ENV FLASK_APP js_example
EXPOSE 5000
CMD . venv/bin/activate && flask run --host=0.0.0.0
