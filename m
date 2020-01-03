Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0A12FAE4
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgACQ4k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:56:40 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46370 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQ4k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:56:40 -0500
Received: by mail-yw1-f67.google.com with SMTP id u139so18725351ywf.13;
        Fri, 03 Jan 2020 08:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VJgu2/3umFtGBIl1WJIjq2UBGgp/XxZOmw1CIFWppGc=;
        b=t7DaGFDvxdBjTGvPDBoUC4ENy4RIDdxepx/SkbWMRBvE7obWBV1VupAg5SBmTKBSHM
         BnPMMI23qQDk6N1hlbokg3iUwIWsdP97SeVp+Suyzy9K3EyTwTQV4Mvc09mMYK7JHCmd
         cfOplPSES1lfP/VxYDzYAlmGx17OJx/S3uUZSdlpfcfZmJTm2WkITC9LYPcwQ4RYhj+C
         B7o8Q9AgTLM6zx4T78/rqWZfBKqvAGc5RNf6jQI/eXjnQdUuj7Skh7Oc0/MiW6k5LIHg
         UMLwDg6VgJMhBMJYotHdUr3mWb/hwlMMHKDRYogEQ2p2ONqkxN7OqDkA0I5XyFeeNBcT
         zwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=VJgu2/3umFtGBIl1WJIjq2UBGgp/XxZOmw1CIFWppGc=;
        b=q+SCt/5+8oCayGGjF1X0ZVDLCmzM7XmJBLo6rafDo45WUikvoHtirmOAm1E2+kf5Ww
         DdDNBNJAVEetDtXca1DWwgK0+INKCOiG6+gp+11rvKXylqDuOFjVCVScTziJc+EQQdsb
         u/O9zUpBlTy3htXli004Sqp6P0xkJfaSatC9a+J7JXII8eBr6K4+9qiBmdfwo01OCOVP
         9JWOMBQecU0PcuXUUpCRiMUmaDMduSWUrxD7SGQ2SrGbqV+B6nVUxb8RYyPqAwPbiep7
         AP0RKSvAB+lxtP0WwQkQUuPaF37ZFpiVvpvzjWIVcxSnzfWckBHuCFQkvXrtuN0DEGYk
         Smrw==
X-Gm-Message-State: APjAAAV5CKcwo6g8jqj+kiXF7iAjhEnpPbhh+5WYWotZZZyNui5CM5pH
        Wz/+J6K859ac/7xpovkwqKNdkI8w
X-Google-Smtp-Source: APXvYqwagpEIm/aQ+x6AlnDIdaOcH3OgB+WmcW8S+8EkAbpACNYo8BndqcAGJYAql26IalwGYu4ncQ==
X-Received: by 2002:a81:3b45:: with SMTP id i66mr68380387ywa.289.1578070599018;
        Fri, 03 Jan 2020 08:56:39 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j11sm23415484ywg.37.2020.01.03.08.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:56:38 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GubWk016389;
        Fri, 3 Jan 2020 16:56:37 GMT
Subject: [PATCH v1 3/9] xprtrdma: Refactor initialization of
 ep->rep_max_requests
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:56:37 -0500
Message-ID: <157807059776.4606.16811783083488098904.stgit@morisot.1015granger.net>
In-Reply-To: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
References: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: there is no need to keep two copies of the same value.
Also, in subsequent patches, rpcrdma_ep_create() will be called in
the connect worker rather than at set-up time.

Minor fix: Initialize the transport's sendctx to the value based on
the capabilities of the underlying device, not the maximum setting.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |    6 +++---
 net/sunrpc/xprtrdma/transport.c |    3 ++-
 net/sunrpc/xprtrdma/verbs.c     |    8 ++++----
 net/sunrpc/xprtrdma/xprt_rdma.h |    5 ++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index af917228d245..520323ddc930 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -909,7 +909,7 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst)
 		goto out_err;
 	*p++ = rqst->rq_xid;
 	*p++ = rpcrdma_version;
-	*p++ = cpu_to_be32(r_xprt->rx_buf.rb_max_requests);
+	*p++ = r_xprt->rx_buf.rb_max_requests;
 
 	/* When the ULP employs a GSS flavor that guarantees integrity
 	 * or privacy, direct data placement of individual data items
@@ -1480,8 +1480,8 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 
 	if (credits == 0)
 		credits = 1;	/* don't deadlock */
-	else if (credits > buf->rb_max_requests)
-		credits = buf->rb_max_requests;
+	else if (credits > r_xprt->rx_ep.rep_max_requests)
+		credits = r_xprt->rx_ep.rep_max_requests;
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
 	rpcrdma_post_recvs(r_xprt, false);
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 7395eb2cfdeb..f868a75057ad 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -316,7 +316,8 @@ xprt_setup_rdma(struct xprt_create *args)
 	if (args->addrlen > sizeof(xprt->addr))
 		return ERR_PTR(-EBADF);
 
-	xprt = xprt_alloc(args->net, sizeof(struct rpcrdma_xprt), 0, 0);
+	xprt = xprt_alloc(args->net, sizeof(struct rpcrdma_xprt), 0,
+			  xprt_rdma_slot_table_entries);
 	if (!xprt)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3cc6d19f7f3a..4f9595b72888 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -474,13 +474,14 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	struct ib_cq *sendcq, *recvcq;
 	int rc;
 
-	ep->rep_max_requests = xprt_rdma_slot_table_entries;
+	ep->rep_max_requests = r_xprt->rx_xprt.max_reqs;
 	ep->rep_inline_send = xprt_rdma_max_inline_write;
 	ep->rep_inline_recv = xprt_rdma_max_inline_read;
 
 	rc = frwr_open(ia, ep);
 	if (rc)
 		return rc;
+	r_xprt->rx_buf.rb_max_requests = cpu_to_be32(ep->rep_max_requests);
 
 	ep->rep_attr.event_handler = rpcrdma_qp_event_handler;
 	ep->rep_attr.qp_context = ep;
@@ -820,7 +821,7 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt)
 	 * the ->send_request call to fail temporarily before too many
 	 * Sends are posted.
 	 */
-	i = buf->rb_max_requests + RPCRDMA_MAX_BC_REQUESTS;
+	i = r_xprt->rx_ep.rep_max_requests + RPCRDMA_MAX_BC_REQUESTS;
 	buf->rb_sc_ctxs = kcalloc(i, sizeof(sc), GFP_KERNEL);
 	if (!buf->rb_sc_ctxs)
 		return -ENOMEM;
@@ -1154,7 +1155,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	int i, rc;
 
-	buf->rb_max_requests = r_xprt->rx_ep.rep_max_requests;
 	buf->rb_bc_srv_max_requests = 0;
 	spin_lock_init(&buf->rb_lock);
 	INIT_LIST_HEAD(&buf->rb_mrs);
@@ -1166,7 +1166,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	INIT_LIST_HEAD(&buf->rb_all_reps);
 
 	rc = -ENOMEM;
-	for (i = 0; i < buf->rb_max_requests; i++) {
+	for (i = 0; i < r_xprt->rx_xprt.max_reqs; i++) {
 		struct rpcrdma_req *req;
 
 		req = rpcrdma_req_create(r_xprt, RPCRDMA_V1_DEF_INLINE_SIZE * 2,
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 7655a99fd559..0fde694144f5 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -98,7 +98,7 @@ struct rpcrdma_ep {
 	wait_queue_head_t 	rep_connect_wait;
 	struct rpcrdma_connect_private	rep_cm_private;
 	struct rdma_conn_param	rep_remote_cma;
-	unsigned int		rep_max_requests;	/* set by /proc */
+	unsigned int		rep_max_requests;	/* depends on device */
 	unsigned int		rep_inline_send;	/* negotiated */
 	unsigned int		rep_inline_recv;	/* negotiated */
 	int			rep_receive_count;
@@ -372,7 +372,7 @@ struct rpcrdma_buffer {
 
 	struct llist_head	rb_free_reps;
 
-	u32			rb_max_requests;
+	__be32			rb_max_requests;
 	u32			rb_credits;	/* most recent credit grant */
 
 	u32			rb_bc_srv_max_requests;
@@ -582,7 +582,6 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
 
 /* RPC/RDMA module init - xprtrdma/transport.c
  */
-extern unsigned int xprt_rdma_slot_table_entries;
 extern unsigned int xprt_rdma_max_inline_read;
 extern unsigned int xprt_rdma_max_inline_write;
 void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);


