Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B756002F1
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Oct 2022 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJPSvF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Oct 2022 14:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJPSvE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Oct 2022 14:51:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25A13120D
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 11:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D715B80B40
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 18:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F82C433D6;
        Sun, 16 Oct 2022 18:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665946260;
        bh=HJoOA4lfMzXOBwTJlv5nzdicTEQlDMevIR+sVH0Vs+c=;
        h=From:To:Cc:Subject:Date:From;
        b=OpRSdGTcNNALVORVZI/gYBnVlcOQYD/chSjxGZb8yIzT7at99OSWg4s3rKhKO/TV3
         4Kv8gWm7wq4OB7hGKRmCidEHzGI6TQVWFEyfpqZO+4IYddc0t2mtkInpVvlUvHjdOb
         2AiTkKBp/fqGjJz4q4y+6KZfTbf8LTaualKYelznX7Rz/TRL4LePfKBeFTNNipTqRM
         qkvqozXAin606PsPFedwtyyeYMJaEf8FqcAU0UZtSA316+Q2bSfKpTDyvcu4/xBqQE
         zSZn9DRRXu8zOrZpyb3Sk8RyO2S3rIagkpvfOXYGWHDT8B8u/A5uSBFty5g+HrXwlI
         1s2ryg5Tyge9g==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv4: Fix a potential state reclaim deadlock
Date:   Sun, 16 Oct 2022 14:44:31 -0400
Message-Id: <20221016184433.31213-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server reboots while we are engaged in a delegation return, and
there is a pNFS layout with return-on-close set, then the current code
can end up deadlocking in pnfs_roc() when nfs_inode_set_delegation()
tries to return the old delegation.
Now that delegreturn actually uses its own copy of the stateid, it
should be safe to just always update the delegation stateid in place.

Fixes: 078000d02d57 ("pNFS: We want return-on-close to complete when evicting the inode")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5c97cad741a7..ead8a0e06abf 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -228,8 +228,7 @@ static int nfs_delegation_claim_opens(struct inode *inode,
  *
  */
 void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
-				  fmode_t type,
-				  const nfs4_stateid *stateid,
+				  fmode_t type, const nfs4_stateid *stateid,
 				  unsigned long pagemod_limit)
 {
 	struct nfs_delegation *delegation;
@@ -239,25 +238,24 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
 	if (delegation != NULL) {
 		spin_lock(&delegation->lock);
-		if (nfs4_is_valid_delegation(delegation, 0)) {
-			nfs4_stateid_copy(&delegation->stateid, stateid);
-			delegation->type = type;
-			delegation->pagemod_limit = pagemod_limit;
-			oldcred = delegation->cred;
-			delegation->cred = get_cred(cred);
-			clear_bit(NFS_DELEGATION_NEED_RECLAIM,
-				  &delegation->flags);
-			spin_unlock(&delegation->lock);
-			rcu_read_unlock();
-			put_cred(oldcred);
-			trace_nfs4_reclaim_delegation(inode, type);
-			return;
-		}
-		/* We appear to have raced with a delegation return. */
+		nfs4_stateid_copy(&delegation->stateid, stateid);
+		delegation->type = type;
+		delegation->pagemod_limit = pagemod_limit;
+		oldcred = delegation->cred;
+		delegation->cred = get_cred(cred);
+		clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
+		if (test_and_clear_bit(NFS_DELEGATION_REVOKED,
+				       &delegation->flags))
+			atomic_long_inc(&nfs_active_delegations);
 		spin_unlock(&delegation->lock);
+		rcu_read_unlock();
+		put_cred(oldcred);
+		trace_nfs4_reclaim_delegation(inode, type);
+	} else {
+		rcu_read_unlock();
+		nfs_inode_set_delegation(inode, cred, type, stateid,
+					 pagemod_limit);
 	}
-	rcu_read_unlock();
-	nfs_inode_set_delegation(inode, cred, type, stateid, pagemod_limit);
 }
 
 static int nfs_do_return_delegation(struct inode *inode, struct nfs_delegation *delegation, int issync)
-- 
2.37.3

