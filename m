Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3D1DD00D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgEUOf6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgEUOf5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:57 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3CC061A0E;
        Thu, 21 May 2020 07:35:57 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j3so7237628ilk.11;
        Thu, 21 May 2020 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yNlCk1OMvKGd0jU8MTuLuvq/QP3Nc1spuetnuyqYxGQ=;
        b=t3AB47+BEZc+Rz2AneRDHDyzEQlTyR0llrs94FkCvP2qjZTHztBJmn5siT38YpgZ3j
         Sh0Bm/V77kwROGsosbQFA0VIebL5FNXRaNhNKI4DyBNumIYJBRkMxbqCLCgegrGlRomR
         f37Zw3b2HOoiXZ7VZB3jQVshpl85geFqLcBCtpDVI3wO0cAEraGQf49YH9kKQjnvb4r4
         4s8uTHZamfDsbz5Lwewl2UH09FS+WXFBkOjy3KKLDbT+xJVJqy4q1mlfs6yU8E8Bq7Xh
         hr6gBEW8qsuJudD9+Iz/DQ0FD1OkO0uslgPDPy7LgSutO2NhEAzd7Syk9Q/8w0MnvY61
         9NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yNlCk1OMvKGd0jU8MTuLuvq/QP3Nc1spuetnuyqYxGQ=;
        b=tT7fd8SbQRrsaxKUUYe/aJk7GRIRZ03ciioulJvBKTy5KtvCMybaUQ13b3vuijOCUy
         f+iEwyIRbTNpTMrDYSPTe0Y7vtkZ1gi8L45XtEeFjBnz9FfowNzNrRTf48VvftmBiwnb
         4iwTCExq2wa53jXnWgK58nvmKnMIalXBfiLZsGdYuzoppVbQBbhZk3sI8B+u61O9HIlA
         HQpC3taB9uXKNjhyG3gQqdoBIChJoLxUiMzZw/JUlmSx/y4YUOOT+1hDm77sMMBX9W2l
         nzh6H5JgCK1SPb2PsHBt+Wc3lFPRJWUrlQe+4upeWLnX8A2Etimm9Ap4egxp1apAA3s+
         Dd9w==
X-Gm-Message-State: AOAM5314kRBqz1VQJ4hMBCYqFHXuA+VAfdr3AXZmCtjTYK3JanzbYNcg
        LLoDz6YnveJC1a1iKL9211P+Tvmg
X-Google-Smtp-Source: ABdhPJyLGZJYbOqtsnLsbxTXxdYI6CzzxZ+1sO0ShkyY17M5cMyANrIY3J6m2mBcMZOzWHlmRcTTmg==
X-Received: by 2002:a92:ba14:: with SMTP id o20mr9012144ili.23.1590071756500;
        Thu, 21 May 2020 07:35:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c13sm3093347ilu.81.2020.05.21.07.35.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:55 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZtnq000913;
        Thu, 21 May 2020 14:35:55 GMT
Subject: [PATCH v3 25/32] SUNRPC: Restructure svc_udp_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:55 -0400
Message-ID: <20200521143555.3557.78504.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. At this point, we are not ready yet to support bio_vecs in
the UDP transport implementation. However, we can clean up
svc_udp_recvfrom() to match the tracing and straight-lining recently
changes made in svc_tcp_recvfrom().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    2 +
 net/sunrpc/svcsock.c          |   60 ++++++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 81659876b4af..08c7d618ceb4 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1501,6 +1501,8 @@ DECLARE_EVENT_CLASS(svcsock_class,
 			TP_ARGS(xprt, result))
 
 DEFINE_SVCSOCK_EVENT(udp_send);
+DEFINE_SVCSOCK_EVENT(udp_recv);
+DEFINE_SVCSOCK_EVENT(udp_recv_err);
 DEFINE_SVCSOCK_EVENT(tcp_send);
 DEFINE_SVCSOCK_EVENT(tcp_recv);
 DEFINE_SVCSOCK_EVENT(tcp_recv_eagain);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 3e25511b800e..97d2b6f8c791 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -425,8 +425,15 @@ static int svc_udp_get_dest_address(struct svc_rqst *rqstp,
 	return 0;
 }
 
-/*
- * Receive a datagram from a UDP socket.
+/**
+ * svc_udp_recvfrom - Receive a datagram from a UDP socket.
+ * @rqstp: request structure into which to receive an RPC Call
+ *
+ * Called in a loop when XPT_DATA has been set.
+ *
+ * Returns:
+ *   On success, the number of bytes in a received RPC Call, or
+ *   %0 if a complete RPC Call message was not ready to return
  */
 static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 {
@@ -460,20 +467,14 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	    svc_sock_setbufsize(svsk, serv->sv_nrthreads + 3);
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
-	skb = NULL;
 	err = kernel_recvmsg(svsk->sk_sock, &msg, NULL,
 			     0, 0, MSG_PEEK | MSG_DONTWAIT);
-	if (err >= 0)
-		skb = skb_recv_udp(svsk->sk_sk, 0, 1, &err);
-
-	if (skb == NULL) {
-		if (err != -EAGAIN) {
-			/* possibly an icmp error */
-			dprintk("svc: recvfrom returned error %d\n", -err);
-			set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
-		}
-		return 0;
-	}
+	if (err < 0)
+		goto out_recv_err;
+	skb = skb_recv_udp(svsk->sk_sk, 0, 1, &err);
+	if (!skb)
+		goto out_recv_err;
+
 	len = svc_addr_len(svc_addr(rqstp));
 	rqstp->rq_addrlen = len;
 	if (skb->tstamp == 0) {
@@ -484,26 +485,21 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	sock_write_timestamp(svsk->sk_sk, skb->tstamp);
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags); /* there may be more data... */
 
-	len  = skb->len;
+	len = skb->len;
 	rqstp->rq_arg.len = len;
+	trace_svcsock_udp_recv(&svsk->sk_xprt, len);
 
 	rqstp->rq_prot = IPPROTO_UDP;
 
-	if (!svc_udp_get_dest_address(rqstp, cmh)) {
-		net_warn_ratelimited("svc: received unknown control message %d/%d; dropping RPC reply datagram\n",
-				     cmh->cmsg_level, cmh->cmsg_type);
-		goto out_free;
-	}
+	if (!svc_udp_get_dest_address(rqstp, cmh))
+		goto out_cmsg_err;
 	rqstp->rq_daddrlen = svc_addr_len(svc_daddr(rqstp));
 
 	if (skb_is_nonlinear(skb)) {
 		/* we have to copy */
 		local_bh_disable();
-		if (csum_partial_copy_to_xdr(&rqstp->rq_arg, skb)) {
-			local_bh_enable();
-			/* checksum error */
-			goto out_free;
-		}
+		if (csum_partial_copy_to_xdr(&rqstp->rq_arg, skb))
+			goto out_bh_enable;
 		local_bh_enable();
 		consume_skb(skb);
 	} else {
@@ -531,6 +527,20 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 		serv->sv_stats->netudpcnt++;
 
 	return len;
+
+out_recv_err:
+	if (err != -EAGAIN) {
+		/* possibly an icmp error */
+		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+	}
+	trace_svcsock_udp_recv_err(&svsk->sk_xprt, err);
+	return 0;
+out_cmsg_err:
+	net_warn_ratelimited("svc: received unknown control message %d/%d; dropping RPC reply datagram\n",
+			     cmh->cmsg_level, cmh->cmsg_type);
+	goto out_free;
+out_bh_enable:
+	local_bh_enable();
 out_free:
 	kfree_skb(skb);
 	return 0;

