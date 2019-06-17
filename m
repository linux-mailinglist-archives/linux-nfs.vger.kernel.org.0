Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5448734
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfFQPb6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:31:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40498 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPb6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:31:58 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so22069498ioc.7;
        Mon, 17 Jun 2019 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=R5adNTAX4v/whhBxaGHdcBfgRe+XMScB387JUuJ1wr0=;
        b=vQLl4TDVt1vJA/j3K5Z3am8RK/S9PnEBJPz/A5sa4axNsgT3sb2NxjsU8TskWDxCU4
         kDNCLga9GjIeCHsAWJo/9GD1IwOCaMFAYr+e7MlzA8d+pot/iWRVfsu1KYA/vwlQEd03
         WDkezP0QJJmoc1oGML2DlOpud2gve1nbUCZ6zlaEoPyospQN0bH4sjQHFMNuBGySuuWx
         LvSkpxHmXMqw/e1NYGcCsqbrFtqH89/pKMcV+fXNHrqYCrNUsqcORJDjrw5UAERpfbZz
         WotZxs/aJO3b774HCE5npQjwekSgZ9n6fOP5vSE2iKpa99eHPPYTvQYSIjbr8/KFIH1+
         GhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=R5adNTAX4v/whhBxaGHdcBfgRe+XMScB387JUuJ1wr0=;
        b=ZB5TlfVMitsUeU6ZYTOEl+zWCw6fcNflGhGpUVcBM7Sd56jISvdJjSmIAjcNTMcLuh
         c/MInuWiyoDA3/hyDF/HuWNACqHWr7dDa1+YhU3Phl2fn4CZA1VYyQPDYL3AQQfk1hoP
         n7oGpnJqpL3iNSS8xv4LXEgUYsNbN1vZswcK1TRHzQCLmrxOGSKr3tg/1roxMqe47Ufx
         ovj/NTUy2FgODI9OgQd0jTC0vxUCKGvlXkMwKeBRmlqQ88zv6v0+BBhgSCTP9mA7AChw
         u1bQDcPmPll67iRrIkR3+YAkM/oLrzszsXC0bP4qDpJJ11GrwHzR6M3rsi7LPXHnIoT4
         SxgQ==
X-Gm-Message-State: APjAAAW7tgIPpHjbU6Jm3AzOItvNo48D1rcr9o+8PG5m+A9knnOH5bvi
        UygDotNeGn2J8ExG/T7e4NxIG870
X-Google-Smtp-Source: APXvYqzngqjdafYseKRRAFcgvnwA1NWfLKB2YlK6Vo+3PF2oIlUFNo1meZ6YGpBULbg9Y+fREqNSEA==
X-Received: by 2002:a5e:d507:: with SMTP id e7mr24587149iom.284.1560785517532;
        Mon, 17 Jun 2019 08:31:57 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z17sm12054987iol.73.2019.06.17.08.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:31:57 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFVuJa031200;
        Mon, 17 Jun 2019 15:31:56 GMT
Subject: [PATCH v3 05/19] xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:31:56 -0400
Message-ID: <20190617153156.12090.87019.stgit@manet.1015granger.net>
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
 

