FROM docker.io/ubnt/unms-netflow:0.13.1 AS unms-netflow-patch
RUN  apk add --no-cache patch
COPY 0000-unms-netflow-v9-no-padding.patch /tmp/0000-unms-netflow-v9-no-padding.patch
RUN  patch -p1 < /tmp/0000-unms-netflow-v9-no-padding.patch \
 &&  cp lib/netflow/v9/parser.js /parser.js

FROM docker.io/ubnt/unms-netflow:0.13.1 AS unms-netflow
COPY --from=unms-netflow-patch /parser.js lib/netflow/v9/parser.js
