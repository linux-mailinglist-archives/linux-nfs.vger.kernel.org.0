Return-Path: <linux-nfs+bounces-2561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDC891F00
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826EF28DB28
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02541BE62F;
	Fri, 29 Mar 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMgoKSAe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B601BE62E;
	Fri, 29 Mar 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716680; cv=none; b=lg8DRvuiQBKPT6WD9HmrQ/QwpA8G+31VtttQrQ1+mHBzsVy1EQQKvOgsAhYur2/CYFYo8YRlgD7hHXXsVyd8Gd9nDpMIKmZZZ0aKC10tJDGlvnkTmGgpNPnL8Qft7Qh+fAVFXd/Dl4PhFUz2a05auIO9QRXi08lein8i1gXpJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716680; c=relaxed/simple;
	bh=89DVC1TNx4YYw4n/u2khFqCOeFDZNMylMEZNDf18SDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHI83nWwAXnsk2alPQuDZxOhIoll3ae/rRCFtwlItAcL8/FXjOzrAsMeLAa1hKGt9VrXCUl5QhIqZyizyR4jSGoi+jr8kDyUfCGU0Kbig8wIkk7WKmSkJQXavdr5u4ngOnukM+/pAYNjAbW3Ro4Ri1hn92bv2D2/kZmgaEfIRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMgoKSAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E7AC433F1;
	Fri, 29 Mar 2024 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716680;
	bh=89DVC1TNx4YYw4n/u2khFqCOeFDZNMylMEZNDf18SDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMgoKSAe+dWCVtu+D0ENuONdhKtJuoTSrCrfAC1Nl2zMWvAzjXTZGw3JKPeLIhdql
	 PEWMwyVhQawW2O8glMxmriKFXyABfa8O0+gWa5lHx9uZxmDVh73JaUmxTGw7HYRpYY
	 93mRgW4950VHtAbYLAh3bAWOMhA0PXZCgMwJYqJEDjkzrSXoCQjxFbboFarf0hL36A
	 NHIVjLZ0sT8cuYOvcLSPV1X719PFr8dHVJS/UBGVyqF+H8CXToc16Wp86QRSa4TRvK
	 Z6lP6XjtLZyIATDXsqzupebhn9kX/f6pnxp7Q+ADAeRDHql2wak7jN37wS4v4zJUhy
	 pEsFWqvthTKtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	anna@kernel.org,
	chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/19] SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int
Date: Fri, 29 Mar 2024 08:50:42 -0400
Message-ID: <20240329125100.3094358-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 2c35f43b5a4b9cdfaa6fdd946f5a212615dac8eb ]

When the NFS client is under extreme load the rpc_wait_queue.qlen counter
can be overflowed. Here is an instant of the backlog queue overflow in a
real world environment shown by drgn helper:

rpc_task_stats(rpc_clnt):
-------------------------
rpc_clnt: 0xffff92b65d2bae00
rpc_xprt: 0xffff9275db64f000
  Queue:  sending[64887] pending[524] backlog[30441] binding[0]
XMIT task: 0xffff925c6b1d8e98
     WRITE: 750654
        __dta_call_status_580: 65463
        __dta_call_transmit_status_579: 1
        call_reserveresult: 685189
        nfs_client_init_is_complete: 1
    COMMIT: 584
        call_reserveresult: 573
        __dta_call_status_580: 11
    ACCESS: 1
        __dta_call_status_580: 1
   GETATTR: 10
        __dta_call_status_580: 4
        call_reserveresult: 6
751249 tasks for server 111.222.333.444
Total tasks: 751249

count_rpc_wait_queues(xprt):
----------------------------
**** rpc_xprt: 0xffff9275db64f000 num_reqs: 65511
wait_queue: xprt_binding[0] cnt: 0
wait_queue: xprt_binding[1] cnt: 0
wait_queue: xprt_binding[2] cnt: 0
wait_queue: xprt_binding[3] cnt: 0
rpc_wait_queue[xprt_binding].qlen: 0 maxpriority: 0
wait_queue: xprt_sending[0] cnt: 0
wait_queue: xprt_sending[1] cnt: 64887
wait_queue: xprt_sending[2] cnt: 0
wait_queue: xprt_sending[3] cnt: 0
rpc_wait_queue[xprt_sending].qlen: 64887 maxpriority: 3
wait_queue: xprt_pending[0] cnt: 524
wait_queue: xprt_pending[1] cnt: 0
wait_queue: xprt_pending[2] cnt: 0
wait_queue: xprt_pending[3] cnt: 0
rpc_wait_queue[xprt_pending].qlen: 524 maxpriority: 0
wait_queue: xprt_backlog[0] cnt: 0
wait_queue: xprt_backlog[1] cnt: 685801
wait_queue: xprt_backlog[2] cnt: 0
wait_queue: xprt_backlog[3] cnt: 0
rpc_wait_queue[xprt_backlog].qlen: 30441 maxpriority: 3 [task cnt mismatch]

There is no effect on operations when this overflow occurs. However
it causes confusion when trying to diagnose the performance problem.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 96837ae07822b..ca0a568fd8244 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -190,7 +190,7 @@ struct rpc_wait_queue {
 	unsigned char		maxpriority;		/* maximum priority (0 if queue is not a priority queue) */
 	unsigned char		priority;		/* current priority */
 	unsigned char		nr;			/* # tasks remaining for cookie */
-	unsigned short		qlen;			/* total # tasks waiting in queue */
+	unsigned int		qlen;			/* total # tasks waiting in queue */
 	struct rpc_timer	timer_list;
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 	const char *		name;
-- 
2.43.0


