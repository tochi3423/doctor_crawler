CREATE TABLE `doctors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '医師の名前',
  `certification` varchar(100) DEFAULT NULL COMMENT '医師が持っている資格',
  `major` varchar(100) DEFAULT NULL  COMMENT '専攻',
  `url` varchar(100) DEFAULT NULL COMMENT '詳細url',
  `department` varchar(100) DEFAULT NULL COMMENT '診療科',
  `time_table` varchar(100) DEFAULT NULL COMMENT '診療時間、担当時間',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;