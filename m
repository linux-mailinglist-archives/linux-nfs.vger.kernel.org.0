Return-Path: <linux-nfs+bounces-4866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F9392FBEB
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 15:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F611F23709
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D35171086;
	Fri, 12 Jul 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRLx3lzl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD6171085
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792525; cv=none; b=UqtPGnYeLnoiJqon3AmYExRFDouqeu8Un4etRSTib2KWtlPew7NELMFsfclU/SoMUT42tZv4NBMCWPz0/JmZlwTgGTLXfDB1cD99HBZwPLnWxzdn97x7KRg63BLvnqH9TQrW7IlrJXvCTA3M9gNqdjADNZsVpkklUtSrUAhdVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792525; c=relaxed/simple;
	bh=lj/cfBtpEuXAbEdN583hg+ZXN48m9UKUH6g+/ssD+lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9Yjm8nig/QhGYktx0EtjQzOLllTFXsx1LWv7vop0nQMGjZmY42Tf9JrT8GZSJ4nG0g7ig2dCXFErc9Nv4YsiwHodc8FGry1H3X+W5lHZSMQYoaFDm4wTjRpdBXmDQHVGCZYwDmmWrXpgnuPbaZxJ/qSPc2n6eMJzwjPLUhq5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRLx3lzl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720792522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QIip0KmOMAFRqxXr3QRiSoP9SPr5EbUKeX4yGrrlx5w=;
	b=eRLx3lzleDXALExHMAiFaaS6Vfz5QOtW0P1jLxkTTCfnvDq1bpuTNlv9JSscuw/VgxT8yA
	0tLm0jyh5Lk46fcN5Cbn6UvXJ68uYxpq3XK0f5lbvaibHrN3QgDj4W5Kyt9Ta6lefsChv2
	WO3Ju3d+9nAXPWOsajwCvN7ggEpNIFM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-AIOln3uiOK2DIzZwwp6gAQ-1; Fri,
 12 Jul 2024 09:55:21 -0400
X-MC-Unique: AIOln3uiOK2DIzZwwp6gAQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ACB719560B3;
	Fri, 12 Jul 2024 13:55:20 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FB851955F3B;
	Fri, 12 Jul 2024 13:55:18 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix a race to wake a sync task
Date: Fri, 12 Jul 2024 09:55:17 -0400
Message-ID: <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

Fix this by inserting smp_mb() before the wake_up_bit(), which pairs with
prepare_to_wait() calling set_current_state().

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 6debf4fd42d4..34b31be75497 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -369,8 +369,11 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
 	if (RPC_IS_ASYNC(task)) {
 		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
 		queue_work(wq, &task->u.tk_work);
-	} else
+	} else {
+		/* paired with set_current_state() in prepare_to_wait */
+		smp_mb();
 		wake_up_bit(&task->tk_runstate, RPC_TASK_QUEUED);
+	}
 }
 
 /*
-- 
2.44.0


