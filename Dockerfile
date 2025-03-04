# 根据你的 PHP 版本选择合适的镜像
FROM arm64v8/php:8.4-rc-fpm

# 更新系统
RUN apt update
RUN apt-get update

# 安装必要的 PHP 扩展 (根据你的应用程序需求修改)
RUN apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install mysqli

# 设置工作目录
WORKDIR /var/www/html

# 复制你的应用程序代码到容器
#COPY . /var/www/html/

# 暴露端口
EXPOSE 9000

# 设置时区 (可选)
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone

# 启动 PHP-FPM (通常不需要，因为 php:*-fpm 镜像已经配置好了)
# CMD ["php-fpm"]

