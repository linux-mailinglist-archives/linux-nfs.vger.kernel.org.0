Return-Path: <linux-nfs+bounces-16998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA71CAE2F5
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 22:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E861300C20D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 21:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150C62D7D2F;
	Mon,  8 Dec 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a01Ezyeo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352D2D3EC7
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765227930; cv=none; b=jY8Qemn1IQPKZIESmj4nmLnccEpoyvGpVlBMdcCt0uKDaUjjXl/HK8JBSgVAbwriZBTkQLeVIlGHB92fRpvwu38XHliAcrRU/xy+I8vHISiNEakakest5XOV9LM5knxDElvEqF1fi9Vje0fiwMyhkdWzXTPWB24BTY/XsH3pdk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765227930; c=relaxed/simple;
	bh=QQQGC5CKCWAhpef3VXBA1RSQKUq5KrP0Z0NBvfHQSCg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eYWk6nmx2zHZKLP94PD9lk7p+OnSap8PtQJBzO2udCYsFyb7p1FgK4gLJNUte6zsechspHO1p+P3ab1RlCWjwleH3Te4rvpzGrZzhztU182o1xXOrj/IYvfijJP66bepOerWt5U6zjKf36VVACiZs040CjmHwUEYuuLk6D3xxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a01Ezyeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E365C4CEF1
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 21:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765227929;
	bh=QQQGC5CKCWAhpef3VXBA1RSQKUq5KrP0Z0NBvfHQSCg=;
	h=From:To:Subject:Date:From;
	b=a01EzyeorI5yvSbMudcPHiu42HkpvgjCUilqXmVboqaDU4/SnVwRJSLEXuN8NyPxZ
	 gZGRVPqI9VCjGYWktsJDFgvhL1//6gKJSDBFHeT0iFIz+R9fILovPYitRMAji7smBs
	 6AX0nxgV0IRPEFkTS937tKQjqnj/7vN6k4zFTZuSHHO197IkgVqggqGrLbB1f56hSe
	 FKdEDyN9ksdH85X2fk+VbGnm3ykWnVfJPcH8683Xco1chibR9PzqseeEI/Pv1lagjz
	 s6Ww3VKOcLlbUwKN82MdzPWv6svvsknErzuCXQaFxV3kr9/ikPVZOfvpDyhGnMUTUs
	 Ajc6mv/bvLa7Q==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH] pNFS: Fix a deadlock when returning a delegation during open()
Date: Mon,  8 Dec 2025 16:05:28 -0500
Message-ID: <24ff118a0bc9c9a845df3987e532365e9d6ecf2a.1765224921.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ben Coddington reports seeing a hang in the following stack trace:
  0 [ffffd0b50e1774e0] __schedule at ffffffff9ca05415
  1 [ffffd0b50e177548] schedule at ffffffff9ca05717
  2 [ffffd0b50e177558] bit_wait at ffffffff9ca061e1
  3 [ffffd0b50e177568] __wait_on_bit at ffffffff9ca05cfb
  4 [ffffd0b50e1775c8] out_of_line_wait_on_bit at ffffffff9ca05ea5
  5 [ffffd0b50e177618] pnfs_roc at ffffffffc154207b [nfsv4]
  6 [ffffd0b50e1776b8] _nfs4_proc_delegreturn at ffffffffc1506586 [nfsv4]
  7 [ffffd0b50e177788] nfs4_proc_delegreturn at ffffffffc1507480 [nfsv4]
  8 [ffffd0b50e1777f8] nfs_do_return_delegation at ffffffffc1523e41 [nfsv4]
  9 [ffffd0b50e177838] nfs_inode_set_delegation at ffffffffc1524a75 [nfsv4]
 10 [ffffd0b50e177888] nfs4_process_delegation at ffffffffc14f41dd [nfsv4]
 11 [ffffd0b50e1778a0] _nfs4_opendata_to_nfs4_state at ffffffffc1503edf [nfsv4]
 12 [ffffd0b50e1778c0] _nfs4_open_and_get_state at ffffffffc1504e56 [nfsv4]
 13 [ffffd0b50e177978] _nfs4_do_open at ffffffffc15051b8 [nfsv4]
 14 [ffffd0b50e1779f8] nfs4_do_open at ffffffffc150559c [nfsv4]
 15 [ffffd0b50e177a80] nfs4_atomic_open at ffffffffc15057fb [nfsv4]
 16 [ffffd0b50e177ad0] nfs4_file_open at ffffffffc15219be [nfsv4]
 17 [ffffd0b50e177b78] do_dentry_open at ffffffff9c09e6ea
 18 [ffffd0b50e177ba8] vfs_open at ffffffff9c0a082e
 19 [ffffd0b50e177bd0] dentry_open at ffffffff9c0a0935

The issue is that the delegreturn is being asked to wait for a layout
return that cannot complete because a state recovery was initiated. The
state recovery cannot complete until the open() finishes processing the
delegations it was given.

The solution is to propagate the existing flags that indicate a
non-blocking call to the function pnfs_roc(), so that it knows not to
wait in this situation.

Reported-by: Benjamin Coddington <bcodding@hammerspace.com>
Fixes: 29ade5db1293 ("pNFS: Wait on outstanding layoutreturns to complete in pnfs_roc()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c |  6 ++---
 fs/nfs/pnfs.c     | 58 +++++++++++++++++++++++++++++++++--------------
 fs/nfs/pnfs.h     | 17 ++++++--------
 3 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ec1ce593dea2..51da62ba6559 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3894,8 +3894,8 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
 	calldata->res.seqid = calldata->arg.seqid;
 	calldata->res.server = server;
 	calldata->res.lr_ret = -NFS4ERR_NOMATCHING_LAYOUT;
-	calldata->lr.roc = pnfs_roc(state->inode,
-			&calldata->lr.arg, &calldata->lr.res, msg.rpc_cred);
+	calldata->lr.roc = pnfs_roc(state->inode, &calldata->lr.arg,
+				    &calldata->lr.res, msg.rpc_cred, wait);
 	if (calldata->lr.roc) {
 		calldata->arg.lr_args = &calldata->lr.arg;
 		calldata->res.lr_res = &calldata->lr.res;
@@ -7005,7 +7005,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	data->inode = nfs_igrab_and_active(inode);
 	if (data->inode || issync) {
 		data->lr.roc = pnfs_roc(inode, &data->lr.arg, &data->lr.res,
-					cred);
+					cred, issync);
 		if (data->lr.roc) {
 			data->args.lr_args = &data->lr.arg;
 			data->res.lr_res = &data->lr.res;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 7ce2e840217c..33bc6db0dc92 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1533,10 +1533,9 @@ static int pnfs_layout_return_on_reboot(struct pnfs_layout_hdr *lo)
 				      PNFS_FL_LAYOUTRETURN_PRIVILEGED);
 }
 
-bool pnfs_roc(struct inode *ino,
-		struct nfs4_layoutreturn_args *args,
-		struct nfs4_layoutreturn_res *res,
-		const struct cred *cred)
+bool pnfs_roc(struct inode *ino, struct nfs4_layoutreturn_args *args,
+	      struct nfs4_layoutreturn_res *res, const struct cred *cred,
+	      bool sync)
 {
 	struct nfs_inode *nfsi = NFS_I(ino);
 	struct nfs_open_context *ctx;
@@ -1547,7 +1546,7 @@ bool pnfs_roc(struct inode *ino,
 	nfs4_stateid stateid;
 	enum pnfs_iomode iomode = 0;
 	bool layoutreturn = false, roc = false;
-	bool skip_read = false;
+	bool skip_read;
 
 	if (!nfs_have_layout(ino))
 		return false;
@@ -1560,20 +1559,14 @@ bool pnfs_roc(struct inode *ino,
 		lo = NULL;
 		goto out_noroc;
 	}
-	pnfs_get_layout_hdr(lo);
-	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
-		spin_unlock(&ino->i_lock);
-		rcu_read_unlock();
-		wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
-				TASK_UNINTERRUPTIBLE);
-		pnfs_put_layout_hdr(lo);
-		goto retry;
-	}
 
 	/* no roc if we hold a delegation */
+	skip_read = false;
 	if (nfs4_check_delegation(ino, FMODE_READ)) {
-		if (nfs4_check_delegation(ino, FMODE_WRITE))
+		if (nfs4_check_delegation(ino, FMODE_WRITE)) {
+			lo = NULL;
 			goto out_noroc;
+		}
 		skip_read = true;
 	}
 
@@ -1582,12 +1575,43 @@ bool pnfs_roc(struct inode *ino,
 		if (state == NULL)
 			continue;
 		/* Don't return layout if there is open file state */
-		if (state->state & FMODE_WRITE)
+		if (state->state & FMODE_WRITE) {
+			lo = NULL;
 			goto out_noroc;
+		}
 		if (state->state & FMODE_READ)
 			skip_read = true;
 	}
 
+	if (skip_read) {
+		bool writes = false;
+
+		list_for_each_entry(lseg, &lo->plh_segs, pls_list) {
+			if (lseg->pls_range.iomode != IOMODE_READ) {
+				writes = true;
+				break;
+			}
+		}
+		if (!writes) {
+			lo = NULL;
+			goto out_noroc;
+		}
+	}
+
+	pnfs_get_layout_hdr(lo);
+	if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
+		if (!sync) {
+			pnfs_set_plh_return_info(
+				lo, skip_read ? IOMODE_RW : IOMODE_ANY, 0);
+			goto out_noroc;
+		}
+		spin_unlock(&ino->i_lock);
+		rcu_read_unlock();
+		wait_on_bit(&lo->plh_flags, NFS_LAYOUT_RETURN,
+			    TASK_UNINTERRUPTIBLE);
+		pnfs_put_layout_hdr(lo);
+		goto retry;
+	}
 
 	list_for_each_entry_safe(lseg, next, &lo->plh_segs, pls_list) {
 		if (skip_read && lseg->pls_range.iomode == IOMODE_READ)
@@ -1627,7 +1651,7 @@ bool pnfs_roc(struct inode *ino,
 out_noroc:
 	spin_unlock(&ino->i_lock);
 	rcu_read_unlock();
-	pnfs_layoutcommit_inode(ino, true);
+	pnfs_layoutcommit_inode(ino, sync);
 	if (roc) {
 		struct pnfs_layoutdriver_type *ld = NFS_SERVER(ino)->pnfs_curr_ld;
 		if (ld->prepare_layoutreturn)
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 91ff877185c8..3db8f13d8fe4 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -303,10 +303,9 @@ int pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 				u32 seq);
 int pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 		struct list_head *lseg_list);
-bool pnfs_roc(struct inode *ino,
-		struct nfs4_layoutreturn_args *args,
-		struct nfs4_layoutreturn_res *res,
-		const struct cred *cred);
+bool pnfs_roc(struct inode *ino, struct nfs4_layoutreturn_args *args,
+	      struct nfs4_layoutreturn_res *res, const struct cred *cred,
+	      bool sync);
 int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
 		  struct nfs4_layoutreturn_res **respp, int *ret);
 void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
@@ -773,12 +772,10 @@ pnfs_layoutcommit_outstanding(struct inode *inode)
 	return false;
 }
 
-
-static inline bool
-pnfs_roc(struct inode *ino,
-		struct nfs4_layoutreturn_args *args,
-		struct nfs4_layoutreturn_res *res,
-		const struct cred *cred)
+static inline bool pnfs_roc(struct inode *ino,
+			    struct nfs4_layoutreturn_args *args,
+			    struct nfs4_layoutreturn_res *res,
+			    const struct cred *cred, bool sync)
 {
 	return false;
 }
-- 
2.52.0


