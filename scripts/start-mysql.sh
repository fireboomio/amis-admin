#!/bin/bash

# 定义容器名称
CONTAINER_NAME="mysql-oidc"

docker stop $CONTAINER_NAME

docker rm $CONTAINER_NAME

# 创建并启动MySQL容器 (设置表名大小写不敏感)
docker run -itd --name $CONTAINER_NAME --restart always -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql --lower_case_table_names=1

# 等待容器启动
sleep 5
docker ps

# 将your_data.sql文件注入到容器中
# docker cp init2.0.sql $CONTAINER_NAME:/init.sql

# docker cp init.sql mysql2:/init.sql
sleep 3

# until mysql -h 127.0.0.1 -e "SELECT 1"; do sleep 1; done
until 
    docker exec -i $CONTAINER_NAME mysql -uroot -p123456 -e "SELECT 1"; 
do 
    sleep 3; 
done

sleep 1
# 在容器中执行初始化数据的操作
docker exec -i $CONTAINER_NAME mysql -uroot -p"123456" < init2.0.sql
sleep 1
docker exec -i $CONTAINER_NAME mysql -uroot -p"123456" -e "SHOW DATABASES;"
# 执行完毕后删除your_data.sql文件
# docker exec $CONTAINER_NAME rm /init.sql
