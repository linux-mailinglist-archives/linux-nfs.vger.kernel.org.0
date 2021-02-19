Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA59832004A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 22:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBSV0C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 16:26:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSV0A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 16:26:00 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JLOvoK074022;
        Fri, 19 Feb 2021 21:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=XFqOLVFldgLvw2+HTDSraAOn69BFrmLtCod8pSamVJ4=;
 b=AcjzwIa6I4g98KFJFVnx3IND2EDf5K+7bRuVfnVuV4AOA2e9oHmR/R1UmrR9h9gwTJNY
 aTu9cNhWj5bEsw0Gu5Nba9xm5mJcge/BQl539ks9868MDA4n1UdfaGrleK4yaR4nHrfw
 rsii/UK6rldk69QVPmIjK72v3XZ6vPqWpLXMokTm5a3UzwPTUZnS3ONMfJpQoZ5pApo8
 n7jpiOlrWdmNjXCfo1rEruMawV8PhqChv/ez13wcGZ6v+UAk82n8efGP1ht/sK/r3ktP
 Gw4CfpS9bQbHY8ow5plQR12q1DtjXFn9LjLwTYef/V5gdyUd04ND9b45ClLPPpYeqDfR ZQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36p7dnts29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 21:25:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JLANpZ193545;
        Fri, 19 Feb 2021 21:25:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 36prp3cn2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 21:25:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRU7SKUI4viaBdr3BNWA8VmLhKLWGE2ApT+XzirPrvS1YaGRmjfo/NvWt0+muDRSRxwNfYfjZuNU/tFIPbvHPaBCmmOtvuink8YiFOl2mtGF2CmV9kBwF8J/ES9KwQKUQklezp7qOfT4cA3v0hRHUL7bZQ/OEnpJntzR7C4/PPJO89z8B7f+HfhM3w9UUIz4qxqp6K4byD9ttiBeT6WwoIQGFVgepEqOcTVOIPU1x6CsHlWrdvG/li6htudSCLIOMzonAHJ19ZOTuaXGJRIoynX3rI2Fq7TVkBhzuVIQcOt3IEtHTigTpamkeRTf8dVW4bB0Dn81qkBVRNEp7pj5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFqOLVFldgLvw2+HTDSraAOn69BFrmLtCod8pSamVJ4=;
 b=Mh2u6ZyNSmjb97i5SkeasB+a5k3uBlcxz9EedzRIispPAPyChuMDZ7Pq0G8J1OMfrwHGgy+A0dJS0jhVJc9yGk/SWxF4B8tNs8hTZbSHDBHqftyCrp0hKqlf2S1cC8oa0NISZoI1GTnlVAzyw+dcBtbYIWQzptbdB/ZAJR7w9HwqYRH3CKX964IFjmLQGfdFh2v4KgCP0LSBX3BvkcpYEPehn6mbTyEu+mFYj+WTR548CPMi6Bo76e3S0Op0l7dO3/MxFOcj0DCa9mWHHineRoLmWTbHfJ/9Gm5iT3KRMyuVtxAWK1fp4IaFUgsZdMMJsj7B9HsC2H44tWjZxZlstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFqOLVFldgLvw2+HTDSraAOn69BFrmLtCod8pSamVJ4=;
 b=q60thjuDX+31ZpcP13EBGt6CvBa/rHwlhSA8rto0B6pqT5IgMrCJpiACb8+RsVUZgRIVLnNr/N+6m5DI10SkA5UDQmuO4x6fMO2AuctZtLkH4XTZkOlqhqiff9ZKeqqtJZo3goYF2Pi/rLTTfi8QPighpZRkhue7uOeqUXpQAuk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15) by CY4PR1001MB2214.namprd10.prod.outlook.com
 (2603:10b6:910:41::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 19 Feb
 2021 21:25:14 +0000
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2]) by CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2%6]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 21:25:14 +0000
From:   Calum Mackay <calum.mackay@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] pynfs: add courteous server tests
Date:   Fri, 19 Feb 2021 21:24:47 +0000
Message-Id: <20210219212447.15549-1-calum.mackay@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-Originating-IP: [141.143.213.42]
X-ClientProxiedBy: LO4P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::17) To CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from cdmvmol7.uk.oracle.com (141.143.213.42) by LO4P123CA0012.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:150::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38 via Frontend Transport; Fri, 19 Feb 2021 21:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7065a540-903e-4f28-f401-08d8d51cd82c
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2214E03BA20088D4D0AE2A88E7849@CY4PR1001MB2214.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbm4V0Z0pa/n3aFOTldFGTs+iNzXkm7TdclmfR5eVHmo0lkh0jfr00wDFFEoftKbvbslXbmfGiPsu/ejnTtFN/uD/mCalkz89V1br4RPLTNXwwN2T4qXlLuQ+/R1yxH1CnTyqDlcS76ghMCLdNGrk/3A3KpnZxN5oIo7bOEdqOq1WikjOBFNu5dGMsJ3UvVjeqjijydmbAE+Ugg0ewUaSf2998qepzhVD2csADl91v+GF1eBgvgh0ANSiLDm+oCALIks8ngtcLDT238hjYVi/qJE7djU0tuwoHbMV4LQXN8RIZs0UR2uhPAsChsrkB17wv2YI1aXBfDKh+FuuEiprmq+atXJdo2iGk6zbepolaB09Cn1yApKKW7eE4oRsVJXbAxz3IslPoVGp7/hVqqZkyLFPj/9i1/RZMeRqkk8qlwUEp1H9dwei8javOA0Tu7GzGRCxEg71nkD2Vznhap0ROXvxY8wU3v/qX24lDJd6IKzIPfCY8bX9/2iW6XROA/H7HSm/qwTtMulcproT65Rdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2119.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39860400002)(136003)(346002)(478600001)(2906002)(6666004)(2616005)(44832011)(36756003)(186003)(26005)(16526019)(52116002)(7696005)(956004)(316002)(5660300002)(8936002)(6916009)(86362001)(66476007)(66946007)(1076003)(83380400001)(8676002)(4326008)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fKro4QLOdWwB9o3e8g9sY2ewB2FNAViFk97Khs7p8CixKwSrbnTnYMRLcl0L2TkF6alDvGwZwQS9SfFxvxhohHOLAuzJiQQi7AWNIYNQdHms1oQ8Dkxi5EyamBj8UR3MWr8gDwN82YcYol9tK5SXnODKSpI5UaMIvKldHB0rILkoAZYTK+om3fotDtPwrxaGfnh+b8XGMYKkbnlaLQzXGDbnvPZqYRFBp/F08VbgkzYgnW4MWDP/FdWpvTPnupOlEbE0U7ECwXUajOyj+CIlo29v9h8k3bz91BUElM3PNzSV0c+cueUFXYvjt6tsxrFCcCQHH8CwCGDbgZvMBJjeABReL4bQsXgSQchI3BLwRAXs/H3biwVKRD0JMvCJxlauXPKEC/cG3/TDRGwB4p8T+381VwFo8Plz0BtqhVhxY3ShSjLMsfwr2owduxuA23ooeFut4ThNEGzajQvzq6MGdwG4VIckYESNQYJk99fkrt2CBIyh/+04fFa1+0DgJrNYOnylRzPhiQbgPEb66XFEQH+J9WSTg+zdOTu5o3jXTHxlIM6Ibk6V96SwwQU+3rgW4tRybl11Zr8K8+O0ltHui9fOqr3KsnsYSUQyPHd0U5FF3dNTp3ZAgoduzXTtNzZvr8xFFxzVFv/eb53NTcnufHls6xQ8tczvRJYcFQvpkIOpdtmULrtOB1raFfjuGJ4xDbnNNlCYte0EaAzUrGSC765aJAN2b4qg7Uc2E2g6fGJOJ+96fDCGLlYnwliXYDoD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7065a540-903e-4f28-f401-08d8d51cd82c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2119.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 21:25:13.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10HHBmShO1df6im9tgwiH9VHr1RCsrwZ0LXDnRScLteiVAb6p8Jb53fn7L0jI8u8rofMs4xc/N1ntIIaQRpK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2214
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190171
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190172
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a first test that simply locks, sleeps for twice the lease period,
then unlocks.

Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
---

I plan to add some more tests shortly, but will send what I have now,
in case it's useful for the upcoming BAT. This first test has been tried
against Solaris & Linux (discourteous) servers.

 nfs4.1/server41tests/__init__.py    |  1 +
 nfs4.1/server41tests/st_courtesy.py | 47 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 nfs4.1/server41tests/st_courtesy.py

diff --git a/nfs4.1/server41tests/__init__.py b/nfs4.1/server41tests/__init__.py
index a4d7ee65fb5e..ebb4e8847151 100644
--- a/nfs4.1/server41tests/__init__.py
+++ b/nfs4.1/server41tests/__init__.py
@@ -25,4 +25,5 @@ __all__ = ["st_exchange_id.py", # draft 21
            "st_sparse.py",
            "st_flex.py",
            "st_xattr.py",
+           "st_courtesy.py",
            ]
diff --git a/nfs4.1/server41tests/st_courtesy.py b/nfs4.1/server41tests/st_courtesy.py
new file mode 100644
index 000000000000..5e13dad44a01
--- /dev/null
+++ b/nfs4.1/server41tests/st_courtesy.py
@@ -0,0 +1,47 @@
+from .st_create_session import create_session
+from xdrdef.nfs4_const import *
+
+from .environment import check, fail, create_file, open_file, close_file
+from .environment import open_create_file_op, use_obj
+from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
+from xdrdef.nfs4_type import creatverfattr, fattr4, stateid4, locker4, lock_owner4
+from xdrdef.nfs4_type import open_to_lock_owner4
+import nfs_ops
+op = nfs_ops.NFS4ops()
+import threading
+
+
+def _getleasetime(sess):
+    res = sess.compound([op.putrootfh(), op.getattr(1 << FATTR4_LEASE_TIME)])
+    return res.resarray[-1].obj_attributes[FATTR4_LEASE_TIME]
+
+def testLockSleepLockU(t, env):
+    """test server courtesy by having LOCK and LOCKU
+       in separate compounds, separated by a sleep of twice the lease period
+
+    FLAGS: courteous
+    CODE: COUR1
+    """
+    sess1 = env.c1.new_client_session(env.testname(t))
+
+    res = create_file(sess1, env.testname(t))
+    check(res)
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+    open_to_lock_owner = open_to_lock_owner4( 0, stateid, 0, lock_owner4(0, b"lock1"))
+    lock_owner = locker4(open_owner=open_to_lock_owner, new_lock_owner=True)
+    lock_ops = [ op.lock(WRITE_LT, False, 0, NFS4_UINT64_MAX, lock_owner) ]
+    res = sess1.compound([op.putfh(fh)] + lock_ops)
+    check(res, NFS4_OK)
+
+    lease_time = _getleasetime(sess1)
+    env.sleep(lease_time * 2, "twice the lease period")
+
+    lock_stateid = res.resarray[-1].lock_stateid
+    lock_ops = [ op.locku(WRITE_LT, 0, lock_stateid, 0, NFS4_UINT64_MAX) ]
+    res = sess1.compound([op.putfh(fh)] + lock_ops)
+    check(res, NFS4_OK, warnlist = [NFS4ERR_BADSESSION])
+
+    res = close_file(sess1, fh, stateid=stateid)
+    check(res)
-- 
2.18.4

