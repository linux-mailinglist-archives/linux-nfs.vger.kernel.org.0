Return-Path: <linux-nfs+bounces-5112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287593E753
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36961C20F68
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646791862BB;
	Sun, 28 Jul 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duVuOdqK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D51862B4;
	Sun, 28 Jul 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181860; cv=none; b=j7C9fsTcmMm7jwQ9TE1ep7jyzHQtO7A32UjB3vpPhEF/1FHkwkmapy64MA6nw/k/7r1SmikRWUaisWW6CRl6h6F36e/nKQOxPaeFcqnV3fOdOnbCF/pJUXlhqG6qhNrK+aP0ghYt+EMNw1H3Gu1ACnuHEAZdn9yys4o/BkCUANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181860; c=relaxed/simple;
	bh=a7nhMQniC6d10qzvJKZZvj5y8Afd7AHY7Dq8/OGStE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPcpZFYdnSjruKnf9tb2Pj+xEKJ3ocJt8d5d8yUV7HkRuur/g3Yp4aLrdkmjwzo9duCbnF9gmoWqRxYk6cO0LfJtMCeAfIzsBlnWU+cpDiLBGQxBt8XUWNLOpRxqwOOVIEX6DF0lFYKGOVhAkg/bwltRWBThg50F/Zf+ah9dbBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duVuOdqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BABC4AF0A;
	Sun, 28 Jul 2024 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181860;
	bh=a7nhMQniC6d10qzvJKZZvj5y8Afd7AHY7Dq8/OGStE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duVuOdqKzOomYzXqgNmaUnEDvQXK1r9JsdequWQAkwCh9b3rDXLWwMBIr0AM2Gpb4
	 RXyfUexGnxuNtyES8XNpiHivB+koUIvgT7BCzYQERlWfBHqffasA5fffR/0kylCk1G
	 E7cmmh+MK/0X4o+fX+I9u4e3tV1Z34jQDYUxMMII0NKcJdl7zTHpiLsTUVo3NWQbtE
	 WMjOJt1L63OMrsVdxd1Fk4Z/tlzXknaf+4gCxqtayVtZuxCMOodJuVQ9PEBXUybEx+
	 Mb4oFrZ7ZUYD5qeRBeRpMTaYRJU3wSWduXrqDVyQq/Paby1MF8QL/V01zlGJ6Q6hU0
	 YCeDZqk5AyipA==
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
Subject: [PATCH AUTOSEL 5.4 6/6] SUNRPC: Fix a race to wake a sync task
Date: Sun, 28 Jul 2024 11:50:38 -0400
Message-ID: <20240728155045.2050587-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728155045.2050587-1-sashal@kernel.org>
References: <20240728155045.2050587-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index a5c6a3d05741a..df83c59cde7fe 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -368,8 +368,10 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
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


