Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28F95835C8
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 01:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiG0XsM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 19:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiG0XsK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 19:48:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC95A3DF
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 16:48:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6CFCF3F5CF;
        Wed, 27 Jul 2022 23:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658965688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YNkvFSTrvxMTheSnBWhbpu28Cp4IEmvxmpesW6Jdus=;
        b=m4oErnVf1xg3L8OgjC5ohmWBLdayuUDA+1cH8stj6xdMa5hHQFIUm+dirsx9MLeZgChE0u
        bO48IFu3foVPJpn+P0c7S3KhXOex4WDVW80xd2C2SUy395lXTbd5T1m67wFkXlAI1g60qO
        LvrgU28DNsH3HPq69DJ6uYsLRlb/oJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658965688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YNkvFSTrvxMTheSnBWhbpu28Cp4IEmvxmpesW6Jdus=;
        b=CtBhq0vNbjVGOkew7dJqI9I8wwZTEShSuYZnBZvAW2TWjs0E87xZPFL04hCFRAbHn/HM/u
        PiZMvv0J/SG+eSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57F3D13A8E;
        Wed, 27 Jul 2022 23:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q3KxBbfO4WJUHQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 27 Jul 2022 23:48:07 +0000
Subject: [PATCH 10/13] NFSD: reduce locking in nfsd_lookup()
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793059.21666.657711087588520392.stgit@noble.brown>
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_lookup() takes an exclusive lock on the parent inode, but no
callers want the lock and it may not be needed at all if the
result is in the dcache.

Change nfsd_lookup_dentry() to not take the lock, and call
lookup_one_len_locked() which takes lock only if needed.

nfsd4_open() currently expects the lock to still be held, but that isn't
necessary as nfsd_validate_delegated_dentry() provides required
guarantees without the lock.

NOTE: NFSv4 requires directory changeinfo for OPEN even when a create
  wasn't requested and no change happened.  Now that nfsd_lookup()
  doesn't use fh_lock(), we need to explicitly fill the attributes
  when no create happens.  A new fh_fill_both_attrs() is provided
  for that task.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4proc.c  |   20 ++++++++++++--------
 fs/nfsd/nfs4state.c |    3 ---
 fs/nfsd/nfsfh.c     |   19 +++++++++++++++++++
 fs/nfsd/nfsfh.h     |    2 +-
 fs/nfsd/vfs.c       |   34 ++++++++++++++--------------------
 5 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 1aa6ae4ec2f5..48e4efb39a9c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -302,6 +302,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (d_really_is_positive(child)) {
 		status = nfs_ok;
 
+		/* NFSv4 protocol requires change attributes even though
+		 * no change happened.
+		 */
+		fh_fill_both_attrs(fhp);
+
 		switch (open->op_createmode) {
 		case NFS4_CREATE_UNCHECKED:
 			if (!d_is_reg(child))
@@ -417,15 +422,15 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		if (nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
 			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
 						FATTR4_WORD1_TIME_MODIFY);
-	} else
-		/*
-		 * Note this may exit with the parent still locked.
-		 * We will hold the lock until nfsd4_open's final
-		 * lookup, to prevent renames or unlinks until we've had
-		 * a chance to an acquire a delegation if appropriate.
-		 */
+	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname, open->op_fnamelen, *resfh);
+		if (!status)
+			/* NFSv4 protocol requires change attributes even though
+			 * no change happened.
+			 */
+			fh_fill_both_attrs(current_fh);
+	}
 	if (status)
 		goto out;
 	status = nfsd_check_obj_isreg(*resfh);
@@ -1043,7 +1048,6 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				    &exp, &dentry);
 	if (err)
 		return err;
-	fh_unlock(&cstate->current_fh);
 	if (d_really_is_negative(dentry)) {
 		exp_put(exp);
 		err = nfserr_noent;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c2ca37d0a616..45df1e85ff32 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5304,9 +5304,6 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 	struct dentry *child;
 	__be32 err;
 
-	/* parent may already be locked, and it may get unlocked by
-	 * this call, but that is safe.
-	 */
 	err = nfsd_lookup_dentry(open->op_rqstp, parent,
 				 open->op_fname, open->op_fnamelen,
 				 &exp, &child);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 5e2ed4b2a925..cd2946a88d72 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -672,6 +672,25 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
 }
 
+/**
+ * fh_fill_both_attrs - Fill pre-op and post-op attributes
+ * @fhp: file handle to be updated
+ *
+ * This is used when the directory wasn't changed, but wcc attributes
+ * are needed anyway.
+ */
+void fh_fill_both_attrs(struct svc_fh *fhp)
+{
+	fh_fill_post_attrs(fhp);
+	if (!fhp->fh_post_saved)
+		return;
+	fhp->fh_pre_change = fhp->fh_post_change;
+	fhp->fh_pre_mtime = fhp->fh_post_attr.mtime;
+	fhp->fh_pre_ctime = fhp->fh_post_attr.ctime;
+	fhp->fh_pre_size = fhp->fh_post_attr.size;
+	fhp->fh_pre_saved = true;
+}
+
 /*
  * Release a file handle.
  */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index fb9d358a267e..28a4f9a94e2c 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -322,7 +322,7 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 
 extern void fh_fill_pre_attrs(struct svc_fh *fhp);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
-
+extern void fh_fill_both_attrs(struct svc_fh *fhp);
 
 /*
  * Lock a file handle/inode
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 06b1408db08b..8ebad4a99552 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -199,27 +199,13 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+		dentry = lookup_one_len_unlocked(name, dparent, len);
 		host_err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_nfserr;
 		if (nfsd_mountpoint(dentry, exp)) {
-			/*
-			 * We don't need the i_mutex after all.  It's
-			 * still possible we could open this (regular
-			 * files can be mountpoints too), but the
-			 * i_mutex is just there to prevent renames of
-			 * something that we might be about to delegate,
-			 * and a mountpoint won't be renamed:
-			 */
-			fh_unlock(fhp);
-			if ((host_err = nfsd_cross_mnt(rqstp, &dentry, &exp))) {
+			host_err = nfsd_cross_mnt(rqstp, &dentry, &exp);
+			if (host_err) {
 				dput(dentry);
 				goto out_nfserr;
 			}
@@ -234,7 +220,15 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+ *
  * Look up one component of a pathname.
  * N.B. After this call _both_ fhp and resfh need an fh_put
  *
@@ -244,11 +238,11 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * returned. Otherwise the covered directory is returned.
  * NOTE: this mountpoint crossing is not supported properly by all
  *   clients and is explicitly disallowed for NFSv3
- *      NeilBrown <neilb@cse.unsw.edu.au>
+ *
  */
 __be32
 nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
-				unsigned int len, struct svc_fh *resfh)
+	    unsigned int len, struct svc_fh *resfh)
 {
 	struct svc_export	*exp;
 	struct dentry		*dentry;


