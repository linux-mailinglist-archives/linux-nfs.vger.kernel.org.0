Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E501575621
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiGNUEl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 16:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiGNUEj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 16:04:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7726B46DB8
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 13:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0361B6221B
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 20:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A964C34115;
        Thu, 14 Jul 2022 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657829077;
        bh=ZBokBBWVnSkst341i6kaq8Hiu+DHPq2Y0Y06wUBukvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSylfhlrAg/JeNZXQ+TEHVOr2MMYW+1fTBxbl186BAJUBxCqnhlfhNpHq+tHLOnhV
         PN85siOwE7DN5r6Hhe2QdaSizSTWfE85M/zMtFPr/hOAWWDEV5zFiYZ0H5cD/qDI8g
         3wh9cPwLb2dfyfStkkm0loGY+sIciUj5YZCmQkEkEsny3Fw1snvM3uUW0rq7ljsQ/+
         c54u36Jv1y10wLGmar8IReB42zXy5bpztd4yM0Eh8Z5ke5OjcWoMeQSNWtZqW0gYn4
         QyroysijX5RmbKdg2ZcksQcUmoSTS/OvAKNv+mWwM/hq9Mgy8UkJyELny4ScXUZvZL
         7Z+8MHqwtG/vA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: vet the opened dentry after setting a delegation
Date:   Thu, 14 Jul 2022 16:04:34 -0400
Message-Id: <20220714200434.161818-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714200434.161818-1-jlayton@kernel.org>
References: <20220714200434.161818-1-jlayton@kernel.org>
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

On a CLAIM_NULL open, we're opening by filename, and we'll hold the
i_rwsem while when attempting to set a delegation. After getting a
lease, redo the lookup of the file being opened and validate that the
resulting dentry matches the one in the open file description.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 48 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d2d21fdf5c41..8a8d8c738950 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5267,11 +5267,38 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 	return 0;
 }
 
+/*
+ * It's possible that between opening the dentry and setting the delegation,
+ * that it has been renamed or unlinked. Redo the lookup to validate that this
+ * hasn't happened.
+ */
+static int
+nfsd4_vet_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
+		       struct dentry *parent)
+{
+	struct dentry *child;
+
+	lockdep_assert_held(&d_inode(parent)->i_rwsem);
+
+	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
+	if (IS_ERR(child))
+		return PTR_ERR(child);
+	dput(child);
+
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
+		    struct dentry *parent)
 {
 	int status = 0;
+	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct nfs4_file *fp = stp->st_stid.sc_file;
+	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf;
 	struct file_lock *fl;
@@ -5326,6 +5353,13 @@ nfs4_set_delegation(struct nfs4_client *clp,
 		locks_free_lock(fl);
 	if (status)
 		goto out_clnt_odstate;
+
+	if (parent) {
+		status = nfsd4_vet_deleg_dentry(open, fp, parent);
+		if (status)
+			goto out_unlock;
+	}
+
 	status = nfsd4_check_conflicting_opens(clp, fp);
 	if (status)
 		goto out_unlock;
@@ -5381,11 +5415,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
  * proper support for them.
  */
 static void
-nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
+nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
+		     struct dentry *cdentry)
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
 	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct dentry *parent = NULL;
 	int cb_up;
 	int status = 0;
 
@@ -5399,6 +5435,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 				goto out_no_deleg;
 			break;
 		case NFS4_OPEN_CLAIM_NULL:
+			parent = cdentry;
+			fallthrough;
 		case NFS4_OPEN_CLAIM_FH:
 			/*
 			 * Let's not give out any delegations till everyone's
@@ -5413,7 +5451,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 		default:
 			goto out_no_deleg;
 	}
-	dp = nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_odstate);
+	dp = nfs4_set_delegation(open, stp, parent);
 	if (IS_ERR(dp))
 		goto out_no_deleg;
 
@@ -5545,7 +5583,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(open, stp);
+	nfs4_open_delegation(open, stp, resp->cstate.current_fh.fh_dentry);
 nodeleg:
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
-- 
2.36.1

