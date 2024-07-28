Return-Path: <linux-nfs+bounces-5110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8EE93E72A
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603F51C213EC
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8AD1586FE;
	Sun, 28 Jul 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM8RsSWc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAD157484;
	Sun, 28 Jul 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181800; cv=none; b=XNxK0D4fbRWZnThcOGPrzuI1Uk+O20C9ZLVRq1aNmCWGdAjSf4WSYP+Y/lMALM8OZmTK56LlIxLuYOatWePBCv9OPClIfSS5QLfOt1DrdJ2x9A8Frzwv5yBbeBg71ttNFYnEgY7iEH7eddy2xx18xFWb9ID6xsxQ4hraX0hDge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181800; c=relaxed/simple;
	bh=y6pIeYbB6+lpyvvtYVHUUVmb4tpbRuegA1GXDCj+U4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cof03cHCL7cJObZRbKhh/xfAySL+Q+oF6tT4Ec0pTmyjAS+0Rlky535QjdK3dHelKjjidASfTnfHnYZnw/bB7XQUfUjmUmuCQkjn8D6WPXKga+DpM7MCfG3usru5vxpT7UMeft4qPYkvxJqWDKkHS3sPpT+k63iVqIp9ODfAQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM8RsSWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D58C116B1;
	Sun, 28 Jul 2024 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181800;
	bh=y6pIeYbB6+lpyvvtYVHUUVmb4tpbRuegA1GXDCj+U4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GM8RsSWcoupxrwUndKjxEc22In4SUcOkhKmZBrkhVGbz50xsjJxcFAHmbE8j5/ZEd
	 F/YGu466jxb6iHB802ytowAXeajLWh84LaQ2CZVv/Llu4vNpoFRiCmVJUu70+APX4A
	 rBqGAlKOzpthoK5tPrNsaNYw/dEyJ1qFC4kP87bzTUHy/POBkuRK0Cgnf9zIdJ1ZOx
	 krSzQUEHjSWOSD5mudNWNMNas2MbpIurB/VHdvHAThc5v/fQqLPTzaKqfPvmi/vtNt
	 5oIerhUtQKzUPWDWZTlOwOFfai0O2Ff/JzHfS/VbAQqX0umdZyclqUESkkYMsHD0vS
	 3UEoOkvDAypKg==
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
Subject: [PATCH AUTOSEL 5.15 10/10] SUNRPC: Fix a race to wake a sync task
Date: Sun, 28 Jul 2024 11:49:08 -0400
Message-ID: <20240728154927.2050160-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154927.2050160-1-sashal@kernel.org>
References: <20240728154927.2050160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index a00890962e115..540220264b31e 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -348,8 +348,10 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
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


