Return-Path: <linux-nfs+bounces-11657-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53648AB2879
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 15:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF73171181
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B91A315D;
	Sun, 11 May 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIw89xO0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37073A1B6
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746970121; cv=none; b=QWyqT5bqvZz2SCvo1zyv7xstwxfM1tHFvOL56zz+Ez9lIZqqm9n2KT+/WH0kInxSHTjk3rTn+jnVdFJNUS2MwarnhshBZjNhLR2FbgWJaOJHH1JSKi+rbfdxqqgmuIHr9v62NyIpi7xRQQDZ0N38efklJsT6wtB+imLh0U5RToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746970121; c=relaxed/simple;
	bh=kMp3Jd6qHGv/yRnlfdM9KxQA47R81rJ1wb9H2o9YzG8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DDHP3VI6uDhEZP/S/vraAqETsBWC0Am6OsWUAWiiXPKjwfH+g8s7VdZkJ3gIfBiKh72eU/Zp39TzMwf2AHEmp0wKa3ZGGywySGNSdZrSVclYApDSX2RfxmFjk+wIwL4YuwnTbQp3+UFKOahx2o+t7r6qDtlvlM6AzZSXeAfQ5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIw89xO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBA3C4CEE4
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746970121;
	bh=kMp3Jd6qHGv/yRnlfdM9KxQA47R81rJ1wb9H2o9YzG8=;
	h=From:To:Subject:Date:From;
	b=iIw89xO0oCOdapX93uRoU3w410sWKTzl3bujQREmfppRzd+h98gVxRlTPgTG1Snbn
	 berc08YkeLJEDrjJk9oQ15frGP2vh/OGl5ti2HDKrviuX7vHROykpxapZ2aWrq9K2s
	 Bqh4KjDTQpWTPnW12oUn5fSfxRcLR3vcLWi2SyDErWtJP43DNzUgC2bQG9yClukMlJ
	 O6cV1c+TOwpRMW1r9eHfhL/AdIzp92E+gnP264UAe//o6wGftXNTMf9E11nHN8KWuI
	 ANrBwES+f5Y8fQ75ljaMTUo0cGW4iTp3JE/Z+FQ6bresMWxaEWZKV1zirjRflknZq8
	 M6VbNHKySznjw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS/pnfs: Fix the error path in pnfs_layoutreturn_retry_later_locked()
Date: Sun, 11 May 2025 09:28:39 -0400
Message-ID: <7a4abcb32bb29ad463638bf1d2d0600a3d9e357c.1746970073.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If there isn't a valid layout, or the layout stateid has changed, the
cleanup after a layout return should clear out the old data.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index fc7c5fb10198..3adb7d0dbec7 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1254,21 +1254,15 @@ static void pnfs_clear_layoutcommit(struct inode *inode,
 static void
 pnfs_layoutreturn_retry_later_locked(struct pnfs_layout_hdr *lo,
 				     const nfs4_stateid *arg_stateid,
-				     const struct pnfs_layout_range *range)
+				     const struct pnfs_layout_range *range,
+				     struct list_head *freeme)
 {
-	const struct pnfs_layout_segment *lseg;
-	u32 seq = be32_to_cpu(arg_stateid->seqid);
-
 	if (pnfs_layout_is_valid(lo) &&
-	    nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid)) {
-		list_for_each_entry(lseg, &lo->plh_return_segs, pls_list) {
-			if (pnfs_seqid_is_newer(lseg->pls_seq, seq) ||
-			    !pnfs_should_free_range(&lseg->pls_range, range))
-				continue;
-			pnfs_set_plh_return_info(lo, range->iomode, seq);
-			break;
-		}
-	}
+	    nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid))
+		pnfs_reset_return_info(lo);
+	else
+		pnfs_mark_layout_stateid_invalid(lo, freeme);
+	pnfs_clear_layoutreturn_waitbit(lo);
 }
 
 void pnfs_layoutreturn_retry_later(struct pnfs_layout_hdr *lo,
@@ -1276,11 +1270,12 @@ void pnfs_layoutreturn_retry_later(struct pnfs_layout_hdr *lo,
 				   const struct pnfs_layout_range *range)
 {
 	struct inode *inode = lo->plh_inode;
+	LIST_HEAD(freeme);
 
 	spin_lock(&inode->i_lock);
-	pnfs_layoutreturn_retry_later_locked(lo, arg_stateid, range);
-	pnfs_clear_layoutreturn_waitbit(lo);
+	pnfs_layoutreturn_retry_later_locked(lo, arg_stateid, range, &freeme);
 	spin_unlock(&inode->i_lock);
+	pnfs_free_lseg_list(&freeme);
 }
 
 void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
@@ -1716,6 +1711,7 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 	struct inode *inode = args->inode;
 	const nfs4_stateid *res_stateid = NULL;
 	struct nfs4_xdr_opaque_data *ld_private = args->ld_private;
+	LIST_HEAD(freeme);
 
 	switch (ret) {
 	case -NFS4ERR_BADSESSION:
@@ -1724,9 +1720,9 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 	case -NFS4ERR_NOMATCHING_LAYOUT:
 		spin_lock(&inode->i_lock);
 		pnfs_layoutreturn_retry_later_locked(lo, &args->stateid,
-						     &args->range);
-		pnfs_clear_layoutreturn_waitbit(lo);
+						     &args->range, &freeme);
 		spin_unlock(&inode->i_lock);
+		pnfs_free_lseg_list(&freeme);
 		break;
 	case 0:
 		if (res->lrs_present)
-- 
2.49.0


