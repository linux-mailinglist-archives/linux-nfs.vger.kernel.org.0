Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BA55330C4
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbiEXS51 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 May 2022 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiEXS50 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 May 2022 14:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77D5B3C6
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 11:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07902615D9
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE86C34100
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:57:24 +0000 (UTC)
Subject: [PATCH v2 5/6] NFSD: Add documenting comment for
 nfsd4_release_lockowner()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 24 May 2022 14:57:23 -0400
Message-ID: <165341864331.3187.18446437444560725281.stgit@bazille.1015granger.net>
In-Reply-To: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
References: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
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

And return fixed nfserr values that match what is documented in the
new comment / API contract.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b8e17125fdf1..578a44495d0f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7538,6 +7538,18 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 	return status;
 }
 
+/**
+ * nfsd4_release_lockowner - process NFSv4.0 RELEASE_LOCKOWNER operations
+ * @rqstp: RPC transaction
+ * @cstate: NFSv4 COMPOUND state
+ * @u: RELEASE_LOCKOWNER arguments
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
@@ -7564,7 +7576,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	lo = find_lockowner_str_locked(clp, &rlockowner->rl_owner);
 	if (!lo) {
 		spin_unlock(&clp->cl_lock);
-		return status;
+		return nfs_ok;
 	}
 	trace_printk("lo=%p lockcnt=%d so_count=%d\n",
 		lo, atomic_read(&lo->lo_lockcnt), atomic_read(&lo->lo_owner.so_count));
@@ -7582,11 +7594,11 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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


