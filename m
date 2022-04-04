Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A2E4F1B6F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 23:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377843AbiDDVUX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 17:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379818AbiDDSLF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 14:11:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E8C1ADAA
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 11:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6677B818D4
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BDDC2BBE4
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:05 +0000 (UTC)
Subject: [PATCH v1 1/6] SUNRPC: Fix NFSD's request deferral on RDMA transports
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Apr 2022 14:09:04 -0400
Message-ID: <164909574412.3716.7890208148717978731.stgit@manet.1015granger.net>
In-Reply-To: <164909503892.3716.8666091898179474248.stgit@manet.1015granger.net>
References: <164909503892.3716.8666091898179474248.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust reports an NFSD crash in svc_rdma_sendto(). Further
investigation shows that the crash occurred while NFSD was handling
a deferred request.

This patch addresses two inter-related issues that prevent request
deferral from working correctly:

1. Prevent the crash by ensuring that the svc_rqst::rq_xprt_ctxt
value is available once the request is revisited. Otherwise
svc_rdma_sendto() does not have a proper Receive context available
with which to construct its reply.

2. Possibly since before commit 71641d99ce03 ("svcrdma: Properly
compute .len and .buflen for received RPC Calls"),
svc_rdma_recvfrom() did not include the transport header in the
returned xdr_buf. There should have been no need for svc_defer()
and friends to save and restore that header as of that commit. This
issue is addressed in a backport-friendly way by simply having
svc_rdma_recvfrom() set rq_xprt_hlen to zero unconditionally, as
svc_tcp_recvfrom() does. This enables svc_deferred_recv() to
correctly reconstruct an RPC received via RPC/RDMA.

Reported-by: Trond Myklebust <trondmy@hammerspace.com>
Link: https://lore.kernel.org/linux-nfs/82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com/
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/sunrpc/svc.h              |    1 +
 net/sunrpc/svc_xprt.c                   |    3 +++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index a5dda4987e8b..217711fc9cac 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -395,6 +395,7 @@ struct svc_deferred_req {
 	size_t			addrlen;
 	struct sockaddr_storage	daddr;	/* where reply must come from */
 	size_t			daddrlen;
+	void			*xprt_ctxt;
 	struct cache_deferred_req handle;
 	size_t			xprt_hlen;
 	int			argslen;
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 297c49855038..5b59e2103526 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1231,6 +1231,8 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr->daddr = rqstp->rq_daddr;
 		dr->argslen = rqstp->rq_arg.len >> 2;
 		dr->xprt_hlen = rqstp->rq_xprt_hlen;
+		dr->xprt_ctxt = rqstp->rq_xprt_ctxt;
+		rqstp->rq_xprt_ctxt = NULL;
 
 		/* back up head to the start of the buffer and copy */
 		skip = rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
@@ -1269,6 +1271,7 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_hlen   = dr->xprt_hlen;
 	rqstp->rq_daddr       = dr->daddr;
 	rqstp->rq_respages    = rqstp->rq_pages;
+	rqstp->rq_xprt_ctxt   = dr->xprt_ctxt;
 	svc_xprt_received(rqstp->rq_xprt);
 	return (dr->argslen<<2) - dr->xprt_hlen;
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index cf76a6ad127b..864131a9fc6e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -831,7 +831,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		goto out_err;
 	if (ret == 0)
 		goto out_drop;
-	rqstp->rq_xprt_hlen = ret;
+	rqstp->rq_xprt_hlen = 0;
 
 	if (svc_rdma_is_reverse_direction_reply(xprt, ctxt))
 		goto out_backchannel;


