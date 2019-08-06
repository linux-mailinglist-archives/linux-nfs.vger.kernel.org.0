Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7713835E7
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfHFPy6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38506 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732676AbfHFPy6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so93767903oth.5;
        Tue, 06 Aug 2019 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QylVfG0S92jfWgMVPQwRKBs7tczuyKq7LvMF/GlKvmI=;
        b=DbVSduedsDtTIFxfj8QJPT1zpF+tq7Xfzu2sbtmZsMvghJOMgkkLLOFJJX4gRlWcEF
         uDghO2HMoboHngM0xFyEF2r2CnPmzmmn/VdnTm8zVqBV5BAS++w2lInXQXJgWuYiLCaB
         JaTsL39RvZ32zn0Yf3lC0a/oNRdyIxgfH/6cL9N9LRinXkQ82Owtff0RvliZFJ5/xucm
         rIh5pZUCRyzE4RreW2xJ1V0cl7rkgtW7v8NlxG/MlWpzE9vZT2FE1TGK9EDj2/Rj0ykE
         C6CHVFA6K+32T8ax6Pj+rhQMKiRL8eIX3lw+TMe7XxBSsCneNZjga+JYExxtaYfQ98Ok
         jyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=QylVfG0S92jfWgMVPQwRKBs7tczuyKq7LvMF/GlKvmI=;
        b=qWYPXsu/x6aSvGtcIDUffLAL+6XJm8Pc08kyT/vvGcycYvPC+clEXF3xd/a/yUvXTV
         odoAMdn4qXyLfVV+SncrXGIw5yHRUru0ciTyV0yE3xtzUp1zn76c+Ue1Rpk2FtgvTbfw
         CwHQBXZNgsbMM4/donns0y990Rv/ndDlxUetaC2tRdygdrmM1BStS5e+t81Hs3Yapq30
         6h/bm+nATKbFNwz+3u22rIm7uftCKyqc/33G0hBLj7K8yKoUanmd9/qa8PNb1qOC2Y0Y
         I+/pStikN+yydPde/jwStEvWhivd7JY6yqLsAnDB/8mnQrecjCVj949LqVKnSLUPJ5l5
         vchA==
X-Gm-Message-State: APjAAAW97TOKNLfnAmE56+mIYl/y71XJIzjjW5PDZaRJgRBOL0WIlGkz
        K4I2rCJQCyzr2SdWqVirxXmp/V7h
X-Google-Smtp-Source: APXvYqyqGu+4WiTqO6THB3IoHgbUzokN2+NwKw4hb9MpFIwUf+9Zcsapuf6iKtoD2e1VTWjTMRh9Ng==
X-Received: by 2002:a6b:bec7:: with SMTP id o190mr4007881iof.158.1565106896518;
        Tue, 06 Aug 2019 08:54:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x22sm65237354iob.84.2019.08.06.08.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:56 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FstJO011550;
        Tue, 6 Aug 2019 15:54:55 GMT
Subject: [PATCH v1 13/18] xprtrdma: Remove rpcrdma_buffer::rb_mrlock
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:55 -0400
Message-ID: <20190806155455.9529.52694.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Now that the free list is used sparingly, get rid of the
separate spin lock protecting it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    4 ++--
 net/sunrpc/xprtrdma/verbs.c     |   21 ++++++++++-----------
 net/sunrpc/xprtrdma/xprt_rdma.h |    9 ++++-----
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 0e740ba..368cdf3 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -106,10 +106,10 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 		mr->mr_dir = DMA_NONE;
 	}
 
-	spin_lock(&r_xprt->rx_buf.rb_mrlock);
+	spin_lock(&r_xprt->rx_buf.rb_lock);
 	list_del(&mr->mr_all);
 	r_xprt->rx_stats.mrs_recycled++;
-	spin_unlock(&r_xprt->rx_buf.rb_mrlock);
+	spin_unlock(&r_xprt->rx_buf.rb_lock);
 
 	frwr_release_mr(mr);
 }
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 1940ffc..15a77b3 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -960,10 +960,10 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 
 		mr->mr_xprt = r_xprt;
 
-		spin_lock(&buf->rb_mrlock);
+		spin_lock(&buf->rb_lock);
 		list_add(&mr->mr_list, &buf->rb_mrs);
 		list_add(&mr->mr_all, &buf->rb_all_mrs);
-		spin_unlock(&buf->rb_mrlock);
+		spin_unlock(&buf->rb_lock);
 	}
 
 	r_xprt->rx_stats.mrs_allocated += count;
@@ -1076,7 +1076,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 
 	buf->rb_max_requests = r_xprt->rx_ep.rep_max_requests;
 	buf->rb_bc_srv_max_requests = 0;
-	spin_lock_init(&buf->rb_mrlock);
 	spin_lock_init(&buf->rb_lock);
 	INIT_LIST_HEAD(&buf->rb_mrs);
 	INIT_LIST_HEAD(&buf->rb_all_mrs);
@@ -1146,18 +1145,18 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req)
 	unsigned int count;
 
 	count = 0;
-	spin_lock(&buf->rb_mrlock);
+	spin_lock(&buf->rb_lock);
 	while ((mr = list_first_entry_or_null(&buf->rb_all_mrs,
 					      struct rpcrdma_mr,
 					      mr_all)) != NULL) {
 		list_del(&mr->mr_all);
-		spin_unlock(&buf->rb_mrlock);
+		spin_unlock(&buf->rb_lock);
 
 		frwr_release_mr(mr);
 		count++;
-		spin_lock(&buf->rb_mrlock);
+		spin_lock(&buf->rb_lock);
 	}
-	spin_unlock(&buf->rb_mrlock);
+	spin_unlock(&buf->rb_lock);
 	r_xprt->rx_stats.mrs_allocated = 0;
 }
 
@@ -1210,9 +1209,9 @@ struct rpcrdma_mr *
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_mr *mr;
 
-	spin_lock(&buf->rb_mrlock);
+	spin_lock(&buf->rb_lock);
 	mr = rpcrdma_mr_pop(&buf->rb_mrs);
-	spin_unlock(&buf->rb_mrlock);
+	spin_unlock(&buf->rb_lock);
 	return mr;
 }
 
@@ -1241,9 +1240,9 @@ static void rpcrdma_mr_free(struct rpcrdma_mr *mr)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 
 	mr->mr_req = NULL;
-	spin_lock(&buf->rb_mrlock);
+	spin_lock(&buf->rb_lock);
 	rpcrdma_mr_push(mr, &buf->rb_mrs);
-	spin_unlock(&buf->rb_mrlock);
+	spin_unlock(&buf->rb_lock);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 6c9830a..b388bb4 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -365,19 +365,18 @@ struct rpcrdma_req {
  * One of these is associated with a transport instance
  */
 struct rpcrdma_buffer {
-	spinlock_t		rb_mrlock;	/* protect rb_mrs list */
+	spinlock_t		rb_lock;
+	struct list_head	rb_send_bufs;
+	struct list_head	rb_recv_bufs;
 	struct list_head	rb_mrs;
-	struct list_head	rb_all_mrs;
 
 	unsigned long		rb_sc_head;
 	unsigned long		rb_sc_tail;
 	unsigned long		rb_sc_last;
 	struct rpcrdma_sendctx	**rb_sc_ctxs;
 
-	spinlock_t		rb_lock;	/* protect buf lists */
-	struct list_head	rb_send_bufs;
-	struct list_head	rb_recv_bufs;
 	struct list_head	rb_allreqs;
+	struct list_head	rb_all_mrs;
 
 	u32			rb_max_requests;
 	u32			rb_credits;	/* most recent credit grant */

