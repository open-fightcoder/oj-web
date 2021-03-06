CREATE TABLE `problem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '题目提供者',
  `difficulty` varchar(40) NOT NULL DEFAULT '' COMMENT '题目难度',
  `case_data` varchar(200) NOT NULL DEFAULT '' COMMENT '测试数据',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '题目标题',
  `description` varchar(7000) NOT NULL DEFAULT '' COMMENT '题目描述',
  `input_des` varchar(2500) NOT NULL DEFAULT '' COMMENT '输入描述',
  `output_des` varchar(2000) NOT NULL DEFAULT '' COMMENT '输出描述',
  `input_case` varchar(2000) NOT NULL DEFAULT '' COMMENT '测试输入',
  `output_case` varchar(2000) NOT NULL DEFAULT '' COMMENT '测试输出',
  `hint` varchar(3000) DEFAULT NULL COMMENT '题目提示(可以为对样例输入输出的解释)',
  `time_limit` int(11) NOT NULL DEFAULT '0' COMMENT '时间限制',
  `memory_limit` int(11) NOT NULL DEFAULT '0' COMMENT '内存限制',
  `tag` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '题目标签',
  `is_special_judge` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否特判 1-特判 2-非特判',
  `special_judge_source` varchar(100) DEFAULT NULL COMMENT '特判程序源代码',
  `special_judge_type` varchar(20) NOT NULL DEFAULT '' COMMENT '特判程序源代码类型',
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT '标准程序',
  `language_limit` varchar(100) DEFAULT NULL COMMENT '语言限制',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_difficulty` (`difficulty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `problem_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '题目拥有者',
  `status` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '题目申请状态',
  `real_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '所在真实题库的Id',
  `difficulty` varchar(40) NOT NULL DEFAULT '' COMMENT '题目难度',
  `case_data` varchar(200) NOT NULL DEFAULT '' COMMENT '测试数据',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '题目标题',
  `description` varchar(7000) NOT NULL DEFAULT '' COMMENT '题目描述',
  `input_des` varchar(2500) NOT NULL DEFAULT '' COMMENT '输入描述',
  `output_des` varchar(2000) NOT NULL DEFAULT '' COMMENT '输出描述',
  `input_case` varchar(2000) NOT NULL DEFAULT '' COMMENT '测试输入',
  `output_case` varchar(2000) NOT NULL DEFAULT '' COMMENT '测试输出',
  `hint` varchar(3000) DEFAULT NULL COMMENT '题目提示(可以为对样例输入输出的解释)',
  `time_limit` int(11) NOT NULL DEFAULT '0' COMMENT '时间限制',
  `memory_limit` int(11) NOT NULL DEFAULT '0' COMMENT '内存限制',
  `tag` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '题目标签',
  `is_special_judge` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否特判 1-特判 2-非特判',
  `special_judge_source` varchar(100) DEFAULT NULL COMMENT '特判程序源代码',
  `special_judge_type` varchar(20) NOT NULL DEFAULT '' COMMENT '特判程序源代码类型',
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT '标准程序',
  `language_limit` varchar(100) DEFAULT NULL COMMENT '语言限制',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_code` (
	`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`problem_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
	`user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
	`save_code` varchar(1000) NOT NULL DEFAULT '' COMMENT '保存代码',
	`language` varchar(50) NOT NULL DEFAULT '' COMMENT '代码语言',
	PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user` (`user_id`,`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_collection` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `problem_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
    `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_collection` (`user_id`,`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sys_config` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `sys_key` varchar(100) NOT NULL DEFAULT '' COMMENT '键',
    `sys_value` varchar(100) NOT NULL DEFAULT '' COMMENT '值',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_sys_key` (`sys_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `password` varchar(80) NOT NULL COMMENT '密码',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `qq_id` varchar(40) DEFAULT NULL COMMENT '用于QQ第三方登录',
  `github_id` varchar(40) DEFAULT NULL COMMENT '用于GITHUB第三方登录',
  `weichat_id` varchar(40) DEFAULT NULL COMMENT '用于微信第三方登录',
  PRIMARY KEY (`id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account_id` bigint(20) NOT NULL COMMENT '账号Id',
  `user_name` varchar(20) NOT NULL COMMENT '用户名',
  `nick_name` varchar(40) NOT NULL COMMENT '昵称',
  `sex` varchar(30) NOT NULL DEFAULT '' COMMENT '性别',
  `avator` varchar(100) NOT NULL DEFAULT '' COMMENT '头像',
  `blog` varchar(100) NOT NULL DEFAULT '' COMMENT '博客地址',
  `git` varchar(100) NOT NULL DEFAULT '' COMMENT 'Git地址',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '个人描述',
  `birthday` varchar(80) NOT NULL DEFAULT '' COMMENT '生日',
  `daily_address` varchar(100) NOT NULL DEFAULT '' COMMENT '日常所在地：省、市',
  `stat_school` varchar(60) NOT NULL DEFAULT '' COMMENT '当前就学状态(小学及以下、中学学生、大学学生、非在校生)',
  `school_name` varchar(100) NOT NULL DEFAULT '' COMMENT '学校名称',
  PRIMARY KEY (`id`),
  KEY `idx_account_id` (`account_id`),
  UNIQUE KEY `uniq_user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `submit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `problem_id` bigint(20) NOT NULL COMMENT '题目ID',
  `user_id` bigint(20) NOT NULL COMMENT '提交用户ID',
  `language` varchar(20) NOT NULL COMMENT '提交语言',
  `submit_time` bigint(20) NOT NULL COMMENT '提交时间',
  `running_time` int(11) DEFAULT NULL COMMENT '耗时(ms)',
  `running_memory` int(11) DEFAULT NULL COMMENT '所占空间',
  `result` int(11) DEFAULT NULL COMMENT '运行结果',
  `result_des` varchar(1000) DEFAULT NULL COMMENT '结果描述',
  `code` varchar(200) NOT NULL COMMENT '提交代码',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `result` (`result`),
  KEY `problem_id` (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `submit_test` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '提交用户ID',
  `language` varchar(20) NOT NULL COMMENT '提交语言',
  `submit_time` bigint(20) NOT NULL COMMENT '提交时间',
  `running_time` int(11) DEFAULT NULL COMMENT '耗时(ms)',
  `running_memory` int(11) DEFAULT NULL COMMENT '所占空间',
  `result` int(11) DEFAULT NULL COMMENT '运行状态',
  `input` varchar(300) DEFAULT NULL COMMENT '输入',
  `result_des` varchar(1000) DEFAULT NULL COMMENT '结果',
  `code` varchar(200) NOT NULL COMMENT '提交代码',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `result` (`result`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_count` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '提交用户ID',
  `rank_num` int(11) DEFAULT NULL COMMENT '排名',
  `submit_num` int(11) DEFAULT NULL COMMENT '提交数',
  `date_time` varchar(50) NOT NULL DEFAULT '' COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  UNIQUE KEY `uniq_user` (`user_id`,`date_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `team` (
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT COMMENT '团队ID',
  `uid` BIGINT(20) NOT NULL COMMENT '组长ID',
  `name` VARCHAR(50) NOT NULL COMMENT '团队名称',
  `description` VARCHAR(200) NOT NULL COMMENT '团队描述',
  `avator`VARCHAR(50) NOT NULL COMMENT '团队头像',
  UNIQUE KEY `name` (`name`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `team_member` (
  `id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
  `uid` BIGINT(20) NOT NULL COMMENT '用户ID',
  `gid` BIGINT(20) NOT NULL COMMENT '团队ID',
  `stat` INTEGER NOT NULL COMMENT  '状态'
)ENGINE=InnoDB DEFAULT CHARSET =utf8;
