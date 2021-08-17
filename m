Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5EC3EF1CE
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Aug 2021 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhHQSZ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 14:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232301AbhHQSZ0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Aug 2021 14:25:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8AA4601FE;
        Tue, 17 Aug 2021 18:24:52 +0000 (UTC)
Subject: [PATCH RFC] xprtrdma: Move initial Receive posting
From:   Chuck Lever <chuck.lever@oracle.com>
To:     haakon.bugge@oracle.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 17 Aug 2021 14:24:51 -0400
Message-ID: <162922469165.515267.14848799693507242987.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Håkon Bugge points out that rdma_create_qp() is not supposed to
return a QP that is ready for Receives to be posted. It so happens
that ours does that, but the IBTA spec (12.9.7.1) states that a
transition to INIT happens only after REQ has been sent.

In future kernels, QPs returned from rdma_create_qp() might not
be in a state where posting Receives will succeed. This patch
is a pre-requisite to changing the legacy behavior of
rdma_create_qp().

The first available moment after cm_send_req where xprtrdma can
post Receives is when the RDMA core reports the QP connection
has been established.

Note that xprtrdma has posted Receives just after rdma_create_qp()
since 8d4fb8ff427a ("xprtrdma: Fix disconnect regression"). To avoid
regressing 8d4fb8ff427a, xprtrdma needs to ensure that initial
Receive WRs are posted before pending RPCs are awoken. It appears
that the current logic does provide that guarantee.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index aaec3c9be8db..87ae62cdea18 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -520,12 +520,6 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	xprt_clear_connected(xprt);
 	rpcrdma_reset_cwnd(r_xprt);
 
-	/* Bump the ep's reference count while there are
-	 * outstanding Receives.
-	 */
-	rpcrdma_ep_get(ep);
-	rpcrdma_post_recvs(r_xprt, 1, true);
-
 	rc = rdma_connect(ep->re_id, &ep->re_remote_cma);
 	if (rc)
 		goto out;
@@ -539,6 +533,12 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 		goto out;
 	}
 
+	/* Bump the ep's reference count while there are
+	 * outstanding Receives.
+	 */
+	rpcrdma_ep_get(ep);
+	rpcrdma_post_recvs(r_xprt, 1, true);
+
 	rc = rpcrdma_sendctxs_create(r_xprt);
 	if (rc) {
 		rc = -ENOTCONN;


