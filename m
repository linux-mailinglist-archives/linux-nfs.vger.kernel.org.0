Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5AD1A15A0
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgDGTLK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 15:11:10 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38051 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGTLK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Apr 2020 15:11:10 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so2404435qva.5;
        Tue, 07 Apr 2020 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eTPMFzVxJLohyOWfFVldmZfg4Ttab96R40GG74GHol4=;
        b=eArYt/ozUL+hx6OuaPZ+4Qd6tytB5Mnz8FBqXO+4GzQOLr76Aou9kZKDit6NA71OGl
         ancF13+ad5B8pi6vdevk4fv3gPhB7+i+ZpKH39fuHuYWz+RNlCTkaCJcBBw0UdnFZjN1
         uKNHfbSHm61hyRY8XoHNjTEZDeo9ZD4WC2S7s0pwzu09FhY0p3rjNOoV2MCgpDdSFqDl
         yuvLen0tkITb3TpO9TMEavvpkw+368rcQYXu86RPxldJgnEK/dCMGd+JA4CZ2TWp5OMO
         Q2z+grAZ5XBorr9j1ojlV4Nf6WSMUO7Q3YD/WUCrhHCMYJ+E8Sq4dCW4iUQZ2MukI5FC
         E5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eTPMFzVxJLohyOWfFVldmZfg4Ttab96R40GG74GHol4=;
        b=fvzMuvmIdhZjN0WuV+4Foe6tcrB2wVnZ7mHINq4hEqb4FxhNYuATMi1F61ocMI0kcY
         FwI3ykYuccJJfysla5ePFaw/cJfaS85Zx9OqQsjRhe7wxPNH6/iBO/uFfDPnr1s596dk
         GLetvdgOVt8va6uH46zY1PH8iPnW+yjjQIvIJum7ayRUWlpTL/U1IrcqQEn8ovvzXnpu
         A5Y/9pA4K9Q5RLAVNhNm3kbgpuaAyAcEc8vVKPS0dh0XQ5VXVOZI14NJM6BKK/R0Dg61
         bi8ZhcDd/CUHZzCzF9qWIth+bu/A+RGl/Ijd1UkBEEpUcQbDtBaTCC8+aPf6CLgcv7bg
         bsHQ==
X-Gm-Message-State: AGi0Pua0JMjNg/svBq+8jxfYv3FWfoqy+LH0V8sUHRIeDefVmLv0vqc+
        Gtt2WxvoEX4nrPElPRu8DTMANyiH
X-Google-Smtp-Source: APiQypIBchLnCMf/uB0OQJOyiFr12mpac22FMgGyMVgtZxE8z9IfopAxWEwUw4N5prqacZPhVC6wag==
X-Received: by 2002:ad4:5642:: with SMTP id bl2mr3961355qvb.11.1586286668339;
        Tue, 07 Apr 2020 12:11:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o186sm17493673qke.39.2020.04.07.12.11.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 12:11:07 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 037JB6XR010264;
        Tue, 7 Apr 2020 19:11:06 GMT
Subject: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 07 Apr 2020 15:11:06 -0400
Message-ID: <20200407191106.24045.88035.stgit@klimt.1015granger.net>
In-Reply-To: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-8-g198f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Utilize the xpo_release_rqst transport method to ensure that each
rqstp's svc_rdma_recv_ctxt object is released even when the server
cannot return a Reply for that rqstp.

Without this fix, each RPC whose Reply cannot be sent leaks one
svc_rdma_recv_ctxt. This is a 2.5KB structure, a 4KB DMA-mapped
Receive buffer, and any pages that might be part of the Reply
message.

The leak is infrequent unless the network fabric is unreliable or
Kerberos is in use, as GSS sequence window overruns, which result
in connection loss, are more common on fast transports.

Fixes: 3a88092ee319 ("svcrdma: Preserve Receive buffer until ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   22 ++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |   13 +++----------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    5 -----
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 78fe2ac6dc6c..cbcfbd0521e3 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -170,6 +170,7 @@ extern bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma);
 extern void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_recv_ctxt *ctxt);
 extern void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma);
+extern void svc_rdma_release_rqst(struct svc_rqst *rqstp);
 extern int svc_rdma_recvfrom(struct svc_rqst *);
 
 /* svc_rdma_rw.c */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 54469b72b25f..efa5fcb5793f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -223,6 +223,26 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
 }
 
+/**
+ * svc_rdma_release_rqst - Release transport-specific per-rqst resources
+ * @rqstp: svc_rqst being released
+ *
+ * Ensure that the recv_ctxt is released whether or not a Reply
+ * was sent. For example, the client could close the connection,
+ * or svc_process could drop an RPC, before the Reply is sent.
+ */
+void svc_rdma_release_rqst(struct svc_rqst *rqstp)
+{
+	struct svc_rdma_recv_ctxt *ctxt = rqstp->rq_xprt_ctxt;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct svcxprt_rdma *rdma =
+		container_of(xprt, struct svcxprt_rdma, sc_xprt);
+
+	rqstp->rq_xprt_ctxt = NULL;
+	if (ctxt)
+		svc_rdma_recv_ctxt_put(rdma, ctxt);
+}
+
 static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
 				struct svc_rdma_recv_ctxt *ctxt)
 {
@@ -820,6 +840,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	__be32 *p;
 	int ret;
 
+	rqstp->rq_xprt_ctxt = NULL;
+
 	spin_lock(&rdma_xprt->sc_rq_dto_lock);
 	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
 	if (ctxt) {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 6a87a2379e91..b6c8643867f2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -926,12 +926,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto err1;
-	ret = 0;
-
-out:
-	rqstp->rq_xprt_ctxt = NULL;
-	svc_rdma_recv_ctxt_put(rdma, rctxt);
-	return ret;
+	return 0;
 
  err2:
 	if (ret != -E2BIG && ret != -EINVAL)
@@ -940,16 +935,14 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = svc_rdma_send_error_msg(rdma, sctxt, rqstp);
 	if (ret < 0)
 		goto err1;
-	ret = 0;
-	goto out;
+	return 0;
 
  err1:
 	svc_rdma_send_ctxt_put(rdma, sctxt);
  err0:
 	trace_svcrdma_send_failed(rqstp, ret);
 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
-	ret = -ENOTCONN;
-	goto out;
+	return -ENOTCONN;
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 8bb99980ae85..ea54785db4f8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -71,7 +71,6 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 					struct sockaddr *sa, int salen,
 					int flags);
 static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt);
-static void svc_rdma_release_rqst(struct svc_rqst *);
 static void svc_rdma_detach(struct svc_xprt *xprt);
 static void svc_rdma_free(struct svc_xprt *xprt);
 static int svc_rdma_has_wspace(struct svc_xprt *xprt);
@@ -552,10 +551,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	return NULL;
 }
 
-static void svc_rdma_release_rqst(struct svc_rqst *rqstp)
-{
-}
-
 /*
  * When connected, an svc_xprt has at least two references:
  *

