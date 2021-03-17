FROM openresty/openresty:alpine-fat
RUN luarocks install pgmoon
RUN luarocks install lua-resty-template
COPY conf/luatest.conf /etc/nginx/conf.d
RUN mkdir -p /var/www/lua/test
COPY lua/test.lua /var/www/lua/test
EXPOSE 8080
CMD [ "openresty", "-c", "/etc/nginx/conf.d/luatest.conf", "-g", "daemon off;" ]