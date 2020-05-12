Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988B21D00C0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbgELVXs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731308AbgELVXr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F669C061A0C;
        Tue, 12 May 2020 14:23:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l1so8929930qtp.6;
        Tue, 12 May 2020 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=51O4yhSr65SN0UuqjkFOH+vH4pbqbD6haQ3RcBeQzKM=;
        b=LbKrd8DKmBZbQPF/0KDzkIDMUSlHy+ugiGMqhzOSIScDgEGhPU9TIvXvti0OlPe7iI
         nT47Y/9i9DdbQiQ4s7BYWaAyyYdkKQTajFoXZi4pk/eZ4YmqZ4FFWbnMrOv1AxdiKjrY
         JvwIdQlXuZ7hyLEws4s+Xa6t8IXbmoN/ddPp0Nir8g0jyrBhkS5UvNLbRX3CeX1EMbls
         PgNOEQQo93niG08NMXc6RUnwSmjYf4At+tAW35/AK0gLllXqy3ybFZpMwJz5KILjN7He
         zRKm7E8ZZZMll8x2rjgXvhndLdoE+hQw09YkCoCClwlXSrF2lgr/PYurmk7pWVYA/h9K
         k4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=51O4yhSr65SN0UuqjkFOH+vH4pbqbD6haQ3RcBeQzKM=;
        b=NqdC6CEujIWQFqZaeRU9E9Q0vB6el8gWcilSNVr0Ligg6YNLUJTStFR/nMCChSaYq8
         oACDUZcN2JaYPqBFICTjKvtMEU3FGq1iyP/0ExhkWc2RHLKuHHnUQyQe09C0e4SpC41q
         xtrVnKD9jF2+tqwULOSSIlarIVVDb+hGQccyuFOSnodbFfWNhstU9cHubxtJfueUKMKl
         6MvOPUcCtHMkU1Ktd4R8oATNRC+4ZmdBSK3ojxgj0T/wPu8WUts06vcouake+R1S5VgR
         +uGNeMyVADrU3iwx3jiS4UqhzH1rE6gGMktY+nEznnJGiuc4QmAdCAJwe6PHrtH7gXpV
         MAMw==
X-Gm-Message-State: AGi0PuaDZZYFqDzgueHSh5/CfPsVclgx9VrMY48Uw/zG6BjqSaiMNeId
        /zLfxrYUefx+7jjlLTR7gDkioDcY
X-Google-Smtp-Source: APiQypJxPYGzg3+++yCtLqi+34sPvGIovQbTOLbh/M/bmXnmF+0XVcn0Y1FO80zW3JtEAfTYmpF2SQ==
X-Received: by 2002:ac8:4b45:: with SMTP id e5mr23695041qts.86.1589318626253;
        Tue, 12 May 2020 14:23:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r30sm7633073qtj.95.2020.05.12.14.23.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:23:45 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLNiqO009933;
        Tue, 12 May 2020 21:23:44 GMT
Subject: [PATCH v2 19/29] SUNRPC: Rename svc_sock::sk_reclen
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:23:44 -0400
Message-ID: <20200512212344.5826.34952.stgit@klimt.1015granger.net>
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

Clean up. I find the name of the svc_sock::sk_reclen field
confusing, so I've changed it to better reflect its function. This
field is not read directly to get the record length. Rather, it is
a buffer containing a record marker that needs to be decoded.

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

