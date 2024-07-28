Return-Path: <linux-nfs+bounces-5108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34493E6D9
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235821F24E14
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16622145343;
	Sun, 28 Jul 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYxo7L7K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0F14533F;
	Sun, 28 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181646; cv=none; b=YRngxIlEefe3YuwjDW106aRbQBmC5QZspBBaWlfmg7Wvd4JaMu94MbIDRKWcVKSE5XkusGVsmONEUrzyZStkAPGm60udzFB4Y9Bdv2l/aS/qvd5fqWVdVneHG1o3P2ILpcJyV0ciOgnIJ6X3ASnCc14vROuQ9y+Jf4YQuYJrbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181646; c=relaxed/simple;
	bh=bW8puwp8UG1FE5R0NW0YGF8HexNK9uU3nHZPanPzjUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/rEb5UX2FkN3se9zWpolIIi6lqYMuzghOWbsqJs+GldL27L9jNPYJ9SLgUVLja+NcDDyu7TjfOT3Qga4Az8tUYQ14+Gq3b0KDzKvxPIBfRoOr6bWgvj+f9a1enKRPRigAlKzJZRZLOP1bU931aYUvd6AjfhI7hunxyv37G2iys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYxo7L7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48FAC4AF0A;
	Sun, 28 Jul 2024 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181645;
	bh=bW8puwp8UG1FE5R0NW0YGF8HexNK9uU3nHZPanPzjUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYxo7L7Kz748WVytalmYOGWWgfQBTxP5nG4PQB//BUJbrzOteDfwD+6/1YiJt/ZO5
	 pLJFyR+gO0VvfoIiPrU7dIq2SMFxzho8EfIZH/qpQN5N02q3ORq1X4PI6/mB4PhGy0
	 qwXZPJ00IoZN3Vq3a7nseEefJPDxVdT44LSja2zpuU/uJuVhfnyH2NodrTwfhJNgGR
	 f3Qu/8oc8n0tIHFr8QNGxcEQDY7kI7TlRUK5GBjIpeURUFktjJrRPKz1wME0gDkVfG
	 QHT93Ewd0yLC1rnMMw/sBC70tEOXFEmtnrcntuW3wQ2XBrfb4re0x3mufE2kqWj4Ko
	 sANBbyjuVWXOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Coddington <bcodding@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/20] SUNRPC: Fix a race to wake a sync task
Date: Sun, 28 Jul 2024 11:45:18 -0400
Message-ID: <20240728154605.2048490-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit ed0172af5d6fc07d1b40ca82f5ca3979300369f7 ]

We've observed NFS clients with sync tasks sleeping in __rpc_execute
waiting on RPC_TASK_QUEUED that have not responded to a wake-up from
rpc_make_runnable().  I suspect this problem usually goes unnoticed,
because on a busy client the task will eventually be re-awoken by another
task completion or xprt event.  However, if the state manager is draining
the slot table, a sync task missing a wake-up can result in a hung client.

We've been able to prove that the waker in rpc_make_runnable() successfully
calls wake_up_bit() (ie- there's no race to tk_runstate), but the
wake_up_bit() call fails to wake the waiter.  I suspect the waker is
missing the load of the bit's wait_queue_head, so waitqueue_active() is
false.  There are some very helpful comments about this problem above
wake_up_bit(), prepare_to_wait(), and waitqueue_active().

Fix this by inserting smp_mb__after_atomic() before the wake_up_bit(),
which pairs with prepare_to_wait() calling set_current_state().

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/sched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 6debf4fd42d4e..cef623ea15060 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -369,8 +369,10 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
 	if (RPC_IS_ASYNC(task)) {
 		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
 		queue_work(wq, &task->u.tk_work);
-	} else
+	} else {
+		smp_mb__after_atomic();
 		wake_up_bit(&task->tk_runstate, RPC_TASK_QUEUED);
+	}
 }
 
 /*
-- 
2.43.0


