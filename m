Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3493E20D10D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgF2SiI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 14:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgF2SiC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 14:38:02 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6873C02F02B;
        Mon, 29 Jun 2020 07:58:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so13046493qtg.4;
        Mon, 29 Jun 2020 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=r3WysMiOk9tm1zhD3bXBjap8Kfx4OSNG7JhtoQEwsn8=;
        b=k5T1WVG3zwMsMotznAUvQtx/+sncqT3FYiDjQjWW4mY1aq4uMlT9C3Y+vOw00hrWuO
         0AufTq2GvkSR5BVjtXqER3vOGHjLkpIIP/6wYRoCFvgg18EHS9Rvtg7W8dI+JMaaP4cl
         WJlWVESi5YDol8Ur+1Pe6FlS2XPPrvykOxUjXe1IgSz8HbEbpTbLMVmdTfQ28wPEr+Ep
         bgwJzA9F3hkgeCPH2ovcyis5oPs0CIQVeQlUYl1Nt/FT3qLI2ZEp9IKDUWP7WsBp5Lzh
         aBku5zGxkavxhMu5ZA8m86K0zXHjAg/Z5e0JAdyyOWNWHo9AFxi5ppOs/5bvcxsh+0R0
         vz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=r3WysMiOk9tm1zhD3bXBjap8Kfx4OSNG7JhtoQEwsn8=;
        b=Stks1GbCHgSlh7l9DwclNLd+BMQAe38AX/CyYr7JEbakv5mAYUeZUCd+vDFadX6wLM
         m6vvXoWuJBt1tCY+BABrIRfR/lJJQ7UYHXfTWCW4jfDM4fVJS9x8QZh+Bt89r1RGJp2x
         XfJ0Ng4EJ069iET9ohxVFhGU1fbljESPPmgxA+P+Bn5q4xg8epCSQhS2DMWXyiB67Z3k
         xnuQDstS1JmH/OYeyIJdd//DQ0WMlTmM7cAT1fnag1RrCE2dhyd/dGcQ6Gkk/MgkYQ8h
         abWJAoeos//7eyl7GMFGyXaLVBnJhaynhBfeoCta0mZW/+fO5nCbOw58L4KrfDFIw5WJ
         R3HQ==
X-Gm-Message-State: AOAM531ZaDLl6XTpn1UqG+2V+XELvFVbdKkKou9fFnUXzf9NI8As8iPr
        gmMya1Wl0Te3b/0YupAdyIDeHDsT
X-Google-Smtp-Source: ABdhPJx8yru8QJXA6McQt1zSlPsS8osyZ1C/n6eZ3Bti+34Xbk9OKalTaprn13ycXRHoDlbm5yStAA==
X-Received: by 2002:ac8:45c1:: with SMTP id e1mr16479281qto.250.1593442725717;
        Mon, 29 Jun 2020 07:58:45 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x13sm17262132qts.57.2020.06.29.07.58.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:58:45 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEwiWM006245;
        Mon, 29 Jun 2020 14:58:44 GMT
Subject: [PATCH v1 2/6] svcrdma: Introduce Receive completion IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:58:44 -0400
Message-ID: <20200629145844.15100.33282.stgit@klimt.1015granger.net>
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

Set up a completion ID in each svc_rdma_recv_ctxt. The ID is used
to match an incoming Receive completion to a transport and to a
previous ib_post_recv().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    4 ++
 include/trace/events/rpcrdma.h          |   51 ++++++++++++-------------------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   15 +++++++--
 3 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index d28ca1b6f2eb..c3c1e46f510f 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -46,6 +46,7 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/rpc_rdma.h>
+#include <linux/sunrpc/rpc_rdma_cid.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
 
@@ -109,6 +110,8 @@ struct svcxprt_rdma {
 	struct work_struct   sc_work;
 
 	struct llist_head    sc_recv_ctxts;
+
+	atomic_t	     sc_completion_ids;
 };
 /* sc_flags */
 #define RDMAXPRT_CONN_PENDING	3
@@ -129,6 +132,7 @@ struct svc_rdma_recv_ctxt {
 	struct list_head	rc_list;
 	struct ib_recv_wr	rc_recv_wr;
 	struct ib_cqe		rc_cqe;
+	struct rpc_rdma_cid	rc_cid;
 	struct ib_sge		rc_recv_sge;
 	void			*rc_recv_buf;
 	struct xdr_buf		rc_arg;
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 70ab989aa3b7..a0330a557e34 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -59,8 +59,6 @@ DECLARE_EVENT_CLASS(rpcrdma_completion_class,
 				),					\
 				TP_ARGS(wc, cid))
 
-DEFINE_COMPLETION_EVENT(dummy);
-
 DECLARE_EVENT_CLASS(xprtrdma_reply_event,
 	TP_PROTO(
 		const struct rpcrdma_rep *rep
@@ -1849,57 +1847,48 @@ DEFINE_SENDCOMP_EVENT(send);
 
 TRACE_EVENT(svcrdma_post_recv,
 	TP_PROTO(
-		const struct ib_recv_wr *wr,
-		int status
+		const struct svc_rdma_recv_ctxt *ctxt
 	),
 
-	TP_ARGS(wr, status),
+	TP_ARGS(ctxt),
 
 	TP_STRUCT__entry(
-		__field(const void *, cqe)
-		__field(int, status)
+		__field(u32, cq_id)
+		__field(int, completion_id)
 	),
 
 	TP_fast_assign(
-		__entry->cqe = wr->wr_cqe;
-		__entry->status = status;
+		__entry->cq_id = ctxt->rc_cid.ci_queue_id;
+		__entry->completion_id = ctxt->rc_cid.ci_completion_id;
 	),
 
-	TP_printk("cqe=%p status=%d",
-		__entry->cqe, __entry->status
+	TP_printk("cq.id=%d cid=%d",
+		__entry->cq_id, __entry->completion_id
 	)
 );
 
-TRACE_EVENT(svcrdma_wc_receive,
+DEFINE_COMPLETION_EVENT(svcrdma_wc_receive);
+
+TRACE_EVENT(svcrdma_rq_post_err,
 	TP_PROTO(
-		const struct ib_wc *wc
+		const struct svcxprt_rdma *rdma,
+		int status
 	),
 
-	TP_ARGS(wc),
+	TP_ARGS(rdma, status),
 
 	TP_STRUCT__entry(
-		__field(const void *, cqe)
-		__field(u32, byte_len)
-		__field(unsigned int, status)
-		__field(u32, vendor_err)
+		__field(int, status)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->cqe = wc->wr_cqe;
-		__entry->status = wc->status;
-		if (wc->status) {
-			__entry->byte_len = 0;
-			__entry->vendor_err = wc->vendor_err;
-		} else {
-			__entry->byte_len = wc->byte_len;
-			__entry->vendor_err = 0;
-		}
+		__entry->status = status;
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
 	),
 
-	TP_printk("cqe=%p byte_len=%u status=%s (%u/0x%x)",
-		__entry->cqe, __entry->byte_len,
-		rdma_show_wc_status(__entry->status),
-		__entry->status, __entry->vendor_err
+	TP_printk("addr=%s status=%d",
+		__get_str(addr), __entry->status
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index c0587d3cd389..e6d7401232d2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -117,6 +117,13 @@ svc_rdma_next_recv_ctxt(struct list_head *list)
 					rc_list);
 }
 
+static void svc_rdma_recv_cid_init(struct svcxprt_rdma *rdma,
+				   struct rpc_rdma_cid *cid)
+{
+	cid->ci_queue_id = rdma->sc_rq_cq->res.id;
+	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
+}
+
 static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
@@ -135,6 +142,8 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
 		goto fail2;
 
+	svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
+
 	ctxt->rc_recv_wr.next = NULL;
 	ctxt->rc_recv_wr.wr_cqe = &ctxt->rc_cqe;
 	ctxt->rc_recv_wr.sg_list = &ctxt->rc_recv_sge;
@@ -249,13 +258,14 @@ static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
 	int ret;
 
 	svc_xprt_get(&rdma->sc_xprt);
+	trace_svcrdma_post_recv(ctxt);
 	ret = ib_post_recv(rdma->sc_qp, &ctxt->rc_recv_wr, NULL);
-	trace_svcrdma_post_recv(&ctxt->rc_recv_wr, ret);
 	if (ret)
 		goto err_post;
 	return 0;
 
 err_post:
+	trace_svcrdma_rq_post_err(rdma, ret);
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
 	svc_xprt_put(&rdma->sc_xprt);
 	return ret;
@@ -309,11 +319,10 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_recv_ctxt *ctxt;
 
-	trace_svcrdma_wc_receive(wc);
-
 	/* WARNING: Only wc->wr_cqe and wc->status are reliable */
 	ctxt = container_of(cqe, struct svc_rdma_recv_ctxt, rc_cqe);
 
+	trace_svcrdma_wc_receive(wc, &ctxt->rc_cid);
 	if (wc->status != IB_WC_SUCCESS)
 		goto flushed;
 

