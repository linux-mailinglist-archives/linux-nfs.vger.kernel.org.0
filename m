Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E847E159E35
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 01:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgBLAmj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 19:42:39 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34363 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBLAmj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Feb 2020 19:42:39 -0500
Received: by mail-yw1-f67.google.com with SMTP id b186so296387ywc.1
        for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2020 16:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HYZWoW4QqCvmqknnidKLyKWfjKq9WkCo7XFv1XGE0W8=;
        b=thm4R37dHgHp2wURh2T1FHD+OXaJUzoNlHbPyGo4wgYF7ttZhcjsj6Tep3xoJhmtG1
         oM17rLgNoZQRaXoeKbRWyY3zTcHjTi2OZ1XverQ20gCKKWZDIzM47MWN6nfbh+mpJeFN
         Z26U4ytHQ3OPQCv8/I8oGJJxe7aR+2KFliFd+Ya94gE5pft9S2hTtLluy2bmKDLhSHW7
         PZjlJbNQxLBnxU5zSc04UiG6Bef5Ii3aMX0+x0ZAspMX0Ajxg+D11lWgRBT18i5pG9Iv
         cgpgiB1yzjv2QmoV3wq1N9YapQODOxRiGrUFyXk9Y4jXxVMGTQFo3ddm4b5+CGolXjrn
         7dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HYZWoW4QqCvmqknnidKLyKWfjKq9WkCo7XFv1XGE0W8=;
        b=BcPSxHtUKUAp58ohFMzrs4clRydqyfAO9Cs5HAvl/zvb2TGKIeZNO63391deZcXvWe
         DZWovtYS/WqpCGntug8jTm04Ffxw8kLrDDjZaj6tiHW7liz5Haj8uaX4hYYaBrr9D9UI
         F70kjQoZJa2Bi06dFkBwpG2A3JUDXI3jh9g2uFmoD0aoXiyjeU8yM+PP/X0MT7+S2yXf
         iTFK8MUtUMbGGoEk5HwqRklQWtRP5Bhhnvr3GYmrnRqiw61yi29H5DRE8oJuwgyXsuhu
         BleGYdB7BLs/s7Q0M/WwPkTCNZYa3ZIyl9PBSJokS2YxANXFpzW6X6hG8TiwvWdlPgMB
         tbVg==
X-Gm-Message-State: APjAAAXMtJlLjijYReobNA5YHwW9XNqxw4jhuZVY+eBRX3mSE6qcOvSF
        2wVh+5Nyg4J3kb0VVCEw5TZlpz7c
X-Google-Smtp-Source: APXvYqwdIad1ANLQBs9WhNMRs1NNHnOC4xStm8+IkZROyZQ/TDeKAHPpkWkA4uksoK8o0vSw8zG79w==
X-Received: by 2002:a0d:ca89:: with SMTP id m131mr7877566ywd.509.1581468156754;
        Tue, 11 Feb 2020 16:42:36 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s31sm2694981ywa.30.2020.02.11.16.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:42:36 -0800 (PST)
Subject: [PATCH RFC 1/3] SUNRPC: Move xs_stream_record_marker
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 11 Feb 2020 19:42:35 -0500
Message-ID: <20200212004235.2305.56300.stgit@bazille.1015granger.net>
In-Reply-To: <20200212003607.2305.38250.stgit@bazille.1015granger.net>
References: <20200212003607.2305.38250.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Allow the client and server to share this helper function.

msg_prot.h now needs linux/kernel.h for cpu_to_be32. #include
<msg_prot.h> is removed anywhere it is not required and causes a
compilation failure due to the new header dependency.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/msg_prot.h |   13 +++++++++++++
 include/linux/sunrpc/svcauth.h  |    1 -
 net/sunrpc/xprtsock.c           |   18 +++---------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/sunrpc/msg_prot.h b/include/linux/sunrpc/msg_prot.h
index bea40d9f03a1..cceb5a3e39f5 100644
--- a/include/linux/sunrpc/msg_prot.h
+++ b/include/linux/sunrpc/msg_prot.h
@@ -104,6 +104,19 @@ enum rpc_auth_stat {
 #define	RPC_FRAGMENT_SIZE_MASK		(~RPC_LAST_STREAM_FRAGMENT)
 #define	RPC_MAX_FRAGMENT_SIZE		((1U << 31) - 1)
 
+/**
+ * rpc_stream_record_marker - Construct a 4-octet stream record marker
+ * @size: number of octets in the RPC message to send
+ *
+ * Returns the stream record marker field for a record of length < 2^31-1
+ */
+static inline rpc_fraghdr rpc_stream_record_marker(u32 size)
+{
+	if (!size)
+		return 0;
+	return cpu_to_be32(RPC_LAST_STREAM_FRAGMENT | size);
+}
+
 /*
  * RPC call and reply header size as number of 32bit words (verifier
  * size computed separately, see below)
diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index b0003866a249..aeac5a955cce 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -11,7 +11,6 @@
 #define _LINUX_SUNRPC_SVCAUTH_H_
 
 #include <linux/string.h>
-#include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/gss_api.h>
 #include <linux/hash.h>
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index d86c664ea6af..f940179db510 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -929,17 +929,6 @@ static int xs_nospace(struct rpc_rqst *req)
 	return transport->xmit.offset != 0 && req->rq_bytes_sent == 0;
 }
 
-/*
- * Return the stream record marker field for a record of length < 2^31-1
- */
-static rpc_fraghdr
-xs_stream_record_marker(struct xdr_buf *xdr)
-{
-	if (!xdr->len)
-		return 0;
-	return cpu_to_be32(RPC_LAST_STREAM_FRAGMENT | (u32)xdr->len);
-}
-
 /**
  * xs_local_send_request - write an RPC request to an AF_LOCAL socket
  * @req: pointer to RPC request
@@ -957,7 +946,7 @@ static int xs_local_send_request(struct rpc_rqst *req)
 	struct sock_xprt *transport =
 				container_of(xprt, struct sock_xprt, xprt);
 	struct xdr_buf *xdr = &req->rq_snd_buf;
-	rpc_fraghdr rm = xs_stream_record_marker(xdr);
+	rpc_fraghdr rm = rpc_stream_record_marker(xdr->len);
 	unsigned int msglen = rm ? req->rq_slen + sizeof(rm) : req->rq_slen;
 	int status;
 	int sent = 0;
@@ -1104,7 +1093,7 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 	struct rpc_xprt *xprt = req->rq_xprt;
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	struct xdr_buf *xdr = &req->rq_snd_buf;
-	rpc_fraghdr rm = xs_stream_record_marker(xdr);
+	rpc_fraghdr rm = rpc_stream_record_marker(xdr->len);
 	unsigned int msglen = rm ? req->rq_slen + sizeof(rm) : req->rq_slen;
 	bool vm_wait = false;
 	int status;
@@ -2652,8 +2641,7 @@ static int bc_sendto(struct rpc_rqst *req)
 	struct msghdr msg = {
 		.msg_flags	= MSG_MORE
 	};
-	rpc_fraghdr marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
-					 (u32)xbufp->len);
+	rpc_fraghdr marker = rpc_stream_record_marker(xbufp->len);
 	struct kvec iov = {
 		.iov_base	= &marker,
 		.iov_len	= sizeof(marker),

