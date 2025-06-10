Return-Path: <linux-nfs+bounces-12245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05626AD35ED
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 14:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E92F188804E
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7422F759;
	Tue, 10 Jun 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw4iXVYJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3028DF4E
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558003; cv=none; b=hnR9p8yCMnETKw44zJn9qXzIwA3xVSjktC6WmIQ5RlQ4afMATN1K5HK7najsQQ6oM0XPZFzk7SH5OmeyjwOIvDSbrBjm6NL3GMqZwU9gyXNKqwzVOuwXsOgdL9MqQo0jluWh43hvlqEBaRiArkihWiK2UEiS81lR27A/hk67Akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558003; c=relaxed/simple;
	bh=pV2HhVEYBux07GT9QG++FJn/nMYtAQm9bBAUZNAGX4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpUl7AmApL9KYFZh1zHx8hw1b+alwy6GEOwQG2UPpYWTgsx8iDSMvJmsqqR2HZ9iFqPJtzYc56n+Sq+1CM0U+e/fl3k5OfdpRCPGyFVVD6OcoVJmTPNOAf5p4uI1MAeDHSaty+u+Zcjrxkh2eRw/lwF7FZ8eeJaIL3+c1MFS/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw4iXVYJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749558000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YuJSwpl8hXsV5lAlZH+NFrhQZihW8UigyvHehx1cZ50=;
	b=Hw4iXVYJmCROLqIPA7Q8VPRdrjDTy++lJ/sAw8hz6DRIzj42jeikh4eu6HZWWSA8/mjf2s
	pKKYRoc+63WphZWWa5hbnyZr0GGH+aZgVWyC6pDpmeT6i+CkCf9EPrsw8UhAa+hl2RcVy3
	QcyH8y+oLJiHUng0nzVGPQp0sJ00V+M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-dsy7WHhlNE2JVNZy0TMNLA-1; Tue,
 10 Jun 2025 08:19:59 -0400
X-MC-Unique: dsy7WHhlNE2JVNZy0TMNLA-1
X-Mimecast-MFC-AGG-ID: dsy7WHhlNE2JVNZy0TMNLA_1749557998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05F85195608C;
	Tue, 10 Jun 2025 12:19:58 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD1E618003FC;
	Tue, 10 Jun 2025 12:19:56 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SUNRPC: Cleanup/fix initial rq_pages allocation
Date: Tue, 10 Jun 2025 08:19:54 -0400
Message-ID: <CA97562B-2F38-453C-8042-D835EAF139AE@redhat.com>
In-Reply-To: <69abb6cd-f506-43b4-ba3e-a63ba821d80a@oracle.com>
References: <151437c300ca8eb4d8d9a842c9caf167cb32b6ea.1749489592.git.bcodding@redhat.com>
 <69abb6cd-f506-43b4-ba3e-a63ba821d80a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 9 Jun 2025, at 15:25, Chuck Lever wrote:

> On 6/9/25 1:21 PM, Benjamin Coddington wrote:
>> While investigating some reports of memory-constrained NUMA machines
>> failing to mount v3 and v4.0 nfs mounts, we found that svc_init_buffer()
>> was not attempting to retry allocations from the bulk page allocator.
>> Typically, this results in a single page allocation being returned and
>> the mount attempt fails with -ENOMEM.  A retry would have allowed the mount
>> to succeed.
>>
>> Additionally, it seems that the bulk allocation in svc_init_buffer() is
>> redundant because svc_alloc_arg() will perform the required allocation and
>> does the correct thing to retry the allocations.
>>
>> The call to allocate memory in svc_alloc_arg() drops the preferred node
>> argument, but I expect we'll still allocate on the preferred node because
>> the allocation call happens within the svc thread context, which chooses
>> the node with memory closest to the current thread's execution.
>
> IIUC this assumption might be incorrect. When a @node argument is
> passed in, the allocator tries to allocate memory on that node only.
> When the non-node API is used, the local node is tried first, but if
> that allocation fails, it looks on other nodes for free pages.

After checking this morning, I see that both calls end up in the same place:
alloc_pages_bulk_noprof(), and @preferred_nid is either from @node in one or
from numa_mem_id() in the other.

So, I stand by my statement above.  I don't see where
alloc_pages_bulk_noprof() will behave differently regarding how strictly the
preferred node is used based on whether alloc_pages_bulk_node() or
alloc_pages_bulk() is called.

Ben


