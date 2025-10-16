Return-Path: <linux-nfs+bounces-15296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905FEBE41E2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 17:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441F9587620
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7832E54BF;
	Thu, 16 Oct 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOF+3oi9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC22D9EE0;
	Thu, 16 Oct 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627066; cv=none; b=RARN/BOcC7Olt2VvSDnaSxhkNHTYGxU7i8MFu3mx8jQy1n0G9EZ+PQ8SENe4fp5Pu2jMgaJ7TgWY0aa3BvftyLq8EzpuJj/YXtL8hufWq6okZDs+9nHgNm8DSTnXTUO+z29f2uQbSVr+M9/aSsDvaIe96hwTO4K+lJPZODtUAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627066; c=relaxed/simple;
	bh=KK+bB7eCx9diDvP/qb7+d4CftEvBpwH/DqcEJeTzdiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8537/meaZh9zwUsQtpwK0k3cyjTPKUGNbzJBxo39PunNydN2K8sRfyn1IfNWGIReIS8R39TTWsfwTTD0YDAFGXevQuXdzotInCa5HpFjHUCgEgisOCY9d1bk3CpW6lrNY2jBm84itBeT2bDbW7SwewtCz5g8lcs61nZxm+zqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOF+3oi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEE4C4CEF1;
	Thu, 16 Oct 2025 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760627066;
	bh=KK+bB7eCx9diDvP/qb7+d4CftEvBpwH/DqcEJeTzdiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vOF+3oi9oGoEIUgCsmyXZ+yoDTOTwFiqESXf/e8Y96aRMBd81rcdijWtcb9nEsx1/
	 5glIPbYmr6VZGRnHLXnTuZHPXT12C4/x7ufJnk8ik7546giBG8G1W6VlCkJh8efSyg
	 Q09R+DwnqjBIHWNI/ntmvVBeN6T76yg+Bz8rRyMI0YFU5JwxKzj755AbgR363bqNqa
	 wozSQ7UczRldU1SyI0HByJM/ea8ZwQzciSxM6K/k7PmfKj+orNaFI7nKW7lMKWzOu8
	 S3SMIzGWrRV4dCDMRn5t+3E4UJkpJsJNGuQN/DO04r9FiAzffLupkuV0U2aej6aOVt
	 C8VGven9nPP3A==
Message-ID: <b97cea29-4ab7-4fb6-85ba-83f9830e524f@kernel.org>
Date: Thu, 16 Oct 2025 11:04:24 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Jeff Layton <jlayton@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251006135010.2165-1-cel@kernel.org>
 <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
 <20251013192103.GA61714@google.com>
 <f3a3f734-e75a-4d93-9a89-988417d5008c@kernel.org>
 <96e2c0717722be57011f4670b1a6b19bb5f4ef48.camel@kernel.org>
 <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 10:36 AM, Geert Uytterhoeven wrote:
> Hi Jeff,
> 
> On Thu, 16 Oct 2025 at 16:31, Jeff Layton <jlayton@kernel.org> wrote:
>> On Mon, 2025-10-13 at 15:37 -0400, Chuck Lever wrote:
>>> On 10/13/25 3:21 PM, Eric Biggers wrote:
>>>> On Mon, Oct 13, 2025 at 12:15:52PM +0200, Geert Uytterhoeven wrote:
>>>>> Hi Chuck, Eric,
>>>>>
>>>>> On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org> wrote:
>>>>>> Eric Biggers (4):
>>>>>>       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it
>>>>>
>>>>> This is now commit d8e97cc476e33037 ("SUNRPC: Make RPCSEC_GSS_KRB5
>>>>> select CRYPTO instead of depending on it") in v6.18-rc1.
>>>>> As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-enabled in
>>>>> defconfigs that didn't enable it before.
>>>>
>>>> Now the config is:
>>>>
>>>>     config RPCSEC_GSS_KRB5
>>>>         tristate "Secure RPC: Kerberos V mechanism"
>>>>         depends on SUNRPC
>>>>         default y
>>>>         select SUNRPC_GSS
>>>>         select CRYPTO
>>>>         select CRYPTO_SKCIPHER
>>>>         select CRYPTO_HASH
>>>>
>>>> Perhaps the 'default y' should be removed?
>>>>
>>>> Chuck, do you know why it's there?
>>> The "default y" was added by 2010 commit df486a25900f ("NFS: Fix the
>>> selection of security flavours in Kconfig"), then modified again by
>>> commit e3b2854faabd ("SUNRPC: Fix the SUNRPC Kerberos V RPCSEC_GSS
>>> module dependencies") in 2011.
>>>
>>> Copying Trond, the author of both of those patches.
>>
>> Looking at this a bit closer, maybe a patch like this is what we want?
>> This should make it so that we only enable RPCSEC_GSS_KRB5 if CRYPTO is
>> already enabled:
>>
>> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
>> index 984e0cf9bf8a..d433626c7917 100644
>> --- a/net/sunrpc/Kconfig
>> +++ b/net/sunrpc/Kconfig
>> @@ -19,9 +19,8 @@ config SUNRPC_SWAP
>>  config RPCSEC_GSS_KRB5
>>         tristate "Secure RPC: Kerberos V mechanism"
>>         depends on SUNRPC
>> -       default y
>> +       default y if CRYPTO
> 
> This merely controls the default, the user can still override it.
> Implementing your suggestion above would mean re-adding "depends on
> CRYPTO", i.e. reverting commit d8e97cc476e33037.
> 
>>         select SUNRPC_GSS
>> -       select CRYPTO
>>         select CRYPTO_SKCIPHER
>>         select CRYPTO_HASH
>>         help
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

The graph of dependencies and selects between NFS, NFSD, and SUNRPC is
brittle, unfortunately. I suggest reverting d8e97cc476e33037 for now
while a proper solution is worked out and then tested.


-- 
Chuck Lever

