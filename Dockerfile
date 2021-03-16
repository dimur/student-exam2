FROM alpine:latest
WORKDIR /opt/student-exam2
RUN apk add python3 \
    && git clone https://github.com/dimur/student-exam2.git . \
    && python3 -m venv venv \
    && . venv/bin/activate \
    && pip install -e .
ENV FLASK_APP js_example
EXPOSE 5000
ENTRYPOINT . venv/bin/activate && flask run --host=0.0.0.0
