Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9CA1E91A3
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgE3NaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3NaC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:02 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CAC03E969;
        Sat, 30 May 2020 06:30:01 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 9so5145870ilg.12;
        Sat, 30 May 2020 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+QhH4znuFuHGbo6XZVPUBT/k5yNsprOm7HXWwCKjTkg=;
        b=UUT1qwrGFO1hWqXZ9ruSDwkNChXeQ1ydlCYrMO9+pU57bmNnd2Nes7vLnI9Jqxaj6D
         Mrrs5lNcHc/+AWy0Zk2vWMc0KSTlipaZbT8DZ5kKT6F90P4jUiujzlsOD1T37eehlI7w
         T8iEd6zqJtFqXtI5wQ2J1Ux42dHyKNt345RyWvTaVOaQS7ajJx8e7tRxsA6l8/XKdPlR
         3oyLADnyAUOANl+FbmvQIMAPpWxOwvRpo2G30GVXVhIJyT2IjVvqDJb5uyUSXKIJV0Pq
         C3o7q53Js3z0/VmJJ8GMwTu3e+frDcrgt1Sqc5cipjLPei275phShMDD3doevGip7CDH
         KIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+QhH4znuFuHGbo6XZVPUBT/k5yNsprOm7HXWwCKjTkg=;
        b=klP+AWxs4bOF7txQbs+uyu4wZmGsYzOmWZajaGuJuj7JX99rc8zdx2Ft09HCPBQ13/
         Vi3w7fA92F5YeRHdWYhne0tJP3/J9cslqNED7y67lxZ+5FtqnIDyoDPOzer/sQr/Rga0
         MBwSiJVZnz0pv3yEVTubAu7cnm+CGF/pQtVl2M78qOZoI4cUHoypG9w8ZfVYNhLSpoY2
         KaL+hAwJn2yi1YX61xoAmYDnd7WTB+AhF6gD1RK974S5LjbDBpgM6tePJkpQptnYer9h
         EtUAJaDbBPIYzOqzbcuWeRS9esO2VHH+cQO5BN3YITAvNcxwQn0/XkiBl38pioKUoaZa
         fIVQ==
X-Gm-Message-State: AOAM533ZrDCCtt4v8vWdZLgtQ2k3yHxdPU4XlwBDpza6TLtGwqMpD6E9
        2iWNIJ1BOtwujl20nP0u/LZ01yl3
X-Google-Smtp-Source: ABdhPJznf37QCQW0/4pK7GyXLSN0bjku3OM9bqHJAvPUBjdrddocbvu3RZ4xfyGtE644eXSWAmtWug==
X-Received: by 2002:a05:6e02:f81:: with SMTP id v1mr11868609ilo.246.1590845401217;
        Sat, 30 May 2020 06:30:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z24sm4890471ioe.18.2020.05.30.06.30.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:00 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDU0pX001450;
        Sat, 30 May 2020 13:30:00 GMT
Subject: [PATCH v4 22/33] SUNRPC: Replace dprintk() call sites in TCP
 receive path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:00 -0400
Message-ID: <20200530133000.10117.89867.stgit@klimt.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/svcsock.c          |   16 ++--------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 794974378be6..dc7388b72501 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1521,6 +1521,7 @@ DECLARE_EVENT_CLASS(svcsock_class,
 
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

