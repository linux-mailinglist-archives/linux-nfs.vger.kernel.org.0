Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A354BBAB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfFSOdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:33:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44966 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfFSOdi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:33:38 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so38542094iob.11;
        Wed, 19 Jun 2019 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YseAtOodHX0zGVoGxVns5kTOq1agdmY5wGLUtAbZOJY=;
        b=u0hVHCK883r/IPUHPKWhRxL+M5HLtHlDcU4RC9xRJHYuj1n2jhxW/w1M4kEiS2hPAF
         OXGwIi6GtDhCn2zo94eup36DIhR2KhlfGo2LG+3YnT+EL7TXzUUKuL73Ji6zwqe6H/wv
         LXzFva06lMNuP5gmye/YBCvPSoqI2CJviWmWET6bCX8c3fjOev78tQdFnR5y85+eUaTb
         tRfq2xSe6I+tPiC8pqKokB3j6l0GBaGplgMN8Z+zIyHfiXqn34y8/grOqMtYDzxNafw9
         YvSE65vs1aDQvUCYaG/JltaEf2hnYvYDZHWjwQzUl/OQpcmfvGqkoqVeIU7UA8NxL71k
         HXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YseAtOodHX0zGVoGxVns5kTOq1agdmY5wGLUtAbZOJY=;
        b=r1dXm3AB8Vcl5esyDXJYOatgU2NesQN9I4rgeP9SAR3EVMYOJiFX7UhNIRn5OuIdvg
         9LSPTwKTQqJyPyqdki7mZtMqPw/SLv4JvOSu68CJdGkWtFGaIg4PdAp9UiByIXXkYvFH
         naPPsg/fBGEEOGhpwySyhiZWztktlG/udCEAzEpOc44cQNFF4HGyVLLJVopo7SK9lHpe
         vTlnih9V4aK/e8gnXU+sIclEnT35gasdwdlUG8GZr//aPDRsfJtlhB6ZHAwUrdCUWAL2
         XAWqUvyHDs7OIGwVHCVpiOO0zjdZDEo3h9+SP8gBd7TmWoqcg5/s3twxQtc/0qtYm9b4
         84ZQ==
X-Gm-Message-State: APjAAAWICVsTQDjL28IhcO+c8vEJ/CdlPCo1MDh8A2UgaiPG+GGytDoi
        UFeB9wjKLZXKtzOvGCXamLM=
X-Google-Smtp-Source: APXvYqzijsNRd+byflY+Us9GRpeLJdwkIvULRTOFuIVyzTxBpKQZCg8IFvIhzveiCoD9Naa/67XzOA==
X-Received: by 2002:a02:a384:: with SMTP id y4mr95283455jak.77.1560954818082;
        Wed, 19 Jun 2019 07:33:38 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h19sm14990541iol.65.2019.06.19.07.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:37 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEXaue004530;
        Wed, 19 Jun 2019 14:33:36 GMT
Subject: [PATCH v4 13/19] xprtrdma: Remove rpcrdma_req::rl_buffer
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:33:36 -0400
Message-ID: <20190619143336.3826.86300.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
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

