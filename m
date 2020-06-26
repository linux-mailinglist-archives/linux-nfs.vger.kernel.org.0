Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB220ACD0
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 09:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgFZHKk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgFZHKj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 03:10:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52566C08C5DB
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 00:10:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so6138124edz.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHFyGd5nTmeBYXjuLspi5k8MHccPgDsPXN2ZV/Am+zE=;
        b=PSHxNS8zQ3kogNCkOQ1Wslep+JbMSMY0ozTx55RxG6vrsO+VJOg01kgwaq+B99OAr6
         MjYi6uFj/fvi7ybeGCVUstHbdmB4lau/xNoFcWvVMChYf5g+jQpiXyfEX4/SPdhAEltN
         j7wZI7LgrT1zRMiQ28uAa5aDIAoDnxNkFLeSdXzc1fB7/K6JkyGA/RSodSYMU8uFZS43
         j/ksTBrAERsYCtv2AlTL3/NIfdlQT8uODHT1Rvkd3YBR7FehSaJ8ws7TbynvvzX/gxQF
         Uy+nt38ycnGcGVyrgOYd061vbewNgkRhHGITA6fevCSF83QTBWQEqOaTOEUf0NgMoGH8
         n+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHFyGd5nTmeBYXjuLspi5k8MHccPgDsPXN2ZV/Am+zE=;
        b=I7J6C5/kWxdYafbAeInZ+NLkMvkcVoTVA7IgjjVJ0FzPuoxQHkgatiOiWaa9qEXhKQ
         N9DNe0A58y5QjY/4yjwDt6J79DzYRUlLvoCJIGrEakYAJPwMY7FLrhexeEpkwYAKfqZ6
         0ZuVQUqXgjQYWs/9ix0HhU/UAlrbXwQHXccOZKPlC+wCbMejAHE+kSRQ65Zut7pcpzS1
         zztAvz5a51NzxgmAtyLqFTK2vz0Ogch/umkBlnhCfVBn1TMHPh1pylLdzTTx02xiA/Oa
         gR54Vh6QTLY2tpnNMQ1BsIyTgUTuZ/Knmk7+6/uaWcIFddQ3fZf2tfjx2M0U5fiDpYMi
         5Nqw==
X-Gm-Message-State: AOAM532FX5B8EeEmYcvLYqLoJqBIxhmXsgoKiz9Z4gV+qtpQ2JoIXj72
        Dey2VWrymIwMNtIMCUdSdBMLcw==
X-Google-Smtp-Source: ABdhPJzYgxSEf4gng9WzIl6Eqji099NWBxc1s8+nkPzP2k5ZfNCF0vZAVCXx+DgxQOmuDqPb52kRxw==
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr1926147edb.296.1593155437974;
        Fri, 26 Jun 2020 00:10:37 -0700 (PDT)
Received: from jupiter.home.aloni.org ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id b11sm11710758edw.76.2020.06.26.00.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:10:37 -0700 (PDT)
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] xprtrdma: fix EP destruction logic
Date:   Fri, 26 Jun 2020 10:10:34 +0300
Message-Id: <20200626071034.34805-1-dan@kernelim.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <0E2AA9D9-2503-462C-952D-FC0DD5111BD1@oracle.com>
References: <0E2AA9D9-2503-462C-952D-FC0DD5111BD1@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This fixes various issues found when testing disconnections and other
various fault injections under a KASAN-enabled kernel.

- Swap the names of `rpcrdma_ep_destroy` and `rpcrdma_ep_put` to
  reflect what the functions are doing.
- In the cleanup of `rpcrdma_ep_create` do `kfree` on the EP only for
  the case where no one knows about it, and avoid a double free (what
  `rpcrdma_ep_destroy` did, followed by `kfree`). No need to set
  `r_xprt->rx_ep` to NULL because we are doing that only in the success
  path.
- Don't up the EP ref in `RDMA_CM_EVENT_ESTABLISHED` but do it sooner
  before `rdma_connect`. This is needed so that an early wake up of
  `wait_event_interruptible` in `rpcrdma_xprt_connect` in case of
  a failure does not see a freed EP.
- Still try to follow the rule that the last decref of EP performs
  `rdma_destroy_id(id)`.
- Only path to disengage an EP is `rpcrdma_xprt_disconnect`, whether it
  is actually connected or not. This makes the error paths of
  `rpcrdma_xprt_connect` clearer.
- Add a mutex in `rpcrdma_ep_destroy` to guard against concurrent calls
  to `rpcrdma_xprt_disconnect` coming from either `rpcrdma_xprt_connect`
  or `xprt_rdma_close`.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/xprtrdma/transport.c |  2 ++
 net/sunrpc/xprtrdma/verbs.c     | 50 ++++++++++++++++++++++-----------
 net/sunrpc/xprtrdma/xprt_rdma.h |  1 +
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 0c4af7f5e241..50c28be6b694 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -350,6 +350,8 @@ xprt_setup_rdma(struct xprt_create *args)
 	xprt_rdma_format_addresses(xprt, sap);
 
 	new_xprt = rpcx_to_rdmax(xprt);
+	mutex_init(&new_xprt->rx_flush);
+
 	rc = rpcrdma_buffer_create(new_xprt);
 	if (rc) {
 		xprt_rdma_free_addresses(xprt);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2ae348377806..c66871bbb894 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -84,7 +84,7 @@ static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep);
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
-static int rpcrdma_ep_destroy(struct rpcrdma_ep *ep);
+static int rpcrdma_ep_put(struct rpcrdma_ep *ep);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -99,6 +99,9 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 {
 	struct rdma_cm_id *id = r_xprt->rx_ep->re_id;
 
+	if (!id->qp)
+		return;
+
 	/* Flush Receives, then wait for deferred Reply work
 	 * to complete.
 	 */
@@ -266,7 +269,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		xprt_force_disconnect(xprt);
 		goto disconnected;
 	case RDMA_CM_EVENT_ESTABLISHED:
-		kref_get(&ep->re_kref);
 		ep->re_connect_status = 1;
 		rpcrdma_update_cm_private(ep, &event->param.conn);
 		trace_xprtrdma_inline_thresh(ep);
@@ -289,7 +291,8 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
 		xprt_force_disconnect(xprt);
-		return rpcrdma_ep_destroy(ep);
+		wake_up_all(&ep->re_connect_wait);
+		return rpcrdma_ep_put(ep);
 	default:
 		break;
 	}
@@ -345,11 +348,11 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 	return ERR_PTR(rc);
 }
 
-static void rpcrdma_ep_put(struct kref *kref)
+static void rpcrdma_ep_destroy(struct kref *kref)
 {
 	struct rpcrdma_ep *ep = container_of(kref, struct rpcrdma_ep, re_kref);
 
-	if (ep->re_id->qp) {
+	if (ep->re_id && ep->re_id->qp) {
 		rdma_destroy_qp(ep->re_id);
 		ep->re_id->qp = NULL;
 	}
@@ -373,9 +376,9 @@ static void rpcrdma_ep_put(struct kref *kref)
  *     %0 if @ep still has a positive kref count, or
  *     %1 if @ep was destroyed successfully.
  */
-static int rpcrdma_ep_destroy(struct rpcrdma_ep *ep)
+static int rpcrdma_ep_put(struct rpcrdma_ep *ep)
 {
-	return kref_put(&ep->re_kref, rpcrdma_ep_put);
+	return kref_put(&ep->re_kref, rpcrdma_ep_destroy);
 }
 
 static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
@@ -492,11 +495,12 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	return 0;
 
 out_destroy:
-	rpcrdma_ep_destroy(ep);
+	rpcrdma_ep_put(ep);
 	rdma_destroy_id(id);
+	return rc;
+
 out_free:
 	kfree(ep);
-	r_xprt->rx_ep = NULL;
 	return rc;
 }
 
@@ -510,6 +514,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 	struct rpcrdma_ep *ep;
+	struct rdma_cm_id *id;
 	int rc;
 
 retry:
@@ -518,6 +523,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		return rc;
 	ep = r_xprt->rx_ep;
+	id = ep->re_id;
 
 	ep->re_connect_status = 0;
 	xprt_clear_connected(xprt);
@@ -529,7 +535,10 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		goto out;
 
-	rc = rdma_connect(ep->re_id, &ep->re_remote_cma);
+	/* From this point on, CM events can discard our EP */
+	kref_get(&ep->re_kref);
+
+	rc = rdma_connect(id, &ep->re_remote_cma);
 	if (rc)
 		goto out;
 
@@ -546,14 +555,17 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 
 	rc = rpcrdma_reqs_setup(r_xprt);
 	if (rc) {
-		rpcrdma_xprt_disconnect(r_xprt);
+		ep->re_connect_status = rc;
 		goto out;
 	}
+
 	rpcrdma_mrs_create(r_xprt);
+	trace_xprtrdma_connect(r_xprt, 0);
+	return rc;
 
 out:
-	if (rc)
-		ep->re_connect_status = rc;
+	ep->re_connect_status = rc;
+	rpcrdma_xprt_disconnect(r_xprt);
 	trace_xprtrdma_connect(r_xprt, rc);
 	return rc;
 }
@@ -570,12 +582,15 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
  */
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct rpcrdma_ep *ep;
 	struct rdma_cm_id *id;
 	int rc;
 
+	mutex_lock(&r_xprt->rx_flush);
+
+	ep = r_xprt->rx_ep;
 	if (!ep)
-		return;
+		goto out;
 
 	id = ep->re_id;
 	rc = rdma_disconnect(id);
@@ -587,10 +602,13 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
 
-	if (rpcrdma_ep_destroy(ep))
+	if (rpcrdma_ep_put(ep))
 		rdma_destroy_id(id);
 
 	r_xprt->rx_ep = NULL;
+
+out:
+	mutex_unlock(&r_xprt->rx_flush);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 0a16fdb09b2c..288645a9437f 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -417,6 +417,7 @@ struct rpcrdma_xprt {
 	struct delayed_work	rx_connect_worker;
 	struct rpc_timeout	rx_timeout;
 	struct rpcrdma_stats	rx_stats;
+	struct mutex            rx_flush;
 };
 
 #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
-- 
2.25.4

