alter user 'root'@'%' identified with mysql_native_password by '123456';
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

DROP DATABASE IF EXISTS oidc;
CREATE DATABASE oidc;
-- SHOW DATABASES;
USE oidc;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

SET NAMES utf8mb4;


# 转储表 admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_log`;

CREATE TABLE `admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ua` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error` text COLLATE utf8mb4_unicode_ci,
  `userId` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `requestId` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `admin_log_userId_fkey` (`userId`),
  CONSTRAINT `admin_log_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


# 转储表 admin_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_menu`;

CREATE TABLE `admin_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` longtext COLLATE utf8mb4_unicode_ci,
  `sort` int NOT NULL,
  `level` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `parentId` int DEFAULT NULL,
  `permission` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updatedAt` datetime NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schema` text COLLATE utf8mb4_unicode_ci,
  `visibleInMenu` tinyint(1) NOT NULL DEFAULT '1',
  `apis` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  KEY `admin_menu_role_menuId_fkey` (`menuId`),
  KEY `admin_menu_role_roleId_fkey` (`roleId`),
  CONSTRAINT `admin_menu_role_menuId_fkey` FOREIGN KEY (`menuId`) REFERENCES `admin_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admin_menu_role_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `admin_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `admin_menu_role` WRITE;
/*!40000 ALTER TABLE `admin_menu_role` DISABLE KEYS */;

INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`)
VALUES
	(100,'2024-01-25 10:08:46',17,2),
	(112,'2024-01-03 06:04:55',14,1),
	(114,'2024-01-03 06:14:29',7,1),
	(116,'2024-01-03 06:25:34',8,1),
	(117,'2024-01-03 06:26:15',9,1),
	(118,'2024-01-03 06:26:31',15,1);

/*!40000 ALTER TABLE `admin_menu_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 admin_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_role`;

CREATE TABLE `admin_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `admin_role` WRITE;
/*!40000 ALTER TABLE `admin_role` DISABLE KEYS */;

INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`)
VALUES
	(1,'admin','管理员','','2023-12-22 23:58:09','2024-01-03 06:04:54'),
	(2,'user','用户','','2023-12-23 01:16:44','2023-12-27 10:08:46');

/*!40000 ALTER TABLE `admin_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 admin_role_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_role_user`;

CREATE TABLE `admin_role_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `roleId` int NOT NULL,
  `userId` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_role_user_roleId_userId_key` (`roleId`,`userId`),
  CONSTRAINT `admin_role_user_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `admin_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `admin_role_user` WRITE;
/*!40000 ALTER TABLE `admin_role_user` DISABLE KEYS */;

INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`)
VALUES
	(10,'2023-12-27 08:29:33',2,'2f329bed-596b-4eed-a27d-0cb7f498cfe3'),
	(20,'2023-12-28 08:29:51',2,'ddfda1ba-228d-412a-a09a-08bad895380e'),
	(38,'2023-12-31 22:26:34',1,'c8da8e37-9596-4290-b794-fed4a12d3760'),
	(42,'2024-01-03 08:09:29',1,'292d2b68-65bc-4c9f-b27e-292853f3b3bc'),
	(43,'2024-01-04 05:48:06',1,'82313034-e97d-4c30-8e96-c524a772b530'),
	(46,'2024-01-05 12:41:06',1,'123');

/*!40000 ALTER TABLE `admin_role_user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 demo_area
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demo_area`;

CREATE TABLE `demo_area` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `code` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parentCode` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `demo_area_pk2` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


# 转储表 demo_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demo_post`;

CREATE TABLE `demo_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL,
  `title` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `poster` text COLLATE utf8mb4_unicode_ci,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoryId` int DEFAULT NULL,
  `authorId` int DEFAULT NULL,
  `likes` int NOT NULL DEFAULT '0',
  `views` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `demo_post_authorId_fkey` (`authorId`),
  KEY `demo_post_categoryId_authorId_idx` (`categoryId`,`authorId`),
  KEY `demo_post_categoryId_fkey` (`categoryId`),
  CONSTRAINT `demo_post_authorId_fkey` FOREIGN KEY (`authorId`) REFERENCES `demo_post_author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `demo_post_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `demo_post_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `owner` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_secret` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sign_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`owner`,`name`),
  UNIQUE KEY `UQE_provider_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


# 转储表 token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `token`;

CREATE TABLE `token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `platform` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `expire_time` datetime DEFAULT NULL,
  `refresh_token` text COLLATE utf8mb4_unicode_ci,
  `refresh_expire_time` datetime DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;

INSERT INTO `token` (`id`, `platform`, `user_id`, `token`, `created_at`, `expire_time`, `refresh_token`, `refresh_expire_time`, `banned`)
VALUES
	(1,'','82313034-e97d-4c30-8e96-c524a772b530','eyJhbGciOiJSUzI1NiIsImtpZCI6ImZpcmVib29tIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJuYW1lIjoiYWRtaW4iLCJwaG9uZSI6IjE4ODg4ODg4ODg4In0sInRva2VuVHlwZSI6ImFjY2Vzcy10b2tlbiIsImlzcyI6ImZpcmVib29tIiwic3ViIjoiODIzMTMwMzQtZTk3ZC00YzMwLThlOTYtYzUyNGE3NzJiNTMwIiwiZXhwIjoxNzA5ODY0MzEwLCJuYmYiOjE3MDk3Nzc5MTAsImlhdCI6MTcwOTc3NzkxMH0.bgyXHLNE6g3u5eIVGarNJrudlNsGLXpdnXYSLA5EpB1bHIW5z5n0WbJP5NA9WmsKe_7yc9sJos9n9wu3FzKwy-l7tFrLtKiq9jWOE8JQ7-QO_dnsqyPXZLhSYirr5d3xk4F_zxgkDFhCY_Ifd5dni7JdJ7G6CJEvGtepSdQ2MB2uo5b_R00_LrvB0RSc_QLgZuUYc_5_xj_CSatiNdJOQivVogV0z4Xp25-fcfRPVxWgBQ-CGhrUnuBmLKc7qDGdzjoAwsRITU2OpwEiAfnZPilnpPg62muzMHjXW2FnqyMi66IyugbcIqBfGrbmMPqCDPvb5ZOpQuJe3iqQcgNeX_cgqvzPK85XlV3sRlnd6bTkPEKr7YTg0a7Jq-syqxoAaTOEwrymROUKRpvPBNBcaFF5S0diROr2-t3dfc1-GSaob4GX8j9n1GYDV8M15-tUzU005hJyjBiuowj0HQ7eNszNuHw5oR37LxrqW3xh9eVm1D-3NOapBbpD8Za8wBBMVfG62k73etvAoY4ySi-WL-rcj1vxTzzaUSOvaluRt69YqpMgfLs_DUEGUoTaH5PFobjemYx3aBcm3LgmB4B1987jd4fHdTMYNHlHll0sNjVyOsUY-ALxWDaOqu78ibLN5oshG1PYjUKO-7HtmlqJfQ48976vX0ONJ1uduuh9VQQ','2024-03-07 02:18:30','2024-03-08 02:18:30','eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6eyJ1c2VySWQiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJzdWIiOiI4MjMxMzAzNC1lOTdkLTRjMzAtOGU5Ni1jNTI0YTc3MmI1MzAiLCJuYW1lIjoiYWRtaW4iLCJwaG9uZSI6IjE4ODg4ODg4ODg4In0sInRva2VuVHlwZSI6InJlZnJlc2gtdG9rZW4iLCJpc3MiOiJmaXJlYm9vbSIsInN1YiI6IjgyMzEzMDM0LWU5N2QtNGMzMC04ZTk2LWM1MjRhNzcyYjUzMCIsImV4cCI6MTcxMDM4MjcxMCwibmJmIjoxNzA5Nzc3OTEwLCJpYXQiOjE3MDk3Nzc5MTB9.FROB_5nuckXlRwzASjI5_DWN0ji6WWM9gWgW5IWVPW4u_ic-wyfxGCRb9sPyT1GGC9L7N8OLec5H130b1-7YCTOEHkvgMBFHt9BgjA3Mjx050boPjCEFbXmb_-Vzzb5163iDmSwXVfv6-sj2MCF4A0NMnP3YU_p75qjAhMADfI01gjWACouDh9gkOPYEYQ5daCrjxtM7wbt6hgpQNsLIERYFM_JgB3SBR3ondOaIpa6bzeqfFSnzCw_K7kJdOfg576WNfh6vysS3X-deWG-9_0yowA0gpR9P6W_ljXTr7XndwMLlSqTI9cJPG0YldASuq1-V7iR4BjLlXV99S0mZE9TIqzly7fqJAYmYjlo_byLhxtRfWR8lVxkoLHhjViBo7wvRrAJC0fYSc1FOoxU9-PR4Vt7FEWI2afxKOqMXoxU7_soP1Oy_Hwdu7e__hwn2P7K0_d8sCBMFIUUeGEuPn4gdArRI3DfR9L3yaYZHouyx5moGQY-G8ptGJuT-q8d9-VEKYZRxFgy6xpcQN7wAEaaEOC_wwvVnGa3iDOwx_rSjV5tijTWfACDf-6f62CQRGaAVLZMVJXB-mTS46vsXiWaEW7VElH7yMfxyepuybI0P0pe8aZ6VZXWGuDVcFs_VGG0w_wnhSP28fVNsEOwwYickqNtaMDK0Ub6n5-c30Hw','2024-03-14 02:18:30',0);

/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_salt` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_id_key` (`user_id`),
  KEY `IDX_user_name` (`name`),
  KEY `IDX_user_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `user_id`, `avatar`, `created_at`, `updated_at`, `name`, `password`, `password_salt`, `password_type`, `phone`, `country_code`)
VALUES
	(3212,'82313034-e97d-4c30-8e96-c524a772b530','','2024-01-04 03:25:26','2024-01-17 05:47:08','admin','43eec874a5751fe2f687e00ea0eedad9','ODdGvnwqpH','md5','18888888888','CN');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 user_social
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_social`;

CREATE TABLE `user_social` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_user_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_platform` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_unionid` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_user_social_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


# 转储表 verification_record
# ------------------------------------------------------------

DROP TABLE IF EXISTS `verification_record`;

CREATE TABLE `verification_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_used` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
