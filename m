Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE8A74C652
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGIPpw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGIPpv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 11:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47684CE
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 08:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9FED60BE9
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 15:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24505C433C7;
        Sun,  9 Jul 2023 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688917549;
        bh=AuYH2/bpA7ApbH6pbu7k9d6JvQpKwFc4F1iHZE0xPZw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PB/bIiSte/tDl71K3aWLrkUZaTxZbo1UVCw7TY5a0CAOKzaTFCNjWbz+Mlq7OilBb
         K7OMchXxiLTYq/ZRi8umD1B1HxXk+eJs84jSR8VLFA2p2G/TTKShLSIEDfj4ZxmX04
         Z3Wrv13mL7UtZ5KX7H8vIeqFDFt6BbWANAkaG5zm4QMXb0cczioxUJvwEQhhXCKSDx
         D9Ie+OUVVAtdMNOJNNTBB1PfYYhwfNJsgGkZEx+qtJQ60RqhtYntFWClTuFv5ijzj3
         5ea/yIdrOeJAlbJw4TKdsEWi+90lbwbxOJe11Lq3847eWDU2Hvy55ZozWO4kXpMBno
         UA+ryRTBkE9Lg==
Subject: [PATCH v1 6/6] NFSD: Rename struct svc_cacherep
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Sun, 09 Jul 2023 11:45:48 -0400
Message-ID: <168891754819.3964.3352471615633843308.stgit@manet.1015granger.net>
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

The svc_ prefix is identified with the SunRPC layer. Although the
duplicate reply cache caches RPC replies, it is only for the NFS
protocol. Rename the struct to better reflect its purpose.

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
index 9bdcd73206c9..6eb3d7bdfaf3 100644
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
 	kfree(rp->c_replvec.iov_base);
 	kmem_cache_free(drc_slab, rp);
@@ -119,11 +119,11 @@ static void nfsd_cacherep_free(struct svc_cacherep *rp)
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
@@ -133,7 +133,7 @@ nfsd_cacherep_dispose(struct list_head *dispose)
 
 static void
 nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
-			    struct svc_cacherep *rp)
+			    struct nfsd_cacherep *rp)
 {
 	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base)
 		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
@@ -146,7 +146,7 @@ nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 }
 
 static void
-nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp,
 				struct nfsd_net *nn)
 {
 	nfsd_cacherep_unlink_locked(nn, b, rp);
@@ -154,7 +154,7 @@ nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 }
 
 static void
-nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp,
 			struct nfsd_net *nn)
 {
 	spin_lock(&b->cache_lock);
@@ -166,7 +166,7 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 int nfsd_drc_slab_create(void)
 {
 	drc_slab = kmem_cache_create("nfsd_drc",
-				sizeof(struct svc_cacherep), 0, 0, NULL);
+				sizeof(struct nfsd_cacherep), 0, 0, NULL);
 	return drc_slab ? 0: -ENOMEM;
 }
 
@@ -235,7 +235,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 
 void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 {
-	struct svc_cacherep	*rp;
+	struct nfsd_cacherep *rp;
 	unsigned int i;
 
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
@@ -243,7 +243,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	for (i = 0; i < nn->drc_hashsize; i++) {
 		struct list_head *head = &nn->drc_hashtbl[i].lru_head;
 		while (!list_empty(head)) {
-			rp = list_first_entry(head, struct svc_cacherep, c_lru);
+			rp = list_first_entry(head, struct nfsd_cacherep, c_lru);
 			nfsd_reply_cache_free_locked(&nn->drc_hashtbl[i],
 									rp, nn);
 		}
@@ -260,7 +260,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
  * not already scheduled.
  */
 static void
-lru_put_end(struct nfsd_drc_bucket *b, struct svc_cacherep *rp)
+lru_put_end(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp)
 {
 	rp->c_timestamp = jiffies;
 	list_move_tail(&rp->c_lru, &b->lru_head);
@@ -283,7 +283,7 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 			 unsigned int max, struct list_head *dispose)
 {
 	unsigned long expiry = jiffies - RC_EXPIRE;
-	struct svc_cacherep *rp, *tmp;
+	struct nfsd_cacherep *rp, *tmp;
 	unsigned int freed = 0;
 
 	lockdep_assert_held(&b->cache_lock);
@@ -401,8 +401,8 @@ nfsd_cache_csum(struct svc_rqst *rqstp)
 }
 
 static int
-nfsd_cache_key_cmp(const struct svc_cacherep *key,
-			const struct svc_cacherep *rp, struct nfsd_net *nn)
+nfsd_cache_key_cmp(const struct nfsd_cacherep *key,
+		   const struct nfsd_cacherep *rp, struct nfsd_net *nn)
 {
 	if (key->c_key.k_xid == rp->c_key.k_xid &&
 	    key->c_key.k_csum != rp->c_key.k_csum) {
@@ -418,11 +418,11 @@ nfsd_cache_key_cmp(const struct svc_cacherep *key,
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
@@ -431,7 +431,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
 	while (*p != NULL) {
 		++entries;
 		parent = *p;
-		rp = rb_entry(parent, struct svc_cacherep, c_node);
+		rp = rb_entry(parent, struct nfsd_cacherep, c_node);
 
 		cmp = nfsd_cache_key_cmp(key, rp, nn);
 		if (cmp < 0)
@@ -477,10 +477,10 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
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
@@ -585,7 +585,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, struct svc_cacherep **cacherep)
  * nfsd failed to encode a reply that otherwise would have been cached.
  * In this case, nfsd_cache_update is called with statp == NULL.
  */
-void nfsd_cache_update(struct svc_rqst *rqstp, struct svc_cacherep *rp,
+void nfsd_cache_update(struct svc_rqst *rqstp, struct nfsd_cacherep *rp,
 		       int cachetype, __be32 *statp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 64ac70990019..5bdbac1f4d0f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1045,7 +1045,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
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


