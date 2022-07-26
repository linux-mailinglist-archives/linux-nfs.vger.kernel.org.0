Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8D5835C9
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 01:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiG0XsW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 19:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiG0XsV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 19:48:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E594F6AB
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 16:48:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 738C920ECC;
        Wed, 27 Jul 2022 23:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658965699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1zd46x1bDFOPapb1EebifdmUBz/1HpnyIYAZTA/3Z0=;
        b=PAhd/6MAMTdGGi/p/Ao2WWjM3KbXH4A/zuhxuO07wVOHJDG9pDCzlJDlet8e+sjTRTex16
        1UzhNfJqgYlx/wj5HHu9xvOrj3r/5lsobPTpK9rbjc7xy+oIZj1R2iLDuhHh4URn0ESk+A
        yuCKyrxsBc6kc45SiC54GXh0plzEgEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658965699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1zd46x1bDFOPapb1EebifdmUBz/1HpnyIYAZTA/3Z0=;
        b=u6kiAp1Au88IvkIiO9qoWlhvph7uhRGg7mExnCAuk7f7StvAtM9y71LIrWQxT91ZAOrJgk
        FH3F2oI0fOdYHgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5110613A8E;
        Wed, 27 Jul 2022 23:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zr4qA8LO4WJjHQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 27 Jul 2022 23:48:18 +0000
Subject: [PATCH 12/13] NFSD: use (un)lock_inode instead of fh_(un)lock for
 file operations
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793060.21666.12014436943063405491.stgit@noble.brown>
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs2acl.c   |    6 +++---
 fs/nfsd/nfs3acl.c   |    4 ++--
 fs/nfsd/nfs4state.c |    9 +++++----
 fs/nfsd/vfs.c       |   25 ++++++++++++-------------
 4 files changed, 22 insertions(+), 22 deletions(-)

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
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 45df1e85ff32..b9be12b3cebd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7397,21 +7397,22 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file_lock *lock)
 {
 	struct nfsd_file *nf;
+	struct inode *inode;
 	__be32 err;
 
 	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
-	fh_lock(fhp); /* to block new leases till after test_lock: */
-	err = nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
-							NFSD_MAY_READ));
+	inode = fhp->fh_dentry->d_inode;
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
index f2cb9b047766..1d96d89a4801 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -416,7 +416,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			return err;
 	}
 
-	fh_lock(fhp);
+	inode_lock(inode);
 	if (size_change) {
 		/*
 		 * RFC5661, Section 18.30.4:
@@ -463,7 +463,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->acl_failed = set_posix_acl(&init_user_ns,
 						 inode, ACL_TYPE_DEFAULT,
 						 attr->dpacl);
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
 out:
@@ -2145,12 +2145,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
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
@@ -2166,12 +2162,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
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
@@ -2191,12 +2189,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
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


