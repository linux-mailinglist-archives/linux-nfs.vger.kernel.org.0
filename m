Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6EA567D12
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 06:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiGFEU7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 00:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGFEU6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 00:20:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87E1838E
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 21:20:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A7B6220A7;
        Wed,  6 Jul 2022 04:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657081256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzVpTHNcBPiNz9K9S7ljnD9RLTSaAjbmyLozYzpHiPs=;
        b=zj4qKLCGdXjD1qFlixdNKnh0GmyapTbHJNsppghdOf6KG1v9qd982YM9lfdCROgnrU03kH
        DqaTXQ946zegofj00/CMpYFcIYSXG8ukVFYNBv7HwreachRR1b1Y7LbxbUfJFd6GDN4k9o
        zecWoD6vYoNe3EjPgVDFo5Y29bQgjXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657081256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzVpTHNcBPiNz9K9S7ljnD9RLTSaAjbmyLozYzpHiPs=;
        b=nlP47roMvf0Qntj34btVS5Xj5ZYFkTHBJRkC4QtomwY4QjOZ3bMoqZRkhqX5iB7yW3gvM3
        i9zevbXzGnEje6BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99C0E13A37;
        Wed,  6 Jul 2022 04:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aJ/TFKYNxWL8QQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Jul 2022 04:20:54 +0000
Subject: [PATCH 6/8] NFSD: use explicit lock/unlock for directory ops
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 14:18:12 +1000
Message-ID: <165708109259.1940.685583862810495747.stgit@noble.brown>
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

When creating or unlinking a name in a directory use explicit
inode_lock_nested() instead of fh_lock(), and explicit calls to
fh_fill_pre_attrs() and fh_fill_post_attrs().  This is already done for
renames.

Also move the 'fill' calls closer to the operation that might change the
attributes.  This way they are avoided on some error paths.

Having the locking explicit will simplify proposed future changes to
locking for directories.  It also makes it easily visible exactly where
pre/post attributes are used - not all callers of fh_lock() actually
need the pre/post attributes.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |    6 ++++--
 fs/nfsd/nfs4proc.c |    6 ++++--
 fs/nfsd/nfsproc.c  |    7 ++++---
 fs/nfsd/vfs.c      |   30 +++++++++++++++++++-----------
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 3a67d0afb885..9629517344ff 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -254,7 +254,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(inode, I_MUTEX_PARENT);
 
 	child = lookup_one_len(argp->name, parent, argp->len);
 	if (IS_ERR(child)) {
@@ -312,11 +312,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -334,7 +336,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
 
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	if (child && !IS_ERR(child))
 		dput(child);
 	fh_drop_write(fhp);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6ec22c69cbec..242f059e6788 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -306,7 +306,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(inode, I_MUTEX_PARENT);
 
 	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
 	if (IS_ERR(child)) {
@@ -385,10 +385,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -406,7 +408,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
 
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	if (child && !IS_ERR(child))
 		dput(child);
 	fh_drop_write(fhp);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index ed24fae09517..427c404bc52b 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -285,7 +285,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto done;
 	}
 
-	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
+	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
 	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
@@ -382,6 +382,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 	resp->status = nfs_ok;
+	fh_fill_pre_attrs(dirfhp);
 	if (!inode) {
 		/* File doesn't exist. Create it and set attrs */
 		resp->status = nfsd_create_locked(rqstp, dirfhp, argp->name,
@@ -399,10 +400,10 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 			resp->status = nfsd_setattr(rqstp, newfhp, attr, 0,
 						    (time64_t)0);
 	}
+	fh_fill_post_attrs(dirfhp);
 
 out_unlock:
-	/* We don't really need to unlock, as fh_put does it. */
-	fh_unlock(dirfhp);
+	inode_unlock(dirfhp->fh_dentry->d_inode);
 	fh_drop_write(dirfhp);
 done:
 	fh_put(dirfhp);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8e050c6d112a..2ca748aa83bb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1412,7 +1412,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
 	dchild = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild)) {
@@ -1427,12 +1427,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dput(dchild);
 	if (err)
 		goto out_unlock;
+	fh_fill_pre_attrs(fhp);
 	err = nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
 				 rdev, resfhp);
 	if (!err && post_create)
 		post_create(resfhp, data);
+	fh_fill_post_attrs(fhp);
 out_unlock:
-	fh_unlock(fhp);
+	inode_unlock(dentry->d_inode);
 	return err;
 }
 
@@ -1505,14 +1507,15 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		goto out_nfserr;
 
-	fh_lock(fhp);
 	dentry = fhp->fh_dentry;
+	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
 	dnew = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(dnew);
 	if (IS_ERR(dnew)) {
-		fh_unlock(fhp);
+		inode_unlock(dentry->d_inode);
 		goto out_nfserr;
 	}
+	fh_fill_pre_attrs(fhp);
 	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
 	if (!err)
@@ -1525,7 +1528,8 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err==0) err = cerr;
 	if (!err && post_create)
 		post_create(resfhp, data);
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(dentry->d_inode);
 out:
 	return err;
 
@@ -1569,9 +1573,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		goto out;
 	}
 
-	fh_lock_nested(ffhp, I_MUTEX_PARENT);
 	ddir = ffhp->fh_dentry;
 	dirp = d_inode(ddir);
+	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
 	dnew = lookup_one_len(name, ddir, len);
 	host_err = PTR_ERR(dnew);
@@ -1585,8 +1589,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
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
@@ -1606,7 +1612,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 out_dput:
 	dput(dnew);
 out_unlock:
-	fh_unlock(ffhp);
+	inode_unlock(dirp);
 	goto out_drop_write;
 }
 
@@ -1781,9 +1787,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (host_err)
 		goto out_nfserr;
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
+	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
 	rdentry = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(rdentry);
@@ -1801,6 +1807,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
+	fh_fill_pre_attrs(fhp);
 	if (type != S_IFDIR) {
 		if (rdentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)
 			nfsd_close_cached_files(rdentry);
@@ -1808,8 +1815,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	} else {
 		host_err = vfs_rmdir(&init_user_ns, dirp, rdentry);
 	}
+	fh_fill_post_attrs(fhp);
 
-	fh_unlock(fhp);
+	inode_unlock(dirp);
 	if (!host_err)
 		host_err = commit_metadata(fhp);
 	dput(rdentry);
@@ -1832,7 +1840,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 out:
 	return err;
 out_unlock:
-	fh_unlock(fhp);
+	inode_unlock(dirp);
 	goto out_drop_write;
 }
 


