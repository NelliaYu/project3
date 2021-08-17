# Servlet과 JSP를 활용한 웹 프로젝트
## 공공도서관 운영시스템 (Public Library Management System)

**요약 |**
이용자들에게 '최적화' & 관리자에게 '편리함'을 제공하는 도서관시스템
<br><br>
**기간 |**
2021. 07. 13 ~ 2021. 08. 05 (약 3주)
<br><br>
**기획배경 |**
- '책'이라는 컨텐츠를 통해 취향을 알고 싶고, 드러내고 싶어하는 이용자들의 니즈 증가
- 사용자 친화적인 도서관 사이트에 대한 니즈
<br><br>


**세부 기능 사항 |**
#### 1) 이용자
도서 검색 서비스
- 상세검색, 주제별 검색서비스 제공

도서관 위치 서비스
- 카카오 맵 API을 통한 이동경로 안내

독서 건강 분석 서비스
- 차트, 이미지를 통한 시각적 지표

도서에 대한 정성적, 정량적 지표
- 이용자들의 능동적 참여가능 - 후기작성서비스, 도서 대출 권수 차트 제공

#### 2) 관리자
회원관리 메일시스템
- 연체이용자에 대한 메일 송신 시스템

회원 별 상세 관리시스템
- 회원 별 상세정보 열람기능

홈페이지 기능 자동화구현
- 도서관 소장자료 현황 장서 수 및 차트 자동화 기능
<br><br>                  
                                       
**개발환경 |**        
플랫폼 -	Windows 10         
언어 - Java, HTML, CSS, JavaScript         
도구 - Eclipse, SQL Developer, Visual Studio Code, eXERD, Kakao oven          
DB	- Oracle           
WAS	- Apache Tomcat 8.5        

<br><br><br> 
**구현화면(순서도 & ERD) |**
### [순서도]
![level](https://user-images.githubusercontent.com/76515187/129681279-dce9d098-2ab7-4400-898d-108b22b967f5.png)
### [ERD]
![ERD](https://user-images.githubusercontent.com/76515187/129681270-e686c163-ad4d-4d94-8afe-22741a2dc46e.png)
                       
<br><br>                           
**담당업무 |**
#### 도서검색
-상세검색, 주제별검색, 신착도서별검색, 대출베스트검색, 검색결과목록, 도서상세페이지, 희망도서 신청


#### 알림마당
- 공지사항, 자주하는 질문(FAQ), 문의하기 조회, 문의하기 글쓰기(잠금기능), 게시물 수정, 게시물 삭제
                       
<br><br>                            
**구현화면(WEB) |**   
### [도서검색]   
![1-1](https://user-images.githubusercontent.com/76515187/129681682-ce4dc866-3faf-4523-bd09-03e2f57a36fd.png)
![1-1-1](https://user-images.githubusercontent.com/76515187/129681686-4823aecf-23b7-4db4-93d8-7e29e378e908.png)
![1-1-2-3(1)](https://user-images.githubusercontent.com/76515187/129681692-cbfed8bf-029f-4057-abc9-029a9b8ed9b9.png)
![1-1-2-3-1](https://user-images.githubusercontent.com/76515187/129681693-263f17a0-1ca9-448f-98d6-61869cb52e6d.png)
![1-1-2-3-2](https://user-images.githubusercontent.com/76515187/129681696-e6b0d534-dc71-4758-ba68-b0210a254757.png)
![1-3](https://user-images.githubusercontent.com/76515187/129681699-91379ddb-314b-4aad-8ed8-a34a0a788231.png)
![1-4-2](https://user-images.githubusercontent.com/76515187/129681703-2a8ff0bf-dba4-47a7-9b9b-fd7a383f060f.png)
![1-4-3](https://user-images.githubusercontent.com/76515187/129681709-99f05d1f-c811-4b69-9f44-6a12b35f6aa0.png)
<br><br>
### [알림마당]   
![2-1](https://user-images.githubusercontent.com/76515187/129681712-508321ab-4955-42a1-91f9-dc4af4687c3a.png)
![2-2](https://user-images.githubusercontent.com/76515187/129681714-46d5af69-bc19-49ed-a885-fb271117c73a.png)
![2-3(1)](https://user-images.githubusercontent.com/76515187/129681715-88e9feef-34e7-4af7-a5de-98b4488539fd.png)
![2-3-2](https://user-images.githubusercontent.com/76515187/129681718-081091bd-f82b-4241-96e8-073cfa9caa3e.png)
![2-3-2-1](https://user-images.githubusercontent.com/76515187/129681723-c0c305a8-b0c2-4237-b734-8a6715fa50ee.png)
![2-3-4](https://user-images.githubusercontent.com/76515187/129681726-111b7c41-404c-43bf-ab8f-d24aa73e9c12.png)

<br><br>
**프로젝트 스토리 |**   

앞서 익혀둔 Java, Oracle(DB)을 바탕으로 Servlet & JSP기술을 활용하여 '웹 프로젝트'가 진행되었습니다.<br>
이전 프로젝트와 비교했을때, 훨씬 프로젝트의 규모도 커지고 사용하는 언어의 종류도 다양해지다보니 막연함에서 오는 두려움이 있었습니다.
그러나, 팀원들과 함께 기획서부터 요구분석서, UI화면설계서 등 구현이전의 약 5~6가지의 서류를 작성하다보니 추상적으로만 그려졌던 프로젝트가 머리속에서 구체화되었습니다. ERD를 함께 그리며 개체간의 구조를 파악했고, 이를 토대로 DDL & DML를 작성하는 과정을 통해 프로젝트의 전반적인 흐름을 익혔습니다. 이러한 과정들을 통해, 제가 맡은 부분의 기능이 어떤 데이터를 활용하여 구현되면될지 파악할 수 있었습니다. 매번 서류의 중요성을 느끼지만, 프로젝트의 규모가 커질수록 그 중요성은 더 강조되는 것 같습니다.
<br><br>
특히 이번 프로젝트는 일상생활에서 쉽게 접할 수 있는 웹 페이지에서의 기능들을 직접 구현해보며, 이전 프로젝트들(Java, Oracle)에 비해 성취감이 가장 높았습니다. 프로젝트에 알맞는 컨셉의 로고와 이미지를 만들어 직접 웹디자인에 적용하였고, 헤더와 푸터, 네비게이션 부분엔 어떤 요소들이 들어갈지 팀원들과 상의하며 템플릿을 만들었습니다. 그 과정들을 통해 프론트앤드 개발의 재미를 느낄 수 있었습니다. 또한, 사용자의 입력한 값을 서버에서 응답하여 처리하고, 다시 응답해주는 과정을 통해 백앤드의 재미와 매력을 제대로 느낄 수 있었습니다. 특히, 수업시간에는 잘 알 수 없었던 hidden태그의 중요성과 Bootstrap, JSTL의 편리함을 절실히 느낄 수 있었습니다.
또한, 데이터를 가공하여 시각적으로 처리하는 차트(HighChart 사용)구현과 오픈 API를 직접 사용해보며 웹페이지의 완성도와 활용도를 높여나가는 재미를 느낄 수 있었습니다. 모든 기능들이 구현된 후, 팀원들과 함께 모여 각 페이지에 구현된 기능들이 서로 연동성을 가지며 완성된 모습을 보았을 때 팀원들에게 감사함을 느꼈습니다. 맡은 부분을 성실히 구현해준 팀원들이 있었기에 프로젝트의 완성도가 높아질 수 있었고, 그만큼 성취감은 배가 되었던 것 같습니다.
