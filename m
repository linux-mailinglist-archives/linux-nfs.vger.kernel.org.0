Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DBA204252
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 23:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgFVVBN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 17:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVVBM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jun 2020 17:01:12 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65CC061573;
        Mon, 22 Jun 2020 14:01:12 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g7so8650132qvx.11;
        Mon, 22 Jun 2020 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qdqoEbktn4y6PV/kskrC+LFY1GfPSLmprda8TiArdPQ=;
        b=qcII2JTrTJMeqBN1qnNetl8aBPED4Juz6u04LAR86snYYRfRP7iG0bF+XuuFwRdGS+
         e/PneF2BhSmN5c1Tfqjc4V1v+ccDLr3aSOzWzEk2m/GezVOA3vlDJZv3qzapAZ04dbQQ
         nD/SbytLoVh8GBGNjc/Gns/d4sn3Xic4EBjvjwZSQLcljSEbyMiBbJkfI9HfUv8mJtYu
         WSs53wUWUpjXUDYaHlJb0lDtaOVgcKkBXF/TQTnM8VNA6fkpQcZffmEN0wW+1MfLejaE
         XqAQ+w7kah6v1j8fX51Mkl6C+KgRPCz3Y/Iw/Ch006XZgPslw+2qZRVHwvw3vwEJukBx
         z5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qdqoEbktn4y6PV/kskrC+LFY1GfPSLmprda8TiArdPQ=;
        b=HYyNpPaWfp3wUGzRuoDHo/CUb9H5I92HjYVOLD186ouW9F772J/fTL+uzx8BYuuIz3
         6rtUTEPsdVmPDI/PwESV28f0W99PzOBEXgbFJuVsMiTHq81QbuPu4a+7mbG+Hq9SxrT2
         Un93265qqpXM+7/1/s0ddozdX+gNvU0PtnmwuP7JVPp1tZDPFHzn8azjfC7cCPUHD7YW
         FqS/zLtdqKGxrkLOfpg8S+r0G7yftd5gejPWV8Oa3Tmg7M0V9ZTBST6ZUTsm+eYyw//w
         a/PGojX9T0v2D5x8MdNjubVjAlaXrf4tqho7Jlr8nGkAuQeTxOYpBDb6yYjARmtM6xrD
         Zxww==
X-Gm-Message-State: AOAM530c70J3HbOL1tONEzPRcU7RnLtQ8rdC9JCPcuxePVjd8oR4JlMj
        Dzu+BUBBcn1mdHPBe5X8soWl8f/H
X-Google-Smtp-Source: ABdhPJz0HDBzCtmKbXuOD0U/Sl8f4TI0FjKpDCRkvOq7tyIQjmcoPs3jhMYutikOKmGsfB3oluKzkw==
X-Received: by 2002:ad4:476a:: with SMTP id d10mr11319225qvx.13.1592859671759;
        Mon, 22 Jun 2020 14:01:11 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e25sm1161316qtc.93.2020.06.22.14.01.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 14:01:11 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05ML1AZk018825;
        Mon, 22 Jun 2020 21:01:10 GMT
Subject: [PATCH v1 2/6] svcrdma: Remove save_io_pages() call from
 send_error_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 22 Jun 2020 17:01:10 -0400
Message-ID: <20200622210110.2144.55065.stgit@klimt.1015granger.net>
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

Commit 4757d90b15d8 ("svcrdma: Report Write/Reply chunk overruns")
made an effort to preserve I/O pages until RDMA Write completion.

In a subsequent patch, I intend to de-duplicate the two functions
that send ERR_CHUNK responses. Pull the save_io_pages() call out of
svc_rdma_send_error_msg() to make it more like
svc_rdma_send_error().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 38e7c3c8c4a9..2f88d01e8d27 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -806,8 +806,7 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 
 /* Given the client-provided Write and Reply chunks, the server was not
  * able to form a complete reply. Return an RDMA_ERROR message so the
- * client can retire this RPC transaction. As above, the Send completion
- * routine releases payload pages that were part of a previous RDMA Write.
+ * client can retire this RPC transaction.
  *
  * Remote Invalidation is skipped for simplicity.
  */
@@ -834,8 +833,6 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	*p   = err_chunk;
 	trace_svcrdma_err_chunk(*rdma_argp);
 
-	svc_rdma_save_io_pages(rqstp, ctxt);
-
 	ctxt->sc_send_wr.num_sge = 1;
 	ctxt->sc_send_wr.opcode = IB_WR_SEND;
 	ctxt->sc_sges[0].length = ctxt->sc_hdrbuf.len;
@@ -930,6 +927,10 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (ret != -E2BIG && ret != -EINVAL)
 		goto err1;
 
+	/* Send completion releases payload pages that were part
+	 * of previously posted RDMA Writes.
+	 */
+	svc_rdma_save_io_pages(rqstp, sctxt);
 	ret = svc_rdma_send_error_msg(rdma, sctxt, rqstp);
 	if (ret < 0)
 		goto err1;

