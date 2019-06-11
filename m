Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686663D054
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbfFKPI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40602 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfFKPI7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:59 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so5289863itc.5;
        Tue, 11 Jun 2019 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=koG2EsMmlf+xVAb4ZuLOBGkCW9y4MVd3Be2orz7yqDg=;
        b=jRjw/KshT/mMmW/dSmzRCycBgiCzTHmUVEkS9XmLD3uMzG2fHp0Kh8cXineXkZbHES
         pxj/4Fv8rFPQfvFuSldubomgxXuQB0Ug5Ls1g1UWqJqNSb2gq2kKGgDeBScfBqvH8gt5
         7b+GTo/kmyHAqPxndxAQZNhYK1dFAHVRYfWURezgVWXXUG45rDCKrCPGC2QVCj5mLC3t
         mEzTwSDKJXR6ymQDxsXylx4FgZa6piI3hsihxRK68cPo5lpVPBgMupIrqP3Kq6pJ6fgx
         wg53aXnzc/L/VvTBYgG2KYKwEx86yvwipvizo/1UJJKiMc2v94fPo3TASVMcE5p8iXr1
         jqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=koG2EsMmlf+xVAb4ZuLOBGkCW9y4MVd3Be2orz7yqDg=;
        b=qFviDTU6QGlqmITZdJPBASmfwAgsHjOhW0Sc3Aqvawwe4VIBiU9er8musIsaPd4hdD
         b8h4CnT/ckMj+FTyX/a+qJ/FDU5j7jMKsfMLl1+jNEwKDaRGQMkqbKJBaHu0aBsxhzN+
         DX7UJmmDbe4zjK5sfwrT5MU9ypF7I/zaS7xenGTt+u0F9vrnj+K6jrxqpbfMhQ1s6o0j
         CMvhiP8/SzfD0ZSjvGBINz+1XHP94Uu7TEVUoqib7Pb4I3bmZZf9FVxoze5PN+aQaVik
         1CGj6SNIkzoAOwJLEiUpqNA+IsPr6u+47zr1Hd8mXPV2QNr0XIOhDDF70SU/WFDdn+lU
         CGew==
X-Gm-Message-State: APjAAAVZFXgS9jBIVcqOZ5rVe7Z6HblSefaNf/lhF0n98FqJMU3LNUC8
        o9XyohnAvbdzQ6dGi66KEWgCRzFZ
X-Google-Smtp-Source: APXvYqxS03St7MvVYRSY0KJH62n+BOi60LgrNHWiqrzXzj2N7UXwyA4x/cXl+pL5QHes5UUX4/dZEA==
X-Received: by 2002:a24:11d6:: with SMTP id 205mr8278652itf.132.1560265738157;
        Tue, 11 Jun 2019 08:08:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 203sm1419446ite.4.2019.06.11.08.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:08:57 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF8u8U021758;
        Tue, 11 Jun 2019 15:08:56 GMT
Subject: [PATCH v2 11/19] xprtrdma: Streamline rpcrdma_post_recvs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:08:56 -0400
Message-ID: <20190611150856.2877.50484.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
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

