Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5F2AC51D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgKITj3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITj3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:29 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C99C0613CF;
        Mon,  9 Nov 2020 11:39:29 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so6370971qkk.10;
        Mon, 09 Nov 2020 11:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W5nj+qdtjuQl8iY/Sq15Ie6k3wJ8XrsPFpmMXP2aUqQ=;
        b=nhLb1hSPeku7T6zxDVRz6i+JND1f7abw1dYmlDSAud5G11o0vyIxljoFKmtLMo5228
         mk1omBGbk3k6U2jxtOZWVkYnxUcQB20rilSspWnLE7Y2nuIZ+WBGz5x0LkIPTti2n/In
         q6WDxHZTNRsQAvHgXYDAhr9fPrGM1ktwpy+rEqIO7pyaMGWL9vCc26H5Xa4slvNPBgjg
         yvSuk7QFFfMtLkOQlssy/0pHzzviiRvlI+474DGTZvosjggGTsYIf0W2d6E1B83CnX+F
         x1UDfWmFWk9E9kZMifmmr8cBKV/gM2OnCsKi9v6kQp+d1hGUAozEqbCBhVwpVqzNGpe9
         ogWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=W5nj+qdtjuQl8iY/Sq15Ie6k3wJ8XrsPFpmMXP2aUqQ=;
        b=uLu5LVtyxKnOl9IDdtV57I4mCYvIDiBx/sZHoRczy+zr4c+X22zVO7VrNbO3IphpPH
         tbiioT9zHUOiphpc/OCSjzh492RTbXx/byUh55dGjIa+wnLIAWPK9KxYc7mEgAMLdnqD
         kogN2YWqx4khMKFlsGY6KvUMKutzKS/1l8UyZwXHNGkK5b48NkZ9WrVRBjt6rKfr+jXG
         LA2IXf45KuDvWviiTv2J9x5hedvXgVAFa3T0zhrT3IilQi0oxFUJlJVGj9KdZwGkUBFi
         TFiBRCOUfYUmE9qzGTfGD0jduDdaLsFwjOHJxQUM7QPW1kzgBdcmL6+crXf2TKJ4uX6e
         sDfQ==
X-Gm-Message-State: AOAM531uw2jxnq91+ocM5KbDlOTJORVgZTOXBPy4P5bAYI4V40gkJXhi
        NFs6J1wVaLB2Lt7D8gFI1aLkBkmX8Q8=
X-Google-Smtp-Source: ABdhPJw9APsu0F+/DkKVLl7sSvcLpeI1fMzyVWeAcBDJWsoU0ZuyAhiWcUd0ePOAQgBiiMiipoMmnQ==
X-Received: by 2002:a37:7b44:: with SMTP id w65mr15933036qkc.350.1604950768192;
        Mon, 09 Nov 2020 11:39:28 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i15sm2376491qke.16.2020.11.09.11.39.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:27 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JdQMY021797;
        Mon, 9 Nov 2020 19:39:26 GMT
Subject: [PATCH v1 03/13] xprtrdma: Introduce Send completion IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:26 -0500
Message-ID: <160495076648.2072548.12867018705746911489.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Set up a completion ID in each rpcrdma_req. The ID is used to match
an incoming Send completion to a transport and to a previous
ib_post_send().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   47 +++++++--------------------------------
 net/sunrpc/xprtrdma/verbs.c     |    5 +++-
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 14 insertions(+), 39 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 1c91c8e721e7..ab239f4f924e 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -735,8 +735,8 @@ TRACE_EVENT(xprtrdma_post_send,
 	TP_ARGS(req),
 
 	TP_STRUCT__entry(
-		__field(const void *, req)
-		__field(const void *, sc)
+		__field(u32, cq_id)
+		__field(int, completion_id)
 		__field(unsigned int, task_id)
 		__field(unsigned int, client_id)
 		__field(int, num_sge)
@@ -745,20 +745,21 @@ TRACE_EVENT(xprtrdma_post_send,
 
 	TP_fast_assign(
 		const struct rpc_rqst *rqst = &req->rl_slot;
+		const struct rpcrdma_sendctx *sc = req->rl_sendctx;
 
+		__entry->cq_id = sc->sc_cid.ci_queue_id;
+		__entry->completion_id = sc->sc_cid.ci_completion_id;
 		__entry->task_id = rqst->rq_task->tk_pid;
 		__entry->client_id = rqst->rq_task->tk_client ?
 				     rqst->rq_task->tk_client->cl_clid : -1;
-		__entry->req = req;
-		__entry->sc = req->rl_sendctx;
 		__entry->num_sge = req->rl_wr.num_sge;
 		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
 	),
 
-	TP_printk("task:%u@%u req=%p sc=%p (%d SGE%s) %s",
+	TP_printk("task:%u@%u cq.id=%u cid=%d (%d SGE%s) %s",
 		__entry->task_id, __entry->client_id,
-		__entry->req, __entry->sc, __entry->num_sge,
-		(__entry->num_sge == 1 ? "" : "s"),
+		__entry->cq_id, __entry->completion_id,
+		__entry->num_sge, (__entry->num_sge == 1 ? "" : "s"),
 		(__entry->signaled ? "signaled" : "")
 	)
 );
@@ -848,37 +849,7 @@ TRACE_EVENT(xprtrdma_post_linv,
  **/
 
 DEFINE_COMPLETION_EVENT(xprtrdma_wc_receive);
-
-TRACE_EVENT(xprtrdma_wc_send,
-	TP_PROTO(
-		const struct rpcrdma_sendctx *sc,
-		const struct ib_wc *wc
-	),
-
-	TP_ARGS(sc, wc),
-
-	TP_STRUCT__entry(
-		__field(const void *, req)
-		__field(const void *, sc)
-		__field(unsigned int, unmap_count)
-		__field(unsigned int, status)
-		__field(unsigned int, vendor_err)
-	),
-
-	TP_fast_assign(
-		__entry->req = sc->sc_req;
-		__entry->sc = sc;
-		__entry->unmap_count = sc->sc_unmap_count;
-		__entry->status = wc->status;
-		__entry->vendor_err = __entry->status ? wc->vendor_err : 0;
-	),
-
-	TP_printk("req=%p sc=%p unmapped=%u: %s (%u/0x%x)",
-		__entry->req, __entry->sc, __entry->unmap_count,
-		rdma_show_wc_status(__entry->status),
-		__entry->status, __entry->vendor_err
-	)
-);
+DEFINE_COMPLETION_EVENT(xprtrdma_wc_send);
 
 DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_fastreg);
 DEFINE_FRWR_DONE_EVENT(xprtrdma_wc_li);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2c8d2801ec4f..63837b5d14e5 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -167,7 +167,7 @@ static void rpcrdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_xprt *r_xprt = cq->cq_context;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_send(sc, wc);
+	trace_xprtrdma_wc_send(wc, &sc->sc_cid);
 	rpcrdma_sendctx_put_locked(r_xprt, sc);
 	rpcrdma_flush_disconnect(r_xprt, wc);
 }
@@ -643,6 +643,9 @@ static struct rpcrdma_sendctx *rpcrdma_sendctx_create(struct rpcrdma_ep *ep)
 		return NULL;
 
 	sc->sc_cqe.done = rpcrdma_wc_send;
+	sc->sc_cid.ci_queue_id = ep->re_attr.send_cq->res.id;
+	sc->sc_cid.ci_completion_id =
+		atomic_inc_return(&ep->re_completion_ids);
 	return sc;
 }
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index b94940bc67aa..4eb8e32b9f4a 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -216,6 +216,7 @@ enum {
 struct rpcrdma_req;
 struct rpcrdma_sendctx {
 	struct ib_cqe		sc_cqe;
+	struct rpc_rdma_cid	sc_cid;
 	struct rpcrdma_req	*sc_req;
 	unsigned int		sc_unmap_count;
 	struct ib_sge		sc_sges[];


