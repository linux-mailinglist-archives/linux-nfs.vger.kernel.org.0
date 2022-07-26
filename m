Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FEE5835C7
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 01:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiG0XsP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 19:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiG0XsP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 19:48:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39644F6AB
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 16:48:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACF283F5D0;
        Wed, 27 Jul 2022 23:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658965692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XXwE/q22+9NSgZcVZ2Z1MVv8p6Bi1Sa17CL84Ird7u0=;
        b=jxM/7lF3MK3s27s3a5C4sF6hrG/ZuomZj7ZNeM2XWDq+3XBhbs038c5zZR/VPTKrO7n2M8
        lxVYHy6j2xD0Agh88eyCwfqi65AsUVadW4sFyP8VsGFECmrIEoqWr9kWKOoeIXbuxOkxjZ
        BGm8LyzlJZMrvQapVcOs/WVWzBQ/zok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658965692;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XXwE/q22+9NSgZcVZ2Z1MVv8p6Bi1Sa17CL84Ird7u0=;
        b=+dxYXsS9H8lNSkB1NDu4RZtc89PQ/7bNRqlOQ5uMHpQRcAUFiChvNMnjbsF5dy/QWyYVvB
        rQiJFCHok0lHcYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D68913A8E;
        Wed, 27 Jul 2022 23:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EM3vFrvO4WJbHQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 27 Jul 2022 23:48:11 +0000
Subject: [PATCH 11/13] NFSD: use explicit lock/unlock for directory ops
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793059.21666.9611699223923887416.stgit@noble.brown>
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

When creating or unlinking a name in a directory use explicit
inode_lock_nested() instead of fh_lock(), and explicit calls to
fh_fill_pre_attrs() and fh_fill_post_attrs().  This is already done for
renames.

Also move the 'fill' calls closer to the operation that might change the
attributes.  This way they are avoided on some error paths.

For the v2-only code in nfsproc.c, drop the fill calls as they aren't
needed.

Having the locking explicit will simplify proposed future changes to
locking for directories.  It also makes it easily visible exactly where
pre/post attributes are used - not all callers of fh_lock() actually
need the pre/post attributes.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |    6 ++++--
 fs/nfsd/nfs4proc.c |    6 ++++--
 fs/nfsd/nfsproc.c  |    5 ++---
 fs/nfsd/vfs.c      |   30 +++++++++++++++++++-----------
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 774e4a2ab9b1..c2f992b4387a 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -256,7 +256,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(inode, I_MUTEX_PARENT);
 
 	child = lookup_one_len(argp->name, parent, argp->len);
 	if (IS_ERR(child)) {
@@ -314,11 +314,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
+	fh_fill_pre_attrs(fhp);
 	host_err = vfs_create(&init_user_ns, inode, child, iap->ia_mode, true);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
 	}
+	fh_fill_post_attrs(fhp);
 
 	/* A newly created file already has a file size of zero. */
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
@@ -336,7 +338,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	if (child && !IS_ERR(child))
 		dput(child);
 	fh_drop_write(fhp);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 48e4efb39a9c..90af82d49119 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -264,7 +264,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (is_create_with_attrs(open))
 		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(inode, I_MUTEX_PARENT);
 
 	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
 	if (IS_ERR(child)) {
@@ -348,10 +348,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
+	fh_fill_pre_attrs(fhp);
 	status = nfsd4_vfs_create(fhp, child, open);
 	if (status != nfs_ok)
 		goto out;
 	open->op_created = true;
+	fh_fill_post_attrs(fhp);
 
 	/* A newly created file already has a file size of zero. */
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
@@ -373,7 +375,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.acl_failed)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	nfsd_attrs_free(&attrs);
 	if (child && !IS_ERR(child))
 		dput(child);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index d09d516188d2..4cff332f58bb 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -287,7 +287,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto done;
 	}
 
-	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
+	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
 	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
@@ -403,8 +403,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 out_unlock:
-	/* We don't really need to unlock, as fh_put does it. */
-	fh_unlock(dirfhp);
+	inode_unlock(dirfhp->fh_dentry->d_inode);
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8ebad4a99552..f2cb9b047766 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1369,7 +1369,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
 	dchild = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild)) {
@@ -1384,10 +1384,12 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dput(dchild);
 	if (err)
 		goto out_unlock;
+	fh_fill_pre_attrs(fhp);
 	err = nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
 				 rdev, resfhp);
+	fh_fill_post_attrs(fhp);
 out_unlock:
-	fh_unlock(fhp);
+	inode_unlock(dentry->d_inode);
 	return err;
 }
 
@@ -1460,20 +1462,22 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 	}
 
-	fh_lock(fhp);
 	dentry = fhp->fh_dentry;
+	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
 	dnew = lookup_one_len(fname, dentry, flen);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
-		fh_unlock(fhp);
+		inode_unlock(dentry->d_inode);
 		goto out_drop_write;
 	}
+	fh_fill_pre_attrs(fhp);
 	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(dentry->d_inode);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
 	dput(dnew);
@@ -1519,9 +1523,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		goto out;
 	}
 
-	fh_lock_nested(ffhp, I_MUTEX_PARENT);
 	ddir = ffhp->fh_dentry;
 	dirp = d_inode(ddir);
+	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
 	dnew = lookup_one_len(name, ddir, len);
 	if (IS_ERR(dnew)) {
@@ -1534,8 +1538,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
 		goto out_dput;
+	fh_fill_pre_attrs(ffhp);
 	host_err = vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
-	fh_unlock(ffhp);
+	fh_fill_post_attrs(ffhp);
+	inode_unlock(dirp);
 	if (!host_err) {
 		err = nfserrno(commit_metadata(ffhp));
 		if (!err)
@@ -1555,7 +1561,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 out_dput:
 	dput(dnew);
 out_unlock:
-	fh_unlock(ffhp);
+	inode_unlock(dirp);
 	goto out_drop_write;
 }
 
@@ -1730,9 +1736,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (host_err)
 		goto out_nfserr;
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
+	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
 	rdentry = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(rdentry);
@@ -1750,6 +1756,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
+	fh_fill_pre_attrs(fhp);
 	if (type != S_IFDIR) {
 		if (rdentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)
 			nfsd_close_cached_files(rdentry);
@@ -1757,8 +1764,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	} else {
 		host_err = vfs_rmdir(&init_user_ns, dirp, rdentry);
 	}
+	fh_fill_post_attrs(fhp);
 
-	fh_unlock(fhp);
+	inode_unlock(dirp);
 	if (!host_err)
 		host_err = commit_metadata(fhp);
 	dput(rdentry);
@@ -1781,7 +1789,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 out:
 	return err;
 out_unlock:
-	fh_unlock(fhp);
+	inode_unlock(dirp);
 	goto out_drop_write;
 }
 


