Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6B1C1BF6
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgEARiP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729040AbgEARiO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:38:14 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C06C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:38:14 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id 59so5045123qva.13
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AJMwKyVCLJ7t1pONDCzPyqQfa9MtjCvSaNEq/HttZ2U=;
        b=rp5tYDySU/MKhaSQVLQgjWjPttY2vSxICS3cb2Qv8qdRZTVIooQod9yx3/8JcTkkKk
         j1bBa0Iin9iW3DyQGBieQ1JBpOYMH4dpFoumbmNYSx7kgQbQb7jw35FM9YdSH9syHu3j
         QC79oLz+7bhZgKApCgf0A2L3Jb5F4DXM6JqQWxZQ5sWgkAhpJ5ceSrOIuyujzOiG0H/k
         ea66gtDhnXd+IY8b9554Nn8zFhdCzr3urg4I9Zsdn/eVBveOfubrUQyPrckgJPMLr2PS
         IsTqeWTCsne5olbkaoMtqAND44OxUnYj5ZfcOWt6kDx2YDv/DCj95clb4WzUIt2Bs4BT
         9vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AJMwKyVCLJ7t1pONDCzPyqQfa9MtjCvSaNEq/HttZ2U=;
        b=lncC9+38/RJuVUSlT1GIkblhebBukRifXYmGBxRy7rBSyHCYTqXqDDDNqnQLG1J7TV
         X16o5I7IannunELZh0U/hIm/0Bqr5oA23/1Xcb4ObdB7iUgJ9YoDla7pGvpRXn+SPOZY
         XtzTRoKNfEOoUDBOHhpzx8Yfm7ESnErQYK5ihiTwynt4XHBm0MulM4O8Pz9xyHT+OrMr
         fBUj4XXVxl5+baYnPwlJuwsdIuOigJoxzqgzXdiJ+SAWQX2XJSQVlj+C7IKI5/jHQzaF
         IV04/oS0Nt1On+RMrKEfHEzZ4YkC9HBNPTss3X38oLDUQq0ICUQaFh8uZYQN5Do3ygDs
         EUTg==
X-Gm-Message-State: AGi0PubXWoft205nfwSPReIqZFTvjmKb24qX4Avn5BQxs9ml545GZVOx
        s9WPJjSfU9Bl8DIq3/2vZ0rrEqZo
X-Google-Smtp-Source: APiQypLK60HWENJ4GWe0XmXR7neOk2jLfuSeKkE77d1AVoZiDD5roGQuKtJvmex67RHwyrfqWT4jkA==
X-Received: by 2002:a0c:c190:: with SMTP id n16mr5220362qvh.107.1588354693456;
        Fri, 01 May 2020 10:38:13 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d4sm2935408qtw.25.2020.05.01.10.38.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:38:13 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HcBJP026740
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:38:11 GMT
Subject: [PATCH v1 5/8] SUNRPC: Clean up: Rename svc_sock::sk_reclen
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:38:11 -0400
Message-ID: <20200501173811.3868.85517.stgit@klimt.1015granger.net>
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

I find the name of the svc_sock::sk_reclen field confusing, so I've
changed it to better reflect its function. This field is not read
directly to get the record length. Rather, it is a buffer containing
a record marker that needs to be decoded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |    6 +++---
 net/sunrpc/svcsock.c           |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 771baadaee9d..b7ac7fe68306 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -28,7 +28,7 @@ struct svc_sock {
 
 	/* private TCP part */
 	/* On-the-wire fragment header: */
-	__be32			sk_reclen;
+	__be32			sk_marker;
 	/* As we receive a record, this includes the length received so
 	 * far (including the fragment header): */
 	u32			sk_tcplen;
@@ -41,12 +41,12 @@ struct svc_sock {
 
 static inline u32 svc_sock_reclen(struct svc_sock *svsk)
 {
-	return ntohl(svsk->sk_reclen) & RPC_FRAGMENT_SIZE_MASK;
+	return be32_to_cpu(svsk->sk_marker) & RPC_FRAGMENT_SIZE_MASK;
 }
 
 static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
 {
-	return ntohl(svsk->sk_reclen) & RPC_LAST_STREAM_FRAGMENT;
+	return be32_to_cpu(svsk->sk_marker) & RPC_LAST_STREAM_FRAGMENT;
 }
 
 /*
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 4ac1180c6306..d63b21f3f207 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -841,7 +841,7 @@ static int svc_tcp_recv_record(struct svc_sock *svsk, struct svc_rqst *rqstp)
 		struct kvec	iov;
 
 		want = sizeof(rpc_fraghdr) - svsk->sk_tcplen;
-		iov.iov_base = ((char *) &svsk->sk_reclen) + svsk->sk_tcplen;
+		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
 		len = svc_recvfrom(rqstp, &iov, 1, want, 0);
 		if (len < 0)
@@ -938,7 +938,7 @@ static void svc_tcp_fragment_received(struct svc_sock *svsk)
 		svc_sock_final_rec(svsk) ? "final" : "nonfinal",
 		svc_sock_reclen(svsk));
 	svsk->sk_tcplen = 0;
-	svsk->sk_reclen = 0;
+	svsk->sk_marker = xdr_zero;
 }
 
 /*
@@ -1154,7 +1154,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 		sk->sk_data_ready = svc_data_ready;
 		sk->sk_write_space = svc_write_space;
 
-		svsk->sk_reclen = 0;
+		svsk->sk_marker = xdr_zero;
 		svsk->sk_tcplen = 0;
 		svsk->sk_datalen = 0;
 		memset(&svsk->sk_pages[0], 0, sizeof(svsk->sk_pages));

