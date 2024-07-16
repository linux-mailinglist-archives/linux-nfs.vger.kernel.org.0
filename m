Return-Path: <linux-nfs+bounces-4954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CADE932E2B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C9F1F217B7
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5919DFB9;
	Tue, 16 Jul 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YR9jk4wX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7617A930
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146402; cv=none; b=iWUWG2AAeD2ucwCZT7bALsJZYk6p2dZ7y8mBT4SiT1e9GhXHNnBIhLBvpRsOxQ4oMJ1ja5KTjzP0C/lqD8R+Z8wO1b4Xe080dFYH2zeOS1ax41GZ/MMWEKo16Ld2kweKSoaHy+DC9DS3MbeYNb1Bs9K8O8noVvgBVMv7agHflvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146402; c=relaxed/simple;
	bh=8+O7FQztI60xCXX1lgRXy3ncXt3TcLU3zfsdJO4Hb+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZHnqKRsEqrlmrO7BfUiF8g+BXLPhhTEvV1uOBZ7pL8dDov9/miA0Wa++7PvWKSde2UkdeRxYkQlLqTvDzAQvBGP3kzZzgMnwJMHph1oTw215AoVZT0V74utLH5fPWl5ZtKMwyF4j1lGiTiM+81/nnOlX3bHoUPg+sZJ6ZEIPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YR9jk4wX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721146399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hoq8Efs7z0jPD4koKN+1j1qlp9lYZbcgrWx+eUcLAas=;
	b=YR9jk4wXCLDcVifwLiZKYNnVcXesjNKZzFjVWUUOhW0AubLmZF+T8iAVE6DUXkuUApFmnJ
	/cUJCAY+ZAbyeQHRYWxBeoaKe8t+FUKOI79sS7Qhzx+OGXB2ohXWSjNTZ4Gp8VILzWck4O
	ohAQ+8sJUyqSYLbdcXSyIDnu9mASdY0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-hQaKa6aKNHibkgzxEITwQw-1; Tue,
 16 Jul 2024 12:13:16 -0400
X-MC-Unique: hQaKa6aKNHibkgzxEITwQw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30AA91955F42;
	Tue, 16 Jul 2024 16:13:15 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449031955F65;
	Tue, 16 Jul 2024 16:13:14 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix a race to wake a sync task
Date: Tue, 16 Jul 2024 12:13:11 -0400
Message-ID: <03EDC346-BD6B-424A-BA49-C381F98C70FF@redhat.com>
In-Reply-To: <58D7782A-5CA2-4D2E-9817-28878EAECF02@redhat.com>
References: <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
 <2525dfa8b9a5539a51109584bf643dcbdcc5f1a0.camel@hammerspace.com>
 <0DFB851E-CEC5-45DC-8C61-CEE6D6DCC9FD@redhat.com>
 <b8b9fa14bce200fc65545b4c380ece3275e13677.camel@hammerspace.com>
 <58D7782A-5CA2-4D2E-9817-28878EAECF02@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 16 Jul 2024, at 12:06, Benjamin Coddington wrote:

> On 16 Jul 2024, at 10:37, Trond Myklebust wrote:
>
>> On Tue, 2024-07-16 at 09:44 -0400, Benjamin Coddington wrote:
>>> On 16 Jul 2024, at 9:23, Trond Myklebust wrote:
>>>> Hmm... Why isn't it sufficient to use smp_mb__after_atomic() here?
>>>> That's what clear_and_wake_up_bit() uses in this case.
>>>
>>> Great question, one that I can't answer with confidence (which is why
>>> I
>>> solicited advice under the RFC posting).
>>>
>>> I ended up following the guidance in the comment above wake_up_bit(),
>>> since
>>> we clear RPC_TASK_RUNNING non-atomically within the queue's
>>> spinlock.  It
>>> states that we'd probably need smp_mb().
>>>
>>> However - this race isn't to tk_runstate, its actually to
>>> waitqueue_active()
>>> being true/false.  So - I believe unless we're checking the bit in
>>> the
>>> waiter's wait_bit_action function, we really only want to look at the
>>> race
>>> in the terms of making sure the waiter's setting of the
>>> wait_queue_head is
>>> visible after the waker tests_and_sets RPC_TASK_RUNNING.
>>>
>>
>> My point is that if we were to call
>>
>> 	clear_and_wake_up_bit(RPC_TASK_QUEUED, &task->tk_runstate);
>>
>> then that should be sufficient to resolve the race with
>>
>> 	status = out_of_line_wait_on_bit(&task->tk_runstate,
>>                                 RPC_TASK_QUEUED, rpc_wait_bit_killable,
>>                                 TASK_KILLABLE|TASK_FREEZABLE);
>>
>> So really, all we should need to do is to add in the
>> smp_mb__after_atomic(). This is consistent with the guidance in
>> Documentation/atomic_t.txt and Documentation/atomic_bitops.txt.
>
> Point taken, but isn't clear_bit_unlock() (via clear_and_wake_up_bit())
> providing a release barrier that clear_bit() (via rpc_clear_running(),
> spin_unlock()) is not providing?

Another few minutes of looking at it.. and now I think you're right..

the smp_mb__after_atomic() is for ordering after rpc_clear_queued(), which I
was overlooking in rpc_make_runnable().  I will still kick off my testing,
and send along the results.  Thanks for the look.

Ben


