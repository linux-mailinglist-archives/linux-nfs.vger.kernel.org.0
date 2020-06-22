Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF746204258
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgFVVB3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVVB2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jun 2020 17:01:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90970C061573;
        Mon, 22 Jun 2020 14:01:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q198so9075566qka.2;
        Mon, 22 Jun 2020 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zQeMNl3XW1m0/k9561YNZvuwp+BUiHHSMSMoXCctjAY=;
        b=MCXPXJgByh5lkP9bP+Sl7X9c5bKxw8ZCGyIBeZuZVMQ1u+H8yC1gLqBrlAIuFPAJoF
         fmQwZ+6+ghNY6zpNKBTx4fC1SMe/kCsOu6ypE2D61Vt5buo4T4wzxjeVu0ciww03dDL6
         eDAjboZfcqntXGwkpU4Is1AKa2CLoIT9LEp4JDhTwCgS624NcE6VR7bJHoWt6EwR2PMe
         vFYSM5hx6TT+MCe0CxzMlZHQol62VcC3/g5/fHvYSSgekYIwwgYyTYskNAJHwkqnqnzJ
         tz2vld3J+hPYvGVbFKkEmANuEI2Evk5deTtP7oSgyTPR3qqHaljuDBoNEO2EuMwkKql2
         39Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zQeMNl3XW1m0/k9561YNZvuwp+BUiHHSMSMoXCctjAY=;
        b=mBAz8iwEohfqG2FqwzqVq4wllqhAUch0lvciN00yg4PmecEJR2X0Y2ul3Sl7PTkDEj
         teKT+f6SNTRylLZZFqrakI2wDTFDBfy6JcFQjXFC0vKDWMGbhQjWv/BQxbEGEAxjFWLn
         OoxhmrdPMyGvKdzfrhypsRh3bmPsckVNDpCYd/YvGd3IVzIXQPIOTKe+KSpYxyZhalR+
         lFqQpcxd4rMLa4yIwqpz099artSJoAE4CE5xeai4sETlFU+XGoqAeYMTJIfE8ySTUN4u
         peqrusnMXF47nzoOFkCXJ6oeIiRIfVW3QXpC+VldWO1z95u8CP+0qes4VQ6tYeFt5ebh
         LxaA==
X-Gm-Message-State: AOAM532TwOPeZNbS2gFHF5eH05mOnUFireyrfnCDkiYAih5qXEstRXWx
        RJTMwIEJMan8clGkuo+SWk/gpvHl
X-Google-Smtp-Source: ABdhPJx4yfZrv5VQDty7ZoG+0nUHLyjXmeJzt9LXPBySlmpY+7IKRwdTto9kSQcwrSziEulV+rWIUw==
X-Received: by 2002:a37:9e92:: with SMTP id h140mr2665304qke.46.1592859687509;
        Mon, 22 Jun 2020 14:01:27 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q24sm15361413qkj.103.2020.06.22.14.01.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 14:01:26 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05ML1Q4w018835;
        Mon, 22 Jun 2020 21:01:26 GMT
Subject: [PATCH v1 5/6] svcrdma: Eliminate return value for
 svc_rdma_send_error_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 22 Jun 2020 17:01:26 -0400
Message-ID: <20200622210126.2144.96792.stgit@klimt.1015granger.net>
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

Like svc_rdma_send_error(), have svc_rdma_send_error_msg() handle
any error conditions internally, rather than duplicating that
recovery logic at every call site.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 73fe7a213169..fb548b548c4b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -810,10 +810,10 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
  *
  * Remote Invalidation is skipped for simplicity.
  */
-static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
-				   struct svc_rdma_send_ctxt *sctxt,
-				   struct svc_rdma_recv_ctxt *rctxt,
-				   int status)
+static void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
+				    struct svc_rdma_send_ctxt *sctxt,
+				    struct svc_rdma_recv_ctxt *rctxt,
+				    int status)
 {
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
 	__be32 *p;
@@ -825,7 +825,7 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	p = xdr_reserve_space(&sctxt->sc_stream,
 			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
-		return -ENOMSG;
+		goto put_ctxt;
 
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
@@ -836,7 +836,7 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	case -EPROTONOSUPPORT:
 		p = xdr_reserve_space(&sctxt->sc_stream, 3 * sizeof(*p));
 		if (!p)
-			return -ENOMSG;
+			goto put_ctxt;
 
 		*p++ = err_vers;
 		*p++ = rpcrdma_version;
@@ -846,7 +846,7 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	default:
 		p = xdr_reserve_space(&sctxt->sc_stream, sizeof(*p));
 		if (!p)
-			return -ENOMSG;
+			goto put_ctxt;
 
 		*p = err_chunk;
 		trace_svcrdma_err_chunk(*rdma_argp);
@@ -855,7 +855,12 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
-	return svc_rdma_send(rdma, &sctxt->sc_send_wr);
+	if (svc_rdma_send(rdma, &sctxt->sc_send_wr))
+		goto put_ctxt;
+	return;
+
+put_ctxt:
+	svc_rdma_send_ctxt_put(rdma, sctxt);
 }
 
 /**
@@ -950,9 +955,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	 * of previously posted RDMA Writes.
 	 */
 	svc_rdma_save_io_pages(rqstp, sctxt);
-	ret = svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
-	if (ret < 0)
-		goto err1;
+	svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
 	return 0;
 
  err1:

