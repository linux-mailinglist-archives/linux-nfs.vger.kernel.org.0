Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FBB4873F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfFQPcZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:32:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34983 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPcZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:32:25 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so22196094ioo.2;
        Mon, 17 Jun 2019 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2pg29dnS4ttgMUR89dxmY66Tv7iksN4v374kY3+7sdc=;
        b=Fu14RxP1O0zfpdpSHF5n1B/tGn89FePDd84/obwblxi51A2YovxRMVd5CHrJOGG+EJ
         KdNFxJCEerzRtTIQ+PLZAW7gbZjH1payeWK5bDHkVROjBRcmuYQddX3vd/rC36vxpz+k
         qz4wC/agLFrOzp0m7xNzM3T3bVwm8mpJQbrXQV7qsoEdQM96QvkQ3+Ucf+dpiTxtNryp
         kGpjnqdKu5vznBrD8hM1G65XMH+tIiVeXp4/JXVuHXwqrw1V1Q7gJ23+PRAN5Duzuz/z
         /oBSp9F1ZWMvDO6enV1rW2zYf4QRoD6ga5IYiU6+m+12vm5hIi88j/m+TvAcmKlf5/nD
         L0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2pg29dnS4ttgMUR89dxmY66Tv7iksN4v374kY3+7sdc=;
        b=iVXpzc4PLRiUrJn/CuteLavxSX/oylafriV94Tuv5EuShQP3n1LKK0+l0tyenuLFND
         +3VA3zLkX02w/vDEtG/tdT87xaoXUJVW2EfI1jxgUodkvWmKFaH0bmUBFbTxtdM8oX04
         eu0iZ+xjZMyTU15LrXruJPzwJiVqCTU7NkZBibyKNamGCvasA3FB1BZhCfpevmBYboD1
         qhsSD94UOAq2risCDRQMw/yjrI62NrKO480qkxNsNjzVEtyOuVNMvHbVkjbLpCp1EoF1
         LTblNIDb8a6qYzNA5OBN269aEXz0KjO8xGooN6YsqeItdq+BVRSr9Ua1KY9fzbXAT7xo
         nTcA==
X-Gm-Message-State: APjAAAXQdfkfq0ub8C4KR2HQvwj/T/u5SSJVLMGtbVhbL/GAjrQ07otA
        SvszSRKqZ5FHHodKRxne+CQ=
X-Google-Smtp-Source: APXvYqxgflOcPjfFbXec3X7uckza0Ic6KASxlgW4NXDUEBuJeuaqukbB2OiufhmHaN4ClDA+krOzWg==
X-Received: by 2002:a02:6516:: with SMTP id u22mr78558568jab.49.1560785544176;
        Mon, 17 Jun 2019 08:32:24 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a1sm9400590ioo.5.2019.06.17.08.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:32:23 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFWN4s031215;
        Mon, 17 Jun 2019 15:32:23 GMT
Subject: [PATCH v3 10/19] xprtrdma: Simplify rpcrdma_rep_create
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:32:23 -0400
Message-ID: <20190617153222.12090.23722.stgit@manet.1015granger.net>
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

