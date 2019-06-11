Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9333D058
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391736AbfFKPJK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:09:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37201 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfFKPJJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:09:09 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so10187216iok.4;
        Tue, 11 Jun 2019 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YseAtOodHX0zGVoGxVns5kTOq1agdmY5wGLUtAbZOJY=;
        b=pYRBRrXj0ZA39BjdB03jYOViUdzXMZf5abN9Pc8FCK6pKwuBUOnu50hk93+VryozcX
         rDstKvHzztu3EC6hfAFqRHFDKqoQr7/8B0OjaJpbkhYFxbufTjbRkidl8Sw3shRrHwqk
         jDVx0DFNPlEMvjBlUEEFG+gPjzl8yGb2UH4kJLncS7FxFtv0Egwsl96wNwsTLbwiBGmV
         z4jcdUib5FOEJl0FuAMCNB0P5HaXrvKeWbohHaygs3ONUabF0BKu//T6PfDFcl8GVZK6
         0mu+Hc2kr7hcQtynsEByvoBQ6pH3mHc424Jy15lSs2i5GUZ54CwGvTSLAGjuYQRZ9ay4
         1c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YseAtOodHX0zGVoGxVns5kTOq1agdmY5wGLUtAbZOJY=;
        b=N8ybzUpOJAUlloj+/33fczg5KaMOUblDr7doImdsiOra6sMzFlKkajhzsOlPaohwX4
         EUlQ5rowgbyJSs6pNAxWnG61Gjx51moo7iAl3eaq4CIlWJjNOxFdWXvRO0UfxfsHw4Cm
         AFCJaPB4L3ufaSED6tVnHY9gzmYUP2HrPk8OpaECggExYWe+2KIsguhDleF/dxCCOGSr
         rtpDg3Si+Ynw+4uus6ZOuLDbBt/J/leRlTAA71qnoITFgNq4098gwWBo/3gepapM6Vk/
         c1Y7q4cqtXO5Ge57JtBXTKsDmt64JpjpUGig5VEm2tlVr2TQwzFs8lJMvRGWB6z2tfx5
         ++KQ==
X-Gm-Message-State: APjAAAVvXu/5MrUIqLdTU39jqzMFInrz2SUYRnEuD+9XHSL4t54L3fWz
        Ve1kfa2D4x6UqGSf7phy8OUAyDnW
X-Google-Smtp-Source: APXvYqz6A8g4sV6gWZnzIThfMqm4To9CV6bqRClT0ngS6qK60ZHIVR+jLzjeA8znnz1/eCpyXHlKgA==
X-Received: by 2002:a5e:a90f:: with SMTP id c15mr51074547iod.133.1560265748916;
        Tue, 11 Jun 2019 08:09:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r143sm2017377ita.0.2019.06.11.08.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:09:08 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF9726021764;
        Tue, 11 Jun 2019 15:09:07 GMT
Subject: [PATCH v2 13/19] xprtrdma: Remove rpcrdma_req::rl_buffer
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:09:07 -0400
Message-ID: <20190611150907.2877.23009.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

There is only one remaining function, rpcrdma_buffer_put(), that
uses this field. Its caller can supply a pointer to the correct
rpcrdma_buffer, enabling the removal of an 8-byte pointer field
from a frequently-allocated shared data structure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    5 ++++-
 net/sunrpc/xprtrdma/verbs.c     |    6 ++----
 net/sunrpc/xprtrdma/xprt_rdma.h |    4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 9575f1d..3688e078 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -550,8 +550,11 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 static void
 xprt_rdma_free_slot(struct rpc_xprt *xprt, struct rpc_rqst *rqst)
 {
+	struct rpcrdma_xprt *r_xprt =
+		container_of(xprt, struct rpcrdma_xprt, rx_xprt);
+
 	memset(rqst, 0, sizeof(*rqst));
-	rpcrdma_buffer_put(rpcr_to_rdmar(rqst));
+	rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
 	rpc_wake_up_next(&xprt->backlog);
 }
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3270c8a..805b1f35 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1019,7 +1019,6 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	if (!req->rl_recvbuf)
 		goto out4;
 
-	req->rl_buffer = buffer;
 	INIT_LIST_HEAD(&req->rl_registered);
 	spin_lock(&buffer->rb_lock);
 	list_add(&req->rl_all, &buffer->rb_allreqs);
@@ -1299,13 +1298,12 @@ struct rpcrdma_req *
 
 /**
  * rpcrdma_buffer_put - Put request/reply buffers back into pool
+ * @buffers: buffer pool
  * @req: object to return
  *
  */
-void
-rpcrdma_buffer_put(struct rpcrdma_req *req)
+void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
 {
-	struct rpcrdma_buffer *buffers = req->rl_buffer;
 	struct rpcrdma_rep *rep = req->rl_reply;
 
 	req->rl_reply = NULL;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 5475f0d..117e328 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -320,7 +320,6 @@ enum {
 struct rpcrdma_req {
 	struct list_head	rl_list;
 	struct rpc_rqst		rl_slot;
-	struct rpcrdma_buffer	*rl_buffer;
 	struct rpcrdma_rep	*rl_reply;
 	struct xdr_stream	rl_stream;
 	struct xdr_buf		rl_hdrbuf;
@@ -499,7 +498,8 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 }
 
 struct rpcrdma_req *rpcrdma_buffer_get(struct rpcrdma_buffer *);
-void rpcrdma_buffer_put(struct rpcrdma_req *);
+void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers,
+			struct rpcrdma_req *req);
 void rpcrdma_recv_buffer_put(struct rpcrdma_rep *);
 
 bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size,

