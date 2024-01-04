Return-Path: <linux-nfs+bounces-923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F065C82416C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 13:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A375D1F22756
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D102F21369;
	Thu,  4 Jan 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jv4RQtrT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D02137A
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704370434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fE0KotzFH+YWUKt15FwiXDTejYklHvADvzLvOeVbHns=;
	b=Jv4RQtrTLOJxuToFhLGbAw0HPg3TOUYOF6ztvUVqW9oPn5RW2LWf24qMbS6Q/8xrLC72i1
	4nbut35rDwhTRfVZ1kzbnRwL4Fvwq0mGNl8J+/OZIJljLTjV0Ho1tFGUi0JNaK5rYQRArH
	GQUoo5+IgnuwuORQTVnAJN+NdDob+5o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-8W4_B05wNlm6ZJEJBQFZxQ-1; Thu,
 04 Jan 2024 07:13:52 -0500
X-MC-Unique: 8W4_B05wNlm6ZJEJBQFZxQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F23D3813BC1;
	Thu,  4 Jan 2024 12:13:52 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A22A0492BC6;
	Thu,  4 Jan 2024 12:13:51 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] NFSv4.1: Use the nfs_client's rpc timeouts for
 backchannel
Date: Thu, 04 Jan 2024 07:13:50 -0500
Message-ID: <47231988-6BE0-4A1C-93CE-F5D14600BA8F@redhat.com>
In-Reply-To: <25DCF24F-FB84-4A52-A66E-63A445197AB6@redhat.com>
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1702496910.git.bcodding@redhat.com>
 <90c9365ad91e1eb0058b170fb332ea70ad554d8b.1702496910.git.bcodding@redhat.com>
 <CAFX2Jf=CARs=2pPhi-Lj_ydZKyqpjA=kZQoWDNsRKM3gdp=CYw@mail.gmail.com>
 <1aa005d1c0b344a455ced93be866dff3c316e15e.camel@hammerspace.com>
 <25DCF24F-FB84-4A52-A66E-63A445197AB6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 4 Jan 2024, at 6:55, Benjamin Coddington wrote:

> On 3 Jan 2024, at 18:00, Trond Myklebust wrote:
>
>> On Wed, 2024-01-03 at 16:45 -0500, Anna Schumaker wrote:
>>> Hi Ben,
>>>
>>> On Wed, Dec 13, 2023 at 2:49 PM Benjamin Coddington
>>> <bcodding@redhat.com> wrote:
>>>>
>>>> For backchannel requests that lookup the appropriate nfs_client,
>>>> use the
>>>> state-management rpc_clnt's rpc_timeout parameters for the
>>>> backchannel's
>>>> response.  When the nfs_client cannot be found, fall back to using
>>>> the
>>>> xprt's default timeout parameters.
>>>
>>> I'm seeing a use-after-free after applying this patch when using pNFS
>>> and session trunking. Any idea what's going on? Here is the stack
>>> trace I'm seeing:
>>
>> I'm going to guess that this is happening because nothing is clearing
>> rqstp->bc_rpc_clnt after a call to svc_process_bc(). So if something
>> later calls CB_NULL, then the resulting svc_process_bc() will free an
>> extra reference.
>
> Doh!
>
>>>
>>> I hit this while testing against ontap, if that helps.
>>>
>>> Thanks,
>>> Anna
>
> Thank you for the test!!
>
>>>> --- a/fs/nfs/callback_xdr.c
>>>> +++ b/fs/nfs/callback_xdr.c
>>>> @@ -967,6 +967,9 @@ static __be32 nfs4_callback_compound(struct
>>>> svc_rqst *rqstp)
>>>>                 nops--;
>>>>         }
>>>>
>>>> +       if (svc_is_backchannel(rqstp) && cps.clp)
>>>> +               rqstp->bc_rpc_clnt = cps.clp->cl_rpcclient;
>>
>>
>> You can re-create the clnt->cl_timeout in svc_process_bc() by just
>> storing the values of to_initval and to_retrans here. Why store a
>> reference to an entire rpc client structure that you don't need?
>
> Hmm, I think I started by thinking we could simply set tk_client, but then
> didn't end up with that for other reasons and just kept passing the single
> pointer.

.. and the client being NULL was the signal to fallback to using the xprt
timeouts.  That's lost with to_initval and to_retries because they can be
set to zero deliberately.  I'm not immediately seeing an easy way to carry
all that info across on the svc_rqst without three additional fields or
another struct.  Either we drop the part where we fallback to the xprt
defaults, or things get a bit uglier.

Ben


