Return-Path: <linux-nfs+bounces-17258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D4CD6EE3
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 20:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C0983014AF9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD3339710;
	Mon, 22 Dec 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lwSaQa5t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900D307AD5
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430470; cv=none; b=MTZ6rZuGvpnPRAwnaZxTaeITSkwBpfK3ZISfNhYA3lYexfVBUKvBZIWRXxGpdgEloJCMWnz1T46rhkNQSi5USBIv/0HGm4Jca/hkkRFiakCgJsvK/WLWKtQKFTAYEsmc7gUs1OUdAa865JKV15xTUew7WA00LI+dpPOLxBztTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430470; c=relaxed/simple;
	bh=UTe8+J4kVotWSElRYImPQw7EhcPHPZrq++Snmw/Knhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuCITqjH9XE/uB+mwui2HnlHUb9TpVFa2FXn+m2h0WBxeUHALpJDixjlXbAa22myOOOXOfBZhPYf9XO2EbCqXIXIfWBrUIDxXl+ydtHlth4AZKMWn7+BL2pDnUau8q3UTClACqAps0YVblVd+Qf97uGAO2kx1qQm4wy6leIqbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lwSaQa5t; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMHLsA72698671;
	Mon, 22 Dec 2025 19:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=avh03TroD1LldFAcxizjDgFGtC1tA
	xLKFUiPJeTCWqc=; b=lwSaQa5tbbWdYfS8pv/zbnv9I1cf5oqj7lz+X1lMysOlA
	Kf7aUB5Zrn1X8FiKQU/m3zQSYGdDSbN0heZR6T/wxijWzQXE9wFDeABeZA0/8Maa
	0i/YQwSDi2+1sG+rP1q2XjmmmVbuEQQkR52BjSz3yENNjl4g8L0Lx4dD5XHo+llo
	fOZX6ozGHpYftghaUCdLoTaf11m79Jqf0dAbHA6b/iLa+U94/blGVF8rhN5mNlL5
	/lYD1FSxFemEAGSkdM0C4sGadunkm4VsQzAlAB8fPbOlHuzVXnZmCSLt+57GiC00
	TMGcbuMgeupRlvBztUwN5Bp3PQxjS9oS2sDeZZe5A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7aaj05s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 19:07:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMIi4lW016764;
	Mon, 22 Dec 2025 19:07:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8hnsj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 19:07:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BMJ7ck5000507;
	Mon, 22 Dec 2025 19:07:38 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4b5j8hnshf-1;
	Mon, 22 Dec 2025 19:07:38 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
Date: Mon, 22 Dec 2025 11:07:19 -0800
Message-ID: <20251222190735.307006-1-dai.ngo@oracle.com>
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
 definitions=2025-12-22_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512220175
X-Proofpoint-GUID: x19wFhsgg_nu_wuSzWZeB36mMFkWHFLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE3NiBTYWx0ZWRfX64fj4rCqbBw7
 y24raggMRKBVHsM3Eqw39HS01s6eghMhzM5SUKPwFvcPgmH9JUNSJpjgVVQVlEZW40QXGZ0A4rn
 sQS2buePdPJ1gtt/8BhHMZ15tfmlEuBYV7PvvMkYoZMc+RgAuqGbMltNxu0cb49NHRBjbXKpJRY
 ZvQ6384BsVltZe68FUEydnydzFk3ECA3RDrkP1PR0QL7TgLXoV9y9LR1kiuKKSrOcWM+2ogGJR/
 71ApvVGI6/D0xDIM74gHtkpDL2+bnrfppu/HgstS1VTtrGy4AsDubyFbnUOroHxvryJSYzo72Jv
 eBGD4dFDIB8GfEY5GZyX14PaNSodhvTvzE3R1QsD+A3ovj2n9XfiXixvSb903QkiCLK2M2VSbvU
 LO1+dvhIgdIrPSSsdXFNf4lqZBZ6WWhBmNxuM7ZfNKcGpMN6Vl8kuPQaFzUVYBgbs/2pz2owfBD
 ddRbXpTKTn6q0cjcAl/IwilJpO+tegkDp8FrYyqk=
X-Proofpoint-ORIG-GUID: x19wFhsgg_nu_wuSzWZeB36mMFkWHFLy
X-Authority-Analysis: v=2.4 cv=WMByn3sR c=1 sm=1 tr=0 ts=694996fb b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=CpYFjIGk7Er79Tw7svAA:9 cc=ntf awl=host:12109

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

The xarray is destroyed when the nfs4_client is released in
__destroy_client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/blocklayout.c | 26 ++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c   |  6 ++++++
 fs/nfsd/state.h       |  2 ++
 3 files changed, 34 insertions(+)

V2:
   . Replace xa_store with xas_set_mark and xas_get_mark to avoid
     memory allocation in nfsd4_scsi_fence_client.
   . Remove cl_fence_lock, use xa_lock instead.
V3:
   . handle xa_store error.
   . add xa_lock and xa_unlock when calling xas_clear_mark

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index afa16d7a8013..bcacd030d84a 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -318,6 +318,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 	struct pnfs_block_volume *b;
 	const struct pr_ops *ops;
 	int ret;
+	void *entry;
 
 	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
 	if (!dev)
@@ -357,6 +358,13 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 		goto out_free_dev;
 	}
 
+	/* create a record for this client with the fenced flag set to 0 */
+	entry = xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
+				xa_mk_value(0), GFP_KERNEL);
+	if (xa_is_err(entry)) {
+		ret = xa_err(entry);
+		goto out_free_dev;
+	}
 	return 0;
 
 out_free_dev:
@@ -400,10 +408,28 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 	int status;
+	void *entry;
+	XA_STATE(xas, &clp->cl_fenced_devs, bdev->bd_dev);
+
+	xa_lock(&clp->cl_fenced_devs);
+	entry = xas_load(&xas);
+	if (entry && xas_get_mark(&xas, XA_MARK_0)) {
+		/* device already fenced */
+		xa_unlock(&clp->cl_fenced_devs);
+		return;
+	}
+	/* Set the fenced flag for this device. */
+	xas_set_mark(&xas, XA_MARK_0);
+	xa_unlock(&clp->cl_fenced_devs);
 
 	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	if (status) {
+		xa_lock(&clp->cl_fenced_devs);
+		xas_clear_mark(&xas, XA_MARK_0);
+		xa_unlock(&clp->cl_fenced_devs);
+	}
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 808c24fb5c9a..2d4a198fe41d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2381,6 +2381,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 	INIT_LIST_HEAD(&clp->cl_revoked);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&clp->cl_lo_states);
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	xa_init(&clp->cl_fenced_devs);
+#endif
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
@@ -2537,6 +2540,9 @@ __destroy_client(struct nfs4_client *clp)
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
index b052c1effdc5..8dd6f82e57de 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -527,6 +527,8 @@ struct nfs4_client {
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
+
+	struct xarray		cl_fenced_devs;
 };
 
 /* struct nfs4_client_reset
-- 
2.47.3


