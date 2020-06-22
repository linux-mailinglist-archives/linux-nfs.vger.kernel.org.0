Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5B20425A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 23:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgFVVBe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVVBd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jun 2020 17:01:33 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C74C061573;
        Mon, 22 Jun 2020 14:01:33 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id g7so8650664qvx.11;
        Mon, 22 Jun 2020 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qI6XUHEnEM+k66AQNlTZ1Xi4+elDUxoiA9HIMNVsMuE=;
        b=Y6k3e9KPmg24akmIW5czCumCB1ISgNNvHloxu+C9Usau3FBRM++pFnPmpePlaV/MlV
         bWiVbBqtGAr1WJ6KtaPjEarXK5HVllDAsizMFQgAOacUzMvncmphNPavuJX7FWsl14jl
         xDZ++HPm6sAftP/rhhIctrN80iWSwOqjnAyfaPHXTiDnpg6j74FfGwOEsZHyXDH75rSw
         4ellPxgamro8vfSSSBNmu2MdjBhnEH0HRV2P1qbF2ooRpV1Y8SgUn01k8mgmkquENxLk
         /LTV6e51wtFmeK0PiobOcfUv2C0anV2u7z3KzRK8mSk4Wbqfy6c8K0Gpl99NQWawtpUZ
         5T7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qI6XUHEnEM+k66AQNlTZ1Xi4+elDUxoiA9HIMNVsMuE=;
        b=AB2gXuD65eFUSpJlo2M5xLPbFlT+kuoh1KdnEX4GjRnEXon17YONKnMPBdgy0dw/Ox
         9I2niBZuWbtTUwmvPF9OuVdYHdtotCZ31FMITw0aYZnPyR1THcRbeMQBKFK2M7Cdzmbg
         gkKGCnkPvXWjq42NzrY7SkNWsxKexo9UpSOI5Yu48EURsWLPPXkrd9yxNaw9n8g8Jf6y
         o765AiRfpDGfwndAt7XEZwwsXWqUJCnYehErH5zEgC0YS9ZAILwk5EcebMVIIKL4N4/B
         KpUwChxboJVomt0Y6JFcNDxUOKxDsbofj/i+s3z2XGyUWbC15Qt6uWAb+6SK1IX/HZlK
         Z/IA==
X-Gm-Message-State: AOAM531n4XMa3xef18W2UXtqKgKZjA0uuxF5iolixUjioIx8scMoWumM
        3OQ2aymVYWLRgGVW7X5dCBEvtEIl
X-Google-Smtp-Source: ABdhPJx05Az7wh6bBZlQuhcBT676A1sw10IaOFOfgreD62rdabOf4K5dsRKfI7pM8UWOEcEfL4iw2Q==
X-Received: by 2002:a0c:b50a:: with SMTP id d10mr13287196qve.192.1592859692488;
        Mon, 22 Jun 2020 14:01:32 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c27sm4854623qka.23.2020.06.22.14.01.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 14:01:32 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05ML1V1L018838;
        Mon, 22 Jun 2020 21:01:31 GMT
Subject: [PATCH v1 6/6] svcrdma: Make svc_rdma_send_error_msg() a global
 function
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 22 Jun 2020 17:01:31 -0400
Message-ID: <20200622210131.2144.914.stgit@klimt.1015granger.net>
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

Prepare for svc_rdma_send_error_msg() to be invoked from another
source file.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    4 ++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   28 +++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 7ed82625dc0b..1579f7a14ab4 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -195,6 +195,10 @@ extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *sctxt,
 				  const struct svc_rdma_recv_ctxt *rctxt,
 				  struct xdr_buf *xdr);
+extern void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
+				    struct svc_rdma_send_ctxt *sctxt,
+				    struct svc_rdma_recv_ctxt *rctxt,
+				    int status);
 extern int svc_rdma_sendto(struct svc_rqst *);
 extern int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 				 unsigned int length);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index fb548b548c4b..57041298fe4f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -804,16 +804,25 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 	return svc_rdma_send(rdma, &sctxt->sc_send_wr);
 }
 
-/* Given the client-provided Write and Reply chunks, the server was not
- * able to form a complete reply. Return an RDMA_ERROR message so the
- * client can retire this RPC transaction.
- *
- * Remote Invalidation is skipped for simplicity.
+/**
+ * svc_rdma_send_error_msg - Send an RPC/RDMA v1 error response
+ * @rdma: controlling transport context
+ * @sctxt: Send context for the response
+ * @rctxt: Receive context for incoming bad message
+ * @status: negative errno indicating error that occurred
+ *
+ * Given the client-provided Read, Write, and Reply chunks, the
+ * server was not able to parse the Call or form a complete Reply.
+ * Return an RDMA_ERROR message so the client can retire the RPC
+ * transaction.
+ *
+ * The caller does not have to release @sctxt. It is released by
+ * Send completion, or by this function on error.
  */
-static void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
-				    struct svc_rdma_send_ctxt *sctxt,
-				    struct svc_rdma_recv_ctxt *rctxt,
-				    int status)
+void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
+			     struct svc_rdma_send_ctxt *sctxt,
+			     struct svc_rdma_recv_ctxt *rctxt,
+			     int status)
 {
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
 	__be32 *p;
@@ -852,6 +861,7 @@ static void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 		trace_svcrdma_err_chunk(*rdma_argp);
 	}
 
+	/* Remote Invalidation is skipped for simplicity. */
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;

