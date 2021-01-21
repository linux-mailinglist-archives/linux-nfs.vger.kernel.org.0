Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493342FF703
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 22:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbhAUVSi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 16:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbhAUUyt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Jan 2021 15:54:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D24523A5D;
        Thu, 21 Jan 2021 20:53:13 +0000 (UTC)
Subject: [PATCH v1 2/2] svcrdma: DMA-sync the receive buffer in
 svc_rdma_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 Jan 2021 15:53:12 -0500
Message-ID: <161126239239.8979.7995314438640511469.stgit@klimt.1015granger.net>
In-Reply-To: <161126216710.8979.7145432546367265892.stgit@klimt.1015granger.net>
References: <161126216710.8979.7145432546367265892.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Receive completion handler doesn't look at the contents of the
Receive buffer. The DMA sync isn't terribly expensive but it's one
less thing that needs to be done by the Receive completion handler,
which is single-threaded (per svc_xprt). This helps scalability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index ab0b7e9777bc..6d28f23ceb35 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -342,9 +342,6 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
-	ib_dma_sync_single_for_cpu(rdma->sc_pd->device,
-				   ctxt->rc_recv_sge.addr,
-				   wc->byte_len, DMA_FROM_DEVICE);
 
 	spin_lock(&rdma->sc_rq_dto_lock);
 	list_add_tail(&ctxt->rc_list, &rdma->sc_rq_dto_q);
@@ -851,6 +848,9 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
 	percpu_counter_inc(&svcrdma_stat_recv);
 
+	ib_dma_sync_single_for_cpu(rdma_xprt->sc_pd->device,
+				   ctxt->rc_recv_sge.addr, ctxt->rc_byte_len,
+				   DMA_FROM_DEVICE);
 	svc_rdma_build_arg_xdr(rqstp, ctxt);
 
 	/* Prevent svc_xprt_release from releasing pages in rq_pages


