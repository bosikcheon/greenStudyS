show tables;

create table user2 (
  idx  int  not null auto_increment,	/* 고유번호 */
  mid  varchar(20) not null,		/* 로그인한 사용자 아이디 */
  pwd  varchar(100) not null,		/* 비밀번호 */
  name varchar(20) not null,		/* 성명 */
  age  int  default 20,					/* 나이 */
  gender char(2) default '여자',	/* 성별 */
  address varchar(20) default '서울',	/* 주소 */
  primary key (idx),
  unique key (mid)
);
drop table user2;

desc user2;

insert into user2 values (default, 'admin', '1234', '관리자', 33, default, '서울 동작구');

select * from user2;

select distinct gender from user2 order by gender
