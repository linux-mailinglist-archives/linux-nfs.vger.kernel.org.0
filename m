Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2719CDA1
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 01:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390289AbgDBXvt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 19:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390284AbgDBXvs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 19:51:48 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CBA2072E
        for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2020 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585871507;
        bh=bQx2x/qI2oBe78xTPFmoMSAAsU4fRFb5TrCyV+Ii+b8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QcmFnULAE4+RfNTrGbFJSqkn5ITlR3wyu0cEXPePiPGPd2wACcS34PSw1QN9wbGJI
         gS6tl564cJFixrE1Nmn72rkXsZef2DKyyB6+6fDA3bhOVlnJMep4i48wkn/W06IBCk
         ciA/80sG1kYt/BTMPStVG93FeZVDJkWS1V2l2HGo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS/pnfs: Reference the layout cred in pnfs_prepare_layoutreturn()
Date:   Thu,  2 Apr 2020 19:49:17 -0400
Message-Id: <20200402234917.797185-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402234917.797185-2-trondmy@kernel.org>
References: <20200402234917.797185-1-trondmy@kernel.org>
 <20200402234917.797185-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we're sending a layoutreturn, ensure that we reference the
layout cred atomically with the copy of the stateid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c |  1 +
 fs/nfs/pnfs.c     | 52 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e4f8311e506c..99e9f2ee7e7a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9297,6 +9297,7 @@ static void nfs4_layoutreturn_release(void *calldata)
 		lrp->ld_private.ops->free(&lrp->ld_private);
 	pnfs_put_layout_hdr(lrp->args.layout);
 	nfs_iput_and_deactive(lrp->inode);
+	put_cred(lrp->cred);
 	kfree(calldata);
 	dprintk("<-- %s\n", __func__);
 }
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 84029c9b2b1b..f2dc35c22964 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1144,6 +1144,7 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 static bool
 pnfs_prepare_layoutreturn(struct pnfs_layout_hdr *lo,
 		nfs4_stateid *stateid,
+		const struct cred **cred,
 		enum pnfs_iomode *iomode)
 {
 	/* Serialise LAYOUTGET/LAYOUTRETURN */
@@ -1154,18 +1155,17 @@ pnfs_prepare_layoutreturn(struct pnfs_layout_hdr *lo,
 	set_bit(NFS_LAYOUT_RETURN, &lo->plh_flags);
 	pnfs_get_layout_hdr(lo);
 	if (test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags)) {
-		if (stateid != NULL) {
-			nfs4_stateid_copy(stateid, &lo->plh_stateid);
-			if (lo->plh_return_seq != 0)
-				stateid->seqid = cpu_to_be32(lo->plh_return_seq);
-		}
+		nfs4_stateid_copy(stateid, &lo->plh_stateid);
+		*cred = get_cred(lo->plh_lc_cred);
+		if (lo->plh_return_seq != 0)
+			stateid->seqid = cpu_to_be32(lo->plh_return_seq);
 		if (iomode != NULL)
 			*iomode = lo->plh_return_iomode;
 		pnfs_clear_layoutreturn_info(lo);
 		return true;
 	}
-	if (stateid != NULL)
-		nfs4_stateid_copy(stateid, &lo->plh_stateid);
+	nfs4_stateid_copy(stateid, &lo->plh_stateid);
+	*cred = get_cred(lo->plh_lc_cred);
 	if (iomode != NULL)
 		*iomode = IOMODE_ANY;
 	return true;
@@ -1189,20 +1189,26 @@ pnfs_init_layoutreturn_args(struct nfs4_layoutreturn_args *args,
 }
 
 static int
-pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo, const nfs4_stateid *stateid,
-		       enum pnfs_iomode iomode, bool sync)
+pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
+		       const nfs4_stateid *stateid,
+		       const struct cred **pcred,
+		       enum pnfs_iomode iomode,
+		       bool sync)
 {
 	struct inode *ino = lo->plh_inode;
 	struct pnfs_layoutdriver_type *ld = NFS_SERVER(ino)->pnfs_curr_ld;
 	struct nfs4_layoutreturn *lrp;
+	const struct cred *cred = *pcred;
 	int status = 0;
 
+	*pcred = NULL;
 	lrp = kzalloc(sizeof(*lrp), GFP_NOFS);
 	if (unlikely(lrp == NULL)) {
 		status = -ENOMEM;
 		spin_lock(&ino->i_lock);
 		pnfs_clear_layoutreturn_waitbit(lo);
 		spin_unlock(&ino->i_lock);
+		put_cred(cred);
 		pnfs_put_layout_hdr(lo);
 		goto out;
 	}
@@ -1210,7 +1216,7 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo, const nfs4_stateid *stateid,
 	pnfs_init_layoutreturn_args(&lrp->args, lo, stateid, iomode);
 	lrp->args.ld_private = &lrp->ld_private;
 	lrp->clp = NFS_SERVER(ino)->nfs_client;
-	lrp->cred = lo->plh_lc_cred;
+	lrp->cred = cred;
 	if (ld->prepare_layoutreturn)
 		ld->prepare_layoutreturn(&lrp->args);
 
@@ -1255,15 +1261,16 @@ static void pnfs_layoutreturn_before_put_layout_hdr(struct pnfs_layout_hdr *lo)
 		return;
 	spin_lock(&inode->i_lock);
 	if (pnfs_layout_need_return(lo)) {
+		const struct cred *cred;
 		nfs4_stateid stateid;
 		enum pnfs_iomode iomode;
 		bool send;
 
-		send = pnfs_prepare_layoutreturn(lo, &stateid, &iomode);
+		send = pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode);
 		spin_unlock(&inode->i_lock);
 		if (send) {
 			/* Send an async layoutreturn so we dont deadlock */
-			pnfs_send_layoutreturn(lo, &stateid, iomode, false);
+			pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
 		}
 	} else
 		spin_unlock(&inode->i_lock);
@@ -1283,6 +1290,7 @@ _pnfs_return_layout(struct inode *ino)
 	struct pnfs_layout_hdr *lo = NULL;
 	struct nfs_inode *nfsi = NFS_I(ino);
 	LIST_HEAD(tmp_list);
+	const struct cred *cred;
 	nfs4_stateid stateid;
 	int status = 0;
 	bool send, valid_layout;
@@ -1327,10 +1335,10 @@ _pnfs_return_layout(struct inode *ino)
 		goto out_put_layout_hdr;
 	}
 
-	send = pnfs_prepare_layoutreturn(lo, &stateid, NULL);
+	send = pnfs_prepare_layoutreturn(lo, &stateid, &cred, NULL);
 	spin_unlock(&ino->i_lock);
 	if (send)
-		status = pnfs_send_layoutreturn(lo, &stateid, IOMODE_ANY, true);
+		status = pnfs_send_layoutreturn(lo, &stateid, &cred, IOMODE_ANY, true);
 out_put_layout_hdr:
 	pnfs_free_lseg_list(&tmp_list);
 	pnfs_put_layout_hdr(lo);
@@ -1376,6 +1384,7 @@ bool pnfs_roc(struct inode *ino,
 	struct nfs4_state *state;
 	struct pnfs_layout_hdr *lo;
 	struct pnfs_layout_segment *lseg, *next;
+	const struct cred *lc_cred;
 	nfs4_stateid stateid;
 	enum pnfs_iomode iomode = 0;
 	bool layoutreturn = false, roc = false;
@@ -1445,16 +1454,20 @@ bool pnfs_roc(struct inode *ino,
 	 * 2. we don't send layoutreturn
 	 */
 	/* lo ref dropped in pnfs_roc_release() */
-	layoutreturn = pnfs_prepare_layoutreturn(lo, &stateid, &iomode);
+	layoutreturn = pnfs_prepare_layoutreturn(lo, &stateid, &lc_cred, &iomode);
 	/* If the creds don't match, we can't compound the layoutreturn */
-	if (!layoutreturn || cred_fscmp(cred, lo->plh_lc_cred) != 0)
+	if (!layoutreturn)
 		goto out_noroc;
+	if (cred_fscmp(cred, lc_cred) != 0)
+		goto out_noroc_put_cred;
 
 	roc = layoutreturn;
 	pnfs_init_layoutreturn_args(args, lo, &stateid, iomode);
 	res->lrs_present = 0;
 	layoutreturn = false;
 
+out_noroc_put_cred:
+	put_cred(lc_cred);
 out_noroc:
 	spin_unlock(&ino->i_lock);
 	rcu_read_unlock();
@@ -1467,7 +1480,7 @@ bool pnfs_roc(struct inode *ino,
 		return true;
 	}
 	if (layoutreturn)
-		pnfs_send_layoutreturn(lo, &stateid, iomode, true);
+		pnfs_send_layoutreturn(lo, &stateid, &lc_cred, iomode, true);
 	pnfs_put_layout_hdr(lo);
 	return false;
 }
@@ -2464,13 +2477,14 @@ pnfs_mark_layout_for_return(struct inode *inode,
 	 * for how it works.
 	 */
 	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, range, 0) != -EBUSY) {
+		const struct cred *cred;
 		nfs4_stateid stateid;
 		enum pnfs_iomode iomode;
 
-		return_now = pnfs_prepare_layoutreturn(lo, &stateid, &iomode);
+		return_now = pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode);
 		spin_unlock(&inode->i_lock);
 		if (return_now)
-			pnfs_send_layoutreturn(lo, &stateid, iomode, false);
+			pnfs_send_layoutreturn(lo, &stateid, &cred, iomode, false);
 	} else {
 		spin_unlock(&inode->i_lock);
 		nfs_commit_inode(inode, 0);
-- 
2.25.1

