Return-Path: <linux-nfs+bounces-15867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0A8C285B1
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 19:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D890F3AC921
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6FE2FC890;
	Sat,  1 Nov 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qg0+nQRI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50D2FC870
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023163; cv=none; b=lAy598ckAZvpZwmL4pRz9FBeQeFEJqpqpKgs3x4VVucZbGEj6Pv3FF2e8d04j2+oJugxMkciqKkltMF6z4RvfYVezsKaVH95P5rZODz7k2pQ2olbxxV5OzykQ8KAALjXIAIPrHab3+oFJlMzMivr4i2o1sDGC6hXNTdldKMMCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023163; c=relaxed/simple;
	bh=oFr/VtuuWbwN6qUQty3lE/dbyhA8mbdFi/Wh1kDJuL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd6bej5eiWcdYH7FUvc3jKtyFtjP6Pf0Ubf+DIERGkfL4yg411dOcQDSB6jIG7gcug5IpUli3YxAH5TUuUgcRgM9FAV5eys3tSZNTbVDpNBAnN0gQkY3OtNVaux06eG4mweYLLc3rhHX004qLShh2TsPSGL0TP+gKUvRhCvz3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qg0+nQRI; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1IZqis013328;
	Sat, 1 Nov 2025 18:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=O9GUO
	HUhkuuZtSUj8rksMJfn+0V0zeltThcsNlX5Ui4=; b=Qg0+nQRIHY/5bucs6rD8a
	1NbKGLb/J4MKVriO6Ie9ml9DIK8bHGbec0QOQaA0gfPUsyvBkNWd2lAKy/k6cZo2
	uoicHAcSOpPDYCcqAoYUKYwT5R4OFQ21XJ2LnQLqzv0HFfp6bblU+31xvVAY+vYO
	D3QYfG/N4vNzoB4HKsE37VCmYWZ5ZJDyzcLWMFs3AMJ9aDmNpm5TE90RZWJVg5Co
	fwcicTJffEYzROADKrR99Oll1/2RosG/TsOdA+xuN+lJ2069HVoLZJLsqegzzFyE
	yNZMCDOG6A3FK+c3NsdGT+FgJjzT/henWH00Wywx2E3qlw0kFYP8H0r4jEVHqM1+
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qkrr0hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:52:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1H03Xa017576;
	Sat, 1 Nov 2025 18:52:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n6ggm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:52:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1IqTSi011363;
	Sat, 1 Nov 2025 18:52:30 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58n6ggks-4;
	Sat, 01 Nov 2025 18:52:30 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSD: Add trace point for SCSI fencing operation.
Date: Sat,  1 Nov 2025 11:51:35 -0700
Message-ID: <20251101185220.663905-4-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101185220.663905-1-dai.ngo@oracle.com>
References: <20251101185220.663905-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511010162
X-Authority-Analysis: v=2.4 cv=FqAIPmrq c=1 sm=1 tr=0 ts=690656f0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ro0K2ivkSJ57f8edTZkA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: oOFHb8D66jx7SFnJCnoFQ3iecycE4bOs
X-Proofpoint-GUID: oOFHb8D66jx7SFnJCnoFQ3iecycE4bOs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE1OSBTYWx0ZWRfX/zrywf6eRLZh
 YDO0gjupJqfVTTXesz4WTuyR5yf43lW5lz44JxAzWGL3X0NLmdlBPfMcVg6/8+77WOmUAt85U7e
 3Rip2uL6pmOhhVqJaA9tkdfzfVRwPHkjx5UuK/0aPbveupI7kNGheWbpRSDhzKzWPo+1jAmgmGA
 eLhnfBSsSdMg/bZg9fNkLf6OIorFZGPe3gqjQ1hXytr9YLzNAokm9pTwdVnnL6R1j7+3peLw6Am
 aVHYp/Sfn8Ik6q9O00yfmxxy+FDDwum+VuD+UxIdmRZmDs6Zsko7oXwlw3N2SPGa0yFb1Kr8AJg
 DjLow7G/buIrOAzZ0ZPKa8XoJ0x5iVyGWk0wSp/u0NPZWGot2YpIeTBI9J4RAm4z9qjUyrayaAw
 Xe1tRrMG6juswuAQ25YhyfXZi+5x0A==

Add trace point to print client IP address, device name and
status of SCSI pr_preempt command.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c |  5 ++++-
 fs/nfsd/trace.h       | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 13ff7f474190..5fb0b6d59fdc 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -13,6 +13,7 @@
 #include "pnfs.h"
 #include "filecache.h"
 #include "vfs.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
@@ -340,9 +341,11 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
+	int status;
 
-	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
+	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp), PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
 const struct nfsd4_layout_ops scsi_layout_ops = {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 6e2c8e2aab10..6a8c840bcf2a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2613,6 +2613,42 @@ DEFINE_EVENT(nfsd_vfs_getattr_class, __name,		\
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
+		__string(dev, dev)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__field(u32, error)
+	),
+	TP_fast_assign(
+		memcpy(__entry->addr, &clp->cl_addr,
+			sizeof(struct sockaddr_in6));
+		__assign_str(dev);
+		__entry->error = error;
+	),
+	TP_printk("client=%pISpc dev=%s error=%d",
+		__entry->addr,
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
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.47.3


