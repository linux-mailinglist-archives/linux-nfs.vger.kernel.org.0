Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B90C5340A6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 May 2022 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiEYPru (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 May 2022 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbiEYPrt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 May 2022 11:47:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9434649
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 08:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2A52B81C3B
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 15:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D71BC385B8
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 15:47:46 +0000 (UTC)
Subject: [PATCH v3 3/4] NFSD: Add documenting comment for
 nfsd4_release_lockowner()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 25 May 2022 11:47:45 -0400
Message-ID: <165349366542.4205.17071461062540399624.stgit@bazille.1015granger.net>
In-Reply-To: <165349272692.4205.8499763565429173274.stgit@bazille.1015granger.net>
References: <165349272692.4205.8499763565429173274.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

And return explicit nfserr values that match what is documented in the
new comment / API contract.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e2f8b04fca92..9409a0dc1b76 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7524,6 +7524,23 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 	return status;
 }
 
+/**
+ * nfsd4_release_lockowner - process NFSv4.0 RELEASE_LOCKOWNER operations
+ * @rqstp: RPC transaction
+ * @cstate: NFSv4 COMPOUND state
+ * @u: RELEASE_LOCKOWNER arguments
+ *
+ * The lockowner's so_count is bumped when a lock record is added
+ * or when copying a conflicting lock. The latter case is brief,
+ * but can lead to fleeting false positives when looking for
+ * locks-in-use.
+ *
+ * Return values:
+ *   %nfs_ok: lockowner released or not found
+ *   %nfserr_locks_held: lockowner still in use
+ *   %nfserr_stale_clientid: clientid no longer active
+ *   %nfserr_expired: clientid not recognized
+ */
 __be32
 nfsd4_release_lockowner(struct svc_rqst *rqstp,
 			struct nfsd4_compound_state *cstate,
@@ -7550,7 +7567,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	lo = find_lockowner_str_locked(clp, &rlockowner->rl_owner);
 	if (!lo) {
 		spin_unlock(&clp->cl_lock);
-		return status;
+		return nfs_ok;
 	}
 	if (atomic_read(&lo->lo_owner.so_count) != 2) {
 		spin_unlock(&clp->cl_lock);
@@ -7566,11 +7583,11 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
+
 	free_ol_stateid_reaplist(&reaplist);
 	remove_blocked_locks(lo);
 	nfs4_put_stateowner(&lo->lo_owner);
-
-	return status;
+	return nfs_ok;
 }
 
 static inline struct nfs4_client_reclaim *


