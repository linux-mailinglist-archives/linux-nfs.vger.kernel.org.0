Return-Path: <linux-nfs+bounces-13568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34BB21691
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 22:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360F217B5AF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2752DBF5E;
	Mon, 11 Aug 2025 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAD1dniE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B226AA91;
	Mon, 11 Aug 2025 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944542; cv=none; b=GjaidN2k5sCNOYWC26EbYzap+GYHhvEix7P2R5vZhxri1dWyqFWxtsk7FcZWHsKbY4OP3raY/XT1ZdPtWtosGEehIn9FO5JhRTXfhx57TVcddqo6pT1T6b37VAXhEJvrkHbFut856k0v0isuAh/bEEEn+JlnVzuKsyG6IGWuCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944542; c=relaxed/simple;
	bh=+wrMYAXVu57IfOqOJCw3l6xiG+9Ojk+54cYW2ocE7xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Or91+eXUyD+b50PaNzh3/QqJ1qgcC7LuJydywhgta9s3a8nSZg+naWvyBrXaCoYZEVunuMoMoAc3GUaQgNKtI4NOoVXCUeTmpTOlNst/mJ34MPhQi2XvHxtLT9x+O0XdU5VldxPFkbMAXusQf8zyXvwU4O4FErbexxpP0Pb1qSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAD1dniE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96938C4CEED;
	Mon, 11 Aug 2025 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754944542;
	bh=+wrMYAXVu57IfOqOJCw3l6xiG+9Ojk+54cYW2ocE7xI=;
	h=From:To:Cc:Subject:Date:From;
	b=QAD1dniE3qoch5CSZRfhgKeKO4F8ASLPz/z3sM5yUIGwFyWxtbPrc/vDOnfUxoFbe
	 czcCHsvNwCVfvCGv661Dmttl7te/nbZCu7WXcLY7z4B/i7gcir5lYmYhT979+an4uM
	 F7KEsF5xDt3Hd7Qk8a5e2CzqTXO70GQn6BMeJ1gza+Mj6lNt/2fnP24s3vvGHt+yiU
	 Pb4ZrKpx+hqWa2qwtNRQEDX+r5hWL/WOfoLJPkSCagwCPS5TO8MVoFeM8zbEpmKFCH
	 48ZZq9wOv/WWZgS+rQZm1HTOpEmqyos5OqiGaAmLqdoz/uPZe+h7i5mx3bmdVDE1Ux
	 s+lMOUtggRj5g==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2] svcrdma: Introduce Receive buffer arenas
Date: Mon, 11 Aug 2025 16:35:39 -0400
Message-ID: <20250811203539.1702-1-cel@kernel.org>
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
 include/trace/events/rpcrdma.h          |  99 +++++++++++
 net/sunrpc/xprtrdma/Makefile            |   2 +-
 net/sunrpc/xprtrdma/pool.c              | 223 ++++++++++++++++++++++++
 net/sunrpc/xprtrdma/pool.h              |  25 +++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  43 ++---
 6 files changed, 370 insertions(+), 25 deletions(-)
 create mode 100644 net/sunrpc/xprtrdma/pool.c
 create mode 100644 net/sunrpc/xprtrdma/pool.h

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
index 000000000000..e285c3e9c38e
--- /dev/null
+++ b/net/sunrpc/xprtrdma/pool.c
@@ -0,0 +1,223 @@
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
+ *  - Buffers in one rpcrdma_pool instance are mapped using the same
+ *    DMA direction
+ *  - Buffers in one rpcrdma_pool instance are automatically released
+ *    when the instance is destroyed
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
+	struct ib_device	*rp_device;
+	size_t			rp_shardsize;	// in bytes
+	size_t			rp_bufsize;	// in bytes
+	enum dma_data_direction	rp_direction;
+	unsigned int		rp_bufs_per_shard;
+	unsigned int		rp_pool_id;
+};
+
+struct rpcrdma_pool_shard {
+	u8			*pc_cpu_addr;
+	u64			pc_mapped_addr;
+	unsigned long		*pc_bitmap;
+};
+
+static struct rpcrdma_pool_shard *
+rpcrdma_pool_shard_alloc(struct rpcrdma_pool *pool, gfp_t flags)
+{
+	struct rpcrdma_pool_shard *shard;
+	size_t bmap_size;
+
+	shard = kmalloc(sizeof(*shard), flags);
+	if (!shard)
+		goto fail;
+
+	bmap_size = BITS_TO_LONGS(pool->rp_bufs_per_shard) * sizeof(unsigned long);
+	shard->pc_bitmap = kzalloc(bmap_size, flags);
+	if (!shard->pc_bitmap)
+		goto free_shard;
+
+	/*
+	 * For good NUMA awareness, allocate the shard's I/O buffer
+	 * on the NUMA node that the underlying device is affined to.
+	 */
+	shard->pc_cpu_addr = kmalloc_node(pool->rp_shardsize, flags,
+					  ibdev_to_node(pool->rp_device));
+	if (!shard->pc_cpu_addr)
+		goto free_bitmap;
+	shard->pc_mapped_addr = ib_dma_map_single(pool->rp_device,
+						  shard->pc_cpu_addr,
+						  pool->rp_shardsize,
+						  pool->rp_direction);
+	if (ib_dma_mapping_error(pool->rp_device, shard->pc_mapped_addr))
+		goto free_iobuf;
+
+	return shard;
+
+free_iobuf:
+	kfree(shard->pc_cpu_addr);
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
+	ib_dma_unmap_single(pool->rp_device, shard->pc_mapped_addr,
+			    pool->rp_shardsize, pool->rp_direction);
+	kfree(shard->pc_cpu_addr);
+	kfree(shard->pc_bitmap);
+	kfree(shard);
+}
+
+/**
+ * rpcrdma_pool_create - Allocate and initialize an rpcrdma_pool instance
+ * @args: pool creation arguments
+ * @flags: GFP flags used during pool creation
+ *
+ * Returns a pointer to an opaque rpcrdma_pool instance or
+ * NULL. If a pool instance is returned, caller must free the
+ * returned instance using rpcrdma_pool_destroy().
+ */
+struct rpcrdma_pool *
+rpcrdma_pool_create(struct rpcrdma_pool_args *args, gfp_t flags)
+{
+	struct rpcrdma_pool *pool;
+
+	pool = kmalloc(sizeof(*pool), flags);
+	if (!pool)
+		return NULL;
+
+	xa_init_flags(&pool->rp_xa, XA_FLAGS_ALLOC);
+	pool->rp_device = args->pa_device;
+	pool->rp_shardsize = RPCRDMA_MAX_INLINE_THRESH;
+	pool->rp_bufsize = args->pa_bufsize;
+	pool->rp_direction = args->pa_direction;
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
+ * @mapped_addr: mapped address of the buffer
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
+			  void **cpu_addr, u64 *mapped_addr)
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
+	*mapped_addr = returned_mapped_addr;
+
+	trace_rpcrdma_pool_buffer(pool->rp_pool_id, returned_cpu_addr);
+	return true;
+}
diff --git a/net/sunrpc/xprtrdma/pool.h b/net/sunrpc/xprtrdma/pool.h
new file mode 100644
index 000000000000..214f8fe78b9a
--- /dev/null
+++ b/net/sunrpc/xprtrdma/pool.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ *
+ * Pools for Send and Receive buffers.
+ */
+
+#ifndef RPCRDMA_POOL_H
+#define RPCRDMA_POOL_H
+
+struct rpcrdma_pool_args {
+	struct ib_device	*pa_device;
+	size_t			pa_bufsize;
+	enum dma_data_direction	pa_direction;
+};
+
+struct rpcrdma_pool;
+
+struct rpcrdma_pool *
+rpcrdma_pool_create(struct rpcrdma_pool_args *args, gfp_t flags);
+void rpcrdma_pool_destroy(struct rpcrdma_pool *pool);
+bool rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
+			       void **cpu_addr, u64 *mapped_addr);
+
+#endif /* RPCRDMA_POOL_H */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e7e4a39ca6c6..f625f1ede434 100644
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
@@ -130,13 +130,11 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	if (!ctxt)
 		goto fail0;
 	ctxt->rc_maxpages = pages;
-	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
-	if (!buffer)
+
+	if (!rpcrdma_pool_buffer_alloc(rdma->sc_recv_pool, GFP_KERNEL,
+				       &ctxt->rc_recv_buf,
+				       &ctxt->rc_recv_sge.addr))
 		goto fail1;
-	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
-				 rdma->sc_max_req_size, DMA_FROM_DEVICE);
-	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
-		goto fail2;
 
 	svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
 	pcl_init(&ctxt->rc_call_pcl);
@@ -149,30 +147,17 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->rc_recv_wr.sg_list = &ctxt->rc_recv_sge;
 	ctxt->rc_recv_wr.num_sge = 1;
 	ctxt->rc_cqe.done = svc_rdma_wc_receive;
-	ctxt->rc_recv_sge.addr = addr;
 	ctxt->rc_recv_sge.length = rdma->sc_max_req_size;
 	ctxt->rc_recv_sge.lkey = rdma->sc_pd->local_dma_lkey;
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
@@ -185,8 +170,9 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
 
 	while ((node = llist_del_first(&rdma->sc_recv_ctxts))) {
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
-		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
+		kfree(ctxt);
 	}
+	rpcrdma_pool_destroy(rdma->sc_recv_pool);
 }
 
 /**
@@ -305,8 +291,17 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
  */
 bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
+	struct rpcrdma_pool_args args = {
+		.pa_device	= rdma->sc_cm_id->device,
+		.pa_bufsize	= rdma->sc_max_req_size,
+		.pa_direction	= DMA_FROM_DEVICE,
+	};
 	unsigned int total;
 
+	rdma->sc_recv_pool = rpcrdma_pool_create(&args, GFP_KERNEL);
+	if (!rdma->sc_recv_pool)
+		return false;
+
 	/* For each credit, allocate enough recv_ctxts for one
 	 * posted Receive and one RPC in process.
 	 */
-- 
2.50.0


