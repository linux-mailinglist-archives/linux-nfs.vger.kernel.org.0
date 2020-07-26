Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8EA22E2AA
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jul 2020 23:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGZU7y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jul 2020 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGZU7x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jul 2020 16:59:53 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6FC0619D2;
        Sun, 26 Jul 2020 13:59:53 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r12so11407822ilh.4;
        Sun, 26 Jul 2020 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OzYL794bdANxKqvBKFYfm3GV6VDCfi36xHGz4dBMwac=;
        b=FwaQ8KkB4g7gsy5Cr9ZSde8OJ3p1TPnSVFBI7q0cVM6rgSuqdxhsiEgE09nOttNV16
         D8onFx1Zv8aYo/umAWL9CC6KNcRev3uZ7fTl8ifuSkHJWskUTeT03CXKSRuHuWK1nTEV
         +chNxUxiR2lW2FssgXRB4scwQ5Mu3UceXlZmEbgoN7/ytTT1Rkl2LBGfJwZjdYZQ7gY5
         z0ebtLgIARLEMQ6UTPatciu56/YdEbbNgQDppUYuWufNIYqjEboWieiqzB576Vj9Jyk9
         auHx5NvL3PNlKxROqmtgwXko3CVKihzLT2zE65EiXYXXJYDisLwn7b4G1A5nmahiVNg6
         /8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OzYL794bdANxKqvBKFYfm3GV6VDCfi36xHGz4dBMwac=;
        b=sD393KIO9T8SjUv9jMBPDriRnzxz1EyFiJLPmUd0anA2tJAXueMbgAvXLDRpxK2fkO
         N9SNLDvKxP/CkNYgQuESDuaua/VM2WsFjLmv/9NKY62lYDJ22N9GvLGZl6cOxaVyLNuj
         j6HWVzklKIUUaQyzSIn7lz83/1yil4O+ubaUrQuXQW+lJuTCpxwoDgdkrSM0XkOm2nj2
         dLpi3bBUoebpCTxSC/y5FGelUtM0iszhV+2+TfFS7fWXvVrHsJxlA/1umTpFINrl4FFc
         sjchYEHaE8fmWynGU2elmJteHsD2bjQ51C+e7pKjPl52drzknNC50nazocHBCN8Iv+ip
         KpgA==
X-Gm-Message-State: AOAM532yYuV+Y0FuT01a0nDCxC/2IWPTK+3hPret/HBeUPpdeKYT9Tn0
        sEdrLIssrwhWZLLJfLXa3x9rx2vkQ4k=
X-Google-Smtp-Source: ABdhPJy0QJf6Qi8WhwUT+XsCRgnl0Rdl7i1wfzF4B0sKCwIizv2wOjJHWlyvzOhnsVdsxTP1DDVZCQ==
X-Received: by 2002:a92:cb06:: with SMTP id s6mr82716ilo.13.1595797192414;
        Sun, 26 Jul 2020 13:59:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v5sm7474029ios.54.2020.07.26.13.59.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2020 13:59:51 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06QKxo58013837;
        Sun, 26 Jul 2020 20:59:50 GMT
Subject: [PATCH v1 2/3] svcrdma: Remove transport reference counting
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sun, 26 Jul 2020 16:59:50 -0400
Message-ID: <159579719076.2004.14162309967032149756.stgit@klimt.1015granger.net>
In-Reply-To: <159579718507.2004.16208139278801479272.stgit@klimt.1015granger.net>
References: <159579718507.2004.16208139278801479272.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jason tells me that a ULP cannot rely on getting an ESTABLISHED
and DISCONNECTED event pair for each connection, so transport
reference counting in the CM event handler will never be reliable.

Now that we have ib_drain_qp(), svcrdma should no longer need to
hold transport references while Sends and Receives are posted. So
remove the get/put call sites in the CM event handlers.

This eliminates a significant source of locked memory bus traffic.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    6 +-----
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |    2 --
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |    4 ----
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   17 +----------------
 4 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 5bb97b5f4606..c6ea2903c21a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -257,7 +257,6 @@ static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
 {
 	int ret;
 
-	svc_xprt_get(&rdma->sc_xprt);
 	trace_svcrdma_post_recv(ctxt);
 	ret = ib_post_recv(rdma->sc_qp, &ctxt->rc_recv_wr, NULL);
 	if (ret)
@@ -267,7 +266,6 @@ static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
 err_post:
 	trace_svcrdma_rq_post_err(rdma, ret);
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
-	svc_xprt_put(&rdma->sc_xprt);
 	return ret;
 }
 
@@ -344,15 +342,13 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	spin_unlock(&rdma->sc_rq_dto_lock);
 	if (!test_bit(RDMAXPRT_CONN_PENDING, &rdma->sc_flags))
 		svc_xprt_enqueue(&rdma->sc_xprt);
-	goto out;
+	return;
 
 flushed:
 post_err:
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
 	set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&rdma->sc_xprt);
-out:
-	svc_xprt_put(&rdma->sc_xprt);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c16d10601d65..fe54cbe97a46 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -164,7 +164,6 @@ static void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 {
 	svc_rdma_cc_cid_init(rdma, &cc->cc_cid);
 	cc->cc_rdma = rdma;
-	svc_xprt_get(&rdma->sc_xprt);
 
 	INIT_LIST_HEAD(&cc->cc_rwctxts);
 	cc->cc_sqecount = 0;
@@ -184,7 +183,6 @@ static void svc_rdma_cc_release(struct svc_rdma_chunk_ctxt *cc,
 				    ctxt->rw_nents, dir);
 		svc_rdma_put_rw_ctxt(rdma, ctxt);
 	}
-	svc_xprt_put(&rdma->sc_xprt);
 }
 
 /* State for sending a Write or Reply chunk.
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 73d46e8cdc16..7b94d971feb3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -291,8 +291,6 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 		set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
 		svc_xprt_enqueue(&rdma->sc_xprt);
 	}
-
-	svc_xprt_put(&rdma->sc_xprt);
 }
 
 /**
@@ -330,7 +328,6 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 			continue;
 		}
 
-		svc_xprt_get(&rdma->sc_xprt);
 		trace_svcrdma_post_send(ctxt);
 		ret = ib_post_send(rdma->sc_qp, wr, NULL);
 		if (ret)
@@ -340,7 +337,6 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 
 	trace_svcrdma_sq_post_err(rdma, ret);
 	set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
-	svc_xprt_put(&rdma->sc_xprt);
 	wake_up(&rdma->sc_send_wait);
 	return ret;
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 3da7901a49e6..aa60f75c8c1d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -271,7 +271,6 @@ static int rdma_cma_handler(struct rdma_cm_id *cma_id,
 	switch (event->event) {
 	case RDMA_CM_EVENT_ESTABLISHED:
 		/* Accept complete */
-		svc_xprt_get(xprt);
 		dprintk("svcrdma: Connection completed on DTO xprt=%p, "
 			"cm_id=%p\n", xprt, cma_id);
 		clear_bit(RDMAXPRT_CONN_PENDING, &rdma->sc_flags);
@@ -282,7 +281,6 @@ static int rdma_cma_handler(struct rdma_cm_id *cma_id,
 			xprt, cma_id);
 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
 		svc_xprt_enqueue(xprt);
-		svc_xprt_put(xprt);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		dprintk("svcrdma: Device removal cma_id=%p, xprt = %p, "
@@ -290,7 +288,6 @@ static int rdma_cma_handler(struct rdma_cm_id *cma_id,
 			rdma_event_msg(event->event), event->event);
 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
 		svc_xprt_enqueue(xprt);
-		svc_xprt_put(xprt);
 		break;
 	default:
 		dprintk("svcrdma: Unexpected event on DTO endpoint %p, "
@@ -539,24 +536,11 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	return NULL;
 }
 
-/*
- * When connected, an svc_xprt has at least two references:
- *
- * - A reference held by the cm_id between the ESTABLISHED and
- *   DISCONNECTED events. If the remote peer disconnected first, this
- *   reference could be gone.
- *
- * - A reference held by the svc_recv code that called this function
- *   as part of close processing.
- *
- * At a minimum one references should still be held.
- */
 static void svc_rdma_detach(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
-	/* Disconnect and flush posted WQE */
 	rdma_disconnect(rdma->sc_cm_id);
 }
 
@@ -566,6 +550,7 @@ static void __svc_rdma_free(struct work_struct *work)
 		container_of(work, struct svcxprt_rdma, sc_work);
 	struct svc_xprt *xprt = &rdma->sc_xprt;
 
+	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
 


