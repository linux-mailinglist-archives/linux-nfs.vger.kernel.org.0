Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58393580BE0
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 08:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiGZGrh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiGZGre (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 02:47:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB921802
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 23:47:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83E631F97A;
        Tue, 26 Jul 2022 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658818051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCI9KEXO2LPQikNtCXNesZpjrQa9VRLaQ1m51DhD3fw=;
        b=jDF3l+k+5VPV91Pw+FASPzL2Amqf+sF8tnbISr1BbKb+bZfzWrMyCXq9hTr9pp5umY6tX9
        9g4YDJgir1wjaPzIEvVC/X8i27OBGEZfJS1KePbWVy2GqeLtTS8R+vTWaxODw+hrfQmmRw
        K24cLcY3YGCMys+JLB/McYYJTwCm+mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658818051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCI9KEXO2LPQikNtCXNesZpjrQa9VRLaQ1m51DhD3fw=;
        b=/2ulzthj6MhyTV6ktOHyha+x7xegoI/xEbAwdbFi3fZwBhrk3XNbe6AY5WP9aQTI8bjB0E
        u8V+QH5R4Mx/zdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3641013A7C;
        Tue, 26 Jul 2022 06:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eDd2OQGO32J9WAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 06:47:29 +0000
Subject: [PATCH 03/13] NFSD: introduce struct nfsd_attrs
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793055.21666.3761329899598926055.stgit@noble.brown>
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The attributes that nfsd might want to set on a file include 'struct
iattr' as well as an ACL and security label.
The latter two are passed around quite separately from the first, in
part because they are only needed for NFSv4.  This leads to some
clumsiness in the code, such as the attributes NOT being set in
nfsd_create_setattr().

We need to keep the directory locked until all attributes are set to
ensure the file is never visibile without all its attributes.  This need
combined with the inconsistent handling of attributes leads to more
clumsiness.

As a first step towards tidying this up, introduce 'struct nfsd_attrs'.
This is passed (by reference) to vfs.c functions that work with
attributes, and is assembled by the various nfs*proc functions which
call them.  As yet only iattr is included, but future patches will
expand this.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c  |   12 ++++++++----
 fs/nfsd/nfs4proc.c  |   17 ++++++++++-------
 fs/nfsd/nfs4state.c |    5 ++++-
 fs/nfsd/nfsproc.c   |   11 +++++++----
 fs/nfsd/vfs.c       |   22 +++++++++++++---------
 fs/nfsd/vfs.h       |   12 ++++++++----
 6 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 981a3a7a6e16..289eb844d086 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -67,12 +67,13 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
 {
 	struct nfsd3_sattrargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = { .iattr = &argp->attrs };
 
 	dprintk("nfsd: SETATTR(3)  %s\n",
 				SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
-	resp->status = nfsd_setattr(rqstp, &resp->fh, &argp->attrs,
+	resp->status = nfsd_setattr(rqstp, &resp->fh, &attrs,
 				    argp->check_guard, argp->guardtime);
 	return rpc_success;
 }
@@ -233,6 +234,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 {
 	struct iattr *iap = &argp->attrs;
 	struct dentry *parent, *child;
+	struct nfsd_attrs attrs = { .iattr = iap };
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status;
@@ -331,7 +333,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 set_attr:
-	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
+	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
 	fh_unlock(fhp);
@@ -368,6 +370,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 {
 	struct nfsd3_createargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = { .iattr = &argp->attrs };
 
 	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -378,7 +381,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
-				   &argp->attrs, S_IFDIR, 0, &resp->fh);
+				   &attrs, S_IFDIR, 0, &resp->fh);
 	fh_unlock(&resp->dirfh);
 	return rpc_success;
 }
@@ -428,6 +431,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 {
 	struct nfsd3_mknodargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres  *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = { .iattr = &argp->attrs };
 	int type;
 	dev_t	rdev = 0;
 
@@ -453,7 +457,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 
 	type = nfs3_ftypes[argp->ftype];
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
-				   &argp->attrs, type, rdev, &resp->fh);
+				   &attrs, type, rdev, &resp->fh);
 	fh_unlock(&resp->dirfh);
 out:
 	return rpc_success;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d57f91fa9f70..ba750d76f515 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -286,6 +286,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct svc_fh *resfhp, struct nfsd4_open *open)
 {
 	struct iattr *iap = &open->op_iattr;
+	struct nfsd_attrs attrs = { .iattr = iap };
 	struct dentry *parent, *child;
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
@@ -404,7 +405,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 set_attr:
-	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
+	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
 	fh_unlock(fhp);
@@ -787,6 +788,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
 	struct nfsd4_create *create = &u->create;
+	struct nfsd_attrs attrs = { .iattr = &create->cr_iattr };
 	struct svc_fh resfh;
 	__be32 status;
 	dev_t rdev;
@@ -818,7 +820,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_umask;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFBLK, rdev, &resfh);
+				     &attrs, S_IFBLK, rdev, &resfh);
 		break;
 
 	case NF4CHR:
@@ -829,26 +831,26 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_umask;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFCHR, rdev, &resfh);
+				     &attrs, S_IFCHR, rdev, &resfh);
 		break;
 
 	case NF4SOCK:
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFSOCK, 0, &resfh);
+				     &attrs, S_IFSOCK, 0, &resfh);
 		break;
 
 	case NF4FIFO:
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFIFO, 0, &resfh);
+				     &attrs, S_IFIFO, 0, &resfh);
 		break;
 
 	case NF4DIR:
 		create->cr_iattr.ia_valid &= ~ATTR_SIZE;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
-				     &create->cr_iattr, S_IFDIR, 0, &resfh);
+				     &attrs, S_IFDIR, 0, &resfh);
 		break;
 
 	default:
@@ -1142,6 +1144,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
 {
 	struct nfsd4_setattr *setattr = &u->setattr;
+	struct nfsd_attrs attrs = { .iattr = &setattr->sa_iattr };
 	__be32 status = nfs_ok;
 	int err;
 
@@ -1174,7 +1177,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&setattr->sa_label);
 	if (status)
 		goto out;
-	status = nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
+	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
 				0, (time64_t)0);
 out:
 	fh_drop_write(&cstate->current_fh);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8f64af3e38d8..c2ca37d0a616 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5060,11 +5060,14 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 		.ia_valid = ATTR_SIZE,
 		.ia_size = 0,
 	};
+	struct nfsd_attrs attrs = {
+		.iattr = &iattr,
+	};
 	if (!open->op_truncate)
 		return 0;
 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
-	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
+	return nfsd_setattr(rqstp, fh, &attrs, 0, (time64_t)0);
 }
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index fcdab8a8a41f..594d6f85c89f 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -51,6 +51,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 	struct nfsd_sattrargs *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	struct iattr *iap = &argp->attrs;
+	struct nfsd_attrs attrs = { .iattr = iap };
 	struct svc_fh *fhp;
 
 	dprintk("nfsd: SETATTR  %s, valid=%x, size=%ld\n",
@@ -100,7 +101,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		}
 	}
 
-	resp->status = nfsd_setattr(rqstp, fhp, iap, 0, (time64_t)0);
+	resp->status = nfsd_setattr(rqstp, fhp, &attrs, 0, (time64_t)0);
 	if (resp->status != nfs_ok)
 		goto out;
 
@@ -260,6 +261,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	svc_fh		*dirfhp = &argp->fh;
 	svc_fh		*newfhp = &resp->fh;
 	struct iattr	*attr = &argp->attrs;
+	struct nfsd_attrs attrs = { .iattr = attr };
 	struct inode	*inode;
 	struct dentry	*dchild;
 	int		type, mode;
@@ -385,7 +387,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	if (!inode) {
 		/* File doesn't exist. Create it and set attrs */
 		resp->status = nfsd_create_locked(rqstp, dirfhp, argp->name,
-						  argp->len, attr, type, rdev,
+						  argp->len, &attrs, type, rdev,
 						  newfhp);
 	} else if (type == S_IFREG) {
 		dprintk("nfsd:   existing %s, valid=%x, size=%ld\n",
@@ -396,7 +398,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		 */
 		attr->ia_valid &= ATTR_SIZE;
 		if (attr->ia_valid)
-			resp->status = nfsd_setattr(rqstp, newfhp, attr, 0,
+			resp->status = nfsd_setattr(rqstp, newfhp, &attrs, 0,
 						    (time64_t)0);
 	}
 
@@ -511,6 +513,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 {
 	struct nfsd_createargs *argp = rqstp->rq_argp;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = { .iattr = &argp->attrs };
 
 	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
@@ -522,7 +525,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_init(&resp->fh, NFS_FHSIZE);
 	resp->status = nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
-				   &argp->attrs, S_IFDIR, 0, &resp->fh);
+				   &attrs, S_IFDIR, 0, &resp->fh);
 	fh_put(&argp->fh);
 	if (resp->status != nfs_ok)
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d79db56475d4..a85dc4dd4f3a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -349,11 +349,13 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * Set various file attributes.  After this call fhp needs an fh_put.
  */
 __be32
-nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
+nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+	     struct nfsd_attrs *attr,
 	     int check_guard, time64_t guardtime)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
+	struct iattr	*iap = attr->iattr;
 	int		accmode = NFSD_MAY_SATTR;
 	umode_t		ftype = 0;
 	__be32		err;
@@ -1208,8 +1210,9 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
  */
 __be32
 nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		    struct svc_fh *resfhp, struct iattr *iap)
+		    struct svc_fh *resfhp, struct nfsd_attrs *attrs)
 {
+	struct iattr *iap = attrs->iattr;
 	__be32 status;
 
 	/*
@@ -1230,7 +1233,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * if the attributes have not changed.
 	 */
 	if (iap->ia_valid)
-		status = nfsd_setattr(rqstp, resfhp, iap, 0, (time64_t)0);
+		status = nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
 	else
 		status = nfserrno(commit_metadata(resfhp));
 
@@ -1269,11 +1272,12 @@ nfsd_check_ignore_resizing(struct iattr *iap)
 /* The parent directory should already be locked: */
 __be32
 nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		char *fname, int flen, struct iattr *iap,
-		int type, dev_t rdev, struct svc_fh *resfhp)
+		   char *fname, int flen, struct nfsd_attrs *attrs,
+		   int type, dev_t rdev, struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dchild;
 	struct inode	*dirp;
+	struct iattr	*iap = attrs->iattr;
 	__be32		err;
 	int		host_err;
 
@@ -1347,7 +1351,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err < 0)
 		goto out_nfserr;
 
-	err = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
+	err = nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 
 out:
 	dput(dchild);
@@ -1366,8 +1370,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		char *fname, int flen, struct iattr *iap,
-		int type, dev_t rdev, struct svc_fh *resfhp)
+	    char *fname, int flen, struct nfsd_attrs *attrs,
+	    int type, dev_t rdev, struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dchild = NULL;
 	__be32		err;
@@ -1399,7 +1403,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dput(dchild);
 	if (err)
 		return err;
-	return nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
+	return nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
 					rdev, resfhp);
 }
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 26347d76f44a..9bb0e3957982 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -42,6 +42,10 @@ struct nfsd_file;
 typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 
 /* nfsd/vfs.c */
+struct nfsd_attrs {
+	struct iattr *iattr;
+};
+
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
@@ -50,7 +54,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
 				const char *, unsigned int,
 				struct svc_export **, struct dentry **);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
-				struct iattr *, int, time64_t);
+				struct nfsd_attrs *, int, time64_t);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);
 #ifdef CONFIG_NFSD_V4
 __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
@@ -63,14 +67,14 @@ __be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
 				       u64 count, bool sync);
 #endif /* CONFIG_NFSD_V4 */
 __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
-				char *name, int len, struct iattr *attrs,
+				char *name, int len, struct nfsd_attrs *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
 __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
-				char *name, int len, struct iattr *attrs,
+				char *name, int len, struct nfsd_attrs *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
 __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
 __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				struct svc_fh *resfhp, struct iattr *iap);
+				struct svc_fh *resfhp, struct nfsd_attrs *iap);
 __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
 				u64 offset, u32 count, __be32 *verf);
 #ifdef CONFIG_NFSD_V4


