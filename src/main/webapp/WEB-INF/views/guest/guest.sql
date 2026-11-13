show tables;

create table guest (
  idx  int not null auto_increment primary key,	/* 방명록 고유번호 */
  name varchar(20) not null,		/* 방명록 작성자 성명 */
  content text not null,				/* 방명록 글 내용 */
  email varchar(60),						/* 메일주소 */
  homePage varchar(60),					/* 홈페이지주소(블로그 주소) */
  hostIp   varchar(30) not null, /* 방문자의 접속 IP */
  visitDate datetime default now() /* 방문일자 */
);

desc guest;

insert into guest values (default, '관리자', '방명록 서비스를 시작합니다.', 'cjsk1126@naver.com', 'cjsk1126.tistory.com', '192.168.50.20', default);
insert into guest values (default, '홍길동', '길동이 글 올립니다.', 'hkd1234@naver.com', 'hkd1234.tistory.com', '192.168.50.51', default);

select * from guest;