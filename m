Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF91C1BF9
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgEARia (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729040AbgEARia (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:38:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF23C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:38:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ck5so5046036qvb.11
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=r8RQUAU4uIGHsg9iyj0Y/YjWaq9ew2ES00P4l5K0nqQ=;
        b=XwT81lWdjMqxHPbG7gMTUGQNqjMG61uHlbz6asRwfVS0SrZ6msIY02GHy9VQlas8B4
         ZA4kVOLv9Y9kISM5wsupAFgj3dnbw19712c+qBstpKI0zcfegxEDJS+kB7V9GCyiP65o
         PoxIO1Xd7HQsAvi1pZD+Huv9J3rwOcZDdlAIUDZWkmaAiymfM6n5k3tyn0BGBn0zJjqx
         tHhusBEl8mNxqPrbVkOSwgXrJrKyXc4bgo20ok7GYBxUwAB9RDTl6kscQlPD8jVy5ev6
         4cmB8ucR3jP+LskXkM4gWOOuYUwIpnioKu8MGcJfawD6Dy96hlj22Dy8gE3dRiEHxcrK
         hMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=r8RQUAU4uIGHsg9iyj0Y/YjWaq9ew2ES00P4l5K0nqQ=;
        b=Jz+7nOqH4dwMIKZkBnmLf+0IxOiQXCAyOpLdrZX3fMe/8m+nyceqgbrceuqxcw5CzW
         Jay9shMwd2JtHcq3zm67nI3QBdeqQGNgWl4wCsnJBySWvaDQLM8lkEqvExZb084b9wEL
         TjmXNJBLxF9NGvn0cHhm38LmobY+dCTPhItELzz30DXWYCwZNTft13DxOirDO+y8zVks
         VDFyDq9LXggVkj+im6PLfg2XrDwCvshKDUSF6AKXexZo/9Ayio0FDTjwZe7ipE/Z/EZ1
         H8DF6Mk3o2fs4jio3pYD490NTn9QTBd9EWYQdjzTkCiyedIAX0opElTLTOwc9qpOYnwg
         Lsow==
X-Gm-Message-State: AGi0PuaJU5MSXnUfusuPcOS684aZlj+PLkLu5o/kYDVjnyTALBdPZrf+
        ZtCDJ95kkgg7949WafHGBcDkN71h
X-Google-Smtp-Source: APiQypI0LfjIRzYU35UZmg6A0CRScLqayulXaZAdI6yCYihxdX/qc9VPKr4HkVxhTBM3Cen8XuMH/w==
X-Received: by 2002:a0c:9e6d:: with SMTP id z45mr5114170qve.206.1588354709124;
        Fri, 01 May 2020 10:38:29 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 10sm3502489qtp.4.2020.05.01.10.38.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:38:28 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HcRri026749
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:38:27 GMT
Subject: [PATCH v1 8/8] SUNRPC: Restructure svc_udp_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:38:27 -0400
Message-ID: <20200501173827.3868.3139.stgit@klimt.1015granger.net>
In-Reply-To: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
References: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

At this point, we are not ready yet to support bio_vecs in the UDP
transport. However, we can clean up svc_udp_recvfrom to match the
tracing and straight-lining changes made in svc_tcp_recvfrom.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/svcsock.c          |   68 +++++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 844c0642fcbb..b15b5c5dad16 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1517,6 +1517,7 @@ DECLARE_EVENT_CLASS(svcsock_class,
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

