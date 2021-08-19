Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BA03F195B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Aug 2021 14:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhHSMex (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 08:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhHSMew (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:34:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EE5660551;
        Thu, 19 Aug 2021 12:34:16 +0000 (UTC)
Subject: [PATCH v1] svcrdma: xpt_bc_xprt is already clear in __svc_rdma_free()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Aug 2021 08:34:15 -0400
Message-ID: <162937645573.2555.8321367440838840185.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_xprt_free() already "puts" the bc_xprt before calling the
transport's "free" method. No need to do it twice.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index d1faa522c3dd..94b20fb47135 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -545,7 +545,6 @@ static void __svc_rdma_free(struct work_struct *work)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(work, struct svcxprt_rdma, sc_work);
-	struct svc_xprt *xprt = &rdma->sc_xprt;
 
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
@@ -553,12 +552,6 @@ static void __svc_rdma_free(struct work_struct *work)
 
 	svc_rdma_flush_recv_queues(rdma);
 
-	/* Final put of backchannel client transport */
-	if (xprt->xpt_bc_xprt) {
-		xprt_put(xprt->xpt_bc_xprt);
-		xprt->xpt_bc_xprt = NULL;
-	}
-
 	svc_rdma_destroy_rw_ctxts(rdma);
 	svc_rdma_send_ctxts_destroy(rdma);
 	svc_rdma_recv_ctxts_destroy(rdma);


