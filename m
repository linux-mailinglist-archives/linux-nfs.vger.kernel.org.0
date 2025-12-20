Return-Path: <linux-nfs+bounces-17248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F21F2CD38BD
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Dec 2025 00:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85600300DA6A
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Dec 2025 23:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE698185955;
	Sat, 20 Dec 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ze3hCpPc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3393A1E66
	for <linux-nfs@vger.kernel.org>; Sat, 20 Dec 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766272730; cv=none; b=CEW5eYIiCnRi1ornfWsmuFgdLXLpiKq/UvglVM7NGZSeGePVutnjuUkKAIkEiphUwt1XcEaz8S0BrcVhsfum9EHainvJEAmE39EDv4aH0NajahpQW61DQX2uvjzZFQFhJazyaaakdOsbAZiYhXMoGhzsk4biksV6HQoU9emPjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766272730; c=relaxed/simple;
	bh=MDK5ajUo6rj40EU20rWDRpwVv0DNo7LP2U8+pJRNXgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDupcH1DrfjrDfFj9drL0Mbqfw0HF7d6AOjCoeYPCzN0YGgaXpoD81YPgVolN2V2p9hUqyAF0/EnrfhQ9gwVZjf+7/b98i0EjUbJsB7uNnA66T6ldXJrUu+zcZKPuNUyLv6xj4DN9gQkDCHl9ObgRsXfjtnVPPcoj5U7PoJ0t2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ze3hCpPc; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BKN0rCD2852605;
	Sat, 20 Dec 2025 23:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=BGTCXEaIl3sQQ93062/s5mPH6V2lC
	Q6cWs3WZtpG9uc=; b=Ze3hCpPcUjHUttpj5W+SpcsiAWhoQyltzf1sMbbsUlQwk
	XQDPHqG4jEP7km5D+jmcD6e3v2U1fS0VeVYNqMsH5VoBfvYxe3B8khWuRw27+vvn
	rNzEPZ8nzR15b8TNs6GnTcSjskHG/wROMah/I9Ah8xqOKlxcfAdJ6ODz8/R8aeUM
	9cDiVmAOUvVBKZLFPXbov2NUA2txAvgxI8T0RwFE57AN2fSltyElFw+YuBpPWYmM
	E3vEDnlm25gE5IarUFKfSVDE+gooQ6Z2hykUbKuAE9Sx2e0qSuR7Afyi9DH6/9BX
	p/KytYV5mk8f5jtTcuPp7Kj35P2yzUyHNhIBcXpvw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b63ht81ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Dec 2025 23:18:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BKL5aXU039988;
	Sat, 20 Dec 2025 23:18:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j864vs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Dec 2025 23:18:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BKNIJBg031407;
	Sat, 20 Dec 2025 23:18:19 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b5j864vru-1;
	Sat, 20 Dec 2025 23:18:19 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
Date: Sat, 20 Dec 2025 15:17:48 -0800
Message-ID: <20251220231816.31848-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-20_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512200209
X-Proofpoint-ORIG-GUID: z0D5nyWBrvJB9nch8eT1s_X-XqVkb8EH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDIwOSBTYWx0ZWRfX3mcQ5866pQV6
 hvvSaXHQJW+38JIuEB+P7ipsVTJUJTCHqgXckC55IqRyhXltxZbUDfIalxqvu8jcmu6Xrlrdtk1
 fJduuzXEGsAhmAhwlRxDXxrLgpuasw70/f+FTi970tWNh8MPqnQIWQ9hk8DB0h2B8aFdkJVJvxX
 F2Bz/OKkL2smBAB2ncOjNRYH1z6hj6fcgFedQ1aOnTIEmJSBF437MRgrksnRrzzkUOqQPAYyjZL
 11NrOQTRVy9n9G8repeGpUjOHyYgKPzWxoJQoJrvhY40DzhcqhXhwl73pFEG05Q3agX6nLqHNJY
 vFPo55hy2cfwjLt9HpwR+jY+ZTQeg4vTMa1ur2bPMcRT41DTuk1UyNAC61Z51N7MwIVle+qHvMn
 Hq6cfTWr3uHZd6O6A3yteTLWxRYjKEA5fDolHTAW0CMCMBp0lZ0y3MxbQaOHg6e8cDd+r1r3kYw
 IGAkO54lsOF5KLffx/Q==
X-Proofpoint-GUID: z0D5nyWBrvJB9nch8eT1s_X-XqVkb8EH
X-Authority-Analysis: v=2.4 cv=B5S0EetM c=1 sm=1 tr=0 ts=69472ebd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JBAJ10bR8BJGrH3-HCAA:9

Update the NFS server to handle SCSI persistent registration fencing on
a per-client and per-device basis by utilizing an xarray associated with
the nfs4_client structure.

Each xarray entry is indexed by the dev_t of a block device registered
by the client. The entry maintains a flag indicating whether this device
has already been fenced for the corresponding client.

When the server issues a persistent registration key to a client, it
creates a new xarray entry at the dev_t index with the fenced flag
initialized to 0.

Before performing a fence via nfsd4_scsi_fence_client, the server
checks the corresponding entry using the device's dev_t. If the fenced
flag is already set, the fence operation is skipped; otherwise, the
flag is set to 1 and fencing proceeds.

All entries in the xarray, as well as the xarray itself, are freed
when the nfs4_client is released in __destroy_client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 27 ++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c   |  7 +++++++
 fs/nfsd/state.h       |  3 +++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index afa16d7a8013..f619de53eec6 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -357,6 +357,9 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 		goto out_free_dev;
 	}
 
+	/* create a record for this client with the fenced flag set to 0 */
+	xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
+				xa_mk_value(0), GFP_KERNEL);
 	return 0;
 
 out_free_dev:
@@ -400,10 +403,31 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 	int status;
-
+	void *val;
+
+	spin_lock(&clp->cl_fence_lock);
+	val = xa_load(&clp->cl_fenced_devs, bdev->bd_dev);
+	if (xa_is_value(val) && xa_to_value(val)) {
+		/* device already fenced */
+		spin_unlock(&clp->cl_fence_lock);
+		return;
+	}
+	/*
+	 * Set the fenced flag for this device.
+	 *
+	 * A record for this device should already exist, so no memory
+	 * allocation is required. The GFP_ATOMIC flag is specified for
+	 * safety, as the spinlock cl_fence_lock is held.
+	 */
+	xa_store(&clp->cl_fenced_devs, (unsigned long)bdev->bd_dev,
+				xa_mk_value(1), GFP_ATOMIC);
+	spin_unlock(&clp->cl_fence_lock);
 	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	if (status)
+		xa_store(&clp->cl_fenced_devs, (unsigned long)bdev->bd_dev,
+				xa_mk_value(0), GFP_KERNEL);
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
@@ -426,4 +450,5 @@ const struct nfsd4_layout_ops scsi_layout_ops = {
 	.proc_layoutcommit	= nfsd4_scsi_proc_layoutcommit,
 	.fence_client		= nfsd4_scsi_fence_client,
 };
+
 #endif /* CONFIG_NFSD_SCSILAYOUT */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 808c24fb5c9a..44e6222ad9e5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2381,6 +2381,10 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 	INIT_LIST_HEAD(&clp->cl_revoked);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&clp->cl_lo_states);
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	spin_lock_init(&clp->cl_fence_lock);
+	xa_init(&clp->cl_fenced_devs);
+#endif
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
@@ -2537,6 +2541,9 @@ __destroy_client(struct nfs4_client *clp)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
 	nfsd4_dec_courtesy_client_count(nn, clp);
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	xa_destroy(&clp->cl_fenced_devs);
+#endif
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index b052c1effdc5..db6980f112ce 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -527,6 +527,9 @@ struct nfs4_client {
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
+
+	spinlock_t		cl_fence_lock;
+	struct xarray		cl_fenced_devs;
 };
 
 /* struct nfs4_client_reset
-- 
2.47.3


