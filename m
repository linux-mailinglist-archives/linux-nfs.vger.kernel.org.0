Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287D76C14A3
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCTOYi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjCTOYh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB0125AD
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C648B61543
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F933C43321;
        Mon, 20 Mar 2023 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322275;
        bh=o9A+Iq6yVbV1oKdeKKQeRvCeMDAQxxL9ghMqcI/zDfI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PHAlx4VDbYQJSdf2V4w8H0S/81I6OxB9d1urLa2hKw2MFrj/e+MYsvZTJwqhWoF0h
         Y6t+tMkIQuQilCnJhorH8FZXfZNG8eFtymTvu//5AK/iqe0MygAiCeKijlynlo9x5V
         +l6JhXfbKjt57qENG7bPBjqSzwewd8oOVYz75VYDyuKeIOZVquyPkOHbTSwQx1yoyd
         yDFxG4P2s3WhIyZXb29XjhYAgL6p0rn6GrMGw1B/ZU7y2oxquvOcHEiefIdRXtQX9l
         iONldgytdetyp6AIdpGS34pP3OQz/iUDUdXIFgF7L3p8fDCM24olG8e2xe/8i6/2fJ
         wMYqof5MkWWWQ==
Subject: [PATCH RFC 2/5] SUNRPC: Recognize control messages in server-side TCP
 socket code
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Mon, 20 Mar 2023 10:24:34 -0400
Message-ID: <167932227406.3131.13458746441638824577.stgit@manet.1015granger.net>
In-Reply-To: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

To support kTLS, the server-side TCP socket code needs to watch for
CMSGs, just like on the client side.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   26 ++++++++++++++++++++++
 net/sunrpc/svcsock.c          |   49 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 280a31be3806..cf286a0a17d0 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2370,6 +2370,32 @@ DECLARE_EVENT_CLASS(svcsock_accept_class,
 DEFINE_ACCEPT_EVENT(accept);
 DEFINE_ACCEPT_EVENT(getpeername);
 
+TRACE_EVENT(svcsock_tls_ctype,
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		unsigned char ctype
+	),
+
+	TP_ARGS(xprt, ctype),
+
+	TP_STRUCT__entry(
+		SVC_XPRT_ENDPOINT_FIELDS(xprt)
+
+		__field(unsigned long, ctype)
+	),
+
+	TP_fast_assign(
+		SVC_XPRT_ENDPOINT_ASSIGNMENTS(xprt);
+
+		__entry->ctype = ctype;
+	),
+
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " %s",
+		SVC_XPRT_ENDPOINT_VARARGS,
+		rpc_show_tls_content_type(__entry->ctype)
+	)
+);
+
 DECLARE_EVENT_CLASS(cache_event,
 	TP_PROTO(
 		const struct cache_detail *cd,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 28deb4acc392..91a62bea6999 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -43,6 +43,7 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 #include <net/tcp_states.h>
+#include <net/tls.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 #include <asm/ioctls.h>
@@ -216,6 +217,50 @@ static int svc_one_sock_name(struct svc_sock *svsk, char *buf, int remaining)
 	return len;
 }
 
+static int
+svc_tcp_sock_process_cmsg(struct svc_sock *svsk, struct msghdr *msg,
+			  struct cmsghdr *cmsg, int ret)
+{
+	if (cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+		u8 content_type = *((u8 *)CMSG_DATA(cmsg));
+
+		trace_svcsock_tls_ctype(&svsk->sk_xprt, content_type);
+		switch (content_type) {
+		case TLS_RECORD_TYPE_DATA:
+			/* TLS sets EOR at the end of each application data
+			 * record, even though there might be more frames
+			 * waiting to be decrypted.
+			 */
+			msg->msg_flags &= ~MSG_EOR;
+			break;
+		case TLS_RECORD_TYPE_ALERT:
+			ret = -ENOTCONN;
+			break;
+		default:
+			ret = -EAGAIN;
+		}
+	}
+	return ret;
+}
+
+static int
+svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
+{
+	union {
+		struct cmsghdr	cmsg;
+		u8		buf[CMSG_SPACE(sizeof(u8))];
+	} u;
+	int ret;
+
+	msg->msg_control = &u;
+	msg->msg_controllen = sizeof(u);
+	ret = sock_recvmsg(svsk->sk_sock, msg, MSG_DONTWAIT);
+	if (unlikely(msg->msg_controllen != sizeof(u)))
+		ret = svc_tcp_sock_process_cmsg(svsk, msg, &u.cmsg, ret);
+	return ret;
+}
+
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 static void svc_flush_bvec(const struct bio_vec *bvec, size_t size, size_t seek)
 {
@@ -263,7 +308,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 		iov_iter_advance(&msg.msg_iter, seek);
 		buflen -= seek;
 	}
-	len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
+	len = svc_tcp_sock_recv_cmsg(svsk, &msg);
 	if (len > 0)
 		svc_flush_bvec(bvec, len, seek);
 
@@ -877,7 +922,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
-		len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
+		len = svc_tcp_sock_recv_cmsg(svsk, &msg);
 		if (len < 0)
 			return len;
 		svsk->sk_tcplen += len;


