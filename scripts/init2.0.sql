alter user 'root'@'%' identified with mysql_native_password by '123456';
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

DROP DATABASE IF EXISTS oidc;
CREATE DATABASE oidc;
-- SHOW DATABASES;
USE oidc;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_log`;
CREATE TABLE `admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `ua` varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  `method` varchar(16) COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(512) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `error` text COLLATE utf8mb4_general_ci,
  `userId` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `requestId` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `body` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `admin_log_userId_fkey` (`userId`),
  CONSTRAINT `admin_log_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `icon` longtext COLLATE utf8mb4_general_ci,
  `sort` int NOT NULL,
  `level` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `parentId` int DEFAULT NULL,
  `permission` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `updatedAt` datetime NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `schema` text COLLATE utf8mb4_general_ci,
  `visibleInMenu` tinyint(1) NOT NULL DEFAULT '1',
  `apis` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
BEGIN;
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (1, '首页', '/dashboard', 'https://icons.fireboom.io/tabler/icons/home-2.svg', 0, 1, '2023-12-22 23:59:07', 1, NULL, 'C', '2024-01-19 05:37:53', NULL, '{\"id\":\"u:168f33e720c6\",\"body\":[{\"type\":\"tpl\",\"tpl\":\"欢迎使用Fireboom 管理后台\",\"inline\":true,\"wrapperComponent\":\"\",\"id\":\"u:989199fa8ca4\",\"editorState\":\"default\"},{\"type\":\"crud\",\"syncLocation\":false,\"api\":{\"method\":\"get\",\"url\":\"/operations/AIApps/GetAIAppList\"},\"columns\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"text\",\"id\":\"u:44c801223699\"},{\"name\":\"engine\",\"label\":\"渲染引擎\",\"type\":\"text\",\"id\":\"u:7be09a66b547\"},{\"type\":\"operation\",\"label\":\"操作\",\"buttons\":[{\"label\":\"编辑\",\"type\":\"button\",\"actionType\":\"dialog\",\"level\":\"link\",\"editorSetting\":{\"behavior\":\"update\"},\"dialog\":{\"title\":\"编辑\",\"body\":{\"type\":\"form\",\"api\":\"xxx/update\",\"body\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"input-text\"},{\"name\":\"engine\",\"label\":\"渲染引擎\",\"type\":\"input-text\"}]}},\"id\":\"u:06f3d0ce8cf0\"},{\"type\":\"button\",\"label\":\"删除\",\"actionType\":\"ajax\",\"level\":\"link\",\"className\":\"text-danger\",\"confirmText\":\"确定要删除？\",\"api\":{\"method\":\"post\",\"url\":\"/operations/AIApps/GetAIAppList\"},\"editorSetting\":{\"behavior\":\"delete\"},\"id\":\"u:eb667018be8b\"}],\"id\":\"u:8866bf8c5fb2\"}],\"bulkActions\":[{\"type\":\"button\",\"level\":\"danger\",\"label\":\"批量删除\",\"actionType\":\"ajax\",\"confirmText\":\"确定要删除？\",\"api\":\"/xxx/batch-delete\",\"editorSetting\":{\"behavior\":\"bulkDelete\"},\"id\":\"u:9ca7bd11878b\"}],\"itemActions\":[],\"headerToolbar\":[{\"label\":\"新增\",\"type\":\"button\",\"actionType\":\"dialog\",\"level\":\"primary\",\"editorSetting\":{\"behavior\":\"create\"},\"dialog\":{\"title\":\"新增\",\"body\":{\"type\":\"form\",\"api\":{\"method\":\"post\",\"url\":\"/operations/AIApps/GetAIAppList\"},\"body\":[{\"type\":\"input-text\",\"name\":\"id\",\"label\":\"ID\"},{\"type\":\"input-text\",\"name\":\"engine\",\"label\":\"渲染引擎\"}]}},\"id\":\"u:03e04b422c0d\",\"editorState\":\"default\",\"onEvent\":{\"click\":{\"weight\":0,\"actions\":[]}}},\"bulkActions\"],\"id\":\"u:5d50c8c37a72\"}],\"type\":\"page\"}', 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (3, '宠物管理', '/pet', '', 2, 1, '2023-12-25 09:34:21', 0, NULL, 'C', '2023-12-29 09:18:18', NULL, '{\"id\":\"u:f5f8512d97b1\",\"aside\":[],\"body\":[{\"type\":\"input-text\",\"label\":\"文本\",\"name\":\"text\",\"id\":\"u:b1ea8d695f46\"}],\"type\":\"page\"}', 0, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (7, '系统管理1', '/system', 'https://icons.fireboom.io/tabler/icons/settings-2.svg', 0, 1, '2023-12-25 13:01:23', NULL, NULL, 'M', '2024-01-21 08:32:18', NULL, NULL, 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (8, '用户管理', '/system/user', 'https://icons.fireboom.io/tabler/icons/user-bolt.svg', 1, 1, '2023-12-25 13:01:55', 7, NULL, 'C', '2024-01-03 07:33:13', NULL, NULL, 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (9, '角色管理', '/system/role', 'https://icons.fireboom.io/tabler/icons/password-user.svg', 2, 1, '2023-12-25 13:02:21', 7, NULL, 'C', '2024-01-03 07:34:54', NULL, NULL, 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (10, '宠物管理', '/pet', '', 2, 1, '2023-12-25 13:02:59', NULL, NULL, 'M', '2023-12-26 01:31:28', NULL, '{\"id\":\"u:f6ba3ea7e8c9\",\"type\":\"page\"}', 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (12, '商店管理', '/pet/shop', '', 2, 1, '2023-12-25 13:04:05', 10, NULL, 'C', '2023-12-25 13:04:05', NULL, NULL, 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (13, '财务管理', '/pet/finance', '', 1, 2, '2023-12-26 03:33:03', 10, 'pet:finance', 'F', '2023-12-26 03:33:39', NULL, NULL, 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (14, '菜单管理', '/system/menu', 'https://icons.fireboom.io/tabler/icons/menu-2.svg', 3, 1, '2023-12-26 03:34:36', 7, '', 'C', '2024-01-03 07:34:21', NULL, NULL, 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (15, '日志管理', '/system/log', 'https://icons.fireboom.io/tabler/icons/file-alert.svg', 4, 1, '2023-12-26 03:34:54', 7, '', 'C', '2024-01-03 07:34:00', NULL, NULL, 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (17, '文章管理2', '/post', 'https://icons.fireboom.io/tabler/icons/accessible.svg', 5, 1, '2023-12-28 07:48:07', 0, '', 'C', '2024-01-22 05:57:45', NULL, '{\"id\":\"u:0bbab368e4fb\",\"body\":[{\"type\":\"crud\",\"syncLocation\":false,\"api\":{\"method\":\"get\",\"url\":\"/operations/post/findMany?take=${perPage}&skip=${(page - 1) * perPage}\",\"messages\":{},\"requestAdaptor\":\"\",\"adaptor\":\"return {\\nstatus: 200,\\nmsg:\'123\'\\n}\"},\"columns\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"text\",\"id\":\"u:a8d27f94b75f\",\"placeholder\":\"-\",\"sortable\":true},{\"name\":\"title\",\"label\":\"title\",\"type\":\"text\",\"id\":\"u:0989a414609e\"},{\"type\":\"text\",\"label\":\"content\",\"name\":\"content\",\"id\":\"u:123a86e2f1d6\"},{\"type\":\"text\",\"label\":\"poster\",\"name\":\"poster\",\"id\":\"u:6853fd7bd9b1\"},{\"type\":\"date\",\"label\":\"createdAt\",\"name\":\"createdAt\",\"id\":\"u:cbd8f4930f2c\",\"sortable\":true},{\"type\":\"date\",\"label\":\"updatedAt\",\"name\":\"updatedAt\",\"id\":\"u:8e755df21c32\",\"sortable\":true},{\"type\":\"text\",\"label\":\"userId\",\"name\":\"userId\",\"id\":\"u:7fe5be390bd2\"},{\"type\":\"operation\",\"label\":\"Operation\",\"buttons\":[{\"label\":\"编辑\",\"type\":\"button\",\"actionType\":\"dialog\",\"editorSetting\":{\"behavior\":\"update\"},\"dialog\":{\"title\":\"Edit\",\"body\":{\"type\":\"form\",\"api\":\"/operations/post/updateOne\",\"body\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"input-text\"},{\"name\":\"title\",\"label\":\"title\",\"type\":\"input-text\"},{\"label\":\"content\",\"name\":\"content\",\"type\":\"input-text\"},{\"label\":\"poster\",\"name\":\"poster\",\"type\":\"input-text\"},{\"label\":\"createdAt\",\"name\":\"createdAt\",\"type\":\"input-date\"},{\"label\":\"updatedAt\",\"name\":\"updatedAt\",\"type\":\"input-date\"},{\"label\":\"userId\",\"name\":\"userId\",\"type\":\"input-text\"}],\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"}}},\"id\":\"u:c1aac64e730c\"},{\"label\":\"查看\",\"type\":\"button\",\"actionType\":\"dialog\",\"editorSetting\":{\"behavior\":\"view\"},\"dialog\":{\"title\":\"View details\",\"body\":{\"type\":\"form\",\"body\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"static\"},{\"name\":\"title\",\"label\":\"title\",\"type\":\"static\"},{\"label\":\"content\",\"name\":\"content\",\"type\":\"static\"},{\"label\":\"poster\",\"name\":\"poster\",\"type\":\"static\"},{\"label\":\"createdAt\",\"name\":\"createdAt\",\"type\":\"static\"},{\"label\":\"updatedAt\",\"name\":\"updatedAt\",\"type\":\"static\"},{\"label\":\"userId\",\"name\":\"userId\",\"type\":\"static\"}]}},\"id\":\"u:1fef6a4175c6\"},{\"type\":\"button\",\"label\":\"删除\",\"actionType\":\"ajax\",\"level\":\"danger\",\"confirmText\":\"确定删除?\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/deleteOne\",\"data\":{\"id\":\"${id}\"}},\"editorSetting\":{\"behavior\":\"delete\"},\"id\":\"u:9e04d51065f7\"}],\"id\":\"u:93736272a8f1\"}],\"bulkActions\":[{\"type\":\"button\",\"level\":\"danger\",\"label\":\"批量删除\",\"actionType\":\"ajax\",\"confirmText\":\"Are you sure to delete it?\",\"api\":\"/xxx/batch-delete\",\"editorSetting\":{\"behavior\":\"bulkDelete\"},\"id\":\"u:fb73af4ed02a\"}],\"itemActions\":[],\"headerToolbar\":[{\"label\":\"新增\",\"type\":\"button\",\"actionType\":\"dialog\",\"level\":\"primary\",\"editorSetting\":{\"behavior\":\"create\"},\"dialog\":{\"title\":\"Add\",\"body\":{\"type\":\"form\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/createOne\",\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"}},\"body\":[{\"type\":\"input-text\",\"name\":\"title\",\"label\":\"title\"},{\"type\":\"input-text\",\"name\":\"content\",\"label\":\"content\"},{\"type\":\"input-text\",\"name\":\"poster\",\"label\":\"poster\"},{\"type\":\"input-number\",\"name\":\"categoryId\",\"label\":\"categoryId\"}]}},\"id\":\"u:4c406438861b\"},\"bulkActions\"],\"id\":\"u:38b68e4b3cca\",\"perPageAvailable\":[10],\"messages\":{}}],\"type\":\"page\"}', 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (31, 'AiApps', '/aiapps', 'https://icons.fireboom.io/tabler/icons/123.svg', 1, 1, '2024-01-05 08:36:02', NULL, '', 'C', '2024-01-10 07:52:25', NULL, '{\n  \"id\": \"u:24dea3535d40\",\n  \"type\": \"page\",\n  \"body\": [\n    {\n      \"title\": \"AI应用列表\",\n      \"type\": \"crud\",\n      \"name\": \"crud\",\n      \"syncLocation\": false,\n      \"api\": {\n        \"method\": \"get\",\n        \"url\": \"/operations/WebpageMask/GetWebpageMaskList?take=${perPage}&skip=${(page - 1) * perPage}\",\n        \"headers\": { \"Authorization\": \"Bearer ${TOKEN}\" }\n      },\n      \"columns\": [\n        { \"name\": \"id\", \"label\": \"ID\", \"type\": \"text\", \"id\": \"u:33bfb35d3c50\" },\n        { \"type\": \"text\", \"name\": \"category\", \"label\": \"分类\", \"id\": \"u:bcf035fa4753\" },\n        { \"name\": \"name\", \"label\": \"名称\", \"type\": \"text\", \"id\": \"u:93e89ceaa20c\" },\n        { \"type\": \"text\", \"name\": \"description\", \"label\": \"描述\", \"id\": \"u:00a41d0155ee\" },\n        {\n          \"type\": \"image\",\n          \"name\": \"avatar\",\n          \"label\": \"头像\",\n          \"enlargeAble\": false,\n          \"width\": 40,\n          \"height\": 40,\n          \"id\": \"u:9692884290ec\"\n        },\n        { \"type\": \"status\", \"name\": \"recommended\", \"label\": \"是否精选\", \"id\": \"u:33dd85682fa3\" },\n        { \"type\": \"status\", \"label\": \"是否内置\", \"name\": \"builtin\", \"id\": \"u:85d0298c0fe3\" },\n        { \"type\": \"text\", \"name\": \"hot\", \"label\": \"热度\", \"id\": \"u:8051c14cc225\" },\n        { \"type\": \"text\", \"name\": \"prologue\", \"label\": \"欢迎语\", \"id\": \"u:07e74c90d864\" },\n        { \"type\": \"text\", \"name\": \"topics\", \"label\": \"话题\", \"id\": \"u:1ec05f2542a6\" },\n        { \"type\": \"text\", \"name\": \"sort\", \"label\": \"排序\", \"id\": \"u:b4b26967af4b\" },\n        {\n          \"type\": \"operation\",\n          \"label\": \"操作\",\n          \"width\": 120,\n          \"buttons\": [\n            {\n              \"label\": \"编辑\",\n              \"type\": \"button\",\n              \"actionType\": \"dialog\",\n              \"level\": \"link\",\n              \"dialog\": {\n                \"title\": \"编辑\",\n                \"body\": {\n                  \"type\": \"form\",\n                  \"api\": {\n                    \"url\": \"/operations/WebpageMask/UpdateOneWebpageMask\",\n                    \"headers\": { \"Authorization\": \"Bearer ${TOKEN}\" }\n                  },\n                  \"body\": [\n                    { \"name\": \"id\", \"label\": \"ID\", \"type\": \"input-text\", \"disable\": true },\n                    { \"name\": \"category\", \"label\": \"分类\", \"type\": \"input-text\", \"required\": true },\n                    { \"name\": \"name\", \"label\": \"名称\", \"type\": \"input-text\", \"required\": true },\n                    { \"name\": \"description\", \"label\": \"描述\", \"type\": \"input-text\", \"required\": true },\n                    {\n                      \"name\": \"avatar\",\n                      \"label\": \"头像\",\n                      \"type\": \"input-image\",\n                      \"required\": true,\n                      \"receiver\": {\n                        \"method\": \"post\",\n                        \"url\": \"/s3/freetalk/upload?directory=mask%2Fmask\",\n                        \"headers\": { \"X-Upload-Profile\": \"free\" },\n                        \"adaptor\": \"return {nstatus: 0,nmsg: \'\',ndata: {nvalue: \'https://ft-dev.oss-cn-shanghai.aliyuncs.com/${response.data[0].key}\'n}n}\"\n                      }\n                    },\n                    { \"name\": \"recommended\", \"label\": \"是否精选\", \"type\": \"checkbox\", \"value\": false },\n                    { \"label\": \"是否内置\", \"name\": \"builtin\", \"type\": \"checkbox\", \"value\": false },\n                    { \"name\": \"hot\", \"label\": \"热度\", \"type\": \"input-number\", \"required\": true, \"value\": 0 },\n                    { \"name\": \"prologue\", \"label\": \"欢迎语\", \"type\": \"input-text\", \"required\": true },\n                    { \"name\": \"topics\", \"label\": \"话题\", \"type\": \"input-text\", \"required\": true },\n                    { \"name\": \"sort\", \"label\": \"排序\", \"type\": \"input-number\", \"required\": true, \"value\": 0 }\n                  ]\n                }\n              },\n              \"id\": \"u:1454c0b9c4d1\"\n            },\n            {\n              \"type\": \"button\",\n              \"label\": \"删除\",\n              \"actionType\": \"ajax\",\n              \"level\": \"link\",\n              \"className\": \"text-danger\",\n              \"confirmText\": \"确定要删除？\",\n              \"api\": {\n                \"method\": \"post\",\n                \"url\": \"/operations/WebpageMask/DeleteOneWebpageMask\",\n                \"headers\": { \"Authorization\": \"Bearer ${TOKEN}\" },\n                \"data\": { \"id\": \"${id}\" }\n              },\n              \"id\": \"u:2d8a77315a4b\"\n            }\n          ],\n          \"id\": \"u:bd2e3e110b49\"\n        }\n      ],\n      \"bulkActions\": [\n        {\n          \"type\": \"button\",\n          \"level\": \"danger\",\n          \"label\": \"批量删除\",\n          \"confirmText\": \"确定要删除？\",\n          \"onEvent\": {\n            \"click\": {\n              \"weight\": 0,\n              \"actions\": [\n                {\n                  \"ignoreError\": false,\n                  \"outputVar\": \"responseResult\",\n                  \"actionType\": \"ajax\",\n                  \"options\": {},\n                  \"api\": {\n                    \"url\": \"/operations/WebpageMask/DeleteManyWebpageMask\",\n                    \"method\": \"post\",\n                    \"data\": { \"ids\": \"${split(ids, \',\')}\" },\n                    \"headers\": { \"Authorization\": \"Bearer ${TOKEN}\" },\n                    \"requestAdaptor\": \"\",\n                    \"adaptor\": \"\",\n                    \"messages\": {},\n                    \"dataType\": \"json\"\n                  }\n                },\n                { \"actionType\": \"reload\", \"target\": \"crud\" }\n              ]\n            }\n          },\n          \"id\": \"u:c2e110ca63d8\"\n        }\n      ],\n      \"itemActions\": [],\n      \"features\": [\"create\", \"filter\", \"bulkDelete\", \"update\", \"delete\"],\n      \"filterColumnCount\": 3,\n      \"headerToolbar\": [\n        {\n          \"label\": \"新增\",\n          \"type\": \"button\",\n          \"actionType\": \"dialog\",\n          \"level\": \"primary\",\n          \"editorSetting\": {\n            \"behavior\": \"create\"\n          },\n          \"dialog\": {\n            \"title\": \"新增\",\n            \"body\": {\n              \"type\": \"form\",\n              \"api\": {\n                \"method\": \"post\",\n                \"url\": \"/operations/WebpageMask/CreateOneWebpageMask\",\n                \"headers\": { \"Authorization\": \"Bearer ${TOKEN}\" }\n              },\n              \"body\": [\n                { \"type\": \"input-text\", \"name\": \"category\", \"label\": \"分类\", \"required\": true },\n                { \"type\": \"input-text\", \"name\": \"name\", \"label\": \"名称\", \"required\": true },\n                { \"type\": \"input-text\", \"name\": \"description\", \"label\": \"描述\", \"required\": true },\n                {\n                  \"type\": \"input-image\",\n                  \"name\": \"avatar\",\n                  \"label\": \"头像\",\n                  \"maxSize\": 102400,\n                  \"required\": true,\n                  \"receiver\": {\n                    \"method\": \"post\",\n                    \"url\": \"/s3/freetalk/upload?directory=mask%2Fmask\",\n                    \"headers\": { \"X-Upload-Profile\": \"free\" },\n                    \"adaptor\": \"return {\\nstatus: 0,\\nmsg: \'\',\\ndata: {\\nvalue: \'https://ft-dev.oss-cn-shanghai.aliyuncs.com/${response.data[0].key}\'\\n}\\n}\"\n                  }\n                },\n                { \"type\": \"checkbox\", \"name\": \"recommended\", \"label\": \"是否精选\" },\n                { \"type\": \"checkbox\", \"name\": \"builtin\", \"label\": \"是否内置\", \"value\": true },\n                { \"type\": \"input-number\", \"name\": \"hot\", \"label\": \"热度\", \"required\": true },\n                { \"type\": \"input-text\", \"name\": \"prologue\", \"label\": \"欢迎语\", \"required\": true },\n                { \"type\": \"input-text\", \"name\": \"topics\", \"label\": \"话题\", \"required\": true },\n                { \"type\": \"input-number\", \"name\": \"sort\", \"label\": \"排序\", \"required\": true, \"default\": 0 }\n              ]\n            }\n          },\n          \"id\": \"u:41ea90b2c2ee\"\n        },\n        \"bulkActions\",\n        \"reload\"\n      ],\n      \"perPage\": 10,\n      \"perPageAvailable\": [10],\n      \"messages\": {},\n      \"alwaysShowPagination\": true,\n      \"autoFillHeight\": false,\n      \"initFetch\": true,\n      \"id\": \"u:0cb2241c7f03\"\n    }\n  ]\n}\n', 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (32, 'Masks', '/masks', 'https://icons.fireboom.io/tabler/icons/abc.svg', 1, 1, '2024-01-05 08:36:33', NULL, '', 'C', '2024-01-10 09:07:04', NULL, '{\"id\":\"u:24dea3535d40\",\"type\":\"page\",\"body\":[{\"title\":\"AI应用列表\",\"type\":\"crud\",\"name\":\"crud\",\"syncLocation\":false,\"api\":{\"method\":\"get\",\"url\":\"/operations/WebpageMask/GetWebpageMaskList?take=${perPage}&skip=${(page - 1) * perPage}\",\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"}},\"columns\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"text\",\"id\":\"u:33bfb35d3c50\"},{\"type\":\"text\",\"name\":\"category\",\"label\":\"分类\",\"id\":\"u:bcf035fa4753\"},{\"name\":\"name\",\"label\":\"名称\",\"type\":\"text\",\"id\":\"u:93e89ceaa20c\"},{\"type\":\"text\",\"name\":\"description\",\"label\":\"描述\",\"id\":\"u:00a41d0155ee\"},{\"type\":\"image\",\"name\":\"avatar\",\"label\":\"头像\",\"enlargeAble\":false,\"width\":40,\"height\":40,\"id\":\"u:9692884290ec\"},{\"type\":\"status\",\"name\":\"recommended\",\"label\":\"是否精选\",\"id\":\"u:33dd85682fa3\"},{\"type\":\"status\",\"label\":\"是否内置\",\"name\":\"builtin\",\"id\":\"u:85d0298c0fe3\"},{\"type\":\"text\",\"name\":\"hot\",\"label\":\"热度\",\"id\":\"u:8051c14cc225\"},{\"type\":\"text\",\"name\":\"prologue\",\"label\":\"欢迎语\",\"id\":\"u:07e74c90d864\"},{\"type\":\"text\",\"name\":\"topics\",\"label\":\"话题\",\"id\":\"u:1ec05f2542a6\"},{\"type\":\"text\",\"name\":\"sort\",\"label\":\"排序\",\"id\":\"u:b4b26967af4b\"},{\"type\":\"operation\",\"label\":\"操作\",\"width\":120,\"buttons\":[{\"label\":\"编辑\",\"type\":\"button\",\"actionType\":\"dialog\",\"level\":\"link\",\"dialog\":{\"title\":\"编辑\",\"body\":{\"type\":\"form\",\"api\":{\"url\":\"/operations/WebpageMask/UpdateOneWebpageMask\",\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"}},\"body\":[{\"name\":\"id\",\"label\":\"ID\",\"type\":\"input-text\",\"disable\":true},{\"name\":\"category\",\"label\":\"分类\",\"type\":\"input-text\",\"required\":true},{\"name\":\"name\",\"label\":\"名称\",\"type\":\"input-text\",\"required\":true},{\"name\":\"description\",\"label\":\"描述\",\"type\":\"input-text\",\"required\":true},{\"name\":\"avatar\",\"label\":\"头像\",\"type\":\"input-image\",\"required\":true,\"receiver\":{\"method\":\"post\",\"url\":\"/s3/freetalk/upload?directory=mask%2Fmask\",\"headers\":{\"X-Upload-Profile\":\"free\"},\"adaptor\":\"return {\nstatus: 0,\nmsg: \'\',\ndata: {\nvalue: \'https://ft-dev.oss-cn-shanghai.aliyuncs.com/${response.data[0].key}\'\n}\n}\"}},{\"name\":\"recommended\",\"label\":\"是否精选\",\"type\":\"checkbox\",\"value\":false},{\"label\":\"是否内置\",\"name\":\"builtin\",\"type\":\"checkbox\",\"value\":false},{\"name\":\"hot\",\"label\":\"热度\",\"type\":\"input-number\",\"required\":true,\"value\":0},{\"name\":\"prologue\",\"label\":\"欢迎语\",\"type\":\"input-text\",\"required\":true},{\"name\":\"topics\",\"label\":\"话题\",\"type\":\"input-text\",\"required\":true},{\"name\":\"sort\",\"label\":\"排序\",\"type\":\"input-number\",\"required\":true,\"value\":0}]}},\"id\":\"u:1454c0b9c4d1\"},{\"type\":\"button\",\"label\":\"删除\",\"actionType\":\"ajax\",\"level\":\"link\",\"className\":\"text-danger\",\"confirmText\":\"确定要删除？\",\"api\":{\"method\":\"post\",\"url\":\"/operations/WebpageMask/DeleteOneWebpageMask\",\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"},\"data\":{\"id\":\"${id}\"}},\"id\":\"u:2d8a77315a4b\"}],\"id\":\"u:bd2e3e110b49\"}],\"bulkActions\":[{\"type\":\"button\",\"level\":\"danger\",\"label\":\"批量删除\",\"confirmText\":\"确定要删除？\",\"onEvent\":{\"click\":{\"weight\":0,\"actions\":[{\"ignoreError\":false,\"outputVar\":\"responseResult\",\"actionType\":\"ajax\",\"options\":{},\"api\":{\"url\":\"/operations/WebpageMask/DeleteManyWebpageMask\",\"method\":\"post\",\"data\":{\"ids\":\"${split(ids, \',\')}\"},\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"},\"requestAdaptor\":\"\",\"adaptor\":\"\",\"messages\":{},\"dataType\":\"json\"}},{\"actionType\":\"reload\",\"target\":\"crud\"}]}},\"id\":\"u:c2e110ca63d8\"}],\"itemActions\":[],\"features\":[\"create\",\"filter\",\"bulkDelete\",\"update\",\"delete\"],\"filterColumnCount\":3,\"headerToolbar\":[{\"label\":\"新增\",\"type\":\"button\",\"actionType\":\"dialog\",\"level\":\"primary\",\"dialog\":{\"title\":\"新增\",\"body\":{\"type\":\"form\",\"api\":{\"method\":\"post\",\"url\":\"/operations/WebpageMask/CreateOneWebpageMask\",\"headers\":{\"Authorization\":\"Bearer ${TOKEN}\"}},\"body\":[{\"type\":\"input-text\",\"name\":\"category\",\"label\":\"分类\",\"required\":true},{\"type\":\"input-text\",\"name\":\"name\",\"label\":\"名称\",\"required\":true},{\"type\":\"input-text\",\"name\":\"description\",\"label\":\"描述\",\"required\":true},{\"type\":\"input-image\",\"name\":\"avatar\",\"label\":\"头像\",\"maxSize\":102400,\"required\":true,\"receiver\":{\"method\":\"post\",\"url\":\"/s3/freetalk/upload?directory=mask%2Fmask\",\"headers\":{\"X-Upload-Profile\":\"free\"},\"adaptor\":\"return {\nstatus: 0,\nmsg: \'\',\ndata: {\nvalue: \'https://ft-dev.oss-cn-shanghai.aliyuncs.com/${response.data[0].key}\'\n}\n}\"}},{\"type\":\"checkbox\",\"name\":\"recommended\",\"label\":\"是否精选\"},{\"type\":\"checkbox\",\"name\":\"builtin\",\"label\":\"是否内置\",\"value\":true},{\"type\":\"input-number\",\"name\":\"hot\",\"label\":\"热度\",\"required\":true},{\"type\":\"input-text\",\"name\":\"prologue\",\"label\":\"欢迎语\",\"required\":true},{\"type\":\"input-text\",\"name\":\"topics\",\"label\":\"话题\",\"required\":true},{\"type\":\"input-number\",\"name\":\"sort\",\"label\":\"排序\",\"required\":true,\"default\":0}]}},\"id\":\"u:41ea90b2c2ee\"},\"bulkActions\",\"reload\"],\"perPage\":10,\"perPageAvailable\":[10],\"messages\":{},\"alwaysShowPagination\":true,\"autoFillHeight\":true,\"initFetch\":true,\"id\":\"u:0cb2241c7f03\"}]}', 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (34, 'Dashhoard', '/dashboard', 'https://icons.fireboom.io/tabler/icons/home-2.svg', 1, 1, '2024-01-22 03:23:37', NULL, '', 'C', '2024-01-22 03:24:48', NULL, '{\"id\":\"u:19444f87320b\",\"body\":[{\"type\":\"input-text\",\"label\":\"文本111\",\"name\":\"text\",\"id\":\"u:37528d2ceff3\",\"editorState\":\"default\"}],\"type\":\"page\"}', 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (35, 'ccc', '', 'https://icons.fireboom.io/tabler/icons/3d-cube-sphere.svg', 1, 1, '2024-01-22 03:26:42', NULL, '', 'C', '2024-01-22 06:52:42', NULL, '{\"id\":\"u:5c015bf9a90d\",\"body\":[{\"type\":\"crud\",\"syncLocation\":false,\"api\":{\"method\":\"get\",\"url\":\"/operation/post/findMany\"},\"columns\":[{\"label\":\"createdAt\",\"type\":\"text\",\"name\":\"createdAt\",\"id\":\"u:46ab21b76b96\"},{\"label\":\"id\",\"type\":\"text\",\"name\":\"id\",\"id\":\"u:1c960e63a998\"},{\"label\":\"updatedAt\",\"type\":\"text\",\"name\":\"updatedAt\",\"id\":\"u:da713217db1a\"},{\"label\":\"content\",\"type\":\"text\",\"name\":\"content\",\"id\":\"u:73c8a14c1e36\"},{\"label\":\"categoryId\",\"type\":\"text\",\"name\":\"categoryId\",\"id\":\"u:b4ca81ba3cc8\"},{\"label\":\"poster\",\"type\":\"text\",\"name\":\"poster\",\"id\":\"u:438bdaa4e211\"},{\"label\":\"title\",\"type\":\"text\",\"name\":\"title\",\"id\":\"u:e5efe2be8828\"},{\"label\":\"userId\",\"type\":\"text\",\"name\":\"userId\",\"id\":\"u:96a9b1933a3b\"},{\"type\":\"operation\",\"label\":\"操作\",\"buttons\":[{\"type\":\"button\",\"label\":\"删除\",\"actionType\":\"ajax\",\"level\":\"link\",\"className\":\"text-danger\",\"confirmText\":\"确定要删除？\",\"api\":{\"method\":\"post\",\"url\":\"/operation/post/findMany\"},\"editorSetting\":{\"behavior\":\"delete\"},\"id\":\"u:7175ccdcbc1d\"}],\"id\":\"u:059ab010d3c3\"}],\"bulkActions\":[],\"itemActions\":[],\"filterSettingSource\":[\"createdAt\",\"id\",\"updatedAt\",\"content\",\"categoryId\",\"poster\",\"title\",\"userId\"],\"id\":\"u:87f20c835dd9\",\"perPageAvailable\":[10],\"messages\":{},\"footerToolbar\":[{\"type\":\"statistics\"},{\"type\":\"pagination\",\"align\":\"right\"}],\"alwaysShowPagination\":true}],\"type\":\"page\"}', 1, NULL);
INSERT INTO `admin_menu` (`id`, `label`, `path`, `icon`, `sort`, `level`, `createdAt`, `parentId`, `permission`, `type`, `updatedAt`, `code`, `schema`, `visibleInMenu`, `apis`) VALUES (36, 'xxx', '/xxx', 'https://icons.fireboom.io/tabler/icons/activity.svg', 1, 1, '2024-01-22 06:04:42', NULL, '', 'C', '2024-01-23 01:23:43', NULL, '{\"id\":\"u:d75d0c192256\",\"body\":[{\"type\":\"crud\",\"syncLocation\":false,\"api\":{\"method\":\"get\",\"url\":\"/operations/post/findMany?take=${perPage}&skip=${(page - 1) * perPage}\",\"messages\":{},\"requestAdaptor\":\"\",\"adaptor\":\"\"},\"bulkActions\":[{\"type\":\"button\",\"level\":\"danger\",\"label\":\"批量删除\",\"actionType\":\"ajax\",\"confirmText\":\"确定要删除？\",\"api\":\"/operation/post/deleteMany\",\"editorSetting\":{\"behavior\":\"bulkDelete\"},\"id\":\"u:0bac8131ffdb\"}],\"itemActions\":[],\"filterSettingSource\":[\"createdAt\",\"id\",\"updatedAt\",\"content\",\"categoryId\",\"poster\",\"title\",\"userId\"],\"headerToolbar\":[{\"label\":\"新增\",\"type\":\"button\",\"actionType\":\"dialog\",\"level\":\"primary\",\"editorSetting\":{\"behavior\":\"create\"},\"dialog\":{\"type\":\"dialog\",\"title\":\"新增\",\"body\":[{\"type\":\"form\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/findMany\"},\"body\":[{\"type\":\"input-text\",\"name\":\"title\",\"label\":\"title\",\"id\":\"u:486757192140\"},{\"type\":\"input-text\",\"name\":\"content\",\"label\":\"content\",\"id\":\"u:721f9c34d7ae\"},{\"type\":\"input-text\",\"name\":\"categoryId\",\"label\":\"categoryId\",\"id\":\"u:e131c1911861\"},{\"type\":\"input-image\",\"name\":\"poster\",\"label\":\"poster\",\"id\":\"u:f579b40a82ca\",\"accept\":\".jpeg, .jpg, .png, .gif\",\"uploadType\":\"fileReceptor\",\"proxy\":false,\"multiple\":false,\"hideUploadButton\":false,\"autoUpload\":false}],\"id\":\"u:377366a82bb3\",\"actions\":[{\"type\":\"submit\",\"label\":\"提交\",\"primary\":true}],\"feat\":\"Insert\"}],\"id\":\"u:f2e7a624acce\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\",\"id\":\"u:78a209ca5a75\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true,\"id\":\"u:e234e78a678e\"}]},\"id\":\"u:96aa9ffafc9f\",\"onEvent\":{\"click\":{\"weight\":0,\"actions\":[]}}},\"bulkActions\"],\"id\":\"u:48280f02027e\",\"perPageAvailable\":[10,50],\"messages\":{},\"pageField\":\"page\",\"perPageField\":\"perPage\",\"initFetch\":true,\"perPage\":15,\"alwaysShowPagination\":true,\"footerToolbar\":[{\"type\":\"statistics\",\"align\":\"left\"},{\"type\":\"pagination\",\"tpl\":\"内容\",\"wrapperComponent\":\"\",\"id\":\"u:3f185d69b36e\",\"align\":\"right\"}],\"mode\":\"table\",\"columns\":[{\"label\":\"id\",\"type\":\"text\",\"name\":\"id\",\"id\":\"u:94576dffc0ce\",\"placeholder\":\"-\",\"sortable\":true},{\"label\":\"categoryId\",\"type\":\"text\",\"name\":\"categoryId\",\"id\":\"u:e4841cc8041a\"},{\"label\":\"title\",\"type\":\"text\",\"name\":\"title\",\"id\":\"u:89479be13847\"},{\"label\":\"content\",\"type\":\"text\",\"name\":\"content\",\"id\":\"u:835e1c4690bf\"},{\"label\":\"poster\",\"type\":\"image\",\"name\":\"poster\",\"id\":\"u:7a261b4ae5f2\",\"enlargeAble\":false,\"maxScale\":200,\"minScale\":50,\"style\":{\"display\":\"inline-block\"},\"height\":48,\"width\":48},{\"label\":\"userId\",\"type\":\"text\",\"name\":\"userId\",\"id\":\"u:83806356c2b4\"},{\"label\":\"createdAt\",\"type\":\"date\",\"name\":\"createdAt\",\"id\":\"u:e6459ac4a046\"},{\"label\":\"updatedAt\",\"type\":\"date\",\"name\":\"updatedAt\",\"id\":\"u:6cc24455ccac\"},{\"type\":\"operation\",\"label\":\"操作\",\"buttons\":[{\"label\":\"编辑\",\"type\":\"button\",\"actionType\":\"dialog\",\"level\":\"link\",\"editorSetting\":{\"behavior\":\"update\"},\"dialog\":{\"type\":\"dialog\",\"title\":\"编辑\",\"body\":[{\"type\":\"form\",\"api\":\"xxx/update\",\"body\":[{\"label\":\"id\",\"name\":\"id\",\"type\":\"input-text\",\"id\":\"u:c4c826d0f022\",\"visible\":false,\"readOnly\":true,\"disabled\":true},{\"label\":\"title\",\"name\":\"title\",\"type\":\"input-text\",\"id\":\"u:331d401510aa\"},{\"label\":\"content\",\"name\":\"content\",\"type\":\"input-text\",\"id\":\"u:d9f62ac16d43\"},{\"label\":\"categoryId\",\"name\":\"categoryId\",\"type\":\"input-text\",\"id\":\"u:41e98814ed1c\"},{\"label\":\"poster\",\"name\":\"poster\",\"type\":\"input-image\",\"id\":\"u:290c9a87b726\"}],\"id\":\"u:e67c123da0cb\",\"actions\":[{\"type\":\"submit\",\"label\":\"提交\",\"primary\":true}],\"feat\":\"Insert\"}],\"id\":\"u:3a4853a7fbb4\",\"actions\":[{\"type\":\"button\",\"actionType\":\"cancel\",\"label\":\"取消\",\"id\":\"u:eb63106bf704\"},{\"type\":\"button\",\"actionType\":\"confirm\",\"label\":\"确定\",\"primary\":true,\"id\":\"u:73fba12679cb\"}]},\"id\":\"u:c36fd3ff870d\"},{\"type\":\"button\",\"label\":\"删除\",\"actionType\":\"ajax\",\"level\":\"link\",\"className\":\"text-danger\",\"confirmText\":\"确定要删除？\",\"api\":{\"method\":\"post\",\"url\":\"/operations/post/deleteOne\",\"dataType\":\"json\"},\"editorSetting\":{\"behavior\":\"delete\"},\"id\":\"u:bc0e0a7af73a\"}],\"id\":\"u:401d821911b5\"}],\"onEvent\":{\"fetchInited\":{\"weight\":0,\"actions\":[]}},\"defaultParams\":{\"perPage\":5},\"total\":5}],\"type\":\"page\"}', 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_menu_role
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of admin_menu_role
-- ----------------------------
BEGIN;
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (99, '2024-01-15 10:08:46', 1, 2);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (100, '2024-01-25 10:08:46', 17, 2);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (101, '2024-01-03 05:50:18', 8, 8);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (102, '2024-01-03 05:50:18', 9, 8);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (112, '2024-01-03 06:04:55', 14, 1);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (113, '2024-01-03 06:14:17', 1, 1);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (114, '2024-01-03 06:14:29', 7, 1);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (116, '2024-01-03 06:25:34', 8, 1);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (117, '2024-01-03 06:26:15', 9, 1);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (118, '2024-01-03 06:26:31', 15, 1);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (124, '2024-01-04 09:49:27', 8, 11);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (125, '2024-01-04 09:49:27', 7, 11);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (126, '2024-01-04 09:49:27', 9, 11);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (127, '2024-01-04 09:49:27', 14, 11);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (131, '2024-01-04 11:08:12', 9, 3);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (132, '2024-01-04 11:08:12', 14, 3);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (133, '2024-01-04 11:08:12', 15, 3);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (134, '2024-01-04 11:08:12', 7, 3);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (135, '2024-01-18 07:30:35', 14, 14);
INSERT INTO `admin_menu_role` (`id`, `createdAt`, `menuId`, `roleId`) VALUES (136, '2024-01-18 07:30:35', 7, 14);
COMMIT;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of admin_role
-- ----------------------------
BEGIN;
INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`) VALUES (1, 'admin', '管理员', '', '2023-12-22 23:58:09', '2024-01-03 06:04:54');
INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`) VALUES (2, 'user', '用户', '', '2023-12-23 01:16:44', '2023-12-27 10:08:46');
INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`) VALUES (3, 'test1', 'test1name', '', '2023-12-26 03:19:57', '2024-01-04 11:08:11');
INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`) VALUES (4, 'test2', 'test2name', 'test2des12', '2023-12-26 03:23:40', '2023-12-27 08:52:18');
INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`) VALUES (8, '111', '角色', '222', '2023-12-28 09:09:28', '2024-01-03 05:50:18');
INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`) VALUES (11, '222', '角色222', '顶顶顶顶', '2024-01-03 07:44:30', '2024-01-05 09:54:21');
INSERT INTO `admin_role` (`id`, `code`, `name`, `description`, `createdAt`, `updatedAt`) VALUES (14, '1212', 'zzz', 'qqqq', '2024-01-17 07:51:53', '2024-01-18 07:30:34');
COMMIT;

-- ----------------------------
-- Table structure for admin_role_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_user`;
CREATE TABLE `admin_role_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `roleId` int NOT NULL,
  `userId` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_role_user_roleId_userId_key` (`roleId`,`userId`),
  CONSTRAINT `admin_role_user_roleId_fkey` FOREIGN KEY (`roleId`) REFERENCES `admin_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of admin_role_user
-- ----------------------------
BEGIN;
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (10, '2023-12-27 08:29:33', 2, '2f329bed-596b-4eed-a27d-0cb7f498cfe3');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (19, '2023-12-28 08:29:51', 3, 'ddfda1ba-228d-412a-a09a-08bad895380e');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (20, '2023-12-28 08:29:51', 2, 'ddfda1ba-228d-412a-a09a-08bad895380e');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (33, '2023-12-28 09:57:05', 8, 'ac40eb74-7ed3-499e-97e2-c0bda1e20131');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (38, '2023-12-31 22:26:34', 1, 'c8da8e37-9596-4290-b794-fed4a12d3760');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (39, '2024-01-03 05:50:46', 8, 'b7e953cd-a75a-46f9-815f-57b39fd5141a');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (42, '2024-01-03 08:09:29', 1, '292d2b68-65bc-4c9f-b27e-292853f3b3bc');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (43, '2024-01-04 05:48:06', 1, '82313034-e97d-4c30-8e96-c524a772b530');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (44, '2024-01-04 09:07:25', 11, '25399e4a-da4c-4509-b384-fc80717103b5');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (45, '2024-01-05 01:44:25', 11, '31ec726d-c84d-41e0-b8eb-fc3405f6c7a7');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (46, '2024-01-05 12:41:06', 1, '123');
INSERT INTO `admin_role_user` (`id`, `createdAt`, `roleId`, `userId`) VALUES (47, '2024-01-06 02:59:33', 11, '04df7417-f65c-46b6-bb71-f92d272672b2');
COMMIT;

-- ----------------------------
-- Table structure for demo_area
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demo_area
-- ----------------------------
BEGIN;
INSERT INTO `demo_area` (`id`, `createdAt`, `name`, `address`, `code`, `parentCode`) VALUES (13, '2023-12-31 13:40:15', '北京市', '北京市', '00003', '');
INSERT INTO `demo_area` (`id`, `createdAt`, `name`, `address`, `code`, `parentCode`) VALUES (23, '2023-12-31 13:57:25', '海淀区', '北京市/海淀区', '0000300001', '00003');
INSERT INTO `demo_area` (`id`, `createdAt`, `name`, `address`, `code`, `parentCode`) VALUES (24, '2023-12-31 14:32:35', '江苏省', '江苏省', '00001', '');
INSERT INTO `demo_area` (`id`, `createdAt`, `name`, `address`, `code`, `parentCode`) VALUES (27, '2023-12-31 14:38:21', '南京市', '江苏省/南京市', '0000100001', '00001');
INSERT INTO `demo_area` (`id`, `createdAt`, `name`, `address`, `code`, `parentCode`) VALUES (28, '2023-12-31 14:38:46', '淮安市', '江苏省/淮安市', '0000100002', '00001');
INSERT INTO `demo_area` (`id`, `createdAt`, `name`, `address`, `code`, `parentCode`) VALUES (30, '2023-12-31 14:42:39', '盱眙', '江苏省/淮安市/盱眙', '000010000200001', '0000100002');
INSERT INTO `demo_area` (`id`, `createdAt`, `name`, `address`, `code`, `parentCode`) VALUES (31, '2023-12-31 14:43:08', '涟水县', '江苏省/淮安市/涟水县', '000010000200002', '0000100002');
COMMIT;

-- ----------------------------
-- Table structure for demo_area_role
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of demo_area_role
-- ----------------------------
BEGIN;
INSERT INTO `demo_area_role` (`id`, `createdAt`, `areaId`, `roleId`) VALUES (6, '2023-12-31 22:44:22', 31, 1);
INSERT INTO `demo_area_role` (`id`, `createdAt`, `areaId`, `roleId`) VALUES (7, '2023-12-31 22:46:37', 13, 1);
COMMIT;

-- ----------------------------
-- Table structure for demo_post
-- ----------------------------
DROP TABLE IF EXISTS `demo_post`;
CREATE TABLE `demo_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL,
  `title` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `poster` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_general_ci NOT NULL,
  `userId` varchar(36) COLLATE utf8mb4_general_ci NOT NULL,
  `categoryId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `demo_post_categoryId_fkey` (`categoryId`),
  CONSTRAINT `demo_post_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `demo_post_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of demo_post
-- ----------------------------
BEGIN;
INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `userId`, `categoryId`) VALUES (1, '2023-12-26 08:21:16', '2023-12-26 08:21:18', 'test1', 'test1 user', 'test1 content', '78e0e5d4-5c09-4e71-a41f-7cc29e0b6acf', 1);
INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `userId`, `categoryId`) VALUES (2, '2023-12-27 08:22:05', '2023-12-27 08:22:10', 'test12', 'test1 user', 'test1 content 2', '78e0e5d4-5c09-4e71-a41f-7cc29e0b6acf', 1);
INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `userId`, `categoryId`) VALUES (3, '2023-12-28 08:22:12', '2023-12-28 08:22:15', 'test123', 'test1 user', 'test1 content 3', '78e0e5d4-5c09-4e71-a41f-7cc29e0b6acf', 1);
INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `userId`, `categoryId`) VALUES (4, '2024-01-08 08:07:59', '2024-01-08 08:54:22', '1.123', '1', '1', '82313034-e97d-4c30-8e96-c524a772b530', 1);
INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `userId`, `categoryId`) VALUES (5, '2024-01-10 10:18:09', '2024-01-10 10:15:25', '', NULL, '测试一下', '', 7);
INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `userId`, `categoryId`) VALUES (6, '2024-01-13 09:55:38', '2024-01-13 09:54:04', '', NULL, 'string', '', 9);
INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `userId`, `categoryId`) VALUES (7, '2024-01-13 10:36:24', '2024-01-13 10:36:23', '', NULL, 'string', '', 10);
INSERT INTO `demo_post` (`id`, `createdAt`, `updatedAt`, `title`, `poster`, `content`, `userId`, `categoryId`) VALUES (8, '2024-01-13 10:41:15', '2024-01-13 10:41:14', '', NULL, 'string', '', 11);
COMMIT;

-- ----------------------------
-- Table structure for demo_post_category
-- ----------------------------
DROP TABLE IF EXISTS `demo_post_category`;
CREATE TABLE `demo_post_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of demo_post_category
-- ----------------------------
BEGIN;
INSERT INTO `demo_post_category` (`id`, `createdAt`, `updatedAt`, `name`, `description`) VALUES (1, '2023-12-28 08:20:43', '2023-12-28 08:20:46', 'test category 1', 'category 1');
COMMIT;

-- ----------------------------
-- Table structure for provider
-- ----------------------------
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

-- ----------------------------
-- Records of provider
-- ----------------------------
BEGIN;
INSERT INTO `provider` (`owner`, `name`, `created_time`, `type`, `client_id`, `client_secret`, `sign_name`, `template_code`) VALUES ('fireboom', 'provider_sms', '2023-09-11T12:15:09+08:00', 'Aliyun SMS', 'xxxx', 'xxxx', 'xxx', 'xxx');
COMMIT;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int NOT NULL,
  `test` enum('Hello','World') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of test
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token` longtext COLLATE utf8mb4_general_ci,
  `expire_time` datetime DEFAULT NULL,
  `flush_time` datetime DEFAULT NULL,
  `refresh_token` longtext COLLATE utf8mb4_general_ci,
  `refresh_expire_time` datetime DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `platform` varchar(36) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `password_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password_salt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` char(13) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `wx_unionid` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_user_id_key` (`user_id`),
  UNIQUE KEY `user_unique_key` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3276 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3264, 'f09c5638-958c-46ab-b112-80f27d07a693', '2024-01-15 15:35:11', '2024-01-16 08:28:50', 'WxUser', 'https://test-1314985928.cos.ap-nanjing.myqcloud.com//avatar/f09c5638-958c-46ab-b112-80f27d07a693/956bf4f1097fd8f7.jpg', '', '', '', '18352538615', 'CN', 'o0-C56KNbOU4gDwLqhEsvjIH1fk0');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3265, '10c62a0e-0f55-4016-88bc-fbb904584601', '2024-01-17 01:30:32', NULL, 'admin', '', 'md5', 'ODdGvnwqpH', '43eec874a5751fe2f687e00ea0eedad9', '13800138001', 'cn', NULL);
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3267, '2249d8f0-93af-4f40-acb9-c3451c735bc4', '2024-01-19 09:44:06', NULL, 'Lily', '', 'md5', 'dFqdtqPqdLFy', '1989eb8d583da6e1dc13b405d26a9bea', '12312321321', 'CN', '');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3268, '7ff2d6bc-d40e-4c11-81a5-3c076c8df580', '2024-01-19 10:15:21', NULL, '11111111111', '', 'md5', 'DVYTxrYwoDfq', '7a2fe140c4eae98766217b13de7f7c68', '11111111111', 'CN', '');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3269, '9c4fa19d-47f0-42cd-a675-cb8f0b982f88', '2024-01-19 10:17:29', NULL, '12312312312', '', 'md5', 'ysCKQxLCZQgs', 'c3f00aa04cbf7282d81c3eccc8c5e1aa', '12312312312', 'CN', '');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3270, 'fe92aba6-52fc-40ba-8f65-f3f532540dfd', '2024-01-19 10:24:33', NULL, '12322111111', '', 'md5', 'PUNkiiIJRsJF', '4963c6b714859c9186d2a24afea9578a', '12322111111', 'CN', '');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3271, '2f91a71c-2052-40c6-b518-3e7298b6f379', '2024-01-19 10:32:14', NULL, 'Lily', '', 'md5', 'hmeNJtmuqXDh', '87ebb9c9195b2c02530b8cbb0e87a5f0', '11123123121', 'CN', '');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3272, '11023716-13e4-494a-8d70-f3e6c1936f8f', '2024-01-19 10:47:07', NULL, 'Lily', '', 'md5', 'lgfVlJoThQlK', '27a2009745adae4a3574266ba1af912c', '12323121231', 'CN', '');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3273, '5805bf77-5ad1-427f-a12c-05c370b6a6cb', '2024-01-19 10:49:52', NULL, 'WxUser', '', '', '', '', '17755003380', 'CN', 'o0-C56JLWJbbRQpwcFTVWsbWhChU');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3274, '83d02c1b-63df-4f79-8e39-51e8c3002559', '2024-01-19 10:50:02', NULL, '17755003380', '', 'md5', 'aYvkAvYnPBcX', '44ff3d6cd0d0acea44ea79e9bc6e37ff', '17755003380', 'CN', '');
INSERT INTO `user` (`id`, `user_id`, `created_at`, `updated_at`, `name`, `avatar`, `password_type`, `password_salt`, `password`, `phone`, `country_code`, `wx_unionid`) VALUES (3275, '4511b8cf-650b-471d-b928-b7130cde570c', '2024-01-19 10:50:19', NULL, 'Lily', '', 'md5', 'ykqCmWSlJEug', 'b6f4c21f2b914c1a625c812c93f86072', '12312312311', 'CN', '');
COMMIT;

-- ----------------------------
-- Table structure for usersocial
-- ----------------------------
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usersocial
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for userwx
-- ----------------------------
DROP TABLE IF EXISTS `userwx`;
CREATE TABLE `userwx` (
  `created_at` varchar(100) DEFAULT NULL,
  `unionid` varchar(100) NOT NULL,
  `openid` varchar(100) NOT NULL,
  `platform` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`unionid`,`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for verificationrecord
-- ----------------------------
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

