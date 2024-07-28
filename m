Return-Path: <linux-nfs+bounces-5107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D992D93E69D
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166521C21223
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D89413B290;
	Sun, 28 Jul 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVm8DtU5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D413B285;
	Sun, 28 Jul 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181517; cv=none; b=Sq7LDAdosTJRjGWXgd2B2SJ4ttC28JuGXcfq+YL+a2VBM04k2V6wdqg/seVCad4f0peERCxPt9bOHoZWmrIyg/Nu6X+bKsCzVAGqc2OshPimf3rx5KLSgvk9zFj6qcSgtXN7/Wh8tpDNEggjouqw0q1QEnpL/r17eGaZVTAC3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181517; c=relaxed/simple;
	bh=bW8puwp8UG1FE5R0NW0YGF8HexNK9uU3nHZPanPzjUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucg/TJU9OaGfesB0Wc39wvhsEKZznK/YqldDUwBhZDGFMHrjJePVb0ANzs1X+TMRllhrWIKRa+scHnXAJ553d3o62K8unsCznk9ISrb89A4Oncd8ZMqkPrLads1prvum/VLhTXRgxI7SHkuJYEA/74ladMxKSJNibQwYULdsSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVm8DtU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02193C116B1;
	Sun, 28 Jul 2024 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181516;
	bh=bW8puwp8UG1FE5R0NW0YGF8HexNK9uU3nHZPanPzjUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVm8DtU5o8N/OdbJj9lgzpNYb2Ps1FcUHuMG9pVhJ2Ql6fNd5DW6MUDhoOFJ5+zPS
	 pnuIqz6LtlPUQM2MWZeWtBroZl9VA7rR3lZrdvGnRDyK9BsSJ4xLH0rqRUweK98dsE
	 WAwkGt4wUhk1aIG9k12YxouJBXBFrC4rERVJ5iP1WeNkLYm7ye/+BTnH65m4GI1QaI
	 R1GTAEF1vzmBfxmhx4LhXcgpU6jP+z/N0HIJlbGng7PEPCJTn12I0adxx4ZceAqdFV
	 2Nt7VL3vQmtgN/joSwBEwPIiQ1YO80KozmPOfUacoJqR7gPtsU8jxltxrx7fa1LrIQ
	 WZyqK3uu+UA5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Coddington <bcodding@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>,
	chuck.lever@oracle.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 34/34] SUNRPC: Fix a race to wake a sync task
Date: Sun, 28 Jul 2024 11:40:58 -0400
Message-ID: <20240728154230.2046786-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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


