Return-Path: <linux-nfs+bounces-3546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8A8FBCBC
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FC128314F
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D22F34;
	Tue,  4 Jun 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSwFq3fp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12101372
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530358; cv=none; b=c8wKz4+3LRgOoyWBiSSYh0TOsISZrhCa7MOnyFGxBMxDlsgItvvQmSLI4rnYzBhMOjRQnJM61b+pBMNILekdnOIuXnyu0WPlyMRFr8coEeImhLXspm5q7Z0+8il9p5q82UO81/FMcVVMuwDOfZJLPTJzI0T1yH6X6NTGqYmtUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530358; c=relaxed/simple;
	bh=9Z/H+o73fZELcFt5f0ixfvT3O8kUFye2ASzlrC2TC/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJs/7RCBkywNSUJldk2TMdY8tTcr63vvWD7lqNnKcLn7UudGHaY1jZrQ4tJAOr+1xqygvcFDM86VUNyOEZROWgD8ZFgm7+W3aaGdVfseAL4QZl+aH/sTFCV4Vn74pNUvGISZzewhVNKxl5QqLoUuz24B5zXpe5Tv+7EAJuvuJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSwFq3fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17592C2BBFC;
	Tue,  4 Jun 2024 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717530357;
	bh=9Z/H+o73fZELcFt5f0ixfvT3O8kUFye2ASzlrC2TC/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSwFq3fpd6LBeULO9G0GBialIxiYKtO9Xk+GWZly5EJehqjxF0sEhfJWhvMb6t7po
	 US1wBWbLgljc0S7Enl68tD4ZVsQm7YuhLQoZM53W/ahp/eC+mTJH0xm4DOUaTWxloi
	 yDL74eRX85rHXuVbevM5fGvDj7H4N3hqV91kXDH1D3AHGmGxhOjoC5DzPCMu72G8Jm
	 v7NwXsT7CHc8YnxfmTdS2HsYbLQljT55qPYoR7V1ZGD7TcpelKHDaxZvGB1NZ8alkz
	 0IMsjBQxpP3INom3nyEuHDqxIv5sSygLCypxNRB8+SMahojwntIXHcwRh0Im9Wu3uu
	 NRnkpRson2GwA==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/5] rpcrdma: Implement generic device removal
Date: Tue,  4 Jun 2024 15:45:24 -0400
Message-ID: <20240604194522.10390-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604194522.10390-6-cel@kernel.org>
References: <20240604194522.10390-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9675; i=chuck.lever@oracle.com; h=from:subject; bh=IIQw5AGrpM1pZ4+VKKIufISRiAUfR/46u4cSiJ1Jikg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmX27ftOcnAsYp9H/5iXkDGRYwEgI+3SqOAXfii QJ7lWQYXO2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZl9u3wAKCRAzarMzb2Z/ lx8KD/9vQ90+DZZJgLbJnQoOkTsEuoMwgQL/vjeDbDBVJOJVS9fiZOyMSAFzhqmqtIp8UIJg7S/ PCfb71GD6rkN/LKmyxFBkubtT3IvG6WzRFUEgKgdKXWb7J3k7bjNoLRbafVRi0AHFR80yCZpj+U 0Bd3gugs8K82Sq1a0uXfP6gmYJ7D8w0tvf/TbQ+obdXvgt0+K/THttTPWIGYZ0rHtsM/CEzQEDm Tir/P8phQeSp1q8a5HRCsl4WEQuomAH9V/PFA0bIo9XRcoxIixqOv/iOawYcJnmnMnMcmTxtZDo Sgp+LPEBTuKPeRazfZ8BVkLNFvAMoSfV6ZHwdZwtAir5FCZfn/JUPJn8PohiUUIVmoZA34HRPtI oXCKHGiA/HrY08MyJCb0t+fab/5uiHg2eQa2TVNVDueI4qSXDtVGuy2yzsS12mk6qSpfVhg1KNC TBA+0eruGCLKonADEth5U7caGyeVfspuphmfhWrLWNq+hPA4mq9gLbhIvHDo6uhGSrg4VlaQ+aQ rNHXLhkiFSG6ddM5+pgW4WXMP0xopuS/j+6aVsbSrjWeMSBoOlpmq9M5+mlAKOjcK3DtjdAZx3U fFshtJk03imFLK+IaLN8rZ4E9kKuXj9QcD79NuPyOo4AJmKdjteDDwLvXg78XaMP+hiFTGB2bSB GBQxTKqedgZDW1g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Commit e87a911fed07 ("nvme-rdma: use ib_client API to detect device
removal") explains the benefits of handling device removal outside
of the CM event handler.

Sketch in an IB device removal notification mechanism that can be
used by both the client and server side RPC-over-RDMA transport
implementations.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/rdma_rn.h  |  27 +++++
 include/trace/events/rpcrdma.h  |  34 ++++++
 net/sunrpc/xprtrdma/Makefile    |   2 +-
 net/sunrpc/xprtrdma/ib_client.c | 181 ++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/module.c    |  18 +++-
 5 files changed, 258 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/sunrpc/rdma_rn.h
 create mode 100644 net/sunrpc/xprtrdma/ib_client.c

diff --git a/include/linux/sunrpc/rdma_rn.h b/include/linux/sunrpc/rdma_rn.h
new file mode 100644
index 000000000000..7d032ca057af
--- /dev/null
+++ b/include/linux/sunrpc/rdma_rn.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * * Copyright (c) 2024, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SUNRPC_RDMA_RN_H
+#define _LINUX_SUNRPC_RDMA_RN_H
+
+#include <rdma/ib_verbs.h>
+
+/**
+ * rpcrdma_notification - request removal notification
+ */
+struct rpcrdma_notification {
+	void			(*rn_done)(struct rpcrdma_notification *rn);
+	u32			rn_index;
+};
+
+int rpcrdma_rn_register(struct ib_device *device,
+			struct rpcrdma_notification *rn,
+			void (*done)(struct rpcrdma_notification *rn));
+void rpcrdma_rn_unregister(struct ib_device *device,
+			   struct rpcrdma_notification *rn);
+int rpcrdma_ib_client_register(void);
+void rpcrdma_ib_client_unregister(void);
+
+#endif /* _LINUX_SUNRPC_RDMA_RN_H */
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 14392652273a..ecdaf088219d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2220,6 +2220,40 @@ TRACE_EVENT(svcrdma_sq_post_err,
 	)
 );
 
+DECLARE_EVENT_CLASS(rpcrdma_client_device_class,
+	TP_PROTO(
+		const struct ib_device *device
+	),
+
+	TP_ARGS(device),
+
+	TP_STRUCT__entry(
+		__string(name, device->name)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+	),
+
+	TP_printk("device=%s",
+		__get_str(name)
+	)
+);
+
+#define DEFINE_CLIENT_DEVICE_EVENT(name)				\
+	DEFINE_EVENT(rpcrdma_client_device_class, name,			\
+		TP_PROTO(						\
+			const struct ib_device *device			\
+		),							\
+		TP_ARGS(device)						\
+	)
+
+DEFINE_CLIENT_DEVICE_EVENT(rpcrdma_client_completion);
+DEFINE_CLIENT_DEVICE_EVENT(rpcrdma_client_add_one);
+DEFINE_CLIENT_DEVICE_EVENT(rpcrdma_client_remove_one);
+DEFINE_CLIENT_DEVICE_EVENT(rpcrdma_client_wait_on);
+DEFINE_CLIENT_DEVICE_EVENT(rpcrdma_client_remove_one_done);
+
 #endif /* _TRACE_RPCRDMA_H */
 
 #include <trace/define_trace.h>
diff --git a/net/sunrpc/xprtrdma/Makefile b/net/sunrpc/xprtrdma/Makefile
index 55b21bae866d..3232aa23cdb4 100644
--- a/net/sunrpc/xprtrdma/Makefile
+++ b/net/sunrpc/xprtrdma/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SUNRPC_XPRT_RDMA) += rpcrdma.o
 
-rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o \
+rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o \
 	svc_rdma.o svc_rdma_backchannel.o svc_rdma_transport.o \
 	svc_rdma_sendto.o svc_rdma_recvfrom.o svc_rdma_rw.o \
 	svc_rdma_pcl.o module.o
diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
new file mode 100644
index 000000000000..a938c19c3490
--- /dev/null
+++ b/net/sunrpc/xprtrdma/ib_client.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (c) 2024 Oracle.  All rights reserved.
+ */
+
+/* #include <linux/module.h>
+#include <linux/slab.h> */
+#include <linux/xarray.h>
+#include <linux/types.h>
+#include <linux/kref.h>
+#include <linux/completion.h>
+
+#include <linux/sunrpc/svc_rdma.h>
+#include <linux/sunrpc/rdma_rn.h>
+
+#include "xprt_rdma.h"
+#include <trace/events/rpcrdma.h>
+
+/* Per-ib_device private data for rpcrdma */
+struct rpcrdma_device {
+	struct kref		rd_kref;
+	unsigned long		rd_flags;
+	struct ib_device	*rd_device;
+	struct xarray		rd_xa;
+	struct completion	rd_done;
+};
+
+#define RPCRDMA_RD_F_REMOVING	(0)
+
+static struct ib_client rpcrdma_ib_client;
+
+/*
+ * Listeners have no associated device, so we never register them.
+ * Note that ib_get_client_data() does not check if @device is
+ * NULL for us.
+ */
+static struct rpcrdma_device *rpcrdma_get_client_data(struct ib_device *device)
+{
+	if (!device)
+		return NULL;
+	return ib_get_client_data(device, &rpcrdma_ib_client);
+}
+
+/**
+ * rpcrdma_rn_register - register to get device removal notifications
+ * @device: device to monitor
+ * @rn: notification object that wishes to be notified
+ * @done: callback to notify caller of device removal
+ *
+ * Returns zero on success. The callback in rn_done is guaranteed
+ * to be invoked when the device is removed, unless this notification
+ * is unregistered first.
+ *
+ * On failure, a negative errno is returned.
+ */
+int rpcrdma_rn_register(struct ib_device *device,
+			struct rpcrdma_notification *rn,
+			void (*done)(struct rpcrdma_notification *rn))
+{
+	struct rpcrdma_device *rd = rpcrdma_get_client_data(device);
+
+	if (!rd || test_bit(RPCRDMA_RD_F_REMOVING, &rd->rd_flags))
+		return -ENETUNREACH;
+
+	kref_get(&rd->rd_kref);
+	if (xa_alloc(&rd->rd_xa, &rn->rn_index, rn, xa_limit_32b, GFP_KERNEL) < 0)
+		return -ENOMEM;
+	rn->rn_done = done;
+	return 0;
+}
+
+static void rpcrdma_rn_release(struct kref *kref)
+{
+	struct rpcrdma_device *rd = container_of(kref, struct rpcrdma_device,
+						 rd_kref);
+
+	trace_rpcrdma_client_completion(rd->rd_device);
+	complete(&rd->rd_done);
+}
+
+/**
+ * rpcrdma_rn_unregister - stop device removal notifications
+ * @device: monitored device
+ * @rn: notification object that no longer wishes to be notified
+ */
+void rpcrdma_rn_unregister(struct ib_device *device,
+			   struct rpcrdma_notification *rn)
+{
+	struct rpcrdma_device *rd = rpcrdma_get_client_data(device);
+
+	if (!rd)
+		return;
+
+	xa_erase(&rd->rd_xa, rn->rn_index);
+	kref_put(&rd->rd_kref, rpcrdma_rn_release);
+}
+
+/**
+ * rpcrdma_add_one - ib_client device insertion callback
+ * @device: device about to be inserted
+ *
+ * Returns zero on success. xprtrdma private data has been allocated
+ * for this device. On failure, a negative errno is returned.
+ */
+static int rpcrdma_add_one(struct ib_device *device)
+{
+	struct rpcrdma_device *rd;
+
+	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
+	if (!rd)
+		return -ENOMEM;
+
+	kref_init(&rd->rd_kref);
+	xa_init_flags(&rd->rd_xa, XA_FLAGS_ALLOC1);
+	rd->rd_device = device;
+	init_completion(&rd->rd_done);
+	ib_set_client_data(device, &rpcrdma_ib_client, rd);
+
+	trace_rpcrdma_client_add_one(device);
+	return 0;
+}
+
+/**
+ * rpcrdma_remove_one - ib_client device removal callback
+ * @device: device about to be removed
+ * @client_data: this module's private per-device data
+ *
+ * Upon return, all transports associated with @device have divested
+ * themselves from IB hardware resources.
+ */
+static void rpcrdma_remove_one(struct ib_device *device,
+			       void *client_data)
+{
+	struct rpcrdma_device *rd = client_data;
+	struct rpcrdma_notification *rn;
+	unsigned long index;
+
+	trace_rpcrdma_client_remove_one(device);
+
+	set_bit(RPCRDMA_RD_F_REMOVING, &rd->rd_flags);
+	xa_for_each(&rd->rd_xa, index, rn)
+		rn->rn_done(rn);
+
+	/*
+	 * Wait only if there are still outstanding notification
+	 * registrants for this device.
+	 */
+	if (!refcount_dec_and_test(&rd->rd_kref.refcount)) {
+		trace_rpcrdma_client_wait_on(device);
+		wait_for_completion(&rd->rd_done);
+	}
+
+	trace_rpcrdma_client_remove_one_done(device);
+	kfree(rd);
+}
+
+static struct ib_client rpcrdma_ib_client = {
+	.name		= "rpcrdma",
+	.add		= rpcrdma_add_one,
+	.remove		= rpcrdma_remove_one,
+};
+
+/**
+ * rpcrdma_ib_client_unregister - unregister ib_client for xprtrdma
+ *
+ * cel: watch for orphaned rpcrdma_device objects on module unload
+ */
+void rpcrdma_ib_client_unregister(void)
+{
+	ib_unregister_client(&rpcrdma_ib_client);
+}
+
+/**
+ * rpcrdma_ib_client_register - register ib_client for rpcrdma
+ *
+ * Returns zero on success, or a negative errno.
+ */
+int rpcrdma_ib_client_register(void)
+{
+	return ib_register_client(&rpcrdma_ib_client);
+}
diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.c
index 45c5b41ac8dc..697f571d4c01 100644
--- a/net/sunrpc/xprtrdma/module.c
+++ b/net/sunrpc/xprtrdma/module.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sunrpc/svc_rdma.h>
+#include <linux/sunrpc/rdma_rn.h>
 
 #include <asm/swab.h>
 
@@ -30,21 +31,32 @@ static void __exit rpc_rdma_cleanup(void)
 {
 	xprt_rdma_cleanup();
 	svc_rdma_cleanup();
+	rpcrdma_ib_client_unregister();
 }
 
 static int __init rpc_rdma_init(void)
 {
 	int rc;
 
+	rc = rpcrdma_ib_client_register();
+	if (rc)
+		goto out_rc;
+
 	rc = svc_rdma_init();
 	if (rc)
-		goto out;
+		goto out_ib_client;
 
 	rc = xprt_rdma_init();
 	if (rc)
-		svc_rdma_cleanup();
+		goto out_svc_rdma;
 
-out:
+	return 0;
+
+out_svc_rdma:
+	svc_rdma_cleanup();
+out_ib_client:
+	rpcrdma_ib_client_unregister();
+out_rc:
 	return rc;
 }
 
-- 
2.45.1


