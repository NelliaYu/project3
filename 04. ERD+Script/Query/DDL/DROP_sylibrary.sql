
--21. 후기
DROP TABLE tblReview;
DROP SEQUENCE seqReview;

--20.  대출현황
DROP TABLE tblPresent;
DROP SEQUENCE seqPresent;


--19.  도서예약현황
DROP TABLE tblBookingStatus;
DROP SEQUENCE seqBookingStatus;

--18. 관심도서목록
DROP TABLE tblWishBook;
DROP SEQUENCE seqWishBook;


--17. 책 테이블 삭제
drop table tblBook;

--17. 책 시퀀스 삭제
drop sequence seqBook;


/* 시설이용시간 */
DROP TABLE tblInFacilTime;

DROP SEQUENCE seqInFacilTime;


/* 택배 */
DROP TABLE tblParcel;

-- 택배 시퀀스 삭제
DROP SEQUENCE seqParcel;



/* 도서기증목록 */
DROP TABLE tblBookdona;
    
-- 희망도서 시퀀스 삭제
DROP SEQUENCE seqBookdona;

/* 희망도서 */
DROP TABLE tblWishBookDoc;
    
-- 희망도서 시퀀스 삭제
DROP SEQUENCE seqWishBookDoc;


/* 문의하기댓글 */
DROP TABLE tblNoticeComment;

-- 문의하기댓글 시퀀스 삭제
DROP SEQUENCE seqNoticeComment;


/* 문의하기 */
DROP TABLE tblNoticeQnA;

-- 문의하기 시퀀스 삭제
DROP SEQUENCE seqNoticeList;


/* 공지사항 */
DROP TABLE tblNoticList;

-- 공지사항 시퀀스 삭제
DROP SEQUENCE seqNoticeList;


--10. 관리자
drop sequence seqAdmin;
drop table tblAdmin;

--9. 회원
drop sequence seqMember;
drop table tblMember;

--8. 연속간행물
drop sequence seqSeries;
drop table tblSeries;

--7. 비도서
drop sequence seqNonBook;
drop table tblNonBook;


--6. 자주묻는질문
drop sequence seqNoticeFAO;
drop table tblNoticeFAO;


--5. 오시는길
drop sequence seqInfoStreet;
drop table tblInfoStreet;


--4. 시설현황
drop table tblInFacil;
drop sequence seqInFacil;

--3. 도서관이용안내
drop table tblInfoGuide;
drop sequence seqInfoGuide;

--2. 연혁
drop table tblInfoHistory;
drop sequence seqInfoHistory;


--1. 인사말
drop table tblInfoHello;
drop sequence seqInfoHello;

