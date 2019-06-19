Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5414BBA4
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfFSOdW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:33:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33955 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOdW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:33:22 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so8490920iot.1;
        Wed, 19 Jun 2019 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2pg29dnS4ttgMUR89dxmY66Tv7iksN4v374kY3+7sdc=;
        b=Uz/oGGUtbeMoAZmVYZjecIjR20teExYH1prGuDqru1ZvW5sqkUqEwcvbK1ZN4XgsbX
         yxUJ8hK3A0WqdYpq4laTeQLYqn/kmRm8Sl6uBqolUDpBFbCASb7F7x4Wmm6ZflkIVm52
         EU7S1In0a1OlaUS7s3Yx7FYTz0YNpchve1NDgcEUUwAU00vIiqMK8W7BNEYHF3t3Xwmo
         9qYaoihSqGGNTbJb6+7xxBnix2Gai4Ic0Pc+gRyYKst2iJRSLoDFyLC61ACX/HgPA8yI
         mn5okDYYgpj5PYdobTz73vpAa2I6vrg6mLEL8eD7oZG5X24/omSCrC1zJMiBxQ8vXxOV
         MkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2pg29dnS4ttgMUR89dxmY66Tv7iksN4v374kY3+7sdc=;
        b=mPBNCCYv56vsqbpsLxHrCZUalIqm9307UQpA4V2FPnyuoG1kete6HdDe8kSs9EQOOj
         XMDB2V0Fx2cQqp/FSx/iOj4L+F4I2JFUODAXA33A5YMgjIg5ZWniwVsHnNkc9hk5F8UZ
         GBYN8lc1Q+wjkQg1MMW5U/Bbv4ffqM3zo9ezQ4zZ1Umnz+sDyGvyalTWZImYNXjr2z+H
         I+YUgoncFn9f2V+5YINt1GVmEtH5XkG/Jkm9iVy+mLfoERKBTBTxkJJ4ubloWclajBn7
         p61LxMscDeD4uzWaNohSejBsgluFs10xFbalBcESDl9hjkVO1va6V5Lju1ZcNBwh8ADR
         36xQ==
X-Gm-Message-State: APjAAAXrd8BEfeOSi267atFgeTf964diO59Xvp5CcBpAO9rn0q0H6TUU
        korufTUtbqTurHgQNLL0X+E=
X-Google-Smtp-Source: APXvYqyry2gTiqVO7tt3fbCeosA3E9/Q6AdyIQC9RW5XG/BPlaY7injpcamhVWBff1tIbivy9zC70Q==
X-Received: by 2002:a6b:c803:: with SMTP id y3mr14926187iof.275.1560954801904;
        Wed, 19 Jun 2019 07:33:21 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d17sm1951734iom.28.2019.06.19.07.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:21 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEXKqP004521;
        Wed, 19 Jun 2019 14:33:20 GMT
Subject: [PATCH v4 10/19] xprtrdma: Simplify rpcrdma_rep_create
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:33:20 -0400
Message-ID: <20190619143320.3826.31702.stgit@manet.1015granger.net>
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

Clean up.

Commit 7c8d9e7c8863 ("xprtrdma: Move Receive posting to Receive
handler") reduced the number of rpcrdma_rep_create call sites to
one. After that commit, the backchannel code no longer invokes it.

Therefore the free list logic added by commit d698c4a02ee0
("xprtrdma: Fix backchannel allocation of extra rpcrdma_reps") is
no longer necessary, and in fact adds some extra overhead that we
can do without.

Simply post any newly created reps. They will get added back to
the rb_recv_bufs list when they subsequently complete.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4e22cc2..de6be10 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1036,9 +1036,9 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	return NULL;
 }
 
-static bool rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt, bool temp)
+static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
+					      bool temp)
 {
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 
 	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
@@ -1049,9 +1049,9 @@ static bool rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt, bool temp)
 					       DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!rep->rr_rdmabuf)
 		goto out_free;
+
 	xdr_buf_init(&rep->rr_hdrbuf, rdmab_data(rep->rr_rdmabuf),
 		     rdmab_length(rep->rr_rdmabuf));
-
 	rep->rr_cqe.done = rpcrdma_wc_receive;
 	rep->rr_rxprt = r_xprt;
 	rep->rr_recv_wr.next = NULL;
@@ -1059,16 +1059,12 @@ static bool rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt, bool temp)
 	rep->rr_recv_wr.sg_list = &rep->rr_rdmabuf->rg_iov;
 	rep->rr_recv_wr.num_sge = 1;
 	rep->rr_temp = temp;
-
-	spin_lock(&buf->rb_lock);
-	list_add(&rep->rr_list, &buf->rb_recv_bufs);
-	spin_unlock(&buf->rb_lock);
-	return true;
+	return rep;
 
 out_free:
 	kfree(rep);
 out:
-	return false;
+	return NULL;
 }
 
 /**
@@ -1497,7 +1493,6 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 	count = 0;
 	wr = NULL;
 	while (needed) {
-		struct rpcrdma_regbuf *rb;
 		struct rpcrdma_rep *rep;
 
 		spin_lock(&buf->rb_lock);
@@ -1507,13 +1502,12 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 			list_del(&rep->rr_list);
 		spin_unlock(&buf->rb_lock);
 		if (!rep) {
-			if (!rpcrdma_rep_create(r_xprt, temp))
+			rep = rpcrdma_rep_create(r_xprt, temp);
+			if (!rep)
 				break;
-			continue;
 		}
 
-		rb = rep->rr_rdmabuf;
-		if (!rpcrdma_regbuf_dma_map(r_xprt, rb)) {
+		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
 			rpcrdma_recv_buffer_put(rep);
 			break;
 		}

