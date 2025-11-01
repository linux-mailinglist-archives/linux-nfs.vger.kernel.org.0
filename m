Return-Path: <linux-nfs+bounces-15864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCFEC2856F
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F5824E41BA
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Nov 2025 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141792FBDF5;
	Sat,  1 Nov 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nvhAxYdd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D82F99B5
	for <linux-nfs@vger.kernel.org>; Sat,  1 Nov 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021740; cv=none; b=uoL6h0RalKNzZ14im/SMM0Uv3VFnIRnyPiNFO2ga0AhO54/IQF/T7heEoiS9IS7mc2uR5ngt+6+rKtPVp9ZEe3xBEIq1LOb+narTiQAHobYhaDUu/IhivhDZgZW7VHimj6UJFI5g+YSQfI96q5DZaQodTkmylLNuAhbSPn2GREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021740; c=relaxed/simple;
	bh=oFr/VtuuWbwN6qUQty3lE/dbyhA8mbdFi/Wh1kDJuL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rve0f1g/pPsqbVh3PW/yy29Ov6b4VkBYAXhnERkbkaG30hN8+ohB52HRFH3prLrtv4DK22Mvcs6iGRjxtZZz0+KpFP6/XWpowYM/0ROMJPVOB7v89yjdA9JegvlxH6iqIr82bvn6NevLHBVc7e1AJNguzRZFT9EXwCcWzM0xVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nvhAxYdd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1ISHc2002167;
	Sat, 1 Nov 2025 18:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=O9GUO
	HUhkuuZtSUj8rksMJfn+0V0zeltThcsNlX5Ui4=; b=nvhAxYddoy+wDRxoqsZEQ
	7QAYGUG7PyUVkxIQ2urZmGMPKbC543AuTssdF1cFj/8vmc2Jet3s+wc2a1AtdEMd
	aabU6lu7vfDzBjrFyGGm+bTtkc7Dv3zC2TK828UrqUU6jpdah99YVZv5lfuz3yG3
	A6alpstGqAEI9VyyOmaiXXdlL1yC1Zfy9wI0GJoVCZvgN08Ew9Xxm3JeSugZnEIf
	J0GqridMeL4X2as/0qSkWX6UqTe7Hz9gu8PCUblHup5vcY7HKecP9or1HqOt14YA
	3s5TcplXE5iCQQ8aL18S4XXByj5i8vH0k3Dn+CckDkL7mk64cShgBQcoZzCmhppp
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qf2r02p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:28:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1GVjQB007966;
	Sat, 1 Nov 2025 18:28:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58na8cwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:28:41 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A1ISbNW035467;
	Sat, 1 Nov 2025 18:28:41 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58na8cvp-4;
	Sat, 01 Nov 2025 18:28:41 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSD: Add trace point for SCSI fencing operation.
Date: Sat,  1 Nov 2025 11:25:20 -0700
Message-ID: <20251101182819.651120-4-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101182819.651120-1-dai.ngo@oracle.com>
References: <20251101182819.651120-1-dai.ngo@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511010159
X-Proofpoint-GUID: jVpu4TQIcpOcshss2G4OJB3dc8BwnLGS
X-Authority-Analysis: v=2.4 cv=HODO14tv c=1 sm=1 tr=0 ts=6906515a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ro0K2ivkSJ57f8edTZkA:9 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: jVpu4TQIcpOcshss2G4OJB3dc8BwnLGS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE1OCBTYWx0ZWRfX97KRLEXkSKKT
 JI99QQ9QFFhvYSwAgqwFZbr//S8Z5Jbtli6g2CH7qSSNJeyPj+/5qo0+wpVlUEOVN3SN9JXJeha
 F/G9C6o3U9mNjnnV+86IyfWbPe8pcXT2v44+hEgj0E5Phxhd3CNR9GWhYvrEGOiYXJYffEQ9ujA
 CybFdsaarbt4831ffhFuwIJYWANZVgnE3V38QbHa1IdkdF9bDPBkHgX3RqKceZRUFCleYWydKsl
 /Bz0SRHQAS8IL0ZsArbF4Mk8d2xpqthV8qWBdfxuPtXZftoQ4vjryDsFUoRi851LUjXpuGE/IoP
 DfqjC0w8UCjBVbEPPKfa06Q/vKKUfSkhzlMhapXUPkDkenE7S+mLgyiadUqAAalj6zn4Tyf1QLI
 5IfvFWx54hJ5GbYM6OtecREo38ck8PbcorO/6lhnt4876xMoa6o=

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


