# zmirror-docker
Dockefile for [aploium/zmirror](https://github.com/aploium/zmirror)
Thanks [aploium/zmirror](https://github.com/aploium/zmirror)

# How-To

~~~shell
cd zmirror-docker/zmirror-base/
docker build zmirror-base:latest .
cd zmirror-docker/
docker build zmirror:latest .
~~~

# Run

~~~yml
version: '2'
services:
  zmirror:
    container_name: zmirror
    image: zmirror
    environment:
      # 如果将zmirror-docker服务部署崽代理后面，那么代理与zmirror-docker之间用http连接即可
      #- IS_BEHIND_PROXY=true
      # 如果需要 google 镜像，将以下注释去掉并指定你的域名
      #- HOST_NAME_FOR_GOOGLE=google.mydomain.com
      # 如果需要 youtube 镜像，将以下注释去掉并指定你的域名
      #- HOST_NAME_FOR_YOUTUBE=youtube.mydomain.com
      # 如果需要 youtube-mobile 镜像，将以下注释去掉并指定你的域名
      #- HOST_NAME_FOR_YOUTUBE_MOBILE=m.youtube.mydomain.com
      # 如果需要 facebook 镜像，将以下注释去掉并指定你的域名
      #- HOST_NAME_FOR_FACEBOOK=facebook.youtube.mydomain.com
      # 如果需要 twitter 镜像，将以下注释去掉并指定你的域名
      #- HOST_NAME_FOR_TWITTER=twitter.mydomain.com
      # 如果需要 twitter-mobile 镜像，将以下注释去掉并指定你的域名
      #- HOST_NAME_FOR_TWITTER_MOBILE=m.twitter.mydomain.com
      # 如果需要 instagram 镜像，将以下注释去掉并指定你的域名
      #- HOST_NAME_FOR_INSTAGRAM=instagram.mydomain.com
    network_mode: bridge
    ports:
      - "80:80"
      - "443:443"
    restart: always

~~~