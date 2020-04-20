Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426221AFF11
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 02:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDTADI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 20:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgDTADH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 20:03:07 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE99CC061A0C;
        Sun, 19 Apr 2020 17:03:07 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id bu9so3864492qvb.13;
        Sun, 19 Apr 2020 17:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EZzXatXdWovisRa+J/057yOG/K1FIo6DnKRkHWhL0f4=;
        b=Zqal0IcfBM0ROSI6dXyyGmG3ESZAf7BUv4LcujweEqCivl/8OMRnzSsHh+hk/oO1+U
         o+Lp3Paxt7ji6uBXByDmaY3LKrcqmQOt5E84knWEqXC65V1Ovz+2LAIxMQd/92bLtBZl
         cpygtuj5wFO/wRyJ236j9APBPIAA44FLZeB4Ra0JtcfsI0iREggmyPC71ljmxUU+V0Qo
         vqfzocWlb/PenHC43KOP0aI3ExLGNXhsOrq9V5t8Qs7jQmw3ht5H02mpBbbISdiUktm8
         53WfNOJKNDcyynrAFvJcUb6jqVPiW+gg41IvH87N/2yFw9ZL1GrBTA1SODUz5OqOeHlK
         Dicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EZzXatXdWovisRa+J/057yOG/K1FIo6DnKRkHWhL0f4=;
        b=F2lA09oYCzia8Nt+iXQVzndv7VGmGXPJHwNy5o/NI1AM4jUL90mtz/VSYFnyqf7LUS
         /MzbkygVgamKScevLtUyhtQA0N+zarf8yeH6p3GzxURSI63Q9v93t6/9LvLQkSVRrqki
         LIGQ4y67uLXJl/y9sRLamMNiVcwbLvNqpEVeP7P+Shqk0H4QBvZ5V+qFZqT9C4ECwxwz
         gMaGqZBqnjXaDXNs4gUGHu46ww3EcsJIaEO52luzcW4kQ/tzJ4MmnUOVfN3KvQqXdMcX
         nA8xUbIjjf7G7LdBXu/wAHDPc1bu9PJkLvNsDbOQV0Ib1Vh3g+IWwGTwGSoyMTxsQ7Eb
         9+OQ==
X-Gm-Message-State: AGi0PuZ8cF4BAuQhm+w16dyzwWlhkOFGMfN04TsZJuyfjNcZrv9OYWWR
        XtXjOt9/wGS8qaqvepwQpOc9MmkH
X-Google-Smtp-Source: APiQypJZza/w3gH3QSaGQh5KQFzUUIDtuz5p4ePvnrwSUGy4LGwT4Ovymi0SHkupzQBebivbbKkk/w==
X-Received: by 2002:a0c:c78a:: with SMTP id k10mr7121312qvj.84.1587340987084;
        Sun, 19 Apr 2020 17:03:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p80sm1532504qke.96.2020.04.19.17.03.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 17:03:06 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03K035AR016696;
        Mon, 20 Apr 2020 00:03:05 GMT
Subject: [PATCH 2/3] xprtrdma: Fix trace point use-after-free race
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Sun, 19 Apr 2020 20:03:05 -0400
Message-ID: <20200420000305.6417.43215.stgit@manet.1015granger.net>
In-Reply-To: <20200420000223.6417.32126.stgit@manet.1015granger.net>
References: <20200420000223.6417.32126.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It's not safe to use resources pointed to by the @send_wr of
ib_post_send() _after_ that function returns. Those resources are
typically freed by the Send completion handler, which can run before
ib_post_send() returns.

Thus the trace points currently around ib_post_send() in the
client's RPC/RDMA transport are a hazard, even when they are
disabled. Rearrange them so that they touch the Work Request only
_before_ ib_post_send() is invoked.

Fixes: ab03eff58eb5 ("xprtrdma: Add trace points in RPC Call transmit paths")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   12 ++++--------
 net/sunrpc/xprtrdma/verbs.c    |    2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 051f26fedc4d..72f043876019 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -692,11 +692,10 @@
 
 TRACE_EVENT(xprtrdma_post_send,
 	TP_PROTO(
-		const struct rpcrdma_req *req,
-		int status
+		const struct rpcrdma_req *req
 	),
 
-	TP_ARGS(req, status),
+	TP_ARGS(req),
 
 	TP_STRUCT__entry(
 		__field(const void *, req)
@@ -705,7 +704,6 @@
 		__field(unsigned int, client_id)
 		__field(int, num_sge)
 		__field(int, signaled)
-		__field(int, status)
 	),
 
 	TP_fast_assign(
@@ -718,15 +716,13 @@
 		__entry->sc = req->rl_sendctx;
 		__entry->num_sge = req->rl_wr.num_sge;
 		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
-		__entry->status = status;
 	),
 
-	TP_printk("task:%u@%u req=%p sc=%p (%d SGE%s) %sstatus=%d",
+	TP_printk("task:%u@%u req=%p sc=%p (%d SGE%s) %s",
 		__entry->task_id, __entry->client_id,
 		__entry->req, __entry->sc, __entry->num_sge,
 		(__entry->num_sge == 1 ? "" : "s"),
-		(__entry->signaled ? "signaled " : ""),
-		__entry->status
+		(__entry->signaled ? "signaled" : "")
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 29ae982d69cf..05c4d3a9cda2 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1356,8 +1356,8 @@ int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		--ep->re_send_count;
 	}
 
+	trace_xprtrdma_post_send(req);
 	rc = frwr_send(r_xprt, req);
-	trace_xprtrdma_post_send(req, rc);
 	if (rc)
 		return -ENOTCONN;
 	return 0;

