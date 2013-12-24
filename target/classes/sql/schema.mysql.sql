drop table if exists user;
create table user (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(50),
  PRIMARY KEY (id)
);

drop table if exists stat;
create table stat (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11),
  record_date datetime,
  weight decimal(5, 2),
  fat_percent decimal(5, 2),
  muscle_percent decimal(5, 2),
  PRIMARY KEY (id)
);

