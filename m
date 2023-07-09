Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0702974C650
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGIPpk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjGIPpj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 11:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4A791
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 08:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41E4560BCC
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 15:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5CBC433C9;
        Sun,  9 Jul 2023 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688917536;
        bh=ESyCxUz+L4CLWq/U+M6xm5NiCuhMJDeWLU2DOm1WrZY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rguEMf9lihj+7wqKm2/6fLPzRhJ+nNWLtbhZe95KTCAij5xuDnHMWf7wrzcFfK2cJ
         LOKUbVoL9t0jTeVfwg8h1LWpIvP2vvyiSlfirV5pufk9fB7ktlVOgRHyh2ldeAGcON
         uQWzq/3LNvHUmLWrQDIQWsnE6+09CYejc3sFyVedJIOUBYlwoBagz5/sKIsZVrLOO+
         Ytz19zAxPo95lp5MXSPou51upkfskjo8599WlK00cbIjio6esdlCtz0kjQXyGwqyLV
         3bMxYO0O+mXaleOzjeRNJI3wFF2LK+j+2F6Xw2PNx0DJnuPRNg2az0RPCZF4QSQLJs
         dOlFGv+iXhboA==
Subject: [PATCH v1 4/6] NFSD: Refactor the duplicate reply cache shrinker
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Sun, 09 Jul 2023 11:45:35 -0400
Message-ID: <168891753555.3964.17240379490969380455.stgit@manet.1015granger.net>
In-Reply-To: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
References: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Avoid holding the bucket lock while freeing cache entries. This
change also caps the number of entries that are freed when the
shrinker calls to reduce the shrinker's impact on the cache's
effectiveness.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |   82 +++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index c8b572d2c72a..c08078ac9284 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -309,68 +309,64 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 	}
 }
 
-static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
-			 unsigned int max)
+/**
+ * nfsd_reply_cache_count - count_objects method for the DRC shrinker
+ * @shrink: our registered shrinker context
+ * @sc: garbage collection parameters
+ *
+ * Returns the total number of entries in the duplicate reply cache. To
+ * keep things simple and quick, this is not the number of expired entries
+ * in the cache (ie, the number that would be removed by a call to
+ * nfsd_reply_cache_scan).
+ */
+static unsigned long
+nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct svc_cacherep *rp, *tmp;
-	long freed = 0;
+	struct nfsd_net *nn = container_of(shrink,
+				struct nfsd_net, nfsd_reply_cache_shrinker);
 
-	list_for_each_entry_safe(rp, tmp, &b->lru_head, c_lru) {
-		/*
-		 * Don't free entries attached to calls that are still
-		 * in-progress, but do keep scanning the list.
-		 */
-		if (rp->c_state == RC_INPROG)
-			continue;
-		if (atomic_read(&nn->num_drc_entries) <= nn->max_drc_entries &&
-		    time_before(jiffies, rp->c_timestamp + RC_EXPIRE))
-			break;
-		nfsd_reply_cache_free_locked(b, rp, nn);
-		if (max && freed++ > max)
-			break;
-	}
-	return freed;
+	return atomic_read(&nn->num_drc_entries);
 }
 
-/*
- * Walk the LRU list and prune off entries that are older than RC_EXPIRE.
- * Also prune the oldest ones when the total exceeds the max number of entries.
+/**
+ * nfsd_reply_cache_scan - scan_objects method for the DRC shrinker
+ * @shrink: our registered shrinker context
+ * @sc: garbage collection parameters
+ *
+ * Free expired entries on each bucket's LRU list until we've released
+ * nr_to_scan freed objects. Nothing will be released if the cache
+ * has not exceeded it's max_drc_entries limit.
+ *
+ * Returns the number of entries released by this call.
  */
-static long
-prune_cache_entries(struct nfsd_net *nn)
+static unsigned long
+nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
+	struct nfsd_net *nn = container_of(shrink,
+				struct nfsd_net, nfsd_reply_cache_shrinker);
+	unsigned long freed = 0;
+	LIST_HEAD(dispose);
 	unsigned int i;
-	long freed = 0;
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
 		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
 
 		if (list_empty(&b->lru_head))
 			continue;
+
 		spin_lock(&b->cache_lock);
-		freed += prune_bucket(b, nn, 0);
+		nfsd_prune_bucket_locked(nn, b, 0, &dispose);
 		spin_unlock(&b->cache_lock);
-	}
-	return freed;
-}
 
-static unsigned long
-nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
-{
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+		freed += nfsd_cacherep_dispose(&dispose);
+		if (freed > sc->nr_to_scan)
+			break;
+	}
 
-	return atomic_read(&nn->num_drc_entries);
+	trace_nfsd_drc_gc(nn, freed);
+	return freed;
 }
 
-static unsigned long
-nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
-{
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
-
-	return prune_cache_entries(nn);
-}
 /*
  * Walk an xdr_buf and get a CRC for at most the first RC_CSUMLEN bytes
  */


