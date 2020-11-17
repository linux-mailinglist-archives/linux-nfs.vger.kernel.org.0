Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B364E2B57C1
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 04:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKQDSJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 22:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgKQDSJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Nov 2020 22:18:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E35C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 16 Nov 2020 19:18:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 911401C21; Mon, 16 Nov 2020 22:18:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 911401C21
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/4] nfsd: move fill_{pre,post}_wcc to nfsfh.c
Date:   Mon, 16 Nov 2020 22:18:03 -0500
Message-Id: <1605583086-19869-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20201117031601.GB10526@fieldses.org>
References: <20201117031601.GB10526@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

These functions are actually used by NFSv4 code as well, and having them
in nfs3xdr.c has caused some confusion.

This is just cleanup, no change in behavior.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs3xdr.c | 49 -----------------------------------------------
 fs/nfsd/nfsfh.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2277f83da250..14efb3aba6b2 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -252,55 +252,6 @@ encode_wcc_data(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 	return encode_post_op_attr(rqstp, p, fhp);
 }
 
-/*
- * Fill in the pre_op attr for the wcc data
- */
-void fill_pre_wcc(struct svc_fh *fhp)
-{
-	struct inode    *inode;
-	struct kstat	stat;
-	__be32 err;
-
-	if (fhp->fh_pre_saved)
-		return;
-
-	inode = d_inode(fhp->fh_dentry);
-	err = fh_getattr(fhp, &stat);
-	if (err) {
-		/* Grab the times from inode anyway */
-		stat.mtime = inode->i_mtime;
-		stat.ctime = inode->i_ctime;
-		stat.size  = inode->i_size;
-	}
-
-	fhp->fh_pre_mtime = stat.mtime;
-	fhp->fh_pre_ctime = stat.ctime;
-	fhp->fh_pre_size  = stat.size;
-	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
-	fhp->fh_pre_saved = true;
-}
-
-/*
- * Fill in the post_op attr for the wcc data
- */
-void fill_post_wcc(struct svc_fh *fhp)
-{
-	__be32 err;
-
-	if (fhp->fh_post_saved)
-		printk("nfsd: inode locked twice during operation.\n");
-
-	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
-						     d_inode(fhp->fh_dentry));
-	if (err) {
-		fhp->fh_post_saved = false;
-		/* Grab the ctime anyway - set_change_info might use it */
-		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
-	} else
-		fhp->fh_post_saved = true;
-}
-
 /*
  * XDR decode functions
  */
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c81dbbad8792..b3b4e8809aa9 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -711,3 +711,52 @@ enum fsid_source fsid_source(struct svc_fh *fhp)
 		return FSIDSOURCE_UUID;
 	return FSIDSOURCE_DEV;
 }
+
+/*
+ * Fill in the pre_op attr for the wcc data
+ */
+void fill_pre_wcc(struct svc_fh *fhp)
+{
+	struct inode    *inode;
+	struct kstat	stat;
+	__be32 err;
+
+	if (fhp->fh_pre_saved)
+		return;
+
+	inode = d_inode(fhp->fh_dentry);
+	err = fh_getattr(fhp, &stat);
+	if (err) {
+		/* Grab the times from inode anyway */
+		stat.mtime = inode->i_mtime;
+		stat.ctime = inode->i_ctime;
+		stat.size  = inode->i_size;
+	}
+
+	fhp->fh_pre_mtime = stat.mtime;
+	fhp->fh_pre_ctime = stat.ctime;
+	fhp->fh_pre_size  = stat.size;
+	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
+	fhp->fh_pre_saved = true;
+}
+
+/*
+ * Fill in the post_op attr for the wcc data
+ */
+void fill_post_wcc(struct svc_fh *fhp)
+{
+	__be32 err;
+
+	if (fhp->fh_post_saved)
+		printk("nfsd: inode locked twice during operation.\n");
+
+	err = fh_getattr(fhp, &fhp->fh_post_attr);
+	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
+						     d_inode(fhp->fh_dentry));
+	if (err) {
+		fhp->fh_post_saved = false;
+		/* Grab the ctime anyway - set_change_info might use it */
+		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
+	} else
+		fhp->fh_post_saved = true;
+}
-- 
2.28.0

