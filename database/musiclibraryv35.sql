-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.45 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

-- /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
-- /*!40101 SET NAMES utf8mb4 */;
-- /*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
-- /*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for musiclibrary
CREATE DATABASE IF NOT EXISTS `musiclibrary`; -- /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `musiclibrary`;


-- Dumping structure for table musiclibrary.artist
CREATE TABLE IF NOT EXISTS `artist` (
  `artist_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`artist_id`),
  KEY `PKI_ARTIST_ID` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table musiclibrary.file
CREATE TABLE IF NOT EXISTS `file` (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `size` bigint(20) NOT NULL,
  `upload` date NOT NULL,
  `modified` date DEFAULT NULL,
  PRIMARY KEY (`file_id`),
  KEY `PKI_FILE_ID` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping structure for table musiclibrary.videofile
CREATE TABLE IF NOT EXISTS `videofile` (
  `video_file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_info` bigint(20) NOT NULL,
  `video_file_path` varchar(200) NOT NULL DEFAULT 'path string',
  `format` enum('MP4','MOV','M4P') NOT NULL,
  `bitrate` enum('128','256','VARIABLE') NOT NULL,
  `resolution_x` bigint(225) NOT NULL,
  `resolution_y` bigint(225) NOT NULL,
  PRIMARY KEY (`video_file_id`),
  UNIQUE KEY `file_info` (`file_info`),
  KEY `PKI_VIDEOFILE_ID` (`video_file_id`),
  KEY `FKI_VIDEOFILE_INFO` (`file_info`),
  CONSTRAINT `videofile_ibfk_1` FOREIGN KEY (`file_info`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping structure for table musiclibrary.audiofile
CREATE TABLE IF NOT EXISTS `audiofile` (
  `audio_file_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_info` bigint(20) NOT NULL,
  `audio_file_path` varchar(200) NOT NULL DEFAULT 'path string',
  `format` enum('MP3','WAV','M4P') DEFAULT NULL,
  `bitrate` varchar(200) DEFAULT NULL,
   PRIMARY KEY (`audio_file_id`),
  UNIQUE KEY `file_info` (`file_info`),
  KEY `PKI_AUDIOFILE_ID` (`audio_file_id`),
  KEY `FKI_AUDIOFILE_FILEINFO` (`file_info`),
  CONSTRAINT `audiofile_ibfk_1` FOREIGN KEY (`file_info`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Data exporting was unselected.

-- Dumping structure for table musiclibrary.genre
CREATE TABLE IF NOT EXISTS `genre` (
  `genre_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` enum('ROCK','POP','COUNTRY','Rythm & Blues','House Music') DEFAULT NULL,
  PRIMARY KEY (`genre_id`),
  KEY `PKI_GENRE_ID` (`genre_id`) USING HASH,
  KEY `GENRE_NAME_INDEX` (`type`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table musiclibrary.song
CREATE TABLE IF NOT EXISTS `song` (
  `song_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `song_name` varchar(200) NOT NULL,
  `release_date` date NOT NULL,
  `album` varchar(200) NOT NULL,
  `language` varchar(200) NOT NULL,
  `audio_file` bigint(20) NOT NULL,
  `video_file` bigint(20) NOT NULL,
  `artist` bigint(20) NOT NULL, 
  PRIMARY KEY (`song_id`),
  KEY `PKI_SONG_ID` (`song_id`) USING HASH,
  KEY `SONG_NAME_INDEX` (`song_name`) USING BTREE,
  KEY `FKI_SONG_ARTIST` (`artist`) USING HASH,
  KEY `FKI_SONG_AUDFILE` (`audio_file`) USING HASH,
  KEY `FKI_SONG_VIDFILE` (`video_file`) USING HASH,
  CONSTRAINT `song_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `artist` (`artist_id`),
  CONSTRAINT `song_ibfk_2` FOREIGN KEY (`audio_file`) REFERENCES `audiofile` (`audio_file_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `song_ibfk_3` FOREIGN KEY (`video_file`) REFERENCES `videofile` (`video_file_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




-- Dumping structure for table musiclibrary.mluser
CREATE TABLE IF NOT EXISTS `mluser` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `email_address` varchar(200) NOT NULL,
  `DOB` date DEFAULT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  `role` varchar(10) NOT NULL DEFAULT 'USER',
  PRIMARY KEY (`user_id`),
  KEY `PKI_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- Dumping structure for table musiclibrary.userlogin
CREATE TABLE IF NOT EXISTS `userlogin` (
  `user_login_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(200) NOT NULL,
  `user_password` varchar(200) NOT NULL,
  `date_joined` datetime NOT NULL,
  `user_details` bigint(20) NOT NULL,
  PRIMARY KEY (`user_login_id`),
  KEY `PKI_USER_LOGIN_ID` (`user_login_id`),
  KEY `FKI_USER_DETAILS` (`user_details`),
  CONSTRAINT `userlogin_ibfk_1` FOREIGN KEY (`user_details`) REFERENCES `mluser` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- Dumping structure for table musiclibrary.lyrics
CREATE TABLE IF NOT EXISTS `lyrics` (
  `lyrics_id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `contributor` bigint(20) NOT NULL,
  `lyrics` varchar(20000) NOT NULL,
  `song` bigint(20) NOT NULL,
  PRIMARY KEY (`lyrics_id`),
  KEY `PKI_LYRICS_ID` (`lyrics_id`) USING HASH,
  KEY `FKI_LYRICS_CONTRIBUTOR` (`contributor`) USING HASH,
  KEY `FKI_LYRICS_SONG` (`song`) USING HASH,
  KEY `LYRICS_INDEX` (`title`) USING BTREE,
  CONSTRAINT `lyrics_ibfk_1` FOREIGN KEY (`contributor`) REFERENCES `userlogin` (`user_login_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lyrics_ibfk_2` FOREIGN KEY (`song`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Data exporting was unselected.


-- Dumping structure for table musiclibrary.playlist
CREATE TABLE IF NOT EXISTS `playlist` (
  `playlist_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `play_list_name` varchar(200) NOT NULL DEFAULT 'playlist name',
  `owner` bigint(20) NOT NULL,
  PRIMARY KEY (`playlist_id`),
  KEY `PKI_PLAYLIST_ID` (`playlist_id`) USING HASH,
  KEY `FKI_PLAYLIST_OWNER` (`owner`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `userlogin` (`user_login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table musiclibrary.review
CREATE TABLE IF NOT EXISTS `review` (
  `user_id` bigint(20) NOT NULL,
  `song_id` bigint(20) NOT NULL,
  `star_rating` bigint(20) NOT NULL,
  `user_comment` varchar(200) NOT NULL,
  PRIMARY KEY (`user_id`,`song_id`),
  KEY `PKI_REVIEW_ID` (`user_id`,`song_id`) USING BTREE,
  KEY `FKI_REVIEW_USER_ID` (`user_id`) USING HASH,
  KEY `FKI_REVIEW_SONG_ID` (`song_id`) USING HASH,
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `userlogin` (`user_login_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Data exporting was unselected.


-- Dumping structure for table musiclibrary.songgenre
CREATE TABLE IF NOT EXISTS `songgenre` (
 `song_genre_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `song` bigint(20) NOT NULL,
  `genre` bigint(20) NOT NULL,
  PRIMARY KEY (`song_genre_id`),
  UNIQUE KEY `song` (`song`,`genre`),
  KEY `PKI_SONG_GENRE_ID` (`song_genre_id`) USING HASH,
  KEY `FKI_SONG_ID` (`song`),
  KEY `FKI_GENRE_ID` (`genre`),
  CONSTRAINT `songgenre_ibfk_1` FOREIGN KEY (`song`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `songgenre_ibfk_2` FOREIGN KEY (`genre`) REFERENCES `genre` (`genre_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table musiclibrary.songplaylist
CREATE TABLE IF NOT EXISTS `songplaylist` (
  `playlist_id` bigint(20) NOT NULL,
  `song_id` bigint(20) NOT NULL,
  PRIMARY KEY (`playlist_id`,`song_id`),
  KEY `PKI_SONGPLAYLIST_ID` (`playlist_id`,`song_id`) USING BTREE,
  KEY `FKI_SONGPLAYLIST_PLAYLIST_ID` (`playlist_id`) USING HASH,
  KEY `FKI_SONGPLAYLIST_SONG_ID` (`song_id`) USING HASH,
  CONSTRAINT `songplaylist_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`playlist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `songplaylist_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.




-- Data exporting was unselected.



-- Data exporting was unselected.
-- /*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
-- /*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
-- /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
--                                        INSERTING DATA TO SQL



insert into mluser (first_name, last_name, email_address, DOB) 
values ('Binnie', 'Abraham', 'abraham.bi@husky.neu.edu', '1992-10-14');

insert into mluser (first_name, last_name, email_address, DOB) 
values ('Meenakshi', 'Mishra', 'mishra.me@husky.neu.edu', '1991-12-29');

insert into mluser (first_name, last_name, email_address, DOB) 
values ('Mayank', 'Sharma', 'sharma.ma@husky.neu.edu', '1992-05-12');

insert into mluser (first_name, last_name, email_address, DOB) 
values ('Mayur', 'Umdekar', 'umdekar.ma@husky.neu.edu', '1991-02-28');

insert into mluser (first_name, last_name, email_address, DOB) 
values ('Diksha', 'Agrawal', 'agrawal.di@husky.neu.edu', '1991-11-27');

insert into mluser (first_name, last_name, email_address, DOB) 
values ('Admin', 'Rai', 'rai.ai@husky.neu.edu', '1980-12-12');

insert into mluser (first_name, last_name, email_address, DOB) 
values ('Ranveer', 'Singh', 'singh.ra@husky.neu.edu', '1991-12-29');


-- insert in user login table

insert into userLogin (user_name, user_password, date_joined, user_details)
values ('binnieAbraham', 'binnieAbrahamPassword', '2015-12-02', '1');

insert into userLogin (user_name, user_password, date_joined, user_details)
values ('meenakshiMishra', 'meenakshiMishraPassword', '2015-12-03', '2');

insert into userLogin (user_name, user_password, date_joined, user_details)
values ('mayankSharma', 'mayankSharmaPassword', '2015-12-04', '3');


insert into userLogin (user_name, user_password, date_joined, user_details)
values ('MayurUmdekar', 'mayurUmdekarPassword', '2015-12-05', '4');

insert into userLogin (user_name, user_password, date_joined, user_details)
values ('DikshaAgrawal', 'dikshaAgrawalPassword', '2015-12-06', '5');

insert into userLogin (user_name, user_password, date_joined, user_details)
values ('AdminRai', 'aishwaryaRaiPassword', '2015-12-07', '6');


insert into userLogin (user_name, user_password, date_joined, user_details)
values ('RanveerSingh', 'ranveerSinghPassword', '2015-12-08', '7');


-- insert into file


insert into file (name, size, upload, modified)
values ('BeatItFile', '250', '1999-12-24', '2000-11-14');


insert into file (name, size, upload, modified)
values ('DangerousFile', '550', '1995-04-21', '1997-01-18');


insert into file (name, size, upload, modified)
values ('RoopTeraMastanaFile', '420', '1990-05-01', '1994-02-14');


insert into file (name, size, upload, modified)
values ('RimjhimGireSavanFile', '180', '1986-07-08', '2008-08-01');


insert into file (name, size, upload)
values ('LeanOnFile', '500', '2015-11-11');


insert into file (name, size, upload)
values ('SkyFallFile', '400', '2013-12-11');


insert into file (name, size, upload)
values ('HeroFile', '190', '2008-11-11');


insert into file (name, size, upload, modified)
values ('RockMyWorldFile', '330', '1995-11-11', '1996-11-14');

insert into file (name, size, upload, modified)
values ('IWillAlwaysLoveYouFile', '347', '1988-01-21', '1996-11-14');

insert into file (name, size, upload, modified)
values ('BilamoseFile', '311', '1988-01-21', '1996-11-14');

-- insert in audio file 

insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('1', '//beatItFilePath', 'MP3', '192');

insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('2', '//DangerousFilePath', 'MP3', '192');

insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('3', '//RoopTeraMastanFilePath', 'MP3', '192');

insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('4', '//RimjhimGireSavanFilePath', 'MP3', '192');


insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('5', '//LeanOnFilePath', 'WAV', '128');

insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('6', '//SkyFallFilePath', 'MP3', '160');

insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('7', '//HeroFilePath', 'WAV', '160');


insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('8', '//RockMyWorldFilePath', 'WAV', '192');


insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('9', '//IWillAlwaysLoveYouFilePath', 'MP3', '160');


insert into audiofile (file_info, audio_file_path, format, bitrate)
values ('10', '//BilamoseFilePath', 'WAV', '192');




-- videoFile

insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('1', '//beatItFilePath', 'M4P', 'VARIABLE', '1024', '576');

insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('2', '//DangerousFilePath', 'M4P', '256', '1280', '720');

insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('3', '//RoopTeraMastanFilePath','M4P', '256', '1280', '720');

insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('4', '//RimjhimGireSavanFilePath', 'M4P', '256', '1280', '720');


insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('5', '//LeanOnFilePath','MP4', 'VARIABLE', '1024', '576');

insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('6', '//SkyFallFilePath', 'MP4', '128', '1024', '576');

insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('7', '//HeroFilePath', 'MP4', '256', '1024', '576');


insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('8', '//RockMyWorldFilePath', 'MP4', 'VARIABLE', '1024', '576');


insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('9', '//IWillAlwaysLoveYouFilePath', 'MOV', '256', '320', '240');


insert into videofile (file_info, video_file_path, format, bitrate, resolution_x, resolution_y)
values ('10', '//BilamoseFilePath', 'MOV', '128', '320', '240');



-- insert data in artist

insert into artist (name) value ('Michael Jackson');
insert into artist (name) value ('Kishor Kumar');
insert into artist (name) value ('Mohammad Rafi');
insert into artist (name) value ('Whitney Huston');
insert into artist (name) value ('Adele');
insert into artist (name) value ('Enrique Iglesias');
insert into artist (name) value ('Major Lazer');
insert into artist (name) value ('DJ Snake');




-- insert data into song

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Beat It', '1982-12-04', 'Beat It', 'English', '1', '1', '1');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Dangerous', '1991-11-26', 'Dangerous', 'English', '2', '2', '1');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Roop Tera Mastana', '1972-11-04', 'Aradhna', 'Hindi', '3', '3', '2');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Rimjhim Gire Savan', '1979-12-14', 'Manzil', 'Hindi', '4', '4', '2');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Lean On', '2015-10-11', 'Peace Is The Mission', 'English', '5', '5', '7');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Lean On', '2015-10-11', 'Peace Is The Mission', 'English', '5', '5', '8');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Sky Fall', '2012-11-19', 'OdinO', 'English', '6', '6', '5');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Hero', '2001-11-11', 'Escape', 'English', '7', '7', '6');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Rock My World', '2001-01-09', 'Invincible', 'English', '8', '8', '1');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('I Will Always Love You', '2000-07-18', 'Whitney: The Unreleased Mixes', 'English', '9', '9', '4');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Bailamose', '1998-11-17', 'Cosas del Amor', 'English', '10', '10', '4');

insert into song (song_name, release_date, album, language, audio_file, video_file, artist)
values ('Bailamose', '1998-11-17', 'Cosas del Amor', 'English', '10', '10', '6');



-- insert data in genre

insert into genre (type) value ('ROCK');
insert into genre (type) value ('POP');
insert into genre (type) value ('COUNTRY');
insert into genre (type) value ('Rythm & Blues');
insert into genre (type) value ('House Music');

-- insert into songenre

insert into songgenre (song, genre) values ('1', '1');
insert into songgenre (song, genre) values ('2', '1');
insert into songgenre (song, genre) values ('2', '2');
insert into songgenre (song, genre) values ('3', '2');
insert into songgenre (song, genre) values ('4', '2');
insert into songgenre (song, genre) values ('4', '4');
insert into songgenre (song, genre) values ('5', '5');
insert into songgenre (song, genre) values ('7', '2');
insert into songgenre (song, genre) values ('8', '2');
insert into songgenre (song, genre) values ('9', '2');
insert into songgenre (song, genre) values ('9', '4');
insert into songgenre (song, genre) values ('10', '3');
insert into songgenre (song, genre) values ('11', '2');

-- insert data in lyrics

insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('1', 'Beat It', '1', 
'Beat It
They told him, "Dont you ever come around here.
Dont wanna see your face. You better disappear."
The fires in their eyes and their words are really clear
So beat it, just beat it

You better run, you better do what you can
Dont wanna see no blood, dont be a macho man
You wanna be tough, better do what you can
So beat it, but you wanna be bad

[Chorus]
Just beat it, beat it, beat it, beat it
No one wants to be defeated
Showin how funky strong is your fight
It doesnt matter whos wrong or right

Just beat it, beat it [4x]

Theyre out to get you, better leave while you can
Dont wanna be a boy, you wanna be a man
You wanna stay alive, better do what you can
So beat it, just beat it

You have to show them that youre really not scared
You are playin wid your life, this aint no truth or dare
Theyll kick you, then they beat you, then theyll tell you its fair
So beat it, but you wanna be bad

[Chorus 2x]
Just beat it, beat it, beat it, beat it
No one wants to be defeated
Showin how funky strong is your fight
It doesnt matter whos wrong or right

Just beat it, beat it, beat it, beat it, beat it

Beat it, beat it, beat it, beat it
No one wants to be defeated
Showin how funky strong is your fight
It doesnt matter whos wrong or right

[Chorus 3x]
Just beat it, beat it, beat it, beat it
No one wants to be defeated
Showin how funky strong is your fight
It doesnt matter whos wrong or right

Just beat it, beat it
Beat it, beat it, beat it', '1');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('2', 'Dangerous', '2', 
'Dangerous
The Way She Came Into The Place
I Knew Right Then And There
There Was Something Different
About This Girl

The Way She Moved
Her Hair, Her Face, Her Lines
Divinity In Motion

As She Stalked The Room
I Could Feel The Aura
Of Her Presence
Every Head Turned
Feeling Passion And Lust

The Girl Was Persuasive
The Girl I Could Not Trust
The Girl Was Bad
The Girl Was Dangerous

I Never Knew But I Was
Walking The Line
Come Go With Me
I Said I Have No Time
And Dont You Pretend We Didnt
Talk On The Phone
My Baby Cried
She Left Me Standing Alone

Shes So Dangerous
The Girl Is So Dangerous
Take Away My Money
Throw Away My Time
You Can Call Me Honey
But Youre No Damn Good For Me

She Came At Me In Sections
With The Eyes Of Desire
I Fell Trapped Into Her
Web Of Sin
A Touch, A Kiss
A Whisper Of Love
I Was At The Point
Of No Return

Deep In The Darkness Of
Passions Insanity
I Felt Taken By Lusts
Strange Inhumanity
This Girl Was Persuasive
This Girl I Could Not Trust
The Girl Was Bad
The Girl Was Dangerous

I Never Knew
But I Was Living In Vain
She Called My House
She Said You Know My Name
And Dont You Pretend
You Never Did Me Before
With Tears In Her Eyes
My Baby Walked Out The Door

Shes So Dangerous
The Girl Is So Dangerous
Take Away My Money
Throw Away My Time
You Can Call Me Honey
But Youre No Damn Good For Me

Dangerous
The Girl Is So Dangerous
I Have To Pray To God
Cause I Know How
Lust Can Blind
Its A Passion In My Soul
But Youre No Damn Lover
Friend Of Mine

I Can not Sleep Alone Tonight
My Baby Left Me Here Tonight
I Cannot Cope Til Its All Right
You And Your Manipulation
You Hurt My Baby

And Then It Happened
She Touched Me
For The Lips Of
A Strange Woman
Drop As A Honeycomb
And Her Mouth Was
Smoother Than Oil
But Her Inner Spirit And Words
Were As Sharp As
A Two-Edged Sword
But I Loved It
Cause Its Dangerous

Dangerous
The Girl Is So Dangerous
Take Away My Money
Throw Away My Time
You Can Call Me Honey
But Youre No Damn Good For Me

Dangerous
The Girl Is So Dangerous
Take Away My Money
Throw Away My Time
You Can Call Me Honey
But Youre No Damn Good For Me

Dangerous
The Girl Is So Dangerous
Take Away My Money
Throw Away My Time
You Can Call Me Honey
But Youre No Damn Good For Me

Dangerous
The Girl Is So Dangerous
I Have To Pray To God
Cause I Know How
Lust Can Blind
Its A Passion In My Soul
But Youre No Damn Lover
Friend Of Mine
[Ad Libs Out]', '2');

insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('3', 'Roop Tera Mastana', '3', 
'Roop Tera Mastana

Roop Tera Mastana Pyaar Mera Deewana
Roop Tera Mastana Pyaar Mera Deewana
Bhool Koi Hamse Na Ho Jaye
Roop Tera Mastana Pyar Mera Deewana
Bhool Koi Hamse Na Ho Jaye

Raat Nasheeli Mast Sama Hai
Aaj Nashe Mein Saara Jahan Hai
Raat Nasheeli Mast Sama Hai
Aaj Nashe Mein Saara Jahan Hai
Haan Ye Sharabi Mausam Behkaye
Roop Tera Mastana Pyaar Mera Deewana
Bhool Koi Hamse Na Ho Jaaye

Ankhon Se Ankhen Milti Hai Aise
Bechain Hoke Toofan Mein Jaise
Ankhon Se Ankhen Milti Hai Aise
Bechain Hoke Toofan Mein Jaise
Mauj Koi Saahil Se Takraaye
Roop Tera Mastana Pyaar Mera Diwana
Bhool Koi Hamse Na Ho Jaaye

Rok Raha Hai Ham Ko Zamana
Door Hi Rehena Paas Na Aana
Rok Raha Hai Ham Ko Zamana
Door Hi Rehena Paas Na Aana
Kaise Magar Koi Dil Ko Samjhaaye
Roop Tera Mastana Pyaar Mera Diwana
Bhool Koi Hamse Na Ho Jaaye

', '3');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('4', 'Roop Tera Mastana English', '2', 'Copyright Issues - song lyrics is unavialable sorry!', '3');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('5', 'Rimjhim Gire Savan', '4', 
' Rimjhim Gire Savan
 Hmmmmmm.......
 Rimjhim gire sawan, sulag sulag jaaye mann
 Bhige aaj iss mausam me, lagee kaisee yeh agan
 
 Rimjhim gire sawan, sulag sulag jaaye mann
 Bhige aaj iss mausam me, lagee kaisee yeh agan
 Rimjhim gire sawan
 
 (Jab ghunghru see bajatee hain bunde
 Armaan hamare palke na munde) - (2)
 Kaise dekhe sapne nayan, sulag sulag jaaye mann
 Bhige aaj iss mausam me, lagee kaisee yeh agan
 Rimjhim gire sawan
 
 (Mehfil me kaise keh de kisi se
 Dil bandh raha hai kis ajnabee se) - (2)
 Haye kare abb kya jatan, sulag sulag jaye mann
 Bhige aaj iss mausam me, lagee kaisee yeh agan
 Rimjhim gire sawan, sulag sulag jaye mann
 Bhige aaj iss mausam me, lagee kaisee yeh agan
 Rimjhim gire sawan', '4');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('6', 'Lean On', '5', 
'LeanOn
Do you recall, not long ago
We would walk on the sidewalk
Innocent, remember?
All we did was care for each other

But the night was warm
We were bold and young
All around the wind blows
We would only hold on to let go

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

What will we do when we get old?
Will we walk down the same road?
Will you be there by my side?
Standing strong as the waves roll over1

When the nights are long
Longing for you to come home
All around the wind blows
We would only hold on to let go

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

All we need is somebody to lean on
All we need is somebody to lean on

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on', '5');

insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('7', 'Lean On', '5', 
'Lean On
Do you recall, not long ago
We would walk on the sidewalk
Innocent, remember?
All we did was care for each other

But the night was warm
We were bold and young
All around the wind blows
We would only hold on to let go

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

What will we do when we get old?
Will we walk down the same road?
Will you be there by my side?
Standing strong as the waves roll over1

When the nights are long
Longing for you to come home
All around the wind blows
We would only hold on to let go

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

All we need is somebody to lean on
All we need is somebody to lean on

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on

Blow a kiss, fire a gun
We need someone to lean on
Blow a kiss, fire a gun
All we need is somebody to lean on', '6');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('8', 'Sky Fall', '6', 
'SkyFall

This is the end
Hold your breath and count to ten
Feel the earth move and then
Hear my heart burst again

For this is the end
I have drowned and dreamt this moment
So overdue I owe them
Swept away, I m stolen

Let the sky fall
When it crumbles
We will stand tall
Face it all together

Let the sky fall
When it crumbles
We will stand tall
Face it all together
At skyfall
That skyfall

Skyfall is where we start
A thousand miles and poles apart
Where worlds collide and days are dark
You may have my number, you can take my name
But you will never have my heart

Let the sky fall (let the sky fall)
When it crumbles (when it crumbles)
We will stand tall (we will stand tall)
Face it all together

Let the sky fall (let the sky fall)
When it crumbles (when it crumbles)
We will stand tall (we will stand tall)
Face it all together
At skyfall

[x2:]
(Let the sky fall
When it crumbles
We will stand tall)

Where you go I go
What you see I see
I know I d never be me
Without the security
Of your loving arms
Keeping me from harm
Put your hand in my hand
And we will stand

Let the sky fall (let the sky fall)
When it crumbles (when it crumbles)
We will stand tall (we will stand tall)
Face it all together

Let the sky fall (let the sky fall)
When it crumbles (when it crumbles)
We will stand tall (we will stand tall)
Face it all together
At skyfall

Let the sky fall
We will stand tall
At skyfall
Oh-s...', '7');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('9', 'Hero', '7', 
'Hero

Let me be your hero

Would you dance if I asked you to dance?
Would you run and never look back?
Would you cry if you saw me crying?
Would you save my soul tonight?

Would you tremble if I touched your lips?
Would you laugh? Oh, please tell me this.
Now would you die for the one you love?
Hold me in your arms, tonight.

I can be your hero, baby.
I can kiss away the pain.
I will stand by you forever.
You can take my breath away.

Would you swear that you will always be mine?
Would you lie? Would you run and hide?
Am I in too deep? Have I lost my mind?
I don t care. You are here tonight.

I can be your hero, baby.
I can kiss away the pain.
I will stand by you forever.
You can take my breath away.

Oh, I just want to hold you.
I just want to hold you, oh, yeah.

Am I in too deep? Have I lost my mind?
Well, I dont care. You are here tonight.

I can be your hero, baby.
I can kiss away the pain, oh, yeah.
I will stand by you forever.
You can take my breath away.

I can be your hero.
I can kiss away the pain.
And I will stand by you forever.
You can take my breath away.
You can take my breath away.

I can be your hero.', '8');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('10', 'Rock My World', '6', 
'Rock My World

Ho, oh

My life will never be the same
Cause girl, you came and changed
The way I walk
The way I talk

I cannot explain the things I feel for you
But girl, you know its true
Stay with me, fulfill my dreams
And I will be all you will need

Oh, oh, oh, oh, ooh, it feels so right (Girl)
I have searched for the perfect love all my life (All my life)
Oh, oh, oh, oh, ooh, it feels like I (Like I)
Have finally found her perfect love is mine
(See, I finally found, come on, girl)

You rocked my world, you know you did
And everything I own I give (You rocked my world)
The rarest love who would think I would find
Someone like you to come by (You rocked my world)

You rocked my world, you know you did (Girl)
And everything I own I give (I want you, girl)
The rarest love who would think I would find
Someone like you to call mine

In time I knew that love would bring
This happiness to me
I tried to keep my sanity
I waited patiently

Girl, you know it seems
My life is so complete
A love thats true because of you
Keep doing what you do

Oh, oh, oh, oh, who would think that I (Oh)
Have finally found the perfect love I searched for all
my life (Searched for all my life)
Oh, oh, oh, oh, who would d think I would find
(Whoa, oh, oh)
Such a perfect love thats so right (Whoa, girl)

You rocked my world, you know you did
(Come on, come on, come on, come on)
And everything I own I give
The rarest love who d think I d find (Girl)
Someone like you to call mine (You rocked my world)

You rocked my world (You rocked my world),
you know you did
And everything I own I give (Girl, girl, girl)
The rarest love who would think I would find
Someone like you to call mine (Girl)

You rocked my world, you know you did (Oh)
And everything I own I give (You rocked my world)
The rarest love who would think I would find
Someone like you to call mine

You rocked my world (Oh...), you know you did
And everything I own I give (To rock my world)
The rarest love who d think I d find
Someone like you to call mine

Girl, I know that this is love
I felt the magic all in the air
And girl, I will never get enough
That s why I always have to have you here, hoo

You rocked my world (You rocked my world),
you know you did
And everything I own I give
(Look what you did to me, baby, yeah)
The rarest love who d think I d find
Someone like you to call mine (You rocked my world)

You rocked my world, you know you did
(Know you did, baby)
And everything I own I give
( Cause you rocked my world)
The rarest love who d think I d find (Hoo, hoo)
Someone like you to call mine

You rocked my world, you know you did
(The way you talk to me, the way you are lovin me)
(The way you give it to me)

You rocked my world, you know you did
(Give it to me)
(Yeah, yeah, yeah...yeah...ooh)
You rocked my world (You rocked my world),
you know you did
(You rocked my world, you rocked my world)

,
you know you did
(Baby, baby, baby)
And everything I own I give
The rarest love who d think I d find
Someone like you to call mine

You rocked my world, you know you did
And everything I own I give
The rarest love who d think I d find
Someone like you to call mine', '9');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('11', 'I Will Always Love You', '5', 
'I Will Always Love You

If I should stay
Well, I would only be in your way
And so I will go, and yet I know
That I will think of you each step of my way
And I will always love you
I will always love you
Bitter-sweet memories
Thats all I have, and all I am taking with me
Good-bye, oh, please dont cry
Cause we both know that I am not
What you need
But I will always love you
I will always love you

And I hope life, will treat you kind
And I hope that you have all
That you ever dreamed of
Oh, I do wish you joy
And I wish you happiness
But above all this
I wish you love
I love you, I will always love

I will always, always love you
I will always love you
I will always love you
I will always love you', '10');


insert into lyrics (lyrics_id, title, contributor, lyrics, song)
values ('12', 'Bailamose', '4', 
'Bailamose

Esta noche bailamos
Te doy toda mi vida
Quedate conmigo

Tonight we dance
I lay my life in your hands
We take the floor
Nothing is forbidden anymore

Dont let the world in outside
Dont let a moment go by
Nothing can stop us tonight!

Bailamos! Let the rhythm take you over
Bailamos! Te quiero amor mio
Bailamos! Gonna live this night forever
Bailamos! Te quiero amor mio, te quiero!

Tonight I am yours
We can make it happen I am so sure
Now I am letting go
There is something I think you should know

I wont be leaving your side
We are gonna dance through the night
I am gonna reach for the stars

Bailamos! Let the rhythm take you over
Bailamos! Te quiero amor mio
Bailamos! Gonna live this night forever
Bailamos! Te quiero amor mio, te quiero!

Tonight we dance
(Whoa!)
Like no tomorrow
(Whoa!)
If you will stay with me
Te quiero, mi amor

Quedate conmigo
Esta noche
Quedate mi cielo

Bailamos! Let the rhythm take you over
Bailamos! Te quiero amor mio
Bailamos! Gonna live this night forever
Bailamos! Te quiero amor mio

Bailamos! Let the rhythm take you over
(Como te quiero, como te quiero)
Bailamos! Te quiero amor mio
(Como te quiero, como te quiero)
Bailamos! Gonna live this night forever
(Como te quiero, como te quiero)
Bailamos! Te quiero amor mio, te quiero
(Como te quiero, como te quiero)', '11');


 -- insert into playlist
insert into playlist (play_list_name, owner) values ('BinniePlaylist', '1');
insert into playlist (play_list_name, owner) values ('MiniPlaylist', '2');
insert into playlist (play_list_name, owner) values ('MayankPlaylist', '3');
insert into playlist (play_list_name, owner) values ('MayurPlaylist', '4');
insert into playlist (play_list_name, owner) values ('DikshaPlaylist', '5');
insert into playlist (play_list_name, owner) values ('AdminPlaylist', '6');
insert into playlist (play_list_name, owner) values ('RanveerPlaylist', '7');


-- insert into 



-- insert into songPlaylist

insert into songplaylist (playlist_id, song_id) values ('1', '1');
insert into songplaylist (playlist_id, song_id) values ('1', '4');
insert into songplaylist (playlist_id, song_id) values ('1', '10');



insert into songplaylist (playlist_id, song_id) values ('2', '9');
insert into songplaylist (playlist_id, song_id) values ('2', '3');
insert into songplaylist (playlist_id, song_id) values ('2', '6');
insert into songplaylist (playlist_id, song_id) values ('2', '2');
insert into songplaylist (playlist_id, song_id) values ('2', '10');


insert into songplaylist (playlist_id, song_id) values ('3', '10');
insert into songplaylist (playlist_id, song_id) values ('3', '12');
insert into songplaylist (playlist_id, song_id) values ('3', '8');
insert into songplaylist (playlist_id, song_id) values ('3', '9');

insert into songplaylist (playlist_id, song_id) values ('4', '1');
insert into songplaylist (playlist_id, song_id) values ('4', '3');
insert into songplaylist (playlist_id, song_id) values ('4', '6');

insert into songplaylist (playlist_id, song_id) values ('5', '8');

insert into songplaylist (playlist_id, song_id) values ('6', '10');
insert into songplaylist (playlist_id, song_id) values ('6', '9');

insert into songplaylist (playlist_id, song_id) values ('7', '4');


-- insert into review
insert into review (user_id, song_id, star_rating, user_comment) 
values ('1', '2', '5', 'Fantastic');

insert into review (user_id, song_id, star_rating, user_comment) 
values ('2', '1', '4', 'Its mood refereshingg!!!');

insert into review (user_id, song_id, star_rating, user_comment) 
values ('7', '9', '5', 'I Will Alwaysss loveeee youuuuuuuuuu Whitneyy!!! :* :* ');

insert into review (user_id, song_id, star_rating, user_comment) 
values ('2', '4', '5', 'Awesomeee songg!! Kishorr Da is a legend :D');

commit;
