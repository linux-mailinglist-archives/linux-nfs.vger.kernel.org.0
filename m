Return-Path: <linux-nfs+bounces-145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161457FC8F3
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9061C20FEA
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D28A481A9;
	Tue, 28 Nov 2023 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr5rfG8C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64844390;
	Tue, 28 Nov 2023 22:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DF0C433C8;
	Tue, 28 Nov 2023 22:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208812;
	bh=oq6ZpYPv5VUldAJhiByovMkeErLUpTcVwLYtYtH/5+E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rr5rfG8CKshEAKEzaAhWzCdxgaHRtadEJYhyWmAQ/nKt7fLCTIMoinmzB8N8WaDyu
	 Xi5Njvbbyn/eu833lYThHcjuFhdT8+pExCCwD0FXBFT1ATozlX9eEgmXNYjlLOrIIF
	 x7vQZSo6BsaH0qUi6tOHOkjzD66jB/GdzcdimGclTLQMv5nQs1cNdVp0mpZE2ZOmAU
	 Ywohz+v9Y4LsQtUG6+MNvG7aLgF8bCz8oKO2BebWE9Bski/FOilFGOVWrM4s+O/Ly5
	 YRlZ3PYCFXk+IyVhNF+UfU5R48JlzCzf08DVFNHHXXbfJjuXxGr6oSwCBvGWs+2KRD
	 btGG7CqQKH8Lg==
Subject: [PATCH 6/8] NFSD: Rename struct svc_cacherep
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 17:00:10 -0500
Message-ID: 
 <170120881083.1515.2442746427305667531.stgit@klimt.1015granger.net>
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

[ Upstream commit e7421ce71437ec8e4d69cc6bdf35b6853adc5050 ]

The svc_ prefix is identified with the SunRPC layer. Although the
duplicate reply cache caches RPC replies, it is only for the NFS
protocol. Rename the struct to better reflect its purpose.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/cache.h    |    6 +++---
 fs/nfsd/nfscache.c |   44 ++++++++++++++++++++++----------------------
 fs/nfsd/nfssvc.c   |    2 +-
 fs/nfsd/trace.h    |    4 ++--
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index 27610b071880..929248c6ca84 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -19,7 +19,7 @@
  * typical sockaddr_storage. This is for space reasons, since sockaddr_storage
  * is much larger than a sockaddr_in6.
  */
-struct svc_cacherep {
+struct nfsd_cacherep {
 	struct {
 		/* Keep often-read xid, csum in the same cache line: */
 		__be32			k_xid;
@@ -85,8 +85,8 @@ void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *rqstp,
-			  struct svc_cacherep **cacherep);
-void	nfsd_cache_update(struct svc_rqst *rqstp, struct svc_cacherep *rp,
+			  struct nfsd_cacherep **cacherep);
+void	nfsd_cache_update(struct svc_rqst *rqstp, struct nfsd_cacherep *rp,
 			  int cachetype, __be32 *statp);
 int	nfsd_reply_cache_stats_show(struct seq_file *m, void *v);
 
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index de4f2c6f23dc..abb453be71ca 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -84,11 +84,11 @@ nfsd_hashsize(unsigned int limit)
 	return roundup_pow_of_two(limit / TARGET_BUCKET_SIZE);
 }
 
-static struct svc_cacherep *
+static struct nfsd_cacherep *
 nfsd_cacherep_alloc(struct svc_rqst *rqstp, __wsum csum,
 		    struct nfsd_net *nn)
 {
-	struct svc_cacherep	*rp;
+	struct nfsd_cacherep *rp;
 
 	rp = kmem_cache_alloc(drc_slab, GFP_KERNEL);
 	if (rp) {
@@ -110,7 +110,7 @@ nfsd_cacherep_alloc(struct svc_rqst *rqstp, __wsum csum,
 	return rp;
 }
 
-static void nfsd_cacherep_free(struct svc_cacherep *rp)
+static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
 {
 	if (rp->c_type == RC_REPLBUFF)
 		kfree(rp->c_replvec.iov_base);
@@ -120,11 +120,11 @@ static void nfsd_cacherep_free(struct svc_cacherep *rp)
 static unsigned long
 nfsd_cacherep_dispose(struct list_head *dispose)
 {
-	struct svc_cacherep *rp;
+	struct nfsd_cacherep *rp;
 	unsigned long freed = 0;
 
 	while (!list_empty(dispose)) {
-		rp = list_first_entry(dispose, struct svc_cacherep, c_lru);
+		rp = list_first_entry(dispose, struct nfsd_cacherep, c_lru);
 		list_del(&rp->c_lru);
 		nfsd_cacherep_free(rp);
 		freed++;
@@ -134,7 +134,7 @@ nfsd_cacherep_dispose(struct list_head *dispose)
 
 static void
 nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
-			    struct svc_cacherep *rp)
+			    struct nfsd_cacherep *rp)
 {
 	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base)
 		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
@@ -147,7 +147,7 @@ nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 }
 
 static void
-nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp,
 				struct nfsd_net *nn)
 {
 	nfsd_cacherep_unlink_locked(nn, b, rp);
@@ -155,7 +155,7 @@ nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 }
 
 static void
-nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp,
 			struct nfsd_net *nn)
 {
 	spin_lock(&b->cache_lock);
@@ -167,7 +167,7 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 int nfsd_drc_slab_create(void)
 {
 	drc_slab = kmem_cache_create("nfsd_drc",
-				sizeof(struct svc_cacherep), 0, 0, NULL);
+				sizeof(struct nfsd_cacherep), 0, 0, NULL);
 	return drc_slab ? 0: -ENOMEM;
 }
 
@@ -236,7 +236,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 
 void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 {
-	struct svc_cacherep	*rp;
+	struct nfsd_cacherep *rp;
 	unsigned int i;
 
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
@@ -244,7 +244,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	for (i = 0; i < nn->drc_hashsize; i++) {
 		struct list_head *head = &nn->drc_hashtbl[i].lru_head;
 		while (!list_empty(head)) {
-			rp = list_first_entry(head, struct svc_cacherep, c_lru);
+			rp = list_first_entry(head, struct nfsd_cacherep, c_lru);
 			nfsd_reply_cache_free_locked(&nn->drc_hashtbl[i],
 									rp, nn);
 		}
@@ -261,7 +261,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
  * not already scheduled.
  */
 static void
-lru_put_end(struct nfsd_drc_bucket *b, struct svc_cacherep *rp)
+lru_put_end(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp)
 {
 	rp->c_timestamp = jiffies;
 	list_move_tail(&rp->c_lru, &b->lru_head);
@@ -284,7 +284,7 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 			 unsigned int max, struct list_head *dispose)
 {
 	unsigned long expiry = jiffies - RC_EXPIRE;
-	struct svc_cacherep *rp, *tmp;
+	struct nfsd_cacherep *rp, *tmp;
 	unsigned int freed = 0;
 
 	lockdep_assert_held(&b->cache_lock);
@@ -402,8 +402,8 @@ nfsd_cache_csum(struct svc_rqst *rqstp)
 }
 
 static int
-nfsd_cache_key_cmp(const struct svc_cacherep *key,
-			const struct svc_cacherep *rp, struct nfsd_net *nn)
+nfsd_cache_key_cmp(const struct nfsd_cacherep *key,
+		   const struct nfsd_cacherep *rp, struct nfsd_net *nn)
 {
 	if (key->c_key.k_xid == rp->c_key.k_xid &&
 	    key->c_key.k_csum != rp->c_key.k_csum) {
@@ -419,11 +419,11 @@ nfsd_cache_key_cmp(const struct svc_cacherep *key,
  * Must be called with cache_lock held. Returns the found entry or
  * inserts an empty key on failure.
  */
-static struct svc_cacherep *
-nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
+static struct nfsd_cacherep *
+nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
 			struct nfsd_net *nn)
 {
-	struct svc_cacherep	*rp, *ret = key;
+	struct nfsd_cacherep	*rp, *ret = key;
 	struct rb_node		**p = &b->rb_head.rb_node,
 				*parent = NULL;
 	unsigned int		entries = 0;
@@ -432,7 +432,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
 	while (*p != NULL) {
 		++entries;
 		parent = *p;
-		rp = rb_entry(parent, struct svc_cacherep, c_node);
+		rp = rb_entry(parent, struct nfsd_cacherep, c_node);
 
 		cmp = nfsd_cache_key_cmp(key, rp, nn);
 		if (cmp < 0)
@@ -478,10 +478,10 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
  *   %RC_REPLY: Reply from cache
  *   %RC_DROPIT: Do not process the request further
  */
-int nfsd_cache_lookup(struct svc_rqst *rqstp, struct svc_cacherep **cacherep)
+int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cacherep)
 {
 	struct nfsd_net		*nn;
-	struct svc_cacherep	*rp, *found;
+	struct nfsd_cacherep	*rp, *found;
 	__wsum			csum;
 	struct nfsd_drc_bucket	*b;
 	int type = rqstp->rq_cachetype;
@@ -586,7 +586,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, struct svc_cacherep **cacherep)
  * nfsd failed to encode a reply that otherwise would have been cached.
  * In this case, nfsd_cache_update is called with statp == NULL.
  */
-void nfsd_cache_update(struct svc_rqst *rqstp, struct svc_cacherep *rp,
+void nfsd_cache_update(struct svc_rqst *rqstp, struct nfsd_cacherep *rp,
 		       int cachetype, __be32 *statp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f91fb343313d..97830e28c140 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1046,7 +1046,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
-	struct svc_cacherep *rp;
+	struct nfsd_cacherep *rp;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c06c505d04fb..2388053eb862 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1240,8 +1240,8 @@ TRACE_EVENT(nfsd_drc_found,
 TRACE_EVENT(nfsd_drc_mismatch,
 	TP_PROTO(
 		const struct nfsd_net *nn,
-		const struct svc_cacherep *key,
-		const struct svc_cacherep *rp
+		const struct nfsd_cacherep *key,
+		const struct nfsd_cacherep *rp
 	),
 	TP_ARGS(nn, key, rp),
 	TP_STRUCT__entry(



