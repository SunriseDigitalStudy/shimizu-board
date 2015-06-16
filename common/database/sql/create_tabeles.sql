drop schema if exists `board` ;
create schema if not exists `board` default characther set utf8 collate utf8_general_ci;
use `board`;

-- table `board`.`genre`
create table if not exists `board`.`genre`(
`id` int unsigned not null auto_increment ,
`name` varchar(45) not null ,
`sequence` int unsigned not null ,
primary key (`id`) )
engine = InnoDb;

-- table `board`.`thread`
create table if not exists `board`.`thread` (
`id` int not null auto_increment ,
`genre_id` int unsigned not null ,
`title` varchar(80) not null ,
`create_at` datetime not null ,
primary key (`id`) ,
index `fk_thread_genre1_idx` (`genre_id` ASC) ,
constraint `fk_thread_genre1`
foreign key(`genre_id`)
references `board`.`genre` (`id`)
on delete no action
on update no action)
engine = InnoDB;

-- Table `board`.`account`
create table if not exists `board`.`account` (
`id` int not null auto_increment ,
`login_id` varchar(120) not null ,
`password` varchar(255) null ,
`updated_at` datetime not null ,
`create_at` datetime not null ,
primary key(`id`) ,
unique index `login_id_unique` (`login_id` ASC) )
engine = InnoDB;

-- Table `board.`entry`
create table if not exists `board`.`entry` (
`id` int not null auto_increment ,
`thread_id` int not null ,
`body` varchar(255) not null ,
`updated_at` datetime not null ,
`create_at` datetime not null ,
primary key(`id`) ,
index `fk_entry_thread_idx` (`thread_id` ASC ) ,
index `fk_entry_account1_idx` (`account_id` ASC ) ,
constraint `fk_entry_thread`
foreign key(`thread_id`)
references `board`.`thread`
on delete cascade
on update restrict ,
constraint `fk_entry_account1`
foreign key(`account_id`)
references `board`.`account` (`id`)
on delete cascade
on update restrict)
engine = InnoDB;

-- Table`board`.`auto_login`
create table if not exists `board`.`auto_login` (
`hash` varchar(190) not null ,
`account_id` int not null ,
`expire_date` datetime not null ,
primary key (`hash`) ,
index `fk_auto_login_account1_login` (`account` ASC ) ,
constraint `fk_auto_login_account1`
foreign key (`account_id`)
references `board`.`account` (`id`)
on delete cascade
on update restrict)
engine = InnoDB;

-- Table `board`.`tag`
create table if not exists `board`.`tag` (
`id` int unsigned not null auto_increment ,
`name` varchar(45)not null ,
primary key(`id`) )
engine = InnoDB;

-- Table `board`.`thread_tag`
create table if not exists `board`.`thread_tag` (
`thread_id` int not null ,
`tag_id` int unsigned not null ,
primary key (`thread_id` , `tag_id`) ,
index `fk_thread_has_tag_tag1_idx` (`tag_id` ASC) ,
index `fk_thread_has_tag_thread1_idx` (`tag_id` ASC) ,
constraint `fk_thread_has_tag_thread1`
foreign key(`thread_id`)
references `board`.`thread`(`id`)
on delete cascade
on update no action ,
constraint `fk_thread_has_tag_tag1`
foreign key(`tag_id`)
references `board`.`tag` (`id`)
on delete cascade
on update no action)
engine = InnoDB;