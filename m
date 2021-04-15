Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC79360B69
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhDOOFw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 10:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbhDOOFw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Apr 2021 10:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3245611F1;
        Thu, 15 Apr 2021 14:05:28 +0000 (UTC)
Subject: [PATCH v1 1/3] svcrdma: Don't leak send_ctxt on Send errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 15 Apr 2021 10:05:28 -0400
Message-ID: <161849552807.27023.3060894326479643195.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Address a rare send_ctxt leak in the svc_rdma_sendto() error paths.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 056452cabc98..39aec629aaeb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -936,7 +936,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	p = xdr_reserve_space(&sctxt->sc_stream,
 			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
-		goto err0;
+		goto err1;
 
 	ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
 	if (ret < 0)
@@ -948,11 +948,11 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	*p = pcl_is_empty(&rctxt->rc_reply_pcl) ? rdma_msg : rdma_nomsg;
 
 	if (svc_rdma_encode_read_list(sctxt) < 0)
-		goto err0;
+		goto err1;
 	if (svc_rdma_encode_write_list(rctxt, sctxt) < 0)
-		goto err0;
+		goto err1;
 	if (svc_rdma_encode_reply_chunk(rctxt, sctxt, ret) < 0)
-		goto err0;
+		goto err1;
 
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)


