Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D573F34D28B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhC2OkN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 10:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhC2Ojy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 10:39:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9471D6192C;
        Mon, 29 Mar 2021 14:39:53 +0000 (UTC)
Subject: [PATCH v1 1/6] SUNRPC: Export svc_xprt_received()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Mar 2021 10:39:52 -0400
Message-ID: <161702879275.5937.4133334295352322345.stgit@klimt.1015granger.net>
In-Reply-To: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
References: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prepare svc_xprt_received() to be called from transport code instead
of from generic RPC server code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_xprt.h |    1 +
 include/trace/events/sunrpc.h   |    1 +
 net/sunrpc/svc_xprt.c           |   13 +++++++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 34dacadfe517..571f605bc91e 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -130,6 +130,7 @@ void	svc_xprt_init(struct net *, struct svc_xprt_class *, struct svc_xprt *,
 int	svc_create_xprt(struct svc_serv *, const char *, struct net *,
 			const int, const unsigned short, int,
 			const struct cred *);
+void	svc_xprt_received(struct svc_xprt *xprt);
 void	svc_xprt_do_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_put(struct svc_xprt *xprt);
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 036eb1f5c133..bda16e9e6ba7 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1781,6 +1781,7 @@ DECLARE_EVENT_CLASS(svc_xprt_event,
 			), \
 			TP_ARGS(xprt))
 
+DEFINE_SVC_XPRT_EVENT(received);
 DEFINE_SVC_XPRT_EVENT(no_write_space);
 DEFINE_SVC_XPRT_EVENT(close);
 DEFINE_SVC_XPRT_EVENT(detach);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b134fc5f3b8d..9d1374e82e90 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -247,21 +247,25 @@ static struct svc_xprt *__svc_xpo_create(struct svc_xprt_class *xcl,
 	return xprt;
 }
 
-/*
- * svc_xprt_received conditionally queues the transport for processing
- * by another thread. The caller must hold the XPT_BUSY bit and must
+/**
+ * svc_xprt_received - start next receiver thread
+ * @xprt: controlling transport
+ *
+ * The caller must hold the XPT_BUSY bit and must
  * not thereafter touch transport data.
  *
  * Note: XPT_DATA only gets cleared when a read-attempt finds no (or
  * insufficient) data.
  */
-static void svc_xprt_received(struct svc_xprt *xprt)
+void svc_xprt_received(struct svc_xprt *xprt)
 {
 	if (!test_bit(XPT_BUSY, &xprt->xpt_flags)) {
 		WARN_ONCE(1, "xprt=0x%p already busy!", xprt);
 		return;
 	}
 
+	trace_svc_xprt_received(xprt);
+
 	/* As soon as we clear busy, the xprt could be closed and
 	 * 'put', so we need a reference to call svc_enqueue_xprt with:
 	 */
@@ -271,6 +275,7 @@ static void svc_xprt_received(struct svc_xprt *xprt)
 	xprt->xpt_server->sv_ops->svo_enqueue_xprt(xprt);
 	svc_xprt_put(xprt);
 }
+EXPORT_SYMBOL_GPL(svc_xprt_received);
 
 void svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *new)
 {


