Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFC1E91A5
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgE3NaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3NaH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:07 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51744C03E969;
        Sat, 30 May 2020 06:30:07 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y17so5237668ilg.0;
        Sat, 30 May 2020 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GVPJUYUYmvMgwUAgLVAuipvRFZxp/twoaEt4EKJPDjA=;
        b=OH8GU1ue3KTVbhXX9QwktceutNCcdYzjDZLl8YGca3LBXlKIQ+Ina6w/Im2Rvpgcl3
         1yICfN2WHCQMyvKdcohPHp5HLNABS56+xv145v+DiLAN8aVK5+SZrlLkD/HUp3TbGCdm
         FZlkyJeFyS+KLwfj9N54Ftytq5aFd0Jy9OMmAp1gp3bXwf3Wu2fRFbEQCj0SaqnrNYyN
         9pWX48ZunV9LlHxjIKR+Ad/cvVFfekzrwPNOoaY8gI2vm5GXE+CTf8Psh47+7KYoK1zb
         vv7Q911Mo0eIXPuSheCarhn5jYHckeEiSrw3kLyIwDNTmP+VBB+Yu0PDmwYeG+rqJHBk
         CksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GVPJUYUYmvMgwUAgLVAuipvRFZxp/twoaEt4EKJPDjA=;
        b=pY0sW+IPF3DZBEiogvL23l3cFY3eqKKgpaaV5HOdQdzs8E6opxOuIXBTS06/dP095l
         GEvuapVOEcilnpNlSiwELQx7TOd7bjz08D7XDxqm37jucJhjy0wP8MxWqvw5D7v8zFkA
         jpHgN9tExg4c6LPVBgmaNWfHTfNtiKk9DhG921vdZZg6xevd4ymTTzFck2mLTXbZyvxQ
         P/eNRTYCFexQmvnhrcfU26Aaji7Wa3yQvqN8VNYNsqqUoy9vR8Mc/0qongoDxp9wq3WX
         V3p5ExQo3xZI/lZ7adW4SEB0iMnibZcRZ2+fSXYc/ovmZeYW1T5ypdW/MpxSbqHc/Xyt
         yIBg==
X-Gm-Message-State: AOAM53311nHExcCYCvyXzwGJBFRd7uA4Wj9Zp/S0EhqXj+nDsXJEKvVD
        A4nP/hrY3u25DziEyYa9Puu0Kljv
X-Google-Smtp-Source: ABdhPJzhp6LDXMgrJH4XOMCsEL/Z76Fi3HQhJu6S0tcIYEKK9iGcLUi0vR6Eq69Wp+FQ3ViOAm7Skw==
X-Received: by 2002:a92:6a06:: with SMTP id f6mr12156667ilc.89.1590845406571;
        Sat, 30 May 2020 06:30:06 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r9sm6278476ilm.10.2020.05.30.06.30.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:06 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDU5KE001462;
        Sat, 30 May 2020 13:30:05 GMT
Subject: [PATCH v4 23/33] SUNRPC: Refactor recvfrom path dealing with
 incomplete TCP receives
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:05 -0400
Message-ID: <20200530133005.10117.47583.stgit@klimt.1015granger.net>
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

Clean up: move exception processing out of the main path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   31 +++++++++++++++++++++++++++++++
 net/sunrpc/svcsock.c          |   39 +++++++++++++++++++--------------------
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index dc7388b72501..22e67fbf79b0 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1522,9 +1522,40 @@ DECLARE_EVENT_CLASS(svcsock_class,
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

