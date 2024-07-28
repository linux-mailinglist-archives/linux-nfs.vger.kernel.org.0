Return-Path: <linux-nfs+bounces-5111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C793E740
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 18:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2AF3B21FFF
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C915E5CF;
	Sun, 28 Jul 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvTq6rRp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4A15DBDD;
	Sun, 28 Jul 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181837; cv=none; b=igZjFe0B5oqJkBmAGpg+u3hm2VB9Nj57+/GOx5tnEKXIldBkFRW3vqHfLySxTqW3Jqdwsv/5GQFE/7sGcxuF+PPdFUfy1e5dhb7pfYRzDNdZeGtxpqM5gnwtYDhZsR75nnUSri8WwJAwFvQcdMK2LViHfY0njkWtndN4wLCXk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181837; c=relaxed/simple;
	bh=i5KDizLcs5tBp+Q0VEtgWSeDywDwJ0HdupJ6lt18wSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJMUGKvgSsQdl7+CHWResmryPYKg0jjppXXIDrm3IiQJjirtAsUTiAryU4rUCMKAtTtHKgYlA9E6q8kklCJr7vQRzm0yT1/XrHWikh/Pbt7QKfeGfYo3IVxBHTTz+4c4RrIwGWgMell81TGAEx0x1nkZMpLr6rkxGgGqEft4UOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvTq6rRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E82C4AF0A;
	Sun, 28 Jul 2024 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181837;
	bh=i5KDizLcs5tBp+Q0VEtgWSeDywDwJ0HdupJ6lt18wSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvTq6rRpT81v4XtKffHwhI2MZtpYElIYOJpc559Fg/U9RZcGaL2BjmpmgL5eQg8Zt
	 Gb21jsjTpvB+4hJ3sIgvY/gFN0C/T8v/qtQMdxRV/aBgemYVMoGfqGJAQcTSNfqAZ0
	 RedHl8b1h3Y2djSTdqFRk6ANtECyz3lk868qz+wf8637nSzD//Cz6Ee+e3+vxnTN5k
	 ERFrkg+vgPKMEj4tWBITv5V2KQ//lKlg4rNxnaQdrAx8U3cyatkPGgKdh/8A672Up0
	 wHZOCd798879z8jZBMXbaIYjISxhxmk1QM+BP1i7okJp3t5JwG4l0CZjUHdlO+xSL6
	 eBw78MiZhlr4g==
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
Subject: [PATCH AUTOSEL 5.10 7/7] SUNRPC: Fix a race to wake a sync task
Date: Sun, 28 Jul 2024 11:50:01 -0400
Message-ID: <20240728155014.2050414-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728155014.2050414-1-sashal@kernel.org>
References: <20240728155014.2050414-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index a4c9d410eb8d5..f4b1b7fee2c05 100644
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


