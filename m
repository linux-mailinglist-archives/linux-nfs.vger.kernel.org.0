Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3269B4BBA6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFSOd2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:33:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45231 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOd2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:33:28 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so38514369ioc.12;
        Wed, 19 Jun 2019 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=koG2EsMmlf+xVAb4ZuLOBGkCW9y4MVd3Be2orz7yqDg=;
        b=PjZut4WISpKj9swqYaA8aPXTDSRdFb7PV5+g3jwLqYv3KEkhjlCl20M4/l9AjzKc67
         D7jwYF4DRdxyA+7ziQODUgVxYsSeKDNHQXmq998jGJZsZR81eQsnTpgQcSJEoGhmDfij
         u7eBoU+QdMEhSaLdnhFjhj8wCnyJD+3yrQND1saIUmFPCHvTemlNhHTHTu0KFQilORCV
         u6ftvrtDguPcgAFcoHzmEHlCeZF5A4YJHeabg3tpHGp4jNscxk5mNpIv9PBDYDjBZSsp
         1w5/aAZR4roYcYGHpvCUZRjsuz4uOJ2lbEMXKHEN2h0rDDnm4HU63xRLmGs66nSOdoMn
         qwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=koG2EsMmlf+xVAb4ZuLOBGkCW9y4MVd3Be2orz7yqDg=;
        b=Q5nZIVXSTAWZXL2q7AIg/8ObOIqVLbhdlgCuJpgJC6Zaa6Lwqe7Yg36LKpw5s+ijXC
         xy5sHIjpX0dj1fmwaOMmJbOTm+lh586ZkCgz+iN4/yto15cQisB4mJBSY9NArbynmHMx
         EUCDp9Waq+7wUG9pfC5RQz9kqu2ehuGBOvLFAU06tme9S/HDJ9kGS7On961Xv5zVFtQ1
         LRsoj/NxyjsTFx6I9cmBEDRaa9qi3YBdcz+ZcQZwWlpttumJF8tGsqjtAwr0SALejm3i
         5kowE4mLCSZKQL+wlwlTej7IfLpivHgCCRGMGkx6lEivWnyQ1Tq7Euhfwj9s/k/Px0Xl
         tYPQ==
X-Gm-Message-State: APjAAAV4m8vUKsu2y8Ng603A38Ro8eSDWUkjchQAuxwAwsDPh0szSYGa
        GEsjfjT0c0shqyfQZsy9eCE=
X-Google-Smtp-Source: APXvYqxZOk1a9zT4R+jxuqZqHKrlRp7j9vt7v5/Cgqa+qg10V+2ARKtaErLhY7ES+9+AHvUqX2FTOA==
X-Received: by 2002:a02:4e05:: with SMTP id r5mr11502027jaa.27.1560954807262;
        Wed, 19 Jun 2019 07:33:27 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s2sm13077547ioj.8.2019.06.19.07.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:26 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEXQYx004524;
        Wed, 19 Jun 2019 14:33:26 GMT
Subject: [PATCH v4 11/19] xprtrdma: Streamline rpcrdma_post_recvs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:33:26 -0400
Message-ID: <20190619143326.3826.30043.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
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

