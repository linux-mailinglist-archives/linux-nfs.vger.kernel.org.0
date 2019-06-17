Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED17D48741
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfFQPca (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:32:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35017 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPca (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:32:30 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so22196814ioo.2;
        Mon, 17 Jun 2019 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=koG2EsMmlf+xVAb4ZuLOBGkCW9y4MVd3Be2orz7yqDg=;
        b=QUNv8nx0xTUziNQ/NDXBEgguj0N1R56ZaIVJOE3SJOdq2JEtKi1EUPbnomXpluOiJS
         Z5Qsttbmht4cUrvaeMSPLthA7gWGiStl8BMPEjhnDYT+xOFUFGKQLbODnlf/AUW2GSGZ
         Q25vfyNdYHBtUt+mxpq9zI1Gt0yGJ8EX8od1727armFCm2Ya69QbxYFJ+ln5FDJAS0ZK
         7rffn8xABMdLhDlt9S65BjOHyz7hja9GC3U4eBQ3FbDcHksg8jwsrhWd5vw23kcAl9y2
         XAojb8Bjxs8WLy3LP+4kDMCAfJL6S4OkJW6nxY+Nj6CY6dSy/V7NUgcNM7WXHtrN2YF6
         KLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=koG2EsMmlf+xVAb4ZuLOBGkCW9y4MVd3Be2orz7yqDg=;
        b=SFQxjjvWLcvdQDLgj0yszYlGer6ho+6CBNelvLxJ+mQWCpkAc+EpMLpOe7+RvQd+iZ
         Q0dBUmXT1dVBPu0Mdn5hUsalASGuLEAmeZItl8zQvBkRY+fKuTJY/Iy7spYxjIaxR0Gl
         p10DMmIAJw314GLahTw1KdOG8Bx1WE6oWcWcF0uIAROF6Ov5tLe89fszVT7zgwLVJ8Al
         th28JouIngqY3wZoMLyfkndZlbQ8arqrUr1B6aimy6XDZf5jVA+kl4JHzBqmZxeSPHFH
         sB8ghAK1nZ0tWJz7kcBAh7tmtPzC++YLryqNbA+Auj3O5omLfbLQSiAWIwFdIQOhgq6e
         8YQw==
X-Gm-Message-State: APjAAAV0cHNnhy+Q35sLudbX46obvB1/2ICGqz+/GkpiQ9j2wHKrC7Zk
        20Af4Q3aFHFXjZK/clK1KKA=
X-Google-Smtp-Source: APXvYqxix2LwSOaO1slj3AMtSsa91AXjl7ugsqRYnfvupeVz0X2MXodoJW6coS/nfpnnLkIDu8PJ4g==
X-Received: by 2002:a6b:d008:: with SMTP id x8mr17693673ioa.129.1560785549598;
        Mon, 17 Jun 2019 08:32:29 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o7sm10224961ioo.81.2019.06.17.08.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:32:29 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFWSXG031218;
        Mon, 17 Jun 2019 15:32:28 GMT
Subject: [PATCH v3 11/19] xprtrdma: Streamline rpcrdma_post_recvs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:32:28 -0400
Message-ID: <20190617153228.12090.77374.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rb_lock is contended between rpcrdma_buffer_create,
rpcrdma_buffer_put, and rpcrdma_post_recvs.

Commit e340c2d6ef2a ("xprtrdma: Reduce the doorbell rate (Receive)")
causes rpcrdma_post_recvs to take the rb_lock repeatedly when it
determines more Receives are needed. Streamline this code path so
it takes the lock just once in most cases to build the Receive
chain that is about to be posted.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   59 ++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index de6be10..3270c8a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1478,11 +1478,13 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct ib_recv_wr *wr, *bad_wr;
+	struct ib_recv_wr *i, *wr, *bad_wr;
+	struct rpcrdma_rep *rep;
 	int needed, count, rc;
 
 	rc = 0;
 	count = 0;
+
 	needed = buf->rb_credits + (buf->rb_bc_srv_max_requests << 1);
 	if (ep->rep_receive_count > needed)
 		goto out;
@@ -1490,39 +1492,48 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 	if (!temp)
 		needed += RPCRDMA_MAX_RECV_BATCH;
 
-	count = 0;
+	/* fast path: all needed reps can be found on the free list */
 	wr = NULL;
+	spin_lock(&buf->rb_lock);
 	while (needed) {
-		struct rpcrdma_rep *rep;
-
-		spin_lock(&buf->rb_lock);
 		rep = list_first_entry_or_null(&buf->rb_recv_bufs,
 					       struct rpcrdma_rep, rr_list);
-		if (likely(rep))
-			list_del(&rep->rr_list);
-		spin_unlock(&buf->rb_lock);
-		if (!rep) {
-			rep = rpcrdma_rep_create(r_xprt, temp);
-			if (!rep)
-				break;
-		}
+		if (!rep)
+			break;
 
-		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
-			rpcrdma_recv_buffer_put(rep);
+		list_del(&rep->rr_list);
+		rep->rr_recv_wr.next = wr;
+		wr = &rep->rr_recv_wr;
+		--needed;
+	}
+	spin_unlock(&buf->rb_lock);
+
+	while (needed) {
+		rep = rpcrdma_rep_create(r_xprt, temp);
+		if (!rep)
 			break;
-		}
 
-		trace_xprtrdma_post_recv(rep->rr_recv_wr.wr_cqe);
 		rep->rr_recv_wr.next = wr;
 		wr = &rep->rr_recv_wr;
-		++count;
 		--needed;
 	}
-	if (!count)
+	if (!wr)
 		goto out;
 
+	for (i = wr; i; i = i->next) {
+		rep = container_of(i, struct rpcrdma_rep, rr_recv_wr);
+
+		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
+			goto release_wrs;
+
+		trace_xprtrdma_post_recv(rep->rr_recv_wr.wr_cqe);
+		++count;
+	}
+
 	rc = ib_post_recv(r_xprt->rx_ia.ri_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
+out:
+	trace_xprtrdma_post_recvs(r_xprt, count, rc);
 	if (rc) {
 		for (wr = bad_wr; wr;) {
 			struct rpcrdma_rep *rep;
@@ -1534,6 +1545,12 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 		}
 	}
 	ep->rep_receive_count += count;
-out:
-	trace_xprtrdma_post_recvs(r_xprt, count, rc);
+	return;
+
+release_wrs:
+	for (i = wr; i;) {
+		rep = container_of(i, struct rpcrdma_rep, rr_recv_wr);
+		i = i->next;
+		rpcrdma_recv_buffer_put(rep);
+	}
 }

