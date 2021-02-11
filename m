Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445703195AF
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Feb 2021 23:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBKWQZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Feb 2021 17:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhBKWQP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Feb 2021 17:16:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43D72601FF;
        Thu, 11 Feb 2021 22:15:32 +0000 (UTC)
Subject: [PATCH v1] svcrdma: Hold private mutex while invoking rdma_accept()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 11 Feb 2021 17:15:30 -0500
Message-ID: <161308170145.1097.4777972218876421176.stgit@klimt.1015granger.net>
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

As a temporary fix, have svc_rdma_accept() take the mutex
explicitly. In the meantime, let's consider how to restructure the
RPC/RDMA transport to invoke rdma_accept() from the proper context.

Calls to svc_rdma_accept() are serialized with calls to
svc_rdma_free() by the generic RPC server layer.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index afba4e9d5425..8d14dbd45418 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -498,7 +498,9 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	}
 	conn_param.private_data = &pmsg;
 	conn_param.private_data_len = sizeof(pmsg);
+	rdma_lock_handler(newxprt->sc_cm_id);
 	ret = rdma_accept(newxprt->sc_cm_id, &conn_param);
+	rdma_unlock_handler(newxprt->sc_cm_id);
 	if (ret) {
 		trace_svcrdma_accept_err(newxprt, ret);
 		goto errout;


