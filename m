Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF92481433
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Dec 2021 15:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbhL2OqJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Dec 2021 09:46:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49676 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhL2OqJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Dec 2021 09:46:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4872EB81905
        for <linux-nfs@vger.kernel.org>; Wed, 29 Dec 2021 14:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76D5C36AE7
        for <linux-nfs@vger.kernel.org>; Wed, 29 Dec 2021 14:46:06 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSD: Move fill_pre_wcc() and fill_post_wcc()
Date:   Wed, 29 Dec 2021 09:46:05 -0500
Message-Id:  <164078916576.2414.5292783716901594308.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164078891040.2414.11995954842150988952.stgit@bazille.1015granger.net>
References:  <164078891040.2414.11995954842150988952.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=7505; h=from:subject:message-id; bh=mHTSh++UA9wRYYRDHYJpcGmLP/USkQly3OY/qYOKCcY=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhzHSt3Bce90nEk7lS83BejVnyEsWIbBCvAcmBynds 8Wp52yWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYcx0rQAKCRAzarMzb2Z/lzanEA CRwZ8msmvwvpbW3/c+XUWnHHFe6HxSiFWmG02fhiqHa2mNL60Pg8DW569hGEi4kqL+JfL5tm/4sqvJ wip686qlzEnQ+7GDWCM3LPMyfb9IFMcL5ZLhTFhBYptBLPdr95CR+er6qS8XRVc5qGM0fW54N3uJ0v O44VAlI+C83wZyhxbQZZM59UFDdKTruUSfwLnh+GkKBfmNapdUrnkeaHlwMfgEtxopkV2dEQIOdyDu eThxgxVJA6ShaP6SQ9t4llsT075QnlOUZbDn5R0ONGC7Sy1h+o6NQ/daVcVJa+gfwcQDuDQAkYf2a3 4Ivr1ZP5iKppDeYZQh5ySS9CMoVKTF6U8dPC5isFFEbvY2xOJ3ETO4j7P2riuJ5jJstZWsj2pTuRUC J4eaFkRLdtFNbaL+kRrFkCC98S19H1BWW4yNHAVuAvkaJ26abXb1R1zla2LHXcqrqBmB22DBFg4Dzy zZFNdnGVNC9mB5o+Kah6eoIAwYAVVVx47s0DhwgPwGNY2nFIaF48ujOiSPgc6Z5WzMMtDgCOhWCbAE uFRLtqtFii/lgIzCqi1tRXe6QlQKU92VxMRIYQ51OdTr76qndFbOk0YYZSihOiBmrQjVwSHkz728IO egN+o+IPYLJk6Het/6xTEqPjjPOJ/qdycJTaPGbqeae6Kc5rtl8kdO6mz+xg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These functions are related to file handle processing and have
nothing to do with XDR encoding or decoding. Also they are no longer
NFSv3-specific. As a clean-up, move their definitions to a more
appropriate location. WCC is also an NFSv3-specific term, so rename
them as general-purpose helpers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c  |   55 -------------------------------------------
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/nfsfh.c    |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsfh.h    |   40 ++++++++++++++++++++------------
 fs/nfsd/vfs.c      |    8 +++---
 5 files changed, 96 insertions(+), 75 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 84088581bbe0..7c45ba4db61b 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -487,61 +487,6 @@ svcxdr_encode_wcc_data(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return true;
 }
 
-/*
- * Fill in the pre_op attr for the wcc data
- */
-void fill_pre_wcc(struct svc_fh *fhp)
-{
-	struct inode    *inode;
-	struct kstat	stat;
-	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	__be32 err;
-
-	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
-		return;
-	inode = d_inode(fhp->fh_dentry);
-	err = fh_getattr(fhp, &stat);
-	if (err) {
-		/* Grab the times from inode anyway */
-		stat.mtime = inode->i_mtime;
-		stat.ctime = inode->i_ctime;
-		stat.size  = inode->i_size;
-	}
-	if (v4)
-		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
-
-	fhp->fh_pre_mtime = stat.mtime;
-	fhp->fh_pre_ctime = stat.ctime;
-	fhp->fh_pre_size  = stat.size;
-	fhp->fh_pre_saved = true;
-}
-
-/*
- * Fill in the post_op attr for the wcc data
- */
-void fill_post_wcc(struct svc_fh *fhp)
-{
-	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
-	struct inode *inode = d_inode(fhp->fh_dentry);
-	__be32 err;
-
-	if (fhp->fh_no_wcc)
-		return;
-
-	if (fhp->fh_post_saved)
-		printk("nfsd: inode locked twice during operation.\n");
-
-	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	if (err) {
-		fhp->fh_post_saved = false;
-		fhp->fh_post_attr.ctime = inode->i_ctime;
-	} else
-		fhp->fh_post_saved = true;
-	if (v4)
-		fhp->fh_post_change =
-			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
-}
-
 /*
  * XDR decode functions
  */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 43057080d2aa..4d4843b7d055 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2530,7 +2530,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			goto encode_op;
 		}
 
-		fh_clear_wcc(current_fh);
+		fh_clear_pre_post_attrs(current_fh);
 
 		/* If op is non-idempotent */
 		if (op->opdesc->op_flags & OP_MODIFIES_SOMETHING) {
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index f3779fa72c89..145208bcb9bd 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -611,6 +611,70 @@ fh_update(struct svc_fh *fhp)
 	return nfserr_serverfault;
 }
 
+#ifdef CONFIG_NFSD_V3
+
+/**
+ * fh_fill_pre_attrs - Fill in pre-op attributes
+ * @fhp: file handle to be updated
+ *
+ */
+void fh_fill_pre_attrs(struct svc_fh *fhp)
+{
+	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
+	struct inode *inode;
+	struct kstat stat;
+	__be32 err;
+
+	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
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
+	if (v4)
+		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
+
+	fhp->fh_pre_mtime = stat.mtime;
+	fhp->fh_pre_ctime = stat.ctime;
+	fhp->fh_pre_size  = stat.size;
+	fhp->fh_pre_saved = true;
+}
+
+/**
+ * fh_fill_post_attrs - Fill in post-op attributes
+ * @fhp: file handle to be updated
+ *
+ */
+void fh_fill_post_attrs(struct svc_fh *fhp)
+{
+	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
+	struct inode *inode = d_inode(fhp->fh_dentry);
+	__be32 err;
+
+	if (fhp->fh_no_wcc)
+		return;
+
+	if (fhp->fh_post_saved)
+		printk("nfsd: inode locked twice during operation.\n");
+
+	err = fh_getattr(fhp, &fhp->fh_post_attr);
+	if (err) {
+		fhp->fh_post_saved = false;
+		fhp->fh_post_attr.ctime = inode->i_ctime;
+	} else
+		fhp->fh_post_saved = true;
+	if (v4)
+		fhp->fh_post_change =
+			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
+}
+
+#endif /* CONFIG_NFSD_V3 */
+
 /*
  * Release a file handle.
  */
@@ -623,7 +687,7 @@ fh_put(struct svc_fh *fhp)
 		fh_unlock(fhp);
 		fhp->fh_dentry = NULL;
 		dput(dentry);
-		fh_clear_wcc(fhp);
+		fh_clear_pre_post_attrs(fhp);
 	}
 	fh_drop_write(fhp);
 	if (exp) {
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index d11e4b6870d6..434930d8a946 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -284,12 +284,13 @@ static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 #endif
 
 #ifdef CONFIG_NFSD_V3
-/*
- * The wcc data stored in current_fh should be cleared
- * between compound ops.
+
+/**
+ * fh_clear_pre_post_attrs - Reset pre/post attributes
+ * @fhp: file handle to be updated
+ *
  */
-static inline void
-fh_clear_wcc(struct svc_fh *fhp)
+static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 {
 	fhp->fh_post_saved = false;
 	fhp->fh_pre_saved = false;
@@ -323,13 +324,24 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 		return time_to_chattr(&stat->ctime);
 }
 
-extern void fill_pre_wcc(struct svc_fh *fhp);
-extern void fill_post_wcc(struct svc_fh *fhp);
-#else
-#define fh_clear_wcc(ignored)
-#define fill_pre_wcc(ignored)
-#define fill_post_wcc(notused)
-#endif /* CONFIG_NFSD_V3 */
+extern void fh_fill_pre_attrs(struct svc_fh *fhp);
+extern void fh_fill_post_attrs(struct svc_fh *fhp);
+
+#else /* !CONFIG_NFSD_V3 */
+
+static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
+{
+}
+
+static inline void fh_fill_pre_attrs(struct svc_fh *fhp)
+{
+}
+
+static inline void fh_fill_post_attrs(struct svc_fh *fhp)
+{
+}
+
+#endif /* !CONFIG_NFSD_V3 */
 
 
 /*
@@ -355,7 +367,7 @@ fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
 
 	inode = d_inode(dentry);
 	inode_lock_nested(inode, subclass);
-	fill_pre_wcc(fhp);
+	fh_fill_pre_attrs(fhp);
 	fhp->fh_locked = true;
 }
 
@@ -372,7 +384,7 @@ static inline void
 fh_unlock(struct svc_fh *fhp)
 {
 	if (fhp->fh_locked) {
-		fill_post_wcc(fhp);
+		fh_fill_post_attrs(fhp);
 		inode_unlock(d_inode(fhp->fh_dentry));
 		fhp->fh_locked = false;
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d8daef9054cb..d985bf48f041 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1759,8 +1759,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	 * so do it by hand */
 	trap = lock_rename(tdentry, fdentry);
 	ffhp->fh_locked = tfhp->fh_locked = true;
-	fill_pre_wcc(ffhp);
-	fill_pre_wcc(tfhp);
+	fh_fill_pre_attrs(ffhp);
+	fh_fill_pre_attrs(tfhp);
 
 	odentry = lookup_one_len(fname, fdentry, flen);
 	host_err = PTR_ERR(odentry);
@@ -1820,8 +1820,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	 * were the same, so again we do it by hand.
 	 */
 	if (!close_cached) {
-		fill_post_wcc(ffhp);
-		fill_post_wcc(tfhp);
+		fh_fill_post_attrs(ffhp);
+		fh_fill_post_attrs(tfhp);
 	}
 	unlock_rename(tdentry, fdentry);
 	ffhp->fh_locked = tfhp->fh_locked = false;

