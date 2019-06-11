Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B523D047
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391687AbfFKPI1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38769 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391203AbfFKPI1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:27 -0400
Received: by mail-it1-f195.google.com with SMTP id e25so5299469itk.3;
        Tue, 11 Jun 2019 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=R5adNTAX4v/whhBxaGHdcBfgRe+XMScB387JUuJ1wr0=;
        b=rFW3HCRo+spQbuiKcoOW57cMxPbE2cMmjB2660WTyVFJTEwWy7ragWTpX7NO7K42ec
         PZoF/0lqWOcGwHvV219QwBYva0mXd22HVEP6GZEzYC/F1w8T5ehvM3E2tv4NGF6Pl09Z
         9Zs8rRLX19Lkk1ejrrgHnkhC9aAKyEMxmYOxKBzt5fHDId1X6cg93jhdaOp5xZZGGKxl
         k34p+xiAnkQdFqWG3pbkrbQud4OIPwpLTpdh+WUuCm/DAFcOOJHBGpBj5rJZAhQ5sC8i
         qN4jXvsFpcuAwMHS+6LP3qpGmNmH1qInuRZvmoUwWgs61zqte/uB+1XXqrCzH1sby+In
         5zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=R5adNTAX4v/whhBxaGHdcBfgRe+XMScB387JUuJ1wr0=;
        b=i1/9VCAtbNKVftxExLuwOSHkSQGn2zylN/rUKpdiHAc4941Q+7I9qBz+G4Sin8ZEH2
         t7axlAM97MRB9X0RahK1hd6OXbt40pegYRP/NcmKuKNAVJ9251MNjFNJ28v80nnCyQjd
         51Odxh0DKvqXK9kZc+MxlKXOMZo3aQplDYoHGzTsiV5HPXZ1M3n2eHI/5a5z1+t8dty0
         xIm5B6MfWMpDxViO6cFymRWEcjjzY0tijfhqHCLO9SzAHWlwfYeRy1QRGJqkaExOGNPh
         N/a9cxK4OBWWWPjYLT1/D2YynJRnB03POHlN/6x23ak+wVPD8wt5R6zDrt0bYAjk1Y26
         i/uw==
X-Gm-Message-State: APjAAAUe755xP2+4AXUGYHqKI3qM2pNqIhyna5sVipmcD1KI0ktyU5NK
        qc0J7Bvss/uNrvFBuuaxdVgIqG7g
X-Google-Smtp-Source: APXvYqzdhB7tDJ3g5QLX8EFuDEuMdxzsjT3P9cm6YXpDDvyRXdAAb/n34nqOt5tXqQWmN7NzpSRL7g==
X-Received: by 2002:a24:7fc7:: with SMTP id r190mr18489698itc.178.1560265706102;
        Tue, 11 Jun 2019 08:08:26 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y136sm1229569itc.37.2019.06.11.08.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:08:25 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF8PWO021740;
        Tue, 11 Jun 2019 15:08:25 GMT
Subject: [PATCH v2 05/19] xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:08:25 -0400
Message-ID: <20190611150824.2877.65392.stgit@manet.1015granger.net>
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

Commit 9590d083c1bb ("xprtrdma: Use xprt_pin_rqst in
rpcrdma_reply_handler") pins incoming RPC/RDMA replies so they
can be left in the pending requests queue while they are being
processed without introducing a race between ->buf_free and the
transport's reply handler. Therefore RPCRDMA_REQ_F_PENDING is no
longer necessary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |    1 -
 net/sunrpc/xprtrdma/transport.c |    4 +---
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 59b214b..fbc0a9f 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1371,7 +1371,6 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	}
 	req->rl_reply = rep;
 	rep->rr_rqst = rqst;
-	clear_bit(RPCRDMA_REQ_F_PENDING, &req->rl_flags);
 
 	trace_xprtrdma_reply(rqst->rq_task, rep, req, credits);
 	queue_work(buf->rb_completion_wq, &rep->rr_work);
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 1f73a6a..f84375d 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -618,8 +618,7 @@ static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(rqst->rq_xprt);
 	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
 
-	if (test_bit(RPCRDMA_REQ_F_PENDING, &req->rl_flags))
-		rpcrdma_release_rqst(r_xprt, req);
+	rpcrdma_release_rqst(r_xprt, req);
 	trace_xprtrdma_op_free(task, req);
 }
 
@@ -667,7 +666,6 @@ static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
 		goto drop_connection;
 	rqst->rq_xtime = ktime_get();
 
-	__set_bit(RPCRDMA_REQ_F_PENDING, &req->rl_flags);
 	if (rpcrdma_ep_post(&r_xprt->rx_ia, &r_xprt->rx_ep, req))
 		goto drop_connection;
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 2c6c5d8..3c39aa3 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -344,7 +344,6 @@ struct rpcrdma_req {
 
 /* rl_flags */
 enum {
-	RPCRDMA_REQ_F_PENDING = 0,
 	RPCRDMA_REQ_F_TX_RESOURCES,
 };
 

