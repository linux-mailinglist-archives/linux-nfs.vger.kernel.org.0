Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E41E919E
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgE3N3w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3N3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:29:51 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEAEC03E969;
        Sat, 30 May 2020 06:29:51 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a13so418697ilh.3;
        Sat, 30 May 2020 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=51O4yhSr65SN0UuqjkFOH+vH4pbqbD6haQ3RcBeQzKM=;
        b=ARj0C+9FSvxWDiuJbsCbXB2oni0jzUrRIJLs6gfY/qaSNYB5OVfgp5n4xkOV3va8Mf
         v2rgQZLhHdq1CDZz5HrfMetFPkuXnx/0vIGQi7WpwfewvCLrlUOi/xMMGzR9bhF+KEZk
         N5yLboM0xqMibZhBtZQGxReURUawh+Nea1b3EnBc8yhW7NFlYOsNn4570bH12cx0FgDi
         z8OMtmjlfiNi9Tl6vwjPqsCAmSPJb1d6U6e/WbS2LeaU/Wkkhih+aqjfsvNCnKn6puUd
         656ja6KxsEWTR8SY+jTn7IxFji/7alSiLfomt7jBS4DtQW/9DQRk64XlW0PKEgpAooGE
         Mv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=51O4yhSr65SN0UuqjkFOH+vH4pbqbD6haQ3RcBeQzKM=;
        b=BPoZdcw5GWW34VEauREKmMOHJAJh07sJqy8pCkBh9cV2XgcS73YN0Yry6XaQxVvasp
         kDSf96VtKTkhuXxGxNKFHE+FvYbqz+o3gAqzKW7XvJ6r7VXqzj5jYDch14ItTre3Dges
         mSQrblZ1uLZdJJhXx62b4NXpUXq3jcjBmShZTqHS7sfHJ/DHo0Jb2Yu63Ju+JjBl7Dls
         coQzIdX2YjZhzNmYhnz48ena1mwvK4hgdhSWYpt9kRbU6sibErp2aqrlWB7o6kPtZ14K
         /LFfbPbgOs+LYOABlznfY35ur4oO3QJz7LVqwLhUM9cNdoimLlSjG8Qu5SH/MHx+K6d2
         mGVg==
X-Gm-Message-State: AOAM531kjG5nQ8hBsg7QFyLN/OqKOBuOqttkkT9a6Q/GDo43wSlXQFrP
        yINQJC26Oxq+GpO1De0FIyczyr50
X-Google-Smtp-Source: ABdhPJwjx6xi0zeSvlgBLbIAaWURiFUNgdPJ9GiezM5KIdIADL5OTeTMdYQ3hM6k5cOeuaVA2dFpIg==
X-Received: by 2002:a92:c7a4:: with SMTP id f4mr12414557ilk.44.1590845390594;
        Sat, 30 May 2020 06:29:50 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d5sm5082462ioe.20.2020.05.30.06.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:29:50 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDTnwQ001444;
        Sat, 30 May 2020 13:29:49 GMT
Subject: [PATCH v4 20/33] SUNRPC: Rename svc_sock::sk_reclen
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:29:49 -0400
Message-ID: <20200530132949.10117.40355.stgit@klimt.1015granger.net>
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

