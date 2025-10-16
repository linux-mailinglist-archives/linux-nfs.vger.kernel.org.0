Return-Path: <linux-nfs+bounces-15308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF4BE5259
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 21:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B115861E0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83B23BF91;
	Thu, 16 Oct 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMQvgqUc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9631D554;
	Thu, 16 Oct 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641208; cv=none; b=GsU+RVwDozW4NRVjwC1y1HcrDDqtjc7F8u7VwuEPhFbj3OOTPhW2XgDmMgt6o7Ach69y7ZldZomQmV7wY4OAER2NBiVphu8jh4Wo8vnuMBZ3fJ3LH2aE/JLkxKDek9QOE8NbOkQNXjNZ88z+OeJHlYDPOp3QCfI2899UR6dTiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641208; c=relaxed/simple;
	bh=yyTMrVAjEHweiSiDmf5/LYldiN4BNE5AsYIzz9qUMIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwRKL5411pPGhUplhPdAeSVGDN71adOaVnzRWISkNwPapG0vCke+9twIw/9dCEnNUMcnvO63Kp27a1AuOdrUD5fQ9E44NobXtnEfeTtgSbswg4SWY8/7HjXMGqUNLoyD6BhRQONgmhtz80C4aCNpLL0gxjb7ObhvOhl7gi2jQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMQvgqUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283BFC4CEF1;
	Thu, 16 Oct 2025 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760641207;
	bh=yyTMrVAjEHweiSiDmf5/LYldiN4BNE5AsYIzz9qUMIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OMQvgqUcI7yFdhroDNWio+BzuRZi9OOnplitqSD4c6yDpmKeT4gmdPLd06JfsYeP4
	 NI9px2pfIJHtwcwFpP3y6Ytt3KkyFIo0XYXGvYhmPfYSpfbRi9gN5jYRqmzYK5FxaT
	 AXIgolAcPCD7IbEQzYT21bgMmYNLbogmV82AsDZ5/YqhPzro0FyzXnJz1ruMRMYd/O
	 tkMaq1MArA3LLjt05rJCjiiwO7U010AHLupLYV/aw17VAow+adqRRiQzyZ81ElZRJX
	 CstC9VXoHO4zMpueiODQStRbvSbgKvo0ebjGJ/UEQTKk9vTDQWR8wqXUKpR1Rx0991
	 MPXUyeMA3S5Iw==
Message-ID: <c62debc0-e2e8-45e2-8b07-8d8047044764@kernel.org>
Date: Thu, 16 Oct 2025 15:00:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: Use MD5 library instead of crypto_shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251016181534.17252-1-ebiggers@kernel.org>
 <176063936413.28537.4413010868699924082.b4-ty@oracle.com>
 <20251016185339.GA1418608@google.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20251016185339.GA1418608@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 2:53 PM, Eric Biggers wrote:
> On Thu, Oct 16, 2025 at 02:31:46PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> On Thu, 16 Oct 2025 11:15:34 -0700, Eric Biggers wrote:
>>> Update NFSD's support for "legacy client tracking" (which uses MD5) to
>>> use the MD5 library instead of crypto_shash.  This has several benefits:
>>>
>>> - Simpler code.  Notably, much of the error-handling code is no longer
>>>   needed, since the library functions can't fail.
>>>
>>> - Improved performance due to reduced overhead.  A microbenchmark of
>>>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
>>>
>>> [...]
>>
>> Applied to nfsd-testing, thanks!
>>
>> Note that the posted version of this patch does not apply cleanly to
>> the nfsd-testing branch here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-testing
>>
>> Be sure to rebase on that branch when posting subsequence patches
>> that target NFSD.
> 
> Sorry, I had just based it on v6.18-rc1.  It did also apply cleanly to
> nfsd-testing f59a20b8390dd with either 'git am -3' or 'git cherry-pick'.
> 
> I noticed you changed the author to yourself when applying.  Could you
> fix that?

That was unintentional, due to applying the patch by hand. Fixed.


-- 
Chuck Lever

