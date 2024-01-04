Return-Path: <linux-nfs+bounces-922-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BD0824110
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 12:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676191F20621
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1102135B;
	Thu,  4 Jan 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioJY4M/G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C521359
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704369357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEgmA49MzeAdHJu8hJGVoYylU8Sm0te82PfQumrL6p4=;
	b=ioJY4M/GjSDt0423K6wtO5ogbPNCyMk1kGSR2eF5c/lo0GGJyPSJ3XCex7MmwuHiYA0n/O
	ntnnvOuCIRQ8Hf6w3VaQlZtYiIro5KHzHFgXmvRuBXbNj1NI+OiANHisqYsxw1ZpxDG93h
	FwPeNS9OKi6DQCIo70aAIckrN+CdJXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-0tsutftuMiuiZSWJBKfgbg-1; Thu, 04 Jan 2024 06:55:54 -0500
X-MC-Unique: 0tsutftuMiuiZSWJBKfgbg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1BEC185A780;
	Thu,  4 Jan 2024 11:55:53 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C4EC492BC6;
	Thu,  4 Jan 2024 11:55:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] NFSv4.1: Use the nfs_client's rpc timeouts for
 backchannel
Date: Thu, 04 Jan 2024 06:55:51 -0500
Message-ID: <25DCF24F-FB84-4A52-A66E-63A445197AB6@redhat.com>
In-Reply-To: <1aa005d1c0b344a455ced93be866dff3c316e15e.camel@hammerspace.com>
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1702496910.git.bcodding@redhat.com>
 <90c9365ad91e1eb0058b170fb332ea70ad554d8b.1702496910.git.bcodding@redhat.com>
 <CAFX2Jf=CARs=2pPhi-Lj_ydZKyqpjA=kZQoWDNsRKM3gdp=CYw@mail.gmail.com>
 <1aa005d1c0b344a455ced93be866dff3c316e15e.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 3 Jan 2024, at 18:00, Trond Myklebust wrote:

> On Wed, 2024-01-03 at 16:45 -0500, Anna Schumaker wrote:
>> Hi Ben,
>>
>> On Wed, Dec 13, 2023 at 2:49 PM Benjamin Coddington
>> <bcodding@redhat.com> wrote:
>>>
>>> For backchannel requests that lookup the appropriate nfs_client,
>>> use the
>>> state-management rpc_clnt's rpc_timeout parameters for the
>>> backchannel's
>>> response.  When the nfs_client cannot be found, fall back to using
>>> the
>>> xprt's default timeout parameters.
>>
>> I'm seeing a use-after-free after applying this patch when using pNFS
>> and session trunking. Any idea what's going on? Here is the stack
>> trace I'm seeing:
>
> I'm going to guess that this is happening because nothing is clearing
> rqstp->bc_rpc_clnt after a call to svc_process_bc(). So if something
> later calls CB_NULL, then the resulting svc_process_bc() will free an
> extra reference.

Doh!

>>
>> I hit this while testing against ontap, if that helps.
>>
>> Thanks,
>> Anna

Thank you for the test!!

>>> --- a/fs/nfs/callback_xdr.c
>>> +++ b/fs/nfs/callback_xdr.c
>>> @@ -967,6 +967,9 @@ static __be32 nfs4_callback_compound(struct
>>> svc_rqst *rqstp)
>>>                 nops--;
>>>         }
>>>
>>> +       if (svc_is_backchannel(rqstp) && cps.clp)
>>> +               rqstp->bc_rpc_clnt = cps.clp->cl_rpcclient;
>
>
> You can re-create the clnt->cl_timeout in svc_process_bc() by just
> storing the values of to_initval and to_retrans here. Why store a
> reference to an entire rpc client structure that you don't need?

Hmm, I think I started by thinking we could simply set tk_client, but then
didn't end up with that for other reasons and just kept passing the single
pointer.

I will send a v4 with your suggestion.

Ben


