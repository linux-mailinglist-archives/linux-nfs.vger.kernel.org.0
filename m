Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722036C0021
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Mar 2023 09:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCSInt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Mar 2023 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCSIns (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Mar 2023 04:43:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071b.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::71b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7594812CD6;
        Sun, 19 Mar 2023 01:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW2VX3n7FwHNRJRnVyPdmFvdalIHOpKdWD3yteNZ7INJ3xMj016qVe/+c/lWiqw5ZQi21XqWxv7DDV53Wbmrk1I0BS12ucjVCQ23C5DGgwjYd/0nQhh1J6cTnwgclPWFwYIjBY8YnAxsAMZzJcMA0kaAszbtMhW+3hD9tjgQVSpH9lSQIL2iSbTBLoKusfuMj5P6Qv8zDq6sjFCEWO3PC4WvRbOo2aio3b97d3++Z3Jb9B1JLImY+wRlCGWp/RRcErUGoSsPlxvwUIebbnDWm6mQUgiSb32PRocnL4XF9xEEtWNeJV7zq0BxFj5TJjvYckGfWe58/S3h84GyZk+arg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b4MF4ufqdI19H/lNLWCOS7kOuCLRTYdgbXiYjutT1w=;
 b=Td8BTiLpdZPDab6e6dd/40/gbC1BcEe+ad+KxBx5coRCtVFeMt7ixHeTee3wap//WK6F59TlRkxVIFZ+f3TYxkc39LV9fAuF3IB3wd32l9u9/egOiaB8aV4PJ4JLBoFJZ1gywPR0kU1hj26LgncG3iYh93MBb9sALoRPtN3tjmbs89jFRh/Hb5bHooSDhXZI0+YhNVcEmuxGOes/Y2/jijPvHth5TtYqlfxjBJoOnlaN4DM6YUhFCKQyYkQZrFOs/Np2CMLvju6TfyPqqkx9U5FLFhtmib/P+cDKtD9W1Yis4LiwSI6VQKrpFK9l0PLqZRz1wNB2tlRQixt/pry6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b4MF4ufqdI19H/lNLWCOS7kOuCLRTYdgbXiYjutT1w=;
 b=DvPGhRO+fLla80J6Rz2oYwqhzi/PqxbkliXRaW9aplUPihpj/fmrowywEcHkwP7JmyAcbOVIvsdIoY295/F7hAFWBn4mVEL+w+fGC2btWh44xKHSdw9A6USwC0/DiAaR32doY2DgQJJXoi4JlosCj4nk5gTjyTnuIi5J+TisJ1V/xQxP84Q+gJkWQGDP1MiKtMmf5P6lpwb1NYqId9X60C1Rz04yGLlDgyvzOqjPsHMo3ydE9UlJy8nwkSDa62no0m3eO5WienuKNwHTpzFwfoFtt+fiLdTITbMiwePwBIlxONkrMYfwm03S+YYe/Y68N6mGwz2Uy+JaldKs9qyeUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:42:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:42:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] nfs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:32 +0800
Message-Id: <20230319084134.11804-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b94f5d-ca75-48ce-202c-08db2855d387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4aJusP7V+Brnfi4lEMDsnqBznJku67k1NvNdlCSp0E+skSC43eZLRJ3X9GVQIuFl/X2bOcs0tZ3C8NUYoEBZpeKQzOxbXORv/onO8r51i0ysv9XqbDGhQwdEgELluYrlPYRdYVlhNXgXZQ4PH3I+OGldl5P4DIEnzILug4aRUcvolrKiErRsB3wQCOFdMXDuHB5KmAoeGnP/gRmoqLJ82ehAPKcYZrQ326lYdFTYuMtip+TvsbocOwwBCmNRTb5LdskNVHkXX+2FW0IEQ59rVuGe5eqN88prRgngfbEjUsp6Pr8iG1eXeN9EAxDVwHav25bVt0y5Gfo8WPOitH7zPi57lrpKMiTGU2GNauzRipRRr0RdqkKoP7DDufK4wnfXhZaf73oLT3MfCCIFlZuFjqjTbWnl+x/b3bggzcg6QmkTCXrSeKiVhBzgA0Y4G7CFYnMtp52qqT0PvERdL1g0yt9o11hLGMkK3AiSNOD5K6WyXnY5q1+s/Sn3xi19cTOONXdKS0BzQ1gHOZCDb8ydATCDwMMatH7BHGMKdpSCfN1wYT3IBw9OMor8MToQKh1+fUbU8w6Ls2I9nQezEAplGewjJb6E5xq6FKcFErAtGA5QHog3LGHwMymlvNApsdvVrMptBTM/71k25brGXRUm9kd54CV8n8IEU3VeAAc3BVxNIY6TuvYW7+LMQ5l68hY9ilV2oLBXXBTJX4JhZqfCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(110136005)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(4744005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JvAoTixD/46RWbmDw8JqdXPsun4wjd8ctFF92D1CVbTuP2Vwwqgi9N7qN3J?=
 =?us-ascii?Q?6g+wAwUcXYmzEjLZmp/Fh+K4FqnF3/x7GMmhZVtdIr1BCBtptMz6rBw6tD66?=
 =?us-ascii?Q?dVqmV98ibdyhjMTuVyEuNBDKDt7iGEPOIcCwdeziR3Eg3AimseqWHktQ3J/S?=
 =?us-ascii?Q?isKhHQCLBWh6fqDop/Fw1csgMsX8sWwmw84Qlhjyte9ZkmICX2riutWF8JHh?=
 =?us-ascii?Q?NpMjBs+I67g4N7vrU9srTovAAXYOYpMCWv4dAzL5e3IhxzAs07cOYlM+E3sy?=
 =?us-ascii?Q?JDtLiT6rlDoIjnn7tBhV1i6sp3QAHsnet4oHiDQJ4UMNn70Nn92+ldZnrCsj?=
 =?us-ascii?Q?XGgGUV88XEvAr7tKprodFK5SBsMfKob7ZR33ZOZIZZ7rirMdF1Q0t/A9gy4I?=
 =?us-ascii?Q?ZbVpvfipe93N1ks8eyrDQYE4inDKgvEjQwHPTZysxeHKFDSI6ot7wwBMTgS7?=
 =?us-ascii?Q?/AzQLv/IzNzlOpU9NzBwHgGVpS0PPNlQXv5pXNHB2NXj7+tMk5YtzzmVbkiQ?=
 =?us-ascii?Q?ImQO8LsQgdMERyHQgzImYLLwzo5Eb1aCXFKgrz0gC10PYuJzTXF2MMZwG693?=
 =?us-ascii?Q?E3sl7CggU9AzY5KcY8r0lpT1ZF0BAlR0Zt7dRkBYaBiJGDr5kmt558UF4HZ5?=
 =?us-ascii?Q?g+bt4QJWKRVDMeai+uT7Pt/eEejOEsgXvQyZ5zkSRP8xYJjyzmssnNUaVuRS?=
 =?us-ascii?Q?zQEJQBF4OAdQcIxg6s5/Jm9QozXvyw7xnOzHH1kMi7vo5JT7lO+xwrBNLmMk?=
 =?us-ascii?Q?RM79j80xjyyUZGZhexFHiI0bdfYuJQBGuUhpRWr/kEL02GPHId7xqpMmV4L4?=
 =?us-ascii?Q?6fwuUK8QtmZ72keZDYKoz4uDTlt95xuhxggsys3ov/4XYecuAemtij7ha34a?=
 =?us-ascii?Q?oyEmr7xfMvviO4Vks5Znt1riJ5lTAS5ol3ATFVYwnkeqjtT2thuRjQ5INCJH?=
 =?us-ascii?Q?i8suFxB/2iWywtli19izHwwh9oiShDqkLf0R+uzB/slDw2PVwPX0PpVKcNPX?=
 =?us-ascii?Q?VFCmDGC8Hu1Okm4rgLvAZ1CV1uinH747Uf6D0IBMCM8EgCEmt+9fEMqUYj2I?=
 =?us-ascii?Q?85Un3fM5dcrdvbbPx2H5HRsMxq0kaEW2ZaN7kkEo5OjYchOf6csJThUoaZoh?=
 =?us-ascii?Q?HkxhFI9YQSuzrtiIM2lMJHQ2ilLcy2apkYGsFszyQnzmd/BacbxoZoecTTIs?=
 =?us-ascii?Q?HVkB4uineFr18jB6A5U4oPWhuiawSzUETxu2DAq+A5DQWC2gOBAy0YCGOvh+?=
 =?us-ascii?Q?3FFW5l1j6yqGMlO/XHp7dIGXq2dHQWksVmPUrzX2T8RmNAOblGtWHL+/70XW?=
 =?us-ascii?Q?ZTcw0qs3WadKWjfpqgDZs2GNGvAlJd9wOXtgthr13qr34PYxtY/vl7luoGAk?=
 =?us-ascii?Q?hvyoCiMuAOHyAI79Lpq/42jTstnflifZ5fQVIWOUB+y/qOgWZYyOTKlymGZi?=
 =?us-ascii?Q?C1WaHx2NGZUSJHPCB4YILLdqmKyZ5PGPPkKtQUXVlLdPbWiH/61u3ld9HAbT?=
 =?us-ascii?Q?WQvkV7VI+KcqfNAQrigqAD+q6TXwFkUbALXbnlxvXwAdS7EuTvX1qeiTCC83?=
 =?us-ascii?Q?hUmfvgnumyddgc/2S7f6CtLIyz0x2DJSoxgSlmm4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b94f5d-ca75-48ce-202c-08db2855d387
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:42:09.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djPeD5CeIA3F62Ojlsf71h7w2oRpVqa8GRoxAg5KIMKuZEueDfb9nFyr0/hSBYfAt/+AfyqGqLcf1XM1+QP3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use kobject_del_and_put() to simplify code.

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

