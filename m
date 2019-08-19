Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D89511D
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfHSWsT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:48:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42870 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWsT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:48:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so3239235ota.9;
        Mon, 19 Aug 2019 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tlYQvSFDVmirL961EYb6E6NXJ8a88YWm44bFByD4wzY=;
        b=OVaey6PwRYSt5idQU7SDEHeLR09BNeMdvcOkX5t+bkdSMiSd3E2jwvb2qS3luzUE9b
         NEbdS267G1z0lX6JryY9wpkypHSqjgL3dbkrC15ZK9cE6zQCoDV1ROPIPQwBa0eobNz+
         33d4gieTDGxFa61wK/rWcMVRY5mWCiCeZrbWbUc0Z4tnCOWdp4rtZfwm1eZu1XV+B0pI
         TZxshs4YHX3VLJXdz/PMdDPWGEyR+V5oPcA9i4BKFn60rXTVmNRndSilVAsedxWwD72m
         OeOAfpDOuCDnl4L1MNqwyoPHD9GEkWAHF37j+pY8lqpo9ROZWiJld+JrW4TbMa4tfFaH
         UOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tlYQvSFDVmirL961EYb6E6NXJ8a88YWm44bFByD4wzY=;
        b=H9vIaKhLIpIyB1uAy0QIpWCL6oT9SBSqUNlwMwaIqR3YUBs3MBRY9CKNSu/0+sqBLw
         fAcCGrNHe1bNNUZboax35R9eRBWCYJ+BwRvZfpcDF6siP3YX/GuUoXwHwVEa7UlRx2aj
         MELGZRMkOvN/4TQtkFXsyrLjTUBqVM0Za8xKs1fn6m8jY35WMw4FHT+ERfZC/RLCHaU6
         beKencZhQ2hDgF6nNqIExPEsh8CboRbwBbKT01K0ZOEjmDe4iY20oIrj0P1VqVM3rFTw
         W5JgPteY9EEsJ0fDtR1PNc/5bejoZBLYAy5iQyJzsbZCHN8HxmXbbYsGrntZgdhpGJZJ
         nm6w==
X-Gm-Message-State: APjAAAWzSIovEEI0NuVPJQ5W8CtGoa7CeCtd6FhM+TfYsWsFjhajrm/B
        yUtx63LHoMSudOhnheuXqZeinuVk
X-Google-Smtp-Source: APXvYqwcdYo9Ve/O4x3S0RZ/BQMLCOAeq5rf7msEsBp7tXlA16st8zO8dhKDdFPa+G2RZLx3l4A2jQ==
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr1775810oti.77.1566254898320;
        Mon, 19 Aug 2019 15:48:18 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id e27sm3502316oig.53.2019.08.19.15.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:48:17 -0700 (PDT)
Subject: [PATCH v2 16/21] xprtrdma: Remove rpcrdma_buffer::rb_mrlock
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:47:57 -0400
Message-ID: <156625485698.8161.16540137464222574550.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
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
index 0e740bae2d80..368cdf3edfc9 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -106,10 +106,10 @@ frwr_mr_recycle_worker(struct work_struct *work)
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
index 69753ec73c36..52444c4d1be2 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -962,10 +962,10 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 
 		mr->mr_xprt = r_xprt;
 
-		spin_lock(&buf->rb_mrlock);
+		spin_lock(&buf->rb_lock);
 		list_add(&mr->mr_list, &buf->rb_mrs);
 		list_add(&mr->mr_all, &buf->rb_all_mrs);
-		spin_unlock(&buf->rb_mrlock);
+		spin_unlock(&buf->rb_lock);
 	}
 
 	r_xprt->rx_stats.mrs_allocated += count;
@@ -1084,7 +1084,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 
 	buf->rb_max_requests = r_xprt->rx_ep.rep_max_requests;
 	buf->rb_bc_srv_max_requests = 0;
-	spin_lock_init(&buf->rb_mrlock);
 	spin_lock_init(&buf->rb_lock);
 	INIT_LIST_HEAD(&buf->rb_mrs);
 	INIT_LIST_HEAD(&buf->rb_all_mrs);
@@ -1154,18 +1153,18 @@ rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
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
 
@@ -1218,9 +1217,9 @@ rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_mr *mr;
 
-	spin_lock(&buf->rb_mrlock);
+	spin_lock(&buf->rb_lock);
 	mr = rpcrdma_mr_pop(&buf->rb_mrs);
-	spin_unlock(&buf->rb_mrlock);
+	spin_unlock(&buf->rb_lock);
 	return mr;
 }
 
@@ -1249,9 +1248,9 @@ static void rpcrdma_mr_free(struct rpcrdma_mr *mr)
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
index c375b0e434ac..200d075bbe31 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -360,19 +360,18 @@ rpcrdma_mr_pop(struct list_head *list)
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

