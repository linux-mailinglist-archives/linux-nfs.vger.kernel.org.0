Return-Path: <linux-nfs+bounces-4971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8654B933ED2
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 16:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BACE282D53
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B2180A6A;
	Wed, 17 Jul 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LS5+RYQB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0C2EAE5
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227785; cv=none; b=Cj7R11Lv9GghM6UV0GurigFmilt4SrXSTJbqcDH6t1g+BjbKuUbdjkbqwtbl5SZ5Cnw02mEET4JfIjFI/vDUm26xu6mL8KLAIpsoUXCG2hwPoger90Ab8I3M+zB42JsSZHKpqSc/jtRRuhiYgIAQgv1YuwmlsXJOyVp14ydrpUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227785; c=relaxed/simple;
	bh=50UHxKCfkfy31YSHCJAAddwhNajsZkL1Cd2sBo/G7wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAMEBrBbQ2yS8ejwrjcEDc7fT4tzDvhCcXTF5sS1jCmS5nQWJMEpyGlgoGHrZLWR8fPlSRjoRdknT/jW8fISG6deS09xd8Hbgd4Zu5W7c3u9Oxj+do2lqQnuWoma0Q5InaoK/Q5HGsJj2Zn5EkkxoqAE+2aJVvVYVVqzQdjPhtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LS5+RYQB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721227783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=56QdmeUIWO7yaOQR20YQ1FVsT6X0YvARfFbCk4rhuOU=;
	b=LS5+RYQBtlGCWy4fE4jDlbSY7pz09nm2FwNusKzU7bLFmtGtVZ31QZ63R9zccL+bMp3NUp
	FsIaVF54odgVMw5PIsrA4TPSuxLxycyJJhfwW4aGomgS21w1TTaBdouDX64KJPh4q3iCHw
	WKyWFX0b9U8A5fIvwD/i8906iubjP5Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-6kLZFu08OqiLzOai2cQEZA-1; Wed,
 17 Jul 2024 10:49:37 -0400
X-MC-Unique: 6kLZFu08OqiLzOai2cQEZA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 108731955D4A;
	Wed, 17 Jul 2024 14:49:36 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDC4C300018E;
	Wed, 17 Jul 2024 14:49:34 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: Fix a race to wake a sync task
Date: Wed, 17 Jul 2024 10:49:33 -0400
Message-ID: <a8e4ef3d79aba79bb844539af6d181a794011b1c.1721227179.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
---
This v2 drops the comment which matches other barriers in our subsystem, and
backs out the full memory barrier to use the __after_atomic() variant as
Trond suggests.

Though I have not yet completed a full test run, it has survived 16 of the
50 hours I planned for it.  My reproducer rarely takes longer than an hour,
never more than 90 minutes for the last ~10 reproductions.

Thanks for the review and attention.
---
 net/sunrpc/sched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 6debf4fd42d4..cef623ea1506 100644
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
2.44.0


