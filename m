Return-Path: <linux-nfs+bounces-19162-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFRZCMJRnWkoOgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19162-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 08:22:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0F182F27
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 08:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA7C23003821
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF152364049;
	Tue, 24 Feb 2026 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="vssCnZvc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC63B24E4A8;
	Tue, 24 Feb 2026 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917729; cv=none; b=iREUffL8JKJxTid4lyRCgLnUGonqdJ8dqQx3RrylizwdkUcnr9Hc439/OFsQUIRqgT/dhWlO728Mv+bivtpoQhxZ/ReiJlwHEARuClafStu7yM5YmYyGtYcW92PP/c6Cmm5kDdl8Bc+yBmoyCZl20Tpv3Q0xVuwxPZF0PJxkc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917729; c=relaxed/simple;
	bh=hhuDUjEPGphqCg9CRGJxIhbOh/Xkc56H4lbpmiOM8sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gC8wm5ZJSsCy3OPOtn1Bki4ciH2+jGkpboowz2U55x428UWvamiuFitMvLy8I6o4wXC4zh5rTBc9Sr9Y2LaSJOii90xjdvRQbq/7ifyNilgPOzb+AsHO+Bo3jliQCXnv+yuN5a4gONjbGPsGY7tRIrJay0VQjaLg2xG0VU4bD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=vssCnZvc; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vssCnZvc4BsBodqdf7MnVWmKT17b9tlhNrv/Lr8mCZXe0q4oyE1p4fkN4QgGvdEkF0/YIpHzx07qC
	 nxuMKFUX1cGbeASiKvq/nG3l4zjMg/Gb+Qc/GBw1bBofeTDXBhCbN2HKVScP8ZDjuBxg8HZmXFf44e
	 tnCSMlY0ncWXQheA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-14-12003 (RichMail) with SMTP id 2ee3699d519a731-0073a;
	Tue, 24 Feb 2026 15:22:03 +0800 (CST)
X-RM-TRANSID:2ee3699d519a731-0073a
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bcodding@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	wangzhaolong@huaweicloud.com
Subject: [PATCH 6.6.y] pNFS: Fix a deadlock when returning a delegation during open()
Date: Tue, 24 Feb 2026 15:22:02 +0800
Message-Id: <20260224072202.2940831-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19162-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[139.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[139.com:-];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hammerspace.com:email,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: 4DC0F182F27
X-Rspamd-Action: no action

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 857bf9056291a16785ae3be1d291026b2437fc48 ]

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
[ Minor conflict resolved. ]
Signed-off-by: Li hongliang <1468888505@139.com>
---
 fs/nfs/nfs4proc.c |  6 ++---
 fs/nfs/pnfs.c     | 58 +++++++++++++++++++++++++++++++++--------------
 fs/nfs/pnfs.h     | 17 ++++++--------
 3 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fe6986939bc9..42fa7c915e29 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3792,8 +3792,8 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
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
@@ -6742,7 +6742,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	data->inode = nfs_igrab_and_active(inode);
 	if (data->inode || issync) {
 		data->lr.roc = pnfs_roc(inode, &data->lr.arg, &data->lr.res,
-					cred);
+					cred, issync);
 		if (data->lr.roc) {
 			data->args.lr_args = &data->lr.arg;
 			data->res.lr_res = &data->lr.res;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0737d9a15d86..6dbfae295f76 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1426,10 +1426,9 @@ pnfs_commit_and_return_layout(struct inode *inode)
 	return ret;
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
@@ -1440,7 +1439,7 @@ bool pnfs_roc(struct inode *ino,
 	nfs4_stateid stateid;
 	enum pnfs_iomode iomode = 0;
 	bool layoutreturn = false, roc = false;
-	bool skip_read = false;
+	bool skip_read;
 
 	if (!nfs_have_layout(ino))
 		return false;
@@ -1453,20 +1452,14 @@ bool pnfs_roc(struct inode *ino,
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
 
@@ -1475,12 +1468,43 @@ bool pnfs_roc(struct inode *ino,
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
@@ -1520,7 +1544,7 @@ bool pnfs_roc(struct inode *ino,
 out_noroc:
 	spin_unlock(&ino->i_lock);
 	rcu_read_unlock();
-	pnfs_layoutcommit_inode(ino, true);
+	pnfs_layoutcommit_inode(ino, sync);
 	if (roc) {
 		struct pnfs_layoutdriver_type *ld = NFS_SERVER(ino)->pnfs_curr_ld;
 		if (ld->prepare_layoutreturn)
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 79996d7dad0f..a613466f6f22 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -295,10 +295,9 @@ int pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
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
@@ -769,12 +768,10 @@ pnfs_layoutcommit_outstanding(struct inode *inode)
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
2.34.1



