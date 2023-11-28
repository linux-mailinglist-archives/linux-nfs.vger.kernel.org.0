Return-Path: <linux-nfs+bounces-143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06C7FC8EF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A652825C9
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171F42A8B;
	Tue, 28 Nov 2023 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0nloBYl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274544390;
	Tue, 28 Nov 2023 21:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAD1C433C7;
	Tue, 28 Nov 2023 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208799;
	bh=H5pH+G0/mC26D2UISmtxczw1Tof4hLeZk9aPvkUQ93I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z0nloBYltk3AiBXK5remPzYzVDx/Zrs8mRzWw4p19M4oMQIfdb4TZHt5V3nvqkEpS
	 DVCfapD4gQYNae9PoyjT5H2L9hliL72jKdMmmaP9YcW+pzKvvwO/laLexAK40klqMD
	 83XjryL4EylSBDH8dPKFjROgKT2vxZCVKeU50ljhH5lsMHBPNnM8lH1pLipXv5Bb0Y
	 aSoIH7gvb690WqtUdjou7HmvJH/T9HSXrrE7ngz8tGFS7gWD+HkKFiJEFPecBFEBnZ
	 TLNLjXLq1Z0fePgj+Lk4lhhY3FnXdQn1mQrT4wwn34z3+ElLA7eNSNGolPZmwovXNF
	 Bw0H60Ii82HHQ==
Subject: [PATCH 4/8] NFSD: Refactor the duplicate reply cache shrinker
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 16:59:58 -0500
Message-ID: 
 <170120879800.1515.15350509894290203882.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
References: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit c135e1269f34dfdea4bd94c11060c83a3c0b3c12 ]

Avoid holding the bucket lock while freeing cache entries. This
change also caps the number of entries that are freed when the
shrinker calls to reduce the shrinker's impact on the cache's
effectiveness.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |   82 +++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 9dfa2c03b712..8aab82ca798b 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -310,68 +310,64 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
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



