Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD41D00B0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgELVXG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgELVXG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:06 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED78C061A0C;
        Tue, 12 May 2020 14:23:06 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di6so7113630qvb.10;
        Tue, 12 May 2020 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MV0EoO+8yVK6ghDt30lbfGE+CAEo1PY+DasnmJYde9U=;
        b=eK/5zme6rq0/ZJFMlWRfeEScDx6QmsTVBPpVpiEe/tF2gIUn4MzXAswpXGcXuxwdQJ
         FrrLdEPvRyENXJQbOJ44daT3XSg5jBqJB9jE7BR3RKQtF2k5gmDZEXl78+37v6lDyobL
         An8wKB9JnJkF9EsuaR+Ddl2hIFs6SY1op/nDSD6UwfjUl8vnPG/SQAv87Z3Prkt1QYg0
         bCnbHyY7Cm7+aT0l0NDqPPq/fq3PJA22QflSu+pewr2l5Rza8Zv6Oo8rOpZUF3OHSlKT
         OrWcTNdRzOH/3obmLjLYPucjnXzHXbE+/neiKY8jK3QtjPzJp9FHkxioyF5k0MYGfjKw
         CW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=MV0EoO+8yVK6ghDt30lbfGE+CAEo1PY+DasnmJYde9U=;
        b=uHqDwPgZGFYfBWOhD4HHsuCgj7CfHtB3uwLO1qBlaowS3xc71+Joc4TJNODNOXNjrC
         NkVWEiJ2UssBrW0CMHL9OmLdEEeDl86LJpYHy2zWcXhi8HrAeT0lXSewNVB6TCuHDLic
         SJearBGFFLHuvGU/PfH/ov54Qvu0X/MSdMB/eOiR+cHpG2DcV+r9RVfYlsPaFHIqHUSf
         uEw9c5hhSb9laMdyOwpoX8cyr9xggeH8qZWMez3nmbSsBY3MXHjf8cWdtJgI0/SlvIQ1
         bf0gg5v57ImfE7TBFDE9a+htpI2hkfzLTXx1KVdLso+kvJxm53CA9EoRMABzZouSQfkZ
         HY/A==
X-Gm-Message-State: AGi0PuYzLOp+SgnqYNwjpiskZxrJDeHsTiJkzavDSWoXusG8ufYntBLT
        uM4w7+lR8d5EKQiRDvcVh9+9dkci
X-Google-Smtp-Source: APiQypJMEmshn0/6wSYHgikdyxvUeRFyNabGRlq6SmtksGpaZdwOAbM6DniwjiWKoO7P76qmm1F6bg==
X-Received: by 2002:a0c:8324:: with SMTP id j33mr23313003qva.23.1589318584890;
        Tue, 12 May 2020 14:23:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e23sm11433766qkm.63.2020.05.12.14.23.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:23:04 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLN272009907;
        Tue, 12 May 2020 21:23:02 GMT
Subject: [PATCH v2 11/29] svcrdma: Add tracepoints to report ->xpo_accept
 failures
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:23:02 -0400
Message-ID: <20200512212302.5826.42765.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
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
 include/trace/events/rpcrdma.h           |   38 +++++++++++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   27 +++++++++------------
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 53b24c8c7860..79ef2ab7743c 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1309,9 +1309,45 @@ DECLARE_EVENT_CLASS(svcrdma_xprt_event,
 				TP_ARGS(xprt))
 
 DEFINE_XPRT_EVENT(accept);
-DEFINE_XPRT_EVENT(fail);
 DEFINE_XPRT_EVENT(free);
 
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
+#define DEFINE_ACCEPT_EVENT(name) \
+		DEFINE_EVENT(svcrdma_accept_class, svcrdma_##name##_err, \
+				TP_PROTO( \
+					const struct svcxprt_rdma *rdma, \
+					long status \
+				), \
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
index 0a1125277a48..f3b5ad2bec2f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -410,9 +410,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (!newxprt)
 		return NULL;
 
-	dprintk("svcrdma: newxprt from accept queue = %p, cm_id=%p\n",
-		newxprt, newxprt->sc_cm_id);
-
 	dev = newxprt->sc_cm_id->device;
 	newxprt->sc_port_num = newxprt->sc_cm_id->port_num;
 
@@ -448,21 +445,17 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 
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
@@ -486,7 +479,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 
 	ret = rdma_create_qp(newxprt->sc_cm_id, newxprt->sc_pd, &qp_attr);
 	if (ret) {
-		dprintk("svcrdma: failed to create QP, ret=%d\n", ret);
+		trace_svcrdma_qp_err(newxprt, ret);
 		goto errout;
 	}
 	newxprt->sc_qp = newxprt->sc_cm_id->qp;
@@ -494,8 +487,10 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
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
@@ -517,15 +512,17 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
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
@@ -544,8 +541,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	return &newxprt->sc_xprt;
 
  errout:
-	dprintk("svcrdma: failure accepting new connection rc=%d.\n", ret);
-	trace_svcrdma_xprt_fail(&newxprt->sc_xprt);
 	/* Take a reference in case the DTO handler runs */
 	svc_xprt_get(&newxprt->sc_xprt);
 	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))

