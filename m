Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA421912F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGHUJk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUJj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584C9C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so42847001qkg.5
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QM2BLZmXpGMbCgx/uKoAYKdw+KC0GZuNoaaGEWC/1uQ=;
        b=cMTZyd/bpeN2RcI3moHvZDF+qJTjiXDe6bHZTodmdLmE3ARFNVnqyH/F1ICaAnWSB1
         RbT3RDmCQOKdWsUvKurebXJL5bOy9RfWEAe7+a8dtMOkDJ3X7VbYnFDLR/0dqAM3sgj2
         Bzk9eSM3I0h/f/ijpFh9w4g3uyk1rDpBSPKMkAbpgPvmcbRoZP/X3gz+m6aDd252Q1qK
         0fPRSDwGtRtlfGwwuIX36jNJnLQsxbYa1Uj+tUzET4MurA0jNpcqhtjmHWq4nP69ePnY
         Va4dpE5eEUPd6/97jeZmBhWIkT1AM1NGTVX8DNHrWooTz3i9KgQUSkc8DchLKBE8e588
         qosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=QM2BLZmXpGMbCgx/uKoAYKdw+KC0GZuNoaaGEWC/1uQ=;
        b=ea0iZXrM8d6OKO9IvC0V3gyhyq7CrMvpY47jiWAoUoECPxUn2VpMnip1twx73W1OEP
         8Dfz9ahrcSGKUuWcQbkg+lcLiF3v8KPXBOVxc3g9ROeL7aykQU8fFyzpuJZnmeo3126H
         pB0ykrGysus3WJyg8I+xYCEso3dbFmOPyBrM/qxwMJZCjcNZSEyGQUN94SSM42ZSeWWa
         L7tjgLgGFXXigrixQwQGls4zqqru+V6CCHWDy/ZOEIfs5szfhGy7jrBv4oRhEKCL5aXv
         2WhTpvNMKTXiZws6TwkPOCrut+sl7hgZYMIcY5UAMLGcgRX0OwnL9ctk9oOqMqwPtKi+
         ArUw==
X-Gm-Message-State: AOAM5321UKNFiQ+BqT9PlXU7kQB86HxaGyFHnSdkFtE0M/83j5zS4FvR
        CXWi2Wi5AyXVqNX0L92nenPRg8x7
X-Google-Smtp-Source: ABdhPJwMz0mJqg/0irYXzUqAB5ZuoSnRS1EtD3Et1/Mh4RNJv4AEo9kscl8M09o7qyxUy/LV6hAfNg==
X-Received: by 2002:a37:9cd0:: with SMTP id f199mr53776657qke.76.1594238978323;
        Wed, 08 Jul 2020 13:09:38 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o15sm977043qko.67.2020.07.08.13.09.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:38 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9bpW006084
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:37 GMT
Subject: [PATCH v1 07/22] SUNRPC: Remove the dprint_status() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:37 -0400
Message-ID: <20200708200937.22129.99263.stgit@manet.1015granger.net>
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

Clean up: The rpc_task_run_action tracepoint serves the same
purpose.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |   31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2086f4389996..d8bc47a4a848 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -47,10 +47,6 @@
 # define RPCDBG_FACILITY	RPCDBG_CALL
 #endif
 
-#define dprint_status(t)					\
-	dprintk("RPC: %5u %s (status %d)\n", t->tk_pid,		\
-			__func__, t->tk_status)
-
 /*
  * All RPC clients are linked into this list
  */
@@ -1658,8 +1654,6 @@ call_start(struct rpc_task *task)
 static void
 call_reserve(struct rpc_task *task)
 {
-	dprint_status(task);
-
 	task->tk_status  = 0;
 	task->tk_action  = call_reserveresult;
 	xprt_reserve(task);
@@ -1675,8 +1669,6 @@ call_reserveresult(struct rpc_task *task)
 {
 	int status = task->tk_status;
 
-	dprint_status(task);
-
 	/*
 	 * After a call to xprt_reserve(), we must have either
 	 * a request slot or else an error status.
@@ -1717,8 +1709,6 @@ call_reserveresult(struct rpc_task *task)
 static void
 call_retry_reserve(struct rpc_task *task)
 {
-	dprint_status(task);
-
 	task->tk_status  = 0;
 	task->tk_action  = call_reserveresult;
 	xprt_retry_reserve(task);
@@ -1730,8 +1720,6 @@ call_retry_reserve(struct rpc_task *task)
 static void
 call_refresh(struct rpc_task *task)
 {
-	dprint_status(task);
-
 	task->tk_action = call_refreshresult;
 	task->tk_status = 0;
 	task->tk_client->cl_stats->rpcauthrefresh++;
@@ -1746,8 +1734,6 @@ call_refreshresult(struct rpc_task *task)
 {
 	int status = task->tk_status;
 
-	dprint_status(task);
-
 	task->tk_status = 0;
 	task->tk_action = call_refresh;
 	switch (status) {
@@ -1792,8 +1778,6 @@ call_allocate(struct rpc_task *task)
 	const struct rpc_procinfo *proc = task->tk_msg.rpc_proc;
 	int status;
 
-	dprint_status(task);
-
 	task->tk_status = 0;
 	task->tk_action = call_encode;
 
@@ -1882,7 +1866,7 @@ call_encode(struct rpc_task *task)
 {
 	if (!rpc_task_need_encode(task))
 		goto out;
-	dprint_status(task);
+
 	/* Dequeue task from the receive queue while we're encoding */
 	xprt_request_dequeue_xprt(task);
 	/* Encode here so that rpcsec_gss can use correct sequence number. */
@@ -1959,8 +1943,6 @@ call_bind(struct rpc_task *task)
 		return;
 	}
 
-	dprint_status(task);
-
 	task->tk_action = call_bind_status;
 	if (!xprt_prepare_transmit(task))
 		return;
@@ -1982,7 +1964,6 @@ call_bind_status(struct rpc_task *task)
 		return;
 	}
 
-	dprint_status(task);
 	trace_rpc_bind_status(task);
 	if (task->tk_status >= 0)
 		goto out_next;
@@ -2109,7 +2090,6 @@ call_connect_status(struct rpc_task *task)
 		return;
 	}
 
-	dprint_status(task);
 	trace_rpc_connect_status(task);
 
 	if (task->tk_status == 0) {
@@ -2177,8 +2157,6 @@ call_transmit(struct rpc_task *task)
 		return;
 	}
 
-	dprint_status(task);
-
 	task->tk_action = call_transmit_status;
 	if (!xprt_prepare_transmit(task))
 		return;
@@ -2213,7 +2191,6 @@ call_transmit_status(struct rpc_task *task)
 
 	switch (task->tk_status) {
 	default:
-		dprint_status(task);
 		break;
 	case -EBADMSG:
 		task->tk_status = 0;
@@ -2295,8 +2272,6 @@ call_bc_transmit_status(struct rpc_task *task)
 	if (rpc_task_transmitted(task))
 		task->tk_status = 0;
 
-	dprint_status(task);
-
 	switch (task->tk_status) {
 	case 0:
 		/* Success */
@@ -2356,8 +2331,6 @@ call_status(struct rpc_task *task)
 	if (!task->tk_msg.rpc_proc->p_proc)
 		trace_xprt_ping(task->tk_xprt, task->tk_status);
 
-	dprint_status(task);
-
 	status = task->tk_status;
 	if (status >= 0) {
 		task->tk_action = call_decode;
@@ -2491,8 +2464,6 @@ call_decode(struct rpc_task *task)
 	struct xdr_stream xdr;
 	int err;
 
-	dprint_status(task);
-
 	if (!task->tk_msg.rpc_proc->p_decode) {
 		task->tk_action = rpc_exit_task;
 		return;

