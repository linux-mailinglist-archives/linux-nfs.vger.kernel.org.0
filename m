Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F732AC532
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbgKITkN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITkN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:40:13 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA2C0613CF;
        Mon,  9 Nov 2020 11:40:12 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so2492375qtp.1;
        Mon, 09 Nov 2020 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/1dcw057r2tJOx2Fks3SvWO0kO71vtvTy0GCH8i0dXw=;
        b=tkvpJ78POSsgDvYAc1NOG2Bi6cqpx0vkQBXU9dmrxsahDFsYvtnSLEojAT1jjQNsBA
         wfr9amsoifDenjBbxd6K0ullhC4mfGV4q9Rn4s8GkOQHSKtJ4G5kCUm1t+VX2FjsaYkK
         AdKY+w7lu3Mm36u3sYTFDW0vCA8s4ezjpTCb/mjMg+HvbWAlM08SIYLrwnBnaytizSH0
         xNIKDig0Au0ACq8P5z0jARY9dNZQq8yliyYMxQsk0OCDWTIPI0vIXYieH4D/iiwVq6s9
         e5gMy2O6AT07ivYUb4cx/PV5oQi2xlg9ax/khbvZDYkHobrM+xYQR26yDgRtQxHl53hH
         3Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/1dcw057r2tJOx2Fks3SvWO0kO71vtvTy0GCH8i0dXw=;
        b=PSiv7FhsUBSFYwUyaSQ2RgOGrA0dfOyq+7cHi3KFVKDwkzVJs0eZO6ac3hFW5Xb5n+
         KR3k7elELnJCEIwLGGj2IQXMZ/VuxzjaHYw+ywRqElPG/t1YsAcKdAcMB+AE0ubo/Tbt
         iLkXFzxJBBdl25GNERVjZE0HWFODEan0ayXOcBqco+KxUu8wAwnorP4TGCp99rM0+zeK
         Szc3V+wzuqwPhGE+RC3mgOtMj+/CpUl0ZVkFENYoyZzZQFGnAmUoEDYpzow6wvPg5tl/
         XS1t555n+W1UJ3gIXbMcck1p7NlIph2/jI6n6nNpI+6pCyMhMI2TM5sIAiwF3WfV5O94
         P/Qw==
X-Gm-Message-State: AOAM531iofuzceJbktoxT6uuMMLkBxdxTCrizyuprtVPifTQl9Gh8Tgo
        NqA0Eqn/wIdb6KPLVq0C+7nKCBULFI4=
X-Google-Smtp-Source: ABdhPJxJJlpn/yPKSnKaEOOBDahYunN2T24N4GnmpHlkAGUiRXzvPN3/3Yrnaog2O/1s8jDhCYwr8A==
X-Received: by 2002:ac8:5c50:: with SMTP id j16mr6457555qtj.306.1604950810984;
        Mon, 09 Nov 2020 11:40:10 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f61sm6333372qtb.75.2020.11.09.11.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:40:10 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9Je8uG021832;
        Mon, 9 Nov 2020 19:40:08 GMT
Subject: [PATCH v1 11/13] xprtrdma: Trace unmap_sync calls
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:40:08 -0500
Message-ID: <160495080890.2072548.7029643130998432677.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

->buf_free is called nearly once per RPC. Only rarely does
xprt_rdma_free() have to do anything, thus tracing every one of
these calls seems unnecessary. Instead, just throw a trace event
when that one occasional RPC still has MRs that need to be
released.

xprt_rdma_free() is further micro-optimized to reduce the amount of
work done in the common case.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   22 ++++++++++++++++++++++
 net/sunrpc/xprtrdma/transport.c |    7 ++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 166bbeef996c..69e1caf7e882 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1167,6 +1167,28 @@ TRACE_EVENT(xprtrdma_decode_seg,
 	)
 );
 
+TRACE_EVENT(xprtrdma_mrs_zap,
+	TP_PROTO(
+		const struct rpc_task *task
+	),
+
+	TP_ARGS(task),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client->cl_clid;
+	),
+
+	TP_printk("task:%u@%u",
+		__entry->task_id, __entry->client_id
+	)
+);
+
 /**
  ** Callback events
  **/
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 8915e42240d3..bb3ed3db6c0a 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -599,11 +599,12 @@ static void
 xprt_rdma_free(struct rpc_task *task)
 {
 	struct rpc_rqst *rqst = task->tk_rqstp;
-	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(rqst->rq_xprt);
 	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
 
-	if (!list_empty(&req->rl_registered))
-		frwr_unmap_sync(r_xprt, req);
+	if (unlikely(!list_empty(&req->rl_registered))) {
+		trace_xprtrdma_mrs_zap(task);
+		frwr_unmap_sync(rpcx_to_rdmax(rqst->rq_xprt), req);
+	}
 
 	/* XXX: If the RPC is completing because of a signal and
 	 * not because a reply was received, we ought to ensure


