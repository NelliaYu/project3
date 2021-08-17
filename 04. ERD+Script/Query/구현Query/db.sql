-- 4조 웹프로젝트 디비파일


--이용시간 안내 이번달 데이터 뷰
create or replace view vwInfoGuide
as
select * from tblInfoGuide where substr(guide_date, 0, 8) between trunc(sysdate,'MM') and (last_day(sysdate));



--메인 대출베스트 뷰
create or replace view vwMainBest
as
select 
    p.book_seq, b.book_subject, b.book_author, count(p.lending_seq) as book_count
from tblPresent p
inner join tblBook b
on p.book_seq = b.book_seq
where p.lending_date between sysdate - 7 and sysdate
group by p.book_seq, b.book_subject, b.book_author order by count(p.lending_seq) desc;



--도서 테이블 일반 도서 개수 구하기
create or replace view vwNormalBookCount
as
select book_genre, count(book_genre) as book_count from tblBook where book_position = '종합자료실' group by book_genre order by book_genre;

select * from vwNormalBookCount;



--도서 테이블 어린이 도서 개수 구하기
create or replace view vwChildrenBookCount
as
select book_genre, count(book_genre) as book_count from tblBook where book_position = '어린이자료실' group by book_genre order by book_genre;


--도서 테이블 전체 도서 개수 구하기
create or replace view vwBookCount
as
select book_genre, count(book_genre) as book_count from tblBook group by book_genre order by book_genre;




--어린이자료실 이용시간
create or replace view vwInFacilChildrenTime
as
select 
    ift.faciltime_seq,
    if.facil_position,
    ift.faciltime_day,
    ift.faciltime_time
from tblInFacil if
inner join tblInFacilTime ift
    on if.facil_seq = ift.facil_seq
where if.facil_position = '어린이자료실';


--디지털자료실 이용시간
create or replace view vwInFacilDigitalTime
as
select 
    ift.faciltime_seq,
    if.facil_position,
    ift.faciltime_day,
    ift.faciltime_time
from tblInFacil if
inner join tblInFacilTime ift
    on if.facil_seq = ift.facil_seq
where if.facil_position = '디지털자료실';


--종합자료실 이용시간
create or replace view vwInFacilTotalTime
as
select 
    ift.faciltime_seq,
    if.facil_position,
    ift.faciltime_day,
    ift.faciltime_time
from tblInFacil if
inner join tblInFacilTime ift
    on if.facil_seq = ift.facil_seq
where if.facil_position = '종합자료실';



--월별 장서 증가 추이
create or replace view vwInDataGraph
as
select book_regdate, count(book_regdate) as book_count from tblBook group by book_regdate order by book_regdate;


--알림마당 - 공지사항목록
create or replace view vwNoticeList
as
select n.*, rownum as rnum from
(select
   list_seq, list_subject, list_date, list_readcount,
   (sysdate - list_date) as list_isnew, list_content
from tblnoticelist order by list_seq desc) n;

select * from vwNoticeList;
select * from vwNoticeList where rnum between 1 and 10 and list_subject like '%쌍용%';
select * from vwNoticeList where rnum between 1 and 10 and (list_subject like '%쌍용%' or list_content like '%쌍용%');



--FAQ목록
create or replace view vwNoticeFAQ
as
select n.*, rownum as rnum from
(select * from tblnoticeFAQ order by faq_seq asc) n;

select * from vwNoticeFAQ;



select c.*, (select member_name from tblmember where member_seq = c.member_seq) as admin_name from tblnoticecomment c where comment_pseq = 358;
			
select * from tblnoticeqna where qna_seq=360;
select * from tblnoticecomment order by comment_pseq desc;


--QnA 게시판목록(뒷번호부터 유효)
--답글(여러개도 있음)의 유무 -> 답글있으면 'y'
select q.*, (select member_name from tblmember where member_seq = q.member_seq) as qna_name,
    CASE
        when EXISTS (select comment_seq from tblnoticecomment where comment_pseq = q.qna_seq) then 'y'
        else null
    END as state
from tblnoticeqna q order by qna_seq desc;


--QnA 목록보기 VIEW
create or replace view vwNoticeqna
as
select n.*, rownum as rnum from
(select q.*, 
    (select member_id from tblmember where member_seq = q.member_seq) as qna_id,
    (select member_name from tblmember where member_seq = q.member_seq) as qna_name,
    CASE
        when EXISTS (select comment_seq from tblnoticecomment where comment_pseq = q.qna_seq) then 'y'
        else null
    END as qna_state
from tblnoticeqna q order by qna_seq desc) n;


select * from vwNoticeqna;


--QnA 상세보기페이지 : 회원글
select q.*, (select member_name from tblmember where member_seq = q.member_seq) as qna_name
from tblnoticeqna q where qna_seq = 1;

--QnA 상세보기페이지 : 관리자답글
select c.*, (select member_name from tblmember where member_seq = c.member_seq) as admin_name from tblnoticecomment c where comment_pseq = 301;
			

--검색시 목록
--select v.*, rownum from vwNoticeqna v where %s and rownum between %s and %s
select q.* from (select n.*, rownum as rnum2 from (select v.* from vwNoticeqna v where qna_subject like '%도서%') n) q where rnum2 between 11 and 20;


--신착도서
--1년이내의 신착도서만
select * from tblbook where book_regdate between sysdate-365 and sysdate order by book_regdate desc;
select book_regdate, count(*) as cnt from tblbook group by book_regdate; 

--조건탭 후 신착도서 목록
select * from tblbook where book_regdate between sysdate-63 and sysdate and book_genre like '총류' order by book_regdate desc;
--조건탭 후 신착도서 목록갯수
select count(*) as cnt from tblbook;
select count(*) as cnt from tblbook where book_regdate between sysdate-63 and sysdate and book_genre like '총류' order by book_regdate desc;

--신착도서목록(1년이내)
create or replace view vwSearchNewbook
as
select b.*, rownum as rnum 
from (select * from tblbook where book_regdate between sysdate-365 and sysdate order by book_regdate desc) b;

select * from vwSearchNewbook;
select count(*) from vwSearchNewbook; --323(8/3)

--신착도서목록(비검색시)
select * from vwSearchNewbook where rnum between 1 and 10;

--신착도서목록(검색시)
--총페이지수
select count(*) as cnt from vwSearchNewbook
where book_regdate between sysdate-365 and sysdate

select count(*) as cnt from vwSearchNewbook
where book_genre like '%예술%';

select count(*) as cnt from vwSearchNewbook
where book_regdate between sysdate-365 and sysdate and book_genre like '예술' 

--목록
select * from (select n.*, rownum as rnum2 from (select * from vwSearchNewbook where book_regdate between sysdate-365 and sysdate and book_genre like '예술') n) where rnum2 between 1 and 10;



--대출베스트
--대출베스트 목록(+연령대, 성인(1960~2002), 청소년(03~08), 어린이(09~현재)): vwbestlistage (930개)
create or replace view vwbestlistage
as
select b.book_seq, b.book_image, b.book_subject, b.book_author, b.book_genre, b.book_status, p.lending_date, p.member_seq, 
    to_char(m.member_birth, 'yyyy') as member_year,
    case
        when to_char(m.member_birth, 'yyyy') between 1960 and to_char(sysdate, 'yyyy')-19 then '성인'
        when to_char(m.member_birth, 'yyyy') between to_char(sysdate, 'yyyy')-18 and to_char(sysdate, 'yyyy')-13 then '청소년' --2003~2008(중,고등학교)
        when to_char(m.member_birth, 'yyyy') between to_char(sysdate, 'yyyy')-12 and to_char(sysdate, 'yyyy') then '어린이'
    end as member_agename
from tblbook b
inner join tblpresent p
 on b.book_seq = p.book_seq
 inner join tblmember m
 on m.member_seq = p.member_seq;

select * from vwbestlistage; --대출기간, 종류, 연령대


--대출된 도서목록: vwbestseller (930개)
create or replace view vwbestseller
as
select b.*, p.lending_date, p.return_date, p.book_seq as rent_booknum, p.member_seq 
from tblbook b
    inner join tblpresent p
    on b.book_seq = p.book_seq
        where p.lending_date between sysdate - 365 and sysdate;

--1년동안 대출된 도서목록(+대출횟수순)
select book_seq, book_image, book_subject, book_author, book_status, book_regdate, count(*) as rent_total from vwbestseller group by book_seq, book_image, book_subject, book_author, book_status, book_regdate order by rent_total desc;


--소장자료 검색
--주제별 도서목록
select * from (select b.*, rownum as rnum from (select * from tblbook where book_genre = '문학' order by book_seq asc) b) where rnum between 1 and 10;


--도서목록테이블
--도서상세페이지용 뷰
create or replace view vwsearchdetail
as 
select b.book_seq, b.book_subject, b.book_callnumber, b.book_status, b.book_position, 
p.lending_seq, p.lending_date, 
(p.lending_date + 7) as return_expect,
p.return_date, p.lending_status, p.member_seq,
m.member_name, m.member_birth, r.review_seq, r.review_star_rating, r.review_percent
from tblbook b
inner join tblpresent p
on b.book_seq = p.book_seq
left outer join tblReview r
on r.lending_seq = p.lending_seq
inner join tblmember m
on p.member_seq = m.member_seq


--후기테이블
select * from vwsearchdetail where book_seq= 6 and review_content is not null

--도서소장정보테이블 뷰 (반납예정일(추가): 현재기준으로 연장 -> 14일추가, 연장없으면 +7)
create or replace view vwbookpresent
as 
select book_seq, book_callnumber, book_status,
case
        when  LENDING_STATUS = '연장'  then lending_date + 14
        when  LENDING_STATUS is null  then lending_date + 7
end as expect_date, book_position
from vwsearchdetail where return_date is null;


--도서 상세검색
--조건모두 not을 사용했을때(3개)
select * from (select n.*, rownum as rnum from (select * from tblbook where not(book_subject like '%강남%' ) and not (book_author like '%성욱%') and (book_publisher like '%김%')) n) where rnum between 1 and 10;
--날짜까지 모두 사용했을때
select * from (select n.*, rownum as rnum from (select * from tblbook where book_subject like '%강남%' and book_date between 2019 and 2021) n) where rnum between 1 and 10;
select * from (select n.*, rownum as rnum from (select * from tblbook where not(book_subject like '%강남%' ) and not (book_author like '%성욱%') or (book_publisher like '%김%') and book_date between 2019 and 2021) n) where rnum between 1 and 10;
select * from (select n.*, rownum as rnum from (select * from tblbook where book_date between 2019 and 2021) n) where rnum between 1 and 10;


-- 대출현황
create or replace view vwPresent
as
select vp.*, rownum as rnum from
    (select b.book_subject,
    p.lending_seq,
    b.book_seq,
    b.book_author,
    b.book_publisher,
    b.book_genre,
    p.lending_date,
    p.return_date,
    p.lending_status,
    p.member_seq,
    nb.nbook_subject, nb.nbook_author, nb.nbook_publisher
from tblPresent p left outer join tblBook b on b.book_seq = p.book_seq
   left outer join tblNonBook nb on p.nbook_seq = nb.nbook_seq
order by p.lending_seq desc) vp;

--후기현황
create or replace view vwReview
as
select vr.*, rownum as rnum from
(select b.book_seq,b.book_subject, b.book_author, b.book_publisher,
    p.lending_date,p.member_seq,
    r.review_seq,r.review_star_rating,r.review_percent,r.review_content,nb.nbook_subject,r.lending_seq as rlending_seq,
    nb.nbook_author, nb.nbook_publisher,p.lending_seq
from tblPresent p left outer join tblBook b on b.book_seq = p.book_seq
    left outer join tblReview r on p.lending_seq = r.lending_seq
    left outer join tblNonBook nb on p.nbook_seq = nb.nbook_seq
order by p.lending_seq desc)  vr;

--예약 현황
create or replace view vwReservation
as
select bs.booking_seq, b.book_subject, b.book_author, b.book_publisher, bs.booking_date, bs.booking_visitdate, m.member_seq
from tblBookingStatus bs inner join tblBook b on bs.book_seq = b.book_seq
inner join tblMember m on bs.member_seq = m.member_seq
order by booking_seq desc;
select * from vwReservation

--희망도서신청현황
create or replace view vwWishBookDoc
as
select *
from tblWishBookDoc
order by wishbook_seq desc;

--문의내역 조회
create or replace view vwMybookNoticeQnA
as
select nq.qna_seq, nq.qna_subject,nq.qna_content, nq.qna_kind,nq.qna_date,nq.qna_readcount,nq.qna_pw,nq.member_seq,
    nc.comment_seq
from tblNoticeQnA nq left outer join tblNoticeComment nc
on nq.qna_seq = nc.comment_pseq
order by qna_seq desc;

--도서기증
create or replace view vwDonation
as
select bd.dona_seq, bd.dona_subject , bd.dona_author, bd.dona_publisher, bd.dona_applydate, bd.dona_finishdate , bd.dona_status, bd.member_seq,
    p.parcel_seq, p.parcel_size, p.parcel_pay,p.parcel_visitdate,p.parcel_etc,
    m.member_name, m.member_tel, m.member_address
from tblBookdona bd left outer join tblParcel p 
    on bd.dona_seq = p.dona_seq 
    left outer join tblMember m on p.member_seq = m.member_seq
order by bd.dona_seq desc;

--관심도서목록
create or replace view vwWishBook
as
select wb.wish_seq,  wb.member_seq,
    b.book_callnumber, b.book_seq,b.book_subject, b.book_author, b.book_publisher, b.book_position, b.book_status,
    nb.nbook_callnumber, nb.nbook_seq, nb.nbook_subject, nb.nbook_author, nb.nbook_publisher, nb.nbook_position, nb.nbook_status
from tblWishBook wb left outer join tblBook b on wb.book_seq = b.book_seq
left outer join tblNonBook nb on wb.nbook_seq = nb.nbook_seq;


--독서건강분석
--이용자 연령대의 월별 평균 대출 수 
select  TO_CHAR(lending_date,'yyyy-mm') as month, 
    round((count(*) / (select count(*) as birthCount from tblMember where substr(member_birth,1,1) = (select substr(member_birth,1,1) from tblMember where member_seq = 108))),2) as readCountAvg
from(select lending_date
from tblPresent p left outer join tblMember m on p.member_seq = m.member_seq
where substr(m.member_birth,1,1) = (select substr(member_birth,1,1) from tblMember where member_seq = 108)) group by TO_CHAR(lending_date,'yyyy-mm');

-- 이용자 나이, 대출 월, 월별 대출 수
SELECT
         (
                SELECT Floor(Months_between(sysdate,member_birth)/12) AS age
                FROM   tblmember
                WHERE  member_seq = 108) AS age,
         total.*,
         Count(*) AS readcount
FROM     (
                  SELECT   To_char(lending_date,'yyyy-mm') AS lending_date
                  FROM     tblpresent
                  WHERE    member_seq = 108
                  GROUP BY(lending_date, 'yyyy-mm')) total
GROUP BY lending_date
ORDER BY lending_date DESC

--도서관 내 대여수가 제일 많은 top100 뷰
create or replace view vwRanking
as
select book_seq, count(*) as presentCount from vwPresent group by book_seq order by presentCount desc

--이용자들 중 대출수가 제일 많은 top100
select tbr100.*
from (select tbr.*, rownum as rnum
from(select *
from (vwRanking vwr inner join tblBook tb on vwr.book_seq = tb.book_seq) 
where book_genre = (select book_genre
from
(select rank.*, rownum as rnum
from(SELECT book_genre,count(*) as cnt
FROM   vwpresent
WHERE  member_seq = 129 AND book_genre IS NOT NULL
GROUP  BY book_genre
order by cnt desc) rank) bg
where rnum = 1)
order by presentcount desc) tbr) tbr100
where rnum = 1 or rnum = 10 or rnum = 55

--장르별 이용자 독서 대출, 이용자 연령대 평균 대출
SELECT
    master.book_genre,
    master.genreCount,
    case
        when sub.genreCount  is null then 0
        when sub.genreCount is not null then sub.genreCount
    end AS memGenreCount
FROM (
    SELECT book_genre,
           Round(Count(*) / (SELECT Count(*) AS birthCount
                             FROM   tblmember
                             WHERE  Substr(member_birth, 1, 1) = (SELECT Substr(member_birth, 1, 1)
                                                                  FROM   tblmember
                                                                  WHERE member_seq = 108)), 2) AS genreCount
    FROM   tblpresent tp
           INNER JOIN tblmember tm
                   ON tp.member_seq = tm.member_seq
           INNER JOIN tblbook tb
                   ON tb.book_seq = tp.member_seq
    WHERE  Substr(member_birth, 1, 1) = (SELECT Substr(member_birth, 1, 1)
                                         FROM   tblmember
                                         WHERE  member_seq = 108)
    GROUP  BY book_genre
) master
LEFT JOIN (
    SELECT book_genre,
            Count(*) AS genreCount
    FROM   vwpresent
    WHERE  member_seq = 108
           AND book_genre IS NOT NULL
    GROUP  BY book_genre 
) sub ON master.book_genre = sub.book_genre
ORDER BY master.book_genre

--이용자 연령대 월별 평균 독서 대출
SELECT To_char(lending_date, 'yyyy-mm') AS month,
       Round(( Count(*) / (SELECT Count(*) AS birthCount
                           FROM   tblmember
                           WHERE  Substr(member_birth, 1, 1) =
                                  (SELECT
                                  Substr(member_birth, 1, 1)
                                                                FROM   tblmember
                                                                WHERE
                                  member_seq = 540
                                  )
                          ) ), 2)       AS readCountAvg
FROM  (SELECT lending_date
       FROM   tblpresent p
              LEFT OUTER JOIN tblmember m
                           ON p.member_seq = m.member_seq
       WHERE  Substr(m.member_birth, 1, 1) = (SELECT Substr(member_birth, 1, 1)
                                              FROM   tblmember
                                              WHERE  member_seq = 740))
GROUP  BY To_char(lending_date, 'yyyy-mm')
ORDER BY month DESC

-- 관리자 전체회원조회 쿼리
select  m.member_seq ,m.member_name, count(lending_date) as lendingcnt,count(return_date) as returncnt, count(qna_content) as qnacnt,count(dona_seq) as donacnt,count(wishbook_seq) as wishcnt from tblPresent p full outer join tblmember m on p.member_seq = m.member_seq full outer join tblNoticeQnA n on n.member_seq = m.member_seq full outer join tblbookdona b on b.member_seq = m.member_seq full outer join tblwishbookdoc d on d.member_seq = m.member_seq group by m.member_seq,m.member_name order by m.member_seq asc ;

-- 관리자 전체회원 조회 목록쿼리
select  * 
from tblPresent p 
full outer join tblmember m 
on p.member_seq = m.member_seq 
full outer join tblNoticeQnA n 
on n.member_seq = m.member_seq 
full outer join tblbookdona b 
on b.member_seq = m.member_seq 
full outer join tblwishbookdoc d 
on d.member_seq = m.member_seq 
group by m.member_seq
order by m.member_seq asc ;

--대출현황
create or replace view vwlendginnow
as
select m.member_seq,m.member_Id, m.member_name,b.book_subject,n.nbook_subject,TO_CHAR(p.lending_date,'yyyy-mm-dd') as lending_date,TO_CHAR(p.lending_date+7,'yyyy-mm-dd') as return_date,TO_CHAR(p.lending_date+14,'yyyy-mm-dd') as return_dateplus,p.lending_status from tblpresent p full outer join tblbook b on p.book_seq = b.book_seq full outer join tblmember m on p.member_seq = m.member_seq full outer join tblnonbook n on n.nbook_seq = p.nbook_seq where p.return_date is null;
select * from vwlendginnow;


-- 관리자 회원조회
create or replace view vwAdminMember
as
select a.*,rownum as rnum from(select m.member_seq ,m.member_name, count(lending_date) as lendingcnt,count(return_date) as returncnt, count(qna_content) as qnacnt,count(dona_seq) as donacnt,count(wishbook_seq) as wishcnt from tblPresent p full outer join tblmember m on p.member_seq = m.member_seq full outer join tblNoticeQnA n on n.member_seq = m.member_seq full outer join tblbookdona b on b.member_seq = m.member_seq full outer join tblwishbookdoc d on d.member_seq = m.member_seq where m.member_lv = 1 group by m.member_seq,m.member_name order by m.member_seq asc)a where m.member_seq = 100;


--관리자 예약현황
create or replace view vwAdminreserve
as 
select s.member_seq,b.book_subject,TO_CHAR(s.booking_visitdate,'yyyy-mm-dd') as booking_visitdate from tblbookingStatus s inner join tblbook b on s.book_seq = b.book_seq; 



-- 관리자 대출이력
create or replace view vwAdhistory
as
select m.member_seq,b.book_subject,n.nbook_subject,TO_CHAR(p.lending_date,'yyyy-mm-dd') as lending_date,TO_CHAR(p.return_date,'yyyy-mm-dd') as return_date,p.lending_status from tblpresent p full outer join tblmember m on p.member_seq = m.member_seq full outer join tblbook b on b.book_seq = p.book_seq full outer join tblnonbook n on n.nbook_seq = p.nbook_seq;
select * from vwAdhistory where member_seq =100 order by return_date desc;

create or replace view vwAdallhistory
as
select m.member_seq,b.book_subject,n.nbook_subject,TO_CHAR(p.lending_date,'yyyy-mm-dd') as lending_date,TO_CHAR(p.return_date,'yyyy-mm-dd') as return_date,p.lending_status from tblpresent p full outer join tblmember m on p.member_seq = m.member_seq full outer join tblbook b on b.book_seq = p.book_seq full outer join tblnonbook n on n.nbook_seq = p.nbook_seq;

--관리자 반납현황
select * from vwlendginnow;
select sysdate,book_subject,nbook_subject,member_seq,lending_date,return_date,return_dateplus,lending_status from vwlendginnow where member_seq =?;

--관리자 문의내역
select * from tblnoticeqna where member_seq =?;


--관리자 회원기증내역
select dona_subject,TO_CHAR(dona_applydate,'yyyy-mm-dd') as dona_applydate,TO_CHAR(dona_finishdate,'yyyy-mm-dd')as dona_finishdate,dona_status from tblBookdona where member_seq =100;

-- 관리자 희망도서신청
select wishbook_subject,TO_CHAR(wishbook_date,'yyyy-mm-dd') as wishbook_date,wishbook_status,wishbook_reason from tblWishBookDoc;
select * from tblWishBookDoc;
select * from tblNoticeQnA n full outer join tblNoticeComment c on n.qna_seq = c.comment_seq;


-- 관리자 전체 반납현황
select * from (select sysdate,book_subject,nbook_subject,member_seq,lending_date,return_date,return_dateplus,lending_status,member_name,rownum as rnum from vwlendginnow where lending_date is not null);

--관리자 전체 반납 카운팅
select count(*) as cnt from vwlendginnow where lending_date is not null;

-- 관리자 전체 기증내역
create or replace view adalldona
as
select m.member_seq, m.member_name,dona_subject,TO_CHAR(dona_applydate,'yyyy-mm-dd') as dona_applydate,TO_CHAR(dona_finishdate,'yyyy-mm-dd')as dona_finishdate,dona_status from tblBookdona b inner join tblmember m on b.member_seq = m.member_seq;

--관리자 전체 기증내역 카운팅
select count(*) as cnt from adalldona order by dona_finishdate desc;

--관리자 전체 희망도서내역
select wishbook_subject,TO_CHAR(wishbook_date,'yyyy-mm-dd') as wishbook_date,wishbook_status,wishbook_reason from tblWishBookDoc;

--관리자 전체 희망도서내역 view
create or replace view adallwish
as
select m.member_seq,m.member_name,wishbook_subject,TO_CHAR(wishbook_date,'yyyy-mm-dd') as wishbook_date,wishbook_status,wishbook_reason from tblWishBookDoc w inner join tblmember m on w.member_seq=m.member_seq;


--관리자 회원조회
create or replace view vwadmember
as
select a.*,rownum as rnum from tblmember a where a.member_seq  >= 100;

create or replace view vwadmember
as
select a.member_seq,a.member_id,a.member_name,a.member_tel,TO_CHAR(a.member_birth,'yyyy-mm-dd') as member_birth,a.member_email,a.member_address,rownum as rnum from tblmember a where a.member_seq  >= 100;

select * from vwadmember where member_seq =100;


--관리자 회원수정
update tblmember set member_name = ?, member_tel = ?, member_birth = ?,member_email = ?,member_address = ? where member_seq = ?;

--관리자 회원수정 조회 뷰
create or replace view vwadmemberedit
as
select member_seq,member_id,member_pw,member_name,member_tel,TO_CHAR(member_birth,'yyyy-mm-dd') as member_birth,member_email,member_address from tblmember;
