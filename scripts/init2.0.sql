alter user 'root'@'%' identified with mysql_native_password by '123456';
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

DROP DATABASE IF EXISTS oidc;
CREATE DATABASE oidc;
-- SHOW DATABASES;
USE oidc;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
# 转储表 admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_log`;

CREATE TABLE `admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ua` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `userId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `requestId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `admin_log_userId_fkey` (`userId`),
  CONSTRAINT `admin_log_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



# 转储表 admin_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_menu`;

CREATE TABLE `admin_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `icon` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `sort` int NOT NULL,
  `level` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `parentId` int DEFAULT NULL,
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `updatedAt` datetime NOT NULL,
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `schema` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `visibleInMenu` tinyint(1) NOT NULL DEFAULT '1',
  `apis` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `admin_menu` WRITE;
/*!40000 ALTER TABLE `admin_menu` DISABLE KEYS */;

INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`)
VALUES
	(7,'系统管理','/system','https://icons.fireboom.io/tabler/icons/settings-2.svg',0,1,'2023-12-25 13:01:23',NULL,NULL,'M','2024-02-20 03:07:29',NULL,NULL,1,NULL),
	(8,'用户管理','/system/user','https://icons.fireboom.io/tabler/icons/user-bolt.svg',1,1,'2023-12-25 13:01:55',7,NULL,'C','2024-01-03 07:33:13',NULL,NULL,1,NULL),
	(9,'角色管理','/system/role','https://icons.fireboom.io/tabler/icons/password-user.svg',2,1,'2023-12-25 13:02:21',7,NULL,'C','2024-01-03 07:34:54',NULL,NULL,1,NULL),
	(14,'菜单管理','/system/menu','https://icons.fireboom.io/tabler/icons/menu-2.svg',3,1,'2023-12-26 03:34:36',7,'','C','2024-01-03 07:34:21',NULL,NULL,1,NULL),
	(15,'日志管理','/system/log','https://icons.fireboom.io/tabler/icons/file-alert.svg',4,1,'2023-12-26 03:34:54',7,'','C','2024-01-03 07:34:00',NULL,NULL,1,NULL),
	(17,'文章管理','/post','https://icons.fireboom.io/tabler/icons/accessible.svg',5,1,'2023-12-28 07:48:07',0,'','C','2024-02-20 09:24:26',NULL,'',1,NULL),
	(37,'文章标签','/post/category','https://icons.fireboom.io/tabler/icons/address-book.svg',1,2,'2024-02-20 09:35:47',17,'','C','2024-03-04 11:02:21',NULL,'{\"id\":\"u:feefc6dd354c\",\"body\":[{\"id\":\"u:a237afa99a98\",\"type\":\"crud\",\"mode\":\"table\",\"dsType\":\"api\",\"syncLocation\":true,\"primaryField\":\"id\",\"loadType\":\"pagination\",\"api\":{\"url\":\"/operations/post/category/findMany\",\"method\":\"get\"},\"quickSaveItemApi\":{\"url\":\"/operations/post/category/updateOne\",\"method\":\"post\",\"requestAdaptor\":\"\",\"adaptor\":\"\",\"messages\":{}},\"filter\":{\"type\":\"form\",\"title\":\"条件查询\",\"mode\":\"inline\",\"columnCount\":3,\"clearValueOnHidden\":true,\"behavior\":[\"SimpleQuery\"],\"body\":[{\"name\":\"name\",\"label\":\"标签名\",\"type\":\"input-text\",\"size\":\"full\",\"required\":false,\"behavior\":\"SimpleQuery\",\"id\":\"u:c116579516f6\",\"clearable\":true}],\"actions\":[{\"type\":\"button\",\"label\":\"清空\",\"actionType\":\"clear\",\"id\":\"u:aed42568fc96\"},{\"type\":\"submit\",\"label\":\"查询\",\"level\":\"primary\",\"id\":\"u:e0542a500396\"}],\"id\":\"u:4c45289c57c4\",\"feat\":\"Insert\",\"target\":\"my_crud\"},\"headerToolbar\":[{\"label\":\"新增\",\"type\":\"button\",\"actionType\":\"dialog\",\"level\":\"primary\",\"editorSetting\":{\"behavior\":\"create\"},\"dialog\":{\"title\":\"新增\",\"body\":[{\"type\":\"form\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/category/createOne\",\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"}},\"body\":[{\"type\":\"input-text\",\"name\":\"name\",\"label\":\"标题\",\"id\":\"u:d1ac8ca5cfce\",\"editorState\":\"default\",\"placeholder\":\"请输入标签名\"}],\"actions\":[{\"type\":\"submit\",\"label\":\"提交\",\"primary\":true}],\"feat\":\"Insert\"}],\"type\":\"dialog\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true}],\"showCloseButton\":true,\"closeOnOutside\":false,\"closeOnEsc\":false,\"showErrorMsg\":true,\"showLoading\":true,\"draggable\":false,\"size\":\"lg\"},\"id\":\"u:70a5e45e221b\"},{\"type\":\"bulk-actions\"}],\"footerToolbar\":[{\"type\":\"pagination\",\"align\":\"right\"},{\"type\":\"switch-per-page\",\"align\":\"right\",\"tpl\":\"内容\",\"wrapperComponent\":\"\",\"id\":\"u:84c24ecffedc\"},{\"type\":\"statistics\",\"align\":\"right\"}],\"filterTogglable\":false,\"name\":\"my_crud\",\"loadDataOnceFetchOnFilter\":true,\"bulkActions\":[],\"editorSetting\":{\"mock\":{\"enable\":true,\"maxDisplayRows\":5}},\"perPageAvailable\":[10],\"messages\":{},\"columns\":[{\"type\":\"tpl\",\"title\":\"id\",\"name\":\"id\",\"id\":\"u:a40687ad9a91\",\"label\":\"ID\"},{\"type\":\"tpl\",\"title\":\"标签名\",\"name\":\"name\",\"id\":\"u:24128b8d06a4\",\"label\":\"标签名\"},{\"type\":\"text\",\"label\":\"描述\",\"name\":\"description\",\"id\":\"u:fcd51c793335\"},{\"type\":\"text\",\"label\":\"文章数\",\"name\":\"postCount\",\"id\":\"u:c82119537282\"},{\"type\":\"date\",\"title\":\"创建时间\",\"name\":\"createdAt\",\"id\":\"u:8d4ba32906a3\",\"label\":\"创建时间\"},{\"type\":\"date\",\"title\":\"更新时间\",\"name\":\"updatedAt\",\"id\":\"u:aec90d9c4399\",\"label\":\"更新时间\"},{\"type\":\"operation\",\"title\":\"操作\",\"buttons\":[{\"type\":\"button\",\"label\":\"编辑\",\"level\":\"link\",\"behavior\":\"Edit\",\"onEvent\":{\"click\":{\"actions\":[{\"actionType\":\"dialog\",\"dialog\":{\"body\":{\"id\":\"u:b4f57a447fc6\",\"type\":\"form\",\"title\":\"编辑数据\",\"mode\":\"horizontal\",\"dsType\":\"api\",\"feat\":\"Edit\",\"body\":[{\"name\":\"id\",\"label\":\"id\",\"type\":\"hidden\"},{\"name\":\"name\",\"label\":\"标签名\",\"type\":\"input-text\"},{\"name\":\"description\",\"label\":\"描述\",\"type\":\"input-text\"}],\"api\":{\"url\":\"/operations/post/category/updateOne\",\"method\":\"post\",\"requestAdaptor\":\"\",\"adaptor\":\"\",\"messages\":{}},\"resetAfterSubmit\":true,\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\"},{\"type\":\"button\",\"actionType\":\"submit\",\"label\":\"提交\",\"level\":\"primary\"}],\"onEvent\":{\"submitSucc\":{\"actions\":[{\"actionType\":\"search\",\"groupType\":\"component\",\"componentId\":\"u:ec97cef72880\"}]}}},\"title\":\"编辑数据\",\"size\":\"md\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\"},{\"type\":\"button\",\"actionType\":\"submit\",\"label\":\"提交\",\"level\":\"primary\"}]}}]}},\"id\":\"u:89c2133ca624\"},{\"type\":\"button\",\"label\":\"删除\",\"actionType\":\"ajax\",\"level\":\"danger\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/category/deleteMany\",\"data\":{\"ids\":[\"${id}\"]}},\"onEvent\":{\"click\":{\"actions\":[{\"actionType\":\"confirmDialog\",\"ignoreError\":false,\"dialog\":{\"type\":\"dialog\",\"title\":\"提示\",\"body\":[{\"type\":\"tpl\",\"tpl\":\"确认删除该条数据吗?\",\"wrapperComponent\":\"\",\"inline\":false}],\"dialogType\":\"confirm\",\"confirmText\":\"确认\",\"cancelText\":\"取消\",\"confirmBtnLevel\":\"primary\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true}]}}],\"weight\":0}},\"id\":\"u:aa2a1d54b163\"}],\"id\":\"u:442d4b7623e7\"}]}],\"type\":\"page\"}',1,NULL),
	(38,'文章列表','/post/list','https://icons.fireboom.io/tabler/icons/article.svg',1,2,'2024-02-20 09:38:19',17,'','C','2024-03-04 11:04:31',NULL,'{\"id\":\"u:0bbab368e4fb\",\"body\":[{\"type\":\"crud\",\"syncLocation\":false,\"api\":{\"method\":\"get\",\"url\":\"/operations/post/findMany\",\"messages\":{},\"requestAdaptor\":\"\",\"adaptor\":\"\"},\"bulkActions\":[{\"type\":\"button\",\"level\":\"danger\",\"label\":\"批量删除\",\"actionType\":\"ajax\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/deleteMany\",\"data\":{\"ids\":\"${ARRAYMAP(SPLIT(ids, \'\',\'\'), id => INT(id))}\"}},\"id\":\"u:8c0b892cc533\",\"onEvent\":{\"click\":{\"weight\":0,\"actions\":[{\"ignoreError\":false,\"actionType\":\"confirmDialog\",\"dialog\":{\"type\":\"dialog\",\"title\":\"提示\",\"body\":[{\"type\":\"tpl\",\"tpl\":\"确认删除该条数据吗？\",\"wrapperComponent\":\"\",\"inline\":false,\"id\":\"u:d0002cda8d4e\"}],\"dialogType\":\"confirm\",\"confirmText\":\"确认\",\"cancelText\":\"取消\",\"confirmBtnLevel\":\"primary\",\"id\":\"u:7fd99a28fe5d\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true}]}}]}}},{\"label\":\"批量导出\",\"type\":\"button\",\"id\":\"u:3d973ff8912c\",\"onEvent\":{\"click\":{\"weight\":0,\"actions\":[{\"ignoreError\":false,\"actionType\":\"ajax\",\"outputVar\":\"responseResult\",\"options\":{},\"api\":{\"url\":\"/export\",\"method\":\"get\"}}]}}}],\"itemActions\":[],\"headerToolbar\":[{\"type\":\"button\",\"id\":\"u:3b052f60aa74\",\"label\":\"新增\",\"actionType\":\"dialog\",\"level\":\"primary\",\"editorSetting\":{\"behavior\":\"create\"},\"dialog\":{\"title\":\"新增文章\",\"body\":[{\"type\":\"form\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/createOne\",\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"}},\"body\":[{\"type\":\"input-text\",\"name\":\"title\",\"label\":\"标题\",\"id\":\"u:9bb7dbdab61a\",\"editorState\":\"default\",\"placeholder\":\"请输入标题\"},{\"type\":\"select\",\"label\":\"标签\",\"name\":\"categoryId\",\"id\":\"u:0d9fae1849d7\",\"multiple\":false,\"source\":{\"url\":\"/operations/post/category/findMany\",\"method\":\"get\"},\"labelField\":\"name\",\"valueField\":\"id\"},{\"type\":\"select\",\"label\":\"作者\",\"name\":\"authorId\",\"id\":\"u:5fa432625757\",\"multiple\":false,\"source\":{\"url\":\"/operations/post/author/findMany\",\"method\":\"get\"},\"labelField\":\"name\",\"valueField\":\"id\"},{\"type\":\"input-image\",\"label\":\"封面图\",\"name\":\"poster\",\"id\":\"u:98e72a8aa88e\",\"receiver\":{\"url\":\"/s3/tengxunyun/upload?directory=article&wg_api_hash=d41d8cd9\",\"method\":\"post\",\"requestAdaptor\":\"\",\"adaptor\":\"return {\'status\': 0,\'msg\': \'\',\'data\': {value: \'https://cos.ap-nanjing.myqcloud.com/test-1314985928/\' + response.data[0].key}}\",\"messages\":{}},\"autoUpload\":true,\"proxy\":true,\"uploadType\":\"fileReceptor\",\"imageClassName\":\"r w-full\",\"accept\":\".jpeg, .jpg, .png, .gif\",\"multiple\":false,\"hideUploadButton\":false,\"editorState\":\"default\"},{\"type\":\"input-rich-text\",\"label\":\"内容\",\"name\":\"content\",\"id\":\"u:8a48b4ca721b\",\"receiver\":{\"url\":\"/s3/tengxunyun/upload?directory=article&wg_api_hash=d41d8cd9\",\"method\":\"post\",\"requestAdaptor\":\"\",\"adaptor\":\"return { \'status\': 0, \'msg\': \'\', \'data\': { value: \'https://cos.ap-nanjing.myqcloud.com/test-1314985928/\' + response.data[0].key } }\",\"messages\":{}},\"vendor\":\"tinymce\",\"options\":{\"plugins\":\"advlist,autolink,link,image,lists,charmap,preview,anchor,pagebreak,searchreplace,wordcount,visualblocks,visualchars,code,fullscreen,insertdatetime,media,nonbreaking,table,emoticons,template,help\",\"toolbar\":\"undo redo formatselect bold italic backcolor alignleft aligncenter alignright alignjustify bullist numlist outdent indent removeformat help\",\"menubar\":true,\"height\":\"\"}}],\"id\":\"u:f0ec4e182b62\",\"actions\":[{\"type\":\"submit\",\"label\":\"提交\",\"primary\":true}],\"feat\":\"Insert\"}],\"type\":\"dialog\",\"id\":\"u:c5411bf4fea6\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\",\"id\":\"u:072015230339\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true,\"id\":\"u:c119314261fb\"}],\"showCloseButton\":true,\"closeOnOutside\":false,\"closeOnEsc\":false,\"showErrorMsg\":true,\"showLoading\":true,\"draggable\":false,\"size\":\"lg\"}},{\"type\":\"bulk-actions\"}],\"id\":\"u:1e4697b1c17f\",\"perPageAvailable\":[10],\"messages\":{},\"filter\":{\"title\":\"查询条件\",\"body\":[{\"type\":\"input-text\",\"name\":\"title\",\"label\":\"文章标题\",\"id\":\"u:b29ab6d333b3\",\"onEvent\":{},\"placeholder\":\"请输入文章标题\",\"size\":\"sm\",\"clearValueOnEmpty\":true,\"clearable\":true},{\"type\":\"select\",\"label\":\"文章标签\",\"name\":\"categoryId\",\"id\":\"u:43873f2e3328\",\"multiple\":false,\"size\":\"sm\",\"clearable\":true,\"searchable\":true,\"source\":{\"url\":\"/operations/post/category/findMany\",\"method\":\"get\"},\"labelField\":\"name\",\"valueField\":\"id\"},{\"type\":\"input-email\",\"label\":\"作者邮箱\",\"name\":\"email\",\"id\":\"u:8207bc9424ae\",\"validations\":{},\"validationErrors\":{},\"placeholder\":\"请输入作者邮箱\",\"size\":\"sm\",\"clearable\":true,\"clearValueOnEmpty\":true},{\"type\":\"input-date-range\",\"label\":\"创建日期\",\"name\":\"createStartDate\",\"id\":\"u:bb47cd6715cd\",\"extraName\":\"createEndDate\",\"valueFormat\":\"YYYY-MM-DDTHH:mm:ss.SSS[Z]\",\"displayFormat\":\"YYYY-MM-DD\",\"utc\":true},{\"type\":\"fieldset\",\"title\":\"\",\"collapsable\":false,\"body\":[{\"type\":\"input-number\",\"label\":\"点赞数\",\"name\":\"likesMin\",\"keyboard\":true,\"id\":\"u:eeb45d6c30eb\",\"step\":1,\"placeholder\":\"点赞最小值\",\"size\":\"sm\"},{\"type\":\"input-number\",\"label\":\"\",\"name\":\"likesMax\",\"keyboard\":true,\"id\":\"u:2d65cd8e2214\",\"step\":1,\"placeholder\":\"点赞最大值\"},{\"type\":\"input-number\",\"label\":\"浏览量\",\"name\":\"viewsMin\",\"keyboard\":true,\"id\":\"u:c30da4e5706f\",\"step\":1,\"placeholder\":\"浏览量最小值\"},{\"type\":\"input-number\",\"label\":\"\",\"name\":\"viewsMax\",\"keyboard\":true,\"id\":\"u:f6805ec99473\",\"step\":1,\"placeholder\":\"浏览量最大值\"},{\"type\":\"submit\",\"label\":\"搜索\",\"primary\":true,\"id\":\"u:a38d6859a04f\"},{\"type\":\"button\",\"label\":\"清空\",\"actionType\":\"clear\",\"id\":\"u:f370adc68466\"}],\"id\":\"u:f1ecf5474a9c\"}],\"id\":\"u:85d87a1422a3\",\"feat\":\"Insert\",\"type\":\"form\",\"target\":\"my_crud\",\"debug\":false,\"actions\":[]},\"alwaysShowPagination\":true,\"footerToolbar\":[{\"type\":\"pagination\",\"align\":\"right\"},{\"type\":\"switch-per-page\",\"align\":\"right\",\"tpl\":\"内容\",\"wrapperComponent\":\"\",\"id\":\"u:bb1a83292041\"},{\"type\":\"statistics\",\"align\":\"right\"}],\"filterTogglable\":false,\"mode\":\"table\",\"name\":\"my_crud\",\"loadDataOnceFetchOnFilter\":true,\"onEvent\":{\"columnSort\":{\"weight\":0,\"actions\":[]}},\"pageField\":\"page\",\"columns\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"text\",\"id\":\"u:d9b069833551\",\"placeholder\":\"-\",\"sortable\":true},{\"name\":\"title\",\"label\":\"文章标题\",\"type\":\"text\",\"id\":\"u:34f4ca0fa7ab\",\"placeholder\":\"-\",\"copyable\":true},{\"type\":\"image\",\"label\":\"封面图\",\"name\":\"poster\",\"id\":\"u:53002bafc629\",\"placeholder\":\"-\"},{\"type\":\"text\",\"label\":\"标签\",\"name\":\"category.name\",\"id\":\"u:5c62c45ab8a2\",\"placeholder\":\"-\"},{\"type\":\"text\",\"label\":\"作者\",\"name\":\"author.name\",\"id\":\"u:973a6ff0fed5\",\"placeholder\":\"-\"},{\"type\":\"text\",\"label\":\"作者邮箱\",\"name\":\"author.email\",\"id\":\"u:d90b4d482db4\",\"placeholder\":\"-\"},{\"type\":\"text\",\"label\":\"点赞数\",\"name\":\"likes\",\"id\":\"u:ab24abc1841f\",\"placeholder\":\"-\"},{\"type\":\"text\",\"label\":\"浏览量\",\"name\":\"views\",\"id\":\"u:1ba92507ab52\",\"placeholder\":\"-\"},{\"type\":\"date\",\"label\":\"创建时间\",\"name\":\"createdAt\",\"id\":\"u:d7cfde9d75e1\",\"placeholder\":\"-\",\"sortable\":true},{\"type\":\"operation\",\"label\":\"操作\",\"id\":\"u:5339f15a6e33\",\"placeholder\":\"-\",\"buttons\":[{\"label\":\"编辑\",\"type\":\"button\",\"actionType\":\"dialog\",\"editorSetting\":{\"behavior\":\"update\"},\"dialog\":{\"title\":\"编辑文章\",\"body\":[{\"type\":\"form\",\"api\":\"/operations/post/updateOne\",\"body\":[{\"name\":\"id\",\"type\":\"hidden\",\"id\":\"u:8d8b13e5c194\"},{\"type\":\"input-text\",\"label\":\"标题\",\"name\":\"title\",\"id\":\"u:9de6e3afe364\"},{\"type\":\"select\",\"label\":\"标签\",\"name\":\"categoryId\",\"id\":\"u:862cccb0fb9f\",\"multiple\":false,\"source\":{\"url\":\"/operations/post/category/findMany\",\"method\":\"get\"},\"labelField\":\"name\",\"valueField\":\"id\"},{\"type\":\"select\",\"label\":\"作者\",\"name\":\"authorId\",\"id\":\"u:a71bf734a5aa\",\"multiple\":false,\"source\":{\"url\":\"/operations/post/author/findMany\",\"method\":\"get\"},\"labelField\":\"name\",\"valueField\":\"id\"},{\"type\":\"input-image\",\"label\":\"封面图\",\"name\":\"poster\",\"id\":\"u:fae528179048\",\"receiver\":{\"url\":\"/s3/tengxunyun/upload?directory=article&wg_api_hash=d41d8cd9\",\"method\":\"post\",\"requestAdaptor\":\"\",\"adaptor\":\"return {\'status\': 0,\'msg\': \'\',\'data\': {value: \'https://cos.ap-nanjing.myqcloud.com/test-1314985928/\' + response.data[0].key}}\",\"messages\":{}},\"autoUpload\":true,\"proxy\":true,\"uploadType\":\"fileReceptor\",\"imageClassName\":\"r w-full\",\"accept\":\".jpeg, .jpg, .png, .gif\",\"multiple\":false,\"hideUploadButton\":false,\"editorState\":\"default\"},{\"type\":\"input-rich-text\",\"label\":\"内容\",\"name\":\"content\",\"id\":\"u:698b3d8e17c5\",\"receiver\":{\"url\":\"/s3/tengxunyun/upload?directory=article&wg_api_hash=d41d8cd9\",\"method\":\"post\",\"requestAdaptor\":\"\",\"adaptor\":\"return { \'status\': 0, \'msg\': \'\', \'data\': { value: \'https://cos.ap-nanjing.myqcloud.com/test-1314985928/\' + response.data[0].key } }\",\"messages\":{}},\"vendor\":\"tinymce\",\"options\":{\"plugins\":\"advlist,autolink,link,image,lists,charmap,preview,anchor,pagebreak,searchreplace,wordcount,visualblocks,visualchars,code,fullscreen,insertdatetime,media,nonbreaking,table,emoticons,template,help\",\"toolbar\":\"undo redo formatselect bold italic backcolor alignleft aligncenter alignright alignjustify bullist numlist outdent indent removeformat help\",\"menubar\":true,\"height\":\"\"}}],\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"},\"id\":\"u:c20ec8dbe4eb\",\"actions\":[{\"type\":\"submit\",\"label\":\"提交\",\"primary\":true}],\"feat\":\"Insert\"}],\"type\":\"dialog\",\"id\":\"u:9b43dbe24425\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\",\"id\":\"u:94609f9c331d\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true,\"id\":\"u:dac03cb809d4\"}],\"showCloseButton\":true,\"closeOnOutside\":false,\"closeOnEsc\":false,\"showErrorMsg\":true,\"showLoading\":true,\"draggable\":false,\"size\":\"lg\"},\"id\":\"u:7aab18b0c95a\"},{\"label\":\"查看\",\"type\":\"button\",\"actionType\":\"dialog\",\"editorSetting\":{\"behavior\":\"view\"},\"dialog\":{\"title\":\"详情\",\"body\":[{\"type\":\"form\",\"body\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"static\",\"id\":\"u:adca146729cf\"},{\"name\":\"title\",\"label\":\"标题\",\"type\":\"static\",\"id\":\"u:1b745302565f\",\"quickEdit\":false,\"popOver\":false,\"copyable\":false},{\"label\":\"标签\",\"name\":\"category.name\",\"type\":\"static\",\"id\":\"u:b9988c45b13f\",\"quickEdit\":false,\"popOver\":false,\"copyable\":false},{\"label\":\"作者\",\"name\":\"author.name\",\"type\":\"static\",\"id\":\"u:89dc1b652261\",\"quickEdit\":false,\"popOver\":false,\"copyable\":false},{\"label\":\"内容\",\"name\":\"content\",\"type\":\"static-html\",\"id\":\"u:49167e503d00\",\"quickEdit\":false,\"popOver\":true,\"copyable\":false},{\"label\":\"封面图\",\"name\":\"poster\",\"type\":\"static-image\",\"id\":\"u:235a38e53aea\",\"thumbMode\":\"cover\",\"thumbRatio\":\"4:3\",\"title\":\"\",\"imageCaption\":\"\",\"enlargeAble\":true,\"originalSrc\":\"${image}\"},{\"label\":\"创建时间\",\"name\":\"createdAt\",\"type\":\"static-date\",\"id\":\"u:e034b4d18b76\",\"quickEdit\":false,\"popOver\":false,\"copyable\":false,\"format\":\"YYYY-MM-DD hh:mm:ss\"},{\"label\":\"更新时间\",\"name\":\"updatedAt\",\"type\":\"static-date\",\"id\":\"u:d2c673efe479\",\"quickEdit\":false,\"popOver\":false,\"copyable\":false,\"format\":\"YYYY-MM-DD hh:mm:ss\"}],\"id\":\"u:feabc9b8958e\",\"actions\":[{\"type\":\"submit\",\"label\":\"提交\",\"primary\":true}],\"feat\":\"Insert\"}],\"type\":\"dialog\",\"id\":\"u:dd6ebe1aadb0\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\",\"id\":\"u:cf15562aa709\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true,\"id\":\"u:092298965aa4\"}],\"showCloseButton\":true,\"closeOnOutside\":false,\"closeOnEsc\":false,\"showErrorMsg\":true,\"showLoading\":true,\"draggable\":false,\"size\":\"lg\"},\"id\":\"u:39e792da3b9a\"},{\"type\":\"button\",\"label\":\"删除\",\"actionType\":\"ajax\",\"level\":\"danger\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/deleteMany\",\"data\":{\"ids\":[\"${id}\"]}},\"id\":\"u:9eee8480ffba\",\"onEvent\":{\"click\":{\"weight\":0,\"actions\":[{\"ignoreError\":false,\"actionType\":\"confirmDialog\",\"dialog\":{\"type\":\"dialog\",\"title\":\"提示\",\"body\":[{\"type\":\"tpl\",\"tpl\":\"确认删除该条数据吗?\",\"wrapperComponent\":\"\",\"inline\":false,\"id\":\"u:a7190c3c08ff\"}],\"dialogType\":\"confirm\",\"confirmText\":\"确认\",\"cancelText\":\"取消\",\"confirmBtnLevel\":\"primary\",\"id\":\"u:23330d908587\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true}]}}]}}}]}]}],\"type\":\"page\"}',1,NULL);

/*!40000 ALTER TABLE `admin_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 admin_menu_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_menu_role`;

CREATE TABLE `admin_menu_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `menuId` int NOT NULL,
  `roleId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_menu_role_menuId_roleId_key` (`menuId`,`roleId`),
  KEY `admin_menu_role_roleId_fkey` (`roleId`),
  KEY `admin_menu_role_menuId_fkey` (`menuId`),
  CONSTRAINT `admin_menu_role_menuId_fkey` FOREIGN KEY (`menuId`) REFERENCES `admin_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admin_menu_role_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `admin_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `admin_menu_role` WRITE;
/*!40000 ALTER TABLE `admin_menu_role` DISABLE KEYS */;

INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`)
VALUES
	(100,'2024-01-25 10:08:46',17,2),
	(101,'2024-01-03 05:50:18',8,8),
	(102,'2024-01-03 05:50:18',9,8),
	(112,'2024-01-03 06:04:55',14,1),
	(114,'2024-01-03 06:14:29',7,1),
	(116,'2024-01-03 06:25:34',8,1),
	(117,'2024-01-03 06:26:15',9,1),
	(118,'2024-01-03 06:26:31',15,1),
	(124,'2024-01-04 09:49:27',8,11),
	(125,'2024-01-04 09:49:27',7,11),
	(126,'2024-01-04 09:49:27',9,11),
	(127,'2024-01-04 09:49:27',14,11),
	(131,'2024-01-04 11:08:12',9,3),
	(132,'2024-01-04 11:08:12',14,3),
	(133,'2024-01-04 11:08:12',15,3),
	(134,'2024-01-04 11:08:12',7,3),
	(135,'2024-01-18 07:30:35',14,14),
	(136,'2024-01-18 07:30:35',7,14);

/*!40000 ALTER TABLE `admin_menu_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 admin_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_role`;

CREATE TABLE `admin_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `admin_role` WRITE;
/*!40000 ALTER TABLE `admin_role` DISABLE KEYS */;

INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`)
VALUES
	(1,'admin','管理员','','2023-12-22 23:58:09','2024-01-03 06:04:54'),
	(2,'user','用户','','2023-12-23 01:16:44','2023-12-27 10:08:46'),
	(3,'test1','test1name','','2023-12-26 03:19:57','2024-01-04 11:08:11'),
	(4,'test2','test2name','test2des12','2023-12-26 03:23:40','2023-12-27 08:52:18'),
	(8,'111','角色','222','2023-12-28 09:09:28','2024-01-03 05:50:18'),
	(11,'222','角色222','顶顶顶顶','2024-01-03 07:44:30','2024-01-05 09:54:21'),
	(14,'1212','zzz','qqqq','2024-01-17 07:51:53','2024-01-18 07:30:34');

/*!40000 ALTER TABLE `admin_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 admin_role_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_role_user`;

CREATE TABLE `admin_role_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `roleId` int NOT NULL,
  `userId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_role_user_roleId_userId_key` (`roleId`,`userId`),
  CONSTRAINT `admin_role_user_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `admin_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `admin_role_user` WRITE;
/*!40000 ALTER TABLE `admin_role_user` DISABLE KEYS */;

INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`)
VALUES
	(10,'2023-12-27 08:29:33',2,'2f329bed-596b-4eed-a27d-0cb7f498cfe3'),
	(19,'2023-12-28 08:29:51',3,'ddfda1ba-228d-412a-a09a-08bad895380e'),
	(20,'2023-12-28 08:29:51',2,'ddfda1ba-228d-412a-a09a-08bad895380e'),
	(33,'2023-12-28 09:57:05',8,'ac40eb74-7ed3-499e-97e2-c0bda1e20131'),
	(38,'2023-12-31 22:26:34',1,'c8da8e37-9596-4290-b794-fed4a12d3760'),
	(39,'2024-01-03 05:50:46',8,'b7e953cd-a75a-46f9-815f-57b39fd5141a'),
	(42,'2024-01-03 08:09:29',1,'292d2b68-65bc-4c9f-b27e-292853f3b3bc'),
	(43,'2024-01-04 05:48:06',1,'82313034-e97d-4c30-8e96-c524a772b530'),
	(44,'2024-01-04 09:07:25',11,'25399e4a-da4c-4509-b384-fc80717103b5'),
	(45,'2024-01-05 01:44:25',11,'31ec726d-c84d-41e0-b8eb-fc3405f6c7a7'),
	(46,'2024-01-05 12:41:06',1,'123'),
	(47,'2024-01-06 02:59:33',11,'04df7417-f65c-46b6-bb71-f92d272672b2');

/*!40000 ALTER TABLE `admin_role_user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 demo_area
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demo_area`;

CREATE TABLE `demo_area` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(64) NOT NULL,
  `address` text,
  `code` varchar(36) NOT NULL,
  `parentCode` varchar(36) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `demo_area_pk2` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `demo_area` WRITE;
/*!40000 ALTER TABLE `demo_area` DISABLE KEYS */;

INSERT INTO `demo_area` (`id`, `createdAt`, `name`, `address`, `code`, `parentCode`)
VALUES
	(13,'2023-12-31 13:40:15','北京市','北京市','00003',''),
	(23,'2023-12-31 13:57:25','海淀区','北京市/海淀区','0000300001','00003'),
	(24,'2023-12-31 14:32:35','江苏省','江苏省','00001',''),
	(27,'2023-12-31 14:38:21','南京市','江苏省/南京市','0000100001','00001'),
	(28,'2023-12-31 14:38:46','淮安市','江苏省/淮安市','0000100002','00001'),
	(30,'2023-12-31 14:42:39','盱眙','江苏省/淮安市/盱眙','000010000200001','0000100002'),
	(31,'2023-12-31 14:43:08','涟水县','江苏省/淮安市/涟水县','000010000200002','0000100002');

/*!40000 ALTER TABLE `demo_area` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 demo_area_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demo_area_role`;

CREATE TABLE `demo_area_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `areaId` int NOT NULL,
  `roleId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `demo_area_role_areaId_roleId_key` (`areaId`,`roleId`),
  KEY `demo_area_role_roleId_fkey` (`roleId`),
  CONSTRAINT `demo_area_role_areaId_fkey` FOREIGN KEY (`areaId`) REFERENCES `demo_area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `demo_area_role_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `admin_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `demo_area_role` WRITE;
/*!40000 ALTER TABLE `demo_area_role` DISABLE KEYS */;

INSERT INTO `demo_area_role` (`id`, `createdAt`, `areaId`, `roleId`)
VALUES
	(6,'2023-12-31 22:44:22',31,1),
	(7,'2023-12-31 22:46:37',13,1);

/*!40000 ALTER TABLE `demo_area_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 demo_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demo_post`;

CREATE TABLE `demo_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `poster` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `categoryId` int DEFAULT NULL,
  `authorId` int DEFAULT NULL,
  `likes` int NOT NULL DEFAULT '0',
  `views` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `demo_post_categoryId_fkey` (`categoryId`),
  KEY `demo_post_categoryId_authorId_idx` (`categoryId`,`authorId`),
  KEY `demo_post_authorId_fkey` (`authorId`),
  CONSTRAINT `demo_post_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `demo_post_author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `demo_post_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `demo_post_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `demo_post` WRITE;
/*!40000 ALTER TABLE `demo_post` DISABLE KEYS */;

INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `categoryId`, `authorId`, `likes`, `views`)
VALUES
	(2,'2023-12-27 08:22:05','2023-12-27 08:22:10','test12','','<div>\n  <div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n    <div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n      <div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\"\n        data-rnwr700-1777fci=\"true\">\n        <div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n          <div class=\"css-175oi2r\">\n            <div class=\"css-175oi2r\">\n              <div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top200_FwkHm bottom200_HuRwz\"\n                data-key=\"03400087b0834e18b3f34b10aecdb416\">\n                <div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9\n                  r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\"\n                  data-block-content=\"03400087b0834e18b3f34b10aecdb416\">\n                  <div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\">\n                    <p class=\"MsoNormal\"><strong><span style=\"font-family:\n                          宋体;\">B 服务区粽子业态出租价格</span>\n                      </strong></p>\n                    <p class=\"MsoNormal\"><strong><span style=\"font-family: 宋体;\">评估咨询报告</span>\n                      </strong></p>\n                    <p class=\"MsoNormal\"><strong><span style=\"font-family: 宋体;\">江苏盛信融价格评估咨询有限公司</span> </strong></p>\n                    <p class=\"MsoNormal\"><strong>2024\n                      </strong><strong><span style=\"font-family: 宋体;\">年</span> </strong><strong>01\n                      </strong><strong><span style=\"font-family: 宋体;\">月</span></strong><strong>B\n                      </strong><strong><span style=\"font-family: 宋体;\">服务区粽子业态出租价格评估</span> </strong></p>\n                    <p class=\"MsoNormal\"><strong><span style=\"font-family: 宋体;\">咨询报告正文</span> </strong></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">江苏盛信融价格评估咨询有限公司接受贵公司委托，按</span></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">照行业通行的评估方法，对贵单位所属的</span> B <span\n                        style=\"font-family: FangSong;\">服务区粽子业态</span></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">的出租价格进行测算评估。</span></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">评估测算是以贵司所提供的数据资料为基础，主要通过</span></p>\n                    <p class=\"MsoNormal\">\n                      <span style=\"font-family: FangSong;\">访谈询问、市场调研、检查求证、分析计算等标准化程序，</span>\n                    </p>\n                    \n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">采用业内通行的评估方法，得出评估结论。</span></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">本报告提供的评估结论具有一定的适用条件性，评估报</span></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">告中的分析、研判及结论受报告中假设和限定条件的制约，</span></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">报告使用人应当充分考虑报告中的前提假设和限定条件及</span></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">其对评估结论所产生的影响。</span></p>\n                    <p class=\"MsoNormal\"><strong><span style=\"font-family: 黑体;\">一、评估对象及范围</span> </strong></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">本次评估对象及范围为</span> B <span\n                        style=\"font-family: FangSong;\">服务区粽子业态出租价格。</span></p>\n                    <p class=\"MsoNormal\"><strong><span style=\"font-family: 黑体;\">二、项目背景</span> </strong></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">随着国家疫情防控政策的调整，全国消费市场呈现出复</span></p>\n                    <p class=\"MsoNormal\">\n                      <span style=\"font-family: FangSong;\">苏迹象，但目前消费回暖较为谨慎，疫情后经济复苏受到诸</span>\n                    </p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">多因素影响。经过疫情，消费者的消费心理和消费行为发生</span></p>\n                    <p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">了明显变化，消费者对于品牌认可度更高，更加注重消费环</span></p>\n                  </div>\n                </div>\n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n<div>\n  <div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n    <div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n      <div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\"\n        data-rnwr700-1777fci=\"true\">\n        <div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n          <div class=\"css-175oi2r\">\n            <div class=\"css-175oi2r\">\n              <div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top600_sT-91 bottom200_HuRwz\"\n                data-key=\"3e5991a7d35d43ce9c9aa7ba3e7590fa\">\n                <div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9\n                  r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\"\n                  data-block-content=\"3e5991a7d35d43ce9c9aa7ba3e7590fa\">\n                  <div id=\"text-qian-duan-kai-fa-zhe-bian-shen-quan-zhan-kai-fa\" class=\"css-1rynq56 r-37p410 r-fdjqy7\n                    r-1xnzce8\" dir=\"auto\" data-rnwrdesktop-gg6oyi-adyw6z-135wba7-b88u0q=\"true\"\n                    data-rnwr700-gg6oyi-ubezar-135wba7-1kfrs79=\"true\"></div>\n                  <h3 id=\"qian-duan-kai-fa-zhe-bian-shen-quan-zhan-kai-fa\" class=\"r-1xc7w19 r-1phboty r-1yadl64\n                    r-deolkf r-6koalj r-1mlwlqe r-1q142lx r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010\n                    r-18u37iz r-obd0qt\"></h3>\n                </div>\n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>',1,2,4,6),
	(3,'2023-12-28 08:22:12','2024-02-21 08:07:57','test123','https://cos.ap-nanjing.myqcloud.com/test-1314985928/article/00083e4681c28efa.jpeg','<p>test1 content 3<img src=\"https://cos.ap-nanjing.myqcloud.com/test-1314985928/avatar/3212/4ce450ae598faf8e.png\" alt=\"\" width=\"512\" height=\"604\"></p>',1,1,0,0),
	(34,'2024-02-20 08:11:00','2024-02-21 07:36:39','什么是飞布？','https://cos.ap-nanjing.myqcloud.com/test-1314985928/avatar/3212/4666cf6316dcc2a4.png','<div>\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\" data-rnwr700-1777fci=\"true\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"css-175oi2r\">\n<div class=\"css-175oi2r\">\n<div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top600_sT-91 bottom200_HuRwz\" data-key=\"6b0a7134e1f142b98fb7d07ad66e56f0\">\n<div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\" data-block-content=\"6b0a7134e1f142b98fb7d07ad66e56f0\">\n<div id=\"text-fei-bu-gai-shu\" class=\"css-1rynq56 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\" data-rnwrdesktop-gg6oyi-1x35g6-37tt59-b88u0q=\"true\" data-rnwr700-gg6oyi-adyw6z-135wba7-b88u0q=\"true\"><span data-key=\"ff6be11d0f2a42838f0ce07ea2d6c741\"><span data-offset-key=\"ff6be11d0f2a42838f0ce07ea2d6c741:0\">飞布概述</span></span></div>\n<h2 id=\"fei-bu-gai-shu\" class=\"r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-1mlwlqe r-1q142lx r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-18u37iz r-obd0qt\"></h2>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n<div>\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\" data-rnwr700-1777fci=\"true\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"css-175oi2r\">\n<div class=\"css-175oi2r\">\n<div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top200_FwkHm bottom200_HuRwz\" data-key=\"8b0004f29a414047a5c1e64fcbc9d82d\">\n<div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\" data-block-content=\"8b0004f29a414047a5c1e64fcbc9d82d\">\n<div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\"><span data-key=\"ae8965fe7fff49fd860a25e1900f7ffb\"><span data-offset-key=\"ae8965fe7fff49fd860a25e1900f7ffb:0\">飞布是&ldquo;</span><strong class=\"r-crgep1 r-b88u0q\" data-slate-leaf=\"true\" data-offset-key=\"ae8965fe7fff49fd860a25e1900f7ffb:1\">开发体验优先</strong><span data-offset-key=\"ae8965fe7fff49fd860a25e1900f7ffb:2\">&rdquo;的可视化API开发平台（IDE），传统模式下2天才能完成的接口，用飞布2分钟就能完成。前后端开发者都能使用飞布构建生产级WEB API。</span></span></div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n<div>\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\" data-rnwr700-1777fci=\"true\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"css-175oi2r\">\n<div class=\"css-175oi2r\">\n<div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top200_FwkHm bottom200_HuRwz\" data-key=\"37db2297940743f0bf0d0ff2076255bf\">\n<div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\" data-block-content=\"37db2297940743f0bf0d0ff2076255bf\">\n<div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\"><span data-key=\"be25a659dee34b1085d28021b0f89cbe\"><span data-offset-key=\"be25a659dee34b1085d28021b0f89cbe:0\">飞布定位是：外包企业的秘密武器，程序员的开发利器（前端变全栈、后端不搬砖）！</span></span></div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n<div data-slate-fragment=\"JTdCJTIyb2JqZWN0JTIyJTNBJTIyZG9jdW1lbnQlMjIlMkMlMjJkYXRhJTIyJTNBJTdCJTdEJTJDJTIybm9kZXMlMjIlM0ElNUIlN0IlMjJvYmplY3QlMjIlM0ElMjJibG9jayUyMiUyQyUyMnR5cGUlMjIlM0ElMjJoZWFkaW5nLTElMjIlMkMlMjJpc1ZvaWQlMjIlM0FmYWxzZSUyQyUyMmRhdGElMjIlM0ElN0IlN0QlMkMlMjJub2RlcyUyMiUzQSU1QiU3QiUyMm9iamVjdCUyMiUzQSUyMnRleHQlMjIlMkMlMjJsZWF2ZXMlMjIlM0ElNUIlN0IlMjJvYmplY3QlMjIlM0ElMjJsZWFmJTIyJTJDJTIydGV4dCUyMiUzQSUyMiVFOSVBMyU5RSVFNSVCOCU4MyVFNiVBNiU4MiVFOCVCRiVCMCUyMiUyQyUyMm1hcmtzJTIyJTNBJTVCJTVEJTJDJTIyc2VsZWN0aW9ucyUyMiUzQSU1QiU1RCU3RCU1RCUyQyUyMmtleSUyMiUzQSUyMkgwR1Z3NDcyT1JPVCUyMiU3RCU1RCUyQyUyMmtleSUyMiUzQSUyMjBkemFhSW5COHMwZCUyMiU3RCUyQyU3QiUyMm9iamVjdCUyMiUzQSUyMmJsb2NrJTIyJTJDJTIydHlwZSUyMiUzQSUyMnBhcmFncmFwaCUyMiUyQyUyMmlzVm9pZCUyMiUzQWZhbHNlJTJDJTIyZGF0YSUyMiUzQSU3QiU3RCUyQyUyMm5vZGVzJTIyJTNBJTVCJTdCJTIyb2JqZWN0JTIyJTNBJTIydGV4dCUyMiUyQyUyMmxlYXZlcyUyMiUzQSU1QiU3QiUyMm9iamVjdCUyMiUzQSUyMmxlYWYlMjIlMkMlMjJ0ZXh0JTIyJTNBJTIyJUU5JUEzJTlFJUU1JUI4JTgzJUU2JTk4JUFGJUUyJTgwJTlDJTIyJTJDJTIybWFya3MlMjIlM0ElNUIlNUQlMkMlMjJzZWxlY3Rpb25zJTIyJTNBJTVCJTVEJTdEJTJDJTdCJTIyb2JqZWN0JTIyJTNBJTIybGVhZiUyMiUyQyUyMnRleHQlMjIlM0ElMjIlRTUlQkMlODAlRTUlOEYlOTElRTQlQkQlOTMlRTklQUElOEMlRTQlQkMlOTglRTUlODUlODglMjIlMkMlMjJtYXJrcyUyMiUzQSU1QiU3QiUyMm9iamVjdCUyMiUzQSUyMm1hcmslMjIlMkMlMjJ0eXBlJTIyJTNBJTIyYm9sZCUyMiUyQyUyMmRhdGElMjIlM0ElN0IlN0QlN0QlNUQlMkMlMjJzZWxlY3Rpb25zJTIyJTNBJTVCJTVEJTdEJTJDJTdCJTIyb2JqZWN0JTIyJTNBJTIybGVhZiUyMiUyQyUyMnRleHQlMjIlM0ElMjIlRTIlODAlOUQlRTclOUElODQlRTUlOEYlQUYlRTglQTclODYlRTUlOEMlOTZBUEklRTUlQkMlODAlRTUlOEYlOTElRTUlQjklQjMlRTUlOEYlQjAlRUYlQkMlODhJREUlRUYlQkMlODklRUYlQkMlOEMlRTQlQkMlQTAlRTclQkIlOUYlRTYlQTglQTElRTUlQkMlOEYlRTQlQjglOEIyJUU1JUE0JUE5JUU2JTg5JThEJUU4JTgzJUJEJUU1JUFFJThDJUU2JTg4JTkwJUU3JTlBJTg0JUU2JThFJUE1JUU1JThGJUEzJUVGJUJDJThDJUU3JTk0JUE4JUU5JUEzJTlFJUU1JUI4JTgzMiVFNSU4OCU4NiVFOSU5MiU5RiVFNSVCMCVCMSVFOCU4MyVCRCVFNSVBRSU4QyVFNiU4OCU5MCVFMyU4MCU4MiVFNSU4OSU4RCVFNSU5MCU4RSVFNyVBQiVBRiVFNSVCQyU4MCVFNSU4RiU5MSVFOCU4MCU4NSVFOSU4MyVCRCVFOCU4MyVCRCVFNCVCRCVCRiVFNyU5NCVBOCVFOSVBMyU5RSVFNSVCOCU4MyVFNiU5RSU4NCVFNSVCQiVCQSVFNyU5NCU5RiVFNCVCQSVBNyVFNyVCQSVBN1dFQiUyMEFQSSVFMyU4MCU4MiUyMiUyQyUyMm1hcmtzJTIyJTNBJTVCJTVEJTJDJTIyc2VsZWN0aW9ucyUyMiUzQSU1QiU1RCU3RCU1RCUyQyUyMmtleSUyMiUzQSUyMmFlODk2NWZlN2ZmZjQ5ZmQ4NjBhMjVlMTkwMGY3ZmZiJTIyJTdEJTVEJTJDJTIya2V5JTIyJTNBJTIyOGIwMDA0ZjI5YTQxNDA0N2E1YzFlNjRmY2JjOWQ4MmQlMjIlN0QlMkMlN0IlMjJvYmplY3QlMjIlM0ElMjJibG9jayUyMiUyQyUyMnR5cGUlMjIlM0ElMjJwYXJhZ3JhcGglMjIlMkMlMjJpc1ZvaWQlMjIlM0FmYWxzZSUyQyUyMmRhdGElMjIlM0ElN0IlN0QlMkMlMjJub2RlcyUyMiUzQSU1QiU3QiUyMm9iamVjdCUyMiUzQSUyMnRleHQlMjIlMkMlMjJsZWF2ZXMlMjIlM0ElNUIlN0IlMjJvYmplY3QlMjIlM0ElMjJsZWFmJTIyJTJDJTIydGV4dCUyMiUzQSUyMiVFOSVBMyU5RSVFNSVCOCU4MyVFNSVBRSU5QSVFNCVCRCU4RCVFNiU5OCVBRiVFRiVCQyU5QSVFNSVBNCU5NiVFNSU4QyU4NSVFNCVCQyU4MSVFNCVCOCU5QSVFNyU5QSU4NCVFNyVBNyU5OCVFNSVBRiU4NiVFNiVBRCVBNiVFNSU5OSVBOCVFRiVCQyU4QyVFNyVBOCU4QiVFNSVCQSU4RiVFNSU5MSU5OCVFNyU5QSU4NCVFNSVCQyU4MCVFNSU4RiU5MSVFNSU4OCVBOSVFNSU5OSVBOCVFRiVCQyU4OCVFNSU4OSU4RCVFNyVBQiVBRiVFNSU4RiU5OCVFNSU4NSVBOCVFNiVBMCU4OCVFMyU4MCU4MSVFNSU5MCU4RSVFNyVBQiVBRiVFNCVCOCU4RCVFNiU5MCVBQyVFNyVBMCU5NiVFRiVCQyU4OSVFRiVCQyU4MSUyMiUyQyUyMm1hcmtzJTIyJTNBJTVCJTVEJTJDJTIyc2VsZWN0aW9ucyUyMiUzQSU1QiU1RCU3RCU1RCUyQyUyMmtleSUyMiUzQSUyMmJlMjVhNjU5ZGVlMzRiMTA4NWQyODAyMWIwZjg5Y2JlJTIyJTdEJTVEJTJDJTIya2V5JTIyJTNBJTIyMzdkYjIyOTc5NDA3NDNmMGJmMGQwZmYyMDc2MjU1YmYlMjIlN0QlMkMlN0IlMjJvYmplY3QlMjIlM0ElMjJibG9jayUyMiUyQyUyMnR5cGUlMjIlM0ElMjJwYXJhZ3JhcGglMjIlMkMlMjJpc1ZvaWQlMjIlM0FmYWxzZSUyQyUyMmRhdGElMjIlM0ElN0IlN0QlMkMlMjJub2RlcyUyMiUzQSU1QiU3QiUyMm9iamVjdCUyMiUzQSUyMnRleHQlMjIlMkMlMjJsZWF2ZXMlMjIlM0ElNUIlN0IlMjJvYmplY3QlMjIlM0ElMjJsZWFmJTIyJTJDJTIydGV4dCUyMiUzQSUyMiVFOSVBMyU5RSVFNSVCOCU4MyVFNiU4NCVCRiVFNiU5OSVBRiVFNiU5OCVBRiVFRiVCQyU5QSVFNiU5RSU4MSVFOCU4NyVCNCVFNSVCQyU4MCVFNSU4RiU5MSVFNCVCRCU5MyVFOSVBQSU4QyVFRiVCQyU4QyVFMiU4MCU5QyVFOSVBMyU5RSVFOSU4MCU5RiVFNSVCOCU4MyVFNyVCRCVCMiVFMiU4MCU5RCVFNSVCQSU5NCVFNyU5NCVBOCVFMyU4MCU4MiUyMiUyQyUyMm1hcmtzJTIyJTNBJTVCJTVEJTJDJTIyc2VsZWN0aW9ucyUyMiUzQSU1QiU1RCU3RCU1RCUyQyUyMmtleSUyMiUzQSUyMjdkNTA0YWQyNzZjYzQ5YWRhODk2NTI5YjQ5NmNjMmJmJTIyJTdEJTVEJTJDJTIya2V5JTIyJTNBJTIyMmE2ZTg0NDg4MTAyNDM1ZDg5OTBmMjZkMWU5MDM0NWQlMjIlN0QlNUQlMkMlMjJrZXklMjIlM0ElMjJnZWowSHA2ckdQNm0lMjIlN0Q=\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\" data-rnwr700-1777fci=\"true\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"css-175oi2r\">\n<div class=\"css-175oi2r\">\n<div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top200_FwkHm bottom200_HuRwz\" data-key=\"2a6e84488102435d8990f26d1e90345d\">\n<div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\" data-block-content=\"2a6e84488102435d8990f26d1e90345d\">\n<div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\"><span data-key=\"7d504ad276cc49ada896529b496cc2bf\"><span data-offset-key=\"7d504ad276cc49ada896529b496cc2bf:0\">飞布愿景是：极致开发体验，&ldquo;飞速布署&rdquo;应用。</span></span></div>\n<div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\">&nbsp;<img src=\"https://2723694181-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FNx22Cp3wzkuW1siRbMwW%2Fuploads%2Fgit-blob-27ac7ebfd2230bb9efc0546751f1a1e45d65cd8e%2Fimage%20(8)%20(2)%20(1).png?alt=media\" alt=\"\" width=\"800\" height=\"438\"></div>\n<div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\">\n<div>\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\" data-rnwr700-1777fci=\"true\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"css-175oi2r\">\n<div class=\"css-175oi2r\">\n<div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top200_FwkHm bottom200_HuRwz\" data-key=\"869537f6194746e3bba4dd851a8c5a0b\">\n<div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\" data-block-content=\"869537f6194746e3bba4dd851a8c5a0b\">\n<div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\"><span data-key=\"570e81ecebcd4d91856004e86df52000\"><span data-offset-key=\"570e81ecebcd4d91856004e86df52000:0\">如果你是后端，厌倦了做CRUD BOY的日子，希望快速成长并接受更有意义的挑战，使用飞布后，你将摆脱重复、低效的开发现状，有时间专注于更有价值的业务逻辑，实现人生更大的梦想。</span></span></div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n<div data-slate-fragment=\"JTdCJTIyb2JqZWN0JTIyJTNBJTIyZG9jdW1lbnQlMjIlMkMlMjJkYXRhJTIyJTNBJTdCJTdEJTJDJTIybm9kZXMlMjIlM0ElNUIlN0IlMjJvYmplY3QlMjIlM0ElMjJibG9jayUyMiUyQyUyMnR5cGUlMjIlM0ElMjJwYXJhZ3JhcGglMjIlMkMlMjJpc1ZvaWQlMjIlM0FmYWxzZSUyQyUyMmRhdGElMjIlM0ElN0IlN0QlMkMlMjJub2RlcyUyMiUzQSU1QiU3QiUyMm9iamVjdCUyMiUzQSUyMnRleHQlMjIlMkMlMjJsZWF2ZXMlMjIlM0ElNUIlN0IlMjJvYmplY3QlMjIlM0ElMjJsZWFmJTIyJTJDJTIydGV4dCUyMiUzQSUyMiVFNSVBNiU4MiVFNiU5RSU5QyVFNCVCRCVBMCVFNiU5OCVBRiVFNSU5MCU4RSVFNyVBQiVBRiVFRiVCQyU4QyVFNSU4RSU4QyVFNSU4MCVBNiVFNCVCQSU4NiVFNSU4MSU5QUNSVUQlMjBCT1klRTclOUElODQlRTYlOTclQTUlRTUlQUQlOTAlRUYlQkMlOEMlRTUlQjglOEMlRTYlOUMlOUIlRTUlQkYlQUIlRTklODAlOUYlRTYlODglOTAlRTklOTUlQkYlRTUlQjklQjYlRTYlOEUlQTUlRTUlOEYlOTclRTYlOUIlQjQlRTYlOUMlODklRTYlODQlOEYlRTQlQjklODklRTclOUElODQlRTYlOEMlOTElRTYlODglOTglRUYlQkMlOEMlRTQlQkQlQkYlRTclOTQlQTglRTklQTMlOUUlRTUlQjglODMlRTUlOTAlOEUlRUYlQkMlOEMlRTQlQkQlQTAlRTUlQjAlODYlRTYlOTElODYlRTglODQlQjElRTklODclOEQlRTUlQTQlOEQlRTMlODAlODElRTQlQkQlOEUlRTYlOTUlODglRTclOUElODQlRTUlQkMlODAlRTUlOEYlOTElRTclOEUlQjAlRTclOEElQjYlRUYlQkMlOEMlRTYlOUMlODklRTYlOTclQjYlRTklOTclQjQlRTQlQjglOTMlRTYlQjMlQTglRTQlQkElOEUlRTYlOUIlQjQlRTYlOUMlODklRTQlQkIlQjclRTUlODAlQkMlRTclOUElODQlRTQlQjglOUElRTUlOEElQTElRTklODAlQkIlRTglQkUlOTElRUYlQkMlOEMlRTUlQUUlOUUlRTclOEUlQjAlRTQlQkElQkElRTclOTQlOUYlRTYlOUIlQjQlRTUlQTQlQTclRTclOUElODQlRTYlQTIlQTYlRTYlODMlQjMlRTMlODAlODIlMjIlMkMlMjJtYXJrcyUyMiUzQSU1QiU1RCUyQyUyMnNlbGVjdGlvbnMlMjIlM0ElNUIlNUQlN0QlNUQlMkMlMjJrZXklMjIlM0ElMjJWYURvRXRob1RmaFAlMjIlN0QlNUQlMkMlMjJrZXklMjIlM0ElMjIxOUZsZlBRZ2FNa0slMjIlN0QlMkMlN0IlMjJvYmplY3QlMjIlM0ElMjJibG9jayUyMiUyQyUyMnR5cGUlMjIlM0ElMjJwYXJhZ3JhcGglMjIlMkMlMjJpc1ZvaWQlMjIlM0FmYWxzZSUyQyUyMmRhdGElMjIlM0ElN0IlN0QlMkMlMjJub2RlcyUyMiUzQSU1QiU3QiUyMm9iamVjdCUyMiUzQSUyMnRleHQlMjIlMkMlMjJsZWF2ZXMlMjIlM0ElNUIlN0IlMjJvYmplY3QlMjIlM0ElMjJsZWFmJTIyJTJDJTIydGV4dCUyMiUzQSUyMiVFNSVBNiU4MiVFNiU5RSU5QyVFNCVCRCVBMCVFNiU5OCVBRiVFNSU4OSU4RCVFNyVBQiVBRiVFRiVCQyU4QyVFNSU4RiU5NyVFNSVBNCU5RiVFNCVCQSU4NiVFNiU4OSVCRSVFNSU5MCU4RSVFNyVBQiVBRiVFNCVCRiVBRSVFNiU5NCVCOSVFNCVCOCU4MCVFNCVCOCVBQSVFNSVBRCU5NyVFNiVBRSVCNSVFNiU5NyVCNiVFNyU5QSU4NCVFNiU5RCVBNSVFNSU5QiU5RSVFNiU4QiU4OSVFNiU4OSVBRiVFRiVCQyU4QyVFNCVCRCVCRiVFNyU5NCVBOCVFOSVBMyU5RSVFNSVCOCU4MyVFNSU5MCU4RSVFRiVCQyU4QyVFNSU4RiVBQSVFOSU5QyU4MDMwJUU1JTg4JTg2JUU5JTkyJTlGJUU1JUFEJUE2JUU0JUI5JUEwJUVGJUJDJThDJUU0JUJEJUEwJUU1JUIwJUIxJUU4JTgzJUJEJUU1JUJDJTgwJUU1JThGJTkxJUU1JTg3JUJBJUU2JUFGJTk0JUU2JTk2JUIwJUU2JTg5JThCJUU1JTkwJThFJUU3JUFCJUFGJUU4JUJGJTk4JUU4JUE2JTgxJUU3JUE4JUIzJUU1JTgxJUE1JUU3JTlBJTg0QVBJJUU2JThFJUE1JUU1JThGJUEzJUVGJUJDJThDJUU3JTlCJUI0JUU2JThFJUE1JUU1JThGJTk4JUU1JTg1JUE4JUU2JUEwJTg4JUUzJTgwJTgyJTIyJTJDJTIybWFya3MlMjIlM0ElNUIlNUQlMkMlMjJzZWxlY3Rpb25zJTIyJTNBJTVCJTVEJTdEJTVEJTJDJTIya2V5JTIyJTNBJTIyNzEyNmI4YTU1OWM0NGY1OTkwNzc3MTRjNzYzZWVkYTElMjIlN0QlNUQlMkMlMjJrZXklMjIlM0ElMjI4NjUyZTg3ZmE2MGU0NDAyYjBmZWFjNjc5NmY1MjM4MSUyMiU3RCU1RCUyQyUyMmtleSUyMiUzQSUyMkZERmY3Q1lNb3VEQiUyMiU3RA==\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\" data-rnwr700-1777fci=\"true\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"css-175oi2r\">\n<div class=\"css-175oi2r\">\n<div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top200_FwkHm bottom200_HuRwz\" data-key=\"8652e87fa60e4402b0feac6796f52381\">\n<div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\" data-block-content=\"8652e87fa60e4402b0feac6796f52381\">\n<div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\"><span data-key=\"7126b8a559c44f599077714c763eeda1\"><span data-offset-key=\"7126b8a559c44f599077714c763eeda1:0\">如果你是前端，受够了找后端修改一个字段时的来回拉扯，使用飞布后，只需30分钟学习，你就能开发出比新手后端还要稳健的API接口，直接变全栈。</span></span></div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>',57,1,0,0),
	(36,'2024-02-21 08:11:30','2024-02-22 07:33:21','飞布的价值','https://cos.ap-nanjing.myqcloud.com/test-1314985928/article/588abb90c0cd8b05.png','<div>\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\" data-rnwr700-1777fci=\"true\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"css-175oi2r\">\n<div class=\"css-175oi2r\">\n<div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top200_FwkHm bottom200_HuRwz\" data-key=\"03400087b0834e18b3f34b10aecdb416\">\n<div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\" data-block-content=\"03400087b0834e18b3f34b10aecdb416\">\n<div class=\"css-1rynq56 r-gg6oyi r-ubezar r-1o2nx2a r-135wba7 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\">\n<p class=\"MsoNormal\"><strong>B </strong><strong><span style=\"font-family: 宋体;\">服务区粽子业态出租价格</span> </strong></p>\n<p class=\"MsoNormal\"><strong><span style=\"font-family: 宋体;\">评估咨询报告</span> </strong></p>\n<p class=\"MsoNormal\"><strong><span style=\"font-family: 宋体;\">江苏盛信融价格评估咨询有限公司</span> </strong></p>\n<p class=\"MsoNormal\"><strong>2024 </strong><strong><span style=\"font-family: 宋体;\">年</span> </strong><strong>01 </strong><strong><span style=\"font-family: 宋体;\">月</span></strong><strong>B </strong><strong><span style=\"font-family: 宋体;\">服务区粽子业态出租价格评估</span> </strong></p>\n<p class=\"MsoNormal\"><strong><span style=\"font-family: 宋体;\">咨询报告正文</span> </strong></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">江苏盛信融价格评估咨询有限公司接受贵公司委托，按</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">照行业通行的评估方法，对贵单位所属的</span> B <span style=\"font-family: FangSong;\">服务区粽子业态</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">的出租价格进行测算评估。</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">评估测算是以贵司所提供的数据资料为基础，主要通过</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">访谈询问、市场调研、检查求证、分析计算等标准化程序，</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">采用业内通行的评估方法，得出评估结论。</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">本报告提供的评估结论具有一定的适用条件性，评估报</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">告中的分析、研判及结论受报告中假设和限定条件的制约，</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">报告使用人应当充分考虑报告中的前提假设和限定条件及</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">其对评估结论所产生的影响。</span></p>\n<p class=\"MsoNormal\"><strong><span style=\"font-family: 黑体;\">一、评估对象及范围</span> </strong></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">本次评估对象及范围为</span> B <span style=\"font-family: FangSong;\">服务区粽子业态出租价格。</span></p>\n<p class=\"MsoNormal\"><strong><span style=\"font-family: 黑体;\">二、项目背景</span> </strong></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">随着国家疫情防控政策的调整，全国消费市场呈现出复</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">苏迹象，但目前消费回暖较为谨慎，疫情后经济复苏受到诸</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">多因素影响。经过疫情，消费者的消费心理和消费行为发生</span></p>\n<p class=\"MsoNormal\"><span style=\"font-family: FangSong;\">了明显变化，消费者对于品牌认可度更高，更加注重消费环</span></p>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n<div>\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"view_manYY blockWrapper_8BIg7 vertical0_jPhI0 horizontalAuto_xck7M\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2 r-18u37iz r-1777fci\" data-rnwr1490-1777fci=\"true\" data-rnwr700-1777fci=\"true\">\n<div class=\"css-175oi2r r-1ro0kt6 r-16y2uox r-1wbh5a2\">\n<div class=\"css-175oi2r\">\n<div class=\"css-175oi2r\">\n<div class=\"view_manYY relative_kNGzo column_Pzect vertical400_IGNdU top600_sT-91 bottom200_HuRwz\" data-key=\"3e5991a7d35d43ce9c9aa7ba3e7590fa\">\n<div class=\"r-1oszu61 r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-eqz5dr r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-1ro0kt6 r-16y2uox r-1wbh5a2\" data-block-content=\"3e5991a7d35d43ce9c9aa7ba3e7590fa\">\n<div id=\"text-qian-duan-kai-fa-zhe-bian-shen-quan-zhan-kai-fa\" class=\"css-1rynq56 r-37p410 r-fdjqy7 r-1xnzce8\" dir=\"auto\" data-rnwrdesktop-gg6oyi-adyw6z-135wba7-b88u0q=\"true\" data-rnwr700-gg6oyi-ubezar-135wba7-1kfrs79=\"true\"></div>\n<h3 id=\"qian-duan-kai-fa-zhe-bian-shen-quan-zhan-kai-fa\" class=\"r-1xc7w19 r-1phboty r-1yadl64 r-deolkf r-6koalj r-1mlwlqe r-1q142lx r-crgep1 r-ifefl9 r-bcqeeo r-t60dpp r-bnwqim r-417010 r-18u37iz r-obd0qt\"></h3>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>',57,1,0,0);

/*!40000 ALTER TABLE `demo_post` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 demo_post_author
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demo_post_author`;

CREATE TABLE `demo_post_author` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `demo_post_author` WRITE;
/*!40000 ALTER TABLE `demo_post_author` DISABLE KEYS */;

INSERT INTO `demo_post_author` (`id`, `createdAt`, `updatedAt`, `name`, `email`)
VALUES
	(1,'2024-02-19 10:31:44.000','2024-02-19 10:31:47.000','张三','zs@fireboom.io'),
	(2,'2024-02-19 10:32:03.000','2024-02-19 10:32:05.000','李四','ls@fireboom.io');

/*!40000 ALTER TABLE `demo_post_author` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 demo_post_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demo_post_category`;

CREATE TABLE `demo_post_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `demo_post_category` WRITE;
/*!40000 ALTER TABLE `demo_post_category` DISABLE KEYS */;

INSERT INTO `demo_post_category` (`id`, `createdAt`, `updatedAt`, `name`, `description`)
VALUES
	(1,'2023-12-28 08:20:43','2023-12-28 08:20:46','人文风情',''),
	(55,'2024-02-19 10:32:41','2024-02-19 10:32:43','社会观察',NULL),
	(56,'2024-02-19 10:32:51','2024-02-19 10:32:53','金融市场',NULL),
	(57,'2024-02-19 10:33:01','2024-02-19 10:33:03','技术研发',NULL);

/*!40000 ALTER TABLE `demo_post_category` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 provider
# ------------------------------------------------------------

DROP TABLE IF EXISTS `provider`;

CREATE TABLE `provider` (
  `owner` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_secret` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sign_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `template_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`) USING BTREE,
  UNIQUE KEY `UQE_provider_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;

INSERT INTO `provider` (`owner`, `name`, `created_time`, `type`, `client_id`, `client_secret`, `sign_name`, `template_code`)
VALUES
	('fireboom','provider_sms','2023-09-11T12:15:09+08:00','Aliyun SMS','xxxx','xxxx','xxx','xxx');

/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 test
# ------------------------------------------------------------

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `id` int NOT NULL,
  `test` enum('Hello','World') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `token`;

CREATE TABLE `token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `expire_time` datetime DEFAULT NULL,
  `flush_time` datetime DEFAULT NULL,
  `refresh_token` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `refresh_expire_time` datetime DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `platform` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;

INSERT INTO `token` (`id`, `user_id`, `token`, `expire_time`, `flush_time`, `refresh_token`, `refresh_expire_time`, `banned`, `platform`)
VALUES
	(3146,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODQyMzE3MCwibmJmIjoxNzA4MzM2NzcwLCJpYXQiOjE3MDgzMzY3NzB9.MrVSY09DcaIU3dErBN3AzDeWwiau9ve0O-pB3Gbsjo0xoDabnHjqjdzi2Ef5pV3q4I_kohkqPisNJzMkkDHf9wUjL7ZKQAuFZ2bO_q7Q78_LHZ3TM1oxesrfTAkH3ZXVpk0Q9s44W_hnHjjz_0e80jHTg0D4XL1XA4B6gylEnFIOPXDnMIqcOcEkUap_sjZ_WCcJA51qyNs1C2QAXNH-rbGMxKI0ICINirFQRDVq2G5asTKxIBoTli5F4lI14ZOksbmiChYAgcMdmkuQIHQlqB5u_udN1FgTOBR3gX5ES1nckG01ksDzfBUZxdUGoPO2Gmi-AGuQAcJvB3qhZt5_Cx2_48qjqur7MoaIwVBd_GVtP_zileHj1tGzDk2gc386gvohR6VKpeqoxZm17zbwzcDhSddxy-BZcks2Jw4QrumU5T2whBOsqwBnwDkeW0v3fp0zB3gRReQzUF7a3e2v-M94p44OM5juOhaubg6nhoWwTKkskFeFRIjN3VUrI7GwbJCtSskMX-UD1y9X4HFDeuuvgSDns5fh1VIG2kOwIhFBdWVtHvcLEDyOyr8QsBCCecZA_0IbjKYNHUD_gv7j02BW3fJN3ytf4pTB_CJQCo2XInst-6tXs12Un3U_TPmJjCfyfBDCgnuEz7PLzaCYbrDo8bwmDaJV-Q9DoTZU7KQ','2024-02-20 09:59:30',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDg5NDE1NzAsIm5iZiI6MTcwODMzNjc3MCwiaWF0IjoxNzA4MzM2NzcwfQ.qGOAZVVrEBsf4dIFd6nLDsnNkg2Cl8XGglhcNnBLQFiyM78q3oXALQa651e9BJG5Eu0x2V4LuVd1iOczEEgJl957HpGrdIDzZEYDZ-cMc5fECVVmD2VhjwiM70RcmkeP6-xOSrfEszK00z2v27UgFvJv2I6N-JeiUuFyTrCyW8wNTXxAuU15BHtYIR7oHpRSYspz_0vPjzH5l1Ma1aATXKwm3ndnWom9wmscq7EJAcnCzZaPtwAs9gQ3d8974IS-Ow-92vUFMbDczEMbuyTbADryMaR1gugYT_x7LRTLh3z-ZSAl--aU63CvG86N6FKhNLFdd2j1e0vkeVP0MFuQpPF_WuB_p2oPf-uMtMJGLvO5bB8hoGZMsBhvbOvri8ldfxtW4C4tAT7qn1PNCvsTFL8PUDka57eP1SwkNnDYw6AvN64o3IPB3umfRthBWXkW-XWHW7t-XGbCptg0fUFPQZIfur1Db47_zX1rj15672g8m3l6-Zm0AGhmrbJfq-H22NaaQfkbF9tLsFAFkyZR_gdL7GDuSLCiTl0QHkvVBwmOdq-4YyIO_WVjj1lO91G0Fpb9qk6h5XAYBtLEtJAB9A7G1Xht6WLYYSFkVVmo1Gc1Yjx8DR_cKp9Q7ZmpnxA2fHXBJuVrIC6G565Um071OEkltiP2Xp5hmq6Wv59Lv5Q','2024-02-26 09:59:30',0,''),
	(3147,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODQyMzM2MywibmJmIjoxNzA4MzM2OTYzLCJpYXQiOjE3MDgzMzY5NjN9.XZ9A47iaitlL-vmjUaYpvIfJ435LPMZhwFlKp_x6LEWdXI4tLQRTiaI55PumzFYh51rYrhe0ks71BsV-H7ElnkEEx6mRFlc96iaf6xLOb38RNW-hqhdzG41o3fFv-zkfUEFG1o6yXzRM2WMklt0FzM-mj6sG9FxnDXAMGjQltHAeCqlqCuDBL3Up3P97vzLWk4xWD-hFxfLSWw6s8nnGEscuTAk4h39ELRr2QjC6_3xR2l2z821Vl_-4kiAbz4t6Vqw_Xv30B2iZxS3yrnGyepfWBdyNEyYD67FcaRvj9upEAbWJwryT8Uf5CotiMItOwPVILAx8MrnmhTsBieN7whHggTuIaEVYuggv1VbVHExBcpPKbniAvkIagOYXi10yT7BCEsF7c4tcTfi--Y8OlSLrRMutQZP6q82Kx-k3zlBTv3QD_D5h-dsUnbxxcg9WhA627fJUo5EgyXysNr9eMqOEg_ln3zCjvs-i4l6ms1EfDhP2WBvtNnE89o3TTr6M92x0tbxCW0CdCWvSoD4EGaGP1xoHI54cQ-ItV8bpmfy5xBgPWynPIub3j3HLH1hA3pjjFzls2ivzDaI7Ub1ysDIRNzcLZkwREXQPYLo-RabPY4t-07Wm2eZ2_BUdl2vdQL354neJ0k9HIEoRSJkW_GsPQFmGBKxzLkqerEzlSiA','2024-02-20 10:02:43',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDg5NDE3NjMsIm5iZiI6MTcwODMzNjk2MywiaWF0IjoxNzA4MzM2OTYzfQ.UPJZeWqaor_Xa_OAD4oWtyTMZOlCJ-_J3hYJ0CgHLvSPtnqVX-q2TUlk1F2bsU8wVnX61sanNg_ppo7koBKiWLolVzIYwnd_M2ps-BsRIv43VrGpleNExEPdNLplEDwTUTyq5AaQdQ510ufw4RFFRriSuBdMostuQYPxxPe9aG9-l07ssCSRno6McSAsiqknGhgu2oGPNd9EqLT4VIUHXgE6m2HV5YiPGcs9LNZ8y78nc0NNNCToIMk4KTHyXuy4GXsRPxWPt0XbQJy21Aw_UBqzLFN1nSCubQOxaABreJFCk2jxvmP7W-4YMPZSsJTFmF7ZxF8WR0NcIh7frs1CjC0eNGhI01zl4Q8-qONZWj42SWEBzXvR_i7NzPAv44Hq6EHJyUBGaevTXfHyuYe1ANWamjcRJMOg7nl6OwwI6OgYoYiooDB3NwlEEBKfITZm3iftmhVxEGaQ_LaM8rXT-ZxiU_DgklYLh0KPqDc0HY-EWTPcioUseK3fvWvRmBeZIwUzXjelVqbDQMOKV3vYSklGihkswUeC96g3hiaN9X0BUmtKGnnkCVLnPJaSjjg44P5399b0b_yINtfM3nKNpKDZ10pjM31B_kJVX39QcqXU69NT9obVBMmCz8JoTEhLrqbznCbspLaHVrGaWL57AYDi7bIyZANFGe_YVpHdDgM','2024-02-26 10:02:43',0,''),
	(3148,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODQzMDMzMywibmJmIjoxNzA4MzQzOTMzLCJpYXQiOjE3MDgzNDM5MzN9.B2khAl55OYyXuyhnBxJIlwroKax7xonjCwlcypzpWNy8OosLfjL2jymQLsuAwtbd1JgVeiJxpeKiMubFw7ONPH61nZzYdpYyVOVRlqudgR8Pj92mR3zOjgDMjtK_3R-N1L8VzwQQYsDtWBpifxP1sKaBfRCJC4taLu-Tu-jb5JWsXa_2rNV2LKhJu3f_E6ojb1kH8r3N2gx4QtpWWXBQSK5zFDaSRobxsri0HB4oq23LdWAzj6l5lJ_UwZnu29Cxa8oUGEH4Inw5ab0ta41GJhDmP1LCtsOMaIoyVQNK4RaTDdhPtZnkfr17ZSJPfSKH9jld0xxZ6buyUHz3GZDi4PEBG4DgeTih1yWKJQ4nc0gmKky1julhAu77hpaumYML8dsAIIZTBRfLVSyCyYSUf15awG1UXbS7M6woxUsR_Bu9N0vU9uhFhxC5p_2nEuYPiy9_147lH338zNEJEVQ-6rfCnTNw6GgOYQC9rHUFLS9ftGyYHz-DILVdj15cLZA6yJ9AqcplcBwdzbsPC2-eoAL0S0ZvcMaltW-H2LMmpzuFPLIRCipesMNA17AzhlRiM8gnxV5E2_131PkrPkirQtMZ-gMLA3TUpxaNaxHsw8tZM2RodGNkAKk47siD26lgZxtWUN_12K6zC4JP0zf3pfmEDUR9kdunp-o5EoAAqC8','2024-02-20 11:58:53',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDg5NDg3MzMsIm5iZiI6MTcwODM0MzkzMywiaWF0IjoxNzA4MzQzOTMzfQ.dJDbONMRKzdHdKac2BOSJIENwZfThvILHSU8-GbQvu_zaGIX3ps4sOmdqAuzvRfl3XBz-Kb2Pl5LEO0sKm7yQmSLNgJGozD4xKV3gJ1KpCHhsy30IArJdiVafSrBBgQ4lok_TuzkpUPi9RiA2OlmfYN66x1x-ZKG5LsiSRv_1s5k7J3gqJTmtDZowinH1FfUkx1zYzoe3Lf0AJ6XL0TzER8nOj3RTAAGDibdInZ8of7aKL5xRmaeiONjRGps9mAzqdMQIL0nTQxVi81lpo_p2p52cRWJxmBMJub8twtTQCdehXjMFwRpHpOI7q0c1qVb23vEYrksHqMKeL0FrGj2JD_4wSS3FlOZjlp9hR3ymGfeIi4ZZhkRXZ4hjgOYqt9p-KFCiRWLX_3UYFSjJNM5jLiWa9jfE8SPJG03BH0SMSZTSOqtE7v7kBRjOjtTrzK50Cn_oqoh-5qINjCy9zFOGlGLzsa5rco7BGguE1PY1GLGmFd4YDvqe_SffC8g7SJdfshamsnrCdNWtk4V7ZmewU4h2I5gqIo5G0mcjTlYryGIBfAaI0XewNc3Y--IiXT8j7-VCbRjFichL8d4dHfDTTvLSeHq37KjOCz8_WJIMzE6LM2aZd6OX_0K07eQ2ScRk3AZ_4ZfQoi8ROqPDf6ki6fKxqB41xXMZ3qO_UZe1Vs','2024-02-26 11:58:53',0,''),
	(3149,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODQ4MjY3MSwibmJmIjoxNzA4Mzk2MjcxLCJpYXQiOjE3MDgzOTYyNzF9.rNQjpILV1lFw5caer7PMC6lPwIFsLDVjClHitBJ0kx1KWHUm4DRUPBHHF2a5Zsq8jq2N3b5Q_8XM0FE6mcFMgt2WwxgcaUIOcKljYrzhdAk7ZQc16VdNIQTPXZyYxI5yxrAr1nRUyQlXBFAAJLMNrovCBOQZRYiOjRlokuSue4vLOtXaYmjXenvQvX7KN43mHytWxi82OpB_5AKOvO6pMEGrS0rzC5XD1u60jSGxuSReXxN0g1V7Wm6Crp2NZAYFjY5BVtDmUjAMxYiw3YXmdmU6v49IMBvywavayj7bnyMuLcHFPWVAHu_iri06x4ezP1KJTRb1GvGHNCLa5xCMTgaHga6ZRnTce2AIJ8EGIDqcJe2SjyaVuF4rzu-mbd4DNqAWuaUS9b_ARG5BYgoup719ZADv6HTeCA365dPUpxpemcqGGciOyGPje3vC5-5B5jf9bunwnsgJxRaUxQe1w3jUOtQW5fKE8QyCDyJXOovekT-HITbv2Rv66TJV9TE6mlRwhXfVcM_FmHVQovf94ct8S9n742XRjYCG48A43CD6rPwZu57kHOLHagBph0x7w26MUbQ7XRKxYm3QHgLAD5Bk32LEjVItpiJ3o1OBZ3Klv5j3POnpxxPWGTLSGzYFCgvYeCI08qMwbFs_qtMU7qlXu9AOEvKaD9e-C5WrhFU','2024-02-21 02:31:11',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDkwMDEwNzEsIm5iZiI6MTcwODM5NjI3MSwiaWF0IjoxNzA4Mzk2MjcxfQ.U3gDyhjN8cqg_6t3x3I84XfkH2a-Ky1q6dUhWzAlG4HH595JBb8BjOVbQPFPE14PBlFWdvk1j1cSNUsrW60qWDYMZTib_jYDwc3tq4Y1QRhm6KJBOk3Od_40WYKnw8ZObq3FqTFGTrAc1zvTAFK7TuadrYgVJe6x1Eed7QyJbgz6FErvh-Pbzj8TBQYwMDH4NZIdDyKOz1u4KEAvsbIQqTXXJDrW3m1Z1drT2ZHQP8-bOu9LAfqXmctcuXJGcwvcXFQ-FkMgQ3rxcfPnnMpw6jd4X7HHtDqg4S7Z9ruLZKftq4dKu7kFe52geIfXblQ2LSbUXv8aZcZRI-jUWRh_Cife6QDcNWNbMDSM31gSw-wb_b52Y_3vQ712iRrZKbiq2ebSV8XKrmIvU8S-KmKdddAVu5bCa2uk7WDEmmNDBPqPhfC8q4uYrF2UhhXWWVOBmDqSDZxl-WM5r0ENdGwPLS3D6RjmKS7kfPSzYxYKnpsvH9aGEqiTNfH9BrSZD9ShrYXYV2Ksr64bgu_UF_qYqkiNSkUGuXbITN-DiV8PY4KXpBPym2USFp7aNb8LE3tn3tPJZkRFqlJFbyvEJ9qRqgxJ-mscIm4KbPiLVK1wCJjFXsPQZjI20eC1B1Pa3rLIQHr9sb3PrkgsXCHDVlw8EeFGFp0pzlgfPVxzFCnR66I','2024-02-27 02:31:11',0,''),
	(3150,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODQ4NDA0NCwibmJmIjoxNzA4Mzk3NjQ0LCJpYXQiOjE3MDgzOTc2NDR9.X8P-Dm6e_NA8Kc7Lh-CFIaGkBFpGuZt0DZEiWOI88_05bIIE67QBxxopISpq-ypqYsd2BvkzSlsl7TIRAjvRFrcBj1YjY1bQWfVH_wYLRJQt4mpMGTbmWgd2WCKxBb2L43Z-zwjFVicNvvW2Ai025bBVX94p-i1FubDwtk8iVNB6PzP-GWXS0iQ5dfytN4YyWSJCE6KHOhRyxjwnsHExfnHKdIjzzWZcwqKU2R6Xm1P4XuScbeChLsygVpoMFfranoDWLFntYxjxIc1XT09FB5gcKFW4eRztVIpyKJz_DRuLZbPzeQRA7KcWcQjaEGPDqmVxyzG6j60kDTHskZhr92911QyPDWxOaO-ZvW2x7325-sxB3vw7s916OOJ_lQsA14le0rHL5MpZpiOTvP91RqycKXsg_G8oiX0mT4BYV5DNRHxv5ONk144pnIpUsjbjrkDNfI-sEtwPiyiYLxwenRgWBzzInpnfdYxsqmZWMitI0JPQ4iR09l8efZCDG395UKUABUjt04y9-C40O0rqpP5DdkdGmf7_ejbCZJ6ozfNVZf-4YuRLWtjus8C1F0V_nl4no9-bCwnVjZaKIbyW_-uZnP2CugMi2SeZq2MgawyyIOvnyzNyHcuEGA188kbUeXqtjxyK8rIWuHWt3PL-Lovi1nGXM3iD13TWaivdJ2M','2024-02-21 02:54:04',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDkwMDI0NDQsIm5iZiI6MTcwODM5NzY0NCwiaWF0IjoxNzA4Mzk3NjQ0fQ.ILNopw6WYNkVmUd6aF6QhYKvT6v9Ju1PGa_nfSvySj_tMJFAeuU2ICy97nvOVHuJZs9IJwZe3ppmzRWGXpuLcdNuszh2w4EHpoq0DPgYM_fLJxMWxNEBUi_78IaO1iQ6OAr5iGO8BRgkhyjGd-zgNwvMJ7a95ks8Pp7uI0FVtPdDPRvpw6ZDgYHFUw06teS2vHIxytQowIWh-D4WpEQxilGcoL2FrqoPD5A3CKEP2mruSBbqBytAn8ZRVgqbDvw60eDRC_ZNyqqJ5EcFWsapWz60f7PBpyEPCNCVkUy7GTlEYQxfssj3CEe0mNi8KKIiHq0loor4qT6aXe76Zqf3qfgziYkkEi8J3h5KDojYV_nS_NkHoVYEPiPkbtsnwch-_dlY81iGsUUEMhoyf8at7lFJQCVgthEfI1_IypqjN7xyNq5_glUUnVqhrTRAd2FLjpfF48m_Oof6HClhnDV9KkhFwG-Mz418u2se4tQ1Kftqy7g76NSw44b75ocrSOfkfQp0nNfN-F5OSJA0hBrYrXTQwruZChligCnkIQK2NKWTQ0R6u7hk954l5TVA2Fvp_oD76rKVZ-SDFQsFFHVnZgS6grk9xLbPAMN5MnWBJQR7u97SpU0q4RaEqHexwBGskGemfRcltTzI_jKXFj0957k3jJArkWhL86JPYD2b47E','2024-02-27 02:54:04',0,''),
	(3151,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODQ5MzgxNywibmJmIjoxNzA4NDA3NDE3LCJpYXQiOjE3MDg0MDc0MTd9.PNHdrxBZWYtGjt3WmS2M6SaYvT-ffU2uFY8P-IlAG7GcaszFwhQwb8vSqlzNUj-qiapDrKZUuxm9WHNcK5_hkRdbikOphFgw28MEEsgMV1VuMmhoCQynnMPBEmCrnosrNQqyJPIhX4YlCxtZJxPcuUChYcP04VdV1eVoP9to4tPRosxVAVDlA_rcVPERINhf_v2xqY7srrHQwTAqLuvlb-k3dRRP40eWUU7-ko7WMsY83Znzd6KeBN2T0yCMQ1ys7cj6Zi6FcPjnb3_9JIC06y_VkeapnKGJyFFSyPlqVLueP02cPfPbll8j-zqJ8fwGLPU9QPE9vw8ER3yucNh571BYpKLLyLTwiDFu9WJpZ2muM7coBHPdtXn4U-gCXmgFywEmH3_kEBa0S6XZPgknV_Xt7FP4uGhVEGaRWoR1bpO_AVSghTkOXFedqTKyj9pNIexKpf78jg61V6yGQQdexTV2V19Z1LIinAD-2R4ISP20I-3EscxGgRIW1_v3lxVKj22JRX6MhX2VYKDT77YbRKEvedQbnJHR0jkIHvIcvKcOgIPlHo_ReJY6NRkG6TH-nlsECWtnrKTUwrgC_F5gFRFrE-lLqdr1KdoxP8TWCaXnOLemxoNvjdbUFp4cTB6o4UTCx70K3l5kgR9a8NbUm9K-bRB-s5OfTIoD1SzkNIQ','2024-02-21 05:36:57',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDkwMTIyMTcsIm5iZiI6MTcwODQwNzQxNywiaWF0IjoxNzA4NDA3NDE3fQ.r0c5pKNYp3i9OJfHQwzfeNcH09hJArxA0d9AfHopQX3uL-tY5-XmBkNBxmUXkhk2W0B87yn5-1HakJ8GUKY3ev0hChoMQ_8q06bhNzKEzX4kyMCjVTyobky7izC2OT5iWTh981PoX99Hun3YhE8_gj97Vo49IqdyrQkueeItV3dnGUm-O9lVANxcFNulCMN1f7meA-ZsXElywzYyczZyoSXsKK7ATpWmBupwDyp8260iEWVu2ZLkuRq7LAKizvRLSjHWYVXlbFigumty-Z21iYyKqH__SSE_ZrxM2s0q5crsuJMwjyql2XJTwmYRlijBkKR-TqE7aTUewHGHxPq2VpWK4aN6mvZQ-9NyEfhXKSFMz3dFoJJyl22ICjthwMVV2NwH37VKZfoxYee9mcNLdEKtRPGQEL-wDxHtVMnRHAGi-dI09skPKDocv8EltTKz1TMXxvrq4FA9g15UDCEZw6YCh3p6lOQ9Oy5kr2pN1LbeBbwmSwDOfo6DKJK2UAFZ343JUNBqG26fm9lxLRCwHh8sN1BGqt7mmL4qxlxu2oMMJvgVYXWnZmstA6XmiithSdIKLqfkL6NPSmSwud123wBt_BaS76z-OtYvl9vjnwNLSil2fYd_Dxp0yJdwEfNPlFkmpvmPZEzrtFmN_pm_X90eHF8LKWqG2aYFDdA7n5E','2024-02-27 05:36:57',0,''),
	(3152,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODQ5Njk5NCwibmJmIjoxNzA4NDEwNTk0LCJpYXQiOjE3MDg0MTA1OTR9.jNWQpCeUOV7oIKIAay-OucTII3FqAW_gdqXM2xV1U33wC5AyKb7WwUocq_Yoa9CY5ICljj7WOGjhlo45CiUX8egALPLai_ur_9nI-zJVPxhFHJX1oQlybY08PlA51UTSUX6NZ37SN1vkTJvJXBZ981XCTc83Cp4TXieOL0BX7mSiqzu8k1kPx1ylEg0X132quT6-Bpp_A6N6hZnKSxO3NmpDFy3CDw_Rz6YkaKPZs4S03z2EES4FEfSstEBzIRI11-PzbJgksauiKjjaBGFEHLCJpvcJPwwexJLjnVSxA0aO8XjeOnFOZxz5R43CHN0YqI1I2fdlC4So0OpCRMB_dJvAEv6ISh0uGtA4hIuD8S0sveYR5cSI_hG8raE3Z_yY3tuQmKOh2uiykQ9X9F7Pjlhtqg1gAlLGDCKBKgxwjXo3B5Cjd6SwGkzLTN6wifB-ia_D1rrLxCKj4EXdFmFg6V_87XhvnT4zEnZ6p7etmxqOzZFvYAY6tOfyPtnrAmG2e8y4HbioXO0gre6xUPqowYNB2x7BieUH8CuQkpDROzHaEM4x25q2XQWCktutBSC2zZ3GBNR5T2uUMZP1nYCuJrQcoADYWeHPZuW6y8uSbmm1EKK1prrM06pI99tXuMg1sdI5MZzjWk_FjUZDRkV6AMaCcu8jtMMjU_pGYRMo_oI','2024-02-21 06:29:54',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDkwMTUzOTQsIm5iZiI6MTcwODQxMDU5NCwiaWF0IjoxNzA4NDEwNTk0fQ.u2ccSUjf0uKwJ3Dd0ZRTD7u9cSp6XN7cgt7OtoBRFzNxmi-iZffhlEU9SEVKAZMA39MNu2TFwCcwRQbDUuI3T6Zgs0bCouzp8Q99ejWSZyca3ybZ0n-pM8f1WWgEMHMWfmPTmwKap7p8BoSBA4bHYqFNDNpMLzJSaJukEopMSc-qW31eyq57Ux1wKDFdwudB5t0imIFOUot1qgPEPXaLOCN7j17hVMqrfjcUo2sNK7P68XEpNF3pGlxsLNTf1rhkeddLF5UxnaAXeYhSKDxy_25uGUkO4VRgMQ2UEQ5zR3LeDcO3sd0dqh0gIZQFVcDgszA_LeRIhhvGEU-EB2qS6XNBUFGRGhHud115gmLf0osM3xhObhXhyNsnRBWyaqc7L3yOra2SDf0w1M-Pz6AQfeE7fhMoK4eobBRYOwkVwDTy_zqkU9RMxBzxHuD_BNPoheah54kgfRWAXrGLkqyRvUjmTB5lNtqOUvM1aioCcWEkuk96yoDNbAH5bPrjzaxRn2biTFUUoaZWyzyYRBGQK8JxZfbY7iMAWrVPCqk2KgtVCnZ9JzMtZ82O-Deo_oh2o2bVSjOjXQEL_xSYMZiBG0rzPruPRawlQYTkZQKGqBy-nJ15UyzOBxLQZyhAb2w6afPBTWxKrQR-mMX3XBQMmENF4RYJB5aTG7GT9jhtCX8','2024-02-27 06:29:54',0,''),
	(3153,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODU4NTk5NiwibmJmIjoxNzA4NDk5NTk2LCJpYXQiOjE3MDg0OTk1OTZ9.LxhTeacPJVVAUPHcKR4QsjDnFhb8w6L7nlBvfSwnWCSFiibLnP4A9_fbBMayTudpW1cza7KVbxT-_KuWe1cV8MVBhTlbDMX00Dm2UMlqAyAhtoLOYqTs3P08JiU6ETKAH2mZlj_UeQ3ixl2YSbgBq2yxyoNWlzkUDgxf7wINRNgXE3kw5_RXt4WBhHZbK1-Os8UMkkiVwXzAuiz0zPLW4NXYshiZiXZxfy4YIk00PKTLlpC7q2GFFYnOCM_S1SYfXHzds2HPy1wP-q01VYavhv3KgY9a69MSZVKXQftHrtDWQZSaVIdyHjX2aRTruViAYj_Ba7j0ZdX36XJYNQ2wUkxc-gJK2biySzqiHBFpcjbxsEsbJ2PThZgnIW4ViD21yZuzaHwdGCabUgDyG0MLcomK4B7ha1_Ob-y9f7oMfHdSwOPM7OonCS2DWd0MA6AF3m5odevJpXXkwJSE64iypX59ciXaRX_JcgjC_b38NFgmt-W4W-9BZuc_TtXnMqxgnzdrLSA1Um1cOFUwMkoS5O7msn-B9EhJYo1YdGdYuaF0pqZid-KJ7aq3YzPyCPhuVpo1pWqQK0VgKoP7lJJrD9lTpL8JkDD6nbZ6hGG7pVnGIry1xRemUkShOdia6y44KRLcGxw8v8dOz0GifYanVK2GRPJ87-6Qpt19_b4wKws','2024-02-22 07:13:16',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDkxMDQzOTYsIm5iZiI6MTcwODQ5OTU5NiwiaWF0IjoxNzA4NDk5NTk2fQ.kajjiPxS5t1YaA5wQ7QY-c_ODJ2VaFoZw9zU5x1Cs7FLuAf5-LLZ_6_IrA8Nkx8vPnO2KTFM_ZmBfKCo8sjCWTETjupShuHqJ1qddVW5-oDeyOtnZVCX3XNx3-jaeJxnadlWHjs4cvubFvYiqdMlpXTnNQ8vM2dkAXhFu_CAiP2T3NsVNeJJZtZ4A2If72xCZ0Q1YdMZOmLbwtfp5BkBGQ2TaDgqcq7DckvRzO9nPkXM2ivhBle_6WSLZIYtNcPhZSbl2xq2474QLY03BRtG-6KkoDbcd04QZtA8RLr3bUsw_JM6VU7phcGFaxDzqDKx_TMGXCtc61WHfJj6DtWsz4HzIBbdWmobiaylE_thOuFcYg0zk7Fjqu1Bpg3R4DirhwSS7BHNpX3xDAvR3m3QhmFTZMoyXY_Sd9-0Gt59Xf2fPQGg2CwSYL6Mk3SNegYWYqU4bc2MDx7sfEyxn3iFy6Xdjs05GChGypUEggxhka1d7yoZBP5oxtmjmC-avXLXiCrbjzf9MQmIaXp0GJPOCQzyMDDoQpK0usjU5jEDXzN4EzU6dal8FX3X2lJaSADdsjlC2gZ-ttye6pGdC-Ht9Opb-iE3nRTWhZ7Kw2bXuZ5ua7Yzzf8y3wHlUsOXk20qmA4e432bOQbXhM9u6J1KdWnfCaxhwcFS1hS74eB3nCM','2024-02-28 07:13:16',0,''),
	(3154,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJhY2Nlc3MtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcwODY3MjU3NiwibmJmIjoxNzA4NTg2MTc2LCJpYXQiOjE3MDg1ODYxNzZ9.fIfqMuF2n4HV22YJdrpadnalgzVdCqppGWIicp4R229LSFgQmqjsb4tJ2Qfo1FtoM0WMfgJyjGCTK1fkELEmHnqPBlsniUfVPxeMWSycc0CcLgTGUtTpdxDtbpETvVYxizhLyhpJZuw8Wa-TV_0IiYdECbY8TOgL5_VaeXZVwwG59iQYXxwre3oxkuNVidjT_c9VGBfymljaxPClLBdoNSOjyFHyKfWk3zeOxhpP1lyM5Uz0iDMi8X9yJbQujiB57oG6djl7TEhW1NlZZl9Oic9CGPRrqbBclbCSc3bCDxRgSuSgJyix62iSl4DddqOVm20Pq0aa8z98hmPx_s71mO8ykuafzdYKM5swHaJAD9Qg9dFDjjPJ8h8CNUKWnQbmbGCxXb1FMibIVIc3S7Au886i35-3AnHVvIlfFr5i-I8v03xBdGzAvBDTTEPXRoA_h7EeUWmU5ggckJqe0Ub4ElZNSrMqLGk9u0LLbt3d9B19VBdU1FjbVE0G9Q89cZrbG4OvJAoxE5PblRci3qk-oTqCW5ZBfMg8qJc2ThXuwIPbnklrg3G0Xehp-yMi3hQn8lA_QPQr44zw0JvfG5k32P7dOzJWyLpW_sZPBIbx_usOiW_AGj8pTZGjheeigU7NBMFLldClbUQQFfLskZ4EroPw4X_n_fWYHBBJUgGfQKs','2024-02-23 07:16:16',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiIiLCJjcmVhdGVkX2F0IjoiMjAyNC0wMS0wNFQxMToyNToyNiswODowMCIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE3VDEzOjQ3OjA4KzA4OjAwIiwibmFtZSI6ImFkbWluIiwicGFzc3dvcmQiOiI0M2VlYzg3NGE1NzUxZmUyZjY4N2UwMGVhMGVlZGFkOSIsInBhc3N3b3JkU2FsdCI6Ik9EZEd2bndxcEgiLCJwYXNzd29yZFR5cGUiOiJtZDUiLCJwaG9uZSI6IjE4ODg4ODg4ODg4IiwiY291bnRyeUNvZGUiOiJDTiJ9LCJ0b2tlblR5cGUiOiJyZWZyZXNoLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDkxOTA5NzYsIm5iZiI6MTcwODU4NjE3NiwiaWF0IjoxNzA4NTg2MTc2fQ.Hc7-gDBGVaOrleeO_ho3hHdGs-Lm_bXxBaeKClYz4sT_E57XbHAWN6ENSlKGgOGiVv9xvqUI6qW1krM0WwfqusFYqHrbid7kOBww2bpMx0WCznaRTwl-8slws_y3QXSbOVuLBrgbKkI1PKPDDzjGtOToiPNtqQlavxeZfcqONw2Fjc65TMz4CaLS-ryeJ5lDCKYrpuVpwl8cc83y2aJ8qcnSjfAc1pXSd9owqe4p1BzlcZMpan6g9qhcercyj1716mIdLGOUEmDv3d3JRRWL__oy5guDvG0ef1QfPMBkKhayDqloShnWr3kArTwS8FazXw6YV94CXvGvWlEKSO75AJwvLPbaGcxd8vdJF9ZKP8BsIWb2ob-rq5MPUg-Yn7xVlhFzhjIu2MGXLnSxDl5ce4b650E1vojYmv6deaRrk3q2-pQm8zCWMFs0UNa14w46tjspD_f44CIneMnmyW1wNE9jPB5-Qz-Bc_dWvRXt0TS2yjIgjWn8-5NhKO0kxC391AhHIHSQycfVcgGZNaDsko3nww0lPXKo00U8VUQlEX9orqSP3dHadeNFv4-fLmIsZxBusWWZsKWNguZCzzN688LRalADP8xPVrNQwW0tw6jyc7xioiUczHkcEMsTCV7dbnxO5tjcpgUQjYMaY2CWmK898acPJr_ZmW2ok2ClNeg','2024-02-29 07:16:16',0,''),
	(3155,'82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiJodHRwczovL3Rlc3QtMTMxNDk4NTkyOC5jb3MuYXAtbmFuamluZy5teXFjbG91ZC5jb20vL2F2YXRhci8zMjEyLzg5ZTY5NDNjNTY5ZmE0MTEuanBnIiwiY3JlYXRlZF9hdCI6IjIwMjQtMDEtMDRUMTE6MjU6MjYrMDg6MDAiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wMi0yMVQxNToxNDowMiswODowMCIsIm5hbWUiOiJhZG1pbiIsInBhc3N3b3JkIjoiNDNlZWM4NzRhNTc1MWZlMmY2ODdlMDBlYTBlZWRhZDkiLCJwYXNzd29yZFNhbHQiOiJPRGRHdm53cXBIIiwicGFzc3dvcmRUeXBlIjoibWQ1IiwicGhvbmUiOiIxODg4ODg4ODg4OCIsImNvdW50cnlDb2RlIjoiQ04ifSwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwiaXNzIjoiZmlyZWJvb20iLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJleHAiOjE3MDk2MzUzNjAsIm5iZiI6MTcwOTU0ODk2MCwiaWF0IjoxNzA5NTQ4OTYwfQ.qerlIlY5xU5QH_iuRhjMejUF49ihNF24Z_SZ4qb-_O58UUX5QYqf0XRIknKYI8-Q9OqMZTSKkbMQD9uGJfkPsL068-FonY4YfMYtdy8nF4qJ5oTJ900xor5mdu7yYGgqhEAD177ZfOaMolTmeB_GlFoojzL75HJpQkR-tDY8krWDxztAfB2R6H4LzKe5srbDsEumTjR8juEUnpNdU4lv-q0f8vgMZyRHYF1qqBI_GApIxteNUb9JuLCIolIln0-U2IlBs0Z-dyakPKbOaKM8O2ErNTEx4P3nvTqK4Y4a-TgG-fWoazbbktC7GDVK-MGpHJtYq6Aktdg-6lWLCk7I9rhR4yHGzr8qYbM4tXvEv_EK6OMQjbTzKdUoK-zTr56UDxEPMngJQfG5M510E5QkdMzxrUP45uIlMYyEMJwY0KaU-VRqngeL-4cwX8k5RMNf5SEnc3TP-rfRGQ5m-gnmgDZidOFDsow3fhjIzCWBleaYaLy-KVzbSXKrGvqtXhj2WrEa_G5t-LUkmCyUYbmbkG55WdrXIWtVtGiFhxzpm0VQG4zSIMS9KaGgXSj1P1Ilp096ppXRi-LBIrwtAzP-iglnB4JnwiC_I9tcmHI2CLcQMkK6LypgWUJtyyTM7KcL86UUCVFUB3356KmtBkzm-IVDhRAgjPZ4tWeeQWJi4GY','2024-03-05 10:42:40',NULL,'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJhdmF0YXIiOiJodHRwczovL3Rlc3QtMTMxNDk4NTkyOC5jb3MuYXAtbmFuamluZy5teXFjbG91ZC5jb20vL2F2YXRhci8zMjEyLzg5ZTY5NDNjNTY5ZmE0MTEuanBnIiwiY3JlYXRlZF9hdCI6IjIwMjQtMDEtMDRUMTE6MjU6MjYrMDg6MDAiLCJ1cGRhdGVkX2F0IjoiMjAyNC0wMi0yMVQxNToxNDowMiswODowMCIsIm5hbWUiOiJhZG1pbiIsInBhc3N3b3JkIjoiNDNlZWM4NzRhNTc1MWZlMmY2ODdlMDBlYTBlZWRhZDkiLCJwYXNzd29yZFNhbHQiOiJPRGRHdm53cXBIIiwicGFzc3dvcmRUeXBlIjoibWQ1IiwicGhvbmUiOiIxODg4ODg4ODg4OCIsImNvdW50cnlDb2RlIjoiQ04ifSwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsImlzcyI6ImZpcmVib29tIiwic3ViIjoiODIzMTMwMzQtZTk3ZC00YzMwLThlOTYtYzUyNGE3NzJiNTMwIiwiZXhwIjoxNzEwMTUzNzYwLCJuYmYiOjE3MDk1NDg5NjAsImlhdCI6MTcwOTU0ODk2MH0.EoPtQnQVQMcVsarKsPi8GRT7ZNqJVGYW67iR-PvyKuc1cElu0Uph20dIZ36crwdBYuQhatbXbFBq2sel-X5PqnzHGwqoRwnMrdL1Fdpwv-QpdziCFKJeBob0Io51HSxbh6dA203XPWMyPkKddNDzvPYCwxcYhcawPWZpawvdAKGISCrExYveiq2lBv0C_Vv5efK00npccbWNLwm4Ikfh0-uTzXHux5cA2cX7m-6moK_znXHHNMTLN8wLZjmcanDpuG_yez_k0u2nUTc7Ji4M9WLvK2EebutSd6fmU7ARtPsVxDqWD614hvm0SXvGPTaXK9207UWutY_C9LUTck050VnZWCqx00L1rLpUhrHmCB3eWjmWscUgaOYhFzYRP-AZy5RFSzGw22EcPkOYNthwpxyQIjXr8UGFq1BVVb1KaHYSw5pXpfRH_BxiUoEefy4vDed9UpjHXkMQfuzO8WzKh6do4IJVsvR0UvUEYBINMSm4v75DzkmS_VQagVHA8s5CASE8j6CKtYa6LtEEyQCuWSmznoAolv2tE8kIIZ1BTpBUSJpHwQEbA2SkyLFnJ-gnz7e7CP4hRQvrdlhJcC_tziTL4pE6Im5bn4APnCZopkaH4tVtT_vljKAsMPBrtLjY1cohiaqPJ-TdqAPqnz-mqanvfzZrzK-lrq-WQrX-pX8','2024-03-11 10:42:40',0,'');

/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `password_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password_salt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `wx_unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_user_id_key` (`user_id`),
  UNIQUE KEY `user_unique_key` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户表';

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`)
VALUES
	(3212,'82313034-e97d-4c30-8e96-c524a772b530','2024-01-04 03:25:26','2024-02-21 07:14:02','admin','https://test-1314985928.cos.ap-nanjing.myqcloud.com//avatar/3212/89e6943c569fa411.jpg','md5','ODdGvnwqpH','43eec874a5751fe2f687e00ea0eedad9','18888888888','CN',NULL),
	(3264,'f09c5638-958c-46ab-b112-80f27d07a693','2024-01-15 15:35:11','2024-01-16 08:28:50','WxUser','https://test-1314985928.cos.ap-nanjing.myqcloud.com//avatar/f09c5638-958c-46ab-b112-80f27d07a693/956bf4f1097fd8f7.jpg','','','111','18352538615','CN','o0-C56KNbOU4gDwLqhEsvjIH1fk0'),
	(3265,'10c62a0e-0f55-4016-88bc-fbb904584601','2024-01-17 01:30:32',NULL,'admin1','','md5','ODdGvnwqpH','43eec874a5751fe2f687e00ea0eedad9','13800138001','cn',NULL),
	(3267,'2249d8f0-93af-4f40-acb9-c3451c735bc4','2024-01-19 09:44:06',NULL,'Lily','','md5','dFqdtqPqdLFy','1989eb8d583da6e1dc13b405d26a9bea','12312321321','CN',''),
	(3268,'7ff2d6bc-d40e-4c11-81a5-3c076c8df580','2024-01-19 10:15:21',NULL,'11111111111','','md5','DVYTxrYwoDfq','7a2fe140c4eae98766217b13de7f7c68','11111111111','CN',''),
	(3269,'9c4fa19d-47f0-42cd-a675-cb8f0b982f88','2024-01-19 10:17:29',NULL,'12312312312','','md5','ysCKQxLCZQgs','c3f00aa04cbf7282d81c3eccc8c5e1aa','12312312312','CN',''),
	(3270,'fe92aba6-52fc-40ba-8f65-f3f532540dfd','2024-01-19 10:24:33',NULL,'12322111111','','md5','PUNkiiIJRsJF','4963c6b714859c9186d2a24afea9578a','12322111111','CN',''),
	(3271,'2f91a71c-2052-40c6-b518-3e7298b6f379','2024-01-19 10:32:14',NULL,'Lily','','md5','hmeNJtmuqXDh','87ebb9c9195b2c02530b8cbb0e87a5f0','11123123121','CN',''),
	(3272,'11023716-13e4-494a-8d70-f3e6c1936f8f','2024-01-19 10:47:07',NULL,'Lily','','md5','lgfVlJoThQlK','27a2009745adae4a3574266ba1af912c','12323121231','CN',''),
	(3273,'5805bf77-5ad1-427f-a12c-05c370b6a6cb','2024-01-19 10:49:52',NULL,'WxUser','','','','','17755003380','CN','o0-C56JLWJbbRQpwcFTVWsbWhChU'),
	(3274,'83d02c1b-63df-4f79-8e39-51e8c3002559','2024-01-19 10:50:02',NULL,'17755003380','','md5','aYvkAvYnPBcX','44ff3d6cd0d0acea44ea79e9bc6e37ff','17755003380','CN',''),
	(3275,'4511b8cf-650b-471d-b928-b7130cde570c','2024-01-19 10:50:19',NULL,'Lily','','md5','ykqCmWSlJEug','b6f4c21f2b914c1a625c812c93f86072','12312312311','CN','');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 usersocial
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usersocial`;

CREATE TABLE `usersocial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) DEFAULT NULL,
  `provider` varchar(64) NOT NULL,
  `provider_user_id` varchar(64) NOT NULL,
  `provider_platform` varchar(64) DEFAULT NULL,
  `provider_unionid` varchar(64) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usersocial_pk` (`provider_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# 转储表 userwx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userwx`;

CREATE TABLE `userwx` (
  `created_at` varchar(100) DEFAULT NULL,
  `unionid` varchar(100) NOT NULL,
  `openid` varchar(100) NOT NULL,
  `platform` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`unionid`,`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# 转储表 verificationrecord
# ------------------------------------------------------------

DROP TABLE IF EXISTS `verificationrecord`;

CREATE TABLE `verificationrecord` (
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `receiver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time` bigint NOT NULL,
  `is_used` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
