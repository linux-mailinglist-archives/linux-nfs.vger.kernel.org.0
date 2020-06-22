Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A84204254
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgFVVBU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 17:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVVBU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jun 2020 17:01:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A68C061573;
        Mon, 22 Jun 2020 14:01:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so13273329qkc.6;
        Mon, 22 Jun 2020 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=m3s/UkyYnkq3YGDNG0dmiQUvsV/sibLQqZw3O2Q0D4M=;
        b=BUOGsxRaB9qHlUIiMx4499bcIAZkGJo/OoNNgyEjeaq60KXonah1ehvPY79hAPeEZ8
         LoZIr4ipBdzxgHw0w8tNaBE9fK+lVGOittK2KamW2hTle+3mbY20Pl4Kb8WsTKCdoHoA
         xDkcgWD6YTCy+mQ2ZNAvmIM8LtrlLzYJVgyVGI086eWNG0jJTKI3kYrZ8weUPvo7zgeM
         iDQtDosPuJBTbSulREsJKWi+QzTObNi0tVe6+qKmss61Xu2OYYXCi45HEhTLqaswTAVc
         N27KbRiSJpYMLebOtB9XzHkqJoOq2yJu/45MWFQSfQYLG3KdJ0g/UBuAijt5OQpED+lU
         c4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=m3s/UkyYnkq3YGDNG0dmiQUvsV/sibLQqZw3O2Q0D4M=;
        b=UNJJr9C4UkS+pwgXYFAh2SQ9j+aQS3c4sbyoT+bvtbveiJk3xddrhNDBLhT5Lkr6tS
         00WdBOlpqCFGSoyLsidh5C5VAxCrWWT6D6+bh6ZXGanJR574EOzWEDvg0mA+gFLMDItN
         x5oyPUzHrSmT2epkFF+wiucbdVRYuPrrlBGG1+FZUZFrJvLktIS3E/ss3rEvWkZAUteV
         ubx+L8kkr4UWsxpAPzltULXZHHapKF7VBIIqKg1hEezAjCr9B0MPgOvufJNQesTEOCAj
         RZXQ5qvV9LmC7QAoPZc2f3nhT+CjnJQTbAl2Go939velTtRDQo9Fm/OV+PZD+lGdyBza
         qvtA==
X-Gm-Message-State: AOAM530AWy7ybMA+QrhmEjuBQpFLikHnYOrtExCrcFIvHY655QaEhZvR
        fJqMIz0bdUdIaGjLmVP3NUyveky/
X-Google-Smtp-Source: ABdhPJyS9bzKGidfjVzYtCk5BsA8p28xW0LL/PuFhUdgRSZFph3f0xcauUbysszFEEdfrcrGJMYnTQ==
X-Received: by 2002:a37:9dc1:: with SMTP id g184mr3751846qke.135.1592859677050;
        Mon, 22 Jun 2020 14:01:17 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m14sm15490111qke.99.2020.06.22.14.01.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 14:01:16 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05ML1Fkv018828;
        Mon, 22 Jun 2020 21:01:15 GMT
Subject: [PATCH v1 3/6] svcrdma: Add @rctxt parameter to
 svc_rdma_send_error() functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 22 Jun 2020 17:01:15 -0400
Message-ID: <20200622210115.2144.66473.stgit@klimt.1015granger.net>
In-Reply-To: <20200622205906.2144.43930.stgit@klimt.1015granger.net>
References: <20200622205906.2144.43930.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Another step towards making svc_rdma_send_error_msg() and
svc_rdma_send_error() similar enough to eliminate one of them.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    9 +++++----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   23 +++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e426fedb9524..60d855116ae7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -715,10 +715,11 @@ static void rdma_read_complete(struct svc_rqst *rqstp,
 }
 
 static void svc_rdma_send_error(struct svcxprt_rdma *xprt,
-				__be32 *rdma_argp, int status)
+				struct svc_rdma_recv_ctxt *rctxt,
+				int status)
 {
+	__be32 *p, *rdma_argp = rctxt->rc_recv_buf;
 	struct svc_rdma_send_ctxt *ctxt;
-	__be32 *p;
 	int ret;
 
 	ctxt = svc_rdma_send_ctxt_get(xprt);
@@ -900,13 +901,13 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	return 0;
 
 out_err:
-	svc_rdma_send_error(rdma_xprt, p, ret);
+	svc_rdma_send_error(rdma_xprt, ctxt, ret);
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
 	return 0;
 
 out_postfail:
 	if (ret == -EINVAL)
-		svc_rdma_send_error(rdma_xprt, p, ret);
+		svc_rdma_send_error(rdma_xprt, ctxt, ret);
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
 	return ret;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 2f88d01e8d27..47ada61411c3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -811,18 +811,17 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
  * Remote Invalidation is skipped for simplicity.
  */
 static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
-				   struct svc_rdma_send_ctxt *ctxt,
-				   struct svc_rqst *rqstp)
+				   struct svc_rdma_send_ctxt *sctxt,
+				   struct svc_rdma_recv_ctxt *rctxt)
 {
-	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
 	__be32 *p;
 
-	rpcrdma_set_xdrlen(&ctxt->sc_hdrbuf, 0);
-	xdr_init_encode(&ctxt->sc_stream, &ctxt->sc_hdrbuf, ctxt->sc_xprt_buf,
-			NULL);
+	rpcrdma_set_xdrlen(&sctxt->sc_hdrbuf, 0);
+	xdr_init_encode(&sctxt->sc_stream, &sctxt->sc_hdrbuf,
+			sctxt->sc_xprt_buf, NULL);
 
-	p = xdr_reserve_space(&ctxt->sc_stream, RPCRDMA_HDRLEN_ERR);
+	p = xdr_reserve_space(&sctxt->sc_stream, RPCRDMA_HDRLEN_ERR);
 	if (!p)
 		return -ENOMSG;
 
@@ -833,10 +832,10 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	*p   = err_chunk;
 	trace_svcrdma_err_chunk(*rdma_argp);
 
-	ctxt->sc_send_wr.num_sge = 1;
-	ctxt->sc_send_wr.opcode = IB_WR_SEND;
-	ctxt->sc_sges[0].length = ctxt->sc_hdrbuf.len;
-	return svc_rdma_send(rdma, &ctxt->sc_send_wr);
+	sctxt->sc_send_wr.num_sge = 1;
+	sctxt->sc_send_wr.opcode = IB_WR_SEND;
+	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
+	return svc_rdma_send(rdma, &sctxt->sc_send_wr);
 }
 
 /**
@@ -931,7 +930,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	 * of previously posted RDMA Writes.
 	 */
 	svc_rdma_save_io_pages(rqstp, sctxt);
-	ret = svc_rdma_send_error_msg(rdma, sctxt, rqstp);
+	ret = svc_rdma_send_error_msg(rdma, sctxt, rctxt);
 	if (ret < 0)
 		goto err1;
 	return 0;

