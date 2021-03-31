Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED635077A
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhCaTg2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235991AbhCaTgM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 15:36:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02A566100C;
        Wed, 31 Mar 2021 19:36:11 +0000 (UTC)
Subject: [PATCH v1 2/8] xprtrdma: Do not post Receives after disconnect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 31 Mar 2021 15:36:11 -0400
Message-ID: <161721937122.515226.14731175629421422152.stgit@manet.1015granger.net>
In-Reply-To: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
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

This patch is probably not sufficient to fully close that window,
but does significantly reduce the opportunity for a crash to
occur without incurring undue performance overhead.

Cc: stable@vger.kernel.org # v5.7
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index ec912cf9c618..1d88685badbe 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1371,8 +1371,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct ib_qp_init_attr init_attr;
 	struct ib_recv_wr *wr, *bad_wr;
 	struct rpcrdma_rep *rep;
+	struct ib_qp_attr attr;
 	int needed, count, rc;
 
 	rc = 0;
@@ -1385,6 +1387,11 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	if (!temp)
 		needed += RPCRDMA_MAX_RECV_BATCH;
 
+	if (ib_query_qp(ep->re_id->qp, &attr, IB_QP_STATE, &init_attr))
+		goto out;
+	if (attr.qp_state == IB_QPS_ERR)
+		goto out;
+
 	/* fast path: all needed reps can be found on the free list */
 	wr = NULL;
 	while (needed) {


