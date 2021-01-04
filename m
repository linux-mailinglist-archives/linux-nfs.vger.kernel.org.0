Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380642E950A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 13:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhADMkS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 07:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhADMkS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 07:40:18 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783BC061793
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 04:39:37 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id l14so12873265qvh.2
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 04:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JlvvbWBytRh5WPvfvyxZhVgZf5+c7x0Je+YdBkDL2CU=;
        b=gNcSJ2/9hHReEpHQqTXpGtLi0xk7SAHLRoANi4hAKsvqhF8DkoY1ggJDSaoAS83XnO
         V7cbJkb6Ud+LkBxE7Xr5wUctPFijEhX6PJ+xabjrRVDh1nGU02kNQTCXNfRbwLor6KJj
         NJpGk0Wsxx8uvqarbWeHp66FzbLoiall9ZcWboyf+kAL269pxERxq+T/tBX6SjZhjRQ1
         I/m2KKLyD7S5UX42tB9Kym7KWvjcq4OscQ0GkwOD95nlWTOuGVciOe9KYgD9eWhHfZlp
         YH+g5tLoO9vecMouNcRSEMjk4Z4UacnCcUIcXpOI02Thw9kUOeH4P4tpLoFrmy+O/57L
         RkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JlvvbWBytRh5WPvfvyxZhVgZf5+c7x0Je+YdBkDL2CU=;
        b=L1GmnvMBs2Q0D6c4bu162HzOBN9aOxk6y4LkkaHT+rPEJakDwvoSAUXMcUBP02YegG
         dpGIyWT57/hYpH0n+Y6DqR/vbQJNrn+ro7LZLgrEpUIQTmQxe0aE9ajkj0b+VGuxbTYJ
         yhGpUYOOogOSfmr4GRYNoCkeavWfyeKikryu9CPCO02yNYUGL4XQ05KFiYGZJHJiCMxn
         OI2s/nyIUVrz4Yh/f1PAWdz7HDeOYht7Qk5Cb1nG2kLGBRWb7GEWnYXKkKxFugBcKWwG
         MfNdBfDNmcfco7gzWQUd9Km2CKdedk8SKb1hg3DWzHnO9rtjagql+zuAsE7pal6wQR4p
         BW0g==
X-Gm-Message-State: AOAM531H92ZtnjL2XsLABefxpNV6vsImxW2NY4mzMoYjmjAIpsBfkUiK
        Bxdga35mW57Vgql/bDqMr6FmPx6fIXY=
X-Google-Smtp-Source: ABdhPJyW8Lnzjx7SEikv2rY4qz1zs4q9+IMtTJse7nAYHxBiC7yXdAHvbJKBqFyXkN01pWWbEDTrMg==
X-Received: by 2002:a05:6214:321:: with SMTP id j1mr77184714qvu.32.1609763976293;
        Mon, 04 Jan 2021 04:39:36 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o20sm18464390qki.93.2021.01.04.04.39.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 04:39:35 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 104CdY7S017689
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jan 2021 12:39:34 GMT
Subject: [PATCH v2] SUNRPC: Handle TCP socket sends with kernel_sendpage()
 again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Jan 2021 07:39:34 -0500
Message-ID: <160976386859.1186.3313043730306558069.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Daire Byrne reports a ~50% aggregrate throughput regression on his
Linux NFS server after commit da1661b93bf4 ("SUNRPC: Teach server to
use xprt_sock_sendmsg for socket sends"), which replaced
kernel_send_page() calls in NFSD's socket send path with calls to
sock_sendmsg() using iov_iter.

Investigation showed that tcp_sendmsg() was not using zero-copy to
send the xdr_buf's bvec pages, but instead was relying on memcpy.
This means copying every byte of a large NFS READ payload.

It looks like TLS sockets do indeed support a ->sendpage method,
so it's really not necessary to use xprt_sock_sendmsg() to support
TLS fully on the server. A mechanical reversion of da1661b93bf4 is
not possible at this point, but we can re-implement the server's
TCP socket sendmsg path using kernel_sendpage().

Reported-by: Daire Byrne <daire@dneg.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209439
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

Hi-

I intend to include this fix in the first NFSD v5.11-rc pull request.

Changes since v1:
- Further testing and code clean up


diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index b248f2349437..c9766d07eb81 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1062,6 +1062,90 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	return 0;	/* record not complete */
 }
 
+static int svc_tcp_send_kvec(struct socket *sock, const struct kvec *vec,
+			      int flags)
+{
+	return kernel_sendpage(sock, virt_to_page(vec->iov_base),
+			       offset_in_page(vec->iov_base),
+			       vec->iov_len, flags);
+}
+
+/*
+ * kernel_sendpage() is used exclusively to reduce the number of
+ * copy operations in this path. Therefore the caller must ensure
+ * that the pages backing @xdr are unchanging.
+ *
+ * In addition, the logic assumes that * .bv_len is never larger
+ * than PAGE_SIZE.
+ */
+static int svc_tcp_sendmsg(struct socket *sock, struct msghdr *msg,
+			   struct xdr_buf *xdr, rpc_fraghdr marker,
+			   unsigned int *sentp)
+{
+	const struct kvec *head = xdr->head;
+	const struct kvec *tail = xdr->tail;
+	struct kvec rm = {
+		.iov_base	= &marker,
+		.iov_len	= sizeof(marker),
+	};
+	int flags, ret;
+
+	*sentp = 0;
+	xdr_alloc_bvec(xdr, GFP_KERNEL);
+
+	msg->msg_flags = MSG_MORE;
+	ret = kernel_sendmsg(sock, msg, &rm, 1, rm.iov_len);
+	if (ret < 0)
+		return ret;
+	*sentp += ret;
+	if (ret != rm.iov_len)
+		return -EAGAIN;
+
+	flags = head->iov_len < xdr->len ? MSG_MORE | MSG_SENDPAGE_NOTLAST : 0;
+	ret = svc_tcp_send_kvec(sock, head, flags);
+	if (ret < 0)
+		return ret;
+	*sentp += ret;
+	if (ret != head->iov_len)
+		goto out;
+
+	if (xdr->page_len) {
+		unsigned int offset, len, remaining;
+		struct bio_vec *bvec;
+
+		bvec = xdr->bvec;
+		offset = xdr->page_base;
+		remaining = xdr->page_len;
+		flags = MSG_MORE | MSG_SENDPAGE_NOTLAST;
+		while (remaining > 0) {
+			if (remaining <= PAGE_SIZE && tail->iov_len == 0)
+				flags = 0;
+			len = min(remaining, bvec->bv_len);
+			ret = kernel_sendpage(sock, bvec->bv_page,
+					      bvec->bv_offset + offset,
+					      len, flags);
+			if (ret < 0)
+				return ret;
+			*sentp += ret;
+			if (ret != len)
+				goto out;
+			remaining -= len;
+			offset = 0;
+			bvec++;
+		}
+	}
+
+	if (tail->iov_len) {
+		ret = svc_tcp_send_kvec(sock, tail, 0);
+		if (ret < 0)
+			return ret;
+		*sentp += ret;
+	}
+
+out:
+	return 0;
+}
+
 /**
  * svc_tcp_sendto - Send out a reply on a TCP socket
  * @rqstp: completed svc_rqst
@@ -1089,7 +1173,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	mutex_lock(&xprt->xpt_mutex);
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
-	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, marker, &sent);
+	err = svc_tcp_sendmsg(svsk->sk_sock, &msg, xdr, marker, &sent);
 	xdr_free_bvec(xdr);
 	trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))


