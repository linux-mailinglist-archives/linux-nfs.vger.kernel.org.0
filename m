Return-Path: <linux-nfs+bounces-4298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B3916E4A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CD47B238E0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E1A174EE2;
	Tue, 25 Jun 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R8hRoBoj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9E174EC6;
	Tue, 25 Jun 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333801; cv=none; b=uglADRwp5UUfjuhPXl35SAKAc9EZ3aVQI4O/8QbNhtTApzBbLNEy1mHKqAeBPGh5lfStYJpwAmLJyi6v0cymi2MiPi+rfEIhFSwJ8UeFRdMdfB+YLLeD8HLAVe+zh4UfGNXK4rowxzRqUKUZQUpfPO/glm4Tven2HJfXJ+m6x5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333801; c=relaxed/simple;
	bh=2L/weZesvpaS33GujX2m1IrTRFya4TVbCAXm5cfqiXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ILmRZI7sZrg8yDImhpDVdBzDUoFNIHkdQ8aVXu8FHCsDVrH6RKVQ4rC5CLiQ1t1E924yku/KMYyRrldBqSxxu1SoylvhF+PcRJ70vKCmocUcJGA1+WlYDrnZ3sjD1MGoEKRZ0mPOp2Jv5J2Ou59gaU6AN6DnWj0WCW0seO70xcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R8hRoBoj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8ZnhS017339;
	Tue, 25 Jun 2024 16:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fnTd3X2IcxnuPJrt8M3MaL
	pgA/56i9asApZb/lKpIcg=; b=R8hRoBojD9z7h+MWYh4dC5FkLEI07p7yiwnPT9
	lF1JM2NjlkDFxgBxgzKh64teLkCA9gmH24gKt5TwcbFYhaOnwlWUuW8f1jYpY+X7
	O7ZGGvgzzFT35jBQy3KXnBX0jppG3xEAw4fVs6fzvugIO5NIYK/G+VVif5jiB6Q8
	7Qok55XhHGOrxDr7AEYYbotyYNfxKVcg1LkMEstzNV8950YU+CzK8I7/fjISehex
	ALRhaIzw3MAOoTRL75IXuq+6Fhy65UmTDowKi2EWcUDilY1fDDVjnWzJRZjOwMv5
	lRQRSs8MzRkvQxW9qVc+PLtCUPhRzTxTMBm3f+kix6tO4emg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw9eue7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 16:42:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PGgolS009442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 16:42:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 09:42:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 25 Jun 2024 09:42:49 -0700
Subject: [PATCH v2] fs: nfs: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240625-md-fs-nfs-v2-1-2316b64ffaa5@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAInzemYC/22NwQ6CMBBEf4X07Jq2Ugye/A/DoS2LbCJFu0Awp
 P9u4exhDi+ZmbcJxkjI4lZsIuJCTGPIoE+F8L0NTwRqMwstdSmNvsLQQscQckrdqRpdJZ2RIvf
 fETtaj69Hk9lZRnDRBt/vDy8K8wqD5QnjXu+JpzF+D/Oi9tE/yaJAQVVaZbB25mKr+2cmT8Gf/
 TiIJqX0A4T9RzPDAAAA
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton
	<jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3ufymTWmd9CZcxEu6-Paw8LvycJvOxtq
X-Proofpoint-GUID: 3ufymTWmd9CZcxEu6-Paw8LvycJvOxtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250122

Fix the 'make W=1' warnings:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs_common/nfs_acl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs_common/grace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv3.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Updated the description in grace.c per Jeff Layton
- Link to v1: https://lore.kernel.org/r/20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.com
---
 fs/nfs/inode.c         | 1 +
 fs/nfs/nfs2super.c     | 1 +
 fs/nfs/nfs3super.c     | 1 +
 fs/nfs/nfs4super.c     | 1 +
 fs/nfs_common/grace.c  | 1 +
 fs/nfs_common/nfsacl.c | 1 +
 6 files changed, 6 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index acef52ecb1bb..57c473e9d00f 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2538,6 +2538,7 @@ static void __exit exit_nfs_fs(void)
 
 /* Not quite true; I just maintain it */
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
+MODULE_DESCRIPTION("NFS client support");
 MODULE_LICENSE("GPL");
 module_param(enable_ino64, bool, 0644);
 
diff --git a/fs/nfs/nfs2super.c b/fs/nfs/nfs2super.c
index 467f21ee6a35..b1badc70bd71 100644
--- a/fs/nfs/nfs2super.c
+++ b/fs/nfs/nfs2super.c
@@ -26,6 +26,7 @@ static void __exit exit_nfs_v2(void)
 	unregister_nfs_version(&nfs_v2);
 }
 
+MODULE_DESCRIPTION("NFSv2 client support");
 MODULE_LICENSE("GPL");
 
 module_init(init_nfs_v2);
diff --git a/fs/nfs/nfs3super.c b/fs/nfs/nfs3super.c
index 8a9be9e47f76..20a80478449e 100644
--- a/fs/nfs/nfs3super.c
+++ b/fs/nfs/nfs3super.c
@@ -27,6 +27,7 @@ static void __exit exit_nfs_v3(void)
 	unregister_nfs_version(&nfs_v3);
 }
 
+MODULE_DESCRIPTION("NFSv3 client support");
 MODULE_LICENSE("GPL");
 
 module_init(init_nfs_v3);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 8da5a9c000f4..b29a26923ce0 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -332,6 +332,7 @@ static void __exit exit_nfs_v4(void)
 	nfs_dns_resolver_destroy();
 }
 
+MODULE_DESCRIPTION("NFSv4 client support");
 MODULE_LICENSE("GPL");
 
 module_init(init_nfs_v4);
diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
index 1479583fbb62..27cd0d13143b 100644
--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -139,6 +139,7 @@ exit_grace(void)
 }
 
 MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
+MODULE_DESCRIPTION("NFS client and server infrastructure");
 MODULE_LICENSE("GPL");
 module_init(init_grace)
 module_exit(exit_grace)
diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index 5a5bd85d08f8..ea382b75b26c 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -29,6 +29,7 @@
 #include <linux/nfs3.h>
 #include <linux/sort.h>
 
+MODULE_DESCRIPTION("NFS ACL support");
 MODULE_LICENSE("GPL");
 
 struct nfsacl_encode_desc {

---
base-commit: 50736169ecc8387247fe6a00932852ce7b057083
change-id: 20240527-md-fs-nfs-42f19eb60b50


