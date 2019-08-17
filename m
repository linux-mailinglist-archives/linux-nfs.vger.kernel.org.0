Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0672A91332
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 23:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfHQVYv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Aug 2019 17:24:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38421 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHQVYv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Aug 2019 17:24:51 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so13240608ioa.5
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2019 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J21Bur1x+P3o8AX2PJsmRWSsWPHyHWcs5Xd+2VCbJJI=;
        b=qGgpawi94Hf7IsduWWZq66SeIl5ua/ZTJKQFR85XlXJUVD0gUaPBkqICY0apIUJ5kP
         DkYzmGe+uTVL25nP1RK6yp09iT+60zrZk9pmHYdIvWEVAPfbBK6NUT6JMU5jRGQ1gpWG
         EVXV/5zIzX4LrtAWIp5y2/bsrFnmwBGaGhz37qxtWJ/Oczhq+VlV4cdtj4X+k+NWpk3y
         ypq5X/LV09r2+o3xz/wg1WfBQTaNER3hzN+EhMWt8XDtp+kwd/7fZiG65snz8gRyk7dn
         Addoj2Qkj6n0IK8YKEXvgolUm62I6oJ4vp5eEk5pjAh7NLrmTADrd5ikzBdMZlVzGJdb
         EkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J21Bur1x+P3o8AX2PJsmRWSsWPHyHWcs5Xd+2VCbJJI=;
        b=eWN9o2q6g9VyfUoU105z4YsAWJ3/qx/B5b3LYhUDRLcuYmrmCI47GgedOaJAVTWrBw
         /luTd9zfCnc6P7QtLkduJY+bmZ8qnFrpvKtnoPgdNmTuxU4+8/Md5C4UL9lrhMw4Y7ef
         2k5dI/cWC6rdmwhTkNFtgWYoLNJmiBghbzWt6p2fWk6jRUcmLGqsG/EnrvweVpY7xOV8
         ocWO+MvUTY0Wtpe5o1sFAgiDKvmJ4iKzKHhRVrQjGGAErLT2RFMCiV8UHVajLsLgbuBy
         qsNb+FTE5O/6k+NqcI+HY4DvfKD/qBHTrCXwtMhgEunabjL7DmlDXhifUP2Pr7Sbl4vL
         hctQ==
X-Gm-Message-State: APjAAAWC4Xb2kbJKdaHeFQncuz62qmRlqPCOx45h1sYvv8xtxkWhCetV
        JSd+gSTxkcJHH/Ff+ZAdJMmeObs=
X-Google-Smtp-Source: APXvYqy/VQWdKTVNGJ1C5jlBnUuDl/Vr1D6S0GJQ2H9uTVNeGPxiw4fxT6aevUZ45OhiYBJ96XjdbQ==
X-Received: by 2002:a5d:824e:: with SMTP id n14mr5186300ioo.205.1566077089819;
        Sat, 17 Aug 2019 14:24:49 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q3sm4609806ios.70.2019.08.17.14.24.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:24:49 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/8] SUNRPC: Handle EADDRINUSE and ENOBUFS correctly
Date:   Sat, 17 Aug 2019 17:22:15 -0400
Message-Id: <20190817212217.22766-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817212217.22766-5-trond.myklebust@hammerspace.com>
References: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
 <20190817212217.22766-2-trond.myklebust@hammerspace.com>
 <20190817212217.22766-3-trond.myklebust@hammerspace.com>
 <20190817212217.22766-4-trond.myklebust@hammerspace.com>
 <20190817212217.22766-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a connect or bind attempt returns EADDRINUSE, that means we want to
retry with a different port. It is not a fatal connection error.
Similarly, ENOBUFS is not fatal, but just indicates a memory allocation
issue. Retry after a short delay.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 92c1c4e02855..9546a4c72838 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2003,6 +2003,9 @@ call_bind_status(struct rpc_task *task)
 		task->tk_rebind_retry--;
 		rpc_delay(task, 3*HZ);
 		goto retry_timeout;
+	case -ENOBUFS:
+		rpc_delay(task, HZ >> 2);
+		goto retry_timeout;
 	case -EAGAIN:
 		goto retry_timeout;
 	case -ETIMEDOUT:
@@ -2026,7 +2029,6 @@ call_bind_status(struct rpc_task *task)
 	case -ENETDOWN:
 	case -EHOSTUNREACH:
 	case -ENETUNREACH:
-	case -ENOBUFS:
 	case -EPIPE:
 		dprintk("RPC: %5u remote rpcbind unreachable: %d\n",
 				task->tk_pid, task->tk_status);
@@ -2124,8 +2126,6 @@ call_connect_status(struct rpc_task *task)
 	case -ENETDOWN:
 	case -ENETUNREACH:
 	case -EHOSTUNREACH:
-	case -EADDRINUSE:
-	case -ENOBUFS:
 	case -EPIPE:
 		xprt_conditional_disconnect(task->tk_rqstp->rq_xprt,
 					    task->tk_rqstp->rq_connect_cookie);
@@ -2134,10 +2134,14 @@ call_connect_status(struct rpc_task *task)
 		/* retry with existing socket, after a delay */
 		rpc_delay(task, 3*HZ);
 		/* fall through */
+	case -EADDRINUSE:
 	case -ENOTCONN:
 	case -EAGAIN:
 	case -ETIMEDOUT:
 		goto out_retry;
+	case -ENOBUFS:
+		rpc_delay(task, HZ >> 2);
+		goto out_retry;
 	}
 	rpc_call_rpcerror(task, status);
 	return;
-- 
2.21.0

