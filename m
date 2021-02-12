Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1589931A112
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBLPEi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 10:04:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBLPEh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 10:04:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0AD664E57;
        Fri, 12 Feb 2021 15:03:56 +0000 (UTC)
Subject: [PATCH v2] svcrdma: Hold private mutex while invoking rdma_accept()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 12 Feb 2021 10:03:56 -0500
Message-ID: <161314223614.4643.16470136253837190113.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RDMA core mutex locking was restructured by d114c6feedfe ("RDMA/cma:
Add missing locking to rdma_accept()") [Aug 2020]. When lock
debugging is enabled, the RPC/RDMA server trips over the new lockdep
assertion in rdma_accept() because it doesn't call rdma_accept()
from its CM event handler.

As a temporary fix, have svc_rdma_accept() take the handler_mutex
explicitly. In the meantime, let's consider how to restructure the
RPC/RDMA transport to invoke rdma_accept() from the proper context.

Calls to svc_rdma_accept() are serialized with calls to
svc_rdma_free() by the generic RPC server layer.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/linux-rdma/20210209154014.GO4247@nvidia.com/
Fixes: d114c6feedfe ("RDMA/cma: Add missing locking to rdma_accept()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index afba4e9d5425..c895f80df659 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -475,9 +475,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (!svc_rdma_post_recvs(newxprt))
 		goto errout;
 
-	/* Swap out the handler */
-	newxprt->sc_cm_id->event_handler = svc_rdma_cma_handler;
-
 	/* Construct RDMA-CM private message */
 	pmsg.cp_magic = rpcrdma_cmp_magic;
 	pmsg.cp_version = RPCRDMA_CMP_VERSION;
@@ -498,7 +495,10 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	}
 	conn_param.private_data = &pmsg;
 	conn_param.private_data_len = sizeof(pmsg);
+	rdma_lock_handler(newxprt->sc_cm_id);
+	newxprt->sc_cm_id->event_handler = svc_rdma_cma_handler;
 	ret = rdma_accept(newxprt->sc_cm_id, &conn_param);
+	rdma_unlock_handler(newxprt->sc_cm_id);
 	if (ret) {
 		trace_svcrdma_accept_err(newxprt, ret);
 		goto errout;


