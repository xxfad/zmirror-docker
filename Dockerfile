FROM zmirror-runtime
    
ADD cert/ /cert
ADD sites-available/ /etc/apache2/sites-available
ADD entrypoint.sh /

RUN chmod +x /entrypoint.sh \
    && cd /var/www/ \
    && git clone https://github.com/aploium/zmirror \
    && sed -i "s/www.localhost.com/127.0.0.1/g" zmirror/more_configs/config_youtube.py \
    && sed -i "s/www.localhost.com/127.0.0.1/g" zmirror/more_configs/config_youtube_mobile.py \
    && sed -i "s/verbose_level\ =\ 3/verbose_level\ =\ 2/g" zmirror/config_default.py \
    && sed -i "s/built_in_server_debug\ =\ True/built_in_server_debug\ =\ False/g" zmirror/config_default.py \
    && chown -R www-data:www-data zmirror \
    && cd /etc/apache2/conf-enabled \
    && wget https://gist.githubusercontent.com/aploium/8cd86ebf07c275367dd62762cc4e815a/raw/29a6c7531c59590c307f503b186493e559c7d790/h5.conf

# Expose ports
EXPOSE 80  
EXPOSE 443  
    
ENTRYPOINT /entrypoint.sh
