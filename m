Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9109015ACEA
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 17:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBLQMk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 11:12:40 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45440 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgBLQMj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 11:12:39 -0500
Received: by mail-yw1-f65.google.com with SMTP id a125so1076067ywe.12;
        Wed, 12 Feb 2020 08:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vdwBZ4Z61PIBVXZVwRCtKpuVjna7R7fsVMIFx193trk=;
        b=RyNrF+geaRYORX7ys/8N+WU0UzaNRJFK5KYzpLaWS/mxs0sajVNkmIXYdb55budWdE
         uLC4X5qul5UPL+jG+NWv48mNLiLQqQeAkn3An3oOPiQibLRUCcrC2CtHCYoQD6SymVfA
         8OPsERjSC5ltoCTGKYtrlhuzbLBzu4ZrmSBudXHCGI6VQ6pQdBIwqcLyjrE6Wf+WQ4rL
         hIYZ+4/k6Xb3zirZOq0+3XI/v+DfrlLauQYc3al2YYeflnAkFTeRLQQCBOa/7zVbD+Jw
         nfPN/AgTwAgF+HfzLbzIwO9GColz4tJ+CeuU/SvUC8sDlBQQt/OKrvYI4DXX7zD7ACXX
         2Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vdwBZ4Z61PIBVXZVwRCtKpuVjna7R7fsVMIFx193trk=;
        b=Nw0ciXftqOXV5q+0wEKUPA7xBSMvJRN7DamU+rGoJaf1AwKnQDjCz/CIhlr7uHO4g5
         IkuP1jpXRYQqXIuBRPTqHwMXw0s6MdKdERLaIHYux72C6ikV8+RJBDpwLgX4yOpR2g7B
         bgD1X+a34D66jvGHqW12bJYbNyIYVd9/vUJ7AJV1l9MqcNjgG1DCN5u2Sod0aZ9mY7NQ
         GrPKzDB5YkycmBjCgSnqwd7+abycl3wkuraN2KZl0TTLCE25Vg207xUncPPF4q8fg63u
         hCTFAWkb3tr4NsD+9Xv9EcruSie2RcRmg0hPS702pzDxBpYDYF3ZHxv9nDR7sGYuVWbe
         i9WA==
X-Gm-Message-State: APjAAAW53sUuFkseYqHTNgfawBUc+wCYRGspoNSNJS2xjUzBwEkBwx4I
        PGU0ZPFbrWo1RK6N0x/fNdNQPp10
X-Google-Smtp-Source: APXvYqzGjVScRHOodUyAHQzqeVxypWtOUzQ4Y13WGOSYSBTwqhUHbu1tZ/JtBvaR6Lh67L5zPmunRg==
X-Received: by 2002:a81:6d17:: with SMTP id i23mr10983519ywc.58.1581523958216;
        Wed, 12 Feb 2020 08:12:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s3sm401856ywf.22.2020.02.12.08.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 08:12:36 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01CGCZnM022129;
        Wed, 12 Feb 2020 16:12:35 GMT
Subject: [PATCH v3 2/2] xprtrdma: Enhance MR-related trace points
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 12 Feb 2020 11:12:35 -0500
Message-ID: <158152395507.433502.11812960451539625240.stgit@morisot.1015granger.net>
In-Reply-To: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Two changes:
- Show the number of SG entries that were mapped. This helps debug
  DMA-related problems.
- Record the MR's resource ID instead of its memory address. This
  groups each MR with its associated rdma-tool output, and reduces
  needless exposure of memory addresses.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   56 +++++++++++++++++++++-------------------
 net/sunrpc/xprtrdma/frwr_ops.c |    2 +
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c0e4c93324f5..87f4461ab108 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -228,20 +228,20 @@ DECLARE_EVENT_CLASS(xprtrdma_frwr_done,
 	TP_ARGS(wc, frwr),
 
 	TP_STRUCT__entry(
-		__field(const void *, mr)
+		__field(u32, mr_id)
 		__field(unsigned int, status)
 		__field(unsigned int, vendor_err)
 	),
 
 	TP_fast_assign(
-		__entry->mr = container_of(frwr, struct rpcrdma_mr, frwr);
+		__entry->mr_id = frwr->fr_mr->res.id;
 		__entry->status = wc->status;
 		__entry->vendor_err = __entry->status ? wc->vendor_err : 0;
 	),
 
 	TP_printk(
-		"mr=%p: %s (%u/0x%x)",
-		__entry->mr, rdma_show_wc_status(__entry->status),
+		"mr.id=%u: %s (%u/0x%x)",
+		__entry->mr_id, rdma_show_wc_status(__entry->status),
 		__entry->status, __entry->vendor_err
 	)
 );
@@ -274,7 +274,8 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
 	TP_ARGS(mr),
 
 	TP_STRUCT__entry(
-		__field(const void *, mr)
+		__field(u32, mr_id)
+		__field(int, nents)
 		__field(u32, handle)
 		__field(u32, length)
 		__field(u64, offset)
@@ -282,15 +283,16 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
 	),
 
 	TP_fast_assign(
-		__entry->mr = mr;
+		__entry->mr_id  = mr->frwr.fr_mr->res.id;
+		__entry->nents  = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
 		__entry->offset = mr->mr_offset;
 		__entry->dir    = mr->mr_dir;
 	),
 
-	TP_printk("mr=%p %u@0x%016llx:0x%08x (%s)",
-		__entry->mr, __entry->length,
+	TP_printk("mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s)",
+		__entry->mr_id, __entry->nents, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
 		xprtrdma_show_direction(__entry->dir)
 	)
@@ -920,17 +922,17 @@ TRACE_EVENT(xprtrdma_frwr_alloc,
 	TP_ARGS(mr, rc),
 
 	TP_STRUCT__entry(
-		__field(const void *, mr)
+		__field(u32, mr_id)
 		__field(int, rc)
 	),
 
 	TP_fast_assign(
-		__entry->mr = mr;
-		__entry->rc	= rc;
+		__entry->mr_id = mr->frwr.fr_mr->res.id;
+		__entry->rc = rc;
 	),
 
-	TP_printk("mr=%p: rc=%d",
-		__entry->mr, __entry->rc
+	TP_printk("mr.id=%u: rc=%d",
+		__entry->mr_id, __entry->rc
 	)
 );
 
@@ -943,7 +945,8 @@ TRACE_EVENT(xprtrdma_frwr_dereg,
 	TP_ARGS(mr, rc),
 
 	TP_STRUCT__entry(
-		__field(const void *, mr)
+		__field(u32, mr_id)
+		__field(int, nents)
 		__field(u32, handle)
 		__field(u32, length)
 		__field(u64, offset)
@@ -952,7 +955,8 @@ TRACE_EVENT(xprtrdma_frwr_dereg,
 	),
 
 	TP_fast_assign(
-		__entry->mr = mr;
+		__entry->mr_id  = mr->frwr.fr_mr->res.id;
+		__entry->nents  = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
 		__entry->offset = mr->mr_offset;
@@ -960,8 +964,8 @@ TRACE_EVENT(xprtrdma_frwr_dereg,
 		__entry->rc	= rc;
 	),
 
-	TP_printk("mr=%p %u@0x%016llx:0x%08x (%s): rc=%d",
-		__entry->mr, __entry->length,
+	TP_printk("mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s): rc=%d",
+		__entry->mr_id, __entry->nents, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
 		xprtrdma_show_direction(__entry->dir),
 		__entry->rc
@@ -977,21 +981,21 @@ TRACE_EVENT(xprtrdma_frwr_sgerr,
 	TP_ARGS(mr, sg_nents),
 
 	TP_STRUCT__entry(
-		__field(const void *, mr)
+		__field(u32, mr_id)
 		__field(u64, addr)
 		__field(u32, dir)
 		__field(int, nents)
 	),
 
 	TP_fast_assign(
-		__entry->mr = mr;
+		__entry->mr_id = mr->frwr.fr_mr->res.id;
 		__entry->addr = mr->mr_sg->dma_address;
 		__entry->dir = mr->mr_dir;
 		__entry->nents = sg_nents;
 	),
 
-	TP_printk("mr=%p dma addr=0x%llx (%s) sg_nents=%d",
-		__entry->mr, __entry->addr,
+	TP_printk("mr.id=%u DMA addr=0x%llx (%s) sg_nents=%d",
+		__entry->mr_id, __entry->addr,
 		xprtrdma_show_direction(__entry->dir),
 		__entry->nents
 	)
@@ -1006,7 +1010,7 @@ TRACE_EVENT(xprtrdma_frwr_maperr,
 	TP_ARGS(mr, num_mapped),
 
 	TP_STRUCT__entry(
-		__field(const void *, mr)
+		__field(u32, mr_id)
 		__field(u64, addr)
 		__field(u32, dir)
 		__field(int, num_mapped)
@@ -1014,15 +1018,15 @@ TRACE_EVENT(xprtrdma_frwr_maperr,
 	),
 
 	TP_fast_assign(
-		__entry->mr = mr;
+		__entry->mr_id = mr->frwr.fr_mr->res.id;
 		__entry->addr = mr->mr_sg->dma_address;
 		__entry->dir = mr->mr_dir;
 		__entry->num_mapped = num_mapped;
 		__entry->nents = mr->mr_nents;
 	),
 
-	TP_printk("mr=%p dma addr=0x%llx (%s) nents=%d of %d",
-		__entry->mr, __entry->addr,
+	TP_printk("mr.id=%u DMA addr=0x%llx (%s) nents=%d of %d",
+		__entry->mr_id, __entry->addr,
 		xprtrdma_show_direction(__entry->dir),
 		__entry->num_mapped, __entry->nents
 	)
@@ -1031,7 +1035,7 @@ TRACE_EVENT(xprtrdma_frwr_maperr,
 DEFINE_MR_EVENT(localinv);
 DEFINE_MR_EVENT(map);
 DEFINE_MR_EVENT(unmap);
-DEFINE_MR_EVENT(remoteinv);
+DEFINE_MR_EVENT(reminv);
 DEFINE_MR_EVENT(recycle);
 
 TRACE_EVENT(xprtrdma_dma_maperr,
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 125297c9aa3e..0dc799553a08 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -419,7 +419,7 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 	list_for_each_entry(mr, mrs, mr_list)
 		if (mr->mr_handle == rep->rr_inv_rkey) {
 			list_del_init(&mr->mr_list);
-			trace_xprtrdma_mr_remoteinv(mr);
+			trace_xprtrdma_mr_reminv(mr);
 			rpcrdma_mr_put(mr);
 			break;	/* only one invalidated MR per RPC */
 		}


