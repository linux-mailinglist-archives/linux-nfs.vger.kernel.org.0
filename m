Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD0120D860
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgF2Til (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387446AbgF2Tho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:37:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78915C02F018;
        Mon, 29 Jun 2020 07:50:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i16so13014619qtr.7;
        Mon, 29 Jun 2020 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qI6XUHEnEM+k66AQNlTZ1Xi4+elDUxoiA9HIMNVsMuE=;
        b=C5orZIqJ+gphRsO4ZoZztVdz0FycN7X4vYQaaCAZ3yOqBYQhp4vnP7KTpsVMPGyuWR
         bvqSzWt6cH6nCf8PYM8QMenrjFElhGtM04t9Ivk5O9Uj4BHBP+5qqcWmVVGacJuSoFtV
         memyhCYuih+kjRwsTu+jZfFzezV1cS2wRe/Rq9GsKwNnBQ8qjbCUhkmKCIp2uhtNqFGe
         9B38V193fkpplbcT8mm2GWSLZErhH1dorwrWjY1svRUwpsbcEiv78tWaVspUtQMa9MlQ
         8CNh6faXE5x4N73RPWCys+JrcCUfXK+jxPGeUXnCe5HuqtbdpNS0A5z8HeAaJNbkwRT2
         ncUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qI6XUHEnEM+k66AQNlTZ1Xi4+elDUxoiA9HIMNVsMuE=;
        b=ZCeR2Ni3Zv5fMdieD650pbu1eA4M4JOvMmPnH7a2S8H3y4n60HMdfdnAVfIhEBQY4B
         xUUaKJr6GPsrjuQpKljfF4YJyxsmOZpAdOOZtAR2V9EXgdsxL1HQZa4t4CtRcRR4VT8S
         EswSoq4g+GMwn+rIA8+irAOLPtL2C9tUJgUE4SRWHUP8MADE8nv8EtHpo308OJx/GXNX
         UtKBX0otJhdMkJ28/7vYwh1V5x/eLhydGAXzTQ0bWuIUWzhlM5RoHrUswDPZ9wb+BMHb
         EdA6nkWmsZZ/txZ4iow+uzmNLxAt4B4CEW2gpM6PElXuOQq02nfMpJMwIeI3MoC3XpiD
         D15A==
X-Gm-Message-State: AOAM530zOfB3tTZ26KGLoBwB+zO1xtsotb5Wsy58ieAwSVlPpogzYHXK
        aKk6wddtqmOT6/lG+FoOik26I8GM
X-Google-Smtp-Source: ABdhPJz5Y0EB3juFl3jtP7nrwuDxGBKOY5CqVCUlkT383wBHFoktsI/+pUUMqW6ogMTBs8ctXnfYFw==
X-Received: by 2002:ac8:544d:: with SMTP id d13mr16517331qtq.375.1593442230447;
        Mon, 29 Jun 2020 07:50:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p66sm25096qkf.58.2020.06.29.07.50.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:50:30 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEoToc006211;
        Mon, 29 Jun 2020 14:50:29 GMT
Subject: [PATCH v2 6/8] svcrdma: Make svc_rdma_send_error_msg() a global
 function
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:50:29 -0400
Message-ID: <20200629145029.15024.95030.stgit@klimt.1015granger.net>
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

