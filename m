Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5182AC527
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgKITj4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbgKITjz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:55 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA558C0613CF;
        Mon,  9 Nov 2020 11:39:55 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 11so9104534qkd.5;
        Mon, 09 Nov 2020 11:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=taDnBlfi+Lo8dxGn8A9RZ4ZuDt+nEI+u+WgtqvzKTu8=;
        b=Lhjbj6kdeWt1Y5mZvfTzXPEU/4H5guwDm6ALZuh/Inl/1amwxNFMJwoYLwo5fy0Zl1
         QTTPLbGATMFub8Lof3LNLgBHMt9KuTyw9JYUg2vsHfMKdEOQBdfT6aAG9RMmpKgsJ0w1
         MIxTnJJqs+hMlzWnSuSLcc2twd2Ga8979Sz+O9Paz3xkxapCjbgM91BPVMrs0WWXRzo2
         dgi7tze7k9W/6WVbj4XfDCryZV9k2g2zaHRXfCH9LSYGAmvp3TLgZI8i7IGvxC71dHbV
         9yKuEUREaT3UxM/Crgk1QiP9uflCYM5FIu0GU5yyx3P18gwhrFJ66ES1n10wmWUkf9SZ
         xNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=taDnBlfi+Lo8dxGn8A9RZ4ZuDt+nEI+u+WgtqvzKTu8=;
        b=OqGJXT5K7rcopiy5x3Cwo97y16gYi0oXigQa8pFna8AExETDiQ7LrywEsmUE5Nm3mF
         RDyUs/6H2VGO8z7LnnsIKWyytJlGm2zToL6C4FM9UR3ba5/DcKJAQ1Q205dMxXtqSCLA
         Z4lCZwbK0TcV40Irti3KdElu2IczD1nDPhoKC1nlb/sqjpRW9O1SzoLLSWnSUnTnBo+g
         IbK6I+KWZdeFi/UmOQlQOp1WPSeJ4zUmBFzyJKfcEVTtdrrHttAE2NJIfdVQLNZ4Oper
         6DgNSeEowlSazo4Asn1qqPC36k+MX4I1tTfU5KJrq7+5fPvIC2OXST+r69xbvaKfktFU
         N36g==
X-Gm-Message-State: AOAM53076poht3QuTv1c558+YRoyw0eklHhe1CCkgk/BYl+EoG7qFsQZ
        aRgc7y9JS1p/y/dr54wvTlN9a+Vm/6g=
X-Google-Smtp-Source: ABdhPJycmFG3/10mSVZpUJdJZ7SSoOF7/4jdbs6YvscT98Glin5aMdw1/tmyBa2ujAqAovUH9Q1hCg==
X-Received: by 2002:a05:620a:10a3:: with SMTP id h3mr4411164qkk.459.1604950794615;
        Mon, 09 Nov 2020 11:39:54 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k15sm6641577qke.75.2020.11.09.11.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:54 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JdrF3021813;
        Mon, 9 Nov 2020 19:39:53 GMT
Subject: [PATCH v1 08/13] xprtrdma: Clean up xprtrdma callback tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:53 -0500
Message-ID: <160495079296.2072548.17967993282277745679.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

- Replace displayed kernel memory addresses
- Tie the XID and event with the peer's IP address

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   31 ++++++++++++++++---------------
 net/sunrpc/xprtrdma/backchannel.c |    6 +++---
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c28bf17e769b..6bdbe1165270 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -313,38 +313,39 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
 				), \
 				TP_ARGS(mr))
 
-DECLARE_EVENT_CLASS(xprtrdma_cb_event,
+DECLARE_EVENT_CLASS(xprtrdma_callback_class,
 	TP_PROTO(
+		const struct rpcrdma_xprt *r_xprt,
 		const struct rpc_rqst *rqst
 	),
 
-	TP_ARGS(rqst),
+	TP_ARGS(r_xprt, rqst),
 
 	TP_STRUCT__entry(
-		__field(const void *, rqst)
-		__field(const void *, rep)
-		__field(const void *, req)
 		__field(u32, xid)
+		__string(addr, rpcrdma_addrstr(r_xprt))
+		__string(port, rpcrdma_portstr(r_xprt))
 	),
 
 	TP_fast_assign(
-		__entry->rqst = rqst;
-		__entry->req = rpcr_to_rdmar(rqst);
-		__entry->rep = rpcr_to_rdmar(rqst)->rl_reply;
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__assign_str(addr, rpcrdma_addrstr(r_xprt));
+		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("xid=0x%08x, rqst=%p req=%p rep=%p",
-		__entry->xid, __entry->rqst, __entry->req, __entry->rep
+	TP_printk("peer=[%s]:%s xid=0x%08x",
+		__get_str(addr), __get_str(port), __entry->xid
 	)
 );
 
-#define DEFINE_CB_EVENT(name)						\
-		DEFINE_EVENT(xprtrdma_cb_event, name,			\
+#define DEFINE_CALLBACK_EVENT(name)					\
+		DEFINE_EVENT(xprtrdma_callback_class,			\
+				xprtrdma_cb_##name,			\
 				TP_PROTO(				\
+					const struct rpcrdma_xprt *r_xprt, \
 					const struct rpc_rqst *rqst	\
 				),					\
-				TP_ARGS(rqst))
+				TP_ARGS(r_xprt, rqst))
 
 /**
  ** Connection events
@@ -1177,8 +1178,8 @@ TRACE_EVENT(xprtrdma_cb_setup,
 	)
 );
 
-DEFINE_CB_EVENT(xprtrdma_cb_call);
-DEFINE_CB_EVENT(xprtrdma_cb_reply);
+DEFINE_CALLBACK_EVENT(call);
+DEFINE_CALLBACK_EVENT(reply);
 
 /**
  ** Server-side RPC/RDMA events
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index c92c1aac270a..946edf2db646 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2015 Oracle.  All rights reserved.
+ * Copyright (c) 2015-2020, Oracle and/or its affiliates.
  *
  * Support for backward direction RPCs on RPC/RDMA.
  */
@@ -82,7 +82,7 @@ static int rpcrdma_bc_marshal_reply(struct rpc_rqst *rqst)
 				      &rqst->rq_snd_buf, rpcrdma_noch_pullup))
 		return -EIO;
 
-	trace_xprtrdma_cb_reply(rqst);
+	trace_xprtrdma_cb_reply(r_xprt, rqst);
 	return 0;
 }
 
@@ -260,7 +260,7 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 	 */
 	req = rpcr_to_rdmar(rqst);
 	req->rl_reply = rep;
-	trace_xprtrdma_cb_call(rqst);
+	trace_xprtrdma_cb_call(r_xprt, rqst);
 
 	/* Queue rqst for ULP's callback service */
 	bc_serv = xprt->bc_serv;


