Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5934D293
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhC2Okq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 10:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhC2OkY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 10:40:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6403E61933;
        Mon, 29 Mar 2021 14:40:24 +0000 (UTC)
Subject: [PATCH v1 6/6] svcrdma: Clean up dto_q critical section in
 svc_rdma_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Mar 2021 10:40:23 -0400
Message-ID: <161702882362.5937.2325805207945484450.stgit@klimt.1015granger.net>
In-Reply-To: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
References: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This, to me, seems less cluttered and less redundant. I was hoping
it could help reduce lock contention on the dto_q lock by reducing
the size of the critical section, but alas, the only improvement is
readability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 357e3ae01991..1cf0b04b632a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -794,22 +794,20 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 
 	rqstp->rq_xprt_ctxt = NULL;
 
+	ctxt = NULL;
 	spin_lock(&rdma_xprt->sc_rq_dto_lock);
 	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_rq_dto_q);
-	if (!ctxt) {
+	if (ctxt)
+		list_del(&ctxt->rc_list);
+	else
 		/* No new incoming requests, terminate the loop */
 		clear_bit(XPT_DATA, &xprt->xpt_flags);
-		spin_unlock(&rdma_xprt->sc_rq_dto_lock);
-		svc_xprt_received(xprt);
-		return 0;
-	}
-	list_del(&ctxt->rc_list);
 	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
-	percpu_counter_inc(&svcrdma_stat_recv);
-
-	/* Start receiving the next incoming message */
 	svc_xprt_received(xprt);
+	if (!ctxt)
+		return 0;
 
+	percpu_counter_inc(&svcrdma_stat_recv);
 	ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
 				   ctxt->rc_recv_sge.addr, ctxt->rc_byte_len,
 				   DMA_FROM_DEVICE);


