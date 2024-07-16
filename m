Return-Path: <linux-nfs+bounces-4952-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CA2932D9B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 18:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7275280D4B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6457C19DFB3;
	Tue, 16 Jul 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxFyzM+4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06D19F464
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146028; cv=none; b=sfH8PH5mE3Atfpbbp13DthFjEiyeLA0pQ2U/bGkv36JqSbU4Pi6zRq1BbCqvUG1j8UazuezrnUsTXwa7U/bzyoSoJFg8CXNFINIdLkjZXQKWt9VXHZPLSm9b5+xZLLhwZBt+05qo3OkgKqAAmd0Optj7GsXViq8/ggaX+VO+1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146028; c=relaxed/simple;
	bh=E1vbzpHIOc9FR4/2EGYHLQ4OhhF9CTWcg8O444qYD9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWQGgEzSG6vBuSnSH9yjBxu5k9Zghfg3JMrNKEQmPwyLTL31SzTgduhfQx5djBzht0gPzvr89y1y8IBJnVDxol2IhtB4dUlPIdvrbJACDsHzoi95iubfLfwcof6H8qttxvVNONqTR5mkUdTMtDpFCx+Q5408qnMhKgdy3UIzmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxFyzM+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721146025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4cbtBVIcZ7B1vFiTvaOArNb5V9+lQBccuhloj0JSMw=;
	b=OxFyzM+4Jf+AOfjXFfN0bPBkgwREhXmkphdpUOI5syk65vRa1iwOLfgnRHF9Upe/K1+J0u
	W06A54HrckbDg15Xxu7oc9pDOsxTdFagsJobrIPAZfTadiXv5tOFZFbxWJfbCzopr5Hfbd
	7PdUm1RCxN21YEP0BBcqWr7JZ+V4Nm8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-fQg_EI3xNKCgIFstG-FUCA-1; Tue,
 16 Jul 2024 12:06:55 -0400
X-MC-Unique: fQg_EI3xNKCgIFstG-FUCA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501181955D48;
	Tue, 16 Jul 2024 16:06:54 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8066A195605A;
	Tue, 16 Jul 2024 16:06:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix a race to wake a sync task
Date: Tue, 16 Jul 2024 12:06:51 -0400
Message-ID: <58D7782A-5CA2-4D2E-9817-28878EAECF02@redhat.com>
In-Reply-To: <b8b9fa14bce200fc65545b4c380ece3275e13677.camel@hammerspace.com>
References: <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
 <2525dfa8b9a5539a51109584bf643dcbdcc5f1a0.camel@hammerspace.com>
 <0DFB851E-CEC5-45DC-8C61-CEE6D6DCC9FD@redhat.com>
 <b8b9fa14bce200fc65545b4c380ece3275e13677.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 16 Jul 2024, at 10:37, Trond Myklebust wrote:

> On Tue, 2024-07-16 at 09:44 -0400, Benjamin Coddington wrote:
>> On 16 Jul 2024, at 9:23, Trond Myklebust wrote:
>>> Hmm... Why isn't it sufficient to use smp_mb__after_atomic() here?
>>> That's what clear_and_wake_up_bit() uses in this case.
>>
>> Great question, one that I can't answer with confidence (which is why
>> I
>> solicited advice under the RFC posting).
>>
>> I ended up following the guidance in the comment above wake_up_bit(),
>> since
>> we clear RPC_TASK_RUNNING non-atomically within the queue's
>> spinlock.  It
>> states that we'd probably need smp_mb().
>>
>> However - this race isn't to tk_runstate, its actually to
>> waitqueue_active()
>> being true/false.  So - I believe unless we're checking the bit in
>> the
>> waiter's wait_bit_action function, we really only want to look at the
>> race
>> in the terms of making sure the waiter's setting of the
>> wait_queue_head is
>> visible after the waker tests_and_sets RPC_TASK_RUNNING.
>>
>
> My point is that if we were to call
>
> 	clear_and_wake_up_bit(RPC_TASK_QUEUED, &task->tk_runstate);
>
> then that should be sufficient to resolve the race with
>
> 	status = out_of_line_wait_on_bit(&task->tk_runstate,
>                                 RPC_TASK_QUEUED, rpc_wait_bit_killable,
>                                 TASK_KILLABLE|TASK_FREEZABLE);
>
> So really, all we should need to do is to add in the
> smp_mb__after_atomic(). This is consistent with the guidance in
> Documentation/atomic_t.txt and Documentation/atomic_bitops.txt.

Point taken, but isn't clear_bit_unlock() (via clear_and_wake_up_bit())
providing a release barrier that clear_bit() (via rpc_clear_running(),
spin_unlock()) is not providing?

I don't think what we're doing is the same, because we conditionally gate
the waker on test_and_set_bit(RPC_TASK_RUNNING) (which provides the atomic
barrier), but order doesn't matter yet since we can still be racing on the
other CPU to set up the wait_bit_queue -- because /that/ is gated on
RPC_TASK_QUEUED.  So I think we need to have a barrier that pairs with
set_current_state().

If we /were/ to use clear_and_wake_up_bit(RPC_TASK_QUEUED,
&task->tk_runstate) in rpc_make_runnable, I think that would also fix the
problem.

I can run the same 50-hour test with smb_mb__after_atomic() here on the
same ppc64le setup where the problem manifests and provide results here.  It
will take a couple of days.

Ben


