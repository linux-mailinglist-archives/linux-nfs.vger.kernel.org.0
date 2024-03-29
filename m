Return-Path: <linux-nfs+bounces-2555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F4891C58
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 14:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AAB1F26E59
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55A18411F;
	Fri, 29 Mar 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOyFikQ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FB18413E;
	Fri, 29 Mar 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716120; cv=none; b=A0KU4fgShXsjsYkSfdhjGvnhgZU7NI0lzg1Q/fM4n5t/MnhkKwed0xGwGfg3xoQyCmpTCIEfOEtQhHEJSyckrOrRtfCpbSdshxy4GfhUABnVLbs/6FkHk7yHURKsoUTCuU+uRYppMJvEw67AGq+LVbyRc4ddrO0iKbrjNgA5zkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716120; c=relaxed/simple;
	bh=YHQaejoZL4q6MpWP8vqZH5Tnb6wiXlPTnPxaDelM7TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnDq0pyp4o1VzWMNOA63KK4WijAVJcwKC9z+OnYPnCWR5ydRjMbUU86jZUl7uyDhKBWr3FTzx65iM5fy4coEFrysuXCyO5Tt8UeQStWhA8SebCVbpTelprp2CMubnRvVdbK3e8tE4VTrasW/s+wd69FMYDCQnrf6P1NVbCE0FKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOyFikQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D364C43390;
	Fri, 29 Mar 2024 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716120;
	bh=YHQaejoZL4q6MpWP8vqZH5Tnb6wiXlPTnPxaDelM7TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOyFikQ27BEgbPnhC2CAmRS0QDSBxMKB7tMoBR8nEZXZ/RXa5oVkWzbpCQA8MOvhc
	 NV+rzmyHnUfqb85VG4HZP5ho0dZp4BLi6Rhc4sKNOuKpLpN19xQuuM1YtMClwIDu9+
	 HKgVs33YyfP2dqlTBVmjonqnrhbDNmtIK0LvCDItWCRU6DlUhvIQbd+8ALGzmH6toN
	 mxAA1FbSG3flEXutlpsiK60tybtO3oQ/0GYni2/5wrVhnA0ZfQiC1SATV2lt4gDVZD
	 aHsKQAWdDpjDN8j8v4Yat9BEibYbqJTDaoFlMF5ZoWv1g7MxPvCx001lk4Z+xIKoak
	 PvVnLSsIJKXFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	chuck.lever@oracle.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 65/98] SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int
Date: Fri, 29 Mar 2024 08:37:36 -0400
Message-ID: <20240329123919.3087149-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 2d61987b35456..0c77ba488bbae 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -197,7 +197,7 @@ struct rpc_wait_queue {
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


