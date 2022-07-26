Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7C580BE6
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 08:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiGZGsU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 02:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiGZGsT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 02:48:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158BC220C2
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 23:48:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C66E91F9CE;
        Tue, 26 Jul 2022 06:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658818097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2jRREvVwvuRSJrXKpxQ6St5SyYdjMkTbFXMTV98+gU=;
        b=ApQD6fzYHoMgQAT9Keuqpu/hkXHVdwIc0IcJV14+qKHFZE6hD8T1vlvcvFsLkdxVcw75xN
        1fIiZRIlfQV8GAjmiS3/lMAQUTfMafc4IUpEqYs+PkUXoHycDbBCfENAec/iVsE0YJU4n6
        QHOjCYHUl9sts0DDxrQGHyefzDH6TTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658818097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2jRREvVwvuRSJrXKpxQ6St5SyYdjMkTbFXMTV98+gU=;
        b=S73DqT+uYVVtIpnoP9i1dMkRt+VlTk1/Jbc/uhAmT7LCk5oc7Yqcdb+K1j05/MkROFc7Hr
        DD2BzTz44NehQUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7D4913A7C;
        Tue, 26 Jul 2022 06:48:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id unWbGDCO32LDWAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 06:48:16 +0000
Subject: [PATCH 07/13] NFSD: change nfsd_create()/nfsd_symlink() to unlock
 directory before returning.
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793057.21666.9881237501107008368.stgit@noble.brown>
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

nfsd_create() usually returns with the directory still locked.
nfsd_symlink() usually returns with it unlocked.  This is clumsy.

Until recently nfsd_create() needed to keep the directory locked until
ACLs and security label had been set.  These are now set inside
nfsd_create() (in nfsd_setattr()) so this need is gone.

So change nfsd_create() and nfsd_symlink() to always unlock, and remove
any fh_unlock() calls that follow calls to these functions.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |    2 --
 fs/nfsd/nfs4proc.c |    2 --
 fs/nfsd/vfs.c      |   38 +++++++++++++++++++++-----------------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 5e369096e42f..0060a89997d4 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -382,7 +382,6 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, S_IFDIR, 0, &resp->fh);
-	fh_unlock(&resp->dirfh);
 	return rpc_success;
 }
 
@@ -459,7 +458,6 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	type = nfs3_ftypes[argp->ftype];
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &attrs, type, rdev, &resp->fh);
-	fh_unlock(&resp->dirfh);
 out:
 	return rpc_success;
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c49cd04cb567..915c9457a571 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -823,8 +823,6 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		create->cr_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 	if (attrs.label_failed)
 		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
-
-	fh_unlock(&cstate->current_fh);
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
 out:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4bb05586a258..877331fabae0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1378,8 +1378,10 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	fh_lock_nested(fhp, I_MUTEX_PARENT);
 	dchild = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(dchild);
-	if (IS_ERR(dchild))
-		return nfserrno(host_err);
+	if (IS_ERR(dchild)) {
+		err = nfserrno(host_err);
+		goto out_unlock;
+	}
 	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
 	/*
 	 * We unconditionally drop our ref to dchild as fh_compose will have
@@ -1387,9 +1389,12 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 */
 	dput(dchild);
 	if (err)
-		return err;
-	return nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
-					rdev, resfhp);
+		goto out_unlock;
+	err = nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
+				 rdev, resfhp);
+out_unlock:
+	fh_unlock(fhp);
+	return err;
 }
 
 /*
@@ -1456,16 +1461,19 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out;
 
 	host_err = fh_want_write(fhp);
-	if (host_err)
-		goto out_nfserr;
+	if (host_err) {
+		err = nfserrno(host_err);
+		goto out;
+	}
 
 	fh_lock(fhp);
 	dentry = fhp->fh_dentry;
 	dnew = lookup_one_len(fname, dentry, flen);
-	host_err = PTR_ERR(dnew);
-	if (IS_ERR(dnew))
-		goto out_nfserr;
-
+	if (IS_ERR(dnew)) {
+		err = nfserrno(PTR_ERR(dnew));
+		fh_unlock(fhp);
+		goto out_drop_write;
+	}
 	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
@@ -1474,16 +1482,12 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	fh_unlock(fhp);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
-	fh_drop_write(fhp);
-
 	dput(dnew);
 	if (err==0) err = cerr;
+out_drop_write:
+	fh_drop_write(fhp);
 out:
 	return err;
-
-out_nfserr:
-	err = nfserrno(host_err);
-	goto out;
 }
 
 /*


