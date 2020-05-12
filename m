Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2701D00C2
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgELVXw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731308AbgELVXw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:52 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EACCC061A0C;
        Tue, 12 May 2020 14:23:52 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o19so886881qtr.10;
        Tue, 12 May 2020 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mEbGapYI4L5VEY7chiiFIUuJ8+Vvzo9WpaWDp1wo7qY=;
        b=ghCZPXLSnNu26vGYXtbBM7/0VSJgDYAFxNyr41r9Fqi5Y+CmDdIQ5e26kCdlx8lxmF
         20Pea9yFZSlpw/n8bsmxf5YqqEWFFyy21N+K64PwD3fTA4WEWPiuBru1wWY4uAsauuWF
         MyWk6jInU1ekPmjxH5VW5JmIkCLKx1sL5ijjZbJW1V2gGUW9v6ZUewWbx8+uQyRLfndr
         l5v0h52YIm26u09zM3CVWkg69B8fSyIqqhs3zCzOt3krgVOph1UaYRMnnR/3Tqj+cGpx
         zUHMlfmej3yyP0MKg5/Ft9J4/XXo/9O6dIbQQe0a+IvNODo7D1P/BZk5VZHVbeWOvWH6
         kCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mEbGapYI4L5VEY7chiiFIUuJ8+Vvzo9WpaWDp1wo7qY=;
        b=tKp8pzZVW2tcVt6yh7jUbomA+5ubzYKBnmV4agK5bc036LnLdUdoef4NdIdTOwbZDR
         x1gdoe9uIVjJ3nwl2DrSswNgu+Dfmq8cC/w1zlrZbow/HqFqc9R3shHgLmCIiQI12976
         5aS3M32jXxG54fiv89zAHnElwvYNmwVFnHU04k2p0HwAiKCj1d65s+6qf5pvZXU6Di1p
         se/DULk7qb/zer5MovU7y2Y7RZG0eHrGJIZz+16PoMRQJevGyowZtJ0P68JUBrTS02eX
         k5J7PhcqWdpA3ZdA8/Sn1K9UKVGd9WQtzQAhpMV2gx6aVpgry7QGUdthW7/z2GW23IPv
         1+ZA==
X-Gm-Message-State: AGi0PuYmXPtVrQqwNd5czosB4iodu7kd7xwZ/0/W0gL+mtr1U7mNNRW7
        J51mF498ba2r0LVWqWXU5yUWVplW
X-Google-Smtp-Source: APiQypKVm/rJTzdSQSeUs6sg84W6RxcbdRhGCDZZgEt+Bin+/PsPrpBGL2XuIyY0igv5XIHji6Wilw==
X-Received: by 2002:ac8:380d:: with SMTP id q13mr12091446qtb.200.1589318631330;
        Tue, 12 May 2020 14:23:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c24sm10593361qtd.26.2020.05.12.14.23.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:23:50 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLNosE009936;
        Tue, 12 May 2020 21:23:50 GMT
Subject: [PATCH v2 20/29] SUNRPC: Restructure svc_tcp_recv_record()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:23:50 -0400
Message-ID: <20200512212350.5826.96262.stgit@klimt.1015granger.net>
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
index 6d85bbb7b8b1..ec4ae34a1f84 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1443,6 +1443,30 @@ TRACE_EVENT(svcsock_new_socket,
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
 

