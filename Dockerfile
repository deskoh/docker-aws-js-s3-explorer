ARG BASE_REGISTRY=registry.access.redhat.com
ARG BASE_IMAGE=ubi8/ubi-minimal
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

ARG BASE_REGISTRY
ARG BASE_IMAGE

RUN if [ "$BASE_REGISTRY/$BASE_IMAGE" == "registry.access.redhat.com/ubi8/ubi-minimal" ]; then \
        microdnf install nginx && \
        microdnf clean all && \
        rm -f \
            /usr/share/nginx/modules/mod-http-image-filter.conf \
            /usr/share/nginx/modules/mod-http-perl.conf \
            /usr/share/nginx/modules/mod-http-xslt-filter.conf \
            /usr/share/nginx/modules/mod-mail.conf && \
        rm -f \
            /usr/share/nginx/modules/ngx_http_image_filter_module.so \
            /usr/share/nginx/modules/ngx_http_perl_module.so \
            /usr/share/nginx/modules/ngx_http_xslt_filter_module.so \
            /usr/share/nginx/modules/2019 ngx_mail_module.so && \
        ln -sf /dev/stdout /var/log/nginx/access.log && \
        ln -sf /dev/stderr /var/log/nginx/error.log && \
        chmod -R o-rwx /etc/nginx && \
        rm -rf /usr/share/nginx/html/* && \
        echo 'OK' > /usr/share/nginx/html/index.html && \
        chown -R nginx:nginx /usr/share/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx; \
    fi

RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

COPY --chown=nginx nginx.conf /etc/nginx/
RUN chmod -R ug-x,o-rwx /etc/nginx/nginx.conf

WORKDIR /usr/share/nginx/html/

ADD --chown=nginx index.html .
ADD --chown=nginx explorer.js .

ADD --chown=nginx https://raw.githubusercontent.com/awslabs/aws-js-s3-explorer/v2-alpha/explorer.css .

# Add external resources
ADD --chown=nginx https://aws.amazon.com/favicon.ico .

# JS / CSS
ADD --chown=nginx https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap.min.css ./css/
ADD --chown=nginx https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js ./js/
ADD --chown=nginx https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js ./js/
ADD --chown=nginx https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.7.5/angular.min.js ./js/
ADD --chown=nginx https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/4.4.0/bootbox.min.js ./js/
ADD --chown=nginx https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.0/moment.min.js ./js/
ADD --chown=nginx https://code.jquery.com/jquery-3.4.1.min.js ./js/
ADD --chown=nginx https://sdk.amazonaws.com/js/aws-sdk-2.437.0.min.js ./js/
ADD --chown=nginx https://stackpath.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap-theme.min.css ./css/
ADD --chown=nginx https://stackpath.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css ./css/
ADD --chown=nginx https://stackpath.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js ./js/
ADD --chown=nginx https://use.fontawesome.com/releases/v5.6.3/css/all.css ./css/

# Fonts
ADD --chown=nginx https://stackpath.bootstrapcdn.com/bootstrap/3.4.0/fonts/glyphicons-halflings-regular.woff2 ./fonts/
ADD --chown=nginx https://use.fontawesome.com/releases/v5.6.3/webfonts/fa-solid-900.woff2 ./webfonts/
ADD --chown=nginx https://use.fontawesome.com/releases/v5.6.3/webfonts/fa-solid-900.woff ./webfonts/
ADD --chown=nginx https://use.fontawesome.com/releases/v5.6.3/webfonts/fa-solid-900.ttf ./webfonts/

USER nginx

CMD ["nginx", "-g", "daemon off;"]
