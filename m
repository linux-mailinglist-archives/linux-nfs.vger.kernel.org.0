Return-Path: <linux-nfs+bounces-18104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD3D3AF57
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 16:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0FD303B7E7
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BD38B993;
	Mon, 19 Jan 2026 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOt6SHbP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8638B9A9
	for <linux-nfs@vger.kernel.org>; Mon, 19 Jan 2026 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837290; cv=none; b=tVo2UNcbFecWZ9Mw/s8c6iDpPrt+xEDmfApTogpFFZ7pvWgo3r101QAQszznAm/eExOPMx5A1+WdO1mV0tfpS+Hnl/x/vSRTxe2enBSzHvzti7EUXAZWeGetpcTtN60xg3aeBPyinLBm0c1KC5V0IO2S+saRpe99iQFRzRmBwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837290; c=relaxed/simple;
	bh=Xai/Yg5YonbEzuIxZI3AsY6rXlUkAZZOM6FT8t8jEOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cma6DGw3SeejFK5tsSOYH0RU9SAIZ84/odPSZP3yP3AVjb4Km+/nZv2UYC/U6CgLaPoQT0GMcSM6HexvJlqqmYvuNqhHnTSn+FfYiLe2c3ZulCYI5zdP4sqwraU1Ru4lUj6PslRlWYpLOpuRtyyTF638vK3aBZ6P4dWQYWTtNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOt6SHbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D4BC116C6;
	Mon, 19 Jan 2026 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768837289;
	bh=Xai/Yg5YonbEzuIxZI3AsY6rXlUkAZZOM6FT8t8jEOE=;
	h=From:To:Cc:Subject:Date:From;
	b=OOt6SHbPGycY/X+o0kTuM1pH7efnapAthFGmxXFhJ9E1CJm+7/MPbl1QAFTmxzW73
	 qZuK6ZjXeCNqWYX9xryLaDz+eat94z0kdQb476pxg8GdwRO2BQ/Uo/0jJ0qRPLm5Mn
	 /b0ctxLQBfF3fjaBY6UWH33UvLJpU/F+2MlWN6oq+sCm/EUbWIbl20Ix09EEUu+dVG
	 NyOt5NxitJ2xaWcdDrgpaqmkS7NbFqA2YaAVAH/0jK4lVdj8C2RZWW8/tIOI7SCaHl
	 6OPZJ7Ndyl4SY8U3E5xH3EGaHlHjz1gvTiHbkune+NG7iW4x7OTp7vlhdbjnaVIVfb
	 ruuIfqp4zGjBQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH v7] NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
Date: Mon, 19 Jan 2026 10:41:26 -0500
Message-ID: <20260119154126.121360-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dai Ngo <dai.ngo@oracle.com>

When a client holding pNFS SCSI layouts becomes unresponsive, the
server revokes access by preempting the client's SCSI persistent
reservation key. A layout recall is issued for each layout the
client holds; if the client fails to respond, each recall triggers
a fence operation. The first preempt for a given device succeeds
and removes the client's key registration. Subsequent preempts for
the same device fail because the key is no longer registered.

Update the NFS server to handle SCSI persistent registration
fencing on a per-client and per-device basis by utilizing an
xarray associated with the nfs4_client structure.

Each xarray entry is indexed by the dev_t of a block device
registered by the client. The entry maintains a flag indicating
whether this device has already been fenced for the corresponding
client.

When the server issues a persistent registration key to a client,
it creates a new xarray entry at the dev_t index with the fenced
flag initialized to 0.

Before performing a fence via nfsd4_scsi_fence_client, the server
checks the corresponding entry using the device's dev_t. If the
fenced flag is already set, the fence operation is skipped;
otherwise, the flag is set to 1 and fencing proceeds.

The xarray is destroyed when the nfs4_client is released in
__destroy_client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayout.c | 72 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c   |  6 ++++
 fs/nfsd/state.h       |  3 ++
 3 files changed, 81 insertions(+)

V2:
   . Replace xa_store with xas_set_mark and xas_get_mark to avoid
     memory allocation in nfsd4_scsi_fence_client.
   . Remove cl_fence_lock, use xa_lock instead.
V3:
   . handle xa_store error.
   . add xa_lock and xa_unlock when calling xas_clear_mark
V4:
   . rename cl_fenced_devs to cl_dev_fences
   . add comment in nfsd4_block_get_device_info_scsi

V5:
   . Take a stab at a proper problem statement
   . Handle failures of pr_register / pr_reserve correctly
   . Remove usage of possibly stale xa_state data
   . Avoid looping when pr_preempt fails
   . Fix usage of #ifdef CONFIG_SCSILAYOUT

V6:
   . Use xa_insert() instead of xa_store()
   . Add check for PR_STS_RETRY_PATH_FAILURE

V7:
   . GETDEVICEINFO must clear existing fences
   . Refactor for separation of concerns

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index afa16d7a8013..7ba9e2dd0875 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -273,6 +273,51 @@ const struct nfsd4_layout_ops bl_layout_ops = {
 #endif /* CONFIG_NFSD_BLOCKLAYOUT */
 
 #ifdef CONFIG_NFSD_SCSILAYOUT
+
+#define NFSD_MDS_PR_FENCED	XA_MARK_0
+
+/*
+ * Clear the fence flag if the device already has an entry. This occurs
+ * when a client re-registers after a previous fence, allowing new
+ * layouts for this device.
+ *
+ * Insert only on first registration. This bounds cl_dev_fences to the
+ * count of devices this client has accessed, preventing unbounded growth.
+ */
+static inline int nfsd4_scsi_fence_insert(struct nfs4_client *clp,
+					  dev_t device)
+{
+	struct xarray *xa = &clp->cl_dev_fences;
+	int ret;
+
+	xa_lock(xa);
+	ret = __xa_insert(xa, device, XA_ZERO_ENTRY, GFP_KERNEL);
+	if (ret == -EBUSY) {
+		__xa_clear_mark(xa, device, NFSD_MDS_PR_FENCED);
+		ret = 0;
+	}
+	xa_unlock(xa);
+	return ret;
+}
+
+static inline bool nfsd4_scsi_fence_set(struct nfs4_client *clp, dev_t device)
+{
+	struct xarray *xa = &clp->cl_dev_fences;
+	bool skip;
+
+	xa_lock(xa);
+	skip = xa_get_mark(xa, device, NFSD_MDS_PR_FENCED);
+	if (!skip)
+		__xa_set_mark(xa, device, NFSD_MDS_PR_FENCED);
+	xa_unlock(xa);
+	return skip;
+}
+
+static inline void nfsd4_scsi_fence_clear(struct nfs4_client *clp, dev_t device)
+{
+	xa_clear_mark(&clp->cl_dev_fences, device, NFSD_MDS_PR_FENCED);
+}
+
 #define NFSD_MDS_PR_KEY		0x0100000000000000ULL
 
 /*
@@ -342,6 +387,10 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 		goto out_free_dev;
 	}
 
+	ret = nfsd4_scsi_fence_insert(clp, sb->s_bdev->bd_dev);
+	if (ret < 0)
+		goto out_free_dev;
+
 	ret = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
 	if (ret) {
 		pr_err("pNFS: failed to register key for device %s.\n",
@@ -401,9 +450,32 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 	int status;
 
+	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
+		return;
+
 	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp),
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
+	/*
+	 * Reset to allow retry only when the command could not have
+	 * reached the device. Negative status means a local error
+	 * (e.g., -ENOMEM) prevented the command from being sent.
+	 * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
+	 * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
+	 * before device delivery.
+	 *
+	 * For all other errors, the command may have reached the device
+	 * and the preempt may have succeeded. Avoid resetting, since
+	 * retrying a successful preempt returns PR_STS_IOERR or
+	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
+	 * retry loop.
+	 */
+	if (status < 0 ||
+	    status == PR_STS_PATH_FAILED ||
+	    status == PR_STS_PATH_FAST_FAILED ||
+	    status == PR_STS_RETRY_PATH_FAILURE)
+		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
+
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3028cb453888..583c13b5aaf3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2382,6 +2382,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 	INIT_LIST_HEAD(&clp->cl_revoked);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&clp->cl_lo_states);
+#endif
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	xa_init(&clp->cl_dev_fences);
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
@@ -2544,6 +2547,9 @@ __destroy_client(struct nfs4_client *clp)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
 	nfsd4_dec_courtesy_client_count(nn, clp);
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	xa_destroy(&clp->cl_dev_fences);
+#endif
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6fcbf1e427d4..713f55ef6554 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -527,6 +527,9 @@ struct nfs4_client {
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
+#ifdef CONFIG_NFSD_SCSILAYOUT
+	struct xarray		cl_dev_fences;
+#endif
 };
 
 /* struct nfs4_client_reset
-- 
2.52.0


