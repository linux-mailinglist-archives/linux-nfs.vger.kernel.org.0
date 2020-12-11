Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A242D822C
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 23:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406961AbgLKWe1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 17:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406925AbgLKWd6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Dec 2020 17:33:58 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB127C061793
        for <linux-nfs@vger.kernel.org>; Fri, 11 Dec 2020 14:33:17 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n142so10073409qkn.2
        for <linux-nfs@vger.kernel.org>; Fri, 11 Dec 2020 14:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7j8nn1wrgW8FFlMLOMQLivQGAidFgYO4bsQnfHsqrSE=;
        b=TZUGochJPSWiALF4mZn53blPK0zbUqvm0smI7D4XAxt3B2fVJuvOysyLTrPsoxTaG2
         vAleaw9vSiOL1hDRhnCl7K4Gc1eJ+pXp8hZ7ll4l0tsp14XRMeyxgMFsHMkbTPICxSM7
         N0D5s782/vUEJX2CqWQyg8WtHyXVqCEPlh585SxZCSIlQ96nf6cgS5isxi3KrL41q8Ry
         HwnmQptCuiH1FJKa9EIVaIcqcgVRQymS/Xv2DjWWHdVUb2J6bDj6iqgauSv08uiCyW9b
         ZnElQ2XN45QD0rvrQqxYjrPQ5V1nAqMOsBGorCXHY6u9mbYL0DFI+VCbJXzm/y4IJ1LZ
         z2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7j8nn1wrgW8FFlMLOMQLivQGAidFgYO4bsQnfHsqrSE=;
        b=YAgiWN6W2PyRdWfQgOMdBYWCsQUt/xsjCgRLQH3K8QgG8NoYt+3seNvUxHWu/oRfV+
         mk/dE48go3WBy0UrEFsLoM4EJMrcfG24JJRAX4dQZ9HBHeG4iVJ8YQKE+ZcTLhAVOBJ3
         7GH5n/LE2bh/Ch9AKeXBRtN6RODOK1SRG+bDIBZXcZ1UIZsTSBjvJ62gR5uAKEnJjtLJ
         rV130kHVuRQ2eimlxJrBcRlnsPaaxOG+S77oOJpgY292r1MsLXQn/DelDfY0Wp51Drta
         JjQZd8Ub/dWc8P/QP9DKyDVU0fByERUmSw9GwFUwX8BrGrpxSyx/Qi0SwjmXPCEOBKdK
         WJIg==
X-Gm-Message-State: AOAM533+GTmDFqJiiat6ejvb3/ilbsptQnJ5vemQs4tgriJ74mCEKvJc
        xRz4rx7sV1iH6D7gvlNyZg+hQOv1Ngo=
X-Google-Smtp-Source: ABdhPJxZQOT8aEHBqXwzaauit+fu1qKTl3XpKqKQfbjqF4m6vETPMlPyxoa7sj5UE1FNyZpYr1BIVQ==
X-Received: by 2002:a05:620a:4db:: with SMTP id 27mr2295824qks.431.1607725996469;
        Fri, 11 Dec 2020 14:33:16 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i24sm8300811qkl.121.2020.12.11.14.33.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 14:33:15 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0BBMXDPF026794
        for <linux-nfs@vger.kernel.org>; Fri, 11 Dec 2020 22:33:13 GMT
Subject: [PATCH RFC] SUNRPC: Handle TCP socket sends with kernel_sendpage()
 again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 11 Dec 2020 17:33:13 -0500
Message-ID: <160772591937.2046.18355802579143636131.stgit@klimt.1015granger.net>
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

No Fixes: tag. If needed, please backport this fix by hand.

Reported-by: Daire Byrne <daire@dneg.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209439
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)


This replaces the SVC zero-copy send patch I posted a couple of
weeks ago.


diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index b248f2349437..30332111bd37 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1062,6 +1062,92 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	return 0;	/* record not complete */
 }
 
+/**
+ * svc_tcp_sendmsg - Send an RPC message on a TCP socket
+ * @sock: socket to write the RPC message onto
+ * @xdr: XDR buffer containing the RPC message
+ * @marker: TCP record marker
+ * @sentp: OUT: number of bytes actually written
+ *
+ * Caller serializes calls on this @sock, and ensures the pages
+ * backing @xdr are unchanging. In addition, it is assumed that
+ * no .bv_len is larger than PAGE_SIZE.
+ *
+ * Returns zero on success or a negative errno value.
+ */
+static int svc_tcp_sendmsg(struct socket *sock, const struct xdr_buf *xdr,
+			   rpc_fraghdr marker, unsigned int *sentp)
+{
+	struct kvec vec[2] = {
+		[0] = {
+			.iov_base	= &marker,
+			.iov_len	= sizeof(marker),
+		},
+		[1] = *xdr->head,
+	};
+	size_t len = vec[0].iov_len + vec[1].iov_len;
+	const struct kvec *tail = xdr->tail;
+	struct msghdr msg = {
+		.msg_flags	= 0,
+	};
+	int ret;
+
+	*sentp = 0;
+
+	/*
+	 * Optimized for the common case where we have just the record
+	 * marker and xdr->head.
+	 */
+	if (xdr->head[0].iov_len < xdr->len)
+		msg.msg_flags = MSG_MORE;
+	iov_iter_kvec(&msg.msg_iter, WRITE, vec, ARRAY_SIZE(vec), len);
+	ret = sock_sendmsg(sock, &msg);
+	if (ret < 0)
+		return ret;
+	*sentp += ret;
+	if (*sentp != len)
+		goto out;
+
+	if (xdr->page_len) {
+		unsigned int offset, len, remaining;
+		struct bio_vec *bvec;
+		int flags, ret;
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
+						bvec->bv_offset + offset,
+						len, flags);
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
+		ret = kernel_sendpage(sock, virt_to_page(tail->iov_base),
+				      offset_in_page(tail->iov_base),
+				      tail->iov_len, 0);
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
@@ -1078,18 +1164,16 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	struct xdr_buf *xdr = &rqstp->rq_res;
 	rpc_fraghdr marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
 					 (u32)xdr->len);
-	struct msghdr msg = {
-		.msg_flags	= 0,
-	};
 	unsigned int sent;
 	int err;
 
 	svc_tcp_release_rqst(rqstp);
+	xdr_alloc_bvec(xdr);
 
 	mutex_lock(&xprt->xpt_mutex);
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
-	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, marker, &sent);
+	err = svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
 	xdr_free_bvec(xdr);
 	trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))


