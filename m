Return-Path: <linux-nfs+bounces-17805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5DD1A5E0
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C0FA300DB1D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD1C32BF5B;
	Tue, 13 Jan 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmxGDZSU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72032AAB0
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322636; cv=none; b=eTK3yJhnZ/z+Bv7Js1UJZLOciTvsYkiWPlPsIfKAyNE8fvYObcgIH2ZnidG/R7Q52Q1BkfRdbNyS8wQGwOYjaEYGRkOnc9+XLYBiV6E5SP/BIEQSLzorTExXYP+SVCAVG21s2CgfH4WfDGZsVt0bRm5jjjeVSX5oxK2b9GRBz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322636; c=relaxed/simple;
	bh=qaaOKVht51r2C2pHStyY0x0esZTfVius3WNmqXtclh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVt2wEDfS00otBUxwnipMueqVN+dR5rx8GFBqyZ7za6clJFig83BWaPf130+Rm0O+mBXM9W43ilXh1Lcfs3TBqzTB69m6/hmgwEUNbvuP6N3IIyjpM4EDaT4owrsMMilpG6eCaP4Ys+w9OlcosrCJLi0YC2xeb467+CiO/pjyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmxGDZSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7E4C116C6;
	Tue, 13 Jan 2026 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322636;
	bh=qaaOKVht51r2C2pHStyY0x0esZTfVius3WNmqXtclh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XmxGDZSUfl/fVm/ClqxdDzFrqvx4HXM7SftTXavjUuv5ZFcZfGQG1GTRI+k8ihm6G
	 r0Fi636nPDpXEKNFyK6lCUASZFbO15cgl/TV7FIN5+rRDWdc3HCdRMS06aet6gM6py
	 PmSAVZe0iVMM8EAFjONJs71d2gHleQsYUO4donGRAq9CttzWBmlK23zFNG944zmDD2
	 YPCSLc2rO4M1c0tzQxdEvZHyMhgsJteMI2rljzR85uw2hj5sJkGI78U7naWsiNs0kL
	 IThVaqbii0JI09FX0t1hWmK9+KrU+Oc7lImJgUDjsxiV1X/JpWUzB2c2hY4DFrGt9f
	 JqmhFE4qPi8AQ==
Message-ID: <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
Date: Tue, 13 Jan 2026 11:43:48 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
 <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 11:05 AM, Benjamin Coddington wrote:
> On 13 Jan 2026, at 10:18, Chuck Lever wrote:
> 
>> On 1/13/26 10:07 AM, Benjamin Coddington wrote:
>>> On 13 Jan 2026, at 9:08, Chuck Lever wrote:
>>>
>>>> On 1/13/26 6:51 AM, Benjamin Coddington wrote:
>>>>> Hi Chuck - I'm back working on this, hoping you'll advise:
>>>>>
>>>>> On 29 Dec 2025, at 8:23, Benjamin Coddington wrote:
>>>>>
>>>>>> On 28 Dec 2025, at 12:09, Chuck Lever wrote:
>>>>>>
>>>>>>> Hi Ben -
>>>>>>>
>>>>>>> Thanks for getting this started.
>>>>>>
>>>>>> Hi Chuck,
>>>>>>
>>>>>> Thanks for all the advice here - I'll do my best to fix things up in the
>>>>>> next version, and I'll respond to a few things inline here:
>>>>>>
>>>>> ...
>>>>>
>>>>>>> I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
>>>>>>> is really an RPC layer object. I know we still have some NFSD-specific
>>>>>>> fields in there, but those are really technical debt.
>>>>>>
>>>>>> Doh, ok - good to know.  How would you recommend I approach creating
>>>>>> per-thread objects?
>>>>>
>>>>> Though the svc_rqst is an RPC object, it's really the only place for
>>>>> marshaling per-thread objects.  I coould use a static xarray for the buffers,
>>>>> but freeing them still needs some connection to the RPC layer.  Would you
>>>>> object to adding a function pointer to svc_rqst that can be called from
>>>>> svc_exit_thread?
>>>> Forgive me, but at this point I don't recall what you're tracking per
>>>> thread and whether it makes sense to do per-thread tracking. Can you
>>>> summarize? What problem are you trying to solve?
>>>
>>> I need small, dynamically allocated buffers for hashing the filehandles, and
>>> it makes the most sense to have them per-thread as that's the scope of
>>> contention.  I want to allocate them once when(if) they are needed, and free
>>> them when the thread exits.
>> I'm asking what are these buffers for. Because this could be a premature
>> optimization, or even entirely unneeded, but I can't really tell at this
>> level of detail.
>>
>> So is this because you need a dynamically allocated buffer for calling
>> the sync crypto API?
> 
> Yes.
> 
>> If so, Eric has already explained that there is a better API to use for
>> that, that perhaps would not require the use of a dynamically-allocated
>> buffer.
> 
> If he did, please show me where - I only received one message from him which
> lamented my lack of my problem explanation.  I responded with much more
> detail, and nothing further came from that.  V2 will do better.  I missed
> any assertion that we wouldn't need dynamically-allocated buffers.
> 
> True - we could use siphash or HMAC-SHA256 as he suggested, but both would
> still expose detailed filesystem information to the clients which was
> counter to my design goal of hiding as much of this information as possible.

We need to understand your threat model before deciding whether
completely obscuring the file handles is more secure than making a
cryptographic hash part of the on-the-wire handle.

As far as I can tell, your proposal attempts to hide information that is
already available via other means. What you really want to do is prevent
a remote client (maliciously or accidentally) from fabricating a file
handle that can be used to access areas of the exported file system that
have explicitly not been shared. A hash that cannot be fabricated
without the server's secret key would accomplish that, ISTM.


> Using a MAC may have the advantage of sometimes resulting in smaller
> filehandles (siphash would add 8 bytes to _every_ filehandle).  But it also
> may not result in smaller filehandles when the unhashed size lands on or
> just under the 16 byte blocks that AES wants.
> 
> What would you like to see used here?  I do not think that allocating 32
> bytes for each knfsd thread for this optional feature to be a problem.

I would like to not add yet another layering violation between SunRPC
and NFSD, especially because there has been no evidence that AES or
anything like it is going to provide any meaningful benefit.

Let's stick with the simplest hash/encryption approaches until we
can see that hardware optimization is necessary. That already leaves
out the need to dynamically allocate buffers.


-- 
Chuck Lever

