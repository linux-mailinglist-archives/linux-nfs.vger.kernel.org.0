Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31E2B57C3
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 04:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKQDSJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 22:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgKQDSJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Nov 2020 22:18:09 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70700C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 16 Nov 2020 19:18:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 96059C52; Mon, 16 Nov 2020 22:18:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 96059C52
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/4] nfsd: pre/post attr is using wrong change attribute
Date:   Mon, 16 Nov 2020 22:18:04 -0500
Message-Id: <1605583086-19869-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605583086-19869-1-git-send-email-bfields@redhat.com>
References: <20201117031601.GB10526@fieldses.org>
 <1605583086-19869-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

fill_{pre/post}_attr are unconditionally using i_version even when the
underlying filesystem doesn't have proper support for i_version.

Move the code that chooses which i_version to use to the common
nfsd4_change_attribute().

The NFSEXP_V4ROOT case probably doesn't matter (the pseudoroot
filesystem is usually read-only and unlikely to see operations with pre
and post change attributes), but let's put it in the same place anyway
for consistency.

Fixes: c654b8a9cba6 ("nfsd: support ext4 i_version")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4xdr.c | 11 +----------
 fs/nfsd/nfsfh.c   | 11 +++++++----
 fs/nfsd/nfsfh.h   | 23 -----------------------
 fs/nfsd/vfs.c     | 32 ++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h     |  3 +++
 5 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 833a2c64dfe8..6806207b6d18 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2295,16 +2295,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
 			     struct svc_export *exp)
 {
-	if (exp->ex_flags & NFSEXP_V4ROOT) {
-		*p++ = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
-		*p++ = 0;
-	} else if (IS_I_VERSION(inode)) {
-		p = xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode));
-	} else {
-		*p++ = cpu_to_be32(stat->ctime.tv_sec);
-		*p++ = cpu_to_be32(stat->ctime.tv_nsec);
-	}
-	return p;
+	return xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode, exp));
 }
 
 /*
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index b3b4e8809aa9..4fbe1413e767 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -719,6 +719,7 @@ void fill_pre_wcc(struct svc_fh *fhp)
 {
 	struct inode    *inode;
 	struct kstat	stat;
+	struct svc_export *exp = fhp->fh_export;
 	__be32 err;
 
 	if (fhp->fh_pre_saved)
@@ -736,7 +737,7 @@ void fill_pre_wcc(struct svc_fh *fhp)
 	fhp->fh_pre_mtime = stat.mtime;
 	fhp->fh_pre_ctime = stat.ctime;
 	fhp->fh_pre_size  = stat.size;
-	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
+	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode, exp);
 	fhp->fh_pre_saved = true;
 }
 
@@ -746,17 +747,19 @@ void fill_pre_wcc(struct svc_fh *fhp)
 void fill_post_wcc(struct svc_fh *fhp)
 {
 	__be32 err;
+	struct inode *inode = d_inode(fhp->fh_dentry);
+	struct svc_export *exp = fhp->fh_export;
 
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
-						     d_inode(fhp->fh_dentry));
+	fhp->fh_post_change =
+			nfsd4_change_attribute(&fhp->fh_post_attr, inode, exp);
 	if (err) {
 		fhp->fh_post_saved = false;
 		/* Grab the ctime anyway - set_change_info might use it */
-		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
+		fhp->fh_post_attr.ctime = inode->i_ctime;
 	} else
 		fhp->fh_post_saved = true;
 }
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 56cfbc361561..547aef9b3265 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -245,29 +245,6 @@ fh_clear_wcc(struct svc_fh *fhp)
 	fhp->fh_pre_saved = false;
 }
 
-/*
- * We could use i_version alone as the change attribute.  However,
- * i_version can go backwards after a reboot.  On its own that doesn't
- * necessarily cause a problem, but if i_version goes backwards and then
- * is incremented again it could reuse a value that was previously used
- * before boot, and a client who queried the two values might
- * incorrectly assume nothing changed.
- *
- * By using both ctime and the i_version counter we guarantee that as
- * long as time doesn't go backwards we never reuse an old value.
- */
-static inline u64 nfsd4_change_attribute(struct kstat *stat,
-					 struct inode *inode)
-{
-	u64 chattr;
-
-	chattr =  stat->ctime.tv_sec;
-	chattr <<= 30;
-	chattr += stat->ctime.tv_nsec;
-	chattr += inode_query_iversion(inode);
-	return chattr;
-}
-
 extern void fill_pre_wcc(struct svc_fh *fhp);
 extern void fill_post_wcc(struct svc_fh *fhp);
 #else
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1ecaceebee13..2c71b02dd1fe 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2390,3 +2390,35 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+/*
+ * We could use i_version alone as the change attribute.  However,
+ * i_version can go backwards after a reboot.  On its own that doesn't
+ * necessarily cause a problem, but if i_version goes backwards and then
+ * is incremented again it could reuse a value that was previously used
+ * before boot, and a client who queried the two values might
+ * incorrectly assume nothing changed.
+ *
+ * By using both ctime and the i_version counter we guarantee that as
+ * long as time doesn't go backwards we never reuse an old value.
+ */
+u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode,
+					 struct svc_export *exp)
+{
+	u64 chattr;
+
+	if (exp->ex_flags & NFSEXP_V4ROOT) {
+		chattr = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
+		chattr <<= 32;
+	} else if (IS_I_VERSION(inode)) {
+		chattr = stat->ctime.tv_sec;
+		chattr <<= 30;
+		chattr += stat->ctime.tv_nsec;
+		chattr += inode_query_iversion(inode);
+	} else {
+		chattr = stat->ctime.tv_sec;
+		chattr <<= 32;
+		chattr += stat->ctime.tv_nsec;
+	}
+	return chattr;
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index a2442ebe5acf..26ed15256340 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -132,6 +132,9 @@ __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 				struct dentry *, int);
 
+u64		nfsd4_change_attribute(struct kstat *stat, struct inode *inode,
+				struct svc_export *exp);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
-- 
2.28.0

