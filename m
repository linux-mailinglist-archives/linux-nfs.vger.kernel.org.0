Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8A341F74
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 15:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCSOcH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 10:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhCSObh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 10:31:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A844764F18;
        Fri, 19 Mar 2021 14:31:36 +0000 (UTC)
Subject: [PATCH v1 4/6] svcrdma: Add a batch Receive posting mechanism
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 19 Mar 2021 10:31:35 -0400
Message-ID: <161616429593.173092.14052996014785354959.stgit@klimt.1015granger.net>
In-Reply-To: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
References: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce a server-side mechanism similar to commit e340c2d6ef2a
("xprtrdma: Reduce the doorbell rate (Receive)") to post Receive
WRs in batch. It's first consumer is svc_rdma_post_recvs().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   56 +++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 04148a656b2a..0c6aa8693f20 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -264,6 +264,47 @@ void svc_rdma_release_rqst(struct svc_rqst *rqstp)
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
 }
 
+static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
+				   unsigned int wanted, bool temp)
+{
+	const struct ib_recv_wr *bad_wr = NULL;
+	struct svc_rdma_recv_ctxt *ctxt;
+	struct ib_recv_wr *recv_chain;
+	int ret;
+
+	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
+		return false;
+
+	recv_chain = NULL;
+	while (wanted--) {
+		ctxt = svc_rdma_recv_ctxt_get(rdma);
+		if (!ctxt)
+			break;
+
+		trace_svcrdma_post_recv(ctxt);
+		ctxt->rc_temp = temp;
+		ctxt->rc_recv_wr.next = recv_chain;
+		recv_chain = &ctxt->rc_recv_wr;
+	}
+	if (!recv_chain)
+		return false;
+
+	ret = ib_post_recv(rdma->sc_qp, recv_chain, &bad_wr);
+	if (ret)
+		goto err_free;
+	return true;
+
+err_free:
+	trace_svcrdma_rq_post_err(rdma, ret);
+	while (bad_wr) {
+		ctxt = container_of(bad_wr, struct svc_rdma_recv_ctxt,
+				    rc_recv_wr);
+		bad_wr = bad_wr->next;
+		svc_rdma_recv_ctxt_put(rdma, ctxt);
+	}
+	return false;
+}
+
 static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
 				struct svc_rdma_recv_ctxt *ctxt)
 {
@@ -301,20 +342,7 @@ static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
  */
 bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
-	struct svc_rdma_recv_ctxt *ctxt;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < rdma->sc_max_requests; i++) {
-		ctxt = svc_rdma_recv_ctxt_get(rdma);
-		if (!ctxt)
-			return false;
-		ctxt->rc_temp = true;
-		ret = __svc_rdma_post_recv(rdma, ctxt);
-		if (ret)
-			return false;
-	}
-	return true;
+	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests, true);
 }
 
 /**


