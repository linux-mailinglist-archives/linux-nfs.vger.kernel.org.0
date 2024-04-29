Return-Path: <linux-nfs+bounces-3062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF95B8B5DA9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385A41F242B5
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5444C127E05;
	Mon, 29 Apr 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci3FB8rc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460382D66;
	Mon, 29 Apr 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404347; cv=none; b=UjoH/ZrQqT9tkd4GeO/lbdRengJV1kcFyf+Jx1OIXFT6LJg6b0sGTDY2BwaW1XcDZVBTIiJwW0GvoJVXlPmcFuIHT5Mcg+LS5CmLc/Mh1zc8iTmxjr0jy+alEPb4RnCBZFCs/gKwPuFwDzprbNTfNGLS33VGv8pGiISIV7+HWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404347; c=relaxed/simple;
	bh=wb5J0O2tSSIZAlZWpMSKSpqG+aU95kjnpuduXitZFSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G82S7ScPkKDmJ512bG6NNKeABKnKalSshgVDxhvzzAMI+ktNv9vx/z3rkntCmHP2bAwwqTQWs8oud5SGkGsnqy+jhctMbpaDJwwJ8J/0rEo9QpX3OJILzWKwC/46B/NSFgKPd5aHqhRm29QKTMaN0saDDEEm5zRool8XFAu7imM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci3FB8rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F294C4AF14;
	Mon, 29 Apr 2024 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714404346;
	bh=wb5J0O2tSSIZAlZWpMSKSpqG+aU95kjnpuduXitZFSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ci3FB8rcIrFqkXrgWbekAOWtOw6ebmuD0CmtR1MN0ZnI79hQHVs9mY7ZY6lB3gEkq
	 HUuTgvo2Tx7JbshJhD06Y9qQIKz3uzcgEndNlzJcM6vj+ZMRA7XOth6EHovJ7ma6QG
	 HpW5XGV/wuD9tjKBQ5vsocgBeYCJSa8JS08CZkJv40e+8ZyBM9nUGtQjRAmEvfBIOG
	 AhIsrNKKARB+mVJuxGRpOFdkn+a1XI7DiE2xcJLZuDhrpjpcphVtuTuiegih8rICRo
	 2fWLqYND5hp3PVy/nViG7DjKxWqCiBgMmLq1mtMdx+Kd4ZSQT5m5gmj/ns3yJacVyj
	 ePxm62v9Cassg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/4] xprtrdma: Delay releasing connection hardware resources
Date: Mon, 29 Apr 2024 11:25:41 -0400
Message-ID: <20240429152537.212958-9-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429152537.212958-6-cel@kernel.org>
References: <20240429152537.212958-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8400; i=chuck.lever@oracle.com; h=from:subject; bh=OYkQ/NF3NTAWlR/nAswSjjfmIkUb8wLKSPlbH5UhdGE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7vyOIJ2Wsp4jV5PQ2ghK0k+jBRjwRrVJRA9M RDafhOFfJ6JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+78gAKCRAzarMzb2Z/ lzxqD/wMiRmygt9tXm2WggHHoMX/lWwDOwp4NPZ6QmutNiQNrDV22h/nXBl5kM75cBTr290QBb3 T6nE5eV+Ptex1Z7IHSL/IRDAkCpK+jgDf05TPOuzBQmItslHRTKTUfQJHOf+xehC5khpK3Naxp0 QZzKg4R8/pLyuL4d8dlUzdW4AVZBBnlZQonJZ7QOYWP2YgcUqrUZAmI9UCkm041LZ2gLuFhF7im 6nr1/lXCY2PctXe0m+HvruBi2kh/Hhh+yvthP2XuXX6BE46hDoG8dnEGkFkPvm82SVPmPdPmlSJ 4Yx7xCMMRX4i4DVFs58HptcCJZzVoZTAhUb3v/le+zRPCi4FDXVrvKHN/Wy3QEAafzcKvlsPSWj T7zmF5TehqwDgd/q+p0BHWIULmTC5RdXvWh/ygK12XZ6TrHTho82D7695M/ZlgL49EAZCatNysX FJGDBV4ndfSx69u/KYu7Ar6W6zD6bswCPugN5Ga5cmsIR56Fi3iLDnpF+YKHjDtLQ3V/r1qkMBM /b5ikyqZV6o0O/HvpL9CCfKOY+oB/HYOLmQiGOGDDNPMqNgAzlR6zCDwZpqpjvNUzOtuJdNmU3I rqHin2dtD/yIo8wTarpGLbEKXbqgApMTg00an2aVamMCVauMMoL2SD+ODNP8yfQojC0mDSQmhm2 ScaO0JwtK3YP3yQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

xprtiod_workqueue is a MEM_RECLAIM-enabled workqueue. However, the
RDMA core API functions are not memory reclaim-safe. This was
partially accomplished by commit 6b1eb3b22272 ("SUNRPC: Replace the
use of the xprtiod WQ in rpcrdma").

This commit addressed the issue in the connect path, but not in the
disconnect path. Thus sometimes a transport disconnect results in
this splat:

workqueue: WQ_MEM_RECLAIM xprtiod:xprt_autoclose [sunrpc] is flushing !WQ_MEM_RECLAIM events_highpri:rpcrdma_mr_refresh_worker [rpcrdma]
WARNING: CPU: 1 PID: 20378 at kernel/workqueue.c:3728 check_flush_dependency+0x101/0x120

 ? check_flush_dependency+0x101/0x120
 ? report_bug+0x175/0x1a0
 ? handle_bug+0x44/0x90
 ? exc_invalid_op+0x1c/0x70
 ? asm_exc_invalid_op+0x1f/0x30
 ? __pfx_rpcrdma_mr_refresh_worker+0x10/0x10 [rpcrdma aefd3d1b298311368fa14fa93ae5fb3818c3aeac]
 ? check_flush_dependency+0x101/0x120
 __flush_work.isra.0+0x20a/0x290
 __cancel_work_sync+0x129/0x1c0
 cancel_work_sync+0x14/0x20
 rpcrdma_xprt_disconnect+0x229/0x3f0 [rpcrdma aefd3d1b298311368fa14fa93ae5fb3818c3aeac]
 xprt_rdma_close+0x16/0x40 [rpcrdma aefd3d1b298311368fa14fa93ae5fb3818c3aeac]
 xprt_autoclose+0x63/0x110 [sunrpc a04d701bce94b5a8fb541cafbe1a489d6b1ab5b3]
 process_one_work+0x19e/0x3f0
 worker_thread+0x340/0x510
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf7/0x130
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x41/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30

Create a context in which it is safe to manage resources that are
not memory reclaim-safe that can be invoked during transport
disconnect. Essentially this means that releasing an rpcrdma_ep is
now done completely asynchronously.

Subsequent patches will move the release of transport resources into
this new context.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218704
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c | 20 +++++++++++++-
 net/sunrpc/xprtrdma/verbs.c     | 46 ++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/xprt_rdma.h |  5 +++-
 3 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 29b0562d62e7..237d78c1ec54 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -761,8 +761,12 @@ static struct xprt_class xprt_rdma = {
 	.netid			= { "rdma", "rdma6", "" },
 };
 
+struct workqueue_struct *rpcrdma_release_wq __read_mostly;
+
 void xprt_rdma_cleanup(void)
 {
+	struct workqueue_struct *wq;
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	if (sunrpc_table_header) {
 		unregister_sysctl_table(sunrpc_table_header);
@@ -772,18 +776,32 @@ void xprt_rdma_cleanup(void)
 
 	xprt_unregister_transport(&xprt_rdma);
 	xprt_unregister_transport(&xprt_rdma_bc);
+
+	wq = rpcrdma_release_wq;
+	rpcrdma_release_wq = NULL;
+	destroy_workqueue(wq);
 }
 
 int xprt_rdma_init(void)
 {
+	struct workqueue_struct *wq;
 	int rc;
 
+	/* provision a WQ that is always unbound and !mem_reclaim */
+	wq = alloc_workqueue("rpcrdma_release", WQ_UNBOUND, 0);
+	if (!wq)
+		return -ENOMEM;
+	rpcrdma_release_wq = wq;
+
 	rc = xprt_register_transport(&xprt_rdma);
-	if (rc)
+	if (rc) {
+		destroy_workqueue(wq);
 		return rc;
+	}
 
 	rc = xprt_register_transport(&xprt_rdma_bc);
 	if (rc) {
+		destroy_workqueue(wq);
 		xprt_unregister_transport(&xprt_rdma);
 		return rc;
 	}
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index c6d9d94c28ba..f1e4a28325fa 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -73,7 +73,7 @@ static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_ep_get(struct rpcrdma_ep *ep);
-static int rpcrdma_ep_put(struct rpcrdma_ep *ep);
+static void rpcrdma_ep_put(struct rpcrdma_ep *ep);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc_node(size_t size, enum dma_data_direction direction,
 			  int node);
@@ -234,15 +234,15 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
 		ep->re_async_rc = 0;
 		complete(&ep->re_done);
-		return 0;
+		break;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 		ep->re_async_rc = -EPROTO;
 		complete(&ep->re_done);
-		return 0;
+		break;
 	case RDMA_CM_EVENT_ROUTE_ERROR:
 		ep->re_async_rc = -ENETUNREACH;
 		complete(&ep->re_done);
-		return 0;
+		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		pr_info("rpcrdma: removing device %s for %pISpc\n",
 			ep->re_id->device->name, sap);
@@ -269,12 +269,13 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 			ep->re_connect_status = -ENOTCONN;
 wake_connect_worker:
 		wake_up_all(&ep->re_connect_wait);
-		return 0;
+		break;
 	case RDMA_CM_EVENT_DISCONNECTED:
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
 		rpcrdma_force_disconnect(ep);
-		return rpcrdma_ep_put(ep);
+		rpcrdma_ep_put(ep);
+		fallthrough;
 	default:
 		break;
 	}
@@ -328,9 +329,13 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 	return ERR_PTR(rc);
 }
 
-static void rpcrdma_ep_destroy(struct kref *kref)
+/* Delayed release of a connection's hardware resources. Releasing
+ * RDMA hardware resources is done in a !MEM_RECLAIM context because
+ * the RDMA core API functions are generally not reclaim-safe.
+ */
+static void rpcrdma_ep_destroy(struct work_struct *work)
 {
-	struct rpcrdma_ep *ep = container_of(kref, struct rpcrdma_ep, re_kref);
+	struct rpcrdma_ep *ep = container_of(work, struct rpcrdma_ep, re_worker);
 
 	if (ep->re_id->qp) {
 		rdma_destroy_qp(ep->re_id);
@@ -348,22 +353,30 @@ static void rpcrdma_ep_destroy(struct kref *kref)
 		ib_dealloc_pd(ep->re_pd);
 	ep->re_pd = NULL;
 
+	if (ep->re_id)
+		rdma_destroy_id(ep->re_id);
+	ep->re_id = NULL;
+
 	kfree(ep);
 	module_put(THIS_MODULE);
 }
 
+static void rpcrdma_ep_release(struct kref *kref)
+{
+	struct rpcrdma_ep *ep = container_of(kref, struct rpcrdma_ep, re_kref);
+
+	INIT_WORK(&ep->re_worker, rpcrdma_ep_destroy);
+	queue_work(rpcrdma_release_wq, &ep->re_worker);
+}
+
 static noinline void rpcrdma_ep_get(struct rpcrdma_ep *ep)
 {
 	kref_get(&ep->re_kref);
 }
 
-/* Returns:
- *     %0 if @ep still has a positive kref count, or
- *     %1 if @ep was destroyed successfully.
- */
-static noinline int rpcrdma_ep_put(struct rpcrdma_ep *ep)
+static noinline void rpcrdma_ep_put(struct rpcrdma_ep *ep)
 {
-	return kref_put(&ep->re_kref, rpcrdma_ep_destroy);
+	kref_put(&ep->re_kref, rpcrdma_ep_release);
 }
 
 static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
@@ -475,7 +488,6 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 
 out_destroy:
 	rpcrdma_ep_put(ep);
-	rdma_destroy_id(id);
 	return rc;
 }
 
@@ -566,10 +578,8 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
 
-	if (rpcrdma_ep_put(ep))
-		rdma_destroy_id(id);
-
 	r_xprt->rx_ep = NULL;
+	rpcrdma_ep_put(ep);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 08bda29ed953..048d2e329384 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -70,7 +70,6 @@
  */
 struct rpcrdma_mr;
 struct rpcrdma_ep {
-	struct kref		re_kref;
 	struct rdma_cm_id 	*re_id;
 	struct ib_pd		*re_pd;
 	unsigned int		re_max_rdma_segs;
@@ -100,6 +99,9 @@ struct rpcrdma_ep {
 	atomic_t		re_completion_ids;
 
 	char			re_write_pad[XDR_UNIT];
+
+	struct kref		re_kref;
+	struct work_struct	re_worker;
 };
 
 /* Pre-allocate extra Work Requests for handling reverse-direction
@@ -583,6 +585,7 @@ void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
 void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
 void xprt_rdma_close(struct rpc_xprt *xprt);
 void xprt_rdma_print_stats(struct rpc_xprt *xprt, struct seq_file *seq);
+extern struct workqueue_struct *rpcrdma_release_wq;
 int xprt_rdma_init(void);
 void xprt_rdma_cleanup(void);
 
-- 
2.44.0


