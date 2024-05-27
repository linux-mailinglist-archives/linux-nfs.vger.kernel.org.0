Return-Path: <linux-nfs+bounces-3422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E878D09A6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487091C20EB4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3434B15F335;
	Mon, 27 May 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jWzWduf0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142A15F321;
	Mon, 27 May 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832753; cv=none; b=kSlosz66UcuCFnYftUTNBtbx7xbTl8qhcIj2byoxuUvhhN8nDj9GmKJM1pCnZpvk+R9S9b37mGcp6+6maYxAjkW6taX0SyoaX61IF2l9yc9iqg4IzUfdGqKHAKgglbo0GP7YPozESUQTmrJDoI22dR8idnCh4147fQkEElbDHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832753; c=relaxed/simple;
	bh=of2jhOL/LSFnCXBG9snT4/owqF920gtFI1/cC3QyP0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=AsRU7qCKWxD75/S5NtqWymbEqbeDLCVivtF9AMMYvDgkC01CKwesAPrhb4Gvx+t3GlmnALu+3SjVFnFuJYnYLdVdXJJBugjJIA2P0cydng2qdvbTdV2mpBZ27DKd7uRUYJD1V+V3tZQZppQSKaDV6+UHGdVAcGa7qKCC87dipZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jWzWduf0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RHgkWS011606;
	Mon, 27 May 2024 17:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yBFXx4wSHCvnnuEyrHy9xB
	0Y7GsUJjUAk67rSST1ZCk=; b=jWzWduf0Ao42Dbg6YyFsgabapHIxVK5+Ugbym2
	lgE4J08fO6AvAR2/aeeIgkbUsXoplEnzVeGjbKtYOZ4rYGWuT+hKT14/zPBHCyaN
	ySacKTjql2SVTeRUfGpBTMC4z8qVluHm+r9AeDWHeSQP+UA/IhUJxWW6svJ2k0yd
	58eb2EvnTndVSAdfhYLbV2cRNax/+CNhAyUrX3IcgtRkHCgc903FZJD4dVT1s5vN
	yLLOgIH1LZ+HEf9Pgw5qVAhr4wiIp9CAf/juhQ/qpE5KvmegKQfc9KIKZ07UwFuJ
	GwhR2+rJWLRf++slS9+cGwQh0xxjl/RZw3RtRyew5ca208rg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0g4exd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 17:58:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RHwtkJ011996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 17:58:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 10:58:54 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 May 2024 10:58:54 -0700
Subject: [PATCH] fs: nfs: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAN3JVGYC/x3MQQqDQAyF4atI1g2Mg1baq5QuZjRTA5qWREUQ7
 960i7f44PEfYKRMBvfqAKWNjd/iqC8V9GOSFyEPboghNqGNHc4DFkPxNbHUN8rXkNsA/v8oFd7
 /rcfTnZMRZk3Sj7/CxLLuOCdbSOE8v6fbT7J6AAAA
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton
	<jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uMbwz0wvCbEhAN3XKAX0AoVYFKAwxB3h
X-Proofpoint-ORIG-GUID: uMbwz0wvCbEhAN3XKAX0AoVYFKAwxB3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270147

Fix the 'make W=1' warnings:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs_common/nfs_acl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs_common/grace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv3.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
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
index 1479583fbb62..8f034aa8c88b 100644
--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -139,6 +139,7 @@ exit_grace(void)
 }
 
 MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
+MODULE_DESCRIPTION("lockd and nfsv4 grace period control");
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
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240527-md-fs-nfs-42f19eb60b50


