Return-Path: <linux-nfs+bounces-5508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6D195A08E
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F77E1C208EF
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907F61B2529;
	Wed, 21 Aug 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE7bpRgT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686751B251D;
	Wed, 21 Aug 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252190; cv=none; b=Xjjdpf1faCin8ITJ5k0QDifpyXWqMfBn4XcrBwD/CsJ+orXiHqTksUmvf6L28qfh8p9nv6Zr8Xw4fwAHyB5wN4B82pR3HkupqhsQ2+MTkH3i2eff9a204CKvjsZU09/L3MXuv3kHrwE4ApnvfyIbx/VhTXouRyp6MRBNMCRAOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252190; c=relaxed/simple;
	bh=Gg0PuGPo4vLQ54215kFZQH2vm7QAMALQX252doUhLEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2IQfB+yPmqB32u0LvZowrDSFj7eiEdU9tzauJxUigA+X3x1dYM5HS7iBNwCMYs/YteJznzV1ynB7zhQdFcZbdCDmZ7c6ry9R0PR790yZ8nGDkFsqYnQ0/X2egDrf2RO2BFAno+u7w1uspgAlzWiSdJjRNV42Q3qLhes6RR8l28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE7bpRgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874BAC4AF0E;
	Wed, 21 Aug 2024 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252190;
	bh=Gg0PuGPo4vLQ54215kFZQH2vm7QAMALQX252doUhLEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eE7bpRgT8TozcaEQtk/WVPZOSf0M8OqnQG5odzzfg1aupH7BLvVM1E7+hI2EmLhzM
	 oZRLrD/Di882TwUXclc4AgNI+zwLfnRXLZU4j3SD9Maw7TiVXl0XVsA1nsniT6V2v2
	 yFjanaVpVket4R+LA9GsSMah/JRRl4al+32KIBM8x7iOdzMLcsk+Tv0B5c0fIYwD+9
	 +qAIDsgmEMXLyvxdD0rTDOp9VQY8QRyK2ardp4PsoZDdYnYwx8dlEb2/fVf9XtrLxM
	 K+bWprb/POsmn7468KoIvAJ0avARj+fzd99Xu6ZO1WyT1fP0p/RmawBrncuU0JpQYE
	 vbrZfSRpEV5Yw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 06/18] NFSD: Refactor the duplicate reply cache shrinker
Date: Wed, 21 Aug 2024 10:55:36 -0400
Message-ID: <20240821145548.25700-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>
References: <20240821145548.25700-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit c135e1269f34dfdea4bd94c11060c83a3c0b3c12 ]

Avoid holding the bucket lock while freeing cache entries. This
change also caps the number of entries that are freed when the
shrinker calls to reduce the shrinker's impact on the cache's
effectiveness.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 86 ++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index e60313ce0fb6..7e1a53c10a7c 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -309,51 +309,16 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 	}
 }
 
-static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
-			 unsigned int max)
-{
-	struct svc_cacherep *rp, *tmp;
-	long freed = 0;
-
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
-}
-
-/*
- * Walk the LRU list and prune off entries that are older than RC_EXPIRE.
- * Also prune the oldest ones when the total exceeds the max number of entries.
+/**
+ * nfsd_reply_cache_count - count_objects method for the DRC shrinker
+ * @shrink: our registered shrinker context
+ * @sc: garbage collection parameters
+ *
+ * Returns the total number of entries in the duplicate reply cache. To
+ * keep things simple and quick, this is not the number of expired entries
+ * in the cache (ie, the number that would be removed by a call to
+ * nfsd_reply_cache_scan).
  */
-static long
-prune_cache_entries(struct nfsd_net *nn)
-{
-	unsigned int i;
-	long freed = 0;
-
-	for (i = 0; i < nn->drc_hashsize; i++) {
-		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
-
-		if (list_empty(&b->lru_head))
-			continue;
-		spin_lock(&b->cache_lock);
-		freed += prune_bucket(b, nn, 0);
-		spin_unlock(&b->cache_lock);
-	}
-	return freed;
-}
-
 static unsigned long
 nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -363,14 +328,45 @@ nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 	return atomic_read(&nn->num_drc_entries);
 }
 
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
+ */
 static unsigned long
 nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct nfsd_net *nn = container_of(shrink,
 				struct nfsd_net, nfsd_reply_cache_shrinker);
+	unsigned long freed = 0;
+	LIST_HEAD(dispose);
+	unsigned int i;
 
-	return prune_cache_entries(nn);
+	for (i = 0; i < nn->drc_hashsize; i++) {
+		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
+
+		if (list_empty(&b->lru_head))
+			continue;
+
+		spin_lock(&b->cache_lock);
+		nfsd_prune_bucket_locked(nn, b, 0, &dispose);
+		spin_unlock(&b->cache_lock);
+
+		freed += nfsd_cacherep_dispose(&dispose);
+		if (freed > sc->nr_to_scan)
+			break;
+	}
+
+	trace_nfsd_drc_gc(nn, freed);
+	return freed;
 }
+
 /*
  * Walk an xdr_buf and get a CRC for at most the first RC_CSUMLEN bytes
  */
-- 
2.45.2


