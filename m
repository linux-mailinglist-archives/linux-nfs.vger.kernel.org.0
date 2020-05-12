Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C281D00C6
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgELVYG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731308AbgELVYE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:24:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE60DC061A0C;
        Tue, 12 May 2020 14:24:02 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c24so6016437qtw.7;
        Tue, 12 May 2020 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=x/iQsa+RorRGYCjZvcK6WkMCCdDeHvIHsOUUPTkhWdM=;
        b=qGA/L72PrRXtFheXpDJ8jEdyV0AEJxZBhIiyn4DkzOrA2wytnQ3VjszODCgDzHGQIF
         F3ezBbpXp7C6LlesHC2ka6SgMtDkkSE85kJCoWh/hpe2wCGV0sM96qZ1HWWYTu8pnTDA
         kSi/aGsXYMcPLRY7rsi7dwQQCp+Lq6imdU72iyS5ZLuBcGw6YeOkSrVYvfex8R1gYiMW
         hf58BJdX6WW6SPK9B/uNqQetP7EYySktiofk+2Lobi6vUeYf1Mk5MD6Lzoj2EwdRThDg
         SqWhYxJ0KD/Lt2XUtu+lES3wmMUBJt0p/7WL1358JrLCIvTsZOkqqjkfA/7EEWx2phdD
         VwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=x/iQsa+RorRGYCjZvcK6WkMCCdDeHvIHsOUUPTkhWdM=;
        b=SoFqH7IqJ6keJrUMDWJ3Hp/GrH+/CUlx4ovBVnOlXAbIMmjMTL7NlwWikPE2JHvmGY
         DjUx3gPfRfN+5IBgNLmP4cEg79x7v+lgdX0WLV7tW4f+LvP5rDBv9acdzn88tAOmvDSe
         s+l8P2k2O2OkqpCtHL25P9jSJkU+EXqKyXZ9Alu08zsxPmVVUQsOm07/8njkRyr2nCoJ
         B+pSq9lbO3XyhvADQsGlMNB369ZwrFlRrSPI4ZAr7C/2fyNud1cGZ7mwWCXLd4EWVwio
         JyeZ4xIHg+jT5vZl2CjE2xmDcncy5DQd22ccvBbpFkAi3xYU4ZAI6pGBFE1J5xh+A6Hl
         8nkw==
X-Gm-Message-State: AGi0PuYxj6DDBeJSTour9MM3/AR9Ba8kpkXleFTSHbSXsErUASE9i/Fk
        scn8FFJrZaVAUl5p+cF8EHKs/x0y
X-Google-Smtp-Source: APiQypKk1McrchTakwlf0BIZlmyt1Xwa8htv5HZ1HmYTmIBr+ohNjG44rOynHs4zKET3Y/O9Z5FUeQ==
X-Received: by 2002:ac8:2db0:: with SMTP id p45mr21619605qta.354.1589318641756;
        Tue, 12 May 2020 14:24:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a1sm13317115qtj.65.2020.05.12.14.24.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:24:01 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLO0Oe009942;
        Tue, 12 May 2020 21:24:00 GMT
Subject: [PATCH v2 22/29] SUNRPC: Restructure svc_udp_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:24:00 -0400
Message-ID: <20200512212400.5826.94699.stgit@klimt.1015granger.net>
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

Clean up. At this point, we are not ready yet to support bio_vecs in
the UDP transport implementation. However, we can clean up
svc_udp_recvfrom() to match the tracing and straight-lining recently
changes made in svc_tcp_recvfrom().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/svcsock.c          |   68 +++++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index bfea554bd91f..6e32c4e16f7d 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1501,6 +1501,7 @@ DECLARE_EVENT_CLASS(svcsock_class,
 			TP_ARGS(xprt, result))
 
 DEFINE_SVCSOCK_EVENT(udp_send);
+DEFINE_SVCSOCK_EVENT(udp_recv);
 DEFINE_SVCSOCK_EVENT(tcp_send);
 DEFINE_SVCSOCK_EVENT(tcp_recv);
 DEFINE_SVCSOCK_EVENT(data_ready);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index f482cfd0d49d..d31a807c2c39 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -122,14 +122,12 @@ static void svc_tcp_release_rqst(struct svc_rqst *rqstp)
 	}
 }
 
-static void svc_release_udp_skb(struct svc_rqst *rqstp)
+static void svc_udp_release_rqst(struct svc_rqst *rqstp)
 {
 	struct sk_buff *skb = rqstp->rq_xprt_ctxt;
 
 	if (skb) {
 		rqstp->rq_xprt_ctxt = NULL;
-
-		dprintk("svc: service %p, releasing skb %p\n", rqstp, skb);
 		consume_skb(skb);
 	}
 }
@@ -409,8 +407,15 @@ static int svc_udp_get_dest_address(struct svc_rqst *rqstp,
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
@@ -444,20 +449,14 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
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
@@ -468,26 +467,21 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
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
@@ -515,6 +509,20 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 		serv->sv_stats->netudpcnt++;
 
 	return len;
+
+out_recv_err:
+	if (err != -EAGAIN) {
+		/* possibly an icmp error */
+		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+	}
+	trace_svcsock_udp_recv(&svsk->sk_xprt, err);
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
@@ -548,7 +556,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	unsigned int uninitialized_var(sent);
 	int err;
 
-	svc_release_udp_skb(rqstp);
+	svc_udp_release_rqst(rqstp);
 
 	svc_set_cmsg_data(rqstp, cmh);
 
@@ -617,7 +625,7 @@ static const struct svc_xprt_ops svc_udp_ops = {
 	.xpo_recvfrom = svc_udp_recvfrom,
 	.xpo_sendto = svc_udp_sendto,
 	.xpo_read_payload = svc_sock_read_payload,
-	.xpo_release_rqst = svc_release_udp_skb,
+	.xpo_release_rqst = svc_udp_release_rqst,
 	.xpo_detach = svc_sock_detach,
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_udp_has_wspace,

