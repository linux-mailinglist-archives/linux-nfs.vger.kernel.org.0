Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945303D5917
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhGZLWp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 07:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233633AbhGZLWp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C4AA60F38;
        Mon, 26 Jul 2021 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300993;
        bh=PbDXgMU54OUeu0I/sdyHnTMg6/U+mhZHv/5tJOo+C7A=;
        h=From:To:Cc:Subject:Date:From;
        b=XcPvHwM438tCr4LIVnpbtTOPLDtAX703p+rdVYxbMIPUBYrhwlouWbfHBEHYZx/6i
         U1fmfojcHsn9tj5LiwPmSfznLdMPSjk+ZZ+hUgj7O4aDfL57KV6y7WIhPd5mpjuqIA
         D1K6N5ZUZj/6upSHjBnhGjIFeT6f0g1rJ63/f9cDtsh8MPipPOqwSBSccXDWgJTcm3
         96tBBRkCifSyALqDOFt9hbCP1rCOtqju0NC3IKs9rMqicXnqIEY3lVd9zvI3StuGUm
         NSL+ZJK05/Hd1bvsfPSCVWPbBbddK0zrqETHEROEEbn9pzz4LyKLqam99UomUY0mQ2
         vgAGHijj5Yo1w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] SUNRPC/xprtrdma: Fix reconnection locking
Date:   Mon, 26 Jul 2021 08:03:12 -0400
Message-Id: <20210726120312.8856-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The xprtrdma client code currently relies on the task that initiated the
connect to hold the XPRT_LOCK for the duration of the connection
attempt. If the task is woken early, due to some other event, then that
lock could get released early.
Avoid races by using the same mechanism that the socket code uses of
transferring lock ownership to the RDMA connect worker itself. That
frees us to call rpcrdma_xprt_disconnect() directly since we're now
guaranteed exclusion w.r.t. other callers.

Fixes: 4cf44be6f1e8 ("xprtrdma: Fix recursion into rpcrdma_xprt_disconnect()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprt.c               |  2 ++
 net/sunrpc/xprtrdma/transport.c | 11 +++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index aae5a328b15b..b88ac8132054 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -877,6 +877,7 @@ bool xprt_lock_connect(struct rpc_xprt *xprt,
 	spin_unlock(&xprt->transport_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xprt_lock_connect);
 
 void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
 {
@@ -893,6 +894,7 @@ void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
 	spin_unlock(&xprt->transport_lock);
 	wake_up_bit(&xprt->state, XPRT_LOCKED);
 }
+EXPORT_SYMBOL_GPL(xprt_unlock_connect);
 
 /**
  * xprt_connect - schedule a transport connect operation
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 9c2ffc67c0fd..975aef16ad34 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -250,12 +250,9 @@ xprt_rdma_connect_worker(struct work_struct *work)
 					   xprt->stat.connect_start;
 		xprt_set_connected(xprt);
 		rc = -EAGAIN;
-	} else {
-		/* Force a call to xprt_rdma_close to clean up */
-		spin_lock(&xprt->transport_lock);
-		set_bit(XPRT_CLOSE_WAIT, &xprt->state);
-		spin_unlock(&xprt->transport_lock);
-	}
+	} else
+		rpcrdma_xprt_disconnect(r_xprt);
+	xprt_unlock_connect(xprt, r_xprt);
 	xprt_wake_pending_tasks(xprt, rc);
 }
 
@@ -489,6 +486,8 @@ xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	unsigned long delay;
 
+	WARN_ON_ONCE(!xprt_lock_connect(xprt, task, r_xprt));
+
 	delay = 0;
 	if (ep && ep->re_connect_status != 0) {
 		delay = xprt_reconnect_delay(xprt);
-- 
2.31.1

