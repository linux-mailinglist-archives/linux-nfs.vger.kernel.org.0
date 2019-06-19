Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E824BB97
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfFSOc4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:32:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39510 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOcz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:32:55 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so32666499iod.6;
        Wed, 19 Jun 2019 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=R5adNTAX4v/whhBxaGHdcBfgRe+XMScB387JUuJ1wr0=;
        b=UIKxw9l49hAY0WhLxXvmAWmKkS4frPYTojCfGwtDL6fIRX0YsYM26nch/NVvd3LkO9
         9V5jIv4fvAHiJfg2AyDe/UCckd2XdANtr7Px9vvlxQaqEDsKUiFl/dma0CyOf/ayhSGT
         cC87Jt74pnCl47avgldlDdQssnJ/jC0R863z46NYZ06UKgSFfWMMRXuLCbNuvw3mujNe
         58MYHt6hn1u/c729Xvm2zxApJzsDNxVhjxGgJTTP0m66nyHYHJ3PW04O9rJzdjVRoI4J
         tfUsHjkPqziKpqFUT64HUECdsYRieUQldiICA82i6XBURibn2DTygnA40ZoU1dWxi68f
         OhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=R5adNTAX4v/whhBxaGHdcBfgRe+XMScB387JUuJ1wr0=;
        b=XeqtwqfuaziHauBVqu3NHnDtn1RrmvBvOo+I+ie6JpvJrFKqURf4zf0OKKLGMjfdkS
         bDPTBLnh8IIU+bC1BXTfP0o1uZ/yJuPxXYUfHn4sIrrNX8n4JXE3mt8VQDtO8b9fW/Ig
         KZwVkHnRP+jkHmvsidGyUO5XdVtc5h6Yzl1nm25+9GN5nNNSI1MZy/xI+Mv7Z/vY834s
         iVsOIOjHlx67zZ5exDxvOyC2be+TX35cH3cxDb33uARE5sez94F/gL+MaaUYVCFsSAi8
         Asamx2iT8KC+4XLNt4W87lRy7oZ093NQdTnAeDOwFtCwaUmQqqDCbWoGmpt2qaUiVPsa
         gIlQ==
X-Gm-Message-State: APjAAAWxkGcaPtn5VlysoMTMNe0BcbYG6N7pygfwotLpZTugOaPoR0zt
        DwPgVmNujUvMmpITK+s5NCo=
X-Google-Smtp-Source: APXvYqzfRXsZ9jJKUrZys2Ud9+9qfx+BZB2IpVFM3KPihOub9D9mmBGMEcRo7kh2cZ53vECvuibCTw==
X-Received: by 2002:a02:b798:: with SMTP id f24mr93948005jam.97.1560954775245;
        Wed, 19 Jun 2019 07:32:55 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 20sm18774231iog.62.2019.06.19.07.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:32:54 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEWskV004506;
        Wed, 19 Jun 2019 14:32:54 GMT
Subject: [PATCH v4 05/19] xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:32:54 -0400
Message-ID: <20190619143253.3826.13658.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
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
 

