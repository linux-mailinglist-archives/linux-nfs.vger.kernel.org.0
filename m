Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37857ECAEF
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Nov 2023 20:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjKOTCV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 14:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjKOTCU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 14:02:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B841A7
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 11:02:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F99CC433C8
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700074936;
        bh=pcGqBYEcZv927P60bgaSDCGjf4eY9PCdOTg1NKfq5ew=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XVRcLmRgnH9LAYXrJmtI0Aj6tE+Awi3qL6j0p4ZsN5rnYgp0HmLcN7CdvLNsk3qvS
         F/ZmlydCU0hYglgZ1jpUZFyM4JhOfOOGPcFtwwujvqvyrqUMn8qY9dIgMy1f4vum98
         4eQ6f+Wb83x58ZVS1FvPEenaEDDoyuwyrHGCHjejEXgvE/WZM73VfX7qNkf/W6wmOD
         Kb5PhPK2RxFwvRIYHn70EYynRIC7lUBx9qhOMwzDAImvsO9HOZ8d0jRij+aXDiRwtF
         SXYbutZjcKsy0JPA4q7uk8TfNxrxBzjlViij8za9Vwk16XCj2b2KNx0wgwyi4O2tYZ
         I9r0sLk6hjyWg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv4.1: if referring calls are complete, trust the stateid argument
Date:   Wed, 15 Nov 2023 13:55:28 -0500
Message-ID: <20231115185529.303842-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115185529.303842-1-trondmy@kernel.org>
References: <20231115185529.303842-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server is recalling a layout, and sends us a list of referring
calls that we can see are complete, then we should just trust that the
stateid argument is correct, even if the sequence id doesn't match the
one we hold.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c | 44 +++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index ebecd1f6409e..c0d16ed3c3c5 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -207,7 +207,8 @@ static struct inode *nfs_layout_find_inode(struct nfs_client *clp,
  * Enforce RFC5661 section 12.5.5.2.1. (Layout Recall and Return Sequencing)
  */
 static u32 pnfs_check_callback_stateid(struct pnfs_layout_hdr *lo,
-					const nfs4_stateid *new)
+					const nfs4_stateid *new,
+					struct cb_process_state *cps)
 {
 	u32 oldseq, newseq;
 
@@ -221,28 +222,29 @@ static u32 pnfs_check_callback_stateid(struct pnfs_layout_hdr *lo,
 
 	newseq = be32_to_cpu(new->seqid);
 	/* Are we already in a layout recall situation? */
-	if (test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags) &&
-	    lo->plh_return_seq != 0) {
-		if (newseq < lo->plh_return_seq)
-			return NFS4ERR_OLD_STATEID;
-		if (newseq > lo->plh_return_seq)
-			return NFS4ERR_DELAY;
-		goto out;
-	}
+	if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags))
+		return NFS4ERR_DELAY;
 
-	/* Check that the stateid matches what we think it should be. */
+	/*
+	 * Check that the stateid matches what we think it should be.
+	 * Note that if the server sent us a list of referring calls,
+	 * and we know that those have completed, then we trust the
+	 * stateid argument is correct.
+	 */
 	oldseq = be32_to_cpu(lo->plh_stateid.seqid);
-	if (newseq > oldseq + 1)
+	if (newseq > oldseq + 1 && !cps->referring_calls)
 		return NFS4ERR_DELAY;
+
 	/* Crazy server! */
 	if (newseq <= oldseq)
 		return NFS4ERR_OLD_STATEID;
-out:
+
 	return NFS_OK;
 }
 
 static u32 initiate_file_draining(struct nfs_client *clp,
-				  struct cb_layoutrecallargs *args)
+				  struct cb_layoutrecallargs *args,
+				  struct cb_process_state *cps)
 {
 	struct inode *ino;
 	struct pnfs_layout_hdr *lo;
@@ -266,7 +268,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 		goto out;
 	}
 	pnfs_get_layout_hdr(lo);
-	rv = pnfs_check_callback_stateid(lo, &args->cbl_stateid);
+	rv = pnfs_check_callback_stateid(lo, &args->cbl_stateid, cps);
 	if (rv != NFS_OK)
 		goto unlock;
 
@@ -326,10 +328,11 @@ static u32 initiate_bulk_draining(struct nfs_client *clp,
 }
 
 static u32 do_callback_layoutrecall(struct nfs_client *clp,
-				    struct cb_layoutrecallargs *args)
+				    struct cb_layoutrecallargs *args,
+				    struct cb_process_state *cps)
 {
 	if (args->cbl_recall_type == RETURN_FILE)
-		return initiate_file_draining(clp, args);
+		return initiate_file_draining(clp, args, cps);
 	return initiate_bulk_draining(clp, args);
 }
 
@@ -340,11 +343,12 @@ __be32 nfs4_callback_layoutrecall(void *argp, void *resp,
 	u32 res = NFS4ERR_OP_NOT_IN_SESSION;
 
 	if (cps->clp)
-		res = do_callback_layoutrecall(cps->clp, args);
+		res = do_callback_layoutrecall(cps->clp, args, cps);
 	return cpu_to_be32(res);
 }
 
-static void pnfs_recall_all_layouts(struct nfs_client *clp)
+static void pnfs_recall_all_layouts(struct nfs_client *clp,
+				    struct cb_process_state *cps)
 {
 	struct cb_layoutrecallargs args;
 
@@ -352,7 +356,7 @@ static void pnfs_recall_all_layouts(struct nfs_client *clp)
 	memset(&args, 0, sizeof(args));
 	args.cbl_recall_type = RETURN_ALL;
 	/* FIXME we ignore errors, what should we do? */
-	do_callback_layoutrecall(clp, &args);
+	do_callback_layoutrecall(clp, &args, cps);
 }
 
 __be32 nfs4_callback_devicenotify(void *argp, void *resp,
@@ -622,7 +626,7 @@ __be32 nfs4_callback_recallany(void *argp, void *resp,
 		nfs_expire_unused_delegation_types(cps->clp, flags);
 
 	if (args->craa_type_mask & BIT(RCA4_TYPE_MASK_FILE_LAYOUT))
-		pnfs_recall_all_layouts(cps->clp);
+		pnfs_recall_all_layouts(cps->clp, cps);
 
 	if (args->craa_type_mask & BIT(PNFS_FF_RCA4_TYPE_MASK_READ)) {
 		set_bit(NFS4CLNT_RECALL_ANY_LAYOUT_READ, &cps->clp->cl_state);
-- 
2.41.0

