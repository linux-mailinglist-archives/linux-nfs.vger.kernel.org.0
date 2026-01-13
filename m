Return-Path: <linux-nfs+bounces-17815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB9D1AEA4
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 19:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B93DE3028DA6
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D37333B962;
	Tue, 13 Jan 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHq9bR1j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59127381E
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330420; cv=none; b=OjSWWjLxUpQOhk5qCkYbncuRa/J9sPLmjifV2x0wp8tlGbCFxxOZ6OGj9Zczyi4AU4O/Qb81A0k/M8arE0m0NwDZZlyBhdNpyrCB6snryKAiSnDO4DhUDeeH2/z/EY6JTFGAt8X7ldRNTJnb1cA9WbzBAxG2avn/rEu0OIHqefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330420; c=relaxed/simple;
	bh=7H00YOm/sTaP6PM2l73cPn3aSkdl2SbbFcWG9neKkUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMLNDqcVvAfEreWqYyAnZ8pE8cBhED4ZuXDzGlQZCveCMOkAtZVHGaHn+Rz5Ee0tcka4wvS8rTSqgTz4LtZZYdspmTMyBmvYIBjvr7hUh7Mjb520SS8V5+Uxjv77P624HpykKcec/7lqYWveaIBEbILdF25PeqnIw9YeNaTQCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHq9bR1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1714BC116C6;
	Tue, 13 Jan 2026 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768330419;
	bh=7H00YOm/sTaP6PM2l73cPn3aSkdl2SbbFcWG9neKkUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHq9bR1jo2F8Ea8ea2xqnsLRgBpbjOsUvjIvL7y4wfI3lB5CxD4XvVA0Rj0mdGLri
	 lCvvS5SYGXCzL7xLvDo2QNxrdcRGmYLwffnwJn34CVoS5VlUEcEhwa4XCFERHHawIb
	 BOoqSAfdXiOvWpKp+zaDvDFbiDeayj6JnxFUOeo2HggecP4OOLvUreXJ+Fb8q2wUrw
	 Dkd6JOtaXGUd5Pm4WJka+SMkBo54cTzZhD8B0utNirlaTnDBUdp67afM6lXn4WbW+A
	 6FOQf9ZWTr0cSRPkChqmGXv8pDOU7SHzItzo1CxFV0AafjMa6Se+Bce9BREIJvvofE
	 hsOCWG0b3+jbQ==
Message-ID: <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
Date: Tue, 13 Jan 2026 13:53:31 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
 <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
 <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 12:02 PM, Benjamin Coddington wrote:
> On 13 Jan 2026, at 11:43, Chuck Lever wrote:
> 
>> On 1/13/26 11:05 AM, Benjamin Coddington wrote:
>>> On 13 Jan 2026, at 10:18, Chuck Lever wrote:
>>>
>>>> On 1/13/26 10:07 AM, Benjamin Coddington wrote:
>>>>> On 13 Jan 2026, at 9:08, Chuck Lever wrote:
>>>>>
>>>>>> On 1/13/26 6:51 AM, Benjamin Coddington wrote:
>>>>>>> Hi Chuck - I'm back working on this, hoping you'll advise:

>>> True - we could use siphash or HMAC-SHA256 as he suggested, but both would
>>> still expose detailed filesystem information to the clients which was
>>> counter to my design goal of hiding as much of this information as possible.
>>
>> We need to understand your threat model before deciding whether
>> completely obscuring the file handles is more secure than making a
>> cryptographic hash part of the on-the-wire handle.
>>
>> As far as I can tell, your proposal attempts to hide information that is
>> already available via other means.
> 
> Not necessarily true.  Filesystems create their own filehandles and so you
> cannot say that the filehandle will only ever contain information that is
> also available via other NFS attributes.
> 
>> What you really want to do is prevent a remote client (maliciously or
>> accidentally) from fabricating a file handle that can be used to access
>> areas of the exported file system that have explicitly not been shared. A
>> hash that cannot be fabricated without the server's secret key would
>> accomplish that, ISTM.
> 
> Yes - a MAC will do, as I have already said several times.
> 
>>> Using a MAC may have the advantage of sometimes resulting in smaller
>>> filehandles (siphash would add 8 bytes to _every_ filehandle).  But it also
>>> may not result in smaller filehandles when the unhashed size lands on or
>>> just under the 16 byte blocks that AES wants.
>>>
>>> What would you like to see used here?  I do not think that allocating 32
>>> bytes for each knfsd thread for this optional feature to be a problem.
>>
>> I would like to not add yet another layering violation between SunRPC
>> and NFSD, especially because there has been no evidence that AES or
>> anything like it is going to provide any meaningful benefit.
> 
> I think we can do it without adding yet another layering violation, Jeff's
> suggestion was on-point.
> 
> Also, it sounds like you don't agree that hiding filehandle internals from
> clients is a more complete solution.  I disagree with you but don't need to
> argue the point, the details are clear.

No, what I'm saying is you haven't described your threat model in enough
detail to justify the proposed design of encrypting file handles. I'm
not saying the justification isn't there at all. I'm saying you need to
bring the rest of us along.

Yes, I found a technical issue with the proposal (abuse of the layering
boundary between SunRPC and NFSD). But I'm concerned about the bigger
picture: what's broken? Why does NFSD need this feature? Is file handle
protection the best or most complete approach? For this initial review,
that needs to be discussed first, based on the kinds of attacks you
foresee. Which are ... ?


>> Let's stick with the simplest hash/encryption approaches until we
>> can see that hardware optimization is necessary. That already leaves
>> out the need to dynamically allocate buffers.
> 
> I will also assert that AES is pretty simple.  Complexity isn't an issue here.
> Buffer allocation is also not complex.

The simpler approaches won't demand dynamically allocated buffers, nor
will they nail another CRYPTO dependency on the NFSD module. I believe
either encryption or signing can be done without introducing either
complication.


> But you're the maintainer so, ok.  If you don't see value in the current
> proposal

This is /reductio ad absurdum/ -- I never said I didn't see any value. I
said the value needs to be explained and demonstrated more clearly.

And, I've read at least two other commenters in this thread (Neil and
Eric) who have asked clarifying questions about what is the purpose of
this proposal. So it's not just me.

In fact, I agree file handle protection could be valuable, but it
doesn't feel to me that we have a consensus about why and what it needs
to do.


> I'll need to rename this feature, because it will not be encryption
> at all - so how about some bikeshedding?  :)  Hashed filehandles?
> Authenticated filehandles?  MACFH?

If we decide to use a MAC, "signed file handles" is accurate, concise,
and follows industry convention.

But let's do some homework first. What exactly are you trying to protect
against? Let's hear some specific examples so we are all on the same
page.

I'm asking because the folks on this mailing list you are presenting
this to for review were not present for the in-person discussion, or
more pertinently, might not know or care to know how NFS file handles
are utilized. (How did linux-crypto get stripped off this thread?)

I'm also asking because the feature will need coherent administrative
UIs and documentation. Having a detailed threat model (also listing
threats that are not designed to be protected against) will help
immensely.

So here are some questions that might be pertinent to me doing a
diligent review:

Is the issue an artifact of the design of the NFS protocol?

Is it a problem specific to the Linux NFS server implementation?

Is it a problem specific to certain file system types?

Is it a problem specific to certain export options? (I think I heard a
yes in there somewhere)

Why precisely do you believe obscuring file handle information is more
beneficial than simply signing it?

Why do you want to protect file handles, in specific, without using in-
transit transport encryption like krb5p or TLS, or without protecting
other XDR data elements?

How much work do you think an attacker might be willing to do to
crack this protection? This goes to selection of algorithm and key
size, and decisions about whether one key protects all of a server's
exports, or each export gets its own key.

What are your performance goals and how do you plan to measure them?


-- 
Chuck Lever

