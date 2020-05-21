Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7431DCFFB
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgEUOf1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgEUOf0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:26 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E99C061A0E;
        Thu, 21 May 2020 07:35:25 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c20so7302832ilk.6;
        Thu, 21 May 2020 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=51O4yhSr65SN0UuqjkFOH+vH4pbqbD6haQ3RcBeQzKM=;
        b=rNTit/zDO0/Mh2vAM9etrM0wuc8ISR04sASQ2+p+7ThXZmeaPm4BgkhzfD2FjMpUXi
         t9J+a4enxjwAid2o7nNsWOACS6919mib9cKs7YmXe5zxDiddfxO4Qn0Ci7iC81irY05J
         O1Lg9M3P2+8qMZaH/QTySb2XdyblfKplVT8OVpOUCPSA4POrXpkzR+R6/9O0ZhFp50Eh
         5iCBVcHN39X4qatUzfSJSiZ5hikKxYgkN6GthV6t7wbHLWcCkZA8Y9tk7/oztZavJ/V6
         9Z/RSEzuUEO4URbMIojsCnqV9iC2wk6HspSagB0HI7WjQeQGlHZKRDxRgLR0w5+wKlfE
         OK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=51O4yhSr65SN0UuqjkFOH+vH4pbqbD6haQ3RcBeQzKM=;
        b=dpbiNwgSS906N+A/lqoqDymSD2Sr+DUjlgWk7ZKCdviY/2e116vOCy/9flwarPm9zM
         vEhLmAzzOkgUiKTnMvQJYzmB3WEOluXYR9mcQnFb+A/EJ51LciQFVtjUTAn/B5hRtbFM
         jZ/zThwY7dvEBGmc8pBQ8K4ZG5sro0TKPweTiNFor7fGa4ujexW2FFJGDbA0qjGQCeSW
         RhoQWscm5BXGuQFGWNgZoPT/Bd3Zusn9VDx4IQF0mDyo/8H3V/tBza+xtHkbtgzD9AUT
         coYW2VfepfJN3sYG3SaY7Ol/fI6aHqs4z9RGUw079zrBVBsUIkKXTGkUtQDLbVAG5k+O
         lcLQ==
X-Gm-Message-State: AOAM533sjjgFXNNnYNnJSIF0fxbo9xmtHzMKj/BXghCAQVyMUBHBegh6
        nq0EOcJn+Peat0jlgmMNi+Xq7l38
X-Google-Smtp-Source: ABdhPJxW8EjVy5aEot91L3dvlg59rCeNw52k0gQqErl4ZhjFXG9y6UjJO8QBFG1JT4hJ8xGmLl7RzA==
X-Received: by 2002:a92:8803:: with SMTP id h3mr8752316ild.121.1590071724666;
        Thu, 21 May 2020 07:35:24 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m89sm3103987ill.40.2020.05.21.07.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:24 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZNlI000884;
        Thu, 21 May 2020 14:35:23 GMT
Subject: [PATCH v3 19/32] SUNRPC: Rename svc_sock::sk_reclen
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:23 -0400
Message-ID: <20200521143523.3557.53352.stgit@klimt.1015granger.net>
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

