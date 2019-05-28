Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545872CE87
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfE1SV4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:21:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36894 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfE1SV4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:21:56 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so7573418iok.4;
        Tue, 28 May 2019 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=x1+4z7FPCyxG9SE0OvF9MthFwRgmmON5YajNorKmYnI=;
        b=Rggn0/ctwYlvLQATI8XW2RF8/JofngJ8zeRU1xltM2HkOvciaoTOI5lQZoRb/f7sxz
         52qkpYBVx/J7hnR5yWdNbtsBsKiY1UPZACdnzW/5wF60L41cbi0J7zrFgKBogNjowKjY
         Az2QtDvfnd8bZnVtYgxbXwrWBczGpcpfzZYHzEftFUZyg+976Zjd7FG/0lV2FieSNrYc
         BDm+p1S1hJac7lRJ+k3su5+uTq/UAjDdOsOTRTdpUvBTeTmjQumgk5MrZb6IvIdFW6AY
         m92SwPqR31SsDm4ay1Kb2MlUbjlGXP0pNzU4WemchplN5/2k6wZg3t+uUPT7qxt9htuv
         8yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=x1+4z7FPCyxG9SE0OvF9MthFwRgmmON5YajNorKmYnI=;
        b=Av5yok066HTNdk6pM6svaUKhuThMoCdJOku2yuWG06YumGrZ9UtL8stLDOlGltmMfC
         uCIC19iTWIq6y2AGQDC/jiZICPBZ9Pjts5xG59hvjdApMnnVmKgl6hW8cSXqAvOcuVIb
         380mLPVcnLwQvCQrjjtNonxM3Sus3nmLa2hbDvqptcmqLf+M8x8zXJ9dqPAT3OBaJdYq
         BZlE20bvn1CtZrs69RmY6ERqTuexzpGHcRgQx1wS0jwOLZxAS9zPtQhjs3clUZlvbcS8
         sgVsdGyBiGKpRd1QmOFual6IX0rbvZdBXnNvuSs7IH6T6Zh0rftaOFjqYHTEvNgc9Zww
         bKxA==
X-Gm-Message-State: APjAAAWSxQhToSZ/cKodxrGpLBj3MLY4Fk3knAdLsfyronUeKEnCuo8B
        KIdr5xkd1fU1dqf/60EKIyhXp4rB
X-Google-Smtp-Source: APXvYqyrOuR3p8Ga8DaATcp+xY/zmSBOxj0jeTLbqWfcgSEWWgQkxZOdgF8khX+4WfYWIkVyHmUCxg==
X-Received: by 2002:a6b:b642:: with SMTP id g63mr15408439iof.142.1559067715328;
        Tue, 28 May 2019 11:21:55 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c1sm1590904ioc.43.2019.05.28.11.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:21:55 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SILsBp014549;
        Tue, 28 May 2019 18:21:54 GMT
Subject: [PATCH RFC 12/12] xprtrdma: Remove rpcrdma_req::rl_buffer
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:21:54 -0400
Message-ID: <20190528182154.19012.46781.stgit@manet.1015granger.net>
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

There is only one remaining function that uses this field. This
caller can supply the correct rpcrdma_buffer, allowing the removal
of an 8-byte pointer field.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    5 ++++-
 net/sunrpc/xprtrdma/verbs.c     |    6 ++----
 net/sunrpc/xprtrdma/xprt_rdma.h |    4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 5b1d5d7..cff090b 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -550,8 +550,11 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 static void
 xprt_rdma_free_slot(struct rpc_xprt *xprt, struct rpc_rqst *rqst)
 {
+	struct rpcrdma_xprt *r_xprt =
+		container_of(xprt, struct rpcrdma_xprt, rx_xprt);
+
 	memset(rqst, 0, sizeof(*rqst));
-	rpcrdma_buffer_put(rpcr_to_rdmar(rqst));
+	rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
 	rpc_wake_up_next(&xprt->backlog);
 }
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index cc1fdca..ea97b98 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1020,7 +1020,6 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	if (!req->rl_recvbuf)
 		goto out4;
 
-	req->rl_buffer = buffer;
 	INIT_LIST_HEAD(&req->rl_registered);
 	spin_lock(&buffer->rb_lock);
 	list_add(&req->rl_all, &buffer->rb_allreqs);
@@ -1300,13 +1299,12 @@ struct rpcrdma_req *
 
 /**
  * rpcrdma_buffer_put - Put request/reply buffers back into pool
+ * @buffers: buffer pool
  * @req: object to return
  *
  */
-void
-rpcrdma_buffer_put(struct rpcrdma_req *req)
+void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
 {
-	struct rpcrdma_buffer *buffers = req->rl_buffer;
 	struct rpcrdma_rep *rep = req->rl_reply;
 
 	req->rl_reply = NULL;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 5475f0d..117e328 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -320,7 +320,6 @@ enum {
 struct rpcrdma_req {
 	struct list_head	rl_list;
 	struct rpc_rqst		rl_slot;
-	struct rpcrdma_buffer	*rl_buffer;
 	struct rpcrdma_rep	*rl_reply;
 	struct xdr_stream	rl_stream;
 	struct xdr_buf		rl_hdrbuf;
@@ -499,7 +498,8 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 }
 
 struct rpcrdma_req *rpcrdma_buffer_get(struct rpcrdma_buffer *);
-void rpcrdma_buffer_put(struct rpcrdma_req *);
+void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers,
+			struct rpcrdma_req *req);
 void rpcrdma_recv_buffer_put(struct rpcrdma_rep *);
 
 bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size,

