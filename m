Return-Path: <linux-nfs+bounces-4950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E59327BF
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156291F2347C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7326619AA46;
	Tue, 16 Jul 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmmXlr2G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E319ADBA
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137503; cv=none; b=gDtJ00Dd4seZ/ZRb2mY4/j8cSjosYKz1IV5EdlC74deo86rGD78efJV6THVCHue935jmGFJ78sPE3UNpXRtR7YZTcMgAr64bgtldB6rlUd7UED0d+uUxX9iBW1C6bZc9cE+7FuJnetRTWIx0Xn8AO6AKR+sifID5g+pdwGVemYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137503; c=relaxed/simple;
	bh=X2iE/HdLRCo7RAKtmYcWFCfBqO+XQSWl6Rdsz/ONfI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyaEYEmozhkor9kKvrLPaTql9qZQ/Lowy/cuFepJ2xq2re2WcYhIhTB7uH1VJn4eGmkk1nW6tx9lTBfS/nadna+xrCLmMX3hXMZKLao9MXuthXQdgQMF9IOb//S7mpnZRH7FAxpG4CJdPJU/nqDCXxnxViDii9f+Buenh6g9iqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmmXlr2G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721137500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUYtXne49VWiAfAPYtU7gsMh+UMpukQo7Mj6i8YDT/k=;
	b=GmmXlr2Gj+q8RgRgu7fEfbFlyXR/0HQSx8jktYYQf3nJBGQWowlRnW4orbSXCaSS8/wJ+Q
	ql76jyX2ieVU5uiiQCfv+0kowsNJeN1Jx2sgQUpSBfRmSeVaeSitgFg87fE5t/rwLnXfpB
	8fiDdpKCjzlYClkk5DQZnxfRR2Fv6zE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-U1iqOu88NOyOfW_dkvdOtw-1; Tue,
 16 Jul 2024 09:44:57 -0400
X-MC-Unique: U1iqOu88NOyOfW_dkvdOtw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BE6A1955F2B;
	Tue, 16 Jul 2024 13:44:56 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DCCE1955D42;
	Tue, 16 Jul 2024 13:44:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix a race to wake a sync task
Date: Tue, 16 Jul 2024 09:44:51 -0400
Message-ID: <0DFB851E-CEC5-45DC-8C61-CEE6D6DCC9FD@redhat.com>
In-Reply-To: <2525dfa8b9a5539a51109584bf643dcbdcc5f1a0.camel@hammerspace.com>
References: <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
 <2525dfa8b9a5539a51109584bf643dcbdcc5f1a0.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 16 Jul 2024, at 9:23, Trond Myklebust wrote:

> On Fri, 2024-07-12 at 09:55 -0400, Benjamin Coddington wrote:
>> We've observed NFS clients with sync tasks sleeping in __rpc_execute
>> waiting on RPC_TASK_QUEUED that have not responded to a wake-up from
>> rpc_make_runnable().  I suspect this problem usually goes unnoticed,
>> because on a busy client the task will eventually be re-awoken by
>> another
>> task completion or xprt event.  However, if the state manager is
>> draining
>> the slot table, a sync task missing a wake-up can result in a hung
>> client.
>>
>> We've been able to prove that the waker in rpc_make_runnable()
>> successfully
>> calls wake_up_bit() (ie- there's no race to tk_runstate), but the
>> wake_up_bit() call fails to wake the waiter.  I suspect the waker is
>> missing the load of the bit's wait_queue_head, so waitqueue_active()
>> is
>> false.  There are some very helpful comments about this problem above
>> wake_up_bit(), prepare_to_wait(), and waitqueue_active().
>>
>> Fix this by inserting smp_mb() before the wake_up_bit(), which pairs
>> with
>> prepare_to_wait() calling set_current_state().
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  net/sunrpc/sched.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index 6debf4fd42d4..34b31be75497 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -369,8 +369,11 @@ static void rpc_make_runnable(struct
>> workqueue_struct *wq,
>>  	if (RPC_IS_ASYNC(task)) {
>>  		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
>>  		queue_work(wq, &task->u.tk_work);
>> -	} else
>> +	} else {
>> +		/* paired with set_current_state() in
>> prepare_to_wait */
>> +		smp_mb();
>
> Hmm... Why isn't it sufficient to use smp_mb__after_atomic() here?
> That's what clear_and_wake_up_bit() uses in this case.

Great question, one that I can't answer with confidence (which is why I
solicited advice under the RFC posting).

I ended up following the guidance in the comment above wake_up_bit(), since
we clear RPC_TASK_RUNNING non-atomically within the queue's spinlock.  It
states that we'd probably need smp_mb().

However - this race isn't to tk_runstate, its actually to waitqueue_active()
being true/false.  So - I believe unless we're checking the bit in the
waiter's wait_bit_action function, we really only want to look at the race
in the terms of making sure the waiter's setting of the wait_queue_head is
visible after the waker tests_and_sets RPC_TASK_RUNNING.

Ben


