Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDCF2CE74
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfE1SVO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:21:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38341 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfE1SVO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:21:14 -0400
Received: by mail-io1-f67.google.com with SMTP id x24so16569483ion.5;
        Tue, 28 May 2019 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dtCtmMjHsjE9+kkAKoJ+QHjUK+M5LzkEDCShi/9x3lE=;
        b=KKr4p9YYrbTqgQDAGj/Bpx3x5ZsFeg53mO1YqlqIoxdDnILG+Pkd3obctftnPBqd4s
         xk19tyMZ1G1CjbjUS4icpPUsTvC9L+u8krCIkfUQkasKYQacr/9+HJeBxXuOmSxTaycu
         ecusTphT78ri4+7z5pMcdAihceMYOwZKZnl6/BbgU1zR5bNfFLpkL6GO5lJ76MHnsDjd
         FNQ03kWkVXaIEWeaB+hvdurg46vYPZ2jNPR0jPTmygk/ohGx+W5rn6HSz2Xg++DpYOJd
         turwkKWWuKEHgCdo78xuaTuk0Qqel8qQxrn3wH58mrhPvaGDoNTQsUCx5Lp/0eRgEWKd
         h8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dtCtmMjHsjE9+kkAKoJ+QHjUK+M5LzkEDCShi/9x3lE=;
        b=JikJsUkSMNTiC8QGc5hJEv/wTFUoXRpzL+VM591Jdgbykqwjuee1Redvn3CF11bpy+
         CjN9Szf0GKogug1vStO31eHesOnXxqtZ7GvAisE1OxMCcwL9snlGkdtRdS2l3rVtACLn
         N5gMwXdrePgn+hZ6//Vzp+MZqcyHzK/bGQHCPCr8IJZP3JYqQMeC/a9FIxYN1ncnfn8F
         idIXtVkjycFZrmBmr8U+n9FnGA+aWq/8fGAlNxxhq81m9HvqtnYYH8YPv3VvAIp+EnJK
         Y7YK7lfqRiGbHSuoVhfDGg41A7QQ19rdYkuj6woaPwvoiEKbaJTfkB8fbAuDX0QVVmTq
         f3Jw==
X-Gm-Message-State: APjAAAWW3eWQ15Gzcb+4UgM42ggXCmAVEjys2kaQkeIuwqeqzoBGMkgj
        kCCm+nQpbtfOShqU5BV5H3MGnkan
X-Google-Smtp-Source: APXvYqyWWLW4/XiAWJcCtmCPFolMjm/f3NtCRzjFBGD9PsflA5Vx6U/e5UqC3efLgyJFr4mFKSL9Cg==
X-Received: by 2002:a05:6602:1d6:: with SMTP id w22mr20582789iot.215.1559067673208;
        Tue, 28 May 2019 11:21:13 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q72sm1592587ita.26.2019.05.28.11.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:21:12 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SILBxI014525;
        Tue, 28 May 2019 18:21:11 GMT
Subject: [PATCH RFC 04/12] xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:21:11 -0400
Message-ID: <20190528182111.19012.50313.stgit@manet.1015granger.net>
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
index d1f44f4..77fc1e4 100644
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
 

