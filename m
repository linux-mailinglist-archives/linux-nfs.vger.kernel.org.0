Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39415F143A
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiI3U4J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiI3U4F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 16:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607752838
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 13:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82DFF6242A
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 20:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A177AC433D6;
        Fri, 30 Sep 2022 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664571364;
        bh=oO1vgIBI9d4H7jLBw3fHneP7pnmGJmPWRx+p2kK3qLM=;
        h=From:To:Cc:Subject:Date:From;
        b=eX6V3rcLxQE6/kWHpFsbKqse8tRtm1BY5GC2qY2awV7T6KiPp6R21rL7cgmZR9o1/
         pdWIydfvrtNam2BQszFEXd7jorygJeZ01u/b6WorGtiHcE78QG0AjoNviD778TXOcg
         urYPFRkH+TCMzldQORz3M/YxsGk8IkIWpz5P2eDY3SOMeKllFCUYQ5W586WetCwpl/
         RCVp5F/17UmZVYJ4ETqytf4DIrfwh5rHzAXrB8k2EOl+OHywV/ZrnidWvKyoUQnD03
         K1F5c+/qetH1IpOaiHJkZ1wGDy1a5c7R0Vot2nn8OcKje9HKdbwKiFO7GCyOXCLNLG
         BOrFYGKrTGw0w==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: fix nfsd_file_unhash_and_dispose
Date:   Fri, 30 Sep 2022 16:56:02 -0400
Message-Id: <20220930205602.180271-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This function is called two reasons:

We're either shutting down and purging the filecache, or we've gotten a
notification about a file delete, so we want to go ahead and unhash it
so that it'll get cleaned up when we close.

We're either walking the hashtable or doing a lookup in it and we
don't take a reference in either case. What we want to do in both cases
is to try and unhash the object and put it on the dispose list if that
was successful. If it's no longer hashed, then we don't want to touch
it, with the assumption being that something else is already cleaning
up the sentinel reference.

Instead of trying to selectively decrement the refcount in this
function, just unhash it, and if that was successful, move it to the
dispose list. Then, the disposal routine will just clean that up as
usual.

Also, just make this a void function, drop the WARN_ON_ONCE, and the
comments about deadlocking since the nature of the purported deadlock
is no longer clear.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

v2: fix comments and formatting nit

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 58f4d9267f4a..5ab0b2b35c52 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -405,22 +405,15 @@ nfsd_file_unhash(struct nfsd_file *nf)
 	return false;
 }
 
-/*
- * Return true if the file was unhashed.
- */
-static bool
+static void
 nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dispose)
 {
 	trace_nfsd_file_unhash_and_dispose(nf);
-	if (!nfsd_file_unhash(nf))
-		return false;
-	/* keep final reference for nfsd_file_lru_dispose */
-	if (refcount_dec_not_one(&nf->nf_ref))
-		return true;
-
-	nfsd_file_lru_remove(nf);
-	list_add(&nf->nf_lru, dispose);
-	return true;
+	if (nfsd_file_unhash(nf)) {
+		/* caller must call nfsd_file_dispose_list() later */
+		nfsd_file_lru_remove(nf);
+		list_add(&nf->nf_lru, dispose);
+	}
 }
 
 static void
@@ -468,7 +461,6 @@ void nfsd_file_close(struct nfsd_file *nf)
 	}
 	/* put the ref for the stateid */
 	nfsd_file_put(nf);
-
 }
 
 struct nfsd_file *
@@ -564,8 +556,6 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
  * @lock: LRU list lock (unused)
  * @arg: dispose list
  *
- * Note this can deadlock with nfsd_file_cache_purge.
- *
  * Return values:
  *   %LRU_REMOVED: @item was removed from the LRU
  *   %LRU_ROTATE: @item is to be moved to the LRU tail
@@ -750,8 +740,6 @@ nfsd_file_close_inode(struct inode *inode)
  *
  * Walk the LRU list and close any entries that have not been used since
  * the last scan.
- *
- * Note this can deadlock with nfsd_file_cache_purge.
  */
 static void
 nfsd_file_delayed_close(struct work_struct *work)
@@ -893,16 +881,12 @@ nfsd_file_cache_init(void)
 	goto out;
 }
 
-/*
- * Note this can deadlock with nfsd_file_lru_cb.
- */
 static void
 __nfsd_file_cache_purge(struct net *net)
 {
 	struct rhashtable_iter iter;
 	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
-	bool del;
 
 	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
 	do {
@@ -912,14 +896,7 @@ __nfsd_file_cache_purge(struct net *net)
 		while (!IS_ERR_OR_NULL(nf)) {
 			if (net && nf->nf_net != net)
 				continue;
-			del = nfsd_file_unhash_and_dispose(nf, &dispose);
-
-			/*
-			 * Deadlock detected! Something marked this entry as
-			 * unhased, but hasn't removed it from the hash list.
-			 */
-			WARN_ON_ONCE(!del);
-
+			nfsd_file_unhash_and_dispose(nf, &dispose);
 			nf = rhashtable_walk_next(&iter);
 		}
 
-- 
2.37.3

