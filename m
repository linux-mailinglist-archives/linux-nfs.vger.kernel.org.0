Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6BD580BE2
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 08:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiGZGry (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiGZGrx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 02:47:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ECA20BD6
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 23:47:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4A24835256;
        Tue, 26 Jul 2022 06:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658818071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKNmZHuaXwOGBl8UHV0gSRNeYPTRNM3HFwclkK2eFd8=;
        b=O3AuS2/1zedkN95tH8kapzh2ita5YSmaT5d68Jp6Qv+4za5gtTgBV8XMEm7I0E/3HDjVpU
        xT5uQ0wn51A3Gf9bhVzTEDWUfNsb/Je5DxkO/eGsASuhi2DLyx39JcoaSxPof9y26BWi6b
        xwe+dWNX+7qPvwlGKdVtFvbujZR+ojc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658818071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKNmZHuaXwOGBl8UHV0gSRNeYPTRNM3HFwclkK2eFd8=;
        b=PNDLGmzXQC6CrIN8XxaFQB7/K8lvOpKgAcSNVtfKgCxcaCBvpV73gJCzSL1s0bPBugZncF
        V0QH8fgyLfHpV3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29B4313A7C;
        Tue, 26 Jul 2022 06:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hd15NRWO32KfWAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 06:47:49 +0000
Subject: [PATCH 04/13] NFSD: set attributes when creating symlinks
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793056.21666.12904500892707412393.stgit@noble.brown>
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

The NFS protocol includes attributes when creating symlinks.
Linux does store attributes for symlinks and allows them to be set,
though they are not used for permission checking.

NFSD currently doesn't set standard (struct iattr) attributes when
creating symlinks, but for NFSv4 it does set ACLs and security labels.
This is inconsistent.

To improve consistency, pass the provided attributes into nfsd_symlink()
and call nfsd_create_setattr() to set them.

We ignore any error from nfsd_create_setattr().  It isn't really clear
what should be done if a file is successfully created, but the
attributes cannot be set.  NFS doesn't allow partial success to be
reported.  Reporting failure is probably more misleading than reporting
success, so the status is ignored.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |    3 ++-
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/nfsproc.c  |    3 ++-
 fs/nfsd/vfs.c      |   11 ++++++-----
 fs/nfsd/vfs.h      |    5 +++--
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 289eb844d086..5e369096e42f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -391,6 +391,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 {
 	struct nfsd3_symlinkargs *argp = rqstp->rq_argp;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = { .iattr = &argp->attrs };
 
 	if (argp->tlen == 0) {
 		resp->status = nfserr_inval;
@@ -417,7 +418,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 	fh_copy(&resp->dirfh, &argp->ffh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
-				    argp->flen, argp->tname, &resp->fh);
+				    argp->flen, argp->tname, &attrs, &resp->fh);
 	kfree(argp->tname);
 out:
 	return rpc_success;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ba750d76f515..ee72c94732f0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -809,7 +809,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	case NF4LNK:
 		status = nfsd_symlink(rqstp, &cstate->current_fh,
 				      create->cr_name, create->cr_namelen,
-				      create->cr_data, &resfh);
+				      create->cr_data, &attrs, &resfh);
 		break;
 
 	case NF4BLK:
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 594d6f85c89f..d09d516188d2 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -474,6 +474,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 {
 	struct nfsd_symlinkargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
+	struct nfsd_attrs attrs = { .iattr = &argp->attrs };
 	struct svc_fh	newfh;
 
 	if (argp->tlen > NFS_MAXPATHLEN) {
@@ -495,7 +496,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 
 	fh_init(&newfh, NFS_FHSIZE);
 	resp->status = nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
-				    argp->tname, &newfh);
+				    argp->tname, &attrs, &newfh);
 
 	kfree(argp->tname);
 	fh_put(&argp->ffh);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a85dc4dd4f3a..91c9ea09f921 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1451,9 +1451,9 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh *fhp, char *buf, int *lenp)
  */
 __be32
 nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				char *fname, int flen,
-				char *path,
-				struct svc_fh *resfhp)
+	     char *fname, int flen,
+	     char *path, struct nfsd_attrs *attrs,
+	     struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dnew;
 	__be32		err, cerr;
@@ -1483,13 +1483,14 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
+	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
+	if (!err)
+		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_unlock(fhp);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
-
 	fh_drop_write(fhp);
 
-	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	dput(dnew);
 	if (err==0) err = cerr;
 out:
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 9bb0e3957982..f3f43ca3ac6b 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -114,8 +114,9 @@ __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
 __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
-				char *name, int len, char *path,
-				struct svc_fh *res);
+			     char *name, int len, char *path,
+			     struct nfsd_attrs *attrs,
+			     struct svc_fh *res);
 __be32		nfsd_link(struct svc_rqst *, struct svc_fh *,
 				char *, int, struct svc_fh *);
 ssize_t		nfsd_copy_file_range(struct file *, u64,


