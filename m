Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558FD580BE5
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 08:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbiGZGsN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 02:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiGZGsI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 02:48:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CE222B0D
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 23:48:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E66DD35256;
        Tue, 26 Jul 2022 06:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658818085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGnfFj+8AXndKxyXof/oBQmKBe0zcbDiP3wU0y21Nd0=;
        b=ke50GTXrMXd6xB3RUJJabY8np8vVY62CGFKwZMXhuu83wWEJQAqpnOO5ilW0Do+CTqcH6J
        Sa/ppublbYcoeW8qU9A/fiH8VRAsZDE2hUI5/yE1scY0ExQUV6/UEYNqKTWqBf8iC2olaH
        LedUrrS3/rYQ+XJCDf/4jKrRm7gxLyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658818085;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGnfFj+8AXndKxyXof/oBQmKBe0zcbDiP3wU0y21Nd0=;
        b=20R5s8I045MLELEyTlm/RB/vjgIeyHGAr3/9for7Ml8JiJASXa8cRH13J+JW241CtMiIXx
        9QvdUa8t/WsHOtBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD2E713A7C;
        Tue, 26 Jul 2022 06:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tjO2ISOO32KzWAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 06:48:03 +0000
Subject: [PATCH 06/13] NFSD: add posix ACLs to struct nfsd_attrs
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793057.21666.7472233362797480106.stgit@noble.brown>
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

pacl and dpacl pointers are added to struct nfsd_attrs, which requires
that we have an nfsd_attrs_free() function to free them.
Those nfsv4 functions that can set ACLs now set up these pointers
based on the passed in NFSv4 ACL.

nfsd_setattr() sets the acls as appropriate.

Errors are handled as with security labels.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/acl.h      |    6 ++++--
 fs/nfsd/nfs4acl.c  |   46 +++++++---------------------------------------
 fs/nfsd/nfs4proc.c |   46 ++++++++++++++++------------------------------
 fs/nfsd/vfs.c      |    8 ++++++++
 fs/nfsd/vfs.h      |   10 ++++++++++
 5 files changed, 45 insertions(+), 71 deletions(-)

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index ba14d2f4b64f..4b7324458a94 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -38,6 +38,8 @@
 struct nfs4_acl;
 struct svc_fh;
 struct svc_rqst;
+struct nfsd_attrs;
+enum nfs_ftype4;
 
 int nfs4_acl_bytes(int entries);
 int nfs4_acl_get_whotype(char *, u32);
@@ -45,7 +47,7 @@ __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int who);
 
 int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 		struct nfs4_acl **acl);
-__be32 nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		struct nfs4_acl *acl);
+__be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
+			 struct nfsd_attrs *attr);
 
 #endif /* LINUX_NFS4_ACL_H */
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index eaa3a0cf38f1..8a5b847b6c73 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -751,58 +751,26 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 	return ret;
 }
 
-__be32
-nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		struct nfs4_acl *acl)
+__be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
+			 struct nfsd_attrs *attr)
 {
-	__be32 error;
 	int host_error;
-	struct dentry *dentry;
-	struct inode *inode;
-	struct posix_acl *pacl = NULL, *dpacl = NULL;
 	unsigned int flags = 0;
 
-	/* Get inode */
-	error = fh_verify(rqstp, fhp, 0, NFSD_MAY_SATTR);
-	if (error)
-		return error;
-
-	dentry = fhp->fh_dentry;
-	inode = d_inode(dentry);
+	if (!acl)
+		return nfs_ok;
 
-	if (S_ISDIR(inode->i_mode))
+	if (type == NF4DIR)
 		flags = NFS4_ACL_DIR;
 
-	host_error = nfs4_acl_nfsv4_to_posix(acl, &pacl, &dpacl, flags);
+	host_error = nfs4_acl_nfsv4_to_posix(acl, &attr->pacl, &attr->dpacl,
+					     flags);
 	if (host_error == -EINVAL)
 		return nfserr_attrnotsupp;
-	if (host_error < 0)
-		goto out_nfserr;
-
-	fh_lock(fhp);
-
-	host_error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pacl);
-	if (host_error < 0)
-		goto out_drop_lock;
-
-	if (S_ISDIR(inode->i_mode)) {
-		host_error = set_posix_acl(&init_user_ns, inode,
-					   ACL_TYPE_DEFAULT, dpacl);
-	}
-
-out_drop_lock:
-	fh_unlock(fhp);
-
-	posix_acl_release(pacl);
-	posix_acl_release(dpacl);
-out_nfserr:
-	if (host_error == -EOPNOTSUPP)
-		return nfserr_attrnotsupp;
 	else
 		return nfserrno(host_error);
 }
 
-
 static short
 ace2type(struct nfs4_ace *ace)
 {
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 83d2b645b0d6..c49cd04cb567 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -128,26 +128,6 @@ is_create_with_attrs(struct nfsd4_open *open)
 		    || open->op_createmode == NFS4_CREATE_EXCLUSIVE4_1);
 }
 
-/*
- * if error occurs when setting the acl, just clear the acl bit
- * in the returned attr bitmap.
- */
-static void
-do_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		struct nfs4_acl *acl, u32 *bmval)
-{
-	__be32 status;
-
-	status = nfsd4_set_nfs4_acl(rqstp, fhp, acl);
-	if (status)
-		/*
-		 * We should probably fail the whole open at this point,
-		 * but we've already created the file, so it's too late;
-		 * So this seems the least of evils:
-		 */
-		bmval[0] &= ~FATTR4_WORD0_ACL;
-}
-
 static inline void
 fh_dup2(struct svc_fh *dst, struct svc_fh *src)
 {
@@ -281,6 +261,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
+	if (is_create_with_attrs(open))
+		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
+
 	fh_lock_nested(fhp, I_MUTEX_PARENT);
 
 	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
@@ -382,8 +365,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	if (attrs.label_failed)
 		open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+	if (attrs.acl_failed)
+		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
 	fh_unlock(fhp);
+	nfsd_attrs_free(&attrs);
 	if (child && !IS_ERR(child))
 		dput(child);
 	fh_drop_write(fhp);
@@ -446,9 +432,6 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	if (status)
 		goto out;
 
-	if (is_create_with_attrs(open) && open->op_acl != NULL)
-		do_set_nfs4_acl(rqstp, *resfh, open->op_acl, open->op_bmval);
-
 	nfsd4_set_open_owner_reply_cache(cstate, open, *resfh);
 	accmode = NFSD_MAY_NOP;
 	if (open->op_created ||
@@ -779,6 +762,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		return status;
 
+	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {
 	case NF4LNK:
@@ -837,10 +821,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (attrs.label_failed)
 		create->cr_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-
-	if (create->cr_acl != NULL)
-		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
-				create->cr_bmval);
+	if (attrs.label_failed)
+		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
 
 	fh_unlock(&cstate->current_fh);
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
@@ -849,6 +831,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+	nfsd_attrs_free(&attrs);
 	return status;
 }
 
@@ -1123,6 +1106,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		.iattr = &setattr->sa_iattr,
 		.label = &setattr->sa_label,
 	};
+	struct inode *inode;
 	__be32 status = nfs_ok;
 	int err;
 
@@ -1145,9 +1129,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 
-	if (setattr->sa_acl != NULL)
-		status = nfsd4_set_nfs4_acl(rqstp, &cstate->current_fh,
-					    setattr->sa_acl);
+	inode = cstate->current_fh.fh_dentry->d_inode;
+	status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
+				   setattr->sa_acl, &attrs);
+
 	if (status)
 		goto out;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
@@ -1155,6 +1140,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (!status)
 		status = attrs.label_failed;
 out:
+	nfsd_attrs_free(&attrs);
 	fh_drop_write(&cstate->current_fh);
 	return status;
 }
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e7a18bedf499..4bb05586a258 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -461,6 +461,14 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attr->label && attr->label->len)
 		attr->label_failed = security_inode_setsecctx(
 			dentry, attr->label->data, attr->label->len);
+	if (attr->pacl)
+		attr->acl_failed = set_posix_acl(&init_user_ns,
+						 inode, ACL_TYPE_ACCESS,
+						 attr->pacl);
+	if (!attr->acl_failed && attr->dpacl && S_ISDIR(inode->i_mode))
+		attr->acl_failed = set_posix_acl(&init_user_ns,
+						 inode, ACL_TYPE_DEFAULT,
+						 attr->dpacl);
 	fh_unlock(fhp);
 	if (size_change)
 		put_write_access(inode);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 8464e04af1ea..9343aac0bd15 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -6,6 +6,8 @@
 #ifndef LINUX_NFSD_VFS_H
 #define LINUX_NFSD_VFS_H
 
+#include <linux/fs.h>
+#include <linux/posix_acl.h>
 #include "nfsfh.h"
 #include "nfsd.h"
 
@@ -45,9 +47,17 @@ typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 struct nfsd_attrs {
 	struct iattr *iattr;
 	struct xdr_netobj *label;
+	struct posix_acl *pacl, *dpacl;
 	int label_failed;
+	int acl_failed;
 };
 
+static inline void nfsd_attrs_free(struct nfsd_attrs *attrs)
+{
+	posix_acl_release(attrs->pacl);
+	posix_acl_release(attrs->dpacl);
+}
+
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,


