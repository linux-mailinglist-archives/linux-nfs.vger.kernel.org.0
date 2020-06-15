Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F224F1F983E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgFONUy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbgFONUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 09:20:53 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F09BC061A0E;
        Mon, 15 Jun 2020 06:20:53 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r2so17805923ioo.4;
        Mon, 15 Jun 2020 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZlaCqm28R2FksyPTvJwuLIvLy4AIg5LN7n2O1w/Bits=;
        b=QlnV63zeug6pQnYg6vnoJzPm0y8E//o6KVERapQG68Of08elRjV7wObp0IuV73bnVg
         jXRmV8O1g9SrvgF0lnQX0A/YA2qNGTD/DwmIYFQt3AUh01WjxKWzkRonUMQdOEQsiiY/
         PMmJzmA03iNO8265V2wsAEDWUfZbsWwHqwU6Qdh+F9by/dmI/b2HXxVvDchrDOh5PScR
         vvp2iQxOkAB7SZw3HQRjnNUFshGwA0ifi/b8DRaMJNARVOSFvGBkGe03uVZmH2kUp4id
         ClJpq4VfmUbGhIzgfpt2+d2F4VydF/6qc02R9v9S7HVeJsyrV67ik1EMpxz19gtNrasm
         9EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZlaCqm28R2FksyPTvJwuLIvLy4AIg5LN7n2O1w/Bits=;
        b=UTYWAhfOC1jufNRHpC3fusIP8ewlCO/Fpv2AyE0A9GjjGO8SIkQSklZhQ8suwKijvT
         UUu9ud/hhRy5yAidLvEgPw6a/wDdnhrK7fQ8LHocO7pWefdGnFl/xIVH0h3boGZhU9P5
         tQ7HJnzr052Pcn5Aypn0UkCuE/UsWIACC9w5/h+y3oiQfG3Dwou3WwRRhFw5l0ogSN5O
         jNaODu6ywaoOg0mewj//AADN96v2HVUK4rUOsCEwF7DLNI02jFtR5YruJB5tntJ83x7H
         M6LiLoHlFNVzjOd+wvTskiOSR0Q5+zoYxAy+E2Buz19b2+GseQxWqFLyf5XzMAYWHwIf
         GjkA==
X-Gm-Message-State: AOAM533t1ThWgqoO9X5abGZrAtVg3Urw5KJljHEBlPDGkbiAp0CxS73F
        gJ5PzE/RWFVncz7hyyMZcsM=
X-Google-Smtp-Source: ABdhPJxMolEMSQ+i7ojEJX7CQ587h0J4op1u5R/b8FTxtIP9Fz0svZnPVUwQ0XgfUkAxxsRYJ9HFRg==
X-Received: by 2002:a05:6602:140b:: with SMTP id t11mr27484929iov.198.1592227252968;
        Mon, 15 Jun 2020 06:20:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f22sm7967055iob.18.2020.06.15.06.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:20:52 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05FDKqaN018432;
        Mon, 15 Jun 2020 13:20:52 GMT
Subject: [PATCH v1 1/5] xprtrdma: Prevent dereferencing r_xprt->rx_ep after
 it is freed
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 15 Jun 2020 09:20:52 -0400
Message-ID: <20200615132052.11800.40928.stgit@manet.1015granger.net>
In-Reply-To: <20200615131642.11800.27486.stgit@manet.1015granger.net>
References: <20200615131642.11800.27486.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

r_xprt->rx_ep is known to be good while the transport's send lock is
held.  Otherwise additional references on rx_ep must be held when it
is used outside of that lock's critical sections.

For now, bump the rx_ep reference count once whenever there is at
least one outstanding Receive WR. This avoids the memory bandwidth
overhead of taking and releasing the reference count for every
ib_post_recv() and Receive completion.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2ae348377806..b021baa4b28d 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -84,7 +84,8 @@ static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep);
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
-static int rpcrdma_ep_destroy(struct rpcrdma_ep *ep);
+static void rpcrdma_ep_get(struct rpcrdma_ep *ep);
+static int rpcrdma_ep_put(struct rpcrdma_ep *ep);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -97,7 +98,8 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb);
  */
 static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 {
-	struct rdma_cm_id *id = r_xprt->rx_ep->re_id;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct rdma_cm_id *id = ep->re_id;
 
 	/* Flush Receives, then wait for deferred Reply work
 	 * to complete.
@@ -108,6 +110,8 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	 * local invalidations.
 	 */
 	ib_drain_sq(id->qp);
+
+	rpcrdma_ep_put(ep);
 }
 
 /**
@@ -266,7 +270,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		xprt_force_disconnect(xprt);
 		goto disconnected;
 	case RDMA_CM_EVENT_ESTABLISHED:
-		kref_get(&ep->re_kref);
+		rpcrdma_ep_get(ep);
 		ep->re_connect_status = 1;
 		rpcrdma_update_cm_private(ep, &event->param.conn);
 		trace_xprtrdma_inline_thresh(ep);
@@ -289,7 +293,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
 		xprt_force_disconnect(xprt);
-		return rpcrdma_ep_destroy(ep);
+		return rpcrdma_ep_put(ep);
 	default:
 		break;
 	}
@@ -345,7 +349,7 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 	return ERR_PTR(rc);
 }
 
-static void rpcrdma_ep_put(struct kref *kref)
+static void rpcrdma_ep_destroy(struct kref *kref)
 {
 	struct rpcrdma_ep *ep = container_of(kref, struct rpcrdma_ep, re_kref);
 
@@ -369,13 +373,18 @@ static void rpcrdma_ep_put(struct kref *kref)
 	module_put(THIS_MODULE);
 }
 
+static noinline void rpcrdma_ep_get(struct rpcrdma_ep *ep)
+{
+	kref_get(&ep->re_kref);
+}
+
 /* Returns:
  *     %0 if @ep still has a positive kref count, or
  *     %1 if @ep was destroyed successfully.
  */
-static int rpcrdma_ep_destroy(struct rpcrdma_ep *ep)
+static noinline int rpcrdma_ep_put(struct rpcrdma_ep *ep)
 {
-	return kref_put(&ep->re_kref, rpcrdma_ep_put);
+	return kref_put(&ep->re_kref, rpcrdma_ep_destroy);
 }
 
 static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
@@ -492,7 +501,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	return 0;
 
 out_destroy:
-	rpcrdma_ep_destroy(ep);
+	rpcrdma_ep_put(ep);
 	rdma_destroy_id(id);
 out_free:
 	kfree(ep);
@@ -521,8 +530,12 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 
 	ep->re_connect_status = 0;
 	xprt_clear_connected(xprt);
-
 	rpcrdma_reset_cwnd(r_xprt);
+
+	/* Bump the ep's reference count while there are
+	 * outstanding Receives.
+	 */
+	rpcrdma_ep_get(ep);
 	rpcrdma_post_recvs(r_xprt, true);
 
 	rc = rpcrdma_sendctxs_create(r_xprt);
@@ -587,7 +600,7 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
 
-	if (rpcrdma_ep_destroy(ep))
+	if (rpcrdma_ep_put(ep))
 		rdma_destroy_id(id);
 
 	r_xprt->rx_ep = NULL;

