show tables;

create table board (
	idx  int not null auto_increment,	/* 게시글의 고유번호 */
	mid  varchar(20) not null,				/* 게시글 올린이 아이디 */
	nickName varchar(20) not null,		/* 게시글 올린이 닉네임(무조건 공개) */
	title varchar(100) not null,			/* 게시글 제목 */
	content text not null,						/* 게시글 내용 */
	hostIp	varchar(40) not null,			/* 글 올린이 IP */
	openSw	char(2) default 'OK',			/* 게시글 공개여부(OK:공개, NO:비공개) */
	readNum int default 0,						/* 글 조회수 */
	wDate   datetime default now(),		/* 글 올린 날짜 */
	good    int default 0,						/* '좋아요' 클릭 횟수 누적 */
	complaint char(2) default 'NO',		/* 신고글 유무(정상글:NO, 신고당한글:OK) */
	primary key(idx),
	foreign key(mid) references member(mid)	/* 외래키 설정 */
);
drop table board;
desc board;

insert into board values (default,'admin','관리맨','게시판 서비시 개시','게시판서비스를 시작합니다. 많은 관심 부탁드려요.', '192.168.50.20',default,default,default,default,default);

select * from board;

/* 댓글 달기 */
create table boardReply (
  idx      	int not null auto_increment,/* 댓글 고유번호 */
  boardIdx	int not null,						/* 원본글의 고유번호 */
  mid				varchar(20),						/* 댓글 올린이 아이디 */
  nickName  varchar(20) not null,		/* 댓글 올린이 별명 */
  wDate			datetime default now(),	/* 댓글 쓴날짜 */
  hostIp		varchar(50) not null,		/* 댓글 올린 Host IP */
  content   text not null,					/* 댓글 내용 */
  primary key(idx),
  foreign key(mid)      references member(mid) on delete set null,
  foreign key(boardIdx) references board(idx)
  /* on update cascade */
  on update restrict
  on delete cascade
);
desc boardReply;
drop table boardReply;

insert into boardReply values (default,28,'kms1234','김장미',default,'192.168.50.57','잘 보고 갑니다.');

select * from boardReply;

-- 댓글 출력 연습
select * from board order by idx desc;

select * from boardReply where boardIdx=27 order by idx desc;
select count(*) as replyCnt from boardReply where boardIdx=27;
select *,count(*) as replyCnt from boardReply where boardIdx=27;

select board.idx, board.* from board, boardReply order by idx desc;
select b.idx, b.* from board b, boardReply r order by idx desc;
select b.*, (select count(*) from boardReply where boardIdx=27) as replyCnt from board b, boardReply r where b.idx=27 order by idx desc;
select b.*, (select count(*) from boardReply where boardIdx=b.idx) as replyCnt from board b where b.idx=27;
select b.*, (select count(*) from boardReply where boardIdx=b.idx) as replyCnt from board b order by b.idx desc;

-- 날짜(시간)로 비교해서 필드값 저장하기
select *, timestampdiff(hour, wDate , now()) as hour_diff from board order by idx desc;
