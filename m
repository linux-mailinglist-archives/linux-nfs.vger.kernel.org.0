Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0140920D842
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbgF2Thu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387456AbgF2Thp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:37:45 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2333C02F014;
        Mon, 29 Jun 2020 07:50:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t7so7731523qvl.8;
        Mon, 29 Jun 2020 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qdqoEbktn4y6PV/kskrC+LFY1GfPSLmprda8TiArdPQ=;
        b=VFzoyaMVhuFajSsuvze+4TRviiSsqUWHrQazHBM94wkZcJcme1Kr+RsczMppE2do93
         GFQ1uASU0e/W7RXB8GBt2CRA/Twle5tenunnRCVIP4PoIK/Yj+A9KQCPIDc3B7a2vdNY
         JDGPfd8WShBwumxtFP5jLPos9qXUyiFfODxK1Hf+/Ozxw8rTKPmbUVMxVYxhnXHLP8lM
         nUNZ1f7pN0H6aLHOcqEd58X+3iczrcpgZji4tswM7UcSDnP8jm9h/ytXdS1ebm5Ae/NX
         X0fJG79D3NgpzyBTC0US0idOC9om+PCigVSaL/pONINuhKGu4I/MWjdQmx4VPUeVteCv
         WYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qdqoEbktn4y6PV/kskrC+LFY1GfPSLmprda8TiArdPQ=;
        b=N9zI3ArpeEIs2VmsenDdaDAJY3RMNPLcvaaWMf65hUSDvHhXMQZOCAYyZN2Luxmgn7
         rMoWN6bNvG/Z+AT+7fpm3+lSMKoGD431xn/at56SblcMlqt4fCje7cfH0iWCzitujmX+
         /Ha23JjEgHPI0ifh4Ih8X09SFmuPxMSIdUKdDhlAOQotEAvo8UWjG0fzz198y3n8B5nJ
         AJTrG4Lct7Q96QzNCzLO0rQwlguxhFNwnJtS5bkvI5zy3/z4E1nZyg5J9kCuZzBCNWA3
         vhjRjn9hdjTQZV4QrWFDwOZPo6wbaZFopNQ4T+EdWAanpADiY3CvYaZQjXoAPPBl5kQE
         KCwA==
X-Gm-Message-State: AOAM533OpFFSND9kIO6iqJKcet6EQZDPCqykhgO02G+fjjIvc2AvPuxF
        A+p0ihU1Oyja6Ouot+9vUF3Fy2aa
X-Google-Smtp-Source: ABdhPJwwXu1A+Q3DtTA+w/TNmFZj3V/YwdqFlo7H4DLU3uK3oUHClt0CNOxdv7kY0LPjAOdWz3w2RA==
X-Received: by 2002:a0c:f486:: with SMTP id i6mr15145220qvm.229.1593442209748;
        Mon, 29 Jun 2020 07:50:09 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n64sm20238qke.77.2020.06.29.07.50.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:50:09 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEo8Fn006198;
        Mon, 29 Jun 2020 14:50:08 GMT
Subject: [PATCH v2 2/8] svcrdma: Remove save_io_pages() call from
 send_error_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:50:08 -0400
Message-ID: <20200629145008.15024.61477.stgit@klimt.1015granger.net>
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

