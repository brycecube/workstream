DROP TABLE IF EXISTS `routine`;
CREATE TABLE `routine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX(`user_id`)
);

INSERT INTO `routine` VALUES (1,1,'Legs','Bros don\'t let bros skip leg day');
INSERT INTO `routine` VALUES (2,2,'Biceps','Curls for the girls');


DROP TABLE IF EXISTS `routine_exercise`;
CREATE TABLE `routine_exercise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `routine_id` int(11) NOT NULL DEFAULT '0',
  `exercise_id` int(11) DEFAULT '0',
  `name` varchar(255) NOT NULL default '',
  `sort` int(5) DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX(`routine_id`),
  INDEX(`name`),
  INDEX(`sort`)
);

INSERT INTO `routine_exercise` VALUES (1,1,0,'Pull Ups',1),(2,1,0,'Bench Press',2);
INSERT INTO `routine_exercise` VALUES (3,2,0,'Pull Ups',1),(4,2,0,'Bench Press',2);


