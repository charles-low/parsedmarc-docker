FROM python:latest

WORKDIR /app
COPY parsedmarc/dist/*.whl ./
COPY docker/start.sh /start.sh

RUN apt-get update \
    && apt-get install -y libxslt-dev libz-dev libxml2-dev gcc libemail-outlook-message-perl \
    && pip install *.whl \
    && apt-get purge --yes gcc && apt autoremove --yes && apt-get clean \
    && mkdir /etc/parsedmarc \
    && rm -Rf /var/lib/{apt,dpkg}/ && rm -Rf /root/.cache/ \
    && rm *.whl \
    && chmod +x /start.sh

ENTRYPOINT [ "/start.sh" ]