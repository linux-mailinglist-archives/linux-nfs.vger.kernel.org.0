Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA9360B6A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhDOOF6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 10:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhDOOF6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Apr 2021 10:05:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BA01611F1;
        Thu, 15 Apr 2021 14:05:34 +0000 (UTC)
Subject: [PATCH v1 2/3] svcrdma: Rename goto labels in svc_rdma_sendto()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 15 Apr 2021 10:05:34 -0400
Message-ID: <161849553432.27023.5613620438210798841.stgit@klimt.1015granger.net>
In-Reply-To: <161849552807.27023.3060894326479643195.stgit@klimt.1015granger.net>
References: <161849552807.27023.3060894326479643195.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Make the goto labels consistent with other similar
functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 39aec629aaeb..a3b0f5899f03 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -926,21 +926,21 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
 	ret = -ENOTCONN;
 	if (svc_xprt_is_dead(xprt))
-		goto err0;
+		goto drop_connection;
 
 	ret = -ENOMEM;
 	sctxt = svc_rdma_send_ctxt_get(rdma);
 	if (!sctxt)
-		goto err0;
+		goto drop_connection;
 
 	p = xdr_reserve_space(&sctxt->sc_stream,
 			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
-		goto err1;
+		goto put_ctxt;
 
 	ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
 	if (ret < 0)
-		goto err2;
+		goto reply_chunk;
 
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
@@ -948,15 +948,15 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	*p = pcl_is_empty(&rctxt->rc_reply_pcl) ? rdma_msg : rdma_nomsg;
 
 	if (svc_rdma_encode_read_list(sctxt) < 0)
-		goto err1;
+		goto put_ctxt;
 	if (svc_rdma_encode_write_list(rctxt, sctxt) < 0)
-		goto err1;
+		goto put_ctxt;
 	if (svc_rdma_encode_reply_chunk(rctxt, sctxt, ret) < 0)
-		goto err1;
+		goto put_ctxt;
 
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
-		goto err1;
+		goto put_ctxt;
 
 	/* Prevent svc_xprt_release() from releasing the page backing
 	 * rq_res.head[0].iov_base. It's no longer being accessed by
@@ -964,16 +964,16 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	rqstp->rq_respages++;
 	return 0;
 
- err2:
+reply_chunk:
 	if (ret != -E2BIG && ret != -EINVAL)
-		goto err1;
+		goto put_ctxt;
 
 	svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
 	return 0;
 
- err1:
+put_ctxt:
 	svc_rdma_send_ctxt_put(rdma, sctxt);
- err0:
+drop_connection:
 	trace_svcrdma_send_err(rqstp, ret);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
 	return -ENOTCONN;


