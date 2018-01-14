#!/bin/bash

##################################################################
# HTTP_PROXY=
# HTTPS_PROXY=
# IS_BEHIND_PROXY=
# HOST_NAME_FOR_GOOGLE=
# HOST_NAME_FOR_YOUTUBE=
# HOST_NAME_FOR_YOUTUBE_MOBILE=
# HOST_NAME_FOR_FACEBOOK=
# HOST_NAME_FOR_TWITTER=
# HOST_NAME_FOR_TWITTER_MOBILE=
# HOST_NAME_FOR_INSTAGRAM=
##################################################################

ENABLED=false

# 转小写
IS_BEHIND_PROXY=$(echo   ${IS_BEHIND_PROXY}   |   tr   [A-Z]   [a-z])

# 定义部署函数

deploy() {

    ENABLED=true

    HOST_NAME=$1
    HOST_ABBREVIATION=$2
    
    echo 
    echo "deploying ${HOST_NAME}(${HOST_ABBREVIATION})"
    echo 
    
    cd /var/www/
    
    # 已经部署好，直接跳过
    if [ -d ${HOST_ABBREVIATION}/ ]; then
        return
    fi    

    cp -rf zmirror/ ${HOST_ABBREVIATION}
    cd ${HOST_ABBREVIATION}/
    cp more_configs/config_${HOST_ABBREVIATION}.py config.py
    cp more_configs/custom_func_${HOST_ABBREVIATION:0:5}*.py custom_func.py >/dev/null 2>&1
    sed -i "s/my_host_name = '127.0.0.1'/my_host_name = '${HOST_NAME}'/g" config.py
    sed -i "s/my_host_scheme = 'http:\/\/'/my_host_scheme = 'https:\/\/'/g" config.py
    cd /etc/apache2/sites-enabled/
    
    cp ../sites-available/zmirror-http.conf ./zmirror-http-${HOST_ABBREVIATION}.conf
    sed -i "s/lovelucia.zmirrordemo.com/${HOST_NAME}/g" zmirror-http-${HOST_ABBREVIATION}.conf
    sed -i "s/google/${HOST_ABBREVIATION}/g" zmirror-http-${HOST_ABBREVIATION}.conf
    
    if [ "${IS_BEHIND_PROXY}" == "true" ]; then
        echo ""
    else
        cp ../sites-available/zmirror-https.conf ./zmirror-https-${HOST_ABBREVIATION}.conf
        sed -i "s/lovelucia.zmirrordemo.com/${HOST_NAME}/g" zmirror-https-${HOST_ABBREVIATION}.conf
        sed -i "s/google/${HOST_ABBREVIATION}/g" zmirror-https-${HOST_ABBREVIATION}.conf
    fi

}

# 部署 GOOGLE
if [ "${HOST_NAME_FOR_GOOGLE}" != "" ]; then
    deploy "${HOST_NAME_FOR_GOOGLE}" "google_and_zhwikipedia"
fi


# 部署 YOUTUBE
if [ "${HOST_NAME_FOR_YOUTUBE}" != "" ]; then
    deploy "${HOST_NAME_FOR_YOUTUBE}" "youtube"
fi

# 部署 YOUTUBE-MOBILE
if [ "${HOST_NAME_FOR_YOUTUBE_MOBILE}" != "" ]; then
    deploy "${HOST_NAME_FOR_YOUTUBE_MOBILE}" "youtube_mobile" "www.localhost.com"
fi

# 部署 FACEBOOK
if [ "${HOST_NAME_FOR_FACEBOOK}" != "" ]; then
    deploy "${HOST_NAME_FOR_FACEBOOK}" "facebook"
fi

# 部署 TWITTER
if [ "${HOST_NAME_FOR_TWITTER}" != "" ]; then
    deploy "${HOST_NAME_FOR_TWITTER}" "twitter_pc"
fi

# 部署 TWITTER-MOBILE
if [ "${HOST_NAME_FOR_TWITTER_MOBILE}" != "" ]; then
    deploy "${HOST_NAME_FOR_TWITTER_MOBILE}""twitter_mobile"
fi

# 部署 INSTAGRAM
if [ "${HOST_NAME_FOR_INSTAGRAM}" != "" ]; then
    deploy "${HOST_NAME_FOR_INSTAGRAM}" "instagram"
fi

if [ "${ENABLED}" == "false" ]; then
    echo "必须至少配置一个站点"
    exit 1
fi

service apache2 start

tail -f /var/log/apache2/access.log

