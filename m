Return-Path: <linux-nfs+bounces-16764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C81C8F995
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537F83AACA0
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5516D2E0417;
	Thu, 27 Nov 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSj0CarI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7C2DEA87;
	Thu, 27 Nov 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263292; cv=none; b=oHutbb5/Y7H1+w58NfyVegSjw7O/gQDnFPboVeABKjdRYqN7C6UKVxM1T6clle6fPpFRJG3v5qDlzJbTkoRTsF2hNKfKL0+5+T6CZCsgwTThxj30J8vRSlBJMxSsY64U+NnYQ6zPFH7J8JcX2q584a8nEDcZb/Tc8F6W3vCR31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263292; c=relaxed/simple;
	bh=T2NeJIvr7/ZhVpovep/tsqBAbL2dBmZl3rd7BLzJYLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQAvqsf5pxapWIr4Co0FBA6z0IM3PHw0NWVFM8fxle9bpUI9GEcvjrS288mb7w0NyZucGo6PNmAd/2kDVSk6/WtqmU4gzEg9dGoGsu/5uiIesk3oJsXf0Z0cZ3WQhnF6QkUKvvjV3zAKt0g7gq/bYK71hYOfT90sLdZRMHEIPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSj0CarI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE55C4CEF8;
	Thu, 27 Nov 2025 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764263291;
	bh=T2NeJIvr7/ZhVpovep/tsqBAbL2dBmZl3rd7BLzJYLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BSj0CarI+15dFC9foWUZ8Dv7KW1r6WH62d60JYRIIB1wOxLc9+cdBIRfVo0ctd+g8
	 zqGUFfDqe9xySk8p0rKejdrfGvxH6lxYtLexCsYv6X7/nPywufrDoc7k2++wxERIay
	 XrMScCcoRz12M5gUeEJCeC0CeEn8WY5/iudoQRirBTLPAKoYFDaN0q7vH/6UPrawCM
	 tZ7NwXbYk1QlefpKQWX6dMrHMWMLd4XYmZGeIEdoXC86iw96mPPNyAZyrrYMbTJaN6
	 4fm8znBEp9UEt1GNMLs1dP/+canCSz2+BiGBcGPCA1XSFZgBWVxzlL4BuuuK+keV9g
	 APmM2HhaabfUg==
Message-ID: <52260b53-9ed8-400a-aaed-b1dc9e7910e9@kernel.org>
Date: Thu, 27 Nov 2025 12:08:09 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] nfsd: Mark variable __maybe_unused to avoid W=1
 build break
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20251113083131.2239677-1-andriy.shevchenko@linux.intel.com>
 <176338731878.4204.10224670039692915729.b4-ty@oracle.com>
 <aSgCyqR72Zu6TSSI@black.igk.intel.com>
 <087f6258-a605-4e8c-9fa7-420ec12bef6f@kernel.org>
 <aSiCg0i4wMXk6QxV@smile.fi.intel.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aSiCg0i4wMXk6QxV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 11:55 AM, Andy Shevchenko wrote:
> On Thu, Nov 27, 2025 at 11:20:16AM -0500, Chuck Lever wrote:
>> On 11/27/25 2:50 AM, Andy Shevchenko wrote:
>>> On Mon, Nov 17, 2025 at 08:49:29AM -0500, Chuck Lever wrote:
>>>> On Thu, 13 Nov 2025 09:31:31 +0100, Andy Shevchenko wrote:
>>>>> Clang is not happy about set but (in some cases) unused variable:
>>>>>
>>>>> fs/nfsd/export.c:1027:17: error: variable 'inode' set but not used [-Werror,-Wunused-but-set-variable]
>>>>>
>>>>> since it's used as a parameter to dprintk() which might be configured
>>>>> a no-op. To avoid uglifying code with the specific ifdeffery just mark
>>>>> the variable __maybe_unused.
> 
> [...]
> 
>>>> Applied to nfsd-testing, thanks!
>>>>
>>>> [1/1] nfsd: Mark variable __maybe_unused to avoid W=1 build break
>>>>       commit: 56e9f88b25abf08de6f2b1bfbbb2ddc4e6622d1e
>>>
>>> Thanks, but still no appearance in Linux Next and problem seems to be present.
>>>
>>
>> The usual practice is to keep patches in nfsd-testing for four
>> weeks to allow NFSD and community CI processes to work, and to
>> enable extended review before it is merged. Both the community
>> CI processes (eg, zero-day bots) and the availability of
>> reviewers are not something I have control over.
>>
>> It will be available for upstream merge after December 11. You
>> seem to be suggesting there is a sense of urgency so I will
>> direct it towards v6.20-rc as soon as it is merge-ready.

Oops:

s/v6.20-rc/v6.19-rc/


> Since it's (not so critical TBH, but still) a build breakage I supposed this to
> go via the respective -fixes path.

Yes, what I meant above was I will submit it just after the
v6.19 merge window closes in a few weeks.


> But okay, your call.

It's just a build warning, but I know such issues affect the
Fedora and Red Hat kernel build pipelines, as they enable the
"warning => error" compile option.

However, those distributions enable SunRPC debugging, which
means they won't see it. So I think this problem is not likely
to be pervasive.


-- 
Chuck Lever

