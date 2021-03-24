Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE2346F04
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 02:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhCXBrZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 21:47:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhCXBrD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 21:47:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O1cuJS141523;
        Wed, 24 Mar 2021 01:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=RLqMZa8hCjCY3Ibh/l/ulbIgBGKLpWE9iggsG31t5Vg=;
 b=GlzS7ovg81bL8xQJG9vTpNGYXduj8MaJsjNTGU+BoGOX4gzJZ7wTaydnj8Yb2kHRcpFT
 mBTHMImqGxMgegXCqznIEc9otL6fqIPTQzhmXOC1Gfifm+q7sa0zDlTy7ZoUiC/cxj0d
 uiptg7XO6h3kFAtWhbYs4MG0JUKv0aFXZGszsdpidW8ixfw1M75VrobFTEp1i+lD5YkT
 cQBMImyhIJABoZcET4vlWNTiuJcjynQWnnp7Bduq4Yisu8nudDe5T2f046SX0uuMKSGr
 ajrIGC6MFigr6W016wsabDrzfuvDkf8aNMvsujQRs7+ymjX1jwcdZWTFx5hkU5PphNN/ oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8fr95af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:46:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O1k92x159138;
        Wed, 24 Mar 2021 01:46:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2057.outbound.protection.outlook.com [104.47.36.57])
        by userp3020.oracle.com with ESMTP id 37dttsq9ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 01:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq4JOGbTHBhSeJuYEm4bojdder6JwstoszQHSGsx8qafz0ei3K6ajhRxfyB0PU5/ma2K/xU96YO80fUJr0PEwWiI9DpU0bcXKAH6NkBkMl2sS3B2fe5cCZgqfBUDv4flZmBWhYp+hs8JZp1ER7SiiAiH3FrhVSvOj02oRm9hsO7kjHazDoKzXEzXhYUO6qPdKoGWDgZHdmooRjRdmhIfNFrUmqCMdVbe5JJjYp0HWizWd1e95rcipkg2QMtXtHz67Z5M+H96zGrpb9fwKKHhME0ZjGIbl6zSJR7HR9oIHBqcWQsZVU0nD7eGxy+37ufsa0tEeR9fkDarOFpLiexsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLqMZa8hCjCY3Ibh/l/ulbIgBGKLpWE9iggsG31t5Vg=;
 b=SBlRem5YmhbmQWjshsvuQ/oXdgUAgXilGYD1AMgy1QybW5tocYAw0v4hSZeMfuGqWXa1hssZ02kfw0ckVvw5/nt4CUG1aIjAObMTsRvD9lPd9LApqOVf37BZ7mguGlTxnxKfBG79aD7oPBN7KJ73VasydMhPbBzbzZHB9Vo+AokX/hEr8vXM6bHt9PLjQrBjq2gdYhQQ/F0PZy4flWmEU4xvzYM/I+f0s1cLyDmtVDBE4WfYaMgK/FIJAf3sLkZpDCkKbT8gwgDuGQUIUUVFJlKez7U9xUIY4Pdc0FU2yFo336sAxqoV+owtALADdvP9GZNMgEZxdQMWktJNDJY03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLqMZa8hCjCY3Ibh/l/ulbIgBGKLpWE9iggsG31t5Vg=;
 b=RWuZMLYclmtpFm6//FZviZ3sDa6tGMvL5lFYJBeVfUWc5Noz1AZX3L2rJ+hNyuFXqqCmHieFaMAa8olXMFtRVwsyVGpYRB/T/qIGmjJV5L5AfvaDetx5l5Q4UNIAPprVlEf5mOz167HFnPaIrr6CPU2QcRr8BJ+bqARPkW/0hms=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15) by CY4PR10MB1304.namprd10.prod.outlook.com
 (2603:10b6:903:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 01:46:54 +0000
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2]) by CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 01:46:54 +0000
From:   Calum Mackay <calum.mackay@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] pynfs: courtesy: add a test to ensure server releases state appropriately
Date:   Wed, 24 Mar 2021 01:46:30 +0000
Message-Id: <20210324014630.2454-3-calum.mackay@oracle.com>
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
Received: from cdmvmol7.uk.oracle.com (141.143.213.46) by AM3PR07CA0065.eurprd07.prod.outlook.com (2603:10a6:207:4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Wed, 24 Mar 2021 01:46:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68feeb83-b383-43da-1f70-08d8ee66b3ab
X-MS-TrafficTypeDiagnostic: CY4PR10MB1304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1304917844295DE08BFBD499E7639@CY4PR10MB1304.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22YZxmn/0BrKLcqOwqgf9PIjyBOrMnmA7MC1JKOLRdO6vu2XCbHyVz7M4LEwmBFOj8c1cSy1BmBgJZR7wLi9Kp8Uf1T1+17pLkUH/4GaR7LGqE4muhV3AyQw+5EFcz0+PyxZyYc7WUqHscItf9HEyvFnH6IGXsjeMXpFitV3PUYzktrkGAcdYTw/15H2Vc+cj8q66nnZnZC5Vqr5SYN6FawmvdvmQX0wHgqUmiS9RizaNy7TcIit+l9mV6Qpoa6xUafT8NCHhF1AWlVgr/B0AKyN8j+tHJISgFvCFCSl/0Ev/y6MNKEWLnE7vAj5kLjPJjI5A75JIE2Aqy69XDs3IS8q0/3Rte9VxEId1U/Qd/vkj0+GgiBzkDVIIDJf0sljS794tELd6bqxPcc9DbGc2jKhGSph2jon+xr/6MdJGVt58Zob0UCL/LuGL3LJ6Ge8qLMnrO2BvJ0q3qwwHtGMs0L7D199+0e7laylmLlSKwoe37EYE2HlWlHycfrzN8w4TLUKraLrwIAbBdIYUnlAZrGdJw0lf+XKeshFSAidwNuLYpqA2YuqkuiZV0NocRYM1ufVH75EVWTFIiotBLo4vRQJGExFpAlGRGI0+enlwK9nH+WmGrQeeTaDTbKO3v8e5C46wxyG2N+dQT31jrd6/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2119.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(956004)(8936002)(6486002)(2616005)(7696005)(66946007)(6916009)(478600001)(66476007)(66556008)(6666004)(4326008)(26005)(38100700001)(83380400001)(2906002)(5660300002)(186003)(86362001)(16526019)(316002)(44832011)(36756003)(1076003)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wNupmjEiUqPTBZ6JvSfAYyYTjyKzg0bWGf7RYy4l67Fjqea6VC7jDGr8c/a8?=
 =?us-ascii?Q?+MYTmPGrBLchqlFtFbqUAq8Nai8qCy1GiYeRE4cYu2jeWfCPgcID5PbGPaX3?=
 =?us-ascii?Q?Iwbt/22VWNWo4hTDiQQ6ZT2MRsuoFXfLMD4R+S9R/n5Y/3w25mrsZGYf72JJ?=
 =?us-ascii?Q?eI61wDDLzJ8HZnporWfWPHICTVTe1ocxt+lOIFhWG2sO1R5suuGklT5YNNcT?=
 =?us-ascii?Q?uFBtO74u1Tot610EQtM/TOfCAi8cBauMGHp6CH+s3Si50LdyIeGO6ww79Q/2?=
 =?us-ascii?Q?1sHDvDF5abeAy8kdeeOdGva/6/ckR4Ykv/te+2UtetpTfBAxF8uw/ihOyi2r?=
 =?us-ascii?Q?ExPrrbycunMNzti8npURR/tymrHKFpO9jdMj4lc1pN6Qx/sdViXkLD7EQ4bW?=
 =?us-ascii?Q?glfOLnAgfo+OI0tygNm9IAvNCleOOcvTBYe3B71pJXhh5R0AyOnv6LHfndof?=
 =?us-ascii?Q?N9v9nPiusKZOZU/Qc2i5md1BBli4OYBAYYi5Bo0yO5CyxYB0tVaMQGY9eOgH?=
 =?us-ascii?Q?tXGr8V7aqJAXpQgrm6/HD6CepFqhtuMcZott8pYW1GbsTU4t4bWzz04Otdkh?=
 =?us-ascii?Q?7uTa99uY3c9/lS5aXAso663OYlL+j4/0kZ6XydShVG/6C+QZxRj3mHhfwfPo?=
 =?us-ascii?Q?yr8sJwl8G9ITZDWayM52Bmvj7wEHCKeQcD2Fh1OPEpuDxaHZTvbuM1UvXR91?=
 =?us-ascii?Q?uWWtOAX2JAkcXQY7lpxzV08GGUfHOBgIGR56CHJSD0c09hKzvkRVLnkfTmeH?=
 =?us-ascii?Q?h7Sgv6DkVrh/7W9K8Dl3IwACrAuf9l9QO0ry1CgTMNG9n3u8F2l0vk4F78U6?=
 =?us-ascii?Q?jO3t+quY6Fxu+B1uA1rWoEMH6K9hdWsMpe94QXS7guc1JfydyqoP7FZ2XZgY?=
 =?us-ascii?Q?XB3OU+hnMhdHVsAnqpATamtatceYcKa60YTOEHb6kXUVF1425ATA2t5fktfD?=
 =?us-ascii?Q?XGv457Eh4kWU+kLO72xrB2lS4xPqhGFXmnpppsQen88vaGH4iPu1MB9EpbzW?=
 =?us-ascii?Q?jljqObE9of5T/UeXt11cckd3Jb947g/DQg1G+TIjhsbYdaoOt3oWqiaLGTzT?=
 =?us-ascii?Q?XA+LJqyTtFoBJkrZD10fuxxKZMZDNCRCYUm9OTM0aRYlQIcWucWCo0VoaJ5M?=
 =?us-ascii?Q?QOG0nOIKxpXV96gr072WkRFs3iSohcr0t/Sy2hgPoQGm4d3wtfjY/yz3fC3c?=
 =?us-ascii?Q?v1AWdW5vhrYV0FdAIwkJ3FHHXK8sdb8hcHBu0rp7x5B85fvePQsMFLKXmqn6?=
 =?us-ascii?Q?Y4WqmV/xINq69AV7GWizKtA8Kr0ZbMHWZdC2zRGsmiBzPxFVv63MdnxtSDuI?=
 =?us-ascii?Q?b0ZZY+ZBrK+spzaUSjp8l17Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68feeb83-b383-43da-1f70-08d8ee66b3ab
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2119.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 01:46:54.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8uh3NZc3uKNGnEZZKh0lY8mS+/71NVFzF3EfeQ1YWOFMzAstjnmyF00txJL92sGuwjlbFxLkBKoFSZ9CGCPQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1304
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240011
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240010
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This test checks that the server will allow a conflicting lock from a
second client, after lease expiry of the first client.

This applies to both courteous, and discourteous servers, but ensures
that courteous servers don't just hang onto state indefinitely.

Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
---
 nfs4.1/server41tests/st_courtesy.py | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/nfs4.1/server41tests/st_courtesy.py b/nfs4.1/server41tests/st_courtesy.py
index e74d9afbca60..dd911a37772d 100644
--- a/nfs4.1/server41tests/st_courtesy.py
+++ b/nfs4.1/server41tests/st_courtesy.py
@@ -48,3 +48,36 @@ def testLockSleepLockU(t, env):
 
     res = close_file(sess1, fh, stateid=stateid)
     check(res)
+
+def testLockSleepLock(t, env):
+    """ensure that a courteous server will allow a conflicting lock from
+       a second client, after lease expiry of the first client.
+       A discourteous server should allow this too, of course.
+
+    FLAGS: courteous all
+    CODE: COUR2
+    """
+
+    sess1 = env.c1.new_client_session(env.testname(t))
+
+    res = create_file(sess1, env.testname(t))
+    check(res)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+    res = sess1.compound(cour_lockargs(fh, stateid))
+    check(res, NFS4_OK)
+
+    lease_time = _getleasetime(sess1)
+    env.sleep(lease_time * 2, "twice the lease period")
+
+    c2 = env.c1.new_client(b"%s_2" % env.testname(t))
+    sess2 = c2.create_session()
+
+    res = open_file(sess2, env.testname(t), access=OPEN4_SHARE_ACCESS_WRITE)
+    check(res)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+    res = sess2.compound(cour_lockargs(fh, stateid))
+    check(res, NFS4_OK)
-- 
2.27.0

