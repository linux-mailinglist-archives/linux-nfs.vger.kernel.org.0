Return-Path: <linux-nfs+bounces-16179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35909C4093F
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01B864E2593
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515EC2DF143;
	Fri,  7 Nov 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceV8qkL6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD532D94A1
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529216; cv=none; b=VO4qYKsxV+4oARFB1CuaEKmJP5Nxlzm3n6AXwOqYrq7VVOLhwCdJqjnMenVWwCUu6vUxKP08drBKC2DREoMHqtYeVu58tY69IWBL3IdK/MvgErbqU73iap+usWrf3VPfHzpUxhPXYrnCBUDqL8k+tc4ogoDrHsudiwEynp1Z8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529216; c=relaxed/simple;
	bh=RINEgM1G9tEhRThvr9S/6QMuGzkULoSRYMeMDElL+14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZcvLAvP4izdjt1egcZtDmxHemaZsQ+W9OGSVLL0dEurIMdvBWzNrRU3VpadwvMDojCv5P6lE/KMRCaUM3qMwNy8Bcw+0ymx+w67UznbltUaq+l4l9Ym12ptXs4gXEPO6j5n05FegmO6frOh7Y5QTI5K7x9mOwG4/IrU2sNkTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceV8qkL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF9BC19421;
	Fri,  7 Nov 2025 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762529215;
	bh=RINEgM1G9tEhRThvr9S/6QMuGzkULoSRYMeMDElL+14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ceV8qkL6EV94LqOJmmCZCIJrjiMeR7m/cv1WX0ZcQtqjnQfYrdvek2PlVVKGpNPYr
	 wrWYA5lvyypQHrYFNaI8NgUmcY+9y07XmGrNvXk2WCfE2brbLhtEP2gy6L+pVs7RVl
	 G+hO3l5WPcfGH0PyuACpDW+bm1TarRs4tTd7lffyMy74Bd9lsFhr/vaLQb+H+A+qAx
	 Bi0ZA/6trhcfqrof4Z29K21zPOGDPnk52KReISB1WBaru9gCdoQNC9NAPPcwgPoSuX
	 E1rvegorBaXvG982Xxewl4wC6hoR4YeghgG1bKpAeqFAgbwSKqC1OCXBzbY4E6Gvag
	 yTnqVYRJAuVHA==
Message-ID: <a3eb79b8-f301-45a6-a3de-ea251cc6a72b@kernel.org>
Date: Fri, 7 Nov 2025 10:26:53 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org> <aQyn-_GSL_z3a9to@infradead.org>
 <aQzRdTcyc2nhTWqj@kernel.org>
 <e0723227-6984-4c04-be7c-c3be852a8607@kernel.org>
 <aQzwvqlD0xiYjMCW@kernel.org> <aQ3zFRizxIa-Hk6F@infradead.org>
 <60402263-4336-42e0-acfc-7f1cab6c1742@kernel.org>
 <aQ4PIT0ixuSkvk6X@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQ4PIT0ixuSkvk6X@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 10:24 AM, Christoph Hellwig wrote:
> On Fri, Nov 07, 2025 at 09:38:43AM -0500, Chuck Lever wrote:
>> On 11/7/25 8:24 AM, Christoph Hellwig wrote:
>>> On Thu, Nov 06, 2025 at 02:02:22PM -0500, Mike Snitzer wrote:
>>>>>> Selectively pushing the flag twiddling out to nfsd_direct_write()
>>>>>> ignores that we don't want to use DONTCACHE for the unaligned
>>>>>> prefix/suffix. Chuck and I discussed this a fair bit 1-2 days ago.
>>>
>>> Please document why.  Because honestly it makes zero sense to do that.
>>
>> There is a slow-down. But it's not like using DONTCACHE on the unaligned
>> ends results in a regression, technically, since this is a brand new
>> feature.
>>
>> So for an UNSTABLE unaligned WRITE in NFSD_IO_DIRECT mode, the unaligned
>> ends would go through the page cache, and would not be durable until
>> the subsequent COMMIT. Using DONTCACHE for the end segments adds a
>> penalty, and no durability; but what is the value we get for that?
> 
> Less cache pollution, and especially less conflicts with other direct
> I/O writes.  Do you have a link to results with the slowdown?  How much
> is it?
> 

https://lore.kernel.org/linux-nfs/aQrsWnHK1ny3Md9g@kernel.org/

-- 
Chuck Lever

