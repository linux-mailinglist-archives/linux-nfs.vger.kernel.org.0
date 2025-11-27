Return-Path: <linux-nfs+bounces-16761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5907C8F7BC
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 17:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 716184E3BF2
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA962C3774;
	Thu, 27 Nov 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8QvJDGU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB02C326C;
	Thu, 27 Nov 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260418; cv=none; b=ZIaQ4pCPURICkCvr/QCUwsMCfbpx2kD6K746CDoHB9AKh4sB2wjoNOEoPqUXXT/hRNPmETRuee91y8I8ea5A08y5t5Rp1hP0+kta2FdQVX1qr9A1sBFGy/0bUbnGgiRvBLO30+nL6rmCUGdoW8lFXNwJvQ1Tob0eDiHGykjKikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260418; c=relaxed/simple;
	bh=rzS0jGh+hilv8WHovLt2Uz1fCgQWt6SnRKnUNSE6gWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3C30ERXPRG7ayhExQaqECYejeWMcE+5HWwrPCpn79fT7LRLGvf3/nN/gKn5o9XwEEPixffFk+ckAJ6jBO2Jro4wD4pprIHv1g/dPLwo6NVOXvclg2TFk20CLHCJw8XHxQIRPRD3mA1SuarwgOnTm1p2cHWAnjbAL1YWfJslKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8QvJDGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819FFC113D0;
	Thu, 27 Nov 2025 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764260418;
	bh=rzS0jGh+hilv8WHovLt2Uz1fCgQWt6SnRKnUNSE6gWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X8QvJDGUp0wxYnjoMhsHiVZJhG6GZu1S5fXMN7pGPdgh/cwf8lW4JRQTeyHpU7K4R
	 WhAQ/N8n2xIQDF9Jh0lJCw78HXA4Cs2gXDNoKQhx8EolihBuDjp+rgfMH7Ggz8a5sU
	 mXUtWvW1Swtf9SPesC8rrihkZdKlXlZylA5kk1uZPxxdCFopy4LcxfRbMylj3Uc0VF
	 +mo6xqkiOPeLc2HGE6hqYpSCMGhiZzEuH2ZcsH0x7eudEt9JjKdl5IeXBADNYS6gS2
	 UnUIbNwfAUANUFoDw8uV6ruKzh/ojEgktJ7z/iCxfmn7/5wCruRfUy534hFKR+UBbF
	 Nu/IRAI8K6mUg==
Message-ID: <087f6258-a605-4e8c-9fa7-420ec12bef6f@kernel.org>
Date: Thu, 27 Nov 2025 11:20:16 -0500
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
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aSgCyqR72Zu6TSSI@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 2:50 AM, Andy Shevchenko wrote:
> On Mon, Nov 17, 2025 at 08:49:29AM -0500, Chuck Lever wrote:
>> On Thu, 13 Nov 2025 09:31:31 +0100, Andy Shevchenko wrote:
>>> Clang is not happy about set but (in some cases) unused variable:
>>>
>>> fs/nfsd/export.c:1027:17: error: variable 'inode' set but not used [-Werror,-Wunused-but-set-variable]
>>>
>>> since it's used as a parameter to dprintk() which might be configured
>>> a no-op. To avoid uglifying code with the specific ifdeffery just mark
>>> the variable __maybe_unused.
> 
> [...]
> 
>> Applied to nfsd-testing, thanks!
>>
>> [1/1] nfsd: Mark variable __maybe_unused to avoid W=1 build break
>>       commit: 56e9f88b25abf08de6f2b1bfbbb2ddc4e6622d1e
> 
> Thanks, but still no appearance in Linux Next and problem seems to be present.
> 

The usual practice is to keep patches in nfsd-testing for four
weeks to allow NFSD and community CI processes to work, and to
enable extended review before it is merged. Both the community
CI processes (eg, zero-day bots) and the availability of
reviewers are not something I have control over.

It will be available for upstream merge after December 11. You
seem to be suggesting there is a sense of urgency so I will
direct it towards v6.20-rc as soon as it is merge-ready.


-- 
Chuck Lever

