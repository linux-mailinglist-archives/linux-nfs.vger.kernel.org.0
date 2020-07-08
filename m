Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DDA21912A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGHUJS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUJS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF36C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:18 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e13so42845936qkg.5
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qoA1caBVXdzerjmf1plX8nTe7VlvEoZAa17JiDZydjI=;
        b=CxdzxFKTMV8rC0u0M4ncqmuwG9Jg2xgzE7AUcv7FeslpNTSdWLqQcNGzqNrhx/0KsZ
         RUUC90YHOZOGNkXrEcX3NNqMvLNB9ctihqtnz5U5sYgCrUaoLWIcPF47LgPd8taBGi3t
         K8jyQ49AxI6aWARU7f+pduMHhBm7O+biz2/TKR+Tr09WTVKAY4NSoZ9Fwke8k4uiDp3G
         Oz/Xac6b8r6Zl3K+rDDF7mofirmtS2xwvnGN1b++g52d7VpsUM5AYyDwel2+hconjfen
         AiMDSuyH8p/+MR841edGan6GpkrLZPKANjy9+D+UzLE/0fPZ4DCGGM9ts7rBbdkMNmUZ
         1Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qoA1caBVXdzerjmf1plX8nTe7VlvEoZAa17JiDZydjI=;
        b=DhOM/5ByioOFOKbEHHMzH2j/LeJbbUCjwWQXzCOduRk0OhRc+K+dYYWfEQ6vwvV44X
         3GAWFP4DJHCVjvUv7uvFB3spLzHdJZYFDl7OOPJuNLbD/DCexJaHHjzVaecpEYl/fbqh
         vkl3XouIsCqsYI7C7DnxbLxSRBGRE4QX1XMxiI09Nm0zjcr86osfIAVYnb0U8rxii02/
         wOAv4AbbiNNpGKTEuhVNJofAAsVJya1ahk4cyL288eFakV28l1BY1TUMt051QkteOudF
         zptPGUYWOvW5KvllyE9ZTnUP8HI7BF+hoZ80QmvOFLokVhDeBYyOKPPf2+w+PXfxxy/H
         V8iA==
X-Gm-Message-State: AOAM530KILKpCPkUv44xyNIvr+p5ifSBtzha3imuB2qt7Jb6x40kJrEg
        2wDOdh1WHt5BEYvNsa0mfRV9/Dbb
X-Google-Smtp-Source: ABdhPJyD/eeyA2GzY8RR80MGc9g1/gOnBX7KDC4gLYmF/OPnlJm7lvByTNBWKWNh050ARyomqq/BUw==
X-Received: by 2002:a37:957:: with SMTP id 84mr52441921qkj.392.1594238957243;
        Wed, 08 Jul 2020 13:09:17 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f4sm823047qtv.59.2020.07.08.13.09.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:16 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9Gdd006072
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:16 GMT
Subject: [PATCH v1 03/22] SUNRPC: Remove debugging instrumentation from
 xprt_release
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:16 -0400
Message-ID: <20200708200916.22129.86702.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These instruments don't appear to add any substantial value.

We already have this at the termination of each RPC:

          iozone-2617  [002]   975.713126: rpc_stats_latency:    task:418@5 xid=0x260eab5d nfsv3 LOOKUP backlog=15 rtt=32 execute=58
          iozone-2617  [002]   975.713127: xprt_release_cong:    task:418@5 snd_task:4294967295 cong=256 cwnd=16384
          iozone-2617  [002]   975.713127: xprt_put_cong:        task:418@5 snd_task:4294967295 cong=0 cwnd=16384

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   32 --------------------------------
 net/sunrpc/sched.c              |    3 ---
 net/sunrpc/xprt.c               |    1 -
 net/sunrpc/xprtrdma/transport.c |    2 --
 4 files changed, 38 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 920621536731..4a93c166512b 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1146,38 +1146,6 @@ TRACE_EVENT(xprtrdma_decode_seg,
 	)
 );
 
-/**
- ** Allocation/release of rpcrdma_reqs and rpcrdma_reps
- **/
-
-TRACE_EVENT(xprtrdma_op_free,
-	TP_PROTO(
-		const struct rpc_task *task,
-		const struct rpcrdma_req *req
-	),
-
-	TP_ARGS(task, req),
-
-	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(const void *, req)
-		__field(const void *, rep)
-	),
-
-	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
-		__entry->req = req;
-		__entry->rep = req->rl_reply;
-	),
-
-	TP_printk("task:%u@%u req=%p rep=%p",
-		__entry->task_id, __entry->client_id,
-		__entry->req, __entry->rep
-	)
-);
-
 /**
  ** Callback events
  **/
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index adce1e2ed10d..402b1c8869fd 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1056,9 +1056,6 @@ void rpc_free(struct rpc_task *task)
 	buf = container_of(buffer, struct rpc_buffer, data);
 	size = buf->len;
 
-	dprintk("RPC:       freeing buffer of size %zu at %p\n",
-			size, buf);
-
 	if (size <= RPC_BUFFER_MAXSIZE)
 		mempool_free(buf, rpc_buffer_mempool);
 	else
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 09bf7bf94adc..46db56e1aa38 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1827,7 +1827,6 @@ void xprt_release(struct rpc_task *task)
 	if (req->rq_release_snd_buf)
 		req->rq_release_snd_buf(req);
 
-	dprintk("RPC: %5u release request %p\n", task->tk_pid, req);
 	if (likely(!bc_prealloc(req)))
 		xprt->ops->free_slot(xprt, req);
 	else
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 612b60f31302..819a922830da 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -605,8 +605,6 @@ xprt_rdma_free(struct rpc_task *task)
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(rqst->rq_xprt);
 	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
 
-	trace_xprtrdma_op_free(task, req);
-
 	if (!list_empty(&req->rl_registered))
 		frwr_unmap_sync(r_xprt, req);
 

