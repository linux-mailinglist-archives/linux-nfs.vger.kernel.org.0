Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84353D58FF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhGZLS4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 07:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233814AbhGZLS4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:18:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2197E60F38
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jul 2021 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300765;
        bh=YQhIwQlRnWIGwninUTiQkXOp95CVg0WvXvBEtOKSPEY=;
        h=From:To:Subject:Date:From;
        b=pWK2f/36NpNH2ojznHx68YGvjqIVw0s+1bu5Iiiz707YbzhooAW6/RkjP6wLOIx37
         88zVBhvw5kWBVq+u/WqDFx+nP82Qv5X82MCiT8mhDfTIF4oikY2DdCUCXhpJg8RlFu
         ydw6lwUwmBqt3Sw4QJHnPMsXFSSnYXVtGnKPUd3LPz+dap7uQLYzMVNjEagzu6EXqo
         WVFZNfx/iX/IX7oai9xFe7yxOJvMyw8gr8BZg8ZXPKlM0aH2LAVcHc8RKb8O3L7tTY
         Zu4tNkciHbc+wTvnbPZ1ixvLReraHEnUnRF8jgYrDhYAqTEAC8gULG7I/fUcLEjYow
         lhOchiftSlNog==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: Fix potential memory corruption
Date:   Mon, 26 Jul 2021 07:59:23 -0400
Message-Id: <20210726115924.8576-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We really should not call rpc_wake_up_queued_task_set_status() with
xprt->snd_task as an argument unless we are certain that is actually an
rpc_task.

Fixes: 0445f92c5d53 ("SUNRPC: Fix disconnection races")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xprt.h | 1 +
 net/sunrpc/xprt.c           | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index c8c39f22d3b1..59cd97da895b 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -432,6 +432,7 @@ void			xprt_release_write(struct rpc_xprt *, struct rpc_task *);
 #define XPRT_CONGESTED		(9)
 #define XPRT_CWND_WAIT		(10)
 #define XPRT_WRITE_SPACE	(11)
+#define XPRT_SND_IS_COOKIE	(12)
 
 static inline void xprt_set_connected(struct rpc_xprt *xprt)
 {
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index fb6db09725c7..bddd354a0076 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -775,9 +775,9 @@ void xprt_force_disconnect(struct rpc_xprt *xprt)
 	/* Try to schedule an autoclose RPC call */
 	if (test_and_set_bit(XPRT_LOCKED, &xprt->state) == 0)
 		queue_work(xprtiod_workqueue, &xprt->task_cleanup);
-	else if (xprt->snd_task)
+	else if (xprt->snd_task && !test_bit(XPRT_SND_IS_COOKIE, &xprt->state))
 		rpc_wake_up_queued_task_set_status(&xprt->pending,
-				xprt->snd_task, -ENOTCONN);
+						   xprt->snd_task, -ENOTCONN);
 	spin_unlock(&xprt->transport_lock);
 }
 EXPORT_SYMBOL_GPL(xprt_force_disconnect);
@@ -866,6 +866,7 @@ bool xprt_lock_connect(struct rpc_xprt *xprt,
 		goto out;
 	if (xprt->snd_task != task)
 		goto out;
+	set_bit(XPRT_SND_IS_COOKIE, &xprt->state);
 	xprt->snd_task = cookie;
 	ret = true;
 out:
@@ -881,6 +882,7 @@ void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
 	if (!test_bit(XPRT_LOCKED, &xprt->state))
 		goto out;
 	xprt->snd_task =NULL;
+	clear_bit(XPRT_SND_IS_COOKIE, &xprt->state);
 	xprt->ops->release_xprt(xprt, NULL);
 	xprt_schedule_autodisconnect(xprt);
 out:
-- 
2.31.1

