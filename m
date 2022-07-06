Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A72567D0F
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 06:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGFEUx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 00:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiGFEUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 00:20:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED48272C
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jul 2022 21:20:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C2681F8B6;
        Wed,  6 Jul 2022 04:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657081250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1a8yo+4tfdZ9zOZuai3dvqhEuaLma88FnlthRvqO+U=;
        b=vHYFeqPTRrzhalOl7DhOkDXUwAsIzIrrf3HGrMf9wrTqpN/hnCWHdLIcudGKD4+BPHXGLj
        c0659OkVbhP6ZisviRbG2UxmwsotP0JMYVIgNQVQcBQTawtIWE6dyYpwmTwdRnYOLLhf3j
        8cWp3e6YAKbz30Q0sl+SwtxbGaAtVfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657081250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1a8yo+4tfdZ9zOZuai3dvqhEuaLma88FnlthRvqO+U=;
        b=F/lqcC2Ih4ZWI/W2yk6dTx+oGlJsVp3Wi5M8oKVr0KLYPr2DWqSIp+auzSvmNLPypXNx32
        CGlBS+VJ3pbYqsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D37E913A37;
        Wed,  6 Jul 2022 04:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4OyJI6ANxWL4QQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Jul 2022 04:20:48 +0000
Subject: [PATCH 5/8] NFSD: reduce locking in nfsd_lookup()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 14:18:12 +1000
Message-ID: <165708109258.1940.1095066282860556838.stgit@noble.brown>
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

nfsd_lookup() takes an exclusive lock on the parent inode, but many
callers don't want the lock and may not need to lock at all if the
result is in the dcache.

Change nfsd_lookup() to be passed a bool flag.
If false, don't take the lock.
If true, do take an exclusive lock, and return with it held if
successful.
If nfsd_lookup() returns an error, the lock WILL NOT be held.

Only nfsd4_open() requests the lock to be held, and does so to block
rename until it decides whether to return a delegation.

NOTE: when nfsd4_open() creates a file, the directory does *NOT* remain
  locked and never has.  So it is possible (though unlikely) for the
  newly created file to be renamed before a delegation is handed out,
  and that would be bad.  This patch does *NOT* fix that, but *DOES*
  take the directory lock immediately after creating the file, which
  reduces the size of the window and ensure that the lock is held
  consistently.  More work is needed to guarantee no rename happens
  before the delegation.

NOTE-2: NFSv4 requires directory changeinfo for OPEN even when a create
  wasn't requested and no change happened.  Now that nfsd_lookup()
  doesn't use fh_lock(), we need explicit fh_fill_pre/post_attrs()
  in the non-create branch of do_open_lookup().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |    2 +-
 fs/nfsd/nfs4proc.c |   51 ++++++++++++++++++++++++++++------------
 fs/nfsd/nfsproc.c  |    2 +-
 fs/nfsd/vfs.c      |   66 +++++++++++++++++++++++++++++++++++-----------------
 fs/nfsd/vfs.h      |    8 ++++--
 5 files changed, 88 insertions(+), 41 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index ad7941001106..3a67d0afb885 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -96,7 +96,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 
 	resp->status = nfsd_lookup(rqstp, &resp->dirfh,
 				   argp->name, argp->len,
-				   &resp->fh);
+				   &resp->fh, false);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4737019738ab..6ec22c69cbec 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -414,7 +414,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 
 static __be32
-do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh **resfh)
+do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	       struct nfsd4_open *open, struct svc_fh **resfh)
 {
 	struct svc_fh *current_fh = &cstate->current_fh;
 	int accmode;
@@ -441,11 +442,18 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		 * yes          | no     | GUARDED4        | GUARDED4
 		 * yes          | yes    | GUARDED4        | GUARDED4
 		 */
-
 		current->fs->umask = open->op_umask;
 		status = nfsd4_create_file(rqstp, current_fh, *resfh, open);
 		current->fs->umask = 0;
 
+		if (!status)
+			/* We really want to hold the lock from before the
+			 * create to ensure no rename happens, but that
+			 * needs more work...
+			 */
+			inode_lock_nested(current_fh->fh_dentry->d_inode,
+					  I_MUTEX_PARENT);
+
 		if (!status && open->op_label.len)
 			nfsd4_security_inode_setsecctx(*resfh, &open->op_label, open->op_bmval);
 
@@ -457,17 +465,25 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		if (nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
 			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
 						FATTR4_WORD1_TIME_MODIFY);
-	} else
-		/*
-		 * Note this may exit with the parent still locked.
-		 * We will hold the lock until nfsd4_open's final
-		 * lookup, to prevent renames or unlinks until we've had
-		 * a chance to an acquire a delegation if appropriate.
+	} else {
+		/* We want to keep the directory locked until we've had a chance
+		 * to acquire a delegation if appropriate, so request that
+		 * nfsd_lookup() hold on to the lock.
 		 */
 		status = nfsd_lookup(rqstp, current_fh,
-				     open->op_fname, open->op_fnamelen, *resfh);
+				     open->op_fname, open->op_fnamelen, *resfh,
+				     true);
+		if (!status) {
+			/* NFSv4 protocol requires change attributes even though
+			 * no change happened.
+			 */
+			fh_fill_pre_attrs(current_fh);
+			fh_fill_post_attrs(current_fh);
+		}
+	}
 	if (status)
-		goto out;
+		return status;
+
 	status = nfsd_check_obj_isreg(*resfh);
 	if (status)
 		goto out;
@@ -483,6 +499,8 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 	status = do_open_permission(rqstp, *resfh, open, accmode);
 	set_change_info(&open->op_cinfo, current_fh);
 out:
+	if (status)
+		inode_unlock(current_fh->fh_dentry->d_inode);
 	return status;
 }
 
@@ -540,6 +558,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	bool reclaim = false;
+	bool locked = false;
 
 	dprintk("NFSD: nfsd4_open filename %.*s op_openowner %p\n",
 		(int)open->op_fnamelen, open->op_fname,
@@ -604,6 +623,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = do_open_lookup(rqstp, cstate, open, &resfh);
 		if (status)
 			goto out;
+		locked = true;
 		break;
 	case NFS4_OPEN_CLAIM_PREVIOUS:
 		status = nfs4_check_open_reclaim(cstate->clp);
@@ -639,6 +659,8 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		fput(open->op_filp);
 		open->op_filp = NULL;
 	}
+	if (locked)
+		inode_unlock(cstate->current_fh.fh_dentry->d_inode);
 	if (resfh && resfh != &cstate->current_fh) {
 		fh_dup2(&cstate->current_fh, resfh);
 		fh_put(resfh);
@@ -933,7 +955,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 		return nfserr_noent;
 	}
 	fh_put(&tmp_fh);
-	return nfsd_lookup(rqstp, fh, "..", 2, fh);
+	return nfsd_lookup(rqstp, fh, "..", 2, fh, false);
 }
 
 static __be32
@@ -949,7 +971,7 @@ nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	return nfsd_lookup(rqstp, &cstate->current_fh,
 			   u->lookup.lo_name, u->lookup.lo_len,
-			   &cstate->current_fh);
+			   &cstate->current_fh, false);
 }
 
 static __be32
@@ -1089,11 +1111,10 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (err)
 		return err;
 	err = nfsd_lookup_dentry(rqstp, &cstate->current_fh,
-				    secinfo->si_name, secinfo->si_namelen,
-				    &exp, &dentry);
+				 secinfo->si_name, secinfo->si_namelen,
+				 &exp, &dentry, false);
 	if (err)
 		return err;
-	fh_unlock(&cstate->current_fh);
 	if (d_really_is_negative(dentry)) {
 		exp_put(exp);
 		err = nfserr_noent;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index a25b8e321662..ed24fae09517 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -133,7 +133,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 
 	fh_init(&resp->fh, NFS_FHSIZE);
 	resp->status = nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
-				   &resp->fh);
+				   &resp->fh, false);
 	fh_put(&argp->fh);
 	if (resp->status != nfs_ok)
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4916c29af0fa..8e050c6d112a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -172,7 +172,8 @@ int nfsd_mountpoint(struct dentry *dentry, struct svc_export *exp)
 __be32
 nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		   const char *name, unsigned int len,
-		   struct svc_export **exp_ret, struct dentry **dentry_ret)
+		   struct svc_export **exp_ret, struct dentry **dentry_ret,
+		   bool locked)
 {
 	struct svc_export	*exp;
 	struct dentry		*dparent;
@@ -199,27 +200,31 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				goto out_nfserr;
 		}
 	} else {
-		/*
-		 * In the nfsd4_open() case, this may be held across
-		 * subsequent open and delegation acquisition which may
-		 * need to take the child's i_mutex:
-		 */
-		fh_lock_nested(fhp, I_MUTEX_PARENT);
-		dentry = lookup_one_len(name, dparent, len);
+		if (locked)
+			dentry = lookup_one_len(name, dparent, len);
+		else
+			dentry = lookup_one_len_unlocked(name, dparent, len);
 		host_err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_nfserr;
 		if (nfsd_mountpoint(dentry, exp)) {
 			/*
-			 * We don't need the i_mutex after all.  It's
-			 * still possible we could open this (regular
-			 * files can be mountpoints too), but the
-			 * i_mutex is just there to prevent renames of
-			 * something that we might be about to delegate,
-			 * and a mountpoint won't be renamed:
+			 * nfsd_cross_mnt() may wait for an upcall
+			 * to userspace, and holding i_sem across that
+			 * invites the possibility of a deadlock.
+			 * We don't really need the lock on the parent
+			 * of a mount point was we only need it to guard
+			 * against a rename before we get a lease for a
+			 * delegation.
+			 * So just drop the i_sem and reclaim it.
 			 */
-			fh_unlock(fhp);
-			if ((host_err = nfsd_cross_mnt(rqstp, &dentry, &exp))) {
+			if (locked)
+				inode_unlock(dparent->d_inode);
+			host_err = nfsd_cross_mnt(rqstp, &dentry, &exp);
+			if (locked)
+				inode_lock_nested(dparent->d_inode,
+						  I_MUTEX_PARENT);
+			if (host_err) {
 				dput(dentry);
 				goto out_nfserr;
 			}
@@ -234,7 +239,17 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfserrno(host_err);
 }
 
-/*
+/**
+ * nfsd_lookup - look up a single path component for nfsd
+ *
+ * @rqstp:   the request context
+ * @ftp:     the file handle of the directory
+ * @name:    the component name, or %NULL to look up parent
+ * @len:     length of name to examine
+ * @resfh:   pointer to pre-initialised filehandle to hold result.
+ * @lock:    if true, lock directory during lookup and keep it locked
+ *           if there is no error.
+ *
  * Look up one component of a pathname.
  * N.B. After this call _both_ fhp and resfh need an fh_put
  *
@@ -244,11 +259,15 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * returned. Otherwise the covered directory is returned.
  * NOTE: this mountpoint crossing is not supported properly by all
  *   clients and is explicitly disallowed for NFSv3
- *      NeilBrown <neilb@cse.unsw.edu.au>
+ *
+ * Only nfsd4_open() calls this with @lock set.  It does so to block
+ * renames/unlinks before it possibly gets a lease to provide a
+ * delegation.
  */
 __be32
 nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
-				unsigned int len, struct svc_fh *resfh)
+	    unsigned int len, struct svc_fh *resfh,
+	    bool lock)
 {
 	struct svc_export	*exp;
 	struct dentry		*dentry;
@@ -257,9 +276,11 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (err)
 		return err;
-	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
+	if (lock)
+		inode_lock_nested(fhp->fh_dentry->d_inode, I_MUTEX_PARENT);
+	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry, lock);
 	if (err)
-		return err;
+		goto out_err;
 	err = check_nfsd_access(exp, rqstp);
 	if (err)
 		goto out;
@@ -273,6 +294,9 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 out:
 	dput(dentry);
 	exp_put(exp);
+out_err:
+	if (err && lock)
+		inode_unlock(fhp->fh_dentry->d_inode);
 	return err;
 }
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 9f4fd3060200..290788f007d4 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -45,10 +45,12 @@ typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
-				const char *, unsigned int, struct svc_fh *);
+			    const char *, unsigned int, struct svc_fh *,
+			    bool);
 __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
-				const char *, unsigned int,
-				struct svc_export **, struct dentry **);
+				    const char *, unsigned int,
+				    struct svc_export **, struct dentry **,
+				    bool);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
 				struct iattr *, int, time64_t);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);


