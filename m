Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981DD1C1BCE
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgEAReH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730341AbgEAReC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:34:02 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784D1C061A0C;
        Fri,  1 May 2020 10:34:01 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so5065603qvz.8;
        Fri, 01 May 2020 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=93ayo/94AvL0bcM6DZvZdFqTzlt58jM0zJHfBTCx9/c=;
        b=sFxoynyDgqZiuXieYju7OuDXSouWl8WGb5L2zgCwOh7hdBiCNlM8XyUVn7qV0yMQyY
         dd1MAyXlDcXtzu6z/+9InpArek0ZBxOAT3XbvrIIDm5rjbCjn1aPfdMJL7c2fLLglaXV
         uZowzqS2VAjeuqPJGbpl81VrnMarSXKCwvVQVAW5Su+/yNx044fKslyAcEWbBWWTO54Q
         GSLE58XApHOK2JcHZ7QKi9IdFC4WzvJRIfT53fjjAJS9WfW7w6geLwjjc6v2cNGB1Emc
         9HkeyVK7ix9OVeA+XXgAcQtHUkMUK698ktvawGbBhAGcjJ6Xi3kpOhy5e8/z34CfOT4X
         NBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=93ayo/94AvL0bcM6DZvZdFqTzlt58jM0zJHfBTCx9/c=;
        b=gy+wwx3OsKLfAF9gagImAB0cDkI7mrhzfH9U8zgxv3EgbpZ+vHQiFCRXkrlCCE/gJr
         FjKlqiSeWPSEb68SiUBrzF2i2nJSU2rsNkMNvLnNnSNzkaYeaHeOs5dtv5WJdx50suca
         ZWVDCTwcXYbUAUd8u4fPfpvd7LlzsgDxM5JcH9wFfkHGYTpI1wdymIr7PKNxVW2m+1gJ
         MUgrgsTZTfq/TCKbN8pNNYUmIK9l0H9j6Kv/36ZvJmx6p+WSGQesWrjXOVYcq4gfV2Gk
         3uzDYlN3V4jXq8F1mgCbKC0EYHGX8trTxiqRNOoGu1cIKE7dRLwNLZv5wR/D6klFugum
         Wb+w==
X-Gm-Message-State: AGi0Pua3SPBmXCWQ9C0cGl78N+Pu7HL1CPpzjVnTuGTokJPZWGWRpv06
        jtcY+6Z0EMm8oOwfD5sEG+yw4i97
X-Google-Smtp-Source: APiQypKaNqUY5uWRvUL7ZENxWB17e8yl44eoOS4CIwldjJQBjKJoYIYa1earOez6A8RuW845BKPs3A==
X-Received: by 2002:ad4:562e:: with SMTP id cb14mr4876712qvb.249.1588354440446;
        Fri, 01 May 2020 10:34:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q62sm2024519qke.22.2020.05.01.10.33.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:33:59 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HXwlo026721;
        Fri, 1 May 2020 17:33:58 GMT
Subject: [PATCH v1 7/7] svcrdma: Add tracepoints to report ->xpo_accept
 failures
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 01 May 2020 13:33:58 -0400
Message-ID: <20200501173358.3798.73582.stgit@klimt.1015granger.net>
In-Reply-To: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
References: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Failure to accept a connection is typically due to a problem
specific to a transport type. Also, ->xpo_accept returns NULL
on error rather than reporting a specific problem.

So, add failure-specific tracepoints in svc_rdma_accept().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h           |   37 ++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   25 +++++++++-----------
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 6de7a9202a68..c25e11564598 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1283,6 +1283,43 @@ TRACE_EVENT(xprtrdma_leaked_rep,
  ** Server-side RPC/RDMA events
  **/
 
+DECLARE_EVENT_CLASS(svcrdma_accept_class,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		long status
+	),
+
+	TP_ARGS(rdma, status),
+
+	TP_STRUCT__entry(
+		__field(long, status)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->status = status;
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s status=%ld",
+		__get_str(addr), __entry->status
+	)
+);
+
+#define DEFINE_ACCEPT_EVENT(name)					\
+		DEFINE_EVENT(svcrdma_accept_class, svcrdma_##name##_err,	\
+				TP_PROTO(				\
+					const struct svcxprt_rdma *rdma,	\
+					long status			\
+				),					\
+				TP_ARGS(rdma, status))
+
+DEFINE_ACCEPT_EVENT(pd);
+DEFINE_ACCEPT_EVENT(qp);
+DEFINE_ACCEPT_EVENT(fabric);
+DEFINE_ACCEPT_EVENT(initdepth);
+DEFINE_ACCEPT_EVENT(accept);
+
 TRACE_DEFINE_ENUM(RDMA_MSG);
 TRACE_DEFINE_ENUM(RDMA_NOMSG);
 TRACE_DEFINE_ENUM(RDMA_MSGP);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index aa68dc706006..d38be57b00ed 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -400,9 +400,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (!newxprt)
 		return NULL;
 
-	dprintk("svcrdma: newxprt from accept queue = %p, cm_id=%p\n",
-		newxprt, newxprt->sc_cm_id);
-
 	dev = newxprt->sc_cm_id->device;
 	newxprt->sc_port_num = newxprt->sc_cm_id->port_num;
 
@@ -438,21 +435,17 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 
 	newxprt->sc_pd = ib_alloc_pd(dev, 0);
 	if (IS_ERR(newxprt->sc_pd)) {
-		dprintk("svcrdma: error creating PD for connect request\n");
+		trace_svcrdma_pd_err(newxprt, PTR_ERR(newxprt->sc_pd));
 		goto errout;
 	}
 	newxprt->sc_sq_cq = ib_alloc_cq_any(dev, newxprt, newxprt->sc_sq_depth,
 					    IB_POLL_WORKQUEUE);
-	if (IS_ERR(newxprt->sc_sq_cq)) {
-		dprintk("svcrdma: error creating SQ CQ for connect request\n");
+	if (IS_ERR(newxprt->sc_sq_cq))
 		goto errout;
-	}
 	newxprt->sc_rq_cq =
 		ib_alloc_cq_any(dev, newxprt, rq_depth, IB_POLL_WORKQUEUE);
-	if (IS_ERR(newxprt->sc_rq_cq)) {
-		dprintk("svcrdma: error creating RQ CQ for connect request\n");
+	if (IS_ERR(newxprt->sc_rq_cq))
 		goto errout;
-	}
 
 	memset(&qp_attr, 0, sizeof qp_attr);
 	qp_attr.event_handler = qp_event_handler;
@@ -476,7 +469,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 
 	ret = rdma_create_qp(newxprt->sc_cm_id, newxprt->sc_pd, &qp_attr);
 	if (ret) {
-		dprintk("svcrdma: failed to create QP, ret=%d\n", ret);
+		trace_svcrdma_qp_err(newxprt, ret);
 		goto errout;
 	}
 	newxprt->sc_qp = newxprt->sc_cm_id->qp;
@@ -484,8 +477,10 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (!(dev->attrs.device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS))
 		newxprt->sc_snd_w_inv = false;
 	if (!rdma_protocol_iwarp(dev, newxprt->sc_port_num) &&
-	    !rdma_ib_or_roce(dev, newxprt->sc_port_num))
+	    !rdma_ib_or_roce(dev, newxprt->sc_port_num)) {
+		trace_svcrdma_fabric_err(newxprt, -EINVAL);
 		goto errout;
+	}
 
 	if (!svc_rdma_post_recvs(newxprt))
 		goto errout;
@@ -507,15 +502,17 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	conn_param.initiator_depth = min_t(int, newxprt->sc_ord,
 					   dev->attrs.max_qp_init_rd_atom);
 	if (!conn_param.initiator_depth) {
-		dprintk("svcrdma: invalid ORD setting\n");
 		ret = -EINVAL;
+		trace_svcrdma_initdepth_err(newxprt, ret);
 		goto errout;
 	}
 	conn_param.private_data = &pmsg;
 	conn_param.private_data_len = sizeof(pmsg);
 	ret = rdma_accept(newxprt->sc_cm_id, &conn_param);
-	if (ret)
+	if (ret) {
+		trace_svcrdma_accept_err(newxprt, ret);
 		goto errout;
+	}
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	dprintk("svcrdma: new connection %p accepted:\n", newxprt);

