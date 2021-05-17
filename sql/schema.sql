create database if not exists `life_case`;

use `life_case`;

-- 用户信息表
create table if not exists `tb_user`(
    `id` varchar(32) not null primary key,
    `username` varchar(200) not null,
    `password` varchar(50) not null,
    `avatar` varchar(100) not null,
    `vip` tinyint(1) not null
) engine = InnoDB comment '用户信息表';

-- 
create table if not exists `record`()