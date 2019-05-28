Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81F22CE7F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfE1SVk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:21:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39986 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfE1SVk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:21:40 -0400
Received: by mail-it1-f193.google.com with SMTP id h11so5491434itf.5;
        Tue, 28 May 2019 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AYDAlu3lshTWu+thI1Eb0xhXztpFpS+AwLcO72xeFgg=;
        b=QjI4AlsJ+3d6BBMyO5ijZjnwzVuiuJkkoJKp3MjThLosRE1sE1bMq185QiZ2SpUqm/
         zq4aDAWNFb0LdkWhB4l/26qF4iAUHuEB+Ltwau2sNe2TREr+q6+949NFeiSsjE8JTx/y
         KXG50iNxmRgALuTxWWWGsHS5jo/eHQ00MIxT8U2L/vEbQblaW8qDtAVwEKzKTjoiuxby
         fXJWLSCnz6Dtcd9QYsgCxCOiX9AbfJudEb6VENi0lGYis91jyytmeNsILTFVeN8w4SN3
         7YiKBjz9cy94RT7FRJQcDbCjWM/iJ5e8h/I0vS86mbHP/9G+QyhnqS0qH/vpGvJDbxUw
         /jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AYDAlu3lshTWu+thI1Eb0xhXztpFpS+AwLcO72xeFgg=;
        b=LvLqcPE0wZ0zjIRxJOdswNX+BppSyvwLSFH4GRcUp9nFdm+IulPLNDBbDLcO+MsU5Y
         M/tmz8x0bOqDB/2kis45yrMy+9CpxxjnhOlz/eHWM+q3AYGWtERT4+u7A/s6Y2jnXJmX
         J3joJWI1GNhtfcVLVUWuHaXw3A/hE4nbUMDebQyghZlqVqKQ2v8IdUqrxsyvDNT3qzgn
         Jlgewd9/P5IGBG7Rt2FG+UK6sRzItSVklMD0H2PRUBGOCqZKdbqOjKRqLKZrR7kUG31+
         NoH4rjGuDe4KT3f9NW0dmZUArICphVdGhud9BMUpZKPcxLkvQSR9RidatwxrpZlbeL4n
         zg4g==
X-Gm-Message-State: APjAAAUJrd9aDG5llToz98DAt1eRa2GWQRl+hdZHMNRQ128hsUWFmYFw
        Be2lrjoibhYNE34SvKqD+2jhywnj
X-Google-Smtp-Source: APXvYqx7HzZlbX1kjkkdv7IUs4Qlg/KfOU6cXJmL3KUpGQBEBLPSpjSFVaunHCNOVVcBUGOil1iaaA==
X-Received: by 2002:a24:3988:: with SMTP id l130mr4048009ita.13.1559067699616;
        Tue, 28 May 2019 11:21:39 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n26sm3366771ioc.74.2019.05.28.11.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:21:39 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SILcgX014540;
        Tue, 28 May 2019 18:21:38 GMT
Subject: [PATCH RFC 09/12] xprtrdma: Simplify rpcrdma_rep_create
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:21:38 -0400
Message-ID: <20190528182138.19012.62904.stgit@manet.1015granger.net>
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
index 729266e..390c3bc 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1037,9 +1037,9 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	return NULL;
 }
 
-static bool rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt, bool temp)
+static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
+					      bool temp)
 {
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 
 	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
@@ -1050,9 +1050,9 @@ static bool rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt, bool temp)
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
@@ -1060,16 +1060,12 @@ static bool rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt, bool temp)
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
@@ -1498,7 +1494,6 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 	count = 0;
 	wr = NULL;
 	while (needed) {
-		struct rpcrdma_regbuf *rb;
 		struct rpcrdma_rep *rep;
 
 		spin_lock(&buf->rb_lock);
@@ -1508,13 +1503,12 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
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

