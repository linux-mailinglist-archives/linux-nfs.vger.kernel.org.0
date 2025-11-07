Return-Path: <linux-nfs+bounces-16193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D6C40A2F
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B401889B4C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EAE2E3B07;
	Fri,  7 Nov 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU49ubVU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AC2D373F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530058; cv=none; b=hkSl0x9vr0sWh5FPUPYvGQZm4o41ndN7CNxa6dxMv58kN2WDp5W572EfmHwIZdE4nHrqX9MzRwslEjFaMaW+ZPtT1cJ6mBKbwz3bU2ksQF6Dq8saXLV5WUEAU2cgym1gnrCcRPtmkpeOw0ygc4OURvP1Wqme47OfqahpRwKQfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530058; c=relaxed/simple;
	bh=FTZb/b7RDjYO5YsKH764vVRjG7g3sa7YJSBg95hiesk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8Hnn1VU1May+m0whEBSOVs9zoZ7XW6tmck2faTqbqWtUUBMROKx/n3aNYUWRQqz++rH/No8mosnFTMK1+Eh/ZwzgU/MgVslzg1rihy9Aash9k0pFLIuSC/3er5EBt6kE7xCXxSNiQvoendb5q9BBdv8y2+zG5BDo2vFSPcSUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU49ubVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD35C4CEF5;
	Fri,  7 Nov 2025 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762530057;
	bh=FTZb/b7RDjYO5YsKH764vVRjG7g3sa7YJSBg95hiesk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CU49ubVUbAG8m62vzFZq6ic1PbRBYJVjtt2WJQbmOfmM6msRkJuUaMQdZrkpdbCSZ
	 t2zRByz/jPKmu3OWtYJAWAzi6O4QvLRVsD0JdPlb7lwsuu7w9daI60SrluGjv8uFDQ
	 LFx3+Xkrit5lKQDqBLEPeeAIlSdCxCdmvUgzziFW1NSQGM3tT34y7ModkMrykcC348
	 gn6ktmqVXrMeZ5Kg2RDM+HvSBgxcveeJKmx4QnGDqmpsqGM3AMIhqtHPsLoYt9I802
	 sYQSqKzFZ79KOahUznpKzvxad9hGZmCnai1rRCO92SqtNG2lkFHFqGXikk9LcOc2HH
	 bv+whVw+DsPxg==
Message-ID: <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
Date: Fri, 7 Nov 2025 10:40:56 -0500
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

Agreed. The cover letter noted that this is still controversial.


-- 
Chuck Lever

