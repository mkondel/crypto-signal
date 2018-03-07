FROM python:3.6-jessie

# TA-lib is required by the python TA-lib wrapper. This provides analysis.
COPY lib/ta-lib-0.4.0-src.tar.gz /tmp/ta-lib-0.4.0-src.tar.gz

RUN cd /tmp && \
  tar -xvzf ta-lib-0.4.0-src.tar.gz && \
  cd ta-lib/ && \
  ./configure --prefix=/usr && \
  make && \
  make install

ADD app/ /app
WORKDIR /app

# numpy must be installed first for python TA-lib
RUN pip install numpy==1.14.0
RUN pip install -r requirements.txt

ENV SETTINGS_MARKET_PAIRS=ETH/USD,LTC/USD,BTC/USD
ENV EXCHANGES_GDAX_REQUIRED_ENABLED=false
ENV EXCHANGES_BITFINEX_REQUIRED_ENABLED=true
ENV EXCHANGES_BITTREX_REQUIRED_ENABLED=false
ENV SETTINGS_UPDATE_INTERVAL=3600

ENV NOTIFIERS_SLACK_REQUIRED_WEBHOOK=https://hooks.slack.com/services/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

ENV NOTIFIERS_DISCORD_REQUIRED_WEBHOOK=https://discordapp.com/api/webhooks/420761536743866409/IqXS7f5nU0Qz3uivSnW4zR0CbWbfyn8ZuERTrGJdNUBpzp7HXLywlPKu1bFgvwmmLWSV
ENV NOTIFIERS_DISCORD_OPTIONAL_AVATAR=https://cdn.discordapp.com/attachments/268381289692921857/420772621068533761/rambo.png
ENV NOTIFIERS_DISCORD_REQUIRED_USERNAME=LamboRambo

CMD ["/usr/local/bin/python","app.py"]
