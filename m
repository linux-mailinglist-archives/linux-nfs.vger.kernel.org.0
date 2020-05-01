Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1681D1C1BF7
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgEARiU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729040AbgEARiT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:38:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA93C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:38:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f83so2572541qke.13
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1d5HyKY/8aMXAU82uYfN4p45cMe4PgXtVEIUFVnr5I0=;
        b=ki5VScw42L4N0APqlNmUYVJhf7TuwAdc2vAj+Pmnn8U39trHWU3od09XOKW8ofxJMR
         wK+QkKLMu0kYePACfxdDDJAr8bPkVmV4Lhxgx2b8FIe6pPE2U2BFAKLQaK+DVODiayYH
         vfQtMIC/7SddNVZMpWQGEqM7JIeLo+tFe3e6IaZFqFJz11HG97bDs1Qw7ifP+11xAk55
         NM1ZiCYM6fsLNlqo/3RXa0FtRztx1LjGyhcSaqmP3UfznBF1DGVtV7Fa4NvdjHHeswEF
         zDS7v+MW9F/sOeC87RbJM5YmuCmLA/txbM0n+mkx3mC5bcF8swAWchqOkwVSGx1kRnTr
         dMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1d5HyKY/8aMXAU82uYfN4p45cMe4PgXtVEIUFVnr5I0=;
        b=GNngFWp+iX8hW3ZPFouWL5bKGFBccFCTv0jTKQargrPnrBWADU2y9nQw0hhOavWpdC
         k34TfhWCfoQ3GuqB5SGpugiGqUERvcc8/zW+JS6/gzdz/kVjXhiBGF7sIKzAxJsgi2i/
         G3ufMunL5pcHQ89lbVRYt0BW68N45I6S6qjWeNA6pO4s/njC1uY4sVnJiuVqMmCCG7kb
         yJ6FPBcqGutqpPXXglZ5axTmwHHT/H/IF3W8D0eB1+S8/ue1XPbE1Mms+zRAGh19z7tq
         nm1yx5bBKT6cvpizvfbHEwpDkLHi8OdORVk6ttqI7gYsYveJUhahqi4afb0uDRGUWA4j
         ApYQ==
X-Gm-Message-State: AGi0PuYAE/k6V42JEtHBNqbte3LkoQ85evu3TuMfTe43SAgyreRPkexa
        dLikNoYSuheKB9w+71R2V0/wOUPo
X-Google-Smtp-Source: APiQypL+peqYcLcU+2jz9+Zvuab72LcNwuTaTAk610qw12PaX2L4exoNVZ2L94oeGc14DyLxrbeTKw==
X-Received: by 2002:a37:9f4a:: with SMTP id i71mr4683838qke.132.1588354698542;
        Fri, 01 May 2020 10:38:18 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a195sm1966411qkc.87.2020.05.01.10.38.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:38:18 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HcHnb026743
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:38:17 GMT
Subject: [PATCH v1 6/8] SUNRPC: Restructure svc_tcp_recv_record()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:38:17 -0400
Message-ID: <20200501173817.3868.97075.stgit@klimt.1015granger.net>
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

Refactor: svc_recvfrom() is going to be converted to read into
bio_vecs in a moment. Unhook the only other caller,
svc_tcp_recv_record(), which just wants to read the 4-byte stream
record marker into a kvec.

While we're in the area, streamline this helper by straight-lining
the hot path, replace dprintk call sites with tracepoints, and
reduce the number of atomic bit operations in this path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   24 +++++++++++++++++++
 net/sunrpc/svcsock.c          |   51 ++++++++++++++++++++---------------------
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 32200745f1b8..fd8073d1f3b8 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1459,6 +1459,30 @@ TRACE_EVENT(svcsock_new_socket,
 	)
 );
 
+TRACE_EVENT(svcsock_marker,
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		__be32 marker
+	),
+
+	TP_ARGS(xprt, marker),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, length)
+		__field(bool, last)
+		__string(addr, xprt->xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->length = be32_to_cpu(marker) & RPC_FRAGMENT_SIZE_MASK;
+		__entry->last = be32_to_cpu(marker) & RPC_LAST_STREAM_FRAGMENT;
+		__assign_str(addr, xprt->xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s length=%u%s", __get_str(addr),
+		__entry->length, __entry->last ? " (last)" : "")
+);
+
 DECLARE_EVENT_CLASS(svcsock_class,
 	TP_PROTO(
 		const struct svc_xprt *xprt,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d63b21f3f207..9c1eb13aa9b8 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -828,47 +828,45 @@ static void svc_tcp_clear_pages(struct svc_sock *svsk)
 }
 
 /*
- * Receive fragment record header.
- * If we haven't gotten the record length yet, get the next four bytes.
+ * Receive fragment record header into sk_marker.
  */
-static int svc_tcp_recv_record(struct svc_sock *svsk, struct svc_rqst *rqstp)
+static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
+				   struct svc_rqst *rqstp)
 {
-	struct svc_serv	*serv = svsk->sk_xprt.xpt_server;
-	unsigned int want;
-	int len;
+	ssize_t want, len;
 
+	/* If we haven't gotten the record length yet,
+	 * get the next four bytes.
+	 */
 	if (svsk->sk_tcplen < sizeof(rpc_fraghdr)) {
+		struct msghdr	msg = { NULL };
 		struct kvec	iov;
 
 		want = sizeof(rpc_fraghdr) - svsk->sk_tcplen;
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
-		len = svc_recvfrom(rqstp, &iov, 1, want, 0);
+		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, want);
+		len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
 		if (len < 0)
-			goto error;
+			return len;
 		svsk->sk_tcplen += len;
-
 		if (len < want) {
-			dprintk("svc: short recvfrom while reading record "
-				"length (%d of %d)\n", len, want);
-			return -EAGAIN;
+			/* call again to read the remaining bytes */
+			goto err_short;
 		}
-
-		dprintk("svc: TCP record, %d bytes\n", svc_sock_reclen(svsk));
+		trace_svcsock_marker(&svsk->sk_xprt, svsk->sk_marker);
 		if (svc_sock_reclen(svsk) + svsk->sk_datalen >
-							serv->sv_max_mesg) {
-			net_notice_ratelimited("RPC: fragment too large: %d\n",
-					svc_sock_reclen(svsk));
-			goto err_delete;
-		}
+		    svsk->sk_xprt.xpt_server->sv_max_mesg)
+			goto err_too_large;
 	}
-
 	return svc_sock_reclen(svsk);
-error:
-	dprintk("RPC: TCP recv_record got %d\n", len);
-	return len;
-err_delete:
+
+err_too_large:
+	net_notice_ratelimited("svc: %s %s RPC fragment too large: %d\n",
+			       __func__, svsk->sk_xprt.xpt_server->sv_name,
+			       svc_sock_reclen(svsk));
 	set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
+err_short:
 	return -EAGAIN;
 }
 
@@ -961,12 +959,13 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		test_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags),
 		test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags));
 
-	len = svc_tcp_recv_record(svsk, rqstp);
+	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+	len = svc_tcp_read_marker(svsk, rqstp);
 	if (len < 0)
 		goto error;
 
 	base = svc_tcp_restore_pages(svsk, rqstp);
-	want = svc_sock_reclen(svsk) - (svsk->sk_tcplen - sizeof(rpc_fraghdr));
+	want = len - (svsk->sk_tcplen - sizeof(rpc_fraghdr));
 
 	vec = rqstp->rq_vec;
 

