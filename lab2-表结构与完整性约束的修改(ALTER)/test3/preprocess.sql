CREATE DATABASE IF NOT EXISTS MyDb;
use MyDb;

DROP TABLE IF EXISTS addressBook;

create table addressBook(
   serialNo int auto_increment primary key,
   name char(32),
   company char(32),
   position char(10),
   workPhone char(16),
   mobile char(11),
   QQ int,
   weixin char(12)
);


