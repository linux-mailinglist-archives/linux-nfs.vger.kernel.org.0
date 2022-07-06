Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8E8567D14
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 06:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiGFEVb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 00:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiGFEVa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 00:21:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF521838E
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 21:21:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBC671F8D8;
        Wed,  6 Jul 2022 04:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657081287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCsWxh1ujzkMG9C+r1JDX2CNmUtweUV3bl/Qbt4JkG8=;
        b=FNpSiP37LC1XG8jCmBAetjhPF9uJlA0GhEKwyMh3k8hiXFq4It4/gv5ctS8O98ybt1KaIE
        TDEI/5SXLc66A/7cH73XDXTlrrA/S2OnpI0Etto3ux5rLClOBd0dXobDG6Dxv/k6Wb2/Vp
        Svr0v3rGV4/X6lv+YOZRjXOSENyDf24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657081287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCsWxh1ujzkMG9C+r1JDX2CNmUtweUV3bl/Qbt4JkG8=;
        b=PW1TIFpJhyebaOWj1AD+r00LA5X87cFdy3xAx5+EA5vMFMkcUvyg/oLcLuK3oCOEpxdPVn
        HTS8Af25uc80c/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C6EA13A37;
        Wed,  6 Jul 2022 04:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t6rdFcYNxWIjQgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Jul 2022 04:21:26 +0000
Subject: [PATCH 7/8] NFSD: use (un)lock_inode instead of fh_(un)lock for file
 operations
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 14:18:12 +1000
Message-ID: <165708109260.1940.6599746560136720935.stgit@noble.brown>
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

When locking a file to access ACLs and xattrs etc, use explicit locking
with inode_lock() instead of fh_lock().  This means that the calls to
fh_fill_pre/post_attr() are also explicit which improves readability and
allows us to place them only where they are needed.  Only the xattr
calls need pre/post information.

When locking a file we don't need I_MUTEX_PARENT as the file is not a
parent of anything, so we can use inode_lock() directly rather than the
inode_lock_nested() call that fh_lock() uses.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs2acl.c   |    6 +++---
 fs/nfsd/nfs3acl.c   |    4 ++--
 fs/nfsd/nfs4acl.c   |    7 +++----
 fs/nfsd/nfs4state.c |    8 ++++----
 fs/nfsd/vfs.c       |   25 ++++++++++++-------------
 5 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index b5760801d377..9edd3c1a30fb 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -111,7 +111,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_errno;
 
-	fh_lock(fh);
+	inode_lock(inode);
 
 	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
 			      argp->acl_access);
@@ -122,7 +122,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_drop_lock;
 
-	fh_unlock(fh);
+	inode_unlock(inode);
 
 	fh_drop_write(fh);
 
@@ -136,7 +136,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	return rpc_success;
 
 out_drop_lock:
-	fh_unlock(fh);
+	inode_unlock(inode);
 	fh_drop_write(fh);
 out_errno:
 	resp->status = nfserrno(error);
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 35b2ebda14da..9446c6743664 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -101,7 +101,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_errno;
 
-	fh_lock(fh);
+	inode_lock(inode);
 
 	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
 			      argp->acl_access);
@@ -111,7 +111,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 			      argp->acl_default);
 
 out_drop_lock:
-	fh_unlock(fh);
+	inode_unlock(inode);
 	fh_drop_write(fh);
 out_errno:
 	resp->status = nfserrno(error);
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 5c9b7e01e8ca..a33cacf62ea0 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -781,19 +781,18 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_error < 0)
 		goto out_nfserr;
 
-	fh_lock(fhp);
+	inode_lock(inode);
 
 	host_error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pacl);
 	if (host_error < 0)
 		goto out_drop_lock;
 
-	if (S_ISDIR(inode->i_mode)) {
+	if (S_ISDIR(inode->i_mode))
 		host_error = set_posix_acl(&init_user_ns, inode,
 					   ACL_TYPE_DEFAULT, dpacl);
-	}
 
 out_drop_lock:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 
 	posix_acl_release(pacl);
 	posix_acl_release(dpacl);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9d1a3e131c49..307317ba9aff 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7322,21 +7322,21 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file_lock *lock)
 {
 	struct nfsd_file *nf;
+	struct inode *inode = fhp->fh_dentry->d_inode;
 	__be32 err;
 
 	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
-	fh_lock(fhp); /* to block new leases till after test_lock: */
-	err = nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
-							NFSD_MAY_READ));
+	inode_lock(inode); /* to block new leases till after test_lock: */
+	err = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 	if (err)
 		goto out;
 	lock->fl_file = nf->nf_file;
 	err = nfserrno(vfs_test_lock(nf->nf_file, lock));
 	lock->fl_file = NULL;
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	nfsd_file_put(nf);
 	return err;
 }
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2ca748aa83bb..2526615285ca 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -444,7 +444,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 			return err;
 	}
 
-	fh_lock(fhp);
+	inode_lock(inode);
 	if (size_change) {
 		/*
 		 * RFC5661, Section 18.30.4:
@@ -480,7 +480,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	host_err = notify_change(&init_user_ns, dentry, iap, NULL);
 
 out_unlock:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
 out:
@@ -2196,12 +2196,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
 }
 
 /*
- * Removexattr and setxattr need to call fh_lock to both lock the inode
- * and set the change attribute. Since the top-level vfs_removexattr
- * and vfs_setxattr calls already do their own inode_lock calls, call
- * the _locked variant. Pass in a NULL pointer for delegated_inode,
- * and let the client deal with NFS4ERR_DELAY (same as with e.g.
- * setattr and remove).
+ * Pass in a NULL pointer for delegated_inode, and let the client deal
+ * with NFS4ERR_DELAY (same as with e.g.  setattr and remove).
  */
 __be32
 nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
@@ -2217,12 +2213,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 	if (ret)
 		return nfserrno(ret);
 
-	fh_lock(fhp);
+	inode_lock(fhp->fh_dentry->d_inode);
+	fh_fill_pre_attrs(fhp);
 
 	ret = __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
 				       name, NULL);
 
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
 	return nfsd_xattr_errno(ret);
@@ -2242,12 +2240,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 	ret = fh_want_write(fhp);
 	if (ret)
 		return nfserrno(ret);
-	fh_lock(fhp);
+	inode_lock(fhp->fh_dentry->d_inode);
+	fh_fill_pre_attrs(fhp);
 
 	ret = __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
 				    len, flags, NULL);
-
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
 	return nfsd_xattr_errno(ret);


