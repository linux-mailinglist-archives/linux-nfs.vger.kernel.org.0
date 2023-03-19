Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A26C0059
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Mar 2023 10:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCSJ1n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Mar 2023 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCSJ1k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Mar 2023 05:27:40 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5A19F37;
        Sun, 19 Mar 2023 02:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrLpavS3TTlwUd55EY/yOQwOlyt9sPk0+J3bJ7rwOTUj++oBjGY73IwAzy4zl5v2SYTrGwd1o4TZdk2U8PrmtG1ckK3LYJ6l3N/4AmCEo+uscC1Z0T4CvkxfCQKbuph3Or+7wUbFtCUbcNeKj9YeLkMvfcn/EivB4jw4vbI2pK5i2mXpDAfdYNpHe/Q2SRWnV6FDanmQzyALg2UVKzRhd6B80zOv9AyD7A4QxW+Ue1u3eCgOoxy2LlOX2YUUaStsX/uhLFTROdEGBB33ZPB0KBBjA0tckKd468Jqlh+a7GAf/D9ZPcx52XcYeUxNfOZ93HSEifUMPu1A5erKMX5jOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q81iK7HLN6yJNsX3Y6yye3cjtezWCjI30boi9TiN/gQ=;
 b=isGKijz7Rwtxhv06lJncDJO54ulwS2xfSxMKARkzXcB8rsnw9GQ3pLlZ048NmlaZZ7W/JEqiEBtwPswzXm3AlmZ5Kekax3Q2gEFFV4yWVEdJw5CVPzHBGySayiWXJpNyhXxewn7p4rh/HX8IFGBKNjY2A/Q3mf5+IMeL3Gq736lw6j/27WZDYemEdZ/7af/lnCmC3N8eDmgWIlMtkY9wg+HKQdDNp96MT2Cx7gEstSv5ao9t74NbOsDZDU8yUvOIV8HN5M57Li8YsvI6BToTaNAqFZRjel2EMa39SAl+XSB7xHdRUoDfdXDlsP3kSkrfmYjycI4EY39m0ko69Fef0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q81iK7HLN6yJNsX3Y6yye3cjtezWCjI30boi9TiN/gQ=;
 b=Ixym8emjX3qKB1E2STdZ9EB0N4aMoNLwmeruUp8u+whuq1kitBOny+VE+UsQzgZj2iXIOrkMwfnG/W9xk9QK9C8YnhQWDG6lkgt7Y8Nn1ktr2K3M3GeR/Fr5skbi12C9n7Z5EPG8JWk7eSRmjDAFQUXFLAY7Ey6tOtvOxM2UQDnWbkSC4ywHDxZsSs93pt+aqBwR2NehV/t3fmphTgmEOBtsnSRfyuUuvLAFIndsBfux72v3zIgK8oGvQnwXhDJDcZxJJ/IZRWOGG0Fl6ahxXNe8SiiSBzSWO7FzAa3NNizqxTduTp7QrrcWFPgcuIVEYGoEnN3OuAyRQ8ik/JzGGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2, RESEND 09/10] nfs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:26:40 +0800
Message-Id: <20230319092641.41917-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319092641.41917-1-frank.li@vivo.com>
References: <20230319092641.41917-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 716614c1-f5f9-47b2-6225-08db285c26dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeP1jLEm2MBQqfmAR8xREOnWFoScJ+UVXYccsQ6oStax/7X8JAACLKkoE3U/MnTVcj3aoCf1pQRIDNh54tVdoIAosrBChqz7zZQTnS9GHhwRivwOFsklGLPJGXmHu5fUy030kG65qTgewxDZ7QQp6OLgbqVJl5huV8p19687a+eli7duh76PZcBq3LGQIUOCyWbB9houDsflVhZjQC7rbuEZ/9Mq0JCO6hyWOwXS1z1nrC+HHQXVQ3cDM/stefVvnk83Lzd7SX/ZNy0kweUl8kzR2vF/UTURPVfTE0DDCHYpgQW7mwpcAJ8IgPQSTK3N4MBdZdcO3CtYio2ZOmhTm+TF7gEKcpnxDto6a7ZVxVHfaWNNcWCJQFGBhEkZpCjAZRNjbA0oy7qG6OFHNScAZduaH2xRjrcNt60T0a3kzCp9ez33ZUoKiJh8G4hGAN4fsbJU8M3XTYPyWctVu2NveaywoTcCUujAUMFl7jVLKqPL5m/JVSGcubtvqRoy28Vv4fOr2WD/rXKNEtbfwau4jsWi8vuTXBjEk5qJbRwwMwNQJ5+NjH2Tm8UYbzwMH/0P1HeCO72V/5PbAGUUI2SPPO7A616CIEfw+AH5Krr9ht7Xt4MRCR41rYnBJ4++m0bGNOcPa8uRFo4iXl1W4PMvAgIN1yRsqjPw4DfXBGO0dMriLBrE5PJ10zCQgs6grKObXHBvK6CWzAROGy9iNQhIig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(110136005)(1076003)(4326008)(5660300002)(41300700001)(4744005)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rMmbAg56LXeB5ddZj45Z9BeGxnHeiTgKKWRovBvEKavC8JzplA0z8KELHTvn?=
 =?us-ascii?Q?/WDaoBH8i53LLJcafUDD1qJu9nHzSKragrMBXiE07QgJ7Ss+zNvthV768e/Z?=
 =?us-ascii?Q?3JYoCnqPYB/7zIT81/dK1om2vfVZPcSu7u8S4tItu/nDAD7SCpiSIhuxEf1s?=
 =?us-ascii?Q?So4Wi0VlAD4TC+X/iSZmPtl5OZI8RPqPkkxO9+lrtRQ09uKObHM11h3vBmdR?=
 =?us-ascii?Q?mVThDpXOJ3TnB6BeIoGwbp0DlBuOnz3f/CoExSq5akC/MFZyQimG65SVcDAJ?=
 =?us-ascii?Q?fSMj/8e5twXun8TDY6FwvMhNaDbggyQ/+CyuaVnDxgaDHJoGd6+M/gnzl/6D?=
 =?us-ascii?Q?7zUbD9vNvG6UxeLmkWQ3kYlh0S40ppoq8H+Fbf/PytyijXGmD2/UGXnKeSZ1?=
 =?us-ascii?Q?8R4/swgSqRhrYIw74Jo0uHzFwLpSw3mw4AYhlY5hv7VU04+2gad5sDlU2olg?=
 =?us-ascii?Q?YCDsdSa9t62l3prIJrH3ZjFLfahjCdlZkBkYYqdDBSwCQlw5FlJFnlVyBQ2w?=
 =?us-ascii?Q?xN2NAC0A0yFNrZCkvXaK0lsECgHCf6/PNVhhi8eAmJga0B4wjV8Ky35NK69t?=
 =?us-ascii?Q?NltC4kjsWRl2JQQDO4JncP3GHb/sJrdxVkVSrpqgqAyB4jJ45atMHXf/Wyv3?=
 =?us-ascii?Q?zc6D8kWdt8BXgT1q2dAVjspuf6RNI/oZI4tcc9SY09vRRw88XK6Kt5qVtosd?=
 =?us-ascii?Q?wKarlA0ZYyjvorlb7iHrPpRWDhIC/n5CKnVx2EDru2BT80Sk8UZppVwObz9i?=
 =?us-ascii?Q?sVg9TiOjYiRjT2SN87Jm2P+UiLqJ/PuLqoR5Fe9hhfntC0pUZdv1vZsbiWHL?=
 =?us-ascii?Q?CAdQVdJbYjkb+/UNtK9nusdddw8cfcbDGq+/SpnEWnBwRUDd/PqfjGVhz+eE?=
 =?us-ascii?Q?n1AwJ/8p+0bfa+OLserYsIBx4UvDxkelQJSr+JubuBmgIih5MLRrHKBllN+v?=
 =?us-ascii?Q?7LADCV2lI549VQhIHSMlRMzFE+NMri0BtB5/YWyl7fP2+l7YjCOBHxPxVTZM?=
 =?us-ascii?Q?yFpIbGbVh7XPPa7yQi5Cumt7Ji1HWlR+I2KbW2I6imtMNtauQxtN7UMwW0pX?=
 =?us-ascii?Q?5RisMiw1gQH+pm+P9tdBAbvB85wi8zF4d1xekduCswCUG8spfZoeI3JaDD1V?=
 =?us-ascii?Q?YpR63bjPMGslP2OnSk6wftw+owOvgs1vla/qnADyx8O9CsFXXTYVWRsI2zdS?=
 =?us-ascii?Q?gaTHPwxFZ8jk1WsucMdZIDQeGQHMCBMg6ctLNfdHfaBndHjpjPh69vO3NtxY?=
 =?us-ascii?Q?vBpVu05I4ayrZGCV75m9pJY2XnARiFqrWDR4pTM/jQY3T6/5Zz0hOWUXwqmb?=
 =?us-ascii?Q?NlEKFY93K6PBtKtAySCD77aY2iXojNYI/CvmMoY9fJV7yhcP3+FdKPIdHM/w?=
 =?us-ascii?Q?eybMu3lNgq9UL+NCRLNJQovFAwsOh7ndCM0jxXZ/+JHGewT2+dHF+sFnUL7q?=
 =?us-ascii?Q?jq4cL9NX0QEf6mFLEzupUOfQ4z400BwsTrvuZ0MvwxKm7RSKAZHGu9baJC6t?=
 =?us-ascii?Q?fCFF2OESPM8QlJffYsIZuH66fnAYVgFVIi4Yr67Ta8hPazrpshKwbWpMIo+k?=
 =?us-ascii?Q?26iRFY8Ff9ue4UJiyKfjbb7UXeXbRr4JMOyEgT3k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716614c1-f5f9-47b2-6225-08db285c26dd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:25.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqJauQuv7VluhK5Y5zIfoDtdBjyPCuK6eSiLSKq+Eo4XXazUhgWIohgprLlEClG6un0WEJ9V95Nk2oddMMEm9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/nfs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 0cbcd2dfa732..a6072be5fa5a 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -185,8 +185,7 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 
 	if (clp) {
 		kobject_uevent(&clp->kobject, KOBJ_REMOVE);
-		kobject_del(&clp->kobject);
-		kobject_put(&clp->kobject);
+		kobject_del_and_put(&clp->kobject);
 		netns->nfs_client = NULL;
 	}
 }
-- 
2.35.1

