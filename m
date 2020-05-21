Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B244B1DD003
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgEUOfh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgEUOfg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285FEC061A0E;
        Thu, 21 May 2020 07:35:36 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so6279404iow.7;
        Thu, 21 May 2020 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dHMnMIZmn6lK7k/ecSOkgzRz2f7b82ES9DZUEm9ZgP8=;
        b=ufEygol0Zom3frNrMQKDZCyOqnb5xbJwbOUUFjpFRVQcIZbXSCV/wXfCLO02PYNcS9
         g3mhS+LAbeO6M7346/ObjD11xSkU3M1hmmVPShiok/VrpfKSvpM7eku3bhxOR0zDokYs
         EVHDF5h30DhobbmCaihF8iCSaht6kVwHo86un3zbAfYML+dIAx/gRZAqWGyQ1nhxU+44
         m581m8gEjzDF0tGx6QVdO6rSCO4wHmdk+bD96pB1UTU0GT5yz2F1bWM2y7HTlJZr/3Ja
         vRTG+pL6UW4hODVZ++iTaFEA7TeY0GPJU15SCd/eM1h/irt0FfDHiQqPP5sfC1OFQPrj
         ivMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dHMnMIZmn6lK7k/ecSOkgzRz2f7b82ES9DZUEm9ZgP8=;
        b=qje9ExPjIlTRIzwHOpOzG9iLxl5L5JwymedtZwcKsYOhB1n64U81tA4YtBhGL5GxU+
         Nn46VxoXX9zRUX6xzgGM8p426zqux7brOkpxmOlXndL6vSgg0p7i1PwB71N95aIphXwh
         nugsPYhMPu0sm3IeevYQLKQV+C1k97jpKrN7if7YsmcyHhpFa1tHuxVL1X/ZOeT3k4ut
         tgO73Hi28IyUFLGdoVKM2he8PVFmGa5Cp3nJP0haXR14ujEM2MecURIkVQy6ccsroY7R
         Bi4NtzgkvdzoHs3C+Ub+WSmwg+akRgRysu8FzqJ4uSM9/GTX0O/KnD6/ov5D2PT/3Vuc
         zSQw==
X-Gm-Message-State: AOAM530DgdTwwSdT34aAam2k5ug4qhITCv/RACYOv/Yf5Iav/4fZXHmE
        irCj7FHhEnFj/+eii9r8foEe6HK8
X-Google-Smtp-Source: ABdhPJyuv9atNP3W3CDIMOz7707cruf2Sa7GXsrOijyTvlVmytS70Oim9dsoK7V3Zef5NWgcwB2IqQ==
X-Received: by 2002:a6b:e509:: with SMTP id y9mr7904367ioc.67.1590071735293;
        Thu, 21 May 2020 07:35:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a20sm2535088iot.17.2020.05.21.07.35.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:34 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZYgv000891;
        Thu, 21 May 2020 14:35:34 GMT
Subject: [PATCH v3 21/32] SUNRPC: Replace dprintk() call sites in TCP
 receive path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:34 -0400
Message-ID: <20200521143534.3557.5502.stgit@klimt.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/svcsock.c          |   16 ++--------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ec4ae34a1f84..bfea554bd91f 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1502,6 +1502,7 @@ DECLARE_EVENT_CLASS(svcsock_class,
 
 DEFINE_SVCSOCK_EVENT(udp_send);
 DEFINE_SVCSOCK_EVENT(tcp_send);
+DEFINE_SVCSOCK_EVENT(tcp_recv);
 DEFINE_SVCSOCK_EVENT(data_ready);
 DEFINE_SVCSOCK_EVENT(write_space);
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 9c1eb13aa9b8..8cf06b676831 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -119,9 +119,8 @@ static void svc_release_skb(struct svc_rqst *rqstp)
 	if (skb) {
 		struct svc_sock *svsk =
 			container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
-		rqstp->rq_xprt_ctxt = NULL;
 
-		dprintk("svc: service %p, releasing skb %p\n", rqstp, skb);
+		rqstp->rq_xprt_ctxt = NULL;
 		skb_free_datagram_locked(svsk->sk_sk, skb);
 	}
 }
@@ -132,8 +131,6 @@ static void svc_release_udp_skb(struct svc_rqst *rqstp)
 
 	if (skb) {
 		rqstp->rq_xprt_ctxt = NULL;
-
-		dprintk("svc: service %p, releasing skb %p\n", rqstp, skb);
 		consume_skb(skb);
 	}
 }
@@ -245,8 +242,6 @@ static ssize_t svc_recvfrom(struct svc_rqst *rqstp, struct kvec *iov,
 	if (len == buflen)
 		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 
-	dprintk("svc: socket %p recvfrom(%p, %zu) = %zd\n",
-		svsk, iov[0].iov_base, iov[0].iov_len, len);
 	return len;
 }
 
@@ -932,9 +927,6 @@ static int copy_pages_to_kvecs(struct kvec *vec, struct page **pages, int len)
 static void svc_tcp_fragment_received(struct svc_sock *svsk)
 {
 	/* If we have more data, signal svc_xprt_enqueue() to try again */
-	dprintk("svc: TCP %s record (%d bytes)\n",
-		svc_sock_final_rec(svsk) ? "final" : "nonfinal",
-		svc_sock_reclen(svsk));
 	svsk->sk_tcplen = 0;
 	svsk->sk_marker = xdr_zero;
 }
@@ -954,11 +946,6 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	__be32 calldir;
 	int pnum;
 
-	dprintk("svc: tcp_recv %p data %d conn %d close %d\n",
-		svsk, test_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags),
-		test_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags),
-		test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags));
-
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	len = svc_tcp_read_marker(svsk, rqstp);
 	if (len < 0)
@@ -977,6 +964,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	/* Now receive data */
 	len = svc_recvfrom(rqstp, vec, pnum, base + want, base);
 	if (len >= 0) {
+		trace_svcsock_tcp_recv(&svsk->sk_xprt, len);
 		svsk->sk_tcplen += len;
 		svsk->sk_datalen += len;
 	}

