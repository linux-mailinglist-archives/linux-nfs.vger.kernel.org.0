Return-Path: <linux-nfs+bounces-16200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003DC4195D
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 21:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E531888FF1
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286D285CBA;
	Fri,  7 Nov 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk7J+8mn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230718E1F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547292; cv=none; b=H209IVYgfiNu4d0V2FetIXHcFDc3dTqKJPwEY4wgerZ/FyEzrVvfadralxftUpyyXxZbYVLZUR3p0CWCOlQX192bn7FpBJ2NQt6ERfWlrAsk9e/V7bFCM22d0GeJkjM053fC/sF1Sw5HkAssHa05ZqS84sNToTJ4LUBXHLbH1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547292; c=relaxed/simple;
	bh=1rLasTuLMk+ih7JqrkKljhDrYQaSWK2G5I4Lnr7iDcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4vh8us+kWBKO6/DFLW7KU24aDXKbJPjtABaUdUlSqKyXYi68BxtukYjXbA9DAEh4S4mYmZaY47Hfz6rKVlNQhgu0JzyVrR0AgU400pUh2M+jc+50E14/td1e4bGeK7i0y5npHJViNXCZan0JAL2nGYIBYwjLHlRugf3CRsQmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk7J+8mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949D7C2BCAF;
	Fri,  7 Nov 2025 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762547288;
	bh=1rLasTuLMk+ih7JqrkKljhDrYQaSWK2G5I4Lnr7iDcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kk7J+8mnVIgovczCINXyXImsPQnvx5TZX0fmTBLSWxwSJ9DEuJNAraWTvvs9m1KEK
	 pQIHeCvP5C06PE3AiTVuDd/gnesu+AiPSvNTZkfggunVHfzeE60TgjPNbjyzb063dV
	 XfYxsf1LIKhLwE8OMl+6xcTu+sAwdCusrEm1pErimki2PRtP+ZPfyGP9YFSLDzaT/2
	 EecS1y18OMZ6F7hs1U4hVU8H5fk7bdnYOjEIeybz+cByWkYg7GJ4VlJtrrFIR2pmV6
	 iHdG5KT1+FbVycAASHwpfCYorJwA0CPRihIls7DGHyRlW0isApb5rkte4AwupF0MHT
	 TSEeO17d+7gdg==
Message-ID: <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>
Date: Fri, 7 Nov 2025 15:28:06 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org> <aQ4Sr5M9dk2jGS0D@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQ4Sr5M9dk2jGS0D@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 10:39 AM, Christoph Hellwig wrote:
> On Fri, Nov 07, 2025 at 10:34:21AM -0500, Chuck Lever wrote:
>> +no_dio:
>> +	/*
>> +	 * No DIO alignment possible - pack into single non-DIO segment.
>> +	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
>> +	 */
>> +	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total, 0,
>> +				total, iocb);
> 
> I'd like to sort out the discussion on why to set IOCB_DONTCACHE when
> nothing is aligned, but not for the non-aligned parts as that is
> extremely counter-intuitive.  From the other thread it might be because
> the test case used to justify it is very unaligned and caching partial
> pages is helpful, but if that is indeed the case the right check would
> be for writes that are file offset unaligned vs the page or max folio
> size and not about being able to do parts of it as direct I/O.
> 
> Either way a tweak to suddenly use cached buffered I/O when the mode
> asks for direct should have a comment explaining the justification
> and explain the rationale instead of rushing it in.

+1 for an explanatory comment, but I'm not getting what is "counter-
intuitive" about leaving the content of the end segments in the page
cache. The end segments are small and simply cannot be handled by direct
I/O.

I raised a similar concern about whether NFSD needs to care about highly
unaligned NFS WRITE requests performing well. I'm not convinced that a
performance argument is an appropriate rationale for not using
DONTCACHE on the ends.

Upshot is I'm on the fence here; I can see both sides of this
controversy.


-- 
Chuck Lever

