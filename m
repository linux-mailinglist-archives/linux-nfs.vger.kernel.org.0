Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472A41E91AB
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgE3NaY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3NaX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:23 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF79C03E969;
        Sat, 30 May 2020 06:30:23 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r2so5208716ila.4;
        Sat, 30 May 2020 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7syV9Wo5Ncp1HB9ERqIkSCog5Z5aZtrikvAa3nX4tvQ=;
        b=DuLmM6hFzv+Y5OhPEkTvqa+NgbIBw8+HgwFrg3pEHHkMYx6SurpBFT+EP0qfknVa8v
         VVG4kma5gFPh3KFuIzSC4/K/PZDK5JJqfch8HSZAdze0uM5TkzZY63NcMflrWudkr12F
         4+NkA3RaeDQR8rkWEwtfMTfqhRggR29J0+C13ymgIEbNTu6n8pBruXYzr25poaZxxq3i
         dZO5jzi9jc0dFvjBqN2HSXIScXjX9Gt0jq+y9RrQIDRuDFCCIq7erS4XtKjKdhMiF/FT
         sDhkkNyRcWcuouB3z8Ck34jz/12vMKfoaoS0Y+/bZ/RpwvdWFcl3xhxO0F3Jkwvhaikl
         9awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7syV9Wo5Ncp1HB9ERqIkSCog5Z5aZtrikvAa3nX4tvQ=;
        b=TM6rih6XsMGYF6qCbyBnwRIZD+ANPEyTSDvn5Oa5N5ItUu/tJ1BpG0SCq3bkbs7xUv
         sWf7dZnmIEDxf5lZNeS2s0DzuMDnImUVKqE8l69XDjFcphv4w/EvufOlrg6q0v7+AJCn
         0XpQril95yMraVuldnkUJsNZCgFrxc+x5D7mIHWO0WVaKcRMhGuiIvPpVG+Kk1ymYTgH
         d0+FifanOBuYPrKiHCxQZmbh38mZHbSIm0PTLb9Mj8VsCsjUb5J/RKIUMYV3MIp+ABJ4
         2TePWELqZpN+lDtZVmX83zkaIiR9XXm/UzNPHKhg/niC3bb6m6HghzDWfZr60hVG8wG7
         eltA==
X-Gm-Message-State: AOAM532uicCYuHAdSGNThO1QYOty0n3ocyWPChjerOGFzgM+47OXPrwe
        U7nLHuQZIQwmjHOYGRnZtY3urZw7
X-Google-Smtp-Source: ABdhPJySlX9HKrymca22xDvd6ZQ0oj5O+fPyZ4gPgwaFsEs8kvnta+0Qakk4MiPFg28LHFISO+5LyA==
X-Received: by 2002:a92:d112:: with SMTP id a18mr4775816ilb.3.1590845422314;
        Sat, 30 May 2020 06:30:22 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e13sm6292281ils.27.2020.05.30.06.30.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:21 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDULRr001471;
        Sat, 30 May 2020 13:30:21 GMT
Subject: [PATCH v4 26/33] SUNRPC: Restructure svc_udp_recvfrom()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:21 -0400
Message-ID: <20200530133021.10117.32280.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
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
index 22e67fbf79b0..91c668bd4e4c 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1520,6 +1520,8 @@ DECLARE_EVENT_CLASS(svcsock_class,
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

