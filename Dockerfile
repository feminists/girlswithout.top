FROM alpine:edge

WORKDIR /page

COPY package.json package-lock.json ./

RUN apk add --no-cache --virtual .node nodejs-current npm && \
    npm i

COPY . .

RUN npm run build && \
    mv dist /out && \
    adduser -h /out -s /bin/false -D -H girl && \
    chown -R girl:girl /out && \
    apk del .node && \
    apk add --no-cache darkhttpd

CMD ["darkhttpd", "/out"]
