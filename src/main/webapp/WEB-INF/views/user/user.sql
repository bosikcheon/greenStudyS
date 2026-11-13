show tables;

create table user (
  idx  int  not null auto_increment primary key,
  mid  varchar(20) not null,
  name varchar(20) not null,
  age  int  default 20,
  address varchar(20) default '서울'
);

desc user;

insert into user values (default, 'admin', '관리자', 33, '서울 동작구');
insert into user values (default, 'atom1234', '아톰맨', 21, '서울 관악구');
insert into user values (default, 'btom1234', '비톰맨', 13, '서울 영등포구');
insert into user values (default, 'ctom1234', '씨톰맨', 33, '대전');
insert into user values (default, 'dtom1234', '디톰맨', 33, '청주');

select * from user;
