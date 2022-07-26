Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD12580BDA
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 08:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiGZGrQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 02:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiGZGrP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 02:47:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D238B7B
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 23:47:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D30E35096;
        Tue, 26 Jul 2022 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658818033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rw62hTRAu7XbTugIIP7Mj6IcYxmutbp33q0qZL62vIA=;
        b=wvjyJ9GZyLifHbTgRcltewQT0viwjqgFY9BiwuhgxBrUrijG9f5cjjvUg03PAE1pU3n55u
        Orn1lN0jaFpJF0xrojVW18Z/YL/aQO7ufYTDr6/tZdzvlcyuzSwtUk6IHPY5Nrs90gscCh
        NatqRkgVDLA6oO4vA8NSy9fXd4Wrh5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658818033;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rw62hTRAu7XbTugIIP7Mj6IcYxmutbp33q0qZL62vIA=;
        b=dATu9pw6YVUjVKAV1x0VbNSEu5RDcBLTTs71i4IqCotNVQhMu0hGPCJ5m7oIvE0Yx4ln1Z
        18SmzHug+BX+pkBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CB7F13A7C;
        Tue, 26 Jul 2022 06:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9qwROu+N32JhWAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 06:47:11 +0000
Subject: [PATCH 02/13] NFSD: verify the opened dentry after setting a
 delegation
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793054.21666.4968784719648129759.stgit@noble.brown>
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

From: Jeff Layton <jlayton@kernel.org>

Between opening a file and setting a delegation on it, someone could
rename or unlink the dentry. If this happens, we do not want to grant a
delegation on the open.

On a CLAIM_NULL open, we're opening by filename, and we may (in the
non-create case) or may not (in the create case) be holding i_rwsem
when attempting to set a delegation.  The latter case allows a
race.

After getting a lease, redo the lookup of the file being opened and
validate that the resulting dentry matches the one in the open file
description.

To properly redo the lookup we need an rqst pointer to pass to
nfsd_lookup_dentry(), so make sure that is available.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4proc.c  |    1 +
 fs/nfsd/nfs4state.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/xdr4.h      |    1 +
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5af9f8d1feb6..d57f91fa9f70 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -547,6 +547,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		open->op_openowner);
 
 	open->op_filp = NULL;
+	open->op_rqstp = rqstp;
 
 	/* This check required by spec. */
 	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 279c7a1502c9..8f64af3e38d8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5288,11 +5288,44 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 	return 0;
 }
 
+/*
+ * It's possible that between opening the dentry and setting the delegation,
+ * that it has been renamed or unlinked. Redo the lookup to verify that this
+ * hasn't happened.
+ */
+static int
+nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
+			  struct svc_fh *parent)
+{
+	struct svc_export *exp;
+	struct dentry *child;
+	__be32 err;
+
+	/* parent may already be locked, and it may get unlocked by
+	 * this call, but that is safe.
+	 */
+	err = nfsd_lookup_dentry(open->op_rqstp, parent,
+				 open->op_fname, open->op_fnamelen,
+				 &exp, &child);
+
+	if (err)
+		return -EAGAIN;
+
+	dput(child);
+	if (child != file_dentry(fp->fi_deleg_file->nf_file))
+		return -EAGAIN;
+
+	return 0;
+}
+
 static struct nfs4_delegation *
-nfs4_set_delegation(struct nfs4_client *clp,
-		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
+nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
+		    struct svc_fh *parent)
 {
 	int status = 0;
+	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct nfs4_file *fp = stp->st_stid.sc_file;
+	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf;
 	struct file_lock *fl;
@@ -5347,6 +5380,13 @@ nfs4_set_delegation(struct nfs4_client *clp,
 		locks_free_lock(fl);
 	if (status)
 		goto out_clnt_odstate;
+
+	if (parent) {
+		status = nfsd4_verify_deleg_dentry(open, fp, parent);
+		if (status)
+			goto out_unlock;
+	}
+
 	status = nfsd4_check_conflicting_opens(clp, fp);
 	if (status)
 		goto out_unlock;
@@ -5402,11 +5442,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
  * proper support for them.
  */
 static void
-nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
+nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
+		     struct svc_fh *currentfh)
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct svc_fh *parent = NULL;
 	int cb_up;
 	int status = 0;
 
@@ -5420,6 +5462,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 				goto out_no_deleg;
 			break;
 		case NFS4_OPEN_CLAIM_NULL:
+			parent = currentfh;
+			fallthrough;
 		case NFS4_OPEN_CLAIM_FH:
 			/*
 			 * Let's not give out any delegations till everyone's
@@ -5434,7 +5478,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 		default:
 			goto out_no_deleg;
 	}
-	dp = nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_odstate);
+	dp = nfs4_set_delegation(open, stp, parent);
 	if (IS_ERR(dp))
 		goto out_no_deleg;
 
@@ -5566,7 +5610,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(open, stp);
+	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
 nodeleg:
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 7b744011f2d3..189f0600dbe8 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -279,6 +279,7 @@ struct nfsd4_open {
 	struct nfs4_clnt_odstate *op_odstate; /* used during processing */
 	struct nfs4_acl *op_acl;
 	struct xdr_netobj op_label;
+	struct svc_rqst *op_rqstp;
 };
 
 struct nfsd4_open_confirm {


