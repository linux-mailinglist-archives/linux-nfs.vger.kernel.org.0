Return-Path: <linux-nfs+bounces-5113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AEA93E766
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06001283514
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF556188CAF;
	Sun, 28 Jul 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdEllnmp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B4188CA9;
	Sun, 28 Jul 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181877; cv=none; b=pN4cdNc64JlDAL1izFoGVmBYTB2+2h5/n9rPzyZ9vlAEeIX90dIc58sj9vXeNwKqX2Cg2IfWiODC9DG1lqylDlFDt0Vcb7p5OFQCwmqnZOgaDc0HGbnnlUUBXfrk7tMbiNTZTcvxrH1g1kLpEnXysuD4MO6ffs58Vd1gK+bz1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181877; c=relaxed/simple;
	bh=SwC3DXWMQkHyaE4FsbLFHk4mNXw3o8n03RoNhtkQyVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPKOBpAn73lxmgwZ1DHsy59PXz/CfbLWWRmXRat6iOcbaqcLQERmwYtQjAPnhrgMHaAW/P2hSQOjrmGJyiPeeGtAsG+FthGPJ3LNlVGd4HL9j17fzWZjkq/Qx6OHuwNeq99Ozee1nVsjmTUOjlB+YP3xd64geDDLZjMWRZmmv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdEllnmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9886BC116B1;
	Sun, 28 Jul 2024 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181877;
	bh=SwC3DXWMQkHyaE4FsbLFHk4mNXw3o8n03RoNhtkQyVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdEllnmp6yqUZ433/PgoIVM7FfV7L6WB6p4En0SugjC54uOzhmzHfK8+CoY9Kuu8b
	 BcmUjex8rXVH4emnQmWQhBxIegx09JbMzc7IvDnGNtJCvkQ/iWdoKu8gqz/l8y9+Qx
	 jqJ2H8wU94mVrwX/+FsmzhLtIq14dmlXaLdU0ufJS1g00d03o3qnT6G0A1iuZk84CV
	 LgId9zmTRRWYRUe43uNlQGv3NZErPsr2Pci/1QsUHr0wvOaV0JATXSyKBO716RBZqs
	 LfUmyxtsyUCIwtwF4v81xSTr6VpBIYMeOOZeNZRaacsp6asiW/4zZOKStYDLPfi3+d
	 sjCYKXughtAtw==
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
Subject: [PATCH AUTOSEL 4.19 5/5] SUNRPC: Fix a race to wake a sync task
Date: Sun, 28 Jul 2024 11:51:00 -0400
Message-ID: <20240728155103.2050728-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728155103.2050728-1-sashal@kernel.org>
References: <20240728155103.2050728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index 9af919364a001..92d88aa62085b 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -349,8 +349,10 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
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


