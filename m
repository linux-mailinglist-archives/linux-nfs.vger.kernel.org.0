Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AAC567D17
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 06:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiGFEVh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 00:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiGFEVg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 00:21:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129BA17A9D
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 21:21:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B14B41F8D8;
        Wed,  6 Jul 2022 04:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657081292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3ntBbPLLmlhlDCgeuZPn3uytaoNBzdWQ/MVtf7ajeo=;
        b=niwKeeKJVq0A5PO2jZsK3GCJEwy7ZC+fO+16McG88UBxw3BPgkvpIsylIe2ByqYc/BZvkM
        OI2S57GeU9q0njopslKBQ0yY2fm6iNfOOKF0uO/CT+P3QysZzVSHQExTb7HNvhg3PttGhx
        lGzVEE6JyK/eJAj9uNZr2RVWI1C32aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657081292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3ntBbPLLmlhlDCgeuZPn3uytaoNBzdWQ/MVtf7ajeo=;
        b=plQt2mN9HQvVaE/Xuv7QCb7Fh/ibPPYlLUshsRHMJkua9rgn1IkU5w4lxNK/ZsGhZh6uLD
        ohvBbRsyi18prbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F9DD13A37;
        Wed,  6 Jul 2022 04:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GMl/EssNxWIsQgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Jul 2022 04:21:31 +0000
Subject: [PATCH 8/8] NFSD: discard fh_locked flag and fh_lock/fh_unlock
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 14:18:12 +1000
Message-ID: <165708109261.1940.5366273190007170909.stgit@noble.brown>
In-Reply-To: <165708033167.1940.3364591321728458949.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As all inode locking is now fully balanced, fh_put() does not need to
call fh_unlock().
fh_lock() and fh_unlock() are no longer used, so discard them.
These are the only real users of ->fh_locked, so discard that too.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsfh.c |    3 +--
 fs/nfsd/nfsfh.h |   56 ++++---------------------------------------------------
 fs/nfsd/vfs.c   |   17 +----------------
 3 files changed, 6 insertions(+), 70 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 5e2ed4b2a925..22a77a5e2327 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -549,7 +549,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	if (ref_fh == fhp)
 		fh_put(ref_fh);
 
-	if (fhp->fh_locked || fhp->fh_dentry) {
+	if (fhp->fh_dentry) {
 		printk(KERN_ERR "fh_compose: fh %pd2 not initialized!\n",
 		       dentry);
 	}
@@ -681,7 +681,6 @@ fh_put(struct svc_fh *fhp)
 	struct dentry * dentry = fhp->fh_dentry;
 	struct svc_export * exp = fhp->fh_export;
 	if (dentry) {
-		fh_unlock(fhp);
 		fhp->fh_dentry = NULL;
 		dput(dentry);
 		fh_clear_pre_post_attrs(fhp);
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index fb9d358a267e..09c654bdf9b0 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -81,7 +81,6 @@ typedef struct svc_fh {
 	struct dentry *		fh_dentry;	/* validated dentry */
 	struct svc_export *	fh_export;	/* export pointer */
 
-	bool			fh_locked;	/* inode locked by us */
 	bool			fh_want_write;	/* remount protection taken */
 	bool			fh_no_wcc;	/* no wcc data needed */
 	bool			fh_no_atomic_attr;
@@ -93,7 +92,7 @@ typedef struct svc_fh {
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
-	/* Pre-op attributes saved during fh_lock */
+	/* Pre-op attributes saved when inode is locked */
 	__u64			fh_pre_size;	/* size before operation */
 	struct timespec64	fh_pre_mtime;	/* mtime before oper */
 	struct timespec64	fh_pre_ctime;	/* ctime before oper */
@@ -103,7 +102,7 @@ typedef struct svc_fh {
 	 */
 	u64			fh_pre_change;
 
-	/* Post-op attributes saved in fh_unlock */
+	/* Post-op attributes saved in fh_fill_post_attrs() */
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
 } svc_fh;
@@ -223,8 +222,8 @@ void	fh_put(struct svc_fh *);
 static __inline__ struct svc_fh *
 fh_copy(struct svc_fh *dst, struct svc_fh *src)
 {
-	WARN_ON(src->fh_dentry || src->fh_locked);
-			
+	WARN_ON(src->fh_dentry);
+
 	*dst = *src;
 	return dst;
 }
@@ -323,51 +322,4 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 extern void fh_fill_pre_attrs(struct svc_fh *fhp);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 
-
-/*
- * Lock a file handle/inode
- * NOTE: both fh_lock and fh_unlock are done "by hand" in
- * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
- * so, any changes here should be reflected there.
- */
-
-static inline void
-fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
-{
-	struct dentry	*dentry = fhp->fh_dentry;
-	struct inode	*inode;
-
-	BUG_ON(!dentry);
-
-	if (fhp->fh_locked) {
-		printk(KERN_WARNING "fh_lock: %pd2 already locked!\n",
-			dentry);
-		return;
-	}
-
-	inode = d_inode(dentry);
-	inode_lock_nested(inode, subclass);
-	fh_fill_pre_attrs(fhp);
-	fhp->fh_locked = true;
-}
-
-static inline void
-fh_lock(struct svc_fh *fhp)
-{
-	fh_lock_nested(fhp, I_MUTEX_NORMAL);
-}
-
-/*
- * Unlock a file handle/inode
- */
-static inline void
-fh_unlock(struct svc_fh *fhp)
-{
-	if (fhp->fh_locked) {
-		fh_fill_post_attrs(fhp);
-		inode_unlock(d_inode(fhp->fh_dentry));
-		fhp->fh_locked = false;
-	}
-}
-
 #endif /* _LINUX_NFSD_NFSFH_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2526615285ca..fe4cdf8ab428 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1305,13 +1305,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dirp = d_inode(dentry);
 
 	dchild = dget(resfhp->fh_dentry);
-	if (!fhp->fh_locked) {
-		WARN_ONCE(1, "nfsd_create: parent %pd2 not locked!\n",
-				dentry);
-		err = nfserr_io;
-		goto out;
-	}
-
 	err = nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE);
 	if (err)
 		goto out;
@@ -1674,10 +1667,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 	}
 
-	/* cannot use fh_lock as we need deadlock protective ordering
-	 * so do it by hand */
 	trap = lock_rename(tdentry, fdentry);
-	ffhp->fh_locked = tfhp->fh_locked = true;
 	fh_fill_pre_attrs(ffhp);
 	fh_fill_pre_attrs(tfhp);
 
@@ -1733,17 +1723,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	dput(odentry);
  out_nfserr:
 	err = nfserrno(host_err);
-	/*
-	 * We cannot rely on fh_unlock on the two filehandles,
-	 * as that would do the wrong thing if the two directories
-	 * were the same, so again we do it by hand.
-	 */
+
 	if (!close_cached) {
 		fh_fill_post_attrs(ffhp);
 		fh_fill_post_attrs(tfhp);
 	}
 	unlock_rename(tdentry, fdentry);
-	ffhp->fh_locked = tfhp->fh_locked = false;
 	fh_drop_write(ffhp);
 
 	/*


