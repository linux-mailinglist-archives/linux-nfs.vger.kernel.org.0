Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD521912D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGHUJ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUJ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA638C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id di5so16160110qvb.11
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fCtDa06mPq6ZTSYBBiRIxER6Hyy4bfd7uPI24tfejdE=;
        b=DVrOTRu+hFRXS8/IqHsJipROZ9uQFokb84F+1ZcPCWtq5opl8jrDSemGLGzSCyf5Cy
         sKqDwCBU+qjhMApDOIftvWS4Q6sAp3yKrS6OuOt7ljXUFj7J/5FapOPTJA2OUqnkCSTn
         OGEmbNzqd2JJPiH9U1o8Q5dlUy5v73k723vwyDy1hy/VPm19dqCi+7D2NmLdWI1n7zC6
         GFNqrtBc6IiuJk2E9ZYCQKpT/YtfFSnkxLI+iobZDOzNoK96YmOkB0nkcRcISAZPwe41
         5//2lLV+tpaGrGkQxoHMyvjjIk88FdftDXcJGebX3ql5uw5gxeBmSlLetI1LA8P7+D7D
         dy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=fCtDa06mPq6ZTSYBBiRIxER6Hyy4bfd7uPI24tfejdE=;
        b=Y9H6Qe9LBeXZhr69RyOATgNG21ipc/0HdkNECkpJpHCispJUVK2152vnZIPyJDqTkP
         tm9XMvIKjpAotfBV/BBiCZf1YK561TIBDTH7PgY34KfE+mXO8hHRVa/Rbs4rvnkDF35F
         8iyktxJN6F/NqflsOg0dU6UcDNGqgNUQAv+eOFj11J6/A7F76YEsNiCfHFq75zJu5+LS
         8sh9ZVu8xPK93+VydzJEQ6r30TnO6exb4ejggkfJb/w7vQ4QOAigpyHsyWIma8ZS1aRl
         myxnfkaei1YRcERQ5CtWXFhTtgMxz5PIfayySTl6731XERr4IFPt2WYr8jhVif8HBWiU
         QdKg==
X-Gm-Message-State: AOAM530RJFMzLNq89aGT2cHjPaRpoIECUVDnv4jVpmJDpQeEnEse9Ah8
        d3JQalDKUix0D9/5KjAeO3Fnr5VB
X-Google-Smtp-Source: ABdhPJyxgfKbOwZ/dW6Ur/JVOfIK4R7T2WmyVTJ3B4zHp8/kjnG7u6n5Zu5aDFKu+5FnZ7UYDpCoCw==
X-Received: by 2002:a0c:f2c5:: with SMTP id c5mr59906934qvm.156.1594238967959;
        Wed, 08 Jul 2020 13:09:27 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a5sm784864qtd.84.2020.07.08.13.09.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:27 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9QWn006078
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:26 GMT
Subject: [PATCH v1 05/22] SUNRPC: Replace dprintk() call site in
 xprt_prepare_transmit
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:26 -0400
Message-ID: <20200708200926.22129.1042.stgit@manet.1015granger.net>
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

Generate a trace event when an RPC request is queued without being
sent immediately.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/xprt.c             |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 7ff40870d122..b5d1ed7f996a 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1093,6 +1093,7 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 
 DEFINE_WRITELOCK_EVENT(reserve_xprt);
 DEFINE_WRITELOCK_EVENT(release_xprt);
+DEFINE_WRITELOCK_EVENT(transmit_queued);
 
 DECLARE_EVENT_CLASS(xprt_cong_event,
 	TP_PROTO(
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index cb5cf74105aa..1ce89778119c 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1399,9 +1399,9 @@ bool xprt_prepare_transmit(struct rpc_task *task)
 	struct rpc_rqst	*req = task->tk_rqstp;
 	struct rpc_xprt	*xprt = req->rq_xprt;
 
-	dprintk("RPC: %5u xprt_prepare_transmit\n", task->tk_pid);
-
 	if (!xprt_lock_write(xprt, task)) {
+		trace_xprt_transmit_queued(xprt, task);
+
 		/* Race breaker: someone may have transmitted us */
 		if (!test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate))
 			rpc_wake_up_queued_task_set_status(&xprt->sending,

