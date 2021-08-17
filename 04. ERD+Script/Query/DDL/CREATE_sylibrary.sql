
--1. 인사말
create table tblInfoHello (

    hello_seq number not null,
    hello_info varchar2(4000) not null
    
);

--1. 인사말 제약사항
alter table tblInfoHello
    add constraint tblInfoHello_hello_seq_pk primary key(hello_seq);

--1. 인사말 시퀀스 생성
create sequence seqInfoHello;




--2. 연혁
create table tblInfoHistory (

    history_seq number not null,
    history_date date not null,
    history_content VARCHAR2(200) not null
    
);

--2. 연혁 제약사항
alter table tblInfoHistory
    add constraint tblInfoHistory_history_seq_pk primary key(history_seq);

--2. 연혁 시퀀스 생성
create sequence seqInfoHistory;



--3. 도서관이용안내
create table tblInfoGuide (

    guide_seq number not null,
    guide_time VARCHAR2(100),
    guide_date DATE not null,
    guide_closed varchar2(10)

);


--3. 도서관이용안내 제약사항
alter table tblInfoGuide
    add constraint tblInfoGuide_guide_seq_pk primary key(guide_seq);

--3. 도서관이용안내 시퀀스 생성
create sequence seqInfoGuide;





--4. 시설현황
create table tblInFacil (

    facil_seq NUMBER not null,
    facil_position VARCHAR2(100) not null,
    facil_area NUMBER not null,
    facil_use VARCHAR2(1000)
    
);

--4. 시설현황 제약사항
alter table tblInFacil
    add constraint tblInFacil_facil_seq_pk primary key(facil_seq);

--4. 시설현황 시퀀스 생성
create sequence seqInFacil;




--5. 오시는길
create table tblInfoStreet (

    street_seq NUMBER not null,
    street_address VARCHAR2(500) not null,
    street_trans VARCHAR2(500) not null,
    street_transinfo VARCHAR2(3000) not null,
    street_parking VARCHAR2(3000) not null
    
);

--5. 오시는길 제약사항
alter table tblInfoStreet
    add constraint tblInfoStreet_street_seq_pk primary key(street_seq);

--5. 오시는길 시퀀스 생성
create sequence seqInfoStreet;




--6. 자주묻는질문
create table tblNoticeFAQ (

    faq_seq NUMBER not null,
    faq_subject VARCHAR2(1000) not null,
    faq_content VARCHAR2(3000) not null,
    faq_kind VARCHAR2(100) not null
    
);

--6. 자주묻는질문 제약사항
alter table tblNoticeFAQ
    add constraint tblNoticeFAQ_faq_seq_pk primary key(faq_seq);

alter table tblNoticeFAQ
    add constraint tblNoticeFAQ_faq_kind_ck check ( faq_kind in ('회원가입', '도서관자료', '도서관이용', '기타'));

--6. 자주묻는질문 시퀀스 생성
create sequence seqNoticeFAQ;



--7. 비도서
create table tblNonBook (

    nbook_seq NUMBER not null,
    nbook_subject VARCHAR2(200) not null,
    nbook_publisher VARCHAR2(50) not null,
    nbook_kind VARCHAR2(50) not null,
    nbook_date VARCHAR2(30) not null,
    nbook_position VARCHAR2(30) not null,
    nbook_image	VARCHAR2(500)	NOT NULL,
    nbook_author	VARCHAR2(50)	NOT NULL,
    nbook_callnumber VARCHAR2(50)	NOT NULL,
    nbook_isbn	VARCHAR2(50)	NULL,
    nbook_genre	VARCHAR2(30)	NULL,
    nbook_status	VARCHAR2(20)	NOT NULL
    
);

--7. 비도서 제약사항
alter table tblNonBook
    add constraint tblNonBook_nbook_seq_pk primary key(nbook_seq);

alter table tblNonBook
    add constraint tblNonBook_nbook_kind_ck check(nbook_kind in ('DVD', 'CD', 'eBook'));

alter table tblNonBook
    add constraint tblNonBook_nbook_position_ck check(nbook_position = '디지털자료실');

alter table tblNonBook
    add constraint tblNonBook_nbook_status_ck check(nbook_status in ('대출가능', '대출불가'));


--7. 비도서 시퀀스 생성
create sequence seqNonBook;




--8. 연속간행물
create table tblSeries (

    series_seq NUMBER not null,
    series_subject VARCHAR2(200) not null,
    series_publisher VARCHAR2(50) not null,
    series_kind VARCHAR2(30) not null,
    series_date VARCHAR2(30) not null,
    series_position VARCHAR2(30) not null
    
);

--8. 연속간행물 제약사항
alter table tblSeries
    add constraint tblSeries_series_seq_pk primary key(series_seq);

alter table tblSeries
    add constraint tblSeries_series_kind_ck check(series_kind in ('신문', '잡지'));

alter table tblSeries
    add constraint tblSeries_series_position_ck check(series_position = '종합자료실');


--8. 연속간행물 시퀀스 생성
create sequence seqSeries;




--9. 회원
create table tblMember (

    member_seq NUMBER not null,
    member_id VARCHAR2(20) not null,
    member_pw VARCHAR2(20) not null,
    member_name VARCHAR2(20) not null,
    member_tel VARCHAR2(20) not null,
    member_birth DATE not null,
    member_email VARCHAR2(30) not null,
    member_address VARCHAR2(1000) not null,
    member_hash varchar2(20),
    member_check varchar2(20)
    
);

--9. 회원 제약사항
alter table tblMember
    add constraint tblMember_member_seq_pk primary key(member_seq);

alter table tblMember add(member_lv number(5));
update tblmember set member_lv = 1;

--9. 회원 시퀀스 생성
create sequence seqMember
	START WITH 100;




--10. 관리자
create table tblAdmin (

    admin_seq NUMBER not null,
    admin_id VARCHAR2(20) not null,
    admin_pw VARCHAR2(20) not null,
    admin_name VARCHAR2(20) not null
    
);

--10. 관리자 제약사항
alter table tblAdmin
    add constraint tblAdmin_admin_seq_pk primary key(admin_seq);

--10. 관리자 시퀀스 생성
create sequence seqAdmin;



--11. 공지사항 
CREATE TABLE tblNoticeList (
	list_seq NUMBER NOT NULL, /* 글번호 */
	list_subject VARCHAR2(100) NOT NULL, /* 제목 */
	list_content VARCHAR2(3000) NOT NULL, /* 내용 */
	list_date DATE DEFAULT sysdate NOT NULL, /* 날짜 */
	list_readcount NUMBER NOT NULL, /* 조회수 */
	admin_seq NUMBER NOT NULL /* 관리자번호 */
);

--11. 공지사항 제약사항
ALTER TABLE tblNoticeList
	add CONSTRAINT tblnotice_list_seq_pk primary key(list_seq); -- 공지사항 기본키
    
ALTER TABLE tblNoticeList
	add CONSTRAINT tblnotice_admin_seq_fk foreign key(admin_seq) REFERENCES tblAdmin(admin_seq);


--11. 공지사항 시퀀스 생성 
CREATE SEQUENCE seqNoticeList;



--12. 문의하기  
CREATE TABLE tblNoticeQnA (
	qna_seq NUMBER NOT NULL, /* 글번호 */
	qna_subject VARCHAR2(100) NOT NULL, /* 제목 */
	qna_content VARCHAR2(3000) NOT NULL, /* 내용 */
	qna_kind VARCHAR2(100) NOT NULL, /* 분류 */
	qna_date DATE DEFAULT sysdate NOT NULL, /* 날짜 */
	qna_readcount NUMBER NOT NULL, /* 조회수 */
    qna_pw varchar2(10) NULL, /* 비밀번호 */
	member_seq NUMBER NOT NULL /* 회원번호 */
);

--12. 문의하기 제약사항
ALTER TABLE tblNoticeQnA
	add CONSTRAINT tblQnA_qna_seq_pk primary key(qna_seq); -- 문의하기 기본키

ALTER TABLE tblNoticeQnA
	add CONSTRAINT tblQnA_member_seq_fk foreign key(member_seq) REFERENCES tblMember(member_seq);
    
ALTER TABLE tblNoticeQnA
	add CONSTRAINT tblQnA_qna_kind_ck check (qna_kind in ('전체', '회원가입', '도서관자료', '도서관이용', '기타'));

--12. 문의하기 시퀀스 생성 
CREATE SEQUENCE seqNoticeQnA;



--13. 문의하기댓글 
CREATE TABLE tblNoticeComment (
	comment_seq NUMBER NOT NULL, /* 댓글번호 */
	comment_text VARCHAR2(3000) NOT NULL, /* 내용 */
	comment_regdate DATE DEFAULT sysdate NOT NULL, /* 작성날짜 */
	comment_pseq NUMBER NOT NULL, /* 글번호 */
	admin_seq NUMBER NOT NULL /* 관리자번호 */
);

--13. 문의하기댓글 제약사항
ALTER TABLE tblNoticeComment
	add CONSTRAINT tblComment_qna_seq_pk primary key(comment_seq); -- 문의하기댓글 기본키

ALTER TABLE tblNoticeComment
	add CONSTRAINT tblComment_comment_pseq_fk foreign key(comment_pseq) REFERENCES tblNoticeQnA(qna_seq);

ALTER TABLE tblNoticeComment
	add CONSTRAINT tblComment_admin_seq_fk foreign key(admin_seq) REFERENCES tblAdmin(admin_seq);

--13. 문의하기댓글 시퀀스 생성 
CREATE SEQUENCE seqNoticeComment;



--14. 희망도서      
CREATE TABLE tblWishBookDoc (
	wishbook_seq NUMBER NOT NULL, /* 희망도서 */
	wishbook_subject VARCHAR2(200) NOT NULL, /* 제목 */
	wishbook_author VARCHAR2(50) NOT NULL, /* 저자 */
	wishbook_publisher VARCHAR2(50) NOT NULL, /* 출판사 */
	wishbook_kind VARCHAR2(50) NOT NULL, /* 종류 */
	wishbook_date DATE DEFAULT sysdate NOT NULL, /* 희망신청일 */
	wishbook_status varchar2(50) NOT NULL, /* 신청현황(입고예정일) 신청완료 입고예정(날짜) 신청반려*/
	wishbook_reason varchar2(300), /* 반려사유 */
	member_seq NUMBER NOT NULL /* 회원번호 */
);

--14. 희망도서 제약사항
ALTER TABLE tblWishBookDoc
	add CONSTRAINT tblWish_wishbook_seq primary key(wishbook_seq); -- 희망도서 기본키

ALTER TABLE tblWishBookDoc
	add CONSTRAINT tblWish_member_seq_fk foreign key(member_seq) REFERENCES tblMember(member_seq);

ALTER TABLE tblWishBookDoc
	add CONSTRAINT tblWish_wishbook_kind_ck check (wishbook_kind in ('총류', '철학', '종교', '사회과학', '자연과학', '기술과학', '예술', '언어', '문학', '역사'));
    
    
--14. 희망도서 시퀀스 생성 
CREATE SEQUENCE seqWishBookDoc;


select * from tblBookdona;

--15. 도서기증목록 
/* 도서기증 */
CREATE TABLE tblBookdona (
	dona_seq NUMBER NOT NULL, /* 도서기증번호 */
	dona_applydate date DEFAULT sysdate NOT NULL, /* 기증신청날짜 */
	dona_finishdate date, /* 기증완료날짜 */
	dona_status varchar2(20), /* 상태 */
	member_seq NUMBER NOT NULL, /* 회원번호 */
	dona_subject VARCHAR2(200) NOT NULL, /* 제목 */
	dona_author VARCHAR2(50) NOT NULL, /* 저자 */
	dona_publisher VARCHAR2(50) NOT NULL /* 출판사 */
);

--15. 도서기증목록 테이블 제약사항
ALTER TABLE tblBookdona
	add CONSTRAINT tblDona_dona_seq primary key(dona_seq); -- 도서기증목록 기본키

ALTER TABLE tblBookdona
	add CONSTRAINT tblDona_member_seq_fk foreign key(member_seq) REFERENCES tblMember(member_seq);

ALTER TABLE tblBookdona
	add CONSTRAINT tblDona_dona_status_ck check (dona_status in ('기증신청', '기증완료')); 

--15. 도서기증목록 시퀀스 생성 
CREATE SEQUENCE seqBookdona;




--16. 택배 
CREATE TABLE tblParcel (
	parcel_seq number NOT NULL, /* 택배번호 */
	parcel_size varchar2(30), /* 박스크기 */
	parcel_pay varchar2(30), /* 결제방법 */
	parcel_address varchar2(100), /* 보낸사람주소 */
	dona_seq NUMBER /* 도서기증번호 */
);

--16. 택배 제약사항
ALTER TABLE tblParcel
	add CONSTRAINT tblParcel_parcel_seq primary key(parcel_seq); -- 택배 기본키

ALTER TABLE tblParcel
	add CONSTRAINT tblParcel_dona_seq_fk foreign key(dona_seq) REFERENCES tblBookdona(dona_seq);

ALTER TABLE tblParcel
	add CONSTRAINT tblParcel_parcel_size_ck check (parcel_size in ('소(100cm)', '중(120cm)', '대(160cm)')); 

ALTER TABLE tblParcel
	add CONSTRAINT tblParcel_parcel_pay_ck check (parcel_pay in ('신용카드', '가상계좌')); 

--16. 도서기증목록 시퀀스 생성 
CREATE SEQUENCE seqParcel;





/* 시설이용시간 */
CREATE TABLE tblInFacilTime (
	faciltime_seq NUMBER NOT NULL, /* 시설이용시간번호 */
	facil_seq NUMBER NOT NULL, /* 시설번호 */
	faciltime_day VARCHAR2(50) NOT NULL, /* 요일구분 */
	faciltime_time VARCHAR2(100) NOT NULL /* 이용시간 */
);
-- 제약사항
ALTER TABLE tblInFacilTime
	add CONSTRAINT tblinfatime_faciltime_seq primary key(faciltime_seq); -- 기본키
   

CREATE SEQUENCE seqInFacilTime;



--17. 책
create table tblBook(
    book_seq number not null,
    book_image varchar2(500) not null, --500으로 수정
    book_subject varchar2(200) not null,
    book_author varchar2(50) not null,
    book_publisher varchar2(50) not null,
    book_date varchar2(30) not null,
    book_callnumber varchar2(50) not null,
    book_isbn varchar2(50) not null,
    book_genre varchar2(30) not null,
    book_position varchar2(30) not null,
    book_country varchar2(30) not null,
    book_status varchar2(20) not null,
    wishbook_seq number,
    dona_seq number --이름 수정해야됨. 기증도서번호
);

select * from tblBook;

--17. 책 제약사항
alter table tblBook add constraint tblBook_book_seq primary key(book_seq);
alter table tblBook add constraint tblBook_wishbook_seq foreign key(wishbook_seq) references tblWishBookDoc(wishbook_seq);
alter table tblBook add constraint tblBook_dona_seq foreign key(dona_seq) references tblBookdona(dona_seq); --이름 수정해야됨. 기증도서번호

--17. 책 시퀀스 생성
create sequence seqBook;


--17. 책 테이블 삭제
drop table tblBook;

--17. 책 시퀀스 삭제
drop sequence seqBook;


-- erd수정 210726
alter table tblBook modify(book_status varchar2(20)); 
alter table tblBook modify(BOOK_AUTHOR varchar2(200));
alter table tblNonBook modify(nbook_author varchar2(200));  
alter table tblBook modify(book_country null);
alter table tblBook modify(book_image null);
alter table tblBook modify(book_publisher null);
alter table tblBook modify(book_author null);
alter table tblNonBook modify(nbook_image null);
alter table tblNonBook modify(nbook_publisher null);
alter table tblNonBook modify(nbook_author null);

-- 책 테이블 컬럼추가
alter table tblBook add(book_regdate date default sysdate not null);

-- 택배 테이블 컬럼 삭제
alter table tblParcel drop column parcel_address;
-- 택배 테이블 컬럼 추가
alter table tblParcel add (parcel_visitdate date null);
alter table tblParcel add (parcel_etc varchar2(2000) null);
-- 택배 테이블 제약사항 추가
alter table tblParcel add constraint tblParcel_member_seq_fk foreign key(member_seq) references tblMember(member_seq);


--18. 관심도서목록
DROP TABLE tblWishBook;
CREATE TABLE tblWishBook (
	wish_seq  number       NOT NULL,
	member_seq number NOT NULL,
    book_seq number  NULL,
	nbook_seq  number  NULL
);

-- 18. 관심도서목록 제약사항
ALTER TABLE tblWishBook
	add CONSTRAINT tblwishBook_wish_seq_pk primary key(wish_seq); 
ALTER TABLE tblWishBook
	add CONSTRAINT tblwishBook_member_seq_fk foreign key(member_seq) REFERENCES tblMember(member_seq);
ALTER TABLE tblWishBook
	add CONSTRAINT tblwishBook_book_seq_fk foreign key(book_seq) REFERENCES tblBook(book_seq);
ALTER TABLE tblWishBook
	add CONSTRAINT tblwishBook_nbook_seq_fk foreign key(nbook_seq) REFERENCES tblNonBook(nbook_seq);

-- 18. 관심도서목록 시퀀스 생성 
DROP SEQUENCE seqWishBook;
CREATE SEQUENCE seqWishBook;

--19. 도서예약현황
DROP TABLE tblBookingStatus;
CREATE TABLE tblBookingStatus (
	booking_seq  number NOT NULL,
	booking_date date NOT NULL,
    booking_visitdate date  NOT NULL,
	member_seq  number  NOT NULL,
    book_seq  number  NOT NULL
);

-- 19. 도서예약현황 제약사항
ALTER TABLE tblBookingStatus
	add CONSTRAINT tblbookingstatus_booking_seq_pk primary key(booking_seq); 
ALTER TABLE tblBookingStatus
	add CONSTRAINT tblbookingstatus_member_seq_fk foreign key(member_seq) REFERENCES tblMember(member_seq);
ALTER TABLE tblBookingStatus
	add CONSTRAINT tblbookingstatus_book_seq_fk foreign key(book_seq) REFERENCES tblBook(book_seq);


-- 19. 도서예약현황 시퀀스 생성 
DROP SEQUENCE seqBookingStatus;
CREATE SEQUENCE seqBookingStatus;


--20. 대출현황
DROP TABLE tblPresent;
CREATE TABLE tblPresent (
	lending_seq number NOT NULL,
	lending_date date NOT NULL,
    return_date date NULL,
	lending_status varchar2(10) NULL,
    member_seq number  NOT NULL,
    book_seq  number NULL,
    nbook_seq  number NULL
);

-- 20. 대출현황 제약사항
ALTER TABLE tblPresent
	add CONSTRAINT tblpresent_lending_seq_pk primary key(lending_seq); 
ALTER TABLE tblPresent
	add CONSTRAINT tblpresent_member_seq_fk foreign key(member_seq) REFERENCES tblMember(member_seq);
ALTER TABLE tblPresent
	add CONSTRAINT tblpresent_book_seq_fk foreign key(book_seq) REFERENCES tblBook(book_seq);
ALTER TABLE tblPresent
	add CONSTRAINT tblpresent_nbook_seq_fk foreign key(nbook_seq) REFERENCES tblNonBook(nbook_seq);


-- 20. 대출현황 시퀀스 생성 
DROP SEQUENCE seqPresent;
CREATE SEQUENCE seqPresent;


--21. 후기
DROP TABLE tblReview;
CREATE TABLE tblReview (
	review_seq number NOT NULL,
	review_star_rating number NOT NULL,
    review_percent number NOT NULL,
	review_content varchar2(3000) NOT NULL,
    lending_seq number  NOT NULL
);

-- 21. 후기 제약사항
ALTER TABLE tblReview
	add CONSTRAINT tblreview_review_seq_pk primary key(review_seq); 
ALTER TABLE tblReview
	add CONSTRAINT tblreview_lending_seq_fk foreign key(lending_seq) REFERENCES tblPresent(lending_seq);



-- 21. 후기 시퀀스 생성 
DROP SEQUENCE seqReview;
CREATE SEQUENCE seqReview;

