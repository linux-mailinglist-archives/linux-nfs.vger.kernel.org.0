Return-Path: <linux-nfs+bounces-18758-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BwbL/a9hGnG4wMAu9opvQ
	(envelope-from <linux-nfs+bounces-18758-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 16:57:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA67F4D7D
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 16:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C0AE3006110
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965842B757;
	Thu,  5 Feb 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnmGCRKR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B57421F10
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307055; cv=none; b=ptUssHpZmNqW4gFdg2ZuXR7h6EX6tQ1b2zvZnH7xdr0fefC5SwqpMTFn2S6lGQQ24b3s37KiYXlfDGleblyOHQVTiU6pqLd2E1CiFDAcCBK1CdLnGzv+y/owcQZQrZ5lWVP3fjGbN4n5h8xQfhmoedhKsTNqbQMDmUJtvt83QDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307055; c=relaxed/simple;
	bh=Ipbh1xpvwHRj+FUV4G7veSyz2+jJcaWeU+KAEXpcO2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI0rw05iRa87hPifxbZDEigE7ktwYnTZFyFl4ym9Scy/HNZBclEZ3Y3anWSAYn5C/hVj9PXw3A+6W4969ej48Os2oPqAMRzkx0mM8EA4P1GT9/mY8ykWNQ5jsZsDtKZ7DqmrDhHc8JiwYwHigVte0fohQzoWlkJIsaxuONaNUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnmGCRKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31BFC19423;
	Thu,  5 Feb 2026 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770307055;
	bh=Ipbh1xpvwHRj+FUV4G7veSyz2+jJcaWeU+KAEXpcO2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnmGCRKRpPf/CEMBuwkbWg8FAfqUs1ZVw5zTO0PaLqxrlUh1FT7u092TBfUl1YSGY
	 bXeWA10XLVy42dpH/sGVnC3EpIMtTKAuHu1lHrgPS4GKxAOybQhSkjc7PI5S+j2PDC
	 j0vHuFOGmmo7KoON5oDtA/yE9nn+jIs9zd0kDAozBV7TVhRaZaQc3Y9bqT218Gf1ED
	 8QCbEwzSo/s4u62qW+T61Wu3yp8gxiPGheAaOB6x6Y75t1M/sRsp0JhwgMiYHYG+WM
	 PGnHVsFKR0eeomh+OdwGU1whPbDGoZSzq2ngspT9YodPHmYeefRmFp5qZBnaqUCCgL
	 ch1lw5MLabKTw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	daire@dneg.com,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/7] sunrpc: add per-transport page recycling pool
Date: Thu,  5 Feb 2026 10:57:25 -0500
Message-ID: <20260205155729.6841-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205155729.6841-1-cel@kernel.org>
References: <20260205155729.6841-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18758-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,dneg.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9EA67F4D7D
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

RPC server transports allocate pages for receiving incoming data on
every request. Under high load, this repeated allocation and freeing
creates unnecessary overhead in the page allocator hot path.

Introduce svc_page_pool, a lock-free page recycling mechanism that
enables efficient page reuse between receive operations. A follow-up
commit wires this into the TCP transport's receive path; svcrdma's
RDMA Read path might also make use of this mechanism some day.

The pool uses llist for lock-free producer-consumer handoff: worker
threads returning pages after RPC processing act as producers, while
receiver threads allocating pages for incoming data act as
consumers. Pages are linked via page->pcp_llist, which is safe
because these pages are owned exclusively by the transport.

Each pool tracks its NUMA node affinity, allowing page allocations
to target the same node as the transport's receiver thread. Provide
svc_pool_node() to enable transports to determine the NUMA node
associated with a service pool for NUMA-aware resource allocation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h      |   1 +
 include/linux/sunrpc/svc_xprt.h |  32 +++++++
 net/sunrpc/svc.c                |  13 +++
 net/sunrpc/svc_xprt.c           | 151 ++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5506d20857c3..f4efe60f4dad 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -457,6 +457,7 @@ void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
 void		   svc_pool_wake_idle_thread(struct svc_pool *pool);
 struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
+int		   svc_pool_node(struct svc_pool *pool);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
 const char *	   svc_proc_name(const struct svc_rqst *rqstp);
 int		   svc_encode_result_payload(struct svc_rqst *rqstp,
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index da2a2531e110..e60c2936b1ce 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -9,9 +9,33 @@
 #define SUNRPC_SVC_XPRT_H
 
 #include <linux/sunrpc/svc.h>
+#include <linux/llist.h>
 
 struct module;
 
+/**
+ * struct svc_page_pool - per-transport page recycling pool
+ * @pp_pages: lock-free list of recycled pages
+ * @pp_count: number of pages currently in pool
+ * @pp_numa_node: NUMA node for page allocations
+ * @pp_max: maximum pages to retain in pool
+ *
+ * Lock-free page recycling between producers (svc threads returning
+ * pages) and a single consumer (the thread allocating pages for
+ * receives). Uses llist for efficient producer-consumer handoff
+ * without spinlocks.
+ *
+ * Callers must serialize calls to svc_page_pool_get(); multiple
+ * concurrent consumers are not supported.
+ * Allocate with svc_page_pool_alloc(); free with svc_page_pool_free().
+ */
+struct svc_page_pool {
+	struct llist_head	pp_pages;
+	atomic_t		pp_count;
+	int			pp_numa_node;
+	unsigned int		pp_max;
+};
+
 struct svc_xprt_ops {
 	struct svc_xprt	*(*xpo_create)(struct svc_serv *,
 				       struct net *net,
@@ -187,6 +211,14 @@ void	svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *xprt);
 void	svc_age_temp_xprts_now(struct svc_serv *, struct sockaddr *);
 void	svc_xprt_deferred_close(struct svc_xprt *xprt);
 
+/* Page pool helpers */
+struct svc_page_pool *svc_page_pool_alloc(int numa_node, unsigned int max);
+void	svc_page_pool_free(struct svc_page_pool *pool);
+void	svc_page_pool_put(struct svc_page_pool *pool, struct page *page);
+void	svc_page_pool_put_bulk(struct svc_page_pool *pool,
+			       struct page **pages, unsigned int count);
+struct page *svc_page_pool_get(struct svc_page_pool *pool);
+
 static inline void svc_xprt_get(struct svc_xprt *xprt)
 {
 	kref_get(&xprt->xpt_ref);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4704dce7284e..6b350cb7d539 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -418,6 +418,19 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	return &serv->sv_pools[pidx % serv->sv_nrpools];
 }
 
+/**
+ * svc_pool_node - Return the NUMA node affinity of a service pool
+ * @pool: the service pool
+ *
+ * Return value:
+ *   The NUMA node the pool is associated with, or the local node
+ *   if no explicit mapping exists
+ */
+int svc_pool_node(struct svc_pool *pool)
+{
+	return svc_pool_map_get_node(pool->sp_id);
+}
+
 static int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
 {
 	int err;
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 6973184ff667..fe31cf6a9c5d 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1497,4 +1497,155 @@ int svc_pool_stats_open(struct svc_info *info, struct file *file)
 }
 EXPORT_SYMBOL(svc_pool_stats_open);
 
+static struct llist_node *svc_page_to_llist(struct page *page)
+{
+	return &page->pcp_llist;
+}
+
+static struct page *svc_llist_to_page(struct llist_node *node)
+{
+	return container_of(node, struct page, pcp_llist);
+}
+
+/**
+ * svc_page_pool_alloc - Allocate a page pool
+ * @numa_node: NUMA node for page allocations
+ * @max: maximum pages to retain in pool
+ *
+ * Pages in an svc_page_pool are linked via page->pcp_llist, which is
+ * safe since these pages are owned exclusively by the transport.
+ *
+ * The caller must free the pool with svc_page_pool_free() when
+ * the transport is destroyed.
+ *
+ * Returns a new page pool, or NULL on allocation failure.
+ */
+struct svc_page_pool *svc_page_pool_alloc(int numa_node, unsigned int max)
+{
+	struct svc_page_pool *pool;
+
+	pool = kmalloc_node(sizeof(*pool), GFP_KERNEL, numa_node);
+	if (!pool)
+		return NULL;
+
+	init_llist_head(&pool->pp_pages);
+	atomic_set(&pool->pp_count, 0);
+	pool->pp_numa_node = numa_node;
+	pool->pp_max = max;
+	return pool;
+}
+
+/**
+ * svc_page_pool_free - Free a page pool and all pages in it
+ * @pool: pool to free (may be NULL)
+ */
+void svc_page_pool_free(struct svc_page_pool *pool)
+{
+	struct llist_node *node;
+
+	if (!pool)
+		return;
+
+	while ((node = llist_del_first(&pool->pp_pages)) != NULL)
+		put_page(svc_llist_to_page(node));
+	kfree(pool);
+}
+
+/**
+ * svc_page_pool_put - Return a page to the pool
+ * @pool: pool to return page to (may be NULL)
+ * @page: page to return (may be NULL)
+ *
+ * Transfers ownership of @page to the pool. The caller's reference
+ * is consumed: either the pool retains the page, or put_page() is
+ * called if @pool is NULL or full.
+ */
+void svc_page_pool_put(struct svc_page_pool *pool, struct page *page)
+{
+	if (!page)
+		return;
+	if (!pool || atomic_read(&pool->pp_count) >= pool->pp_max) {
+		put_page(page);
+		return;
+	}
+	llist_add(svc_page_to_llist(page), &pool->pp_pages);
+	atomic_inc(&pool->pp_count);
+}
+
+/**
+ * svc_page_pool_put_bulk - Return multiple pages to the pool
+ * @pool: pool to return pages to (may be NULL)
+ * @pages: array of pages to return
+ * @count: number of pages in @pages array
+ *
+ * Batch version of svc_page_pool_put() that reduces atomic operations
+ * when returning many pages at once. Transfers ownership of all pages
+ * in @pages to the pool. Uses release_pages() for efficient bulk
+ * freeing when the pool is full.
+ *
+ * Unlike svc_page_pool_put(), this function does not handle NULL
+ * entries in @pages. All @count entries must be valid page pointers.
+ */
+void svc_page_pool_put_bulk(struct svc_page_pool *pool,
+			    struct page **pages, unsigned int count)
+{
+	struct llist_node *head, *last, *node;
+	unsigned int i, to_add, avail;
+
+	if (!count)
+		return;
+	if (!pool) {
+		release_pages(pages, count);
+		return;
+	}
+
+	avail = pool->pp_max - atomic_read(&pool->pp_count);
+	to_add = min_t(unsigned int, count, avail);
+	if (!to_add) {
+		release_pages(pages, count);
+		return;
+	}
+
+	head = NULL;
+	last = NULL;
+	for (i = 0; i < to_add; i++) {
+		node = svc_page_to_llist(pages[i]);
+		node->next = head;
+		head = node;
+		if (!last)
+			last = node;
+	}
+	llist_add_batch(head, last, &pool->pp_pages);
+	atomic_add(to_add, &pool->pp_count);
+
+	/* Free overflow pages that didn't fit in the pool */
+	if (to_add < count)
+		release_pages(pages + to_add, count - to_add);
+}
+EXPORT_SYMBOL_GPL(svc_page_pool_put_bulk);
+
+/**
+ * svc_page_pool_get - Get a page from the pool
+ * @pool: pool to take from (may be NULL)
+ *
+ * Returns a recycled page with one reference, or NULL if @pool is
+ * NULL or empty. The caller owns the returned page and must either
+ * return it via svc_page_pool_put() or release it with put_page().
+ *
+ * Caller must serialize; concurrent calls for the same pool are
+ * not supported.
+ */
+struct page *svc_page_pool_get(struct svc_page_pool *pool)
+{
+	struct llist_node *node;
+
+	if (!pool)
+		return NULL;
+	node = llist_del_first(&pool->pp_pages);
+	if (!node)
+		return NULL;
+	atomic_dec(&pool->pp_count);
+	return svc_llist_to_page(node);
+}
+
 /*----------------------------------------------------------------------------*/
-- 
2.52.0


