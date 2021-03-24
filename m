Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C014E346F02
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 02:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhCXBrW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 21:47:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhCXBq5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 21:46:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O1eu9U033268;
        Wed, 24 Mar 2021 01:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=3mly1dW/RmLJdsdhV4q9tyNU1U3Q0u+Fx6bVImQD2ak=;
 b=rcl3kHjPrwCHIx0vjprPzGQkuBi/26irbwdf0n5DHsZ2NwWpB2e7DFfKHeLgTF4T5wVL
 ZTL3ypy/tHJPBnCFUgjbfal5+q+zs9hCIOl1xXbs46sVA1f73fvy83E7pUU6vwd+mQD3
 0okuQG8JuQXdKeUjGl1eWt3AgKAoz5T491ep1qQ7/zBwfmjyiGzgDNofVQInTYm9ZPDH
 yHgvgtxZwSB5a+HFAdlkbxOQaewNiiTdkLeNY7TIh6VZ2LL5vv17fOXh4hfanCgbU8GX
 IF1WI2PlwrB6S094Rwd56QI9gHNkotJfVb078YpKsO6LNyzGaSnIQtK8PL0zJbnpBeQu VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37d9pn13yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:46:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O1il3c093711;
        Wed, 24 Mar 2021 01:46:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
        by userp3030.oracle.com with ESMTP id 37dtyy7mxr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:46:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQSKsYNDv733fzs8AEDJo1IM8xiRFNQOd9EHyqJNePFAGIn+4CE0FxL6j0gYCQp3zvw8B4bi9t9aDIydBko7ghGne3m8geF4znW/5Uix9/MYNCX9/o20E9IEhoJ5LcZauAIB2lS9SqMrBhCpPTmuCa2Fvgp/0HyBJUj0RfcHXi6m+FK/34Sjr+huVZgsyddHn4rZDhV7oMoIZJZ4FsVFTFCWqSJNEcZHbXb/GQCSmkQ3Ug5xlxyfAV2BCzh1mFDfYkhukkUQGSzbv0LQYLS/Rd8We2ZRF18baIWwphWYCcWpAYCcvA/zyaX3c2ZiZsKfDox3cUK5O09wXhYaDnX44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mly1dW/RmLJdsdhV4q9tyNU1U3Q0u+Fx6bVImQD2ak=;
 b=IFl+iP/ms/k1KmV1Xzn4nUGO4EpjRG7gkQvH51uHWSa2WPTtI9gw7tSV2K638DXe+VKKxzlqQTqoFiZPZ0MWoIHq/C02S4gvDc2AsWy6w/g7Jwq7CppHtE4NA3EoYK1GVBaH6SLfw3N/RKiuEEmpfGKfVcXDuR0xMUo+rN6RFvXD6i+ptLZm26bYQNDGysrh76NNUBlBeHtEge4izyo+hPw3CjgMai8nnHtMeZDt4rKO6ArfLf/UPECMxqIJid0BN7FIbtUiqElU/nqSV4sxN5riE/t5v7h8Kz4fyboUCYTaXS7A2MYpPx/dkvRj84OF74DJkoUI0geY1qPEn7E97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mly1dW/RmLJdsdhV4q9tyNU1U3Q0u+Fx6bVImQD2ak=;
 b=VVIZYpLEtavDfyxjPlvb/Nv7yO0O3feZ8S3GIpj1GsJIpImo/pDqQf+TF3GM6zcc+zROfaC8FW/mCzPdNCFTKzqWo/BZhQve5irG9HSNadG5SGVdQiVuwKlR6rW7jWue3KVk/6OcxPp7WWywC2Di0gH1kNrA04zz5WI4fJqosl4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15) by CY4PR10MB1304.namprd10.prod.outlook.com
 (2603:10b6:903:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 01:46:53 +0000
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2]) by CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 01:46:53 +0000
From:   Calum Mackay <calum.mackay@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] pynfs: courtesy: use a helper function to prepare the lock op args
Date:   Wed, 24 Mar 2021 01:46:29 +0000
Message-Id: <20210324014630.2454-2-calum.mackay@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324014630.2454-1-calum.mackay@oracle.com>
References: <20210324014630.2454-1-calum.mackay@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [141.143.213.46]
X-ClientProxiedBy: AM3PR07CA0065.eurprd07.prod.outlook.com
 (2603:10a6:207:4::23) To CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from cdmvmol7.uk.oracle.com (141.143.213.46) by AM3PR07CA0065.eurprd07.prod.outlook.com (2603:10a6:207:4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Wed, 24 Mar 2021 01:46:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9532ce-9943-4e42-a59f-08d8ee66b2f5
X-MS-TrafficTypeDiagnostic: CY4PR10MB1304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB130499286EE7166584AA8069E7639@CY4PR10MB1304.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oPtsnATYlZc3Mplr2So6Y69Vmluq8pCh+eoFPgrQLKBJix+7CEMQlRu6kypBxGl290pE9jaQcx/pwiXH5XcDoLrbSZbmpoZmf6cfKEW7+Z3oRm1HVCsEQiQyBlndmXRuyRyKkq/9b1ClnN5l01rRVRs8b/c4qi827PMwkGWQWd/Hgp53Tusj002vueKnEI2IuqKAaDS0l+g5BUPR0aOyK1EGToFitZ8D6iR0XP59w0YCs1pSZVva631qrn+WaW4AJ5yICeXVEO07esDhWLkimmtph02Cq31xekK4mTRr4s2/bgAXl9MQXJBpJI0rGwayyCg2H1dxdrLc9jcmktqHoHjloCet7PsYwuCwSTGdKfpEOldwrR79VOoOoNoETyhjy/pw42uaPPBxaJzAbLEGHyJ4KgrICA1MWt1E3ekO+oLDcFVXuRwd4FoyY+ACdsjHyyCjSkvY5Xvf1uNk4aLflZ2TnwpTyPmdqTFDuZuA/SYdbbuSYwIRirkCM8NqBtse2bdbnBKF7pR/740JPBVrrGr7P3eY3iUIatgzkXtLMFKQi0SFWtN9X2kOzypRF5WFMRsMwQPOt4f3SGapUkxN17nHLCXutfGdcosvjyhvXdXj9UcKO+Myq83L5c9+mH85IAWgCCVgYYC5XV22zyoNRAUzgIRqX41jssjcFmCPig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2119.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(956004)(8936002)(6486002)(2616005)(7696005)(66946007)(6916009)(478600001)(66476007)(66556008)(6666004)(4326008)(26005)(38100700001)(83380400001)(2906002)(5660300002)(186003)(86362001)(16526019)(316002)(44832011)(36756003)(1076003)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qpw6U8xiUkmwdqDSVzm3SsDmNjwHLl7hVc/bp3pIg5Ciji4Kn+XW568U0NG/?=
 =?us-ascii?Q?L4YeXcxHquDlabNJ42Viiv7RGJvJpv7FM5QfuvTopjX65tUCdhiyKA6jquRU?=
 =?us-ascii?Q?0fZ5WmHdHry3eOuhvp3rwt3kSi1qpdTgEeSDmFVS9n0xtqpCTJtWjeFToMcN?=
 =?us-ascii?Q?LeFJL/QLKSOp+bxUWH7+TUCT4BywhLZNqdVKagGOVp3HsaU9AqiaXgYqOI3T?=
 =?us-ascii?Q?2Ef9wmM8BhhSGmUWkS+dkqxZv3yqpl/JlV91ehQgJZJb770wroG6GNo1ysX3?=
 =?us-ascii?Q?0IkVGnA4LOG2KYEf0wNcDyNsAQQA5jZzBwWIrOSqhOCbbxcM5yu2p8fF1KRC?=
 =?us-ascii?Q?rIRcEnEHVJba+sZtvX3LmGbeCZCZyWG1AGM5PGQIV3Zwxj9Y/2EWZ7DA9Jno?=
 =?us-ascii?Q?1YfLrjWYovWd5oGHyqzkmH8fJibRRJTb98JhQRaRA/5YFUIYgL/COXpncxSD?=
 =?us-ascii?Q?41u0KTqdCUE7qY330dydtj7AojMMRGzX8f445ryK070g0h9fZV+2H3BXwr6+?=
 =?us-ascii?Q?SMOxae1qbS0X1pBk2UmN81hcERrsP06KBdW8DVHQeikoQ6D2R17m690QloUV?=
 =?us-ascii?Q?lI/xjoADWoo25sLHyqcWxKSiVNiFhDUzn7IBMYoFqSmQ3kxj6+ie1n6uvKk9?=
 =?us-ascii?Q?378KZrKPySyDZ4I2M5XA4yVKH37c3WM+y4z61JVlafBp5LenrAPBbIK11wTB?=
 =?us-ascii?Q?AoqLqQiFfR/WE6PMryuyhPWi5SIm4jpjofutXEQDocz0aC6RSKSlWAJ2A6ae?=
 =?us-ascii?Q?PXZcQtBEGyCfRmCBfGmFRdrJswGPM6Q+23OHe5av+SWueOJmAUmmIOCA8hUK?=
 =?us-ascii?Q?GlQqcGOnuA4ghIatqIzraW5zEEBk8hRQlqaYFplIrgarjQnqawf10RUr/4Le?=
 =?us-ascii?Q?4QLnEAJYb7lda++8y0kbtvu8wFxLL8UW+3MwKE8+TZY1dzlem1ITnOn6yLaG?=
 =?us-ascii?Q?ueuU6N1ULAlYcD2V4zovLJviGPODz/m6ac6vk2KXVxNrZfiIAtJFvfnHrBqn?=
 =?us-ascii?Q?o55eeHoRiG+PrfPOTVvyKxCJKu/ER72+Re8Bje2wEe6PxBA+KDLeBC7Y2R4y?=
 =?us-ascii?Q?7t0XSoPjINTF8woCEs6t4TA8ENXRALdNaY+KsEyUFliaTn08gP07Uw+N/3kh?=
 =?us-ascii?Q?GrDwXnIokxOLikjICMS9Y6qgim8l4DBqiEY9po2MMI9eniKCYJpm0K9Rkwha?=
 =?us-ascii?Q?kDpzQIYPvnvWaoOHHkwUY1FfNEINxJRYwUYrMucg+R5tmWYZWrR9YIVLPCIc?=
 =?us-ascii?Q?En3stMXAG0F/GI+hM9OUo9p6ij3uPQjPkzjbys+M/SDnkeTo8keyGhfzcsDj?=
 =?us-ascii?Q?hM5It+0SiNXqokpS4RE/pZaz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9532ce-9943-4e42-a59f-08d8ee66b2f5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2119.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 01:46:53.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8mVVGdGNO8wvI1Mwo1yj+nNb6+c9NuUuIA3XRA8WXmFGhddWZB5Eoku+NouDh90xaUGbc1agf0cBjjOWqCqoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1304
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240011
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240010
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Cleanup.

Future tests to be added will use the same sequence to prepare the args
for the lock op, so use a helper function for that.

Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
---
 nfs4.1/server41tests/st_courtesy.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/nfs4.1/server41tests/st_courtesy.py b/nfs4.1/server41tests/st_courtesy.py
index 5e13dad44a01..e74d9afbca60 100644
--- a/nfs4.1/server41tests/st_courtesy.py
+++ b/nfs4.1/server41tests/st_courtesy.py
@@ -15,6 +15,12 @@ def _getleasetime(sess):
     res = sess.compound([op.putrootfh(), op.getattr(1 << FATTR4_LEASE_TIME)])
     return res.resarray[-1].obj_attributes[FATTR4_LEASE_TIME]
 
+def cour_lockargs(fh, stateid):
+    open_to_lock_owner = open_to_lock_owner4( 0, stateid, 0, lock_owner4(0, b"lock1"))
+    lock_owner = locker4(open_owner=open_to_lock_owner, new_lock_owner=True)
+    lock_ops = [ op.lock(WRITE_LT, False, 0, NFS4_UINT64_MAX, lock_owner) ]
+    return [op.putfh(fh)] + lock_ops
+
 def testLockSleepLockU(t, env):
     """test server courtesy by having LOCK and LOCKU
        in separate compounds, separated by a sleep of twice the lease period
@@ -29,10 +35,7 @@ def testLockSleepLockU(t, env):
 
     fh = res.resarray[-1].object
     stateid = res.resarray[-2].stateid
-    open_to_lock_owner = open_to_lock_owner4( 0, stateid, 0, lock_owner4(0, b"lock1"))
-    lock_owner = locker4(open_owner=open_to_lock_owner, new_lock_owner=True)
-    lock_ops = [ op.lock(WRITE_LT, False, 0, NFS4_UINT64_MAX, lock_owner) ]
-    res = sess1.compound([op.putfh(fh)] + lock_ops)
+    res = sess1.compound(cour_lockargs(fh, stateid))
     check(res, NFS4_OK)
 
     lease_time = _getleasetime(sess1)
-- 
2.27.0

