Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98506C5182
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Mar 2023 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCVRAr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Mar 2023 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCVRAU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Mar 2023 13:00:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F96424C;
        Wed, 22 Mar 2023 10:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL/oOhQrSz35vBE9J7e50R/FitHYcoL4INcXJQf/2gRU7hS+CMUmWtC8ZIBSQCig7u5LWYEckq69TAGFHfYsSA7QatKHfqBVumFbmZkMp3+8dW7JYhbiiJaJV30FsRwhnWSxuv2L7iMUN2sb0NElDyJy4y952FAUye/AqlalmxXMomw11tUMo2YcA5yhykpzQfkB+J117Sn2WXtymgAAZyzeABtQU5akeDPw0E2H+hNvnS8h01TOhkcnqzazNe1TQU20ymQTAuTf8deg7Ea2Hvwt2cY+XwIT/5iu5KXA+BeYxwijFrS5fURiRu6bCXVsX9IzBloPvpsQgxuZCZ3yBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC23nHvmsjk047LeZyGTlxwogRKKTMdhTbyermoaPGI=;
 b=FBfP00X+21Il+aLnFK+E83n/g9WiQOXqCXuBOPUdeiSQq5AIBvBy3TckWwkKhlP86hyxsr1CuYPKXqobKET6cZ7IXlgq994fWCC8Cd6SXAvbjua40baI0Qa/NFXSKEhUE/W7/z3EP1LyfkOgJ8mu8JiKdgHNHOcDRWeCv0pHVclwH/xVjkeYGrpU877y8JHD7A5GfV97xS7fbkEvOuMsy2FnVZBPuHUUfr8YJAKpRg4eUP2aCUJlhA6YSncuYIv7BZBY+QRArKDHl67oMufvt33DqOfeVNuhSd7PQGJyGlWzyq5u6eTwoKPV5xJcXfME9NVePVKVGj8h5CEe4RfZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC23nHvmsjk047LeZyGTlxwogRKKTMdhTbyermoaPGI=;
 b=Lk1xwnCQtqD47+KjWPuBwnu+xm1sbuzeWiCSZve82uPNCyHbiYPYx/a9vLrSHwC06WHHwJn3myFXZi7NCv+SMRFIVl2S9It6nbT3vM+sfnwdyDSFxQB09FxWygHi/CuDlIgaoR9rmLTvCN+89k83/eI5H1HX98ctR6XHtqkzmhDQDw2m5oY4+KieVHtgWEEbzIakGzPeH0TGFhbXAh07fmJPORofmV5J/iB2eQGuL0Ol2gn5dUV4Ac62tsDI4Owpr+M+h1AVTjC5KFS9qDWrdpacALXhza1mybn64aRpRncDuGf8XleTwRsl2bVJ8fbW6FQj9USjjBCQtsGUk3vtYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4107.apcprd06.prod.outlook.com (2603:1096:4:f1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 16:59:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:59:58 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] nfs: convert to kobject_del_and_put()
Date:   Thu, 23 Mar 2023 00:59:04 +0800
Message-Id: <20230322165905.55389-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230322165905.55389-1-frank.li@vivo.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c449da-3268-44ce-77a6-08db2af6de5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lr9AMxUvbBDPMccCG0bVoOMpES/I7oJKB+xDQ7HkMjR2K4EV1/2Mn4sC+A5a4doRd6+XoKR0SITCHNGdAV511wkl6xJydPtrg0693cDNwFlIttQ8c5Zs7xPsQJvrkxxvgjgroP3En3eFDQH4X/kc7BSo7wHCSfDxjMsTrRBlf8z4py6ydR68Yt1ackStwnQ32aUZLd1gDlwiv0oLJLRbUrASGQUB+SU6d9ap4plszAFbotGuEzbaRklG4cXzW7fstulyrcEl9poLKBTnbk77WcS6WnEeTWKW2N4VsvOEhFPOOnV2LjaT3aG8agS5AOnhaXRExJRX3wbChR/AtpuDxqcEisXLBLc3VN2kw8CJ0NfiQzvXSXRUV+xCHVQ8VXxtChYRVx3D+nBSEJX53hibU9c1v4QR76kp6PJpS+1QfcW5u9s6NBDb1oanJu7vTJwC6jvDCb2K3HBtmTiW9mRBWj3+T6wGb6ugzXSfhkDU8eoIVcrFkbC/Wbxr3iMT0zauTyAFg0llaEDFBqjaMiHwwthZEO4P/S9vQwsKG4BCAEPYSxC8dwRVMxdJ4hZi8arT0Lh4EaRfpiuKZ+mFGqi6JxrHQR+PBsj1zSlkHyl6vhmotWJn144AOuR+p/7Ibk61DHPdFAkJUAFpOcfLAJ8Z/765OUwLGpGqa9ZUbsABpDf02E/9K9y2JXBLsYOXVtzUaACKJE+WLvz/pCwCXV5okA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(6512007)(2616005)(6666004)(1076003)(52116002)(26005)(478600001)(5660300002)(186003)(6506007)(6486002)(83380400001)(316002)(110136005)(38350700002)(38100700002)(86362001)(8676002)(66946007)(4744005)(54906003)(41300700001)(36756003)(8936002)(66476007)(66556008)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2U7VRH9/9mfqhIyFFmyhdFrU9Rt2yG3Fy23/Bf9P/ADxypSWWlCn3qLg5yr?=
 =?us-ascii?Q?MKLNS+un+yfHE454AFFKk2PCz+j+s4/G01MZRwkLOwaz2RmTTY/fn0KnsiuK?=
 =?us-ascii?Q?zXNwD0vAXczCe/5Dk2Um3zGM5NITZ677DHDvaybjTXIMU/dAe1XniditPJ7T?=
 =?us-ascii?Q?2m6Jjz5h1TmY8K+3KZrq/rNxN4cWPAPmliRHpS8k+uWjYHpfD17VIALDe2QH?=
 =?us-ascii?Q?Jq0DMde0duyJPBMGSWb1YfBkXC+IuGMOpTW8h6jXiz5nDiH/OWNlKliCdo6D?=
 =?us-ascii?Q?OXJZ8plRiflNiIIEgBpGbPYBTWBEMGAhormefFYXC80+dTVGRbjsrJTVGQhL?=
 =?us-ascii?Q?vXDl9+exBPvKPKwH7XMCw50BOpm0WDYnv51S/IaHrxCvEu0qyefHgv+lXqV4?=
 =?us-ascii?Q?EatUUsbluZVXDNsCsl65rRT3L+NJoYnWEuWtLlBknPLHrheV9SCVO0MT+MfH?=
 =?us-ascii?Q?HZZLxzK3V06EzKMvXLRE5NmTraZxjirjJajhjCh3C+8qIQ0z5oCJYVJ48sww?=
 =?us-ascii?Q?eUJ6ahhuHr5ObegJaKNhon3gsoItI/PWBag8RtaeQxukcPZ3jZjm7Yvw+f0c?=
 =?us-ascii?Q?rK6lDxkLgozhvUfeMHD9C0G8lG9tt943Fq8o1NqoyfZba1Jv+4abNXhK+Pgx?=
 =?us-ascii?Q?HH+orJ53ibc7BGNz/LfouNGIbu/j2kY94jFnhAXkSnVTkELe6ksfAbjcyoAp?=
 =?us-ascii?Q?fDzexe88A+1pUvrT8E8Z3X/9l88FO67fKUIlqjVfsjkKLoMZPr66GGWpSAZm?=
 =?us-ascii?Q?tPYDUL2OYDwciUz/Nl80dAudttzAMo2VokDu+gHVgQG62C3Us29DqO5VvCc7?=
 =?us-ascii?Q?ilAD/XeMUX6PyLCxElvOaEw2im6CBjBrei5qwI1Bwmbq4m07S1mfwImAq/D/?=
 =?us-ascii?Q?Lo8N6J4QyMEiHFHNQmq7EcDoNtTpY4ggDdDkGIPU3BEbVbuQ3SmkYWZRP+7q?=
 =?us-ascii?Q?aMQAu3rRVl7Q9UDmTYkZitlnyoRR602kf55l7RSliyMTpS+X0Qy040Sczfcm?=
 =?us-ascii?Q?8BNiMXxBTvKNnF+0ZcfYg9oQFKidfAJmMQZ+vHcUqgWQdDhzIhNUDa2uDoXQ?=
 =?us-ascii?Q?uUs9DmXjfSApAhECffRyBSriz+lBKC5SWTO5344WBJy0OdY3b/oX6xKbuhRm?=
 =?us-ascii?Q?enwNWStTfOwZ13YRlrh4iiBejaBh6wDvr7GmZcpU+MfB4mHfTT+fCP6P+/zM?=
 =?us-ascii?Q?iOs046Y5scML/67zQw16U0n5sIz7oelEhPddoRAvoHcVUGL2+xqSlGNrPUFo?=
 =?us-ascii?Q?hR8rc7TFKUfVUYgUGhKRPGuCSJ1Ny+iF+BNMzrTKzQ6qkRdHeBAom8E37Uuz?=
 =?us-ascii?Q?iXd920e0Uzi5FGI6NByTakd3XCH9nfXvyrF87gGI62H87qh9C3GvdkUM71Df?=
 =?us-ascii?Q?YXB2zWxn4i1hrvH5+kofObzW6yVc/8JiHK8xXlYEizSRITpm63PAsLcHZguv?=
 =?us-ascii?Q?Vil4hsjedVdldYApAw+lTo0yE17RrHguRQxyLiZPsfHFSTKM7VOUDFQFro5i?=
 =?us-ascii?Q?vyDHtoJFGKDBiL1pL4gIXLA4A9MFtx6W2Vf8+2NNI7Xwl5KjpImnehW8ezIp?=
 =?us-ascii?Q?n0LJeGd5qymF8TmyzdgyX8BddaMWMBvrB7xszBzw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c449da-3268-44ce-77a6-08db2af6de5f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:59:58.6520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/Zgy33q/qwJM67f6Tk/GqgiTzENqfFkvqoinEcUwzaBZ3VqzgIYUC/0p8tvRiT2inAns1u/YBwu+T1Vn7ddgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4107
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

