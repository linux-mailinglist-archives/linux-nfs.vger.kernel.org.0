Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D312FAF3
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgACQ5M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:57:12 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44422 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgACQ5M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:57:12 -0500
Received: by mail-yw1-f68.google.com with SMTP id t141so18745569ywc.11;
        Fri, 03 Jan 2020 08:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2Q2YPq+rSLrKcR+aFtKjbLTauVxcEyEoCr3Nslf/jTc=;
        b=IeMU7q1G1vhhLg/HXZ27mTcV/Oq3BvsOgOUQ2trLI+7HLpSZklrNgTl/oTfd9mRaLC
         rhdsxaSV7TW2boIfupIY1Hzs9MlIl4og16H2JOTZLWIkNWEu81jSb+EUegFYV3h5EyP5
         5q7XoQZlFAAfe5GR4f348v/c19JYJLBvnpXTTSgaedezR1ZGwTI+7w0Fcv5r3viXkM3s
         HfKGOWHHxmVFy2J4jVVXWVtExC0uSZbLCC+Uy0d/hxxKH6jfkJCu6JkUN4C0U1tP0aIV
         YlGcjWK7wmVGmE0qyLIYkwf++e1gyu1jZy2uL6Ig5GwofDLOT5GDUgABfAukZE1LTt+3
         fyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2Q2YPq+rSLrKcR+aFtKjbLTauVxcEyEoCr3Nslf/jTc=;
        b=IZsMdgX2yfEH+Xu372ePRRZuV7i/xXspMn8NWVYppGnVWQpkWl9uAmZHRVn8MeFWTh
         hrgx744SH+jcIEu3tkE8MdhptT0hhcAKheXclgXm4y4GNTT7uRnIL+WhMf5UYMqJP7l2
         cp+pZk1s0s0L8YSJoiNP2/mseKmPA43rrB87xWbD1myGSrlr7BdHWt93jfHrP/MnV5WC
         0tMnVQQ0sJF1uCJfIqLQjMJDmzZ/kKIozE4+lhlo78XmEK7+SONNCm1khvJG5p6zJBCI
         hWEkSpPNrg/S/PEys1o/k48ppefTDh8G5f3QY5nQay1uYCQXUrJpf/tl8VaRwXzz05st
         bSUQ==
X-Gm-Message-State: APjAAAWX8l9d+WiiVg+3vT0ubRSIp8OXALpCOmmnrdCjZs47nx6RtLn6
        7M+UdOPccvg5S1N1g9lgEeukZeJj
X-Google-Smtp-Source: APXvYqxHDnZoKxLEQC1+lhiHx0wNMD2on4pKiOk0U9z2qcCrZHQF84vjLgr14rk6/lG4QiS89KZBNA==
X-Received: by 2002:a81:a906:: with SMTP id g6mr56576219ywh.186.1578070630736;
        Fri, 03 Jan 2020 08:57:10 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 189sm24351008ywc.16.2020.01.03.08.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:57:10 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003Gv9F1016407;
        Fri, 3 Jan 2020 16:57:09 GMT
Subject: [PATCH v1 9/9] xprtrdma: DMA map rr_rdma_buf as each rpcrdma_rep is
 created
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:57:09 -0500
Message-ID: <157807062944.4606.8470156130970554891.stgit@morisot.1015granger.net>
In-Reply-To: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
References: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: This simplifies the logic in rpcrdma_post_recvs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3169887f8547..c3e92b5607b5 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1109,8 +1109,9 @@ static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt)
 /* No locking needed here. This function is called only by the
  * Receive completion handler.
  */
-static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
-					      bool temp)
+static noinline
+struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
+				       bool temp)
 {
 	struct rpcrdma_rep *rep;
 
@@ -1123,6 +1124,9 @@ static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	if (!rep->rr_rdmabuf)
 		goto out_free;
 
+	if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
+		goto out_free_regbuf;
+
 	xdr_buf_init(&rep->rr_hdrbuf, rdmab_data(rep->rr_rdmabuf),
 		     rdmab_length(rep->rr_rdmabuf));
 	rep->rr_cqe.done = rpcrdma_wc_receive;
@@ -1135,6 +1139,8 @@ static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	list_add(&rep->rr_all, &r_xprt->rx_buf.rb_all_reps);
 	return rep;
 
+out_free_regbuf:
+	rpcrdma_regbuf_free(rep->rr_rdmabuf);
 out_free:
 	kfree(rep);
 out:
@@ -1536,7 +1542,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct ib_recv_wr *i, *wr, *bad_wr;
+	struct ib_recv_wr *wr, *bad_wr;
 	struct rpcrdma_rep *rep;
 	int needed, count, rc;
 
@@ -1563,23 +1569,15 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 		if (!rep)
 			break;
 
+		trace_xprtrdma_post_recv(rep);
 		rep->rr_recv_wr.next = wr;
 		wr = &rep->rr_recv_wr;
 		--needed;
+		++count;
 	}
 	if (!wr)
 		goto out;
 
-	for (i = wr; i; i = i->next) {
-		rep = container_of(i, struct rpcrdma_rep, rr_recv_wr);
-
-		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
-			goto release_wrs;
-
-		trace_xprtrdma_post_recv(rep);
-		++count;
-	}
-
 	rc = ib_post_recv(r_xprt->rx_ia.ri_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
 out:
@@ -1596,11 +1594,4 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	}
 	ep->rep_receive_count += count;
 	return;
-
-release_wrs:
-	for (i = wr; i;) {
-		rep = container_of(i, struct rpcrdma_rep, rr_recv_wr);
-		i = i->next;
-		rpcrdma_recv_buffer_put(rep);
-	}
 }


