Return-Path: <linux-nfs+bounces-17616-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF2D0390D
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A34D3308036F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E969B50094C;
	Thu,  8 Jan 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBe/68IQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489B500961
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883464; cv=none; b=KL3rhjjk+ztFEJthnpBAfgu4Xp901QSWp/6zDBDodIW92OL2II4MvwwBXsD5L5Mt9EhRUZJ0I/UR4SaO65dBetltopMy7qKbx6fQ0cZqx/k6p0L5q3Z/ZZTvcExucgxiMzORr/3xxkpoQSWo1UsVSfT7tR3oSIW8694o0MAGJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883464; c=relaxed/simple;
	bh=VJeEFmpZNhv2EX88xBOz4tOU0XosAYVCS5rY2c11gAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awp1a7+exHvrZYH4ynPbfOBk8oQz5Pp4RsEv0MCxMRy3igDob1IVsDr7eU5ZHDVfcNrksrEFDaZ+GTq3hJK1TIod0K6mgwFWwCyB/Yvh7GO+H5DO/TyfEkt5gSP0xz5c3Q4Wl/4KXLEmnQbpKrI8oCBdtF/XUgkJerFKvEzNm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBe/68IQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD466C116C6;
	Thu,  8 Jan 2026 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767883464;
	bh=VJeEFmpZNhv2EX88xBOz4tOU0XosAYVCS5rY2c11gAg=;
	h=From:To:Cc:Subject:Date:From;
	b=hBe/68IQ9LqFPvIXRfAcasjSF/j1VGD7QVpPO6xPD4Ij4BMZ5uZtcIGqS/xgdqDH4
	 bzBjwzx+h7DXef1ggZz+oEEMfwRxPvPvqh4IzkhEuUj/kMXmEqAiwJ0ngzjTan8Oll
	 OfZ4RP4g7S1ppgebqp5dMMpijlyCDFN/R12nEbww3hDBmg5w68VnUQX1D5orHA8Eqf
	 iHWiHdpqwvu9aJRLX7hym5QXwD55J2PVepvcJQXV4r4ZGZz3ObaHOxQABK35XTiJJO
	 pqeqmt7jts3JCEC7cwpj4mkcpmqowTFGNNIVSR6FaWejc8a6P1CiaodyqwEkooyHUs
	 9nvu97IXkGahA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH v6] NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
Date: Thu,  8 Jan 2026 09:44:21 -0500
Message-ID: <20260108144421.3955020-1-cel@kernel.org>
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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayout.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c   |  6 ++++++
 fs/nfsd/state.h       |  3 +++
 3 files changed, 50 insertions(+)

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


diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index afa16d7a8013..60304bca1bb6 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -342,6 +342,17 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 		goto out_free_dev;
 	}
 
+	/*
+	 * Add the device if it does not already exist in the xarray. This
+	 * logic prevents adding more entries to cl_dev_fences than there
+	 * are exported devices on the server. XA_MARK_0 tracks whether the
+	 * device has been fenced.
+	 */
+	ret = xa_insert(&clp->cl_dev_fences, sb->s_bdev->bd_dev,
+			XA_ZERO_ENTRY, GFP_KERNEL);
+	if (ret < 0 && ret != -EBUSY)
+		goto out_free_dev;
+
 	ret = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
 	if (ret) {
 		pr_err("pNFS: failed to register key for device %s.\n",
@@ -399,11 +410,41 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
+	struct xarray *xa = &clp->cl_dev_fences;
 	int status;
+	bool skip;
+
+	xa_lock(xa);
+	skip = xa_get_mark(xa, bdev->bd_dev, XA_MARK_0);
+	if (!skip)
+		__xa_set_mark(xa, bdev->bd_dev, XA_MARK_0);
+	xa_unlock(xa);
+	if (skip)
+		return;
 
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
+		xa_clear_mark(xa, bdev->bd_dev, XA_MARK_0);
+
 	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ea4d6eff0d2f..4fc94f2de7ba 100644
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
@@ -2538,6 +2541,9 @@ __destroy_client(struct nfs4_client *clp)
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
index 508b7e36d846..037f4ccd2e87 100644
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


