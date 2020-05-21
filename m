Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7AE1DD004
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgEUOfm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgEUOfl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:41 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E593C061A0E;
        Thu, 21 May 2020 07:35:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t15so7673294ios.4;
        Thu, 21 May 2020 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DD923gpA/57vo3TanxqlQQKr4WVb6dwsKzs26CnmLPg=;
        b=qCp32RGCv78nYuRxsEAC7taVz03Wx/xGSmlczcCsqstSC4vXjGQ2LAE3H5AjHAQ5lG
         FbolXS0xnrx8odOpNC9bA6VdXhB6WG/JIC1p5T/YBAWxw2BzQBGVx8Ue9xBJXjC5G0vD
         i+lyePTi6HPZpVZYr9ntOefick/UzNA/fXlLCwia8sJATTUblwqUKHfKzq/knXoU1FbG
         Zh+sqLB2Mkr3y6kEkvkausz7PeQVH+JLsetqdlklLWD57nRVo71l0fSf4erW6LgC0Nhz
         +zI5xSi4F7C2BHcYGuHSoiMbdz8MaMA5VMAbmocdVUNxG8XzF4K3VkQwnM3+kov7OPlO
         eNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DD923gpA/57vo3TanxqlQQKr4WVb6dwsKzs26CnmLPg=;
        b=GhXkDltOdhksykNZkVfTKfK/uDD1XD2SzNClHDPJJMPK3ZMjCTRcQUdHT/vdswJAyy
         pcTZpFA5lPBeCQYfnZ7HUzFZ80yGtJ4Q0prw2Zf6c0bR7YFCZD964AE2XkQG/bIrlRu8
         3kQPe6CfN0xpr9OfCCpQbYinqtcQK50I8hprIetgHtLWgBBKMH2bbijKrmWPgcM8yDt5
         fu5/xmXvumJl1palc1NqLWE3DUX+MOMvlM8BxlINYa+YzQiYh3t4s2dYK+woM4Tdc4jv
         E5xEh0gCuw8WSsBDS061QgpiSN03XbwT+XJMkPF7PgJbC/MdN7Gefp1gciHfUmjhBAbX
         +ygw==
X-Gm-Message-State: AOAM5314f20HBGpuf9GNnOrXdRtC49h6BZETiwJbOKVAPnCfY2fhDcKZ
        bfJrCsPy4YCqSAdtmWxK3pILYjmy
X-Google-Smtp-Source: ABdhPJy9HJ+TMMQBemVyF1BXrB3fHpf3iPWA9bzbd3abLMB8F+pEqLQyl6v15wKvejDZQNMPHi6y4Q==
X-Received: by 2002:a05:6602:2c88:: with SMTP id i8mr5872329iow.74.1590071740530;
        Thu, 21 May 2020 07:35:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s7sm2367965ioc.37.2020.05.21.07.35.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:40 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZdjp000895;
        Thu, 21 May 2020 14:35:39 GMT
Subject: [PATCH v3 22/32] SUNRPC: Refactor recvfrom path dealing with
 incomplete TCP receives
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:39 -0400
Message-ID: <20200521143539.3557.12371.stgit@klimt.1015granger.net>
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

Clean up: move exception processing out of the main path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   31 +++++++++++++++++++++++++++++++
 net/sunrpc/svcsock.c          |   39 +++++++++++++++++++--------------------
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index bfea554bd91f..81659876b4af 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1503,9 +1503,40 @@ DECLARE_EVENT_CLASS(svcsock_class,
 DEFINE_SVCSOCK_EVENT(udp_send);
 DEFINE_SVCSOCK_EVENT(tcp_send);
 DEFINE_SVCSOCK_EVENT(tcp_recv);
+DEFINE_SVCSOCK_EVENT(tcp_recv_eagain);
+DEFINE_SVCSOCK_EVENT(tcp_recv_err);
 DEFINE_SVCSOCK_EVENT(data_ready);
 DEFINE_SVCSOCK_EVENT(write_space);
 
+TRACE_EVENT(svcsock_tcp_recv_short,
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		u32 expected,
+		u32 received
+	),
+
+	TP_ARGS(xprt, expected, received),
+
+	TP_STRUCT__entry(
+		__field(u32, expected)
+		__field(u32, received)
+		__field(unsigned long, flags)
+		__string(addr, xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->expected = expected;
+		__entry->received = received;
+		__entry->flags = xprt->xpt_flags;
+		__assign_str(addr, xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s flags=%s expected=%u received=%u",
+		__get_str(addr), show_svc_xprt_flags(__entry->flags),
+		__entry->expected, __entry->received
+	)
+);
+
 TRACE_EVENT(svcsock_tcp_state,
 	TP_PROTO(
 		const struct svc_xprt *xprt,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 8cf06b676831..087e21b0f1bb 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -968,23 +968,10 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		svsk->sk_tcplen += len;
 		svsk->sk_datalen += len;
 	}
-	if (len != want || !svc_sock_final_rec(svsk)) {
-		svc_tcp_save_pages(svsk, rqstp);
-		if (len < 0 && len != -EAGAIN)
-			goto err_delete;
-		if (len == want)
-			svc_tcp_fragment_received(svsk);
-		else
-			dprintk("svc: incomplete TCP record (%d of %d)\n",
-				(int)(svsk->sk_tcplen - sizeof(rpc_fraghdr)),
-				svc_sock_reclen(svsk));
-		goto err_noclose;
-	}
-
-	if (svsk->sk_datalen < 8) {
-		svsk->sk_datalen = 0;
-		goto err_delete; /* client is nuts. */
-	}
+	if (len != want || !svc_sock_final_rec(svsk))
+		goto err_incomplete;
+	if (svsk->sk_datalen < 8)
+		goto err_nuts;
 
 	rqstp->rq_arg.len = svsk->sk_datalen;
 	rqstp->rq_arg.page_base = 0;
@@ -1019,14 +1006,26 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 
 	return rqstp->rq_arg.len;
 
+err_incomplete:
+	svc_tcp_save_pages(svsk, rqstp);
+	if (len < 0 && len != -EAGAIN)
+		goto err_delete;
+	if (len == want)
+		svc_tcp_fragment_received(svsk);
+	else
+		trace_svcsock_tcp_recv_short(&svsk->sk_xprt,
+				svc_sock_reclen(svsk),
+				svsk->sk_tcplen - sizeof(rpc_fraghdr));
+	goto err_noclose;
 error:
 	if (len != -EAGAIN)
 		goto err_delete;
-	dprintk("RPC: TCP recvfrom got EAGAIN\n");
+	trace_svcsock_tcp_recv_eagain(&svsk->sk_xprt, 0);
 	return 0;
+err_nuts:
+	svsk->sk_datalen = 0;
 err_delete:
-	printk(KERN_NOTICE "%s: recvfrom returned errno %d\n",
-	       svsk->sk_xprt.xpt_server->sv_name, -len);
+	trace_svcsock_tcp_recv_err(&svsk->sk_xprt, len);
 	set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
 err_noclose:
 	return 0;	/* record not complete */

