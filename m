Return-Path: <linux-nfs+bounces-16020-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1AC32595
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 520E44E053E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F4321F5F;
	Tue,  4 Nov 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gEUMUsT4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E328337BB8
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277492; cv=none; b=mLjIQFyiZt7ZV3w34vPGgq+Fb2MfU5Y/8nZelVWV+7LOaCi6pbDgP3ZMFj+U3qlRBxC4yoUZ0LQnLJU1OBT4GBaT1e5l+2b/lgGo3bbd7XsL4ghHdQE+cLfAY6rQNbLBpSEBandRfB5mpgZqGLyL4NlSLXzoaol4KP53YxtOYP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277492; c=relaxed/simple;
	bh=nh2u1cyf+Mk+ZDhrWjcXjF0usVJO+neWqJZUFQzn7ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW8Eaqw3PQfhV9KdKecNz0JprYtdRLDAp3yNM1AarR9e86RQ0/T89V5GYFJFa0y47uEx+GuCWeJ4tFwkv8V2filEVPtOeGzc/MDXoc/Vtpf+hb6LqBDwz4bpa8HZK2BPILFoXMp+O5ZHFYYMG2sEIAhHfcbFS8oK+fwqQhPaY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gEUMUsT4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4HNMWl020162;
	Tue, 4 Nov 2025 17:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Dv9xe
	s5oBSqQB4qZ9CBsV9FAwawFP06nJwn47IZb8f4=; b=gEUMUsT4C28gF1py7Mrkm
	/rxGVUCtNRV7whSAPhnRAOCR7eJfy+Zy3c0f29jq0ILkarhczxn8rhh0LZQYHsQN
	N7ZVzWBVqG/fPzWs2VOLAzJQGxKyLXj3t0+9S8FZSbw6Th/ymFg2zUi9iR0Sbe75
	kjb7srFccYjXIAiJLYfwFnYVZPrv1sO9CI3H3ysmgHKQ74QLYBVpxVnTQYKJheUP
	Sq4sziIEdeqmOFEiJf5UJ/P0/k7bQNwZI3x9dK7B4MMa3fmjilWheM+Kq0Taesub
	gpPsDIBU25rpZos7fzZ/7oid3khrydcJjJC9D2YfThtA0Sn0wZ8eZ9n1+imCNAUA
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7nmw825c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:31:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4GiTmK010260;
	Tue, 4 Nov 2025 17:31:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nddwq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 17:31:18 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A4HVFvo033666;
	Tue, 4 Nov 2025 17:31:18 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nddwmf-3;
	Tue, 04 Nov 2025 17:31:18 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSD: Add trace point for SCSI fencing operation.
Date: Tue,  4 Nov 2025 09:27:26 -0800
Message-ID: <20251104173103.2893787-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104173103.2893787-1-dai.ngo@oracle.com>
References: <20251104173103.2893787-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511040146
X-Proofpoint-GUID: xnE4EywR8432GFiqxqoLSqODmcFWYKgk
X-Authority-Analysis: v=2.4 cv=cPftc1eN c=1 sm=1 tr=0 ts=690a3868 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ro0K2ivkSJ57f8edTZkA:9 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0NCBTYWx0ZWRfXyOGyuGrWYQJy
 EookEjzCk4lYxkh3XUogMqjSFT/moNspaxJpjHQsdMEHsz0aaPZGaYXA50kEtNp0PPCYZ7Mxewz
 yYSY4Qi7MWHsEGFw2LhkykaSEYck7Dj6JbLjmU/GxuL0OCYxtgWFNqwXTUdeZV5c94M1BdwrZ8D
 BzG1rD7qO9TI7/chW4+BopORZ84QRXVTq/wQrr1rQHIQft5YaqbLn4aOq+n6IoxW86hTLa9X7R2
 peydytG2QTTlqARJZy/9PZoCQvkPgWCSbIzk0TMnI6zKUmjZSXPcx0OZ4CUnz/yUZKRTaaM1MxU
 ndBapV9ekjDWBU+qf7+o6vq0avKVRul1fw2ZwAwmddY7r0Fmzsdppttuzw/007i3Ws2ftRo4MUK
 Fth0cf5vvL2jL9ye78YWO1EBESWhFTAuXhEezAL2YCDTxp7IJ2s=
X-Proofpoint-ORIG-GUID: xnE4EywR8432GFiqxqoLSqODmcFWYKgk

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


