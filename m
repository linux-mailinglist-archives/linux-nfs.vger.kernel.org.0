Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA522E1D9C
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 16:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406300AbfJWOCM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 10:02:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40897 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406291AbfJWOCM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 10:02:12 -0400
Received: by mail-il1-f193.google.com with SMTP id d83so10522845ilk.7;
        Wed, 23 Oct 2019 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JBd2YWeY6s1oHmSMhMxPAGz6fTYvXzn1oIhq6Chb6Ww=;
        b=Ip4wUs2y9KaKBi+Mx9CqvMoEOE2sOVwdjfPWLGVJF0EyLyT85tk8mqnCKD4kcWgaIP
         ppCgq/bSwDEM4MY0CtvHQAP6KDVUfGcIcPDvGh/hFOHFY5QDZATFo7XqLoH0FINTCT1D
         1ty0rur3b3/Du9jjSFm1GIoZy3xce/puqkOu3DBRDO6m4MCYhfVUePxYEfR/ZNzlXdZZ
         2jNcFEU192HuD6SKKLQiwVQpqq0o1foaL4LCffXtBgE4sWls2095nxPz1KEUrRCcHtvb
         x9p9ZwOBRIr1yyq/PyD7T8OLphRQR6Xu05R1Q2d2x/GD52VV3xG4JI7/W/LujavDQGpz
         Gzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JBd2YWeY6s1oHmSMhMxPAGz6fTYvXzn1oIhq6Chb6Ww=;
        b=fCufxOw8VGBWZW0qN/FBD6efEfsCB4dRU1deE1XI9VKg/tyc/qiWvMJB5VDHoBQ/On
         8hBNyXKtxjZaPe0psPwiQn7RTg9hcr8SUW7w3edeFGF9i/RVpYmV4ZK47fJVSRZ9u8PO
         P+QUIGRVPjK/Zm0ZmM8Fw10f7H6KVxNrlYtnn2qsMnoc/tFh/9NBqo/zuu2ODvEexgyR
         g9MBvy4ztGp0hrRqSwTwfK5megUIOwb5+IeJJwRQtJJPfAfZt1HaRqx0uz7cJR5byiGm
         g7f/7mKMBXTTWPk8LoHxHpPBWSJ2q6RLqcq6LjpVUIlL0zDQPD/J7l9+lgJwWoaMtiSe
         x0VA==
X-Gm-Message-State: APjAAAXjRLZj4rZ4evllGp2eYogEhSIxRMpv9FJ4YsQMQWj9vSl1H2f/
        ecm8suKCuq32EvmMrUrYDlxBp779
X-Google-Smtp-Source: APXvYqxk9Ca8c21AbLy9Gf0gdBYLzNIxu3BUw4DrekUJYZFuNJAzh1jIxQP8+BQtUO0Z2Kvbx1XjrA==
X-Received: by 2002:a92:831d:: with SMTP id f29mr17304876ild.263.1571839330435;
        Wed, 23 Oct 2019 07:02:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u124sm7159561ioe.63.2019.10.23.07.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:02:09 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NE29XO012551;
        Wed, 23 Oct 2019 14:02:09 GMT
Subject: [PATCH v1 4/5] xprtrdma: Replace dprintk() in
 rpcrdma_update_connect_private()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 10:02:09 -0400
Message-ID: <20191023140208.3992.79838.stgit@manet.1015granger.net>
In-Reply-To: <20191023135907.3992.69010.stgit@manet.1015granger.net>
References: <20191023135907.3992.69010.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Use a single trace point to record each connection's
negotiated inline thresholds and the computed maximum byte size
of transport headers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   36 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c |    4 ----
 net/sunrpc/xprtrdma/verbs.c    |   21 ++++++++++-----------
 3 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 465c1b0..081831d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -371,6 +371,42 @@
 	)
 );
 
+TRACE_EVENT(xprtrdma_inline_thresh,
+	TP_PROTO(
+		const struct rpcrdma_xprt *r_xprt
+	),
+
+	TP_ARGS(r_xprt),
+
+	TP_STRUCT__entry(
+		__field(const void *, r_xprt)
+		__field(unsigned int, inline_send)
+		__field(unsigned int, inline_recv)
+		__field(unsigned int, max_send)
+		__field(unsigned int, max_recv)
+		__string(addr, rpcrdma_addrstr(r_xprt))
+		__string(port, rpcrdma_portstr(r_xprt))
+	),
+
+	TP_fast_assign(
+		const struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+
+		__entry->r_xprt = r_xprt;
+		__entry->inline_send = ep->rep_inline_send;
+		__entry->inline_recv = ep->rep_inline_recv;
+		__entry->max_send = ep->rep_max_inline_send;
+		__entry->max_recv = ep->rep_max_inline_recv;
+		__assign_str(addr, rpcrdma_addrstr(r_xprt));
+		__assign_str(port, rpcrdma_portstr(r_xprt));
+	),
+
+	TP_printk("peer=[%s]:%s r_xprt=%p neg send/recv=%u/%u, calc send/recv=%u/%u",
+		__get_str(addr), __get_str(port), __entry->r_xprt,
+		__entry->inline_send, __entry->inline_recv,
+		__entry->max_send, __entry->max_recv
+	)
+);
+
 DEFINE_CONN_EVENT(connect);
 DEFINE_CONN_EVENT(disconnect);
 
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 26d334c..aec3beb 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -78,8 +78,6 @@ static unsigned int rpcrdma_max_call_header_size(unsigned int maxsegs)
 	size += rpcrdma_segment_maxsz * sizeof(__be32);
 	size += sizeof(__be32);	/* list discriminator */
 
-	dprintk("RPC:       %s: max call header size = %u\n",
-		__func__, size);
 	return size;
 }
 
@@ -100,8 +98,6 @@ static unsigned int rpcrdma_max_reply_header_size(unsigned int maxsegs)
 	size += maxsegs * rpcrdma_segment_maxsz * sizeof(__be32);
 	size += sizeof(__be32);	/* list discriminator */
 
-	dprintk("RPC:       %s: max reply header size = %u\n",
-		__func__, size);
 	return size;
 }
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 92bdf05..77c7dd7 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -177,11 +177,11 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_recv_buffer_put(rep);
 }
 
-static void
-rpcrdma_update_connect_private(struct rpcrdma_xprt *r_xprt,
-			       struct rdma_conn_param *param)
+static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
+				      struct rdma_conn_param *param)
 {
 	const struct rpcrdma_connect_private *pmsg = param->private_data;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	unsigned int rsize, wsize;
 
 	/* Default settings for RPC-over-RDMA Version One */
@@ -197,13 +197,11 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 		wsize = rpcrdma_decode_buffer_size(pmsg->cp_recv_size);
 	}
 
-	if (rsize < r_xprt->rx_ep.rep_inline_recv)
-		r_xprt->rx_ep.rep_inline_recv = rsize;
-	if (wsize < r_xprt->rx_ep.rep_inline_send)
-		r_xprt->rx_ep.rep_inline_send = wsize;
-	dprintk("RPC:       %s: max send %u, max recv %u\n", __func__,
-		r_xprt->rx_ep.rep_inline_send,
-		r_xprt->rx_ep.rep_inline_recv);
+	if (rsize < ep->rep_inline_recv)
+		ep->rep_inline_recv = rsize;
+	if (wsize < ep->rep_inline_send)
+		ep->rep_inline_send = wsize;
+
 	rpcrdma_set_max_header_sizes(r_xprt);
 }
 
@@ -257,7 +255,8 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	case RDMA_CM_EVENT_ESTABLISHED:
 		++xprt->connect_cookie;
 		ep->rep_connected = 1;
-		rpcrdma_update_connect_private(r_xprt, &event->param.conn);
+		rpcrdma_update_cm_private(r_xprt, &event->param.conn);
+		trace_xprtrdma_inline_thresh(r_xprt);
 		wake_up_all(&ep->rep_connect_wait);
 		break;
 	case RDMA_CM_EVENT_CONNECT_ERROR:

