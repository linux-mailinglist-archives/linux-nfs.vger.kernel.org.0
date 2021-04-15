Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9CA360B6D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhDOOGE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 10:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOOGE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Apr 2021 10:06:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13BBD61153;
        Thu, 15 Apr 2021 14:05:41 +0000 (UTC)
Subject: [PATCH v1 3/3] svcrdma: Pass a useful error code to the send_err
 tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 15 Apr 2021 10:05:40 -0400
Message-ID: <161849554037.27023.2734086457915698668.stgit@klimt.1015granger.net>
In-Reply-To: <161849552807.27023.3060894326479643195.stgit@klimt.1015granger.net>
References: <161849552807.27023.3060894326479643195.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Capture error codes in @ret, which is passed to the send_err
tracepoint, so that they can be logged when something goes awry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index a3b0f5899f03..d6bbafb773e1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -921,6 +921,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
 	struct svc_rdma_send_ctxt *sctxt;
+	unsigned int rc_size;
 	__be32 *p;
 	int ret;
 
@@ -933,6 +934,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!sctxt)
 		goto drop_connection;
 
+	ret = -EMSGSIZE;
 	p = xdr_reserve_space(&sctxt->sc_stream,
 			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
@@ -941,17 +943,21 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
 	if (ret < 0)
 		goto reply_chunk;
+	rc_size = ret;
 
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = rdma->sc_fc_credits;
 	*p = pcl_is_empty(&rctxt->rc_reply_pcl) ? rdma_msg : rdma_nomsg;
 
-	if (svc_rdma_encode_read_list(sctxt) < 0)
+	ret = svc_rdma_encode_read_list(sctxt);
+	if (ret < 0)
 		goto put_ctxt;
-	if (svc_rdma_encode_write_list(rctxt, sctxt) < 0)
+	ret = svc_rdma_encode_write_list(rctxt, sctxt);
+	if (ret < 0)
 		goto put_ctxt;
-	if (svc_rdma_encode_reply_chunk(rctxt, sctxt, ret) < 0)
+	ret = svc_rdma_encode_reply_chunk(rctxt, sctxt, rc_size);
+	if (ret < 0)
 		goto put_ctxt;
 
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);


