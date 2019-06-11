Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6283D051
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbfFKPIy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:54 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52194 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfFKPIx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:53 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so5513006itl.1;
        Tue, 11 Jun 2019 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2pg29dnS4ttgMUR89dxmY66Tv7iksN4v374kY3+7sdc=;
        b=L8kUEVAIYZFwRAyFbdtyHoRt07rOwNSgE0dK/vdl3pS5qAaWpFgLyAivBJIKnyfo3e
         6mhtZCwB2QMh5HP67irDRfkFoIF6rIOTh5xnZHVi81cYzAbmj8LpwFAJTZ/+EkjXhH1x
         5MrAVcv7faAKP7tzuQqvbwuLndFDIj5NTId8yiVKwzg39y4Pa2d1du4lb10obZH5/lvw
         xCaZRQnofEZGqCEvasjBWBRWr2nqEKSrnFeowFYLF5XCF/cUJ3a7C6PhRObyyyOZu9Hu
         0yglebV5lmtz+qgi1qyywrRSaDioVRfrBMhyESTFno1c0+I5JcsEn/9c7BLdMXZnIb+z
         PehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2pg29dnS4ttgMUR89dxmY66Tv7iksN4v374kY3+7sdc=;
        b=NFbmox4mpMCp4Hm4+4BfHTXUzOueBAjWnY+4htIaO+uBMFbb7bwotjFb2V7DXEyiXe
         QjlEfAUJYgUCAFiZzdgM6Fvhwv9w9ttqyIq4QD3IbW630SDAwfabCKyXUGtknfWIfmJk
         XvlhZuOS4eaMHd/9oF3N1LwTDJP0l1MJZy7qEDN8G1AsRC0hjkfFs8JpT4BXUyr3UeXI
         77b3bdzYsjc6dFJtSo2ak9qBoa9CTQ2bc6fYfKCJnSupqbr0L5mi6Dw/uUB0QWjXqw1h
         Z5g9pKhEcsGYDwz0rmWgf4d0RqcYkrRHdkMgwMs30BqZfFU11fd2fc7rCGudTJKMzCxE
         WAXw==
X-Gm-Message-State: APjAAAUOmF7202lkmIZN6WcoY0xQ9w1bnddD5Q0gsfjwkHh/sXCXplB6
        aSY2PMR9ili/aqev1tY44dyzpscE
X-Google-Smtp-Source: APXvYqx6OjThMlRzlrGkdzpEX3vhEqKV/84KAlFn6hn2/YCNEDFW3LRpQrL3ARRUskvd4M6Nl0wABw==
X-Received: by 2002:a05:660c:503:: with SMTP id d3mr20097585itk.126.1560265732709;
        Tue, 11 Jun 2019 08:08:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a200sm1373871itc.20.2019.06.11.08.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:08:52 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF8pCo021755;
        Tue, 11 Jun 2019 15:08:51 GMT
Subject: [PATCH v2 10/19] xprtrdma: Simplify rpcrdma_rep_create
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:08:51 -0400
Message-ID: <20190611150851.2877.87394.stgit@manet.1015granger.net>
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

