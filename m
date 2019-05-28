Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32672CE81
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfE1SVq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:21:46 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34094 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfE1SVq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:21:46 -0400
Received: by mail-it1-f196.google.com with SMTP id g23so3327378iti.1;
        Tue, 28 May 2019 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VkIQGynJzS6VoI5SV8mWOm9mNwDUXUQEwJkQa0bOUmI=;
        b=h2Y9b1S+B+fXqtSDQmd1IgwdrY8QdTg6Luytwa7KbZgCgoSlbD2PY5xzsGmfuuEKnG
         mkX26Hky+CXx1Nej+ZSd9S0340Ec2qxojz5OQmU1UotZto1ZybsNADi1kTNrYepk5q+u
         qzMPk2b5CPM9u3WGd1psRzrN70O90TA81iFQ1HRWOW7UoMFeOS/MGzJGag8d9Zhr8hxH
         BAhLmVzk9VGHtkcq6+1M4f9JKn+GuN2ouPDpkVVMA22pj5p63qVHPlMlP9WxeCE3WoJ8
         nsChdfOnqhJZaW4sRWuxmZrHwacETB6Fu+nPKocbouS0HOBL1Xd0fyJsPJg/tc5C7CL+
         LejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=VkIQGynJzS6VoI5SV8mWOm9mNwDUXUQEwJkQa0bOUmI=;
        b=dxfDmbL7yVpiCqqxbSUnzTiikvuV00/tbIM6b8X0nPQpln2rjeMmAWjO7kZ8wS5rfv
         7tBEgTO+DYOGDrccMqAEwg4hgQPX5dgH7Mh2gfW7JeMadZlYOPewTLL4h48kxbSJ9PXe
         uBYfT6gvjEn2G1807OO2gMiaNxnDBxX2BxLLoTLOy9QdvijMYHUA+TeGaorucnLAq1cG
         boHjDeqAYIQS26TVoUj4kYExShesG4Av+FSm1NhsYnANWstZ8z+7WWEPuohG35hy5Oou
         PkuLFMriuB9yoV5pvdpWEjdORWYC0iTdszdDd7YDI8Gt1i3PCZBB5sdoRIvfxTIAtGxG
         I1SA==
X-Gm-Message-State: APjAAAXdEcT5Im1S8Yo6T63fIBhwee8CtLYHklmNxTDW8bPxWeOZ5aDp
        7zhgKj430DSvRd2V9MeETxRZWsoV
X-Google-Smtp-Source: APXvYqxj/otpynpxqc0ItJdAVvNsAovYSUWlMKcimhZahXK4aOVe9szkNTu+IG4thx1LSe2bET9s/w==
X-Received: by 2002:a24:688a:: with SMTP id v132mr823471itb.31.1559067704667;
        Tue, 28 May 2019 11:21:44 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s2sm456129ioj.8.2019.05.28.11.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:21:44 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SILhSF014543;
        Tue, 28 May 2019 18:21:43 GMT
Subject: [PATCH RFC 10/12] xprtrdma: Streamline rpcrdma_post_recvs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:21:43 -0400
Message-ID: <20190528182143.19012.75326.stgit@manet.1015granger.net>
In-Reply-To: <20190528181018.19012.61210.stgit@manet.1015granger.net>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
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
index 390c3bc..cc1fdca 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1479,11 +1479,13 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
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
@@ -1491,39 +1493,48 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
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
@@ -1535,6 +1546,12 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
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

