############################################################################
# > #은 mysql에서 주석 입니다.
############################################################################
### mysql에 root 로 접속
# 0. mysql 폴더의 startup.bat 실행.
# 1. CMD 실행
# 2. mysql 폴더로 이동
#		cd C:\eGovFrame-4.0.0\bin\mysql-5.7.32\bin
# 3. root 로 접속 
#	mysql -u root -p
# 4. 패스워드 입력, 그냥 엔터


############################################################################
### mysql root 로 접속한 상태에서 진행

show databases;

CREATE DATABASE flounder default CHARACTER SET UTF8; 
SHOW DATABASES; 

#내부ip(localhost) 접속 가능 계정
#CREATE USER '계정아이디'@'localhost' IDENTIFIED BY '비밀번호';
create user 'flounder'@'localhost' identified by 'flounder';

show databases;

#특정 DB에 모든 권한 부여
#GRANT ALL PRIVILEGES ON 데이터베이스명.* TO '계정아이디'@'호스트';
grant all privileges on flounder.* to 'flounder'@'localhost';

#########################################################################
### 이클립스에서 Data Source Explorer - Database Connections 에서 DB 연결 진행. 

-- Table Create SQL
-- 테이블 생성 SQL - 

#########################################################################
#권민팀
#- mysql: 8.0.26
#url서버주소  : project-db-stu.smhrd.com
#port number : 3307
#user :  cgi_3_230524_3
#password : smhrd3
#db : cgi_3_230524_3

#########################################################################
# 문제 : 이클립스에서 원격 DB 접속할때 에러 발생
#       에러떴을 때 Detail 선택해서 보이는 메시지로 구글링
#       이클립스에서 mysql 8.0 지원하지 않음.
#
# 아래는 DB 멘토님이 알려준 현재 상황.
#--alter user 'cgi_3_230524_3'@'project-db-stu.smhrd.com' identified with mysql_native_password BY 'smhrd3'; 
#---- 패스워드 암호화가 버전이 서로 달라 기능이 다름 . mysql_native_password 를 이용해서 암호화된 패스워드 재 입력 필요
#---- 하지만 CREATE USER 권한이 없어 실행이 되지 않는 상황
#########################################################################
# 해결 방법
# 1. MySQL Workbench 에서 원격 접속 가능.
#   - 원격 DB 접속 및 DB 생성 등의 작업은 MySQL Workbench 를 사용.
# 2. 이클립스의 DB 접속 설정은 로컬과 같이 히카리에서 그대로 적용.
#   - 히카리 설정을 이용한 서버 접속은 현재 가능, 소스상에서 작성한 내용 동작확인.
#   - 어제 멘토님이 여러 설정을 확인 했는데 그것이 때문인지 확실하지 않음.
#   - 다른 팀에서는 따로 확인 필요함.   
#########################################################################
#  /src/main/webapp/WEB-INF/spring/root-context.xml
#  위 파일에서 아래와 같이 설정했을 때 팀 서버에 접속 성공.
#
#	<bean id="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
#		<property name="driverClassName" value="com.mysql.jdbc.Driver"/>
#		<property name="jdbcUrl" value="jdbc:mysql://project-db-stu.smhrd.com:3307/cgi_3_230524_3"/>
#		<property name="username" value="cgi_3_230524_3"/>
#		<property name="password" value="smhrd3"/>
#	</bean>
#########################################################################

DROP TABLE conn_dt_code;
DROP TABLE sym_code;
DROP TABLE detect_dis;
DROP TABLE reply;
DROP TABLE community;
DROP TABLE dis_search;
DROP TABLE member;

commit;


CREATE TABLE member (
	m_email	    VARCHAR(300)	NOT NULL PRIMARY KEY,
	m_pw	    VARCHAR(100)	NOT NULL,
	m_name	    VARCHAR(50)	    NOT NULL
);


CREATE TABLE dis_search (
	ds_id	    INT	            NOT NULL AUTO_INCREMENT,
	ds_name	    VARCHAR(100)	NOT NULL,
	ds_simple   VARCHAR(500)	NOT NULL,
	ds_url	    VARCHAR(500)	NOT NULL,
    ds_cause    VARCHAR(100)    DEFAULT NULL
	
    , PRIMARY KEY (ds_id)
);

CREATE TABLE community (
	c_id	    INT	            NOT NULL AUTO_INCREMENT,
	w_email	    VARCHAR(300)	NOT NULL,
	c_date	    DATETIME	    DEFAULT now(),
	title	    VARCHAR(100)	NOT NULL,
	c_text	    VARCHAR(2000)	NOT NULL,
	img_path    VARCHAR(500)	NULL
	
    , PRIMARY KEY (c_id)
    , FOREIGN KEY (w_email) references member(m_email)
	
);

CREATE TABLE reply (
	r_id	 INT	        NOT NULL  AUTO_INCREMENT,
	c_id	 INT	        NOT NULL,
	r_email	 VARCHAR(300)	NOT NULL,
	r_date	 DATETIME	    DEFAULT now(),
	reply	 VARCHAR(500)	NOT NULL
	
    , PRIMARY KEY (r_id)
    , FOREIGN KEY (c_id)    references community(c_id)
    , FOREIGN KEY (r_email) references member(m_email)
);

CREATE TABLE detect_dis (
	dd_id	    INT	            NOT NULL AUTO_INCREMENT,
	org_img     VARCHAR(500)	NULL,
	dt_img      VARCHAR(500)	NULL,
	dd_email	VARCHAR(300)	NOT NULL,
	dd_date	    DATETIME	    DEFAULT now(),
	dd_comment  VARCHAR(2000)	NULL
	
    , PRIMARY KEY (dd_id)
    , FOREIGN KEY (dd_email) references member(m_email)
);

CREATE TABLE sym_code (
	sym_code	    VARCHAR(50)	    NOT NULL PRIMARY KEY,
	dis_name	    VARCHAR(200)	NOT NULL,
	sym_parts	    VARCHAR(200)	NULL,
	symptom	        VARCHAR(200)	NULL,
	ds_id	        INT	            NULL
    , FOREIGN KEY (ds_id)    references dis_search(ds_id)
);

CREATE TABLE conn_dt_code (
	cdc_id	    INT	        NOT NULL AUTO_INCREMENT,
	dd_id	    INT,
	sym_code	VARCHAR(50)
	
    , PRIMARY KEY (cdc_id)
    , FOREIGN KEY (dd_id)   	references detect_dis(dd_id)
    , FOREIGN KEY (sym_code) 	references sym_code(sym_code)
);

commit;

show tables;

insert into member values ('aaa@aaa.aaa' , 'aaa', '관리자');
insert into member values ('mks@kvgs.com', 'aaa', '문경수');
insert into member values ('kkm@kvgs.com', 'aaa', '김권민');
insert into member values ('amy@kvgs.com', 'aaa', '안미연');
insert into member values ('shs@kvgs.com', 'aaa', '심형선');
insert into member values ('cjy@kvgs.com', 'aaa', '조준용');

commit;

select * from member;


insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10001, 'aaa@aaa.aaa' , '2023/03/29 12:45:00', '/DATA/PostImage/img001.jpg',   '남천동 벚꽃 라이딩',                    '?오늘 야간 근무라 벚꽃 다 떨어지기 전 남천동 삼익비치쪽 라이딩 하고 왔슴다 ㅎ<br> <br> 지금 절정이니 함 다녀오세유 ㅎ??');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10002, 'mks@kvgs.com', '2023/03/24 21:54:00', '/DATA/PostImage/img002.jpg',   '첨으로 평일 나들이~',                   '날씨가 너무 좋네요<br>빕숏에 반팔.바막  입고왔는데 넘 좋아요~ <br> 벗꽃들도 넘 이뿌고@@ <br> 5달만에 탓더니 30k왔는데도 손.발 다떨립니다완전 초기화?어요ㅠ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10003, 'kkm@kvgs.com', '2023/03/29 15:10:00', '/DATA/PostImage/img003.jpg',   '친구 자전거와 찍은사진',                 '학교운동장에서 밤에 글러브와 자전거를 한번에 찍었어요 ㅋㅋ <br><br>좋아하는것들이 같이 있으니 멋지네요!' );
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10004, 'amy@kvgs.com', '2023/03/27 08:12:00', '/DATA/PostImage/img004.jpg',   '자전거를 타게 되는 이유~~~~!!!',         ' 자전거를 타게 되는 이유~~~~~!!! <br><br>눈 호강하는 풍경이 기다린다는,,,,,,,,');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10005, 'shs@kvgs.com', '2023/03/11 23:52:00', '/DATA/PostImage/img005.jpg',   '동촌 해맞이다리 개나리',                 '오늘 퇴근길 한컷 <br><br>봄 봄 봄 봄 봄이왔어요^^' );
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10006, 'cjy@kvgs.com', '2023/03/14 18:40:00', '/DATA/PostImage/img006.jpg',   '아라 부부라이딩 날씨 죽이네요',            '?신차구매후 참으로 오랜만에 라이딩 나왔더니<br>날씨 끝내주네요~ <br>청라에서 계양까지 달리고 왔네요~ <br>정서진에서 햄버거 하나 먹고, 아미노바이탈로 에너지 충전하니 좋네요 ㅎ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10007, 'aaa@aaa.aaa' , '2023/03/04 14:56:00', '/DATA/PostImage/img007.jpg',   '[제주] 봄햇살 라이딩',                  '낙타등 구간을 지나 유수암 마을에 도착합니다 나이 많은 보호수가 운치있는 마을이에요 <br>날씨가 풀려서 시즌온 글들이 많이 올라오고 있네요  <br>도로에, 산길에 점점 라이더들이 많아지겠죠 <br>상대방을 배려하고 양보하면서 안전한 시즌온 라이딩이 하시길 바랍니다 ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10008, 'mks@kvgs.com', '2023/02/27 20:31:00', '/DATA/PostImage/img008.jpeg',  '석양이 저무는 곳',                     '동네 한바퀴 돌면서 <br>여느때와 다름없이 다니던 길목에 <br>멋진 기억이 머물고 있습니다');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10009, 'kkm@kvgs.com', '2023/02/21 16:41:00', '/DATA/PostImage/img009.jpg',   '오늘의 라이딩 사진',                   '부산라이딩에 와서 부산골목에서 본 냥이친구들과 <br>부산 골목골목 사진들을 한번 찍어보았습니다.');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10010, 'amy@kvgs.com', '2023/02/08 20:24:00', '/DATA/PostImage/img010.jpg',   '[제주] 강풍 라이딩',                   '바람 덕분에 공기는 깨끗했지만 쌀쌀하고 자전거가 휘청일 정도로 세게 불어댔습니다 <br>역풍을 뚫고 지나가는 자동차 속 사람들이 마냥 부럽게 느껴지기 시작했습니다 <br>멘탈을 부여잡고 속으로 화이팅! 외쳐봅니다 ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10011, 'shs@kvgs.com', '2023/02/20 20:33:00', '/DATA/PostImage/img011.jpeg',  '[4대강길]영산강 종주 후기(3/26~27)',     '작년 섬진강종주 이후 영산강종주를 하고 왔습니다! <br>섬진강은 홀로 다녀왔는데, <br>영산강은 저전거구매하고 4주만에 가는 와이프님과 함께 가서 느긋이 1박2일로 다녀왔어요. ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10012, 'cjy@kvgs.com', '2023/03/29 14:28:00', '/DATA/PostImage/img012.jpg',   '정서진 한강다녀왔어요.',                 '국토종주는 하고 싶으나 한번에 몰아서 할 여건은 안되고  <br>나눠서라도 해보자 결심하고 조금씩 실천중인 자린입니다. <br>큰 마음먹고 당일치기로 정서진부터 광나루인증센터까지 다녀왔습니다. ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10013, 'aaa@aaa.aaa' , '2023/03/25 23:34:00', '/DATA/PostImage/img013.jpg',   'Byplorer 여행기 68회',               '오늘은 대전브레베 200을 다녀왔습니다. <br>브레베때는 랜도너 많은 회원분들이 참가를 하는 축제이기도 합니다. <br>저같이 랜린이가 해야될것은 선배님들 얼굴도장 ㅋㅋ <br>그래서 오늘은 제야의 고수들과의 인증샷을 얻는것을 오늘 라이딩보다 더 행복함을 느낍니다.^^');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10014, 'mks@kvgs.com', '2023/03/01 23:19:00', '/DATA/PostImage/img014.jpg',   '규슈여행후기',                        '자전거로는 처음가보는 일본여행이였는데 <br>정말 괜찮았어서 다음엔 비행기에 실어서 가볼까 <br>계획중입니다');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10015, 'kkm@kvgs.com', '2023/03/29 13:45:00', '/DATA/PostImage/img015.jpeg',  '연휴 라이딩',                        '연휴라 일하는 차들도 없고 원래 차없는 곳이지만 <br>오늘은 더욱더 없어좋네요 <br>편도 10키로정도라 길도 깨끗하고 <br>멀리갈 시간 없을때는 대부분 여기로 옵니다 ㅎㅎ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10016, 'amy@kvgs.com', '2023/03/27 03:12:00', '/DATA/PostImage/img016.jpeg',  '유럽 자전거여행 ',                     '정상에 오르니 다른 풍경이 펼쳐진다. <br>빙하가 녹아 만들어진 호수들 틈으로 풍력발전기와 댐도 눈에 들어온다. <br>그리고 반대편 이태리쪽으론 왕좌의게임속 얼음장벽마냥 <br>웅장한 산맥이 우뚝 가로막고 있다.');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10017, 'shs@kvgs.com', '2023/03/24 23:54:00', '/DATA/PostImage/img017.jpg',   '브롬톤으로 영국시내한바퀴 하고 왔습니다!',    '영국의 자전거도로가 너무 잘되어있고 <br>신호도 따로있어서 안전하게 타고다닐 수 있었어요!');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10018, 'cjy@kvgs.com', '2023/03/29 13:10:00', '/DATA/PostImage/img018.jpg',   '유럽이 자전거 선진국이긴 선진국이네요. ',     '도로 가운데 자전거 도로가 있다는게 참 부럽습니다.');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10019, 'aaa@aaa.aaa' , '2023/03/11 23:52:00', '/DATA/PostImage/img019.png',   '태국 자덕들의 성지를 소개합니다 -트렉편-',    '이렇게 전자팔찌를 태킹 태킹해주면 마법의 문이 열리며...게이트를 지나.. <br>이렇게 만남의 다리(?)에서 집결하게 됩니다. ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10020, 'mks@kvgs.com', '2023/03/29 12:45:00', '/DATA/PostImage/img020.jpg',   '남천동 벚꽃 라이딩',                    '?오늘 야간 근무라 벚꽃 다 떨어지기 전 남천동 삼익비치쪽 라이딩 하고 왔슴다 ㅎ<br> <br> 지금 절정이니 함 다녀오세유 ㅎ??');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10021, 'kkm@kvgs.com', '2023/03/14 13:40:00', '/DATA/PostImage/img021.jpg',   '정읍 벚꽃라이딩',   					'올해 74세 되신 킹왕짱 체력의 소유자이신 아버지랑 복흥 갈재 올라가는 <br>길에 한컷 내장산 하산하는 길에 한컷 찍어봤습니다 모두 즐라하세요 ~');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10022, 'amy@kvgs.com', '2023/03/04 13:56:00', '/DATA/PostImage/img022.jpeg',  '대만에 왓습니다', 						'?여긴 고풍스러운 자전거도 많네요(전시용)<br>독특해서 보여드리고 싶어서요<br>대만에서 자전거용품 뭐사가면 소문날지<br>추천좀 부탁드려요');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10023, 'shs@kvgs.com', '2023/02/27 23:31:00', '/DATA/PostImage/img023.jpg',   '베트남 Phu Quoc 섬', 					'?베트남 호치민에 살고 있는 교민입니다.   ^^<br>금요일 저녁 Phu Quoc 섬에 도착해서, 일요일에 호치민으로 복귀하는 일정이었습니다. <br>토요일 오전에 자전거를 빌렸는데, 일요일에 자전거샵이 오픈하지 않아서... 토요일 오후 5시까지 반납해야만 했네요. <br>결국 시간에 쫓겨서 섬을 절반만 둘러 보았습니다 ~ ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10024, 'cjy@kvgs.com', '2023/02/21 13:41:00', '/DATA/PostImage/img024.jpg',   '[유럽]Grosse Scheidegg 라이딩', 		'역시 스위스는 날씨가 모든걸 좌우하는 곳이란걸 다시한번 느꼈습니다. <br>날씨가 않좋을때는 참 우중충한데 화창한 날의 스위스는 콧노래가 절로 나오는 그런 곳이네요.  ');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10025, 'aaa@aaa.aaa' , '2023/02/08 23:24:00', '/DATA/PostImage/img025.jpg',   '매화꽃 만발한 섬진강 자전거길 종주', 		'이번 여행은 섬진강 종주의 목적이 있었는데요.<br>섬진강을 따라가며 #광양매화꽃축제 #아름다운강변 #평화롭고아늑한시골풍경 등을 고루 감상할 수 있는 행복한 시간들이었습니다.<br>다만, 갈수록 높아지는 고도와 맞바람이 속도를 더디게 했지만, 아름다운 경치에 젖어 힘든 줄을 몰랐어요.<br>날씨도 쾌청해 자연의 모습을 생눈으로 보고 싶어 고글도 벗고 달렸어요...<br>산, 강, 하늘, 꽃, 겨울잠에서 깨어나 봄을 맞이하는 과수원, 들녁, 농촌...<br>모두가 너무 아름답고 아름다웠어요..<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10026, 'mks@kvgs.com', '2023/02/20 23:33:00', '/DATA/PostImage/img026.jpg',   '[전라광주]고흥 거금도', 					'누가 뒤떨어졌다냐?<br>7명중 하나 안 보이믄 쉬어 갑니다.<br>이런 간판도 오늘 눈여겨 봅니다.');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10027, 'kkm@kvgs.com', '2023/03/29 13:28:00', '/DATA/PostImage/img027.jpg',   '호수와 바다가 만나는곳... 화성호 한바퀴 순환코스', '총 54km 3시간 30분 걸린듯 하네요');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10028, 'amy@kvgs.com', '2023/03/25 23:34:00', '/DATA/PostImage/img028.jpg',   '국토종주 무사히 종료합니다.', 				'친형과 함께 좋은날씨의 연속함으로 633 국종 금일 마무리 하였습니다.<br>안전하지만 끝없이 이어지는 자도가 가장 힘들었네요.<br>도로에서만 탔던 로드자전거에 적응되어서 그런지,,,<br>자도의 도로 질감은 피로도가 많이 쌓이고 추진력도 많이 떨어지는듯 합니다.<br>열심히 열정을 가지고 탔던 자전거를 몇년간 뜸하게 보내왔던 제 자신을 다스리며 다시 즐겨보려 합니다.<br>자출사 모든 회원님들의 안라 기원드립니다.<br>감사합니다.<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10029, 'shs@kvgs.com', '2023/03/01 23:19:00', '/DATA/PostImage/img029.jpg',   '남아공 케이프 타운 2탄', 				'여기는 보통 하루 일과과 7시부터 4시<br>특히 금요일은 7시부터 2시에 끝납니다.<br>대체 얼마나 선진국인지 ㅎㅎ.<br>그만큼 할 것도 없고 빈부의 격차도 언청나지만 특히 밤에는 돌아다니는 사람도 없기 때문에<br>대부분 하루를 일찍 시작하고 일찍마치네요<br>주말에 시내나 해안도로를 보게되면 등산 또는 자전거 타는 사람들이 엄청 많습니다.<br>특히나 자전거는 거의 차와 동일시 되기 때문에 시내에 한해서는 <br>좌회전 가능하고 자전거 전용도로도 차선과 나란히 하고 있습니다 <br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10030, 'cjy@kvgs.com', '2023/03/29 02:45:00', '/DATA/PostImage/img030.jpg',   '베트남 / 무이네 -> 냐짱', 				'베트남에 거주하는 교민입니다. ' );
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10031, 'aaa@aaa.aaa' , '2023/03/27 08:12:00', '/DATA/PostImage/img031.jpg',   '캄보디아에서의 자전거 생활', 				'캄보디아 생활한지 벌써 아홉 달이나 지났습니다...처음 mtb를 타다 지금은 로드로 바꾼지 한 5개월 됐습니다. <br><br>주말이면 이곳 저곳 돌아다니는게 저의 가장 큰 행복입니다. <br><br>최근 캄보디아도 자전거 인구가 증가하는 추세라 도로 곳곳에서 라이딩을 즐기는 사람들이 많이 보이곤 합니다.<br><br>즐거운 하루 보내세요^^<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10032, 'mks@kvgs.com', '2023/03/24 09:54:00', '/DATA/PostImage/img032.jpeg',  '연휴 라이딩', 						'일본은 지금 연휴 기간으로 사람마다 10연휴 혹은 3연휴를 보내고 있는 기간입니다<br>파워미터도 달고 첫 주간라이딩다녀왔습니디<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10033, 'kkm@kvgs.com', '2023/03/29 15:10:00', '/DATA/PostImage/img033.jpg',   '자전거 업힐의 성지, Passo dello Stelvio 2차 등반', '주말에 스텔비오 날씨가 좋아서 스텔비오에 다시 다녀왔습니다. <br>스텔비오는 11월이면 길을 닫기 때문에 그전에 꼭 한번 다녀와야지 생각했는데,<br> 갑자기 날씨가 풀려서 다녀왔습니다 ㅎㅎ<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10034, 'amy@kvgs.com', '2023/03/11 13:52:00', '/DATA/PostImage/img034.jpg',   '스위스의 명산, 리기산을 자전거로 등반하다.', 	'첫번째 라이딩에선 중간에 길을 잘못들어 등산로에서 끌바를 시전한 끝에 <br>겨우겨우 리기산 정상에 올라갔고,<br>두번째 라이딩에선 길 잃지 않고 끌바도 없이 <br>(물론 엄청나게 많은 수의 휴식을 취했습니다) 리기산 정상까지 올라갔네요. <br>같이 갔던 친구중 한명은 도저히 못가겠다며 정상을 얼마 안남기고 돌려 내려가 버렸습니다. <br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10035, 'shs@kvgs.com', '2023/03/14 18:40:00', '/DATA/PostImage/img035.jpg',   '북유럽 핀란드 신혼여행라이딩', 				'2년전 신혼여행을 북유럽으로 로드를 챙겨가서 경험하고<br>코로나가 끝나면 지인들과 함께 해외라이딩을 계획중에 있습니다<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10036, 'cjy@kvgs.com', '2023/03/04 14:56:00', '/DATA/PostImage/img036.jpg',   '꽃피는 산골 장성진원-황룡강 소식', 			'첨단-상림4거리-백토고개-고산서원-진원면-밤실고개-<br>황룡대교-오룡교-초지마을-푸른솔cc-능성-사창  37km<br>출근길에 본 봄소식을 올립니다.<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10037, 'aaa@aaa.aaa' , '2023/02/27 10:31:00', '/DATA/PostImage/img037.jpeg',  '본격 시즌온준비 마지막', 					'오늘은 낮에일이있어서<br>본격시즌온 준비 마지막은 정비..<br>올 한해도 무탈하게 달려보자 ㅎ<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10038, 'mks@kvgs.com', '2023/02/21 16:41:00', '/DATA/PostImage/img038.jpg',   '영산강 하구둑에서 유스퀘어 까지 라이딩', 		'오늘 처음으로 징거리 도전이고 광주권을 벗어나서 처음 도전 해봤네요.<br>영산강 하구둑에서 느러지 전망대를 거쳐 죽산보와 싱촌보를 지나서<br>터미널에 치를 세워놔서 유스퀘어 까지 장징 총 5시간이 넘게 ㅎㅎㅎ <br>라이딩했네요. 뿌듯하네요.<br>다음번엔 담양댐 까지 한번 도전을 ㅎㅎㅎ<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10039, 'kkm@kvgs.com', '2023/02/08 13:24:00', '/DATA/PostImage/img039.jpg',   '날 풀린 김에 목포에서 광주까지 라이딩을 가봤습니다', '어제 갔는데 깜빡 잊는 바람에 오늘 쓰게 되네요. <br>3시 반 정도 시작해서 집에 도착하니 8시가 되더군요. 아직은 해가 지면 춥습니다...');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10040, 'amy@kvgs.com', '2023/02/20 14:33:00', '/DATA/PostImage/img040.jpg',   '장성황룡강 자전거길 공사구간안내', 			'장성황룡강자전거길중 천변좌로를 새로 말끔히 단장했기에<br>어제 답사를 했읍니다. 지도상 청색선이 기존이 도로이고<br>임곡->오룡교에서  빨간색좌로로 직진하면 쾌적하게 달릴수<br>있을것 같네요 다리가 거의 완공된듯하여 곧 개통될것 같습니다.<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10041, 'shs@kvgs.com', '2023/03/29 14:28:00', '/DATA/PostImage/img041.jpg',   '전남이 따스하지만', 					'아침6시 라이딩은 춥네요.');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10042, 'cjy@kvgs.com', '2023/03/25 13:34:00', '/DATA/PostImage/img042.jpg',   '북한강 자전거길 벚꽃은 ', 				'어제 보다 20 % 더 폈네여 ..');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10043, 'aaa@aaa.aaa' , '2023/03/01 16:19:00', '/DATA/PostImage/img043.jpeg',  '자출길에 너구리 봤어유', 					'너구리 봤어유 3년 전에 보고 잘못본건가 했는데<br>아직도 잘 살아있네요<br>누가 키우다 버린건가요?<br>사진이 무섭게 나와서 그렇지 음청 귀여워요<br>먹을게 있었으면 주고 싶을 정도로요^^<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10044, 'mks@kvgs.com', '2023/03/29 17:45:00', '/DATA/PostImage/img044.jpg',   '국토종주길에도 흐드러지게 핀 벚꽃~', 		'구미 국토종주길 낙동강변도로입니다,,,<br>잠깐 왔다가는 벚꽃,,, <br>낮도 좋지만, 야라에서 즐기는 눈호강은 곱빼기입니다^^<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10045, 'kkm@kvgs.com', '2023/03/27 18:12:00', '/DATA/PostImage/img045.jpg',   '대전 갑천 벚꽃만개', 					'라이딩겸 친구들만나러 대전내려갔더니<br>벚꽃이 활짝 ?? ??<br>서울은 이제 꽃망울 올라오던데<br>엑스포 구경도하고 라이딩, 꽃놀이까지 잘하고 가요');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10046, 'amy@kvgs.com', '2023/03/24 19:54:00', '/DATA/PostImage/img046.jpg',   '대구 달성습지생태학습관 개나리 만개했네요', 	'안녕하세요 최근 중고로 자전거 입문한 왕왕초보입니다??<br>어제 혼자 운동삼아 다녀온곳이 너무 예뻐서요~');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10047, 'shs@kvgs.com', '2023/03/29 13:10:00', '/DATA/PostImage/img047.jpg',   '자전거 대신 등산 다녀왔어요', 				'이번에 자전거 대신 등산 다녀왔어요  <br>정상에서 보는 풍정 역시 최고네요  <br>아직 등산 초보지만 천천히 심호흡 하면서 올라가다 보니까 <br>이맛에 등산도 다니는 구나 싶습니다 <br>내셔널지오그래픽 프로모션 하길래 짐벌캠 사둔게 있는데 이럴때 써먹네요  <br>영상도 찍으면서 돌아다니는데 화질이 진짜 최고에요 <br>가볍고 찍기도 쉽고 흔들림 없어서 좋네요  <br>좋은풍경 보고 왔으니 한주 또 잘 버텨봐야겠습니다  <br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10048, 'cjy@kvgs.com', '2023/03/11 13:52:00', '/DATA/PostImage/img048.jpg',   '동촌 해맞이다리 개나리', 					'오늘 퇴근길 한컷<br>봄 봄 봄 봄 봄이왔어요^^<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10049, 'aaa@aaa.aaa' , '2023/03/14 13:40:00', '/DATA/PostImage/img049.jpg',   '새만금 남북대교', 						'새만금 남북도로를 잇는 대교 공사중<br><br>왼쪽은 새만금 잼버리 2023 개최지방향<br><br>오른쪽은 내가 사는 전북 군산<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10050, 'mks@kvgs.com', '2023/03/04 13:56:00', '/DATA/PostImage/img050.jpg',   '친구와 롱비치 라이딩', 					'롱비치 항구 뷰포인트에 올라 기념사진 찍어봤네요<br>자덕의 천국이라는 이곳에서 <br>올 한해 열심히 천국을 맛보렵니다.<br>종종 사진으로 소식전하겠습니다.<br>그럼 언제나 안라, 즐라하시구요~<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10051, 'kkm@kvgs.com', '2023/02/27 13:31:00', '/DATA/PostImage/img051.png',   '두물머리', 							'함께온 가족과 연인들이 많네요');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10052, 'amy@kvgs.com', '2023/02/21 14:41:00', '/DATA/PostImage/img052.jpg',   '시즌 온~~~', 						'낙차사고로 척추골절되고 반년만에 야외라이딩~~ <br>10키로 뿔어서 져지고 빕이고 안들어가서 잠바입고 돌아다니는데 자유롭고 좋네요<br>체력이 거의초기화되서 20키로만 타도 헉헉..<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10053, 'shs@kvgs.com', '2023/02/08 15:24:00', '/DATA/PostImage/img053.jpg',   '후쿠오카에 자전거 타고 있습니다', 			'그저께 부산항에서 비틀호 타고 건너왔습니다 <br>자전거로 맨날 움직이다 일본에 한달에 한번씩 올때 마다 뚜벅이 하려니 <br>답답하기도 하고 여기 공공교통요금이 너무 비싸서 도선료나 그거나 비슷해서 <br>한번 싣고와 봤는데 좋네여 ㅎㅎ<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10054, 'cjy@kvgs.com', '2023/02/20 16:33:00', '/DATA/PostImage/img054.jpeg',  '일본 시즈오카현 하마마츠시 하마나호수 일주', 	'일본 7대1주중 하나인 하마이치라는 하마나호수를 도는 코스를 다녀왔습니다<br>어제 미친듯 비오고 오늘 하늘은 깨끗했는데<br>바람이.... 최대풍속 32킬로..ㅋㅋㅋ 방풍림<br>나무를 지나고 ㄴㅏ무사이를 지날때마다<br>자전거가 요동을 칩니다<br>가파른 내릭막을 내려가는데 페달을<br>밟는데 허벅지가 터집니다<br>역풍과 싸우다 무사히 귀환하여 사우나에서 피로풀고<br>겨우 집에 왔네요...<br>그냥 태풍이라 말해줬으면 안탔을지도...<br><br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10055, 'aaa@aaa.aaa' , '2023/03/29 17:28:00', '/DATA/PostImage/img055.jpg',   '주말 가족 자전거', 						'간만에 바람 없는 맑은 날씨에 샤방 자전거를 즐겨보아요<br>캘리포니아 몬테레이 에서....');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10056, 'mks@kvgs.com', '2023/03/25 18:34:00', '/DATA/PostImage/img056.jpg',   '런던에서 만났던 자전거들..', 				'전엔 자전거에 큰 관심이 없었어서 몰랐었는데<br>정말 다양한 종류의 자전거들이 있더라구요<br>몇장 찍은 자전거 사진들 올려 봅니다 ^^;<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10057, 'kkm@kvgs.com', '2023/03/01 19:19:00', '/DATA/PostImage/img057.jpg',   '파리 자전거 도로', 						'출장 왔은데 요즘 이 동네 자전거 길 새로 깔고 있네요. <br>보니 정말 하려면 이정도는 해야 하는 거 아닌가 해서 사진 찍고 올려 봅니다.<br> 자전거와 전동들이 같이 다니는데 차량은 절대로 들어오지 못하네요.<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10058, 'amy@kvgs.com', '2023/02/20 20:33:00', '/DATA/PostImage/img058.jpg',   '프랑스 자전거 여행', 					'숙소도착 후 체크아웃하고, 잔차는 바퀴 분해하여 자동차에 싣고 알프스 프로방스 방향으로 이동을 시작했다.<br>오전 라이딩만하고 투르Tours 로 이동하는데 날씨도 점점 좋아지고 아쉬운 마음에...분풀이 라이딩 한번 더 진행한다.<br>메슬레 듀-만느에서 차세우고 바퀴장착 후 라-플레슈 부근까지 그냥 직선길을 시원하게 쏘았다. 낙타등 구간 ...이지만 왜 오르막만 있는 것 같은지ㅎㅎㅎ<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10059, 'shs@kvgs.com', '2023/03/29 11:28:00', '/DATA/PostImage/img059.jpg',   '벚꽃 라이딩', 						'어제 휴무날 친구와 <br>벚꽃 라이딩...<br>코스는 구례구역에서 곡성예성캠핑장까지..<br>');
insert into community (c_id, w_email, c_date, img_path, title, c_text) values (10060, 'cjy@kvgs.com', '2023/03/25 12:34:00', '/DATA/PostImage/img060.jpg',   '여기는 어디일까요?', 					'서울시 한강공원 입니다');
                                                                                                                    
commit;

select * from community;

select c.c_id c_id, c.title title, c.c_date c_date, m.m_name m_name, c.img_path img_path, c.c_text c_text, c.w_email w_email  
from community c, member m
where c.w_email = m.m_email
order by c.c_date desc;


insert into detect_dis (dd_id, dd_email, dd_date, org_img, dt_img, dd_comment) values (2001, 'mks@kvgs.com', '2023/03/25 12:34:00', '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R01_B01_I00000021.JPG',   '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R01_B01_I00000021_bbox.JPG', '우리광어가 이상해요');
insert into detect_dis (dd_id, dd_email, dd_date, org_img, dt_img, dd_comment) values (2002, 'mks@kvgs.com', '2023/03/26 11:34:00', '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R02_B01_I00000021.JPG',   '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R02_B01_I00000021_bbox.JPG', '얘가 좀 비실거리네요');
insert into detect_dis (dd_id, dd_email, dd_date, org_img, dt_img, dd_comment) values (2003, 'mks@kvgs.com', '2023/03/27 10:34:00', '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R03_B01_I00000021.JPG',   '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R03_B01_I00000021_bbox.JPG', '이녀석 괜찮은 건가요');
insert into detect_dis (dd_id, dd_email, dd_date, org_img, dt_img, dd_comment) values (2004, 'mks@kvgs.com', '2023/03/28 09:34:00', '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R04_B01_I00000021.JPG',   '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R04_B01_I00000021_bbox.JPG', '움직이지 않아서 찍어 봅니다.');
insert into detect_dis (dd_id, dd_email, dd_date, org_img, dt_img, dd_comment) values (2005, 'mks@kvgs.com', '2023/03/29 08:34:00', '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R05_B01_I00000021.JPG',   '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R05_B01_I00000021_bbox.JPG', '배까고 누웠어요');

insert into detect_dis (dd_id, dd_email, dd_date, org_img, dt_img, dd_comment) values (2006, 'shs@kvgs.com', '2023/03/29 08:34:00', '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R05_B01_I00000021.JPG',   '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R05_B01_I00000021_bbox.JPG', '힘없어보이는 넙치 검사');
insert into detect_dis (dd_id, dd_email, dd_date, org_img, dt_img, dd_comment) values (2007, 'shs@kvgs.com', '2023/03/29 08:34:00', '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R05_B01_I00000021.JPG',   '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R05_B01_I00000021_bbox.JPG', '문제있어보이는 광어');
insert into detect_dis (dd_id, dd_email, dd_date, org_img, dt_img, dd_comment) values (2008, 'shs@kvgs.com', '2023/03/29 08:34:00', '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R05_B01_I00000021.JPG',   '/DATA/DetectImg/F01_U01_O0001_D2022-07-11_L330_W0483_S2_R05_B01_I00000021_bbox.JPG', '요즘 움직임이 굼뜬 한마리');

commit;

select d.dd_id dd_id, d.org_img org_img, d.dt_img dt_img, d.dd_email dd_email, 
        d.dd_date dd_date, d.dd_comment dd_comment, m.m_name m_name
    from detect_dis d, member m
	where d.dd_email = m.m_email
			order by d.dd_date desc;
			

insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('림포시스티스', '머리 및 체표 전체의 지느러미에 종양이 생성', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV001&fshCd=611301', '바이러스성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('바이러스성 신경괴사증', '신경세포에 감염되어 신경조직을 괴사시켜 대량폐사를 유발하고 수직감염에 의해 전염', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV007&fshCd=611301', '바이러스성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('바이러스성 출혈성 패혈증 바이러스', '체색흑화, 복수저류로 인한 복부팽만과 탈장, 아가미 퇴색 등이 관찰', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV009&fshCd=611301', '바이러스성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('백점병', '체표와 지느러미에 미세한 흰점이 관찰되며 심한 경우 아가미 뿐만 아니라 안구 등에서도 흰 점이 나타난다', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IP006&fshCd=611301', '기생충성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('버나바이러스병', '주로 치어기에 발생하며 복부가 팽만되거나 뇌부근에 출혈과 발적증상', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV005&fshCd=611301', '바이러스성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('비브리오증', '체색의 흑화, 지느러미 출혈 및 결손, 부분적 발적과 궤양 ', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IB005&fshCd=611301', '세균성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('상피증생증', '자어기에 나타나며, 지느러미 및 체표가 흐릿하게 변하고, 특히 지느러미 끝 부분이 말려들어 가는 듯한 증상', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV002&fshCd=611301', '바이러스성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('스쿠티카병', '표피가 박리되고 근육층이 노출되는 궤양증, 체표 염증, 지느러미 연조 및 꼬리자루 노출, 두부손상', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IP007&fshCd=611301', '기생충성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('에드워드병', '수류를 따라 빙빙 도는 행동, 체색 흑화, 지느러미 및 복부 발적 및 충혈, 복부팽만, 탈장', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IB004&fshCd=611301', '세균성질병');			
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('연쇄구균증', '체색 흑화, 안구 돌출·백탁·충혈, 두부 및 상하턱의 발적, 아가미 뚜껑 및 아가미 뚜껑 내측의 발적 그리고 아가미와 체표에 점액이 많이 분비', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IB001&fshCd=611301', '세균성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('이리도바이러스병', '치어단계에서 발생하며 체색이 검어지고, 복수가 차며, 내부장기의 출혈로 빈혈이 발생, 치어단계를 벗어나면 대량폐사는 발생하지 않음', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IV004&fshCd=611301', '바이러스성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('장관백탁증', '치어가 체색이 검어지고 장관이 백탁되거나 위축되어 90% 이상의 폐사율을 나타내기도 한다', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IB003&fshCd=611301', '세균성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('트리코이노시스', '수질이 좋지 못할때 아가미에서 점액질이 분비되고 표피가 벗겨지거나 궤양이 생성', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IP001&fshCd=611301', '기생충성질병');
insert into dis_search (ds_name, ds_simple, ds_url, ds_cause) values ('활주세균증', '체색흑화가 특징적이며 주둥이나 지느러미가 부식되고 결손 된다. 두부, 몸 및 지느러미가 붉어지고 출혈과 궤양이 생긴다, 단독으로 발생하지 않고 다른 질병과 혼합하여 발병한다.', 'https://www.nifs.go.kr/fishguard/disease01_view?dssCd=IB002&fshCd=611301', '세균성질병');

commit;

select * from dis_search;				
				
				
				
				
				
				