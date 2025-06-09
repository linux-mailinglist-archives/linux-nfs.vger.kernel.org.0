Return-Path: <linux-nfs+bounces-12226-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47072AD2ABA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 01:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BF0188F297
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 23:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D222FAC3;
	Mon,  9 Jun 2025 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj6fQP6u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DB1DF25A
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513296; cv=none; b=Sfq0uN4aifjXNsq3cYS5CTIhtBIqj0uTIjvgfttzECxqm11PkcbfrSZ13HFmv/aSQqB1JptLBJKSQViVvi4gf6D6hiJVqo+oYFnoFJQmlp8vtdRvYS1gWBT0Vgy/CAePjYustF+e0cWr+0107uHREuaHy+05BfaOPGoJWpQq8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513296; c=relaxed/simple;
	bh=1t2G39y5eLaEHKKqRB9DDn2cxjvZ4kL0tkJwtvHfQ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2mVCEjwClrKzssMCyUnKxiz38j07IxMT4+y2PebsiLEqRpy7Pal/KfyitvD0RxoljUFWvLi+n72Zntn+y3r7izxvMhxAbPQ1JmGYEmxxai9s/j7RT1nVTSkf8edDF4Z9kJgAeO+24ZSFG7JPtuVJOtRGeU13UDUE5DyE7Y2oZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cj6fQP6u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749513293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0LiYCp7Eo3vp+j2JEhIw3nrUQAcEmcMg8tevbi2waQ=;
	b=Cj6fQP6u955gXsI5Mpp1fafMfl0nJMvq0d+HyGR7XM1rOgyHZZDX9KrqHFrrJ7IHYdABbB
	69BxTcEIxVTE/0+mYW03LF3LwNAB61FCVB2lBN+ZuUcsYBn4B2zWZf7WJctH2Ykth2VLT0
	HvrxPu5RT07Haka7zkJPH4SJ0rgrLKQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-3XxibieGNTO363JIR1Nb3A-1; Mon,
 09 Jun 2025 19:54:50 -0400
X-MC-Unique: 3XxibieGNTO363JIR1Nb3A-1
X-Mimecast-MFC-AGG-ID: 3XxibieGNTO363JIR1Nb3A_1749513289
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 159561800284;
	Mon,  9 Jun 2025 23:54:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED4181956095;
	Mon,  9 Jun 2025 23:54:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SUNRPC: Cleanup/fix initial rq_pages allocation
Date: Mon, 09 Jun 2025 19:54:46 -0400
Message-ID: <3AF5E6B3-54BA-48AE-8105-A0BC63692868@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
>
> This is how svc_alloc_arg has worked for a while. I tried to make this a
> node-specific allocation in 5f7fc5d69f6e ("SUNRPC: Resupply rq_pages
> from node-local memory"), but that had to be reverted because there
> are some cases where the svc_pool's sv_id is not valid to use as the
> node identifier.

It might be possible to know whether we're in per-pool mode in
svc_alloc_arg(), I can look into it.  In that case we could just fall back
to the non-node specific bulk allocation.  I'd rather not be inserting
hard-to-find performance regressions.

> But otherwise, IMO de-duplicating the code that fills rq_pages seems
> like a step forward. I can take v2 and drop the above paragraph if I get
> one or more additional R-b's. This is probably nfsd-fixes material.

Roger.

>> This patch cleans out the bulk allocation in svc_init_buffer() to allow
>> svc_alloc_arg() to handle the allocation/retry logic for rq_pages.
>
> Fixes: ed603bcf4fea ("sunrpc: Replace the rq_pages array with
> dynamically-allocated memory")

Thanks for the attention, Chuck.

Ben


