Return-Path: <linux-nfs+bounces-15302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F8BE5012
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0CD44EDEBB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE412222D8;
	Thu, 16 Oct 2025 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BclBUnRs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FE221721;
	Thu, 16 Oct 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638196; cv=none; b=hZwwz0mP8pbBZXPD5x9VgFtZH06fdm7Mh1FqGvaxCA3OgfgCep6uMo53rhJckZseoWGDJjIKvDcJ3hHT0HncTIpIhwMPLFS/OZ/mLD5K76EGyeEj/5EcxkOpfYfDGXW+5bUId/JjODdwkDDaLEKxq9u9PjATvB/ChqSgX8kIATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638196; c=relaxed/simple;
	bh=FRAN62fSnY6qJO+g1UsOiqTuZGwBL0tpTWmPU6Wzwq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmVIFXS0eBiklWzXbyStOqzOmuHES5ZIBDMkTieiiiQlc97Rl8p7dbcocRgRhYK9J3C9XmnI3FKzm2JYCB6P/QWjGTNa+Y/LbOBG8POe83sEwxrSNTp1FFRILUZR5xguuaTLaozRzhCmus5Rac5wX+QTs41kn/hpNSLX5U6jHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BclBUnRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1385CC4CEF1;
	Thu, 16 Oct 2025 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760638195;
	bh=FRAN62fSnY6qJO+g1UsOiqTuZGwBL0tpTWmPU6Wzwq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BclBUnRs6bqWeXRqnDjG0fFXxvJ/1yZ6ELpu+6g99uRglnoxe5xatsNVcFu2Yh00S
	 +uoeKOA4Hh6IQVzdRDjd5eB1fPENHw8jwCeyj8A2WSc/GpdaXHS6haWAEMPmTJgaef
	 ytaLZCJd6QdNWsLjnM3qSCxjp2sco0lrkWwKq6eVoXkroHEuGfUQMIL0S7mvHM/L2V
	 PVQXKDi6qD6a7HYy4XkRDPiwORKEfZNSwrA7W+E/1LvluDh/9aCIpCb+u+1I3ciXmX
	 usE8sAnAypxRncUwNwv5fav5r1PC98K5Gg+SKS5QVQ05YKwd1I17Wo7mN5NZ6OFbJb
	 kPvvFUJLU4N4g==
Message-ID: <2ee650e6-9549-4241-ab6d-a294f2d7d4b6@kernel.org>
Date: Thu, 16 Oct 2025 14:09:54 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Eric Biggers <ebiggers@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Jeff Layton <jlayton@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251006135010.2165-1-cel@kernel.org>
 <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
 <20251013192103.GA61714@google.com>
 <f3a3f734-e75a-4d93-9a89-988417d5008c@kernel.org>
 <96e2c0717722be57011f4670b1a6b19bb5f4ef48.camel@kernel.org>
 <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
 <b97cea29-4ab7-4fb6-85ba-83f9830e524f@kernel.org>
 <99d95e27637c6eeb82939d98d6aa3344b7518d89.camel@kernel.org>
 <20251016180234.GC1575@sol>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20251016180234.GC1575@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/25 2:02 PM, Eric Biggers wrote:
> On Thu, Oct 16, 2025 at 11:19:24AM -0400, Trond Myklebust wrote:
>> On Thu, 2025-10-16 at 11:04 -0400, Chuck Lever wrote:
>>> On 10/16/25 10:36 AM, Geert Uytterhoeven wrote:
>>>> Hi Jeff,
>>>>
>>>> On Thu, 16 Oct 2025 at 16:31, Jeff Layton <jlayton@kernel.org>
>>>> wrote:
>>>>> On Mon, 2025-10-13 at 15:37 -0400, Chuck Lever wrote:
>>>>>> On 10/13/25 3:21 PM, Eric Biggers wrote:
>>>>>>> On Mon, Oct 13, 2025 at 12:15:52PM +0200, Geert Uytterhoeven
>>>>>>> wrote:
>>>>>>>> Hi Chuck, Eric,
>>>>>>>>
>>>>>>>> On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org>
>>>>>>>> wrote:
>>>>>>>>> Eric Biggers (4):
>>>>>>>>>       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead
>>>>>>>>> of depending on it
>>>>>>>>
>>>>>>>> This is now commit d8e97cc476e33037 ("SUNRPC: Make
>>>>>>>> RPCSEC_GSS_KRB5
>>>>>>>> select CRYPTO instead of depending on it") in v6.18-rc1.
>>>>>>>> As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-
>>>>>>>> enabled in
>>>>>>>> defconfigs that didn't enable it before.
>>>>>>>
>>>>>>> Now the config is:
>>>>>>>
>>>>>>>     config RPCSEC_GSS_KRB5
>>>>>>>         tristate "Secure RPC: Kerberos V mechanism"
>>>>>>>         depends on SUNRPC
>>>>>>>         default y
>>>>>>>         select SUNRPC_GSS
>>>>>>>         select CRYPTO
>>>>>>>         select CRYPTO_SKCIPHER
>>>>>>>         select CRYPTO_HASH
>>>>>>>
>>>>>>> Perhaps the 'default y' should be removed?
>>>>>>>
>>>>>>> Chuck, do you know why it's there?
>>>>>> The "default y" was added by 2010 commit df486a25900f ("NFS:
>>>>>> Fix the
>>>>>> selection of security flavours in Kconfig"), then modified
>>>>>> again by
>>>>>> commit e3b2854faabd ("SUNRPC: Fix the SUNRPC Kerberos V
>>>>>> RPCSEC_GSS
>>>>>> module dependencies") in 2011.
>>>>>>
>>>>>> Copying Trond, the author of both of those patches.
>>>>>
>>>>> Looking at this a bit closer, maybe a patch like this is what we
>>>>> want?
>>>>> This should make it so that we only enable RPCSEC_GSS_KRB5 if
>>>>> CRYPTO is
>>>>> already enabled:
>>>>>
>>>>> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
>>>>> index 984e0cf9bf8a..d433626c7917 100644
>>>>> --- a/net/sunrpc/Kconfig
>>>>> +++ b/net/sunrpc/Kconfig
>>>>> @@ -19,9 +19,8 @@ config SUNRPC_SWAP
>>>>>  config RPCSEC_GSS_KRB5
>>>>>         tristate "Secure RPC: Kerberos V mechanism"
>>>>>         depends on SUNRPC
>>>>> -       default y
>>>>> +       default y if CRYPTO
>>>>
>>>> This merely controls the default, the user can still override it.
>>>> Implementing your suggestion above would mean re-adding "depends on
>>>> CRYPTO", i.e. reverting commit d8e97cc476e33037.
>>>>
>>>>>         select SUNRPC_GSS
>>>>> -       select CRYPTO
>>>>>         select CRYPTO_SKCIPHER
>>>>>         select CRYPTO_HASH
>>>>>         help
>>>>
>>>> Gr{oetje,eeting}s,
>>>>
>>>>                         Geert
>>>>
>>>
>>> The graph of dependencies and selects between NFS, NFSD, and SUNRPC
>>> is
>>> brittle, unfortunately. I suggest reverting d8e97cc476e33037 for now
>>> while a proper solution is worked out and then tested.
>>>
>>
>> Yes. The reason why I went for the weaker 'default y if ...' and
>> 'depends on ...' is precisely because 'select' is so brittle, and at
>> the time others advised against using it for more complicated
>> situations such as this. The crypto code has a number of dependencies,
>> and those have been known to change both over time and across hardware
>> platforms.
> 
> CRYPTO doesn't have any dependencies.  As I documented in the commit
> itself, CRYPTO is normally selected rather than depended on.  Similar to
> how e.g. this option (RPCSEC_GSS_KRB5) already selected CRYPTO_SKCIPHER
> and CRYPTO_HASH rather than depending on them.  It doesn't really make
> sense to handle these options differently.
> 
> The real issue is RPCSEC_GSS_KRB5 being 'default y'.  The nfs folks
> should make a decision about whether they want that or not.
> 
> I'll also that NFSD_V4 already selects RPCSEC_GSS_KRB5.  Perhaps that
> already achieves what the 'default y' may have been intended to achieve?

Agreed, that's possible. My concern right now is that there are enough
testing gaps (simply because Kconfig makes the test matrix exponentially
large) that I don't have confidence that we can come up with a good fix
and get it broadly tested before v6.18 final.

I am, however, happy to continue discussing ways to improve the menu
and the settings it selects.


-- 
Chuck Lever

