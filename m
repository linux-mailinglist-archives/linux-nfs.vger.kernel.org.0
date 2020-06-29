Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878E820D841
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgF2Tht (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbgF2Thp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:37:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0BC02F015;
        Mon, 29 Jun 2020 07:50:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q22so6504062qtl.2;
        Mon, 29 Jun 2020 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=m3s/UkyYnkq3YGDNG0dmiQUvsV/sibLQqZw3O2Q0D4M=;
        b=AfhSnfsvIbXQfmLzY/Rt8yo66Wpz5wuvj2qIa1JUd6vcX6NN57tYGUjmSIpLt8huFn
         ecW1dMzvdERrGcYEXcbM/hWGdSX60OULThMeNaPFydlpsmZGmnNDdDC+fZxGUBuMHHVh
         qcXcGBm4Z9VrEM/Qp8Zm9NkrCWiLJJe/h4yJytsAqqSwcIIX7zdMr35N9IGgNLkGE/iJ
         cFdV5XlVsr2BI/j73AKzeGHuE+BLEtc3onSrvn+K6AkpCH79JbQwV9Zty0kcOXy28ZZf
         sWn8xqa0iR9Ip3s3Ft05JLp76scqXykAEp8D3UJPzTKJN18qbUm51rbAr0+26smq9vd5
         SHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=m3s/UkyYnkq3YGDNG0dmiQUvsV/sibLQqZw3O2Q0D4M=;
        b=fTx/TIijQ1jq/lPHq+fzTkJMzGJTs2cYjNFv9j+jkWd1ZPMycvkafbKvhb1SMJDSq2
         PZIr60z/6mYg+PkKr1BuHX0fzIKS7VR/R5Hgiqwtbv/3NFVnYoQkQroeZzhmHvbhqvqO
         mO0+ry1BnsoDDMOPgLPyp0+ti56EojR0ITdXwQIvF/m825uQSiUxt+EPHgkQCQXg6n9E
         tnQFYrTzD7SqgnrLibXpVtPT4fTP/eWhSawErE85AASBg+QZRnRyuY180078rau56lNe
         brVqfv/8sZX2ZBVc/5E41NW+W3k1FxuCgN9bGjipWrA/qe+PZMAJQOpb8Ke5JMzQm2mc
         Yvlw==
X-Gm-Message-State: AOAM533kRO2u7YpiLNi6RXXv3CE7ji/udMU+gSCZhjx1LmfqJf/3DzU6
        WvZAkqXiFtC5z06W5d4RBxeDYag9
X-Google-Smtp-Source: ABdhPJxtzBHSAxjoNJWIKY+xSsiqa5biNN3RNEABOl7ad7oI8LD4csTBkHVl3PNTstuwIqOVFOmyPg==
X-Received: by 2002:aed:3081:: with SMTP id 1mr16580938qtf.118.1593442215019;
        Mon, 29 Jun 2020 07:50:15 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 188sm28021qkf.50.2020.06.29.07.50.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:50:14 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEoD7O006202;
        Mon, 29 Jun 2020 14:50:13 GMT
Subject: [PATCH v2 3/8] svcrdma: Add @rctxt parameter to
 svc_rdma_send_error() functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:50:13 -0400
Message-ID: <20200629145013.15024.68894.stgit@klimt.1015granger.net>
In-Reply-To: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
References: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
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

