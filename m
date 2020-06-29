Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52620D10B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 20:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgF2SiC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgF2Sh6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 14:37:58 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE9C02F02D;
        Mon, 29 Jun 2020 07:58:57 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h18so7762254qvl.3;
        Mon, 29 Jun 2020 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/7ALjZmMhPiK2bUZpUhyi04sGW2Du1Oy+/g9ThZu2tA=;
        b=coD1YD9552dXMDfaNeV/cduKkpIQsFqmw5abIRPL4wuCL6pMv6dWwEYtrUVZpO3XCW
         OVp9OrZaz5S3LJQvn9EkOkmnMf6snGtnyh7gM4NAIuyfGXSliuamb0hRRVz4v1bnb9Yi
         9GpU+VVmG00EOycch7flF5rFeRt5sxCkK+dzA1YuUt6kU9zn8FX0LazeRqpf3G78wzQC
         HDYu7y41mo7ZkHdgenPNBomx5u6IUUY6BdMKE56OG+WnQYaYcvVdJ3mIK/9yOmq87I71
         FJvQkrag3CZ8mEItw87tqefFZmqp+RNrGSt5WDqTweJ51T2loPaw9Ba3bDuOeOdyd0fb
         sjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/7ALjZmMhPiK2bUZpUhyi04sGW2Du1Oy+/g9ThZu2tA=;
        b=c5DNv0iqNQQXk1ctW8XK8Y6S/b9HwHyS4I62kYpTeNZEuuFpa/6v2TDUOhOSY8BUDk
         mlaYGCUjVuQMzeq9F3ubhsorJvLbMHLBpkCyxUoXaCsXdBE4qTC0u6CkrOO5vmCKJvDO
         tE9Hqoez6AkDw06VwAevFDpmoAPPuWWuskoP5FMr/r4LfOtUjV0EBHBCYsaWi4oDYlz5
         ZJW3Xa7OfJtL9hgKFunoPfoajf+Lf9Pf0ek7m+LPhOI+2ngXNfTWOe39ldQIxFM7vGHd
         9rCl3okY8w9w7QHpqGQYHzwLouJ31ri/m6CypXDwKxJZOVNFywPMT0juoHTl3Mz+DWq8
         pvbA==
X-Gm-Message-State: AOAM531IiLBJEjlCFRPa4pLlO1O5UvZWLf+GBsbDE+76DOb0PM5nORE/
        DX/qa9ni4cpdbjHTesA4m2dIkNON
X-Google-Smtp-Source: ABdhPJxP6p1gONdceAjyIf5JgerLUqs7yVCkVfKV3N5uulh4nzHOX7lWMIBMssk8arrOXjNY87FaOQ==
X-Received: by 2002:a0c:fc02:: with SMTP id z2mr2102823qvo.1.1593442736422;
        Mon, 29 Jun 2020 07:58:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x19sm18960973qtc.36.2020.06.29.07.58.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:58:56 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEwtkG006251;
        Mon, 29 Jun 2020 14:58:55 GMT
Subject: [PATCH v1 4/6] svcrdma: Introduce Send completion IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:58:55 -0400
Message-ID: <20200629145855.15100.8619.stgit@klimt.1015granger.net>
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

Set up a completion ID in each svc_rdma_send_ctxt. The ID is used
to match an incoming Send completion to a transport and to a
previous ib_post_send().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    2 ++
 include/trace/events/rpcrdma.h        |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   15 ++++++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index c3c1e46f510f..c91e00bc937e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -151,6 +151,8 @@ struct svc_rdma_recv_ctxt {
 
 struct svc_rdma_send_ctxt {
 	struct list_head	sc_list;
+	struct rpc_rdma_cid	sc_cid;
+
 	struct ib_send_wr	sc_send_wr;
 	struct ib_cqe		sc_cqe;
 	struct xdr_buf		sc_hdrbuf;
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index df49ae5d447b..782a4d826a4b 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1863,7 +1863,7 @@ TRACE_EVENT(svcrdma_post_send,
 	)
 );
 
-DEFINE_SENDCOMP_EVENT(send);
+DEFINE_COMPLETION_EVENT(svcrdma_wc_send);
 
 TRACE_EVENT(svcrdma_post_recv,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 38d8f0ee35ec..c720dcf56231 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -122,6 +122,13 @@ svc_rdma_next_send_ctxt(struct list_head *list)
 					sc_list);
 }
 
+static void svc_rdma_send_cid_init(struct svcxprt_rdma *rdma,
+				   struct rpc_rdma_cid *cid)
+{
+	cid->ci_queue_id = rdma->sc_sq_cq->res.id;
+	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
+}
+
 static struct svc_rdma_send_ctxt *
 svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
@@ -144,6 +151,8 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
 		goto fail2;
 
+	svc_rdma_send_cid_init(rdma, &ctxt->sc_cid);
+
 	ctxt->sc_send_wr.next = NULL;
 	ctxt->sc_send_wr.wr_cqe = &ctxt->sc_cqe;
 	ctxt->sc_send_wr.sg_list = ctxt->sc_sges;
@@ -268,14 +277,14 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct svcxprt_rdma *rdma = cq->cq_context;
 	struct ib_cqe *cqe = wc->wr_cqe;
-	struct svc_rdma_send_ctxt *ctxt;
+	struct svc_rdma_send_ctxt *ctxt =
+		container_of(cqe, struct svc_rdma_send_ctxt, sc_cqe);
 
-	trace_svcrdma_wc_send(wc);
+	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
 
 	atomic_inc(&rdma->sc_sq_avail);
 	wake_up(&rdma->sc_send_wait);
 
-	ctxt = container_of(cqe, struct svc_rdma_send_ctxt, sc_cqe);
 	svc_rdma_send_ctxt_put(rdma, ctxt);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {

