Return-Path: <linux-nfs+bounces-16095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54CC37C76
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 21:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB0518C6AFA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9C17993;
	Wed,  5 Nov 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4IynQUv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2612D8792
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375685; cv=none; b=ry8xceaTsBXd9/6VC/MIZpbeIzaSTRHXyPjwf4E074ITOroqp3Ae48I49Qfd2nBNThw64jzQ21cC9DWJ+8O90xYSmJp5smiSDjW/V5hfiIJxyldDzOh2UdO/tPgrJ3qEYgwZ8mcFqco+5O+07Kcx9FNcS9B0VSKKs0bLdSokcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375685; c=relaxed/simple;
	bh=nh2u1cyf+Mk+ZDhrWjcXjF0usVJO+neWqJZUFQzn7ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qu6tBALHFj67AncbTEijFRo4T/kk6kIMvxJtpNKqfM5nMglYwpYv4QupHwOuQdb+FMRAgmDMTH39Jwz6gmhSPcRamYhYqwkuQgr6DtCFLfmO1eHB9EP6BnI4XJc02x7R+aXCIgXzHF6+IXazfd17aT5zdzribwgHW1KHuVrIS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l4IynQUv; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HdQik017359;
	Wed, 5 Nov 2025 20:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Dv9xe
	s5oBSqQB4qZ9CBsV9FAwawFP06nJwn47IZb8f4=; b=l4IynQUv0QlBvA3prVdIp
	Q8nD6K8odAiV0ZOo87o0GEDMdo0hDmL2cQTgcCvLnECz/wacXR5QpZhXpeh+EzQP
	JAOUO72TlnrtzbnmayymYgr9yUaBxu9c1p1ABZtT2qEnA9/CdvCDHpJkGHXv4KnG
	ArtHyUsMM/CjkoedoakqjLfUQ/zY2Bf3uH23Awqm44O9SiCr07Xiwsi9/IvpuHR0
	vPi/mcNJRCZV6cAGMrD05cvTEv2egrAAUyrN0ATUs8rgdyzbvQ8inzMRBACjjHCh
	/zZDF9QnKno5LRoRWKPPQuJDRX/NqeIPDBbK1RSjrXKPyQhb1JKfdsyokHg8NvTu
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8b5yrcq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 20:47:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5JrrZG002645;
	Wed, 5 Nov 2025 20:47:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nf347b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 20:47:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A5KlnEk033889;
	Wed, 5 Nov 2025 20:47:51 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nf345c-3;
	Wed, 05 Nov 2025 20:47:51 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] NFSD: Add trace point for SCSI fencing operation.
Date: Wed,  5 Nov 2025 12:45:55 -0800
Message-ID: <20251105204737.3815186-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105204737.3815186-1-dai.ngo@oracle.com>
References: <20251105204737.3815186-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050162
X-Authority-Analysis: v=2.4 cv=IcKKmGqa c=1 sm=1 tr=0 ts=690bb7f8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ro0K2ivkSJ57f8edTZkA:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: _PAvMZ-eFWoIioE6u-gL4Y6-SEU93q8n
X-Proofpoint-GUID: _PAvMZ-eFWoIioE6u-gL4Y6-SEU93q8n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzOCBTYWx0ZWRfX0JDgfyZqcKGH
 E2yOgwWUIgDnWT4/XTqpT5bMf3LXeyxzF1YYw8fy9CBka3sEtYmAwA4YNC5RaIDF40r/ogIqvGR
 /dgHUBe4HB0yKLqN6pl24ef0eSwtjnhqok71doQ0zJc0WcCO0tP9nxRQshDpMA74YTElrZAQP3R
 vrIahoUqRP9ujoMBkxzzZAzvXI9l0BmIgPWsW6UpUXV1hNvbTfyqk/QGRJ6T3tun67dPL0EmSu0
 gs8NJBEF5kBgKHkvvNDAGPbq84331gRp5N4uU8Yz+FOY1cTB2RCOk5pwPc0ymf2fCSckxDi83tz
 KcSmqtNGDatSX6vRytadkFxx4MV4bQIeRZdapnWpkOacdrSP6D399lajUDhbwfz3lBp1+y5ndz2
 wm15AFn7kTbBXcb6S9i2L5pdvQRyBIBA1terXWiclNBK8YsjuI8=

Add trace point to print client IP address, net namespace number,
device name and status of SCSI pr_preempt command.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c |  5 ++++-
 fs/nfsd/trace.h       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 815c6e0cde5e..fd8a0995ab33 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -13,6 +13,7 @@
 #include "pnfs.h"
 #include "filecache.h"
 #include "vfs.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
@@ -340,10 +341,12 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
+	int status;
 
-	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
+	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
 const struct nfsd4_layout_ops scsi_layout_ops = {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 6e2c8e2aab10..9bfcd90aec9e 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2613,6 +2613,44 @@ DEFINE_EVENT(nfsd_vfs_getattr_class, __name,		\
 DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd_vfs_getattr);
 DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd_vfs_statfs);
 
+DECLARE_EVENT_CLASS(nfsd_pnfs_class,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		const char *dev,
+		int error
+	),
+	TP_ARGS(clp, dev, error),
+	TP_STRUCT__entry(
+		__sockaddr(addr, sizeof(struct sockaddr_in6))
+		__field(unsigned int, netns_ino)
+		__string(dev, dev)
+		__field(u32, error)
+	),
+	TP_fast_assign(
+		__assign_sockaddr(addr, &clp->cl_addr,
+				sizeof(struct sockaddr_in6));
+		__entry->netns_ino = clp->net->ns.inum;
+		__assign_str(dev);
+		__entry->error = error;
+	),
+	TP_printk("client=%pISpc nn=%d dev=%s error=%d",
+		__get_sockaddr(addr),
+		__entry->netns_ino,
+		__get_str(dev),
+		__entry->error
+	)
+);
+
+#define DEFINE_NFSD_PNFS_ERR_EVENT(name)		\
+DEFINE_EVENT(nfsd_pnfs_class, nfsd_pnfs_##name,	\
+	TP_PROTO(					\
+		const struct nfs4_client *clp,		\
+		const char *dev,				\
+		int error				\
+	),						\
+	TP_ARGS(clp, dev, error))
+
+DEFINE_NFSD_PNFS_ERR_EVENT(fence);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.47.3


