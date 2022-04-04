Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CC74F1B6A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379636AbiDDVUT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379827AbiDDSLg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 14:11:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3DA3A73D
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 11:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4E3260DE3
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F818C2BBE4
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:36 +0000 (UTC)
Subject: [PATCH v1 6/6] SUNRPC: Remove svc_rqst::rq_xprt_hlen
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Apr 2022 14:09:35 -0400
Message-ID: <164909577591.3716.15050159604323490718.stgit@manet.1015granger.net>
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

Clean up: This field is now always set to zero.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h              |    2 --
 include/trace/events/sunrpc.h           |    3 +--
 net/sunrpc/svc_xprt.c                   |    8 +++-----
 net/sunrpc/svcsock.c                    |    2 --
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    1 -
 5 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 217711fc9cac..b73704fbd09b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -257,7 +257,6 @@ struct svc_rqst {
 	void *			rq_xprt_ctxt;	/* transport specific context ptr */
 	struct svc_deferred_req*rq_deferred;	/* deferred request we are replaying */
 
-	size_t			rq_xprt_hlen;	/* xprt header len */
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
 	struct xdr_stream	rq_res_stream;
@@ -397,7 +396,6 @@ struct svc_deferred_req {
 	size_t			daddrlen;
 	void			*xprt_ctxt;
 	struct cache_deferred_req handle;
-	size_t			xprt_hlen;
 	int			argslen;
 	__be32			args[];
 };
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index de099ca585d7..6d72df4d29be 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2021,8 +2021,7 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 
 	TP_fast_assign(
 		__entry->dr = dr;
-		__entry->xid = be32_to_cpu(*(__be32 *)(dr->args +
-						       (dr->xprt_hlen>>2)));
+		__entry->xid = be32_to_cpu(*(__be32 *)dr->args);
 		__assign_sockaddr(addr, &dr->addr, dr->addrlen);
 	),
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 5b59e2103526..a4661f8d50ff 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1230,7 +1230,6 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr->addrlen = rqstp->rq_addrlen;
 		dr->daddr = rqstp->rq_daddr;
 		dr->argslen = rqstp->rq_arg.len >> 2;
-		dr->xprt_hlen = rqstp->rq_xprt_hlen;
 		dr->xprt_ctxt = rqstp->rq_xprt_ctxt;
 		rqstp->rq_xprt_ctxt = NULL;
 
@@ -1258,9 +1257,9 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 	trace_svc_defer_recv(dr);
 
 	/* setup iov_base past transport header */
-	rqstp->rq_arg.head[0].iov_base = dr->args + (dr->xprt_hlen>>2);
+	rqstp->rq_arg.head[0].iov_base = dr->args;
 	/* The iov_len does not include the transport header bytes */
-	rqstp->rq_arg.head[0].iov_len = (dr->argslen<<2) - dr->xprt_hlen;
+	rqstp->rq_arg.head[0].iov_len = (dr->argslen<<2);
 	rqstp->rq_arg.page_len = 0;
 	/* The rq_arg.len includes the transport header bytes */
 	rqstp->rq_arg.len     = dr->argslen<<2;
@@ -1268,12 +1267,11 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 	memcpy(&rqstp->rq_addr, &dr->addr, dr->addrlen);
 	rqstp->rq_addrlen     = dr->addrlen;
 	/* Save off transport header len in case we get deferred again */
-	rqstp->rq_xprt_hlen   = dr->xprt_hlen;
 	rqstp->rq_daddr       = dr->daddr;
 	rqstp->rq_respages    = rqstp->rq_pages;
 	rqstp->rq_xprt_ctxt   = dr->xprt_ctxt;
 	svc_xprt_received(rqstp->rq_xprt);
-	return (dr->argslen<<2) - dr->xprt_hlen;
+	return (dr->argslen<<2);
 }
 
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index de91643eecb7..2ac619482ed0 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -250,8 +250,6 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 	ssize_t len;
 	size_t t;
 
-	rqstp->rq_xprt_hlen = 0;
-
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 
 	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE) {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 864131a9fc6e..5242ad121450 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -831,7 +831,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		goto out_err;
 	if (ret == 0)
 		goto out_drop;
-	rqstp->rq_xprt_hlen = 0;
 
 	if (svc_rdma_is_reverse_direction_reply(xprt, ctxt))
 		goto out_backchannel;


