Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6986E95108
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfHSWo0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:44:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35325 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWo0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:44:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id g17so3245992otl.2;
        Mon, 19 Aug 2019 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BEP0xwlQ4b6InfkIJQy/Guf2YYQMYLXVg18uYu4Cs1c=;
        b=tTrQ8Bble+y/ksy75w2DzKGbEMGSRZGoRxTBqPWYQ6BPqUt5VWOCPxLCZjMu1LylPX
         FEI3P/oiBgfohSjGb4e/+uFEgJB5iK5ujAB4lDXk2IOvPafcGDfoYRbLQ9+Py4pFBZMa
         8pP+MoBEaFi0eG1wTkST6AyRE0dGFbY1wqMasrazn9Z6DPEQpJ8xQwchoww5VBsG8tKu
         5JsoLEkzOSRnLm7Sfx6el0xp13KoR9zqmhzBuAO/BSGbbJ8ihRrkUNDdxwSYBgx9ojpC
         mo+pNOwQoNXdqkPML6SgU9RMZRkBlolTKMylGY365K2IO3ebbhH+RI+pbW6iE4SFZRYJ
         ITMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BEP0xwlQ4b6InfkIJQy/Guf2YYQMYLXVg18uYu4Cs1c=;
        b=ef1dtvy7ueu3brFUe9DPbTNSZFPjoyQIwp9QFJ5uAAFHXS6ppkFuRSIIIn6n24sjPV
         nLrk3XQbPHRtqozlCpgky9O4NdzgBfR6FdlFpM9NiooubgoOQ4fGHmr5zHNFFomT5+SY
         xmf9yBcHYIuOH2ekYnKOZAnVx4TVYK07nu4EoTclkiGiGCZUdACZAvmOt8pSufT+e2su
         N6DDILUQghobwa7PAIkDHEQO4h/4elbwNOEVsC7KZNgdCqgl5vZnYwb9ZR0zpsxmT+P8
         xx2NOtdsjedc/su/c/SPBCAC+Kbfck+AjSoacNcm/TxqV+0z1tMWnVaODKDcdnqpanFz
         cMug==
X-Gm-Message-State: APjAAAWVo2jK3s8v32T+6/oHZZ6IQZwxzvSbZnul5BoAtSv6qNht7G38
        fnDr2DLSN4J9IkpfpaGaK+Js5sGY
X-Google-Smtp-Source: APXvYqz4hw3N1Q65A1cSKiWSnEV/Eoab5IoGTcbTn+GVltUsKvcx6cf7fcsdIkFPyCCNySsIcr9drQ==
X-Received: by 2002:a9d:4913:: with SMTP id e19mr13194541otf.1.1566254665577;
        Mon, 19 Aug 2019 15:44:25 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id g3sm6437033oti.41.2019.08.19.15.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:44:25 -0700 (PDT)
Subject: [PATCH v2 11/21] xprtrdma: Simplify rpcrdma_mr_pop
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:44:04 -0400
Message-ID: <156625462416.8161.10214523289584503091.stgit@seurat29.1015granger.net>
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

Clean up: rpcrdma_mr_pop call sites check if the list is empty
first. Let's replace the list_empty with less costly logic.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   12 ++++--------
 net/sunrpc/xprtrdma/rpc_rdma.c  |    7 +------
 net/sunrpc/xprtrdma/verbs.c     |    6 ++----
 net/sunrpc/xprtrdma/xprt_rdma.h |    7 ++++---
 4 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 3a10bfff2125..d7e763fafa04 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -126,12 +126,10 @@ frwr_mr_recycle_worker(struct work_struct *work)
  */
 void frwr_reset(struct rpcrdma_req *req)
 {
-	while (!list_empty(&req->rl_registered)) {
-		struct rpcrdma_mr *mr;
+	struct rpcrdma_mr *mr;
 
-		mr = rpcrdma_mr_pop(&req->rl_registered);
+	while ((mr = rpcrdma_mr_pop(&req->rl_registered)))
 		rpcrdma_mr_unmap_and_put(mr);
-	}
 }
 
 /**
@@ -532,8 +530,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 */
 	frwr = NULL;
 	prev = &first;
-	while (!list_empty(&req->rl_registered)) {
-		mr = rpcrdma_mr_pop(&req->rl_registered);
+	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
 
 		trace_xprtrdma_mr_localinv(mr);
 		r_xprt->rx_stats.local_inv_needed++;
@@ -632,8 +629,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 */
 	frwr = NULL;
 	prev = &first;
-	while (!list_empty(&req->rl_registered)) {
-		mr = rpcrdma_mr_pop(&req->rl_registered);
+	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
 
 		trace_xprtrdma_mr_localinv(mr);
 		r_xprt->rx_stats.local_inv_needed++;
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 4345e6912392..0ac096a6348a 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -841,12 +841,7 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst)
 	 * chunks. Very likely the connection has been replaced,
 	 * so these registrations are invalid and unusable.
 	 */
-	while (unlikely(!list_empty(&req->rl_registered))) {
-		struct rpcrdma_mr *mr;
-
-		mr = rpcrdma_mr_pop(&req->rl_registered);
-		rpcrdma_mr_recycle(mr);
-	}
+	frwr_reset(req);
 
 	/* This implementation supports the following combinations
 	 * of chunk lists in one RPC-over-RDMA Call message:
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index e004873cc4f0..ee6fcf10425b 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1213,13 +1213,11 @@ struct rpcrdma_mr *
 rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
-	struct rpcrdma_mr *mr = NULL;
+	struct rpcrdma_mr *mr;
 
 	spin_lock(&buf->rb_mrlock);
-	if (!list_empty(&buf->rb_mrs))
-		mr = rpcrdma_mr_pop(&buf->rb_mrs);
+	mr = rpcrdma_mr_pop(&buf->rb_mrs);
 	spin_unlock(&buf->rb_mrlock);
-
 	if (!mr)
 		goto out_nomrs;
 	return mr;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 5aaa53b8ae12..9663b8ddd733 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -338,7 +338,7 @@ rpcr_to_rdmar(const struct rpc_rqst *rqst)
 static inline void
 rpcrdma_mr_push(struct rpcrdma_mr *mr, struct list_head *list)
 {
-	list_add_tail(&mr->mr_list, list);
+	list_add(&mr->mr_list, list);
 }
 
 static inline struct rpcrdma_mr *
@@ -346,8 +346,9 @@ rpcrdma_mr_pop(struct list_head *list)
 {
 	struct rpcrdma_mr *mr;
 
-	mr = list_first_entry(list, struct rpcrdma_mr, mr_list);
-	list_del_init(&mr->mr_list);
+	mr = list_first_entry_or_null(list, struct rpcrdma_mr, mr_list);
+	if (mr)
+		list_del_init(&mr->mr_list);
 	return mr;
 }
 

