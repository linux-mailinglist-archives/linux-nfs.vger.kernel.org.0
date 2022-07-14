Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4637E5751CA
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiGNP21 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 11:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiGNP21 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 11:28:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F79F491D1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 08:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F08E6B82591
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 15:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E516C34115;
        Thu, 14 Jul 2022 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657812503;
        bh=0NqYyetOGEUAnIGbaoMuektCVvnQdJT1Zf1YEgWTtCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHGGHxcQvG6XOniT8Sjuc8aOrjTO8F64vhd1Z6BRP/VXaNPNp22OB2utd/NyXVL9B
         ZGXufSGidqiWp+d4vuBFt9Gzf1pcuv9yvDpf1qPgt/Cd8s5oVNiR7qBZTSKnqmPV3o
         E0PYmV3lEh1Otdzy9uPy/dt+M1xva75xo5Ab23l6UwjTCPNqACgb2cQuzXuX4vkQfD
         /4bPorZ/8xaDFQFvbu84BddsR9CptvR8jG4gv+VsMtNoXoRV2Qh+woZJHwJzGmwmGP
         ll/Kkp8vGlsoOenVbdWk2PyGtmGUoOR9o1Pmuj4/6DaJpnwDGntZDRMcvP/t/0rcty
         YgeNwdvY0lb9A==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [RFC PATCH 3/3] nfsd: vet the opened dentry after setting a delegation
Date:   Thu, 14 Jul 2022 11:28:19 -0400
Message-Id: <20220714152819.128276-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714152819.128276-1-jlayton@kernel.org>
References: <20220714152819.128276-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Between opening a file and setting a delegation on it, someone could
rename or unlink the dentry. If this happens, we do not want to grant a
delegation on the open.

Take the i_rwsem before setting the delegation. If we're granted a
lease, redo the lookup of the file being opened and validate that the
resulting dentry matches the one in the open file description. We only
need to do this for the CLAIM_NULL open case however.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 55 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 347794028c98..e5c7f6690d2d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1172,6 +1172,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 
 void
 nfs4_put_stid(struct nfs4_stid *s)
+	__releases(&clp->cl_lock)
 {
 	struct nfs4_file *fp = s->sc_file;
 	struct nfs4_client *clp = s->sc_client;
@@ -5259,13 +5260,41 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 	return 0;
 }
 
+/*
+ * It's possible that between opening the dentry and setting the delegation,
+ * that it has been renamed or unlinked. Redo the lookup to validate that this
+ * hasn't happened.
+ */
+static int
+nfsd4_vet_deleg_parent(struct nfsd4_open *open, struct nfs4_file *fp, struct dentry *parent)
+{
+	struct dentry *child;
+
+	/* Only need to do this if this is an open-by-name */
+	if (!parent)
+		return 0;
+
+	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
+	if (IS_ERR(child))
+		return PTR_ERR(child);
+	dput(child);
+
+	/* Uh-oh, there has been a rename or unlink of the file. No deleg! */
+	if (child != file_dentry(fp->fi_deleg_file->nf_file))
+		return -EAGAIN;
+
+	return 0;
+}
+
 static struct nfs4_delegation *
-nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
+nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
+		    struct svc_fh *parent_fh)
 {
 	int status = 0;
 	struct nfs4_client *clp = stp->st_stid.sc_client;
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
+	struct dentry *parent = parent_fh ? parent_fh->fh_dentry : NULL;
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf;
 	struct file_lock *fl;
@@ -5315,11 +5344,23 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 	if (!fl)
 		goto out_clnt_odstate;
 
+	if (parent)
+		inode_lock_shared_nested(d_inode(parent), I_MUTEX_PARENT);
 	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NULL);
 	if (fl)
 		locks_free_lock(fl);
-	if (status)
+	if (status) {
+		if (parent)
+			inode_unlock_shared(d_inode(parent));
 		goto out_clnt_odstate;
+	}
+
+	status = nfsd4_vet_deleg_parent(open, fp, parent);
+	if (parent)
+		inode_unlock_shared(d_inode(parent));
+	if (status)
+		goto out_unlock;
+
 	status = nfsd4_check_conflicting_opens(clp, fp);
 	if (status)
 		goto out_unlock;
@@ -5375,11 +5416,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
  * proper support for them.
  */
 static void
-nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
+nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
+		     struct svc_fh *current_fh)
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct svc_fh *parent_fh = NULL;
 	int cb_up;
 	int status = 0;
 
@@ -5393,6 +5436,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 				goto out_no_deleg;
 			break;
 		case NFS4_OPEN_CLAIM_NULL:
+			parent_fh = current_fh;
+			fallthrough;
 		case NFS4_OPEN_CLAIM_FH:
 			/*
 			 * Let's not give out any delegations till everyone's
@@ -5407,7 +5452,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 		default:
 			goto out_no_deleg;
 	}
-	dp = nfs4_set_delegation(open, stp);
+	dp = nfs4_set_delegation(open, stp, parent_fh);
 	if (IS_ERR(dp))
 		goto out_no_deleg;
 
@@ -5539,7 +5584,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(open, stp);
+	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
 nodeleg:
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
-- 
2.36.1

