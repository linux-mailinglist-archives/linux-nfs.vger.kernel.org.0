Return-Path: <linux-nfs+bounces-17565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0817CFE613
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 15:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31979300F9CF
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5E34EEFD;
	Wed,  7 Jan 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5O2RbAM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DB34EEFC
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796980; cv=none; b=MT9Md3Bk0h3cVPBAg2DrMKKzjxhyx1wI1T41AZ6CGrbT10s7QTD89Iqc263G7EQfFwQbocqbnrHpskJZYcxEcNcTyBQhRQzQ0sJrXy3oFTTAOoFeXXDx9JK4Wm784mz9CfIeRI+ccfHcIJbA4ZYcCWFNQog+1T1dx2eWRrxRsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796980; c=relaxed/simple;
	bh=ltflRgA5Bp9OA1RMBECAX5T5ojm9RyqbJA6IDlJdEgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkzvd4b5fzLpv4UmzpKTCn6SXxuCz3yiSnRlIXZ4D1dOARPnlyIr1o1h/Xl7ogZCzUP2xmQGT7kHFRHh3XKoL+rSK8QsYs/HlCv1nnBOtIP6vDRcr0TqaabpsHJi5Cs71j2EbKlNj1Jlg5JojGgdESgoTo1lOrqEqIiuSk4ZlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5O2RbAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95694C4CEF1;
	Wed,  7 Jan 2026 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767796980;
	bh=ltflRgA5Bp9OA1RMBECAX5T5ojm9RyqbJA6IDlJdEgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z5O2RbAM60UylpvSc7tDRsPo8xYussO6LfeiPl5OpZFskomm9AaIltc8POGRLs6yM
	 Ir3v3RVEQmVjl/xJg+HeoIXDTAE2VB0Fx4kWJGgo+66X1/OMvuSoP75ptOA4NjVy5X
	 9+OKEwpw5tDZEvlF+yWFV7VX7Rt7wvkydofMEbIwspFV15hFbV8dVlLkZS+XYED0rS
	 HK1f3QwUryL0mX8kAtRJkAJ81IxMbFsk4S4jsgti4BlNnWvFhlUlki2jgHhRz3h6p9
	 Hw4djWqBw/VBd16DUJPAZdgRdIm3DeeYHAce9afeEWt+Nc7rUA2bfg+umLj0FeQPDm
	 8a4XJB0KgbZWw==
Message-ID: <cc3a3e80-7b2b-4652-811b-c2a126daf9c7@kernel.org>
Date: Wed, 7 Jan 2026 09:42:58 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] NFSD: Add asynchronous write throttling support
To: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251219141105.1247093-1-cel@kernel.org>
 <20251219141105.1247093-3-cel@kernel.org> <20260107080057.GB19005@lst.de>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20260107080057.GB19005@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 3:00 AM, Christoph Hellwig wrote:
> On Fri, Dec 19, 2025 at 09:11:05AM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> When memory pressure occurs during buffered writes, the traditional
>> approach is for balance_dirty_pages() to put the writing thread to
>> sleep until dirty pages are flushed. For NFSD, this means server
>> threads block waiting for I/O, reducing overall server throughput.
>>
>> Add support for asynchronous write throttling using the BDP_ASYNC
>> flag to balance_dirty_pages_ratelimited_flags(). When enabled via:
>>
>>   /sys/kernel/debug/nfsd/write_async_throttle
> 
> Let me reiterate that I really, really hate all this magic debugs-fs
> enabled features.  Either they are gnuinely useful (think this would
> be such a thing) and they should be enabled unconditionally, or they
> are tradeoffs and should have a proper tunable not hidden in debugfs.

The use of debugfs here is because we don't yet have a coherent design
in mind -- this new facility is entirely experimental, and we need a
way to enable and disable it to make good comparisons, without making
immutable changes to the actual NFSD administrative interface.

"The RFC sign out front should have told ya."

But I agree, in the long term I most prefer no new administrative
controls -- it should just work if at all possible.


>> NFSD checks memory pressure before attempting buffered writes. If
>> balance_dirty_pages_ratelimited_flags() returns -EAGAIN (indicating
>> memory exhaustion), NFSD returns NFS4ERR_DELAY (or NFSERR_JUKEBOX for
>> NFSv3) to the client instead of blocking.
>>
>> This allows clients to back off and retry rather than having server
>> threads tied up waiting for writeback. The setting defaults to 0
>> (synchronous throttling) and can be combined with write_throttle for
>> layered throttling strategies.
>>
>> Note: NFSv2 does not support NFSERR_JUKEBOX, so async throttling is
>> automatically disabled for NFSv2 requests regardless of the setting.
> 
> This all seems very useful to me.  But it really needs to show numbers
> on how it helps.

Well if I can get this into operational shape, perhaps J. Flynn would
be interested in trying it out for us.

I'm happy to run with this one and drop (or postpone) 1/2, if that is
your assessment.


>> + * Contents:
>> + *   %0: Synchronous throttling (default) - writes sleep in balance_dirty_pages()
> 
> Overly lone line.
> 


-- 
Chuck Lever

