
/* ********************************
Table 생성 부분
******************************** */

/*고객정보*/
create table if not exists heal_user (
id varchar(16) not null,
name varchar(50) not null,
pw varchar(16) not null,
email varchar(50) not null,
phone_home char(20) default '',
phone_corp char(20) default '',
phone_mobi char(20) not null,
jumin char(14) default '',
date_birth datetime not null,
date_join datetime not null,
id_medi int(11) default 0,
group_name varchar(50) default 'none',
group_dept varchar(50) default 'none',
group_id int(11) default 0,
gender char(1) default 'm',
id_comb_used varchar(45) default 'none',
id_comb_nth int(11) default 0,
zipcode_home char(7) default 0,
address_home1 varchar(100) default '',
address_home2 varchar(100) default '',
zipcode_corp char(7) default 0,
address_corp1 varchar(100) default '',
address_corp2 varchar(100) default '',
auth_type char(3) default '0',
file_img varchar(100) default '',
comment varchar(200) default '',
primary key(id, email, phone_mobi)
);

/* 운동처방전-진단정보 */
CREATE  TABLE if not exists heal_prescript_header (
  id INT NOT NULL AUTO_INCREMENT ,
  id_medi INT NOT NULL DEFAULT 0,
  id_user VARCHAR(16) NOT NULL DEFAULT '' ,
  id_doctor VARCHAR(16) NOT NULL DEFAULT '' ,
  id_therap VARCHAR(16) NOT NULL DEFAULT '' ,
  date_upload DATETIME NOT NULL ,
  date_end VARCHAR(45) NOT NULL ,
  diagnosis VARCHAR(100) NOT NULL DEFAULT '' ,
  height FLOAT NOT NULL DEFAULT 0 ,
  weight FLOAT NOT NULL DEFAULT 0 ,
  bmi SMALLINT NOT NULL DEFAULT 0 ,
  bp_high SMALLINT NOT NULL DEFAULT 0 ,
  bp_low SMALLINT NOT NULL DEFAULT 0 ,
  family_history VARCHAR(200) NOT NULL DEFAULT '' ,
  curr_sick INT NOT NULL DEFAULT 0 ,
  remark TEXT NOT NULL ,
  after_action VARCHAR(255) NOT NULL DEFAULT '' ,
  comment TEXT NOT NULL ,
  continued TINYINT NOT NULL DEFAULT 0 ,
  status TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (id) );
  


/* 운동처방전-조합목록 */
CREATE  TABLE if not exists heal_prescript_comb (
  seq INT NOT NULL ,
  id_pres INT NOT NULL ,
  id_comb BIGINT NOT NULL DEFAULT 0 ,
  odi INT NOT NULL DEFAULT 0 ,
  str INT NOT NULL DEFAULT 0 ,
  rom VARCHAR(120) NOT NULL DEFAULT '000' ,
  weekly_chk BIGINT NOT NULL DEFAULT 0 ,
  frequency INT NOT NULL DEFAULT 0 ,
  intensity INT NOT NULL DEFAULT 0 ,
  duration INT NOT NULL DEFAULT 0 ,
  form INT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (seq, id_pres) );

/* 컨텐츠파일정보 */
create table if not exists heal_movie_file (
id integer primary key AUTO_INCREMENT,
subject varchar(100) default '',
file_id varchar(50) default '',
file_webm varchar(50) default '',
file_mp4 varchar(50) default '',
file_ogg varchar(50) default '',
file_mp3 varchar(50) default '',
file_img varchar(50) default '',
file_smi varchar(50) default '',
ori_webm varchar(50) default '',
ori_mp4 varchar(50) default '',
ori_ogg varchar(50) default '',
ori_mp3 varchar(50) default '',
ori_img varchar(50) default '',
ori_smi varchar(50) default '',
cate_movie char(20) default '',
cate_sub int default 0,
date_upload datetime not null,
use_cnt int default 0,
vas_low float default 1,
vas_high float default 1
);

/* 컨텐츠조합정보 */
create table if not exists heal_comb_header (
id bigint primary key AUTO_INCREMENT,
subject varchar(100) default '',
id_user varchar(16) default '',
date_upload datetime not null,
cate_movie char(20) default '',
cate_sub int default 0,
cate_menu int default 0,
use_cnt int default 0,
vas_low float default 1,
vas_high float default 1,
weekly_pfm int not null default 0
);

/* 컨텐츠조합목록 */
create table if not exists heal_comb_cont (
id_comb bigint not null,
seq int not null,
id_movie int default 0,
repeat_cnt int default 1,
repeat_start int default 0,
repeat_end int default 0,
nth int default 1,
left_right char(1) default '',
popup char(1) default '',
popup_msg varchar(255) default '',
popup_action varchar(255) default '',
primary key(id_comb, seq)
);

/* 통합 게시판 */
CREATE TABLE if not exists heal_board (
id INT NOT NULL AUTO_INCREMENT,
board_type CHAR(1) NOT NULL,
category VARCHAR(20) DEFAULT '',
subject VARCHAR(255) NOT NULL,
uploader VARCHAR(100) NOT NULL,
content MEDIUMTEXT NOT NULL,
date_upload DATETIME NOT NULL,
file_image VARCHAR(100) DEFAULT '',
file_upload VARCHAR(100) DEFAULT '',
PRIMARY KEY (id)
);

/* LOG */
CREATE TABLE if not exists heal_log (
id_user VARCHAR(16) NOT NULL DEFAULT '',
email_user VARCHAR(50) NOT NULL DEFAULT '',
phone_user VARCHAR(20) NOT NULL DEFAULT '',
upload_date DATETIME NOT NULL,
`div` CHAR(1) NOT NULL DEFAULT '',
id_cont BIGINT NOT NULL DEFAULT -1,
PRIMARY KEY (id_user, upload_date));

/* 병원/의료기관 정보 사용자 그룹 정보 */
CREATE TABLE if not exists heal_group(
id INT(11) NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL DEFAULT '',
address VARCHAR(255) NOT NULL DEFAULT '',
phone CHAR(20) NOT NULL DEFAULT '',
fax CHAR(20) NOT NULL DEFAULT '',
id_user VARCHAR(50) NOT NULL DEFAULT '',
name_user VARCHAR(50) NOT NULL DEFAULT '',
zipcode char(7) NOT NULL DEFAULT '',
intro VARCHAR(45) NOT NULL DEFAULT '',
div_group CHAR(1) NOT NULL DEFAULT '',
work_type VARCHAR(20) NOT NULL DEFAULT '',
url VARCHAR(255) NOT NULL DEFAULT '',
date_estab DATE NOT NULL,
file_img VARCHAR(100) NOT NULL DEFAULT '',
url_map VARCHAR(255) NOT NULL DEFAULT '',
coordinate VARCHAR(30) NOT NULL DEFAULT '',
file_banner VARCHAR(100) NOT NULL DEFAULT '',
PRIMARY KEY (id)
);












/* ********************************
View 생성 부분
******************************** */

create or replace view heal_movie_file_view as
select id, 
	subject, date_format(date_upload, '%Y-%m-%d') as date_upload, /* %H:%M:%S = 시간 추가 시*/
	file_webm, file_mp4, file_ogg, file_mp3, file_img, file_smi, 
	ori_webm, ori_mp4, ori_ogg, ori_mp3, ori_img, ori_smi,
	use_cnt, vas_low, vas_high, cate_movie,
	substring(cate_movie, 1, 2) as cate_movie0,
	cast(substring(cate_movie, 3, 2) as unsigned) as cate_movie1,
	cast(substring(cate_movie, 5, 1) as unsigned) as cate_movie2,
	cast(substring(cate_movie, 6, 4) as unsigned) as cate_movie3,
	(cate_sub & 1) as cate_sub1
from
	heal_movie_file
order by
	id desc;

create or replace view heal_comb_view as
select
	ch.id,
	ch.subject, id_user,
	date_format(ch.date_upload, '%Y-%m-%d') as date_upload,
	ch.cate_movie,
	substring(ch.cate_movie, 1, 2) as cate_movie0,
	cast(substring(ch.cate_movie, 3, 2) as unsigned) as cate_movie1,
	cast(substring(ch.cate_movie, 5, 1) as unsigned) as cate_movie2,
	cast(substring(ch.cate_movie, 6, 4) as unsigned) as cate_movie3,
	substring(ch.cate_movie, 12, 1) as left_right,
	ch.vas_high,
	usr.name as name_uploader,
	mf.file_img,
	group_concat(mf.subject, '|') as subject_movie
from 
	heal_comb_header as ch
	left outer join heal_user usr
	on ch.id_user = usr.id
	left outer join heal_comb_cont cc
	on ch.id = cc.id_comb and (cc.seq between 1 and 3)
	left outer join heal_movie_file mf
	on cc.id_movie = mf.id
group by
	ch.id
;

create or replace view heal_comb_view_detail as
select
	ch.id,
	ch.subject, id_user,
	date_format(ch.date_upload, '%Y-%m-%d') as date_upload,
	ch.cate_movie,
	substring(ch.cate_movie, 1, 2) as cate_movie0,
	cast(substring(ch.cate_movie, 3, 2) as unsigned) as cate_movie1,
	cast(substring(ch.cate_movie, 5, 1) as unsigned) as cate_movie2,
	cast(substring(ch.cate_movie, 6, 4) as unsigned) as cate_movie3,
	ch.vas_high,
	usr.name as name_uploader,
	ch.use_cnt
from 
	heal_comb_header as ch
	left outer join heal_user usr
	on ch.id_user = usr.id
	left outer join heal_comb_cont cc
	on ch.id = cc.id_comb
	left outer join heal_movie_file mf
	on cc.id_movie = mf.id
group by
	ch.id
;

create or replace view heal_comb_view_detail_sub as
select
    id_comb,
    seq,
    subject as subject_movie,
    file_img,
    file_webm,
    file_mp4,
    file_ogg,
    file_mp3,
    id_movie,
    repeat_cnt,
    nth,
    left_right,
    popup,
    popup_msg,
    popup_action
from 
    heal_comb_cont cc
    left outer join heal_movie_file mf
    on cc.id_movie = mf.id;


create or replace view heal_user_view_detail as
select 
    usr.*,
    year(now()) - year(usr.date_birth) 
        - (datediff(
            concat(
                year(now()), '-', 
                month(usr.date_birth), '-', 
                day(usr.date_birth)
            ), now() ) > 0) as age,
    (CASE WHEN usr.gender = 'm' THEN '남자' ELSE '여자' END) as gender_kor,
    medi.name as medi_name,
    corp.id as id_corp,
    corp.name as corp_name
from 
    heal_user usr
    left outer join heal_group medi
    on usr.id_medi = medi.id
    left outer join heal_group corp
    on usr.group_id = corp.id
;


create or replace view heal_prescript_view as
select
	ph.*,
	(case when ph.status = 0 then '의사 진단중' when ph.status = 1 then '운동사 진단중' else '진단 완료' end) as status_kor,
	pc.id_comb,
	concat(ch.vas_low, '-', ch.vas_high) as vas,
	usr.name as user_name,
	date_format(ph.date_upload, '%Y-%m-%d') as date_upload_fmt,
	date_format(ph.date_end, '%Y-%m-%d') as date_end_fmt
from
	heal_prescript_header as ph
	left outer join heal_prescript_comb as pc
	on ph.id = pc.id_pres
	left outer join heal_comb_header as ch
	on pc.id_comb = ch.id
	left outer join heal_user usr
	on ph.id_user = usr.id
order by
    ph.status asc,
    ph.id desc,
    ph.date_upload desc
;

create or replace view heal_prescript_view_detail as
select
    ph.*,
    pc.*,
    lpad(ph.id, 4, 0) as id_fmt,
    lpad(ph.id_medi, 3, 0) as id_medi_fmt,
    concat(ph.bp_low, '-', ph.bp_high) as bp,
    medi.name as medi_name,
    
    usr.name as user_name,
    (CASE WHEN usr.gender = 'm' THEN '남자' ELSE '여자' END) as user_gender_kor,
    usr.age as user_age,
    date_format(usr.date_birth, '%Y-%m-%d') as user_date_birth,
    usr.phone_home as user_phone_home,
    usr.phone_mobi as user_phone_mobi,
    usr.zipcode_home as user_zipcode_home,
    usr.address_home1 as user_address_home1,
    usr.address_home2 as user_address_home2,
    usr.zipcode_corp as user_zipcode_corp,
    usr.address_corp1 as user_address_corp1,
    usr.address_corp2 as user_address_corp2,

    dctr.name as doctor_name,
    dctr.corp_name as doctor_medi,
    dctr.id_corp as doctor_medi_id,
    
    thrp.name as therap_name,
    thrp.corp_name as therap_medi,

    ch.subject as subject_comb,
    concat(ch.vas_low, '-', ch.vas_high) as vas,
    cast(substring(ch.cate_movie, 3, 2) as unsigned) as cate_movie1,
    
    date_format(ph.date_upload, '%Y-%m-%d') as date_upload_fmt,
    date_format(ph.date_end, '%Y-%m-%d') as date_end_fmt,
    (case when ph.continued = 1 then '예' else '아니오' end) as continued_kor
from
    heal_prescript_header as ph
    left outer join heal_group as medi
    on ph.id_medi = medi.id
    left outer join heal_user_view_detail as usr
    on ph.id_user = usr.id
    left outer join heal_user_view_detail as dctr
    on ph.id_doctor = dctr.id
    left outer join heal_user_view_detail as thrp
    on ph.id_therap = thrp.id
    left outer join heal_prescript_comb as pc
    on ph.id = pc.id_pres
    left outer join heal_comb_header as ch
    on pc.id_comb = ch.id
;


create or replace view heal_prescript_view_detail_sub as
select 
    pc.id_pres,
    cvds.*
from 
    heal_prescript_comb pc
    left outer join heal_comb_view_detail_sub cvds
    on pc.id_comb = cvds.id_comb;

