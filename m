Return-Path: <linux-nfs+bounces-4784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9921392DA26
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 22:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D2282D16
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB5198A2A;
	Wed, 10 Jul 2024 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArGLyN+4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49D193068
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643531; cv=none; b=Eik+CssqzayL/mE0+XdAIuKCb5TZ4DOxN5jSQXGH9HD567TknKJ/PDdxnQGkyFnwREer75XMMYCAur8Kd8qHP0ICicSNgRHyv38Wo7JqAzzL9O385TRwwWRmzUKmxTw45dJ6T5Vwn2vzJjZoc/vsiylVZ1GTDBTw+FcF8lPwcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643531; c=relaxed/simple;
	bh=lj/cfBtpEuXAbEdN583hg+ZXN48m9UKUH6g+/ssD+lw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2I1uYSwH6eRSrBpJRDsaPgQlg57bKG/L4WCp2hP1+lAwVHT9ATBc9bW2F33OCEmVolGwB8NQkQrGrjq6Pm4bEX2ZbzKLl6PHdaLEqDANtHcpESUMPiZJsQq/BpkuEy9E91F/vpS9qNTxPJryPAWOSHXAcNtN8jhngDtGvR+aTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArGLyN+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720643528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIip0KmOMAFRqxXr3QRiSoP9SPr5EbUKeX4yGrrlx5w=;
	b=ArGLyN+4wqxOCWWxSpMzLuOYU+/Nh+0Kth/on2dHhbye2h02BJEPY+qZtfMbUtJ/d6/QNx
	kz5jDPEHM3g/LK+UYHT37akzxo/n7lBiEc/GgGOrElWzmfjj8gOa+HSOdorlf7jeFruzQw
	Zu34xApjt36ll511wDp+oDdQhcV/T3Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-cWcZPVTvMH-xD1cb54j77w-1; Wed,
 10 Jul 2024 16:32:07 -0400
X-MC-Unique: cWcZPVTvMH-xD1cb54j77w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A187E19560AA
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 20:32:06 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B8E03000182
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 20:32:05 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/1] SUNRPC: Fix a race to wake a sync task
Date: Wed, 10 Jul 2024 16:32:04 -0400
Message-ID: <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720643005.git.bcodding@redhat.com>
In-Reply-To: <cover.1720643005.git.bcodding@redhat.com>
References: <cover.1720643005.git.bcodding@redhat.com>
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


