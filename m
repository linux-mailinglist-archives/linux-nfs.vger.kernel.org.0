Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C9B835DD
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbfHFPyb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36921 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPyb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so28189059otp.4;
        Tue, 06 Aug 2019 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=q0PNNvsO6MAnJYGtc+hx6aPJ1mx2BHWsOzx9TV/Ouzc=;
        b=cPwbO7p42ungBThn5zpPAnBsRh7frHvdPxGDsdDAU3oonjcQHdQcj6e1WURmmVa9pb
         RdQoYuvbsU4jHP3duRDdt8HIn8TObA6j6TUCvSc0VJybgpjKKrJhtOokGzuit36w8b0w
         JYt0Jlp95qAPP40VfS10YMV+6yoTTRltTR5pGtP5WURX0GaObyU7yxPWJM0px2XoSkJb
         /F8mbC+LAnXZ16sXjeRQrKoNjKbf+MZ7+j1pI3SFsJ969okPIYYctSJYKa1j0rDgkV0k
         38BKITI52g9NAloMY2ZqJI43DbsPwKQLui6jtcVBw3oLGw3T1IZ/JWAl4jR0yU9j2X/E
         0aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=q0PNNvsO6MAnJYGtc+hx6aPJ1mx2BHWsOzx9TV/Ouzc=;
        b=rZS9eU21irxFFI11/VxBms0utmyFzdGhBLa577zJaYT61uq3e8hk5WL4YeK7Vtq0Nk
         B/9NRusOef7ct03eliwZwqAu2HhAtuEP7KGyNEgoHivUjWXDGnhceQwntBsjb47Uk86Y
         4LnAe32S4DaAsqSinKE6BQ+NjY1/gDASgkIAH2YyLMNpTRrEmP8YRBMYFZF5EgmCy6MA
         rNU+gNdTJ5F5XPTIAvdMzKd7vmVc9BAihVh0bNWP9vBqW8lh9abM5WHIRDmrQKv6rYDX
         KdYKFITZ6bKw8yUzi2S8uqJkUZgVKjx6M4oYzcWWoeoCjc02O212STOE9zBGdwc8T4nl
         Tc1w==
X-Gm-Message-State: APjAAAVEMMhmLy3ojbPgMm6qe3TUqFuQfZY6WHTC7IiyFSJc49dIplEb
        LgNv8ZH3JxppMB5XDN8slGHxwvqD
X-Google-Smtp-Source: APXvYqz4A6kUw5F7rdYvfq9Vt6jidOYvKP08tArJUsEEs7eix6czY8z7qm4g+NRlCl5qcV5R44Joow==
X-Received: by 2002:a5d:9bc6:: with SMTP id d6mr3942104ion.160.1565106870169;
        Tue, 06 Aug 2019 08:54:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j25sm118035469ioj.67.2019.08.06.08.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:29 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FsTVw011535;
        Tue, 6 Aug 2019 15:54:29 GMT
Subject: [PATCH v1 08/18] xprtrdma: Simplify rpcrdma_mr_pop
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:29 -0400
Message-ID: <20190806155428.9529.15251.stgit@manet.1015granger.net>
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
index 3a10bff..d7e763f 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -126,12 +126,10 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
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
index 4345e69..0ac096a 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -841,12 +841,7 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
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
index bf7a7cf..dd5692c 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1205,13 +1205,11 @@ struct rpcrdma_mr *
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
index f90643d..54e6d88 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -343,7 +343,7 @@ struct rpcrdma_req {
 static inline void
 rpcrdma_mr_push(struct rpcrdma_mr *mr, struct list_head *list)
 {
-	list_add_tail(&mr->mr_list, list);
+	list_add(&mr->mr_list, list);
 }
 
 static inline struct rpcrdma_mr *
@@ -351,8 +351,9 @@ struct rpcrdma_req {
 {
 	struct rpcrdma_mr *mr;
 
-	mr = list_first_entry(list, struct rpcrdma_mr, mr_list);
-	list_del_init(&mr->mr_list);
+	mr = list_first_entry_or_null(list, struct rpcrdma_mr, mr_list);
+	if (mr)
+		list_del_init(&mr->mr_list);
 	return mr;
 }
 

