Return-Path: <linux-nfs+bounces-17800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 891BED19D6B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 16:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 580C6300EDC3
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235CF2D7813;
	Tue, 13 Jan 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZVDhVyb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157F22083
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317493; cv=none; b=MjRsnuz0ieiBzpVIXeU2CnKN7BJg0UzsH0wwQKmh+40br2zy+wesXonql6zNniYQ5DtIlbNQrGu6VD+JxzVnsPC9bWrdPEIuzDxjDkzQwxb/Ig+GSa6OodQnCMTrLDrAWowy9LuJWeCMKC4g2Tp6H9NIzsA0vH8U6hm2a/y5EaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317493; c=relaxed/simple;
	bh=4gr6JaD+6p8sJHw7d2tdtUTX519l1rGkU1agpJ/9BsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYtG1LxRhoBxjKPHwUNXJIxTpy7PWgwy0fC4aX2RchtWVIb7l8m93hqfLmZ9vsqAHtVxJfZYoprT9G+i0UYQ3QVdGYOszwoBy/8v7gj2FCfS6aJFwTAt6VxbfrGV9qgPBcxAL3a/eHavXLrWBzmpVyjUOGB5hEC9wN0yS+lQZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZVDhVyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB45C19421;
	Tue, 13 Jan 2026 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317492;
	bh=4gr6JaD+6p8sJHw7d2tdtUTX519l1rGkU1agpJ/9BsA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cZVDhVybVt1XgGROxRQixTlCddMjnJ0EeG8HIdumL/Rwi5Lk2sPQDJd3bYTdg6dfE
	 7XTLnzTcvhfT+AnQds7wrS0MlW2uloUxYTWaVrCZqGJ/qJfjkb25yD5oSNmpIDUrJ6
	 M5Lswp0FbnYVcC6HxvSPOjSfU4hseNgq+0iQOrcSH1/KgZWMn7V9wnSodw4ne51gGH
	 AQEEgYPY8gtFmJtD/3XYFeVMzKFh5TlHXU4UT1J5MJUkU9O1j/SfdrClJIbvaKGMdw
	 HuG9n2yVkKtbIw99rYd10yNra6BgzvzUP6e8x4fiJnfXQGS0rbwfgs1tA85SCxqB1z
	 29mJyfwi90zEg==
Message-ID: <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
Date: Tue, 13 Jan 2026 10:18:04 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
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
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 10:07 AM, Benjamin Coddington wrote:
> On 13 Jan 2026, at 9:08, Chuck Lever wrote:
> 
>> On 1/13/26 6:51 AM, Benjamin Coddington wrote:
>>> Hi Chuck - I'm back working on this, hoping you'll advise:
>>>
>>> On 29 Dec 2025, at 8:23, Benjamin Coddington wrote:
>>>
>>>> On 28 Dec 2025, at 12:09, Chuck Lever wrote:
>>>>
>>>>> Hi Ben -
>>>>>
>>>>> Thanks for getting this started.
>>>>
>>>> Hi Chuck,
>>>>
>>>> Thanks for all the advice here - I'll do my best to fix things up in the
>>>> next version, and I'll respond to a few things inline here:
>>>>
>>> ...
>>>
>>>>> I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
>>>>> is really an RPC layer object. I know we still have some NFSD-specific
>>>>> fields in there, but those are really technical debt.
>>>>
>>>> Doh, ok - good to know.  How would you recommend I approach creating
>>>> per-thread objects?
>>>
>>> Though the svc_rqst is an RPC object, it's really the only place for
>>> marshaling per-thread objects.  I coould use a static xarray for the buffers,
>>> but freeing them still needs some connection to the RPC layer.  Would you
>>> object to adding a function pointer to svc_rqst that can be called from
>>> svc_exit_thread?
>> Forgive me, but at this point I don't recall what you're tracking per
>> thread and whether it makes sense to do per-thread tracking. Can you
>> summarize? What problem are you trying to solve?
> 
> I need small, dynamically allocated buffers for hashing the filehandles, and
> it makes the most sense to have them per-thread as that's the scope of
> contention.  I want to allocate them once when(if) they are needed, and free
> them when the thread exits.
I'm asking what are these buffers for. Because this could be a premature
optimization, or even entirely unneeded, but I can't really tell at this
level of detail.

So is this because you need a dynamically allocated buffer for calling
the sync crypto API? If so, Eric has already explained that there is
a better API to use for that, that perhaps would not require the use
of a dynamically-allocated buffer.


-- 
Chuck Lever

