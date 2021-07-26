Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122513D5902
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhGZLS6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 07:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233824AbhGZLS4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:18:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B7BA60F4F
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jul 2021 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300765;
        bh=0poQSGhZAIj00Xj+7V3yRetui+9NrotTiv9dLx9yQEg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gnu9H6IHxUIs96xdPWmnW4kMYY0gQmXGWN2OuXlWSddePQQa64VPVvNP1dz7grXHC
         RppT1EuLMfg2QuG/hL/xEkvZuM5p23F9NApdy859M5+CEsNZBGiyDYbxPnUj5DLije
         XYW9wYPXwt3YKOU7iETwuHvRAkvIuG0hqqjqEZ4Vt3G4W04eyvyX797dOEenZlUBIv
         pSo3c8jsHdqF04wo7NfTit8LO1JvynV3WwSl04pI7G1p+U4kw5fpCADhKN8PuasRYk
         yFwgM801D32kgsHeZjT5gYYe2Kf8+T3Dt7QsLsyfk+t8y5ohZCA+4eIWu24hM3sTY3
         nmVFNg4XJ+KyA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: Clean up scheduling of autoclose
Date:   Mon, 26 Jul 2021 07:59:24 -0400
Message-Id: <20210726115924.8576-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210726115924.8576-1-trondmy@kernel.org>
References: <20210726115924.8576-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Consolidate duplicated code in xprt_force_disconnect() and
xprt_conditional_disconnect().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprt.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index bddd354a0076..aae5a328b15b 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -760,6 +760,20 @@ void xprt_disconnect_done(struct rpc_xprt *xprt)
 }
 EXPORT_SYMBOL_GPL(xprt_disconnect_done);
 
+/**
+ * xprt_schedule_autoclose_locked - Try to schedule an autoclose RPC call
+ * @xprt: transport to disconnect
+ */
+static void xprt_schedule_autoclose_locked(struct rpc_xprt *xprt)
+{
+	set_bit(XPRT_CLOSE_WAIT, &xprt->state);
+	if (test_and_set_bit(XPRT_LOCKED, &xprt->state) == 0)
+		queue_work(xprtiod_workqueue, &xprt->task_cleanup);
+	else if (xprt->snd_task && !test_bit(XPRT_SND_IS_COOKIE, &xprt->state))
+		rpc_wake_up_queued_task_set_status(&xprt->pending,
+						   xprt->snd_task, -ENOTCONN);
+}
+
 /**
  * xprt_force_disconnect - force a transport to disconnect
  * @xprt: transport to disconnect
@@ -771,13 +785,7 @@ void xprt_force_disconnect(struct rpc_xprt *xprt)
 
 	/* Don't race with the test_bit() in xprt_clear_locked() */
 	spin_lock(&xprt->transport_lock);
-	set_bit(XPRT_CLOSE_WAIT, &xprt->state);
-	/* Try to schedule an autoclose RPC call */
-	if (test_and_set_bit(XPRT_LOCKED, &xprt->state) == 0)
-		queue_work(xprtiod_workqueue, &xprt->task_cleanup);
-	else if (xprt->snd_task && !test_bit(XPRT_SND_IS_COOKIE, &xprt->state))
-		rpc_wake_up_queued_task_set_status(&xprt->pending,
-						   xprt->snd_task, -ENOTCONN);
+	xprt_schedule_autoclose_locked(xprt);
 	spin_unlock(&xprt->transport_lock);
 }
 EXPORT_SYMBOL_GPL(xprt_force_disconnect);
@@ -817,11 +825,7 @@ void xprt_conditional_disconnect(struct rpc_xprt *xprt, unsigned int cookie)
 		goto out;
 	if (test_bit(XPRT_CLOSING, &xprt->state))
 		goto out;
-	set_bit(XPRT_CLOSE_WAIT, &xprt->state);
-	/* Try to schedule an autoclose RPC call */
-	if (test_and_set_bit(XPRT_LOCKED, &xprt->state) == 0)
-		queue_work(xprtiod_workqueue, &xprt->task_cleanup);
-	xprt_wake_pending_tasks(xprt, -EAGAIN);
+	xprt_schedule_autoclose_locked(xprt);
 out:
 	spin_unlock(&xprt->transport_lock);
 }
-- 
2.31.1

