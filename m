Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636C142C3E0
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhJMOtb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJMOt0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:49:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 807D0610C9;
        Wed, 13 Oct 2021 14:47:23 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v1 5/6] svcrdma: Remove dprintk call sites during accept
Date:   Wed, 13 Oct 2021 10:47:22 -0400
Message-Id:  <163413644238.6408.10635937247771604119.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
References:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; h=from:subject:message-id; bh=h6zqwSVQn+NWKJoOaKIqAaEcOL9OpKdXPKCk6VxK1tY=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvF6+vh00eJbnd+9s+acqU2jL8V31Nk42HwbocsS zpmUXm2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbxegAKCRAzarMzb2Z/lz1WD/ 9k/mYXYZkh/04MrjJXVgrpUyVdY3Qwq74L+7G5eA/NUSIfCRS/va2k3ahsQaSyNvrbVWyeSkXQr23Y ly05VhZOB1x6OINpvbu5Mxv0A9+WXjcRQbU04re5Ma3liWRrqLzvYsVjt0keoLP1h2K2rU4mHg4cNt 2+cdFC9yRdvrunILhago+5wAkElwpxHUPy6UAqQ9vGl08EmJnWQ1ybzHyfv6r70BmchdTg2mYwd49t xdZ4Up6qeoNDcJyMmQv2xEXyW/WyX0qXKbniYLBVN+3KYK3NKwo3QsNe/QYYfZ4ZyDqUr5osFGOiqQ ANuxnoEZcI+431XvX57HeDQZWRceizFRTLgDbxt/1kdw9tzE72Ed1oaZMk7fyGQvbFSjhTOtJDteA+ Vh3r77lNd0Q5jS1It4Q1lxNItHg+ZDUSmzFC9G0f1P7m/g4JFzZsKc3Ak6cDBC+9YnhBKT/F1ug3My dnyXzwTxBw/O7gmTqEYfP9Fxz40IeYDmR4Zfiwmj/4oWYnQSsWEJ3CnWXuRw56lg5OPo39TWFMQLjb hrTnQoWRo2Huuf/h4FiSSP3uO1/HhO6idbfHas1dihf1UJraU0uf3TxdoE/DxQYXfiVNrG9ChZVmUQ Fg1B4tVgiPddmvn7Q+mjm3pCkFEcr6WT/oCxJZkv8kgaXi4dELOHwSLqJFBw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. Most of this information is available from other
tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index e105e2d89b9b..acfde6e1594c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -54,14 +54,12 @@
 #include <rdma/rw.h>
 
 #include <linux/sunrpc/addr.h>
-#include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/sunrpc/svc_rdma.h>
 
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#define RPCDBG_FACILITY	RPCDBG_SVCXPRT
 
 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 						 struct net *net);
@@ -365,7 +363,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	unsigned int ctxts, rq_depth;
 	struct ib_device *dev;
 	int ret = 0;
-	RPC_IFDEBUG(struct sockaddr *sap);
 
 	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	clear_bit(XPT_CONN, &xprt->xpt_flags);
@@ -492,19 +489,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		goto errout;
 	}
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-	dprintk("svcrdma: new connection %p accepted:\n", newxprt);
-	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
-	dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
-	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
-	dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
-	dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
-	dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
-	dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
-	dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
-	dprintk("    ord             : %d\n", conn_param.initiator_depth);
-#endif
-
 	return &newxprt->sc_xprt;
 
  errout:

