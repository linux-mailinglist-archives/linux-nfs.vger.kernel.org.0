Return-Path: <linux-nfs+bounces-13522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2AAB1EE75
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 20:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312533A03B9
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547FD20297C;
	Fri,  8 Aug 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVT4Uib8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3EE1361;
	Fri,  8 Aug 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678812; cv=none; b=BoGSbjPUq4nWlWp8wtkfRfWMkVPPEhezqaYrja4bag1+eETKc0YipdqqEKtL0te6bSz2M9SmPDrriL+j37aLDjsWbwhl8Dk73VAyf+zsqJ0ZL1YatuyHgKk5I4ktU8NOKiNZiBGBb80gmlCfK/UjlIW6Mq2FKsG+iOzLSAFCQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678812; c=relaxed/simple;
	bh=dFLZiPoSw3LaxzIiYREnQ+3wF1AR454Fh8fo9S3GhMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8DZkf1aUZS97dCKHxje2jLzJmn7tVTwgKWzi6GFdR6rLMkPbHirQx09OHYHLiIdpyXEPtDwVKehR2FBpeRyBs/3qvyJNZOuCzhC+bg67Mb/UtB78le8aEI8EA7ixr33VFb0yeGHlzFrmfCSCjFio93wZ+sWodEXxtcHw0HxTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVT4Uib8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3367DC4CEED;
	Fri,  8 Aug 2025 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754678811;
	bh=dFLZiPoSw3LaxzIiYREnQ+3wF1AR454Fh8fo9S3GhMg=;
	h=From:To:Cc:Subject:Date:From;
	b=ZVT4Uib8hi1AeoVie9vq+KlZuBpZTYWRcvVA4bjrLMpl/ZzmXLyYzv4mB6ioMH/fJ
	 HQYm+6CoYzox3kSsCwSuYTjjXGbo7mYBq8fyoEILPibwUKdJAcpkf3wiRuUIt8+E5B
	 aJuaBxWANiU1SyRP2z+tnRRg1FCM6Fg1FXE8RLkvvmZZ+z4gtdujgmusrK/OEWEHGF
	 fvjShcupgQN3WZG8tydF8W6oJSL/+bCpK056KkcFQ+ceImUW/+8dYPo3U190Dq9OVh
	 a9dVpBWfzkAdrJzonVZXF0SjJ099bnWq8idwWwujlUQpAOSPzvObMloeFnhabpM0EB
	 zK3QYJJXKYVdQ==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] svcrdma: Introduce Receive buffer arenas
Date: Fri,  8 Aug 2025 14:46:48 -0400
Message-ID: <20250808184648.120866-1-cel@kernel.org>
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
management TLBs by combining each connection's Receive buffers into
a single IOVA.

I don't have a good way to measure whether this approach is
effective.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |   3 +
 net/sunrpc/xprtrdma/Makefile            |   2 +-
 net/sunrpc/xprtrdma/pool.c              | 162 ++++++++++++++++++++++++
 net/sunrpc/xprtrdma/pool.h              |  25 ++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  43 +++----
 5 files changed, 210 insertions(+), 25 deletions(-)
 create mode 100644 net/sunrpc/xprtrdma/pool.c
 create mode 100644 net/sunrpc/xprtrdma/pool.h

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
index 000000000000..ef338528a594
--- /dev/null
+++ b/net/sunrpc/xprtrdma/pool.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ *
+ * Pools for Send and Receive buffers.
+ *
+ * A buffer pool attempts to conserve both the number of DMA mappings
+ * and the device's IOVA space by collecting small buffers together
+ * into a chunk that has a single DMA mapping.
+ *
+ * Future work:
+ *   - Manage pool resources by reference count
+ *   - Manage chunk free space via a bitmap
+ */
+
+#include <linux/list.h>
+#include <linux/sunrpc/svc_rdma.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "pool.h"
+
+struct rpcrdma_pool {
+	struct list_head	rp_chunk_list;
+
+	struct ib_device	*rp_device;
+	size_t			rp_chunksize;
+	size_t			rp_bufsize;
+	enum dma_data_direction	rp_direction;
+};
+
+struct rpcrdma_pool_chunk {
+	struct list_head	pc_next_chunk;
+
+	u8			*pc_cpu_addr;
+	dma_addr_t		pc_dma_addr;
+	size_t			pc_free_start;
+};
+
+static struct rpcrdma_pool_chunk *
+rpcrdma_pool_chunk_create(struct rpcrdma_pool *pool, gfp_t flags)
+{
+	struct rpcrdma_pool_chunk *chunk;
+
+	chunk = kmalloc(sizeof(*chunk), flags);
+	if (!chunk)
+		return NULL;
+	chunk->pc_cpu_addr = kmalloc_node(pool->rp_chunksize, flags,
+					  ibdev_to_node(pool->rp_device));
+	if (!chunk->pc_cpu_addr) {
+		kfree(chunk);
+		return NULL;
+	}
+	chunk->pc_dma_addr = ib_dma_map_single(pool->rp_device,
+					       chunk->pc_cpu_addr,
+					       pool->rp_chunksize,
+					       pool->rp_direction);
+	if (ib_dma_mapping_error(pool->rp_device, chunk->pc_dma_addr)) {
+		kfree(chunk->pc_cpu_addr);
+		kfree(chunk);
+		return NULL;
+	}
+
+	chunk->pc_free_start = 0;
+	return chunk;
+}
+
+/**
+ * rpcrdma_pool_create - Initialize a buffer pool
+ * @args: pool creation arguments
+ * @flags: GFP flags for pool creation
+ *
+ * Returns a pointer to an opaque rpcrdma_pool object or
+ * NULL. If a pool object is returned, caller must free the
+ * returned object using rpcrdma_pool_destroy().
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
+	INIT_LIST_HEAD(&pool->rp_chunk_list);
+	pool->rp_device = args->pa_device;
+	pool->rp_chunksize = RPCRDMA_MAX_INLINE_THRESH;
+	pool->rp_bufsize = args->pa_bufsize;
+	pool->rp_direction = args->pa_direction;
+	return pool;
+}
+
+/**
+ * rpcrdma_pool_destroy - Release resources owned by a buffer pool
+ * @pool: buffer pool object that will no longer be used
+ */
+void
+rpcrdma_pool_destroy(struct rpcrdma_pool *pool)
+{
+	struct rpcrdma_pool_chunk *chunk;
+
+	while (!list_empty(&pool->rp_chunk_list)) {
+		chunk = list_first_entry(&pool->rp_chunk_list,
+					 struct rpcrdma_pool_chunk,
+					 pc_next_chunk);
+		list_del(&chunk->pc_next_chunk);
+		ib_dma_unmap_single(pool->rp_device, chunk->pc_dma_addr,
+				    pool->rp_chunksize, pool->rp_direction);
+		kfree(chunk->pc_cpu_addr);
+		kfree(chunk);
+	}
+	kfree(pool);
+}
+
+static struct rpcrdma_pool_chunk *
+rpcrdma_pool_find_chunk(struct rpcrdma_pool *pool, gfp_t flags)
+{
+	struct rpcrdma_pool_chunk *chunk;
+
+	list_for_each_entry(chunk, &pool->rp_chunk_list, pc_next_chunk) {
+		size_t remaining = pool->rp_chunksize - chunk->pc_free_start;
+
+		if (pool->rp_bufsize >= remaining)
+			return chunk;
+	}
+
+	chunk = rpcrdma_pool_chunk_create(pool, flags);
+	if (chunk)
+		list_add(&chunk->pc_next_chunk, &pool->rp_chunk_list);
+	return chunk;
+}
+
+/**
+ * rpcrdma_pool_alloc_buffer - Allocate a buffer from a pool
+ * @pool: buffer pool from which to allocate the buffer
+ * @flags: GFP flags for the allocation
+ * @cpu_addr: CPU address of the buffer
+ * @dma_addr: mapped DMA address of the buffer
+ *
+ * Return values:
+ *   %true: @cpu_addr and @dma_addr are filled in with a DMA-mapped buffer
+ *   %false: No buffer is available
+ *
+ * When successful, the returned buffer is freed automatically when the
+ * buffer pool is released by rpcrdma_pool_destroy().
+ */
+bool
+rpcrdma_pool_alloc_buffer(struct rpcrdma_pool *pool, gfp_t flags,
+			  void **cpu_addr, dma_addr_t *dma_addr)
+{
+	struct rpcrdma_pool_chunk *chunk;
+
+	chunk = rpcrdma_pool_find_chunk(pool, flags);
+	if (!chunk)
+		return false;
+
+	*cpu_addr = chunk->pc_cpu_addr + chunk->pc_free_start;
+	*dma_addr = chunk->pc_dma_addr + chunk->pc_free_start;
+	chunk->pc_free_start += pool->rp_bufsize;
+	return true;
+}
diff --git a/net/sunrpc/xprtrdma/pool.h b/net/sunrpc/xprtrdma/pool.h
new file mode 100644
index 000000000000..666543e22b5b
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
+bool rpcrdma_pool_alloc_buffer(struct rpcrdma_pool *pool, gfp_t flags,
+			       void **cpu_addr, dma_addr_t *dma_addr);
+
+#endif /* RPCRDMA_POOL_H */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e7e4a39ca6c6..8f0328d899d6 100644
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
+	if (!rpcrdma_pool_alloc_buffer(rdma->sc_recv_pool, GFP_KERNEL,
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


