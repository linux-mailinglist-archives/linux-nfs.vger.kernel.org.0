Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2FC20E5CF
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2020 00:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403909AbgF2Vl7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgF2Sh6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 14:37:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C66C02F02F;
        Mon, 29 Jun 2020 07:59:02 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u12so13015711qth.12;
        Mon, 29 Jun 2020 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CIkNz511rl6KYHK6r8TjqhFW9g2HG/qN/m8S+9SGxmg=;
        b=NVDp/eEGcceNLXO5Izyy7VjIkgYqLG54Yv9ifc5E/SSHZfxJfxUyL+sTsEWdQV/we1
         SQPTiIcFJdllmUzMSsUN7PqO3hhVBGJg8yteGuAMMnh37msnFhfWpYvPq1QGuxn1fxtb
         S8IghGj47v27nqoAW+kQCDci+5Sv7EPGWl4EHOvAJ7w1zufWbf9oOo/yvYQrHw9mZ9w4
         myE/+Sp5kgQu5m/CB8GcK6o0Hpby0lWci7x02+NZQVkk/8/KIONbCgfxrYbbeiKgRmzT
         VcN+V7Qpq4/MT3A7SPfAxCW4M2jhKKtPoP9YS8JcuHopxoUy6pHsMxPsNiDK2K0uH0NY
         TQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=CIkNz511rl6KYHK6r8TjqhFW9g2HG/qN/m8S+9SGxmg=;
        b=QEqmC3hOye6B99ovsuLc4il5EPsWU5LgzO86qJ1MNB1cTbJNWSfRAvOaDh3zSlv/bO
         wiqfDO++Q6Yme7NdyKfUbG8Nx7av9ozCRKSmkSmGisZjm7UXli29YpPNXhZpQoxx2P8R
         0HgYP2nMf1PURSPssm4Z7HSusm+2GFsWYLqpYgcryOx8hboBdgEAf13x8T+51keQ9oMP
         PL2rbE3VkPNAEVbd4W77aBc6lrnDqVEMZVJCB8OO3r9SbytPp8wyaWXOBvP0HR0CAqIE
         7na5CPWajN9vAAgKyimkWqD90rOps8br84LX+rncFuRKYsVU2/8KXwhjt2trMXwHWoyR
         vARw==
X-Gm-Message-State: AOAM531/lumIwFXXd3V0rwh5RmHM4TRKPavyLyb0b6bTUSTc2gaQNXeD
        5ezs/GvmyoaNLVuube4S1JgdfK+0
X-Google-Smtp-Source: ABdhPJyVrhG6BfxK3aRlHM3Uu4d5Si5xILldxM1Kknp8wOa71nWy0roThYpp0gfmCDXE3NHJrMwvLA==
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr16349493qte.196.1593442741695;
        Mon, 29 Jun 2020 07:59:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p66sm51274qkf.58.2020.06.29.07.59.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:59:01 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEx0xc006254;
        Mon, 29 Jun 2020 14:59:00 GMT
Subject: [PATCH v1 5/6] svcrdma: Record send_ctxt completion ID in
 trace_svcrdma_post_send()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:59:00 -0400
Message-ID: <20200629145900.15100.53400.stgit@klimt.1015granger.net>
In-Reply-To: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
References: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

First, refactor: Dereference the svc_rdma_send_ctxt inside
svc_rdma_send() instead of at every call site.

Then, it can be passed into trace_svcrdma_post_send() to get the
proper completion ID.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    3 ++-
 include/trace/events/rpcrdma.h             |   18 +++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   11 ++++++-----
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index c91e00bc937e..9dc3a3b88391 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -196,7 +196,8 @@ extern struct svc_rdma_send_ctxt *
 		svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma);
 extern void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *ctxt);
-extern int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr);
+extern int svc_rdma_send(struct svcxprt_rdma *rdma,
+			 struct svc_rdma_send_ctxt *ctxt);
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *sctxt,
 				  const struct svc_rdma_recv_ctxt *rctxt,
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 782a4d826a4b..aeeba9188ed5 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1839,27 +1839,31 @@ DECLARE_EVENT_CLASS(svcrdma_sendcomp_event,
 
 TRACE_EVENT(svcrdma_post_send,
 	TP_PROTO(
-		const struct ib_send_wr *wr
+		const struct svc_rdma_send_ctxt *ctxt
 	),
 
-	TP_ARGS(wr),
+	TP_ARGS(ctxt),
 
 	TP_STRUCT__entry(
-		__field(const void *, cqe)
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(unsigned int, num_sge)
 		__field(u32, inv_rkey)
 	),
 
 	TP_fast_assign(
-		__entry->cqe = wr->wr_cqe;
+		const struct ib_send_wr *wr = &ctxt->sc_send_wr;
+
+		__entry->cq_id = ctxt->sc_cid.ci_queue_id;
+		__entry->completion_id = ctxt->sc_cid.ci_completion_id;
 		__entry->num_sge = wr->num_sge;
 		__entry->inv_rkey = (wr->opcode == IB_WR_SEND_WITH_INV) ?
 					wr->ex.invalidate_rkey : 0;
 	),
 
-	TP_printk("cqe=%p num_sge=%u inv_rkey=0x%08x",
-		__entry->cqe, __entry->num_sge,
-		__entry->inv_rkey
+	TP_printk("cq_id=%u cid=%d num_sge=%u inv_rkey=0x%08x",
+		__entry->cq_id, __entry->completion_id,
+		__entry->num_sge, __entry->inv_rkey
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 1ee73f7cf931..5e7c4ba9e147 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -87,7 +87,7 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 	 */
 	get_page(virt_to_page(rqst->rq_buffer));
 	ctxt->sc_send_wr.opcode = IB_WR_SEND;
-	return svc_rdma_send(rdma, &ctxt->sc_send_wr);
+	return svc_rdma_send(rdma, ctxt);
 }
 
 /* Server-side transport endpoint wants a whole page for its send
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index c720dcf56231..73d46e8cdc16 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -298,13 +298,14 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 /**
  * svc_rdma_send - Post a single Send WR
  * @rdma: transport on which to post the WR
- * @wr: prepared Send WR to post
+ * @ctxt: send ctxt with a Send WR ready to post
  *
  * Returns zero the Send WR was posted successfully. Otherwise, a
  * negative errno is returned.
  */
-int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr)
+int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 {
+	struct ib_send_wr *wr = &ctxt->sc_send_wr;
 	int ret;
 
 	might_sleep();
@@ -330,7 +331,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr)
 		}
 
 		svc_xprt_get(&rdma->sc_xprt);
-		trace_svcrdma_post_send(wr);
+		trace_svcrdma_post_send(ctxt);
 		ret = ib_post_send(rdma->sc_qp, wr, NULL);
 		if (ret)
 			break;
@@ -805,7 +806,7 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 	} else {
 		sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	}
-	return svc_rdma_send(rdma, &sctxt->sc_send_wr);
+	return svc_rdma_send(rdma, sctxt);
 }
 
 /**
@@ -869,7 +870,7 @@ void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
-	if (svc_rdma_send(rdma, &sctxt->sc_send_wr))
+	if (svc_rdma_send(rdma, sctxt))
 		goto put_ctxt;
 	return;
 

