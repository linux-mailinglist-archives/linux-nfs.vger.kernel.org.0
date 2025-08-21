Return-Path: <linux-nfs+bounces-13837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22972B2FEB6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9DE641EB4
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E414274FD0;
	Thu, 21 Aug 2025 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqRf3wkv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64526272811;
	Thu, 21 Aug 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789777; cv=none; b=aXh8tcDlnQb64phroPSt9zejhR71r5fJHYEtora5Iu4YuzJ5UvnfLQIIpGOQprYd7pjt+/oJf23pGRrdU+Jh07YmbRqOZHYomI0BJVYtnvspbj0xfekDCCZc8Ja1yf1Q3W7D8R4t1Yh0+4QS6ozllIZcQTTvvjy7ikSYuMHv84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789777; c=relaxed/simple;
	bh=gNEReZNKKjiRp14rWITbsj+yWGXcTql8kgd+vE8m5kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mupGaqD0f1ILmQ3orulwpc5KAuT2z218wqfsCVKIIDmOova+X8JpjzCrR7psfb8AkrQxOTm7G1qAeATDvbgs/zjRwnwEtGRUFS2oc4Plz/YhW1vIECiijt8NzZN9XyjgJ33azyCAjb9QBFDmjAC/5yKPTHv6gszLbNGDTVXCGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqRf3wkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717D9C4CEED;
	Thu, 21 Aug 2025 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789776;
	bh=gNEReZNKKjiRp14rWITbsj+yWGXcTql8kgd+vE8m5kU=;
	h=From:To:Cc:Subject:Date:From;
	b=BqRf3wkvtbLEU/8eCHMu1RE13PkJyYZo01nGXmqv6QYHzFOsG1WgJ+9FfpKiPFR/l
	 ajL1Q3id4tPg1tUxzbC4qvm4E5IdBZ2tXm8+L2oHlfj2RFuEDCDcw9FvPlGZwbEfLL
	 9gId/6WGfCVwh7nVpxcVcnB/N6R8j+4d60cNYPmBl22VRBLPChvFe2XP/gs5NYc7dc
	 oGmkWgcHBau0+CQp+jfdBK7ZJl0JvCZvKACYTFOGihPz6kNPTgv7K1aSOLL81iDLTD
	 arlHzvSSIexGlcNwZOs0ktOAjjIyi7y6t5+j/wp6Jz8+P2vfqJa8tdy0DU8hELAKk7
	 zHJ3d6yrtTk1g==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v3] svcrdma: Introduce Receive buffer arenas
Date: Thu, 21 Aug 2025 11:22:54 -0400
Message-ID: <20250821152254.8781-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Reduce the per-connection footprint in the host's and RNIC's memory
management TLBs by combining groups of a connection's Receive
buffers into fewer IOVAs.

I don't have a good way to measure whether this approach is
effective.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |   3 +
 include/trace/events/rpcrdma.h          |  99 ++++++++++
 net/sunrpc/xprtrdma/Makefile            |   2 +-
 net/sunrpc/xprtrdma/pool.c              | 241 ++++++++++++++++++++++++
 net/sunrpc/xprtrdma/pool.h              |  20 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  45 ++---
 6 files changed, 380 insertions(+), 30 deletions(-)
 create mode 100644 net/sunrpc/xprtrdma/pool.c
 create mode 100644 net/sunrpc/xprtrdma/pool.h

Changes since v2:
- Allocate the shard buffer with alloc_pages instead of kmalloc
- Simplify the synopsis of rpcrdma_pool_create
- rpcrdma_pool_buffer_alloc now initializes the RECV's ib_sge
- Added a "sync_for_cpu" API

Changes since v1:
- Rename "chunks" to "shards" -- RPC/RDMA already has chunks
- Replace pool's list of shards with an xarray
- Implement bitmap-based shard free space management
- Implement some naive observability

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 22704c2e5b9b..b4f3c01f1b94 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -73,6 +73,8 @@ extern struct percpu_counter svcrdma_stat_recv;
 extern struct percpu_counter svcrdma_stat_sq_starve;
 extern struct percpu_counter svcrdma_stat_write;
 
+struct rpcrdma_pool;
+
 struct svcxprt_rdma {
 	struct svc_xprt      sc_xprt;		/* SVC transport structure */
 	struct rdma_cm_id    *sc_cm_id;		/* RDMA connection id */
@@ -112,6 +114,7 @@ struct svcxprt_rdma {
 	unsigned long	     sc_flags;
 	struct work_struct   sc_work;
 
+	struct rpcrdma_pool  *sc_recv_pool;
 	struct llist_head    sc_recv_ctxts;
 
 	atomic_t	     sc_completion_ids;
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index e6a72646c507..8bc713082c1a 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2336,6 +2336,105 @@ DECLARE_EVENT_CLASS(rpcrdma_client_register_class,
 DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_register);
 DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_unregister);
 
+TRACE_EVENT(rpcrdma_pool_create,
+	TP_PROTO(
+		unsigned int poolid,
+		size_t bufsize
+	),
+
+	TP_ARGS(poolid, bufsize),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, poolid)
+		__field(size_t, bufsize)
+	),
+
+	TP_fast_assign(
+		__entry->poolid = poolid;
+		__entry->bufsize = bufsize;
+	),
+
+	TP_printk("poolid=%u bufsize=%zu bytes",
+		__entry->poolid, __entry->bufsize
+	)
+);
+
+TRACE_EVENT(rpcrdma_pool_destroy,
+	TP_PROTO(
+		unsigned int poolid
+	),
+
+	TP_ARGS(poolid),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, poolid)
+	),
+
+	TP_fast_assign(
+		__entry->poolid = poolid;),
+
+	TP_printk("poolid=%u",
+		__entry->poolid
+	)
+);
+
+DECLARE_EVENT_CLASS(rpcrdma_pool_shard_class,
+	TP_PROTO(
+		unsigned int poolid,
+		u32 shardid
+	),
+
+	TP_ARGS(poolid, shardid),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, poolid)
+		__field(u32, shardid)
+	),
+
+	TP_fast_assign(
+		__entry->poolid = poolid;
+		__entry->shardid = shardid;
+	),
+
+	TP_printk("poolid=%u shardid=%u",
+		__entry->poolid, __entry->shardid
+	)
+);
+
+#define DEFINE_RPCRDMA_POOL_SHARD_EVENT(name)				\
+	DEFINE_EVENT(rpcrdma_pool_shard_class, name,			\
+	TP_PROTO(							\
+		unsigned int poolid,					\
+		u32 shardid						\
+	),								\
+	TP_ARGS(poolid, shardid))
+
+DEFINE_RPCRDMA_POOL_SHARD_EVENT(rpcrdma_pool_shard_new);
+DEFINE_RPCRDMA_POOL_SHARD_EVENT(rpcrdma_pool_shard_free);
+
+TRACE_EVENT(rpcrdma_pool_buffer,
+	TP_PROTO(
+		unsigned int poolid,
+		const void *buffer
+	),
+
+	TP_ARGS(poolid, buffer),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, poolid)
+		__field(const void *, buffer)
+	),
+
+	TP_fast_assign(
+		__entry->poolid = poolid;
+		__entry->buffer = buffer;
+	),
+
+	TP_printk("poolid=%u buffer=%p",
+		__entry->poolid, __entry->buffer
+	)
+);
+
 #endif /* _TRACE_RPCRDMA_H */
 
 #include <trace/define_trace.h>
diff --git a/net/sunrpc/xprtrdma/Makefile b/net/sunrpc/xprtrdma/Makefile
index 3232aa23cdb4..f69456dffe87 100644
--- a/net/sunrpc/xprtrdma/Makefile
+++ b/net/sunrpc/xprtrdma/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SUNRPC_XPRT_RDMA) += rpcrdma.o
 
-rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o \
+rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o pool.o \
 	svc_rdma.o svc_rdma_backchannel.o svc_rdma_transport.o \
 	svc_rdma_sendto.o svc_rdma_recvfrom.o svc_rdma_rw.o \
 	svc_rdma_pcl.o module.o
diff --git a/net/sunrpc/xprtrdma/pool.c b/net/sunrpc/xprtrdma/pool.c
new file mode 100644
index 000000000000..87404f1fc5bc
--- /dev/null
+++ b/net/sunrpc/xprtrdma/pool.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ *
+ * Pools for RPC-over-RDMA Receive buffers.
+ *
+ * A buffer pool attempts to conserve both the number of DMA mappings
+ * and the device's IOVA space by collecting small buffers together
+ * into a shard that has a single DMA mapping.
+ *
+ * API Contract:
+ *  - Buffers contained in one rpcrdma_pool instance are the same
+ *    size (rp_bufsize), no larger than RPCRDMA_MAX_INLINE_THRESH
+ *  - Buffers in one rpcrdma_pool instance are automatically released
+ *    when the pool instance is destroyed
+ *
+ * Future work:
+ *   - Manage pool resources by reference count
+ */
+
+#include <linux/list.h>
+#include <linux/xarray.h>
+#include <linux/sunrpc/svc_rdma.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "xprt_rdma.h"
+#include "pool.h"
+
+#include <trace/events/rpcrdma.h>
+
+/*
+ * An idr would give near perfect pool ID uniqueness, but for
+ * the moment the pool ID is used only for observability, not
+ * correctness.
+ */
+static atomic_t rpcrdma_pool_id;
+
+struct rpcrdma_pool {
+	struct xarray		rp_xa;
+	struct ib_pd		*rp_pd;
+	size_t			rp_shardsize;	// in bytes
+	size_t			rp_bufsize;	// in bytes
+	unsigned int		rp_bufs_per_shard;
+	unsigned int		rp_pool_id;
+};
+
+struct rpcrdma_pool_shard {
+	struct page		*pc_pages;
+	u8			*pc_cpu_addr;
+	u64			pc_mapped_addr;
+	unsigned long		*pc_bitmap;
+};
+
+/*
+ * For good NUMA awareness, ensure that the shard is allocated on
+ * the NUMA node that the underlying device is affined to.
+ *
+ * For the shard buffer, we really want alloc_pages_node rather
+ * than kmalloc_node.
+ */
+static struct rpcrdma_pool_shard *
+rpcrdma_pool_shard_alloc(struct rpcrdma_pool *pool, gfp_t flags)
+{
+	struct ib_device *device = pool->rp_pd->device;
+	int numa_node = ibdev_to_node(device);
+	struct rpcrdma_pool_shard *shard;
+	size_t bmap_size;
+
+	shard = kmalloc_node(sizeof(*shard), flags, numa_node);
+	if (!shard)
+		goto fail;
+
+	bmap_size = BITS_TO_LONGS(pool->rp_bufs_per_shard) * sizeof(unsigned long);
+	shard->pc_bitmap = kzalloc(bmap_size, flags);
+	if (!shard->pc_bitmap)
+		goto free_shard;
+
+	shard->pc_pages = alloc_pages_node(numa_node, flags,
+					   get_order(pool->rp_shardsize));
+	if (!shard->pc_pages)
+		goto free_bitmap;
+
+	shard->pc_cpu_addr = page_address(shard->pc_pages);
+	shard->pc_mapped_addr = ib_dma_map_single(device, shard->pc_cpu_addr,
+						  pool->rp_shardsize,
+						  DMA_FROM_DEVICE);
+	if (ib_dma_mapping_error(device, shard->pc_mapped_addr))
+		goto free_iobuf;
+
+	return shard;
+
+free_iobuf:
+	__free_pages(shard->pc_pages, get_order(pool->rp_shardsize));
+free_bitmap:
+	kfree(shard->pc_bitmap);
+free_shard:
+	kfree(shard);
+fail:
+	return NULL;
+}
+
+static void
+rpcrdma_pool_shard_free(struct rpcrdma_pool *pool,
+			struct rpcrdma_pool_shard *shard)
+{
+	ib_dma_unmap_single(pool->rp_pd->device, shard->pc_mapped_addr,
+			    pool->rp_shardsize, DMA_FROM_DEVICE);
+
+	__free_pages(shard->pc_pages, get_order(pool->rp_shardsize));
+	kfree(shard->pc_bitmap);
+	kfree(shard);
+}
+
+/**
+ * rpcrdma_pool_create - Allocate an rpcrdma_pool instance
+ * @pd: RDMA protection domain to be used for the pool's buffers
+ * @bufsize: Size, in bytes, of all buffers in the pool
+ * @flags: GFP flags to be used during pool creation
+ *
+ * Returns a pointer to an opaque rpcrdma_pool instance, or NULL. If
+ * a pool instance is returned, caller must free the instance using
+ * rpcrdma_pool_destroy().
+ */
+struct rpcrdma_pool *rpcrdma_pool_create(struct ib_pd *pd, size_t bufsize,
+					 gfp_t flags)
+{
+	struct rpcrdma_pool *pool;
+
+	pool = kmalloc(sizeof(*pool), flags);
+	if (!pool)
+		return NULL;
+
+	xa_init_flags(&pool->rp_xa, XA_FLAGS_ALLOC);
+	pool->rp_pd = pd;
+	pool->rp_shardsize = RPCRDMA_MAX_INLINE_THRESH;
+	pool->rp_bufsize = bufsize;
+	pool->rp_bufs_per_shard = pool->rp_shardsize / pool->rp_bufsize;
+	pool->rp_pool_id = atomic_inc_return(&rpcrdma_pool_id);
+
+	trace_rpcrdma_pool_create(pool->rp_pool_id, pool->rp_bufsize);
+	return pool;
+}
+
+/**
+ * rpcrdma_pool_destroy - Release resources owned by @pool
+ * @pool: buffer pool instance that will no longer be used
+ *
+ * This call releases all buffers in @pool that were allocated
+ * via rpcrdma_pool_buffer_alloc().
+ */
+void
+rpcrdma_pool_destroy(struct rpcrdma_pool *pool)
+{
+	struct rpcrdma_pool_shard *shard;
+	unsigned long index;
+
+	trace_rpcrdma_pool_destroy(pool->rp_pool_id);
+
+	xa_for_each(&pool->rp_xa, index, shard) {
+		trace_rpcrdma_pool_shard_free(pool->rp_pool_id, index);
+		xa_erase(&pool->rp_xa, index);
+		rpcrdma_pool_shard_free(pool, shard);
+	}
+
+	xa_destroy(&pool->rp_xa);
+	kfree(pool);
+}
+
+/**
+ * rpcrdma_pool_buffer_alloc - Allocate a buffer from @pool
+ * @pool: buffer pool from which to allocate the buffer
+ * @flags: GFP flags used during this allocation
+ * @cpu_addr: CPU address of the buffer
+ * @sge: OUT: an initialized scatter-gather entry
+ *
+ * Return values:
+ *   %true: @cpu_addr and @mapped_addr are filled in with a DMA-mapped buffer
+ *   %false: No buffer is available
+ *
+ * When rpcrdma_pool_buffer_alloc() is successful, the returned
+ * buffer is freed automatically when the buffer pool is released
+ * by rpcrdma_pool_destroy().
+ */
+bool
+rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
+			  void **cpu_addr, struct ib_sge *sge)
+{
+	struct rpcrdma_pool_shard *shard;
+	u64 returned_mapped_addr;
+	void *returned_cpu_addr;
+	unsigned long index;
+	u32 id;
+
+	xa_for_each(&pool->rp_xa, index, shard) {
+		unsigned int i;
+
+		returned_cpu_addr = shard->pc_cpu_addr;
+		returned_mapped_addr = shard->pc_mapped_addr;
+		for (i = 0; i < pool->rp_bufs_per_shard; i++) {
+			if (!test_and_set_bit(i, shard->pc_bitmap)) {
+				returned_cpu_addr += i * pool->rp_bufsize;
+				returned_mapped_addr += i * pool->rp_bufsize;
+				goto out;
+			}
+		}
+	}
+
+	shard = rpcrdma_pool_shard_alloc(pool, flags);
+	if (!shard)
+		return false;
+	set_bit(0, shard->pc_bitmap);
+	returned_cpu_addr = shard->pc_cpu_addr;
+	returned_mapped_addr = shard->pc_mapped_addr;
+
+	if (xa_alloc(&pool->rp_xa, &id, shard, xa_limit_16b, flags) != 0) {
+		rpcrdma_pool_shard_free(pool, shard);
+		return false;
+	}
+	trace_rpcrdma_pool_shard_new(pool->rp_pool_id, id);
+
+out:
+	*cpu_addr = returned_cpu_addr;
+	sge->addr = returned_mapped_addr;
+	sge->length = pool->rp_bufsize;
+	sge->lkey = pool->rp_pd->local_dma_lkey;
+
+	trace_rpcrdma_pool_buffer(pool->rp_pool_id, returned_cpu_addr);
+	return true;
+}
+
+/**
+ * rpcrdma_pool_buffer_sync - Sync the contents of a pool buffer after I/O
+ * @pool: buffer pool to which the buffer belongs
+ * @sge: SGE containing the DMA-mapped buffer address and length
+ */
+void rpcrdma_pool_buffer_sync(struct rpcrdma_pool *pool, struct ib_sge *sge)
+{
+	ib_dma_sync_single_for_cpu(pool->rp_pd->device, sge->addr,
+				   sge->length, DMA_FROM_DEVICE);
+}
diff --git a/net/sunrpc/xprtrdma/pool.h b/net/sunrpc/xprtrdma/pool.h
new file mode 100644
index 000000000000..9c8ec8723884
--- /dev/null
+++ b/net/sunrpc/xprtrdma/pool.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ *
+ * Pools for RDMA Receive buffers.
+ */
+
+#ifndef RPCRDMA_POOL_H
+#define RPCRDMA_POOL_H
+
+struct rpcrdma_pool;
+
+struct rpcrdma_pool *rpcrdma_pool_create(struct ib_pd *pd, size_t bufsize,
+					 gfp_t flags);
+void rpcrdma_pool_destroy(struct rpcrdma_pool *pool);
+bool rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
+			       void **cpu_addr, struct ib_sge *sge);
+void rpcrdma_pool_buffer_sync(struct rpcrdma_pool *pool, struct ib_sge *sge);
+
+#endif /* RPCRDMA_POOL_H */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e7e4a39ca6c6..704f6d5fa3e6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -104,9 +104,9 @@
 #include <linux/sunrpc/svc_rdma.h>
 
 #include "xprt_rdma.h"
-#include <trace/events/rpcrdma.h>
+#include "pool.h"
 
-static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
+#include <trace/events/rpcrdma.h>
 
 static inline struct svc_rdma_recv_ctxt *
 svc_rdma_next_recv_ctxt(struct list_head *list)
@@ -115,14 +115,14 @@ svc_rdma_next_recv_ctxt(struct list_head *list)
 					rc_list);
 }
 
+static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
+
 static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
 	int node = ibdev_to_node(rdma->sc_cm_id->device);
 	struct svc_rdma_recv_ctxt *ctxt;
 	unsigned long pages;
-	dma_addr_t addr;
-	void *buffer;
 
 	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
 	ctxt = kzalloc_node(struct_size(ctxt, rc_pages, pages),
@@ -130,13 +130,10 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	if (!ctxt)
 		goto fail0;
 	ctxt->rc_maxpages = pages;
-	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
-	if (!buffer)
+
+	if (!rpcrdma_pool_buffer_alloc(rdma->sc_recv_pool, GFP_KERNEL,
+				       &ctxt->rc_recv_buf, &ctxt->rc_recv_sge))
 		goto fail1;
-	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
-				 rdma->sc_max_req_size, DMA_FROM_DEVICE);
-	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
-		goto fail2;
 
 	svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
 	pcl_init(&ctxt->rc_call_pcl);
@@ -149,30 +146,15 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->rc_recv_wr.sg_list = &ctxt->rc_recv_sge;
 	ctxt->rc_recv_wr.num_sge = 1;
 	ctxt->rc_cqe.done = svc_rdma_wc_receive;
-	ctxt->rc_recv_sge.addr = addr;
-	ctxt->rc_recv_sge.length = rdma->sc_max_req_size;
-	ctxt->rc_recv_sge.lkey = rdma->sc_pd->local_dma_lkey;
-	ctxt->rc_recv_buf = buffer;
 	svc_rdma_cc_init(rdma, &ctxt->rc_cc);
 	return ctxt;
 
-fail2:
-	kfree(buffer);
 fail1:
 	kfree(ctxt);
 fail0:
 	return NULL;
 }
 
-static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
-				       struct svc_rdma_recv_ctxt *ctxt)
-{
-	ib_dma_unmap_single(rdma->sc_pd->device, ctxt->rc_recv_sge.addr,
-			    ctxt->rc_recv_sge.length, DMA_FROM_DEVICE);
-	kfree(ctxt->rc_recv_buf);
-	kfree(ctxt);
-}
-
 /**
  * svc_rdma_recv_ctxts_destroy - Release all recv_ctxt's for an xprt
  * @rdma: svcxprt_rdma being torn down
@@ -185,8 +167,9 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
 
 	while ((node = llist_del_first(&rdma->sc_recv_ctxts))) {
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
-		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
+		kfree(ctxt);
 	}
+	rpcrdma_pool_destroy(rdma->sc_recv_pool);
 }
 
 /**
@@ -307,6 +290,12 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
 	unsigned int total;
 
+	rdma->sc_recv_pool = rpcrdma_pool_create(rdma->sc_pd,
+						 rdma->sc_max_req_size,
+						 GFP_KERNEL);
+	if (!rdma->sc_recv_pool)
+		return false;
+
 	/* For each credit, allocate enough recv_ctxts for one
 	 * posted Receive and one RPC in process.
 	 */
@@ -962,9 +951,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		return 0;
 
 	percpu_counter_inc(&svcrdma_stat_recv);
-	ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
-				   ctxt->rc_recv_sge.addr, ctxt->rc_byte_len,
-				   DMA_FROM_DEVICE);
+	rpcrdma_pool_buffer_sync(rdma_xprt->sc_recv_pool, &ctxt->rc_recv_sge);
 	svc_rdma_build_arg_xdr(rqstp, ctxt);
 
 	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg, ctxt);
-- 
2.50.0


