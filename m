Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDC352D7C
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhDBPa1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 11:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235060AbhDBPa1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 2 Apr 2021 11:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A25A661104;
        Fri,  2 Apr 2021 15:30:25 +0000 (UTC)
Subject: [PATCH v2 2/8] xprtrdma: Do not refresh Receive Queue while it is
 draining
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 02 Apr 2021 11:30:24 -0400
Message-ID: <161737742487.2012531.945322707385198629.stgit@manet.1015granger.net>
In-Reply-To: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
References: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the Receive completion handler refreshes the Receive Queue
whenever a successful Receive completion occurs.

On disconnect, xprtrdma drains the Receive Queue. The first few
Receive completions after a disconnect are typically successful,
until the first flushed Receive.

This means the Receive completion handler continues to post more
Receive WRs after the drain sentinel has been posted. The late-
posted Receives flush after the drain sentinel has completed,
leading to a crash later in rpcrdma_xprt_disconnect().

To prevent this crash, xprtrdma has to ensure that the Receive
handler stops posting Receives before ib_drain_rq() posts its
drain sentinel.

Suggested-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |   13 +++++++++++++
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 2 files changed, 14 insertions(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index ec912cf9c618..d8ed69442219 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -101,6 +101,12 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct rdma_cm_id *id = ep->re_id;
 
+	/* Wait for rpcrdma_post_recvs() to leave its critical
+	 * section.
+	 */
+	if (atomic_inc_return(&ep->re_receiving) > 1)
+		wait_for_completion(&ep->re_done);
+
 	/* Flush Receives, then wait for deferred Reply work
 	 * to complete.
 	 */
@@ -414,6 +420,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	__module_get(THIS_MODULE);
 	device = id->device;
 	ep->re_id = id;
+	reinit_completion(&ep->re_done);
 
 	ep->re_max_requests = r_xprt->rx_xprt.max_reqs;
 	ep->re_inline_send = xprt_rdma_max_inline_write;
@@ -1385,6 +1392,9 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	if (!temp)
 		needed += RPCRDMA_MAX_RECV_BATCH;
 
+	if (atomic_inc_return(&ep->re_receiving) > 1)
+		goto out;
+
 	/* fast path: all needed reps can be found on the free list */
 	wr = NULL;
 	while (needed) {
@@ -1410,6 +1420,9 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 
 	rc = ib_post_recv(ep->re_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
+	if (atomic_dec_return(&ep->re_receiving) > 0)
+		complete(&ep->re_done);
+
 out:
 	trace_xprtrdma_post_recvs(r_xprt, count, rc);
 	if (rc) {
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index fe3be985e239..31404326f29f 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -83,6 +83,7 @@ struct rpcrdma_ep {
 	unsigned int		re_max_inline_recv;
 	int			re_async_rc;
 	int			re_connect_status;
+	atomic_t		re_receiving;
 	atomic_t		re_force_disconnect;
 	struct ib_qp_init_attr	re_attr;
 	wait_queue_head_t       re_connect_wait;


