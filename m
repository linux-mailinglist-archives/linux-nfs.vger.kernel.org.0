Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681C231CED5
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPRSK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 12:18:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhBPRSH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Feb 2021 12:18:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2CAF64DA1;
        Tue, 16 Feb 2021 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613495846;
        bh=B6tCooq2ymPux9vQhoH/1JULKQzCFAKDIEdLLkIgbFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=C5S9yBiu+GXaNcTS/3sL0H6ZlDgR75Fns6t9genDLxfBFw84Otw1nsl2DzBMUviqN
         ZsaEJnzPDn2MnhBXv11pHHSwVCUa9DtYZpNQCnCJqYMRKisy0ZnmR8gfFr76Ikwyys
         WN8S4nce9TUiZfW0f1GZGK+WNxDGIKW/kEgwIeY9kpsANBfrNnC9Mp92NejH/Mqqtm
         WpXIVFl7dzr2mhXjENfv8YVieTOnu7VZi8sH7EWYoMxfZPjH3Lg7NJMBxp39xdNrH/
         Bo+tocMUrx8Fgd4W6BWxnYhTx3nb0U6Thtci7O0Yt9qWfXY7XD3/3p9w0Z/fHjnKbH
         5uOT+LFL3g7mw==
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: Use TCP_CORK to optimise send performance on the server
Date:   Tue, 16 Feb 2021 12:17:22 -0500
Message-Id: <20210216171723.342274-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Use a counter to keep track of how many requests are queued behind the
xprt->xpt_mutex, and keep TCP_CORK set until the queue is empty.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/svcsock.h | 2 ++
 net/sunrpc/svcsock.c           | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index b7ac7fe68306..bcc555c7ae9c 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -35,6 +35,8 @@ struct svc_sock {
 	/* Total length of the data (not including fragment headers)
 	 * received so far in the fragments making up this rpc: */
 	u32			sk_datalen;
+	/* Number of queued send requests */
+	atomic_t		sk_sendqlen;
 
 	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
 };
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 5a809c64dc7b..231f510a4830 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1171,18 +1171,23 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 
 	svc_tcp_release_rqst(rqstp);
 
+	atomic_inc(&svsk->sk_sendqlen);
 	mutex_lock(&xprt->xpt_mutex);
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
+	tcp_sock_set_cork(svsk->sk_sk, true);
 	err = svc_tcp_sendmsg(svsk->sk_sock, &msg, xdr, marker, &sent);
 	xdr_free_bvec(xdr);
 	trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))
 		goto out_close;
+	if (atomic_dec_and_test(&svsk->sk_sendqlen))
+		tcp_sock_set_cork(svsk->sk_sk, false);
 	mutex_unlock(&xprt->xpt_mutex);
 	return sent;
 
 out_notconn:
+	atomic_dec(&svsk->sk_sendqlen);
 	mutex_unlock(&xprt->xpt_mutex);
 	return -ENOTCONN;
 out_close:
@@ -1192,6 +1197,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 		  (err < 0) ? err : sent, xdr->len);
 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
 	svc_xprt_enqueue(xprt);
+	atomic_dec(&svsk->sk_sendqlen);
 	mutex_unlock(&xprt->xpt_mutex);
 	return -EAGAIN;
 }
@@ -1261,7 +1267,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 		svsk->sk_datalen = 0;
 		memset(&svsk->sk_pages[0], 0, sizeof(svsk->sk_pages));
 
-		tcp_sk(sk)->nonagle |= TCP_NAGLE_OFF;
+		tcp_sock_set_nodelay(sk);
 
 		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 		switch (sk->sk_state) {
-- 
2.29.2

