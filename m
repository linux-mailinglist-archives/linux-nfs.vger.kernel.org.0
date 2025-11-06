Return-Path: <linux-nfs+bounces-16151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54CC3D068
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A8F53519A2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1B34EF19;
	Thu,  6 Nov 2025 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXrAeQxH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667734D4CD
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452619; cv=none; b=tJi1LunrsPJCAIuKbPtwopiOQP7xXmHaoOxGoI7qurb9RSBkPvjQUhSousDmzx6rDy89jJuFen0yTe3KLQXwR2qNpwsFFHsQHDDMNn3B1kOXoYBBKFdwn/0VspnKwb8tL9vLMGaOQ8cWs29nJV7iPNytUiaeyOtvhWPti0mfmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452619; c=relaxed/simple;
	bh=w6lR1TaPz0J/59sgIfHyKXBwx593xUWc6IkJ+Mw7Sv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwKWALq3RFGS/e79X/VyU0NshfEXLImFEup+LXiyan28JEKW/LWRo59l/H255VGyBjD4+yPYZl3g6gZK2osHn3JBGYtFFi8aI1Kr5uO9PYjcpkCPfBUxTP90Q7c/qzSgG5BuXjmg98uLCUskPxig55r7KwUmXE/RZuiPz79lZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXrAeQxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F8CC116B1;
	Thu,  6 Nov 2025 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762452619;
	bh=w6lR1TaPz0J/59sgIfHyKXBwx593xUWc6IkJ+Mw7Sv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AXrAeQxHfk8TlhgR30WSITp3Y/bSKYQuD03mDRTe0TpuOtHfRP3qSqQlMhigj4DfA
	 xGq3RimA8IGs9QUq3kfCv+oC71WjJ17f9i8T+92kXPSz1HQV6mB6Kq2DyVPFBDZAYh
	 HYaF3ybCyrmPR67LNFDAfM3htcxFvfa4ZE25zScHH8igO2SyUk1/viHeQWIEffD7fx
	 Po+NHbDOApdDc8TseoObDGq+cWNcFUbpJ0U2YMmLn5+K/IzegSVe9S67CY/ywgmL4x
	 1KCRn+QQZT6qIAxgKl+dbRsgrth+tWs81Sd+B3Omgs22HomqtHkuw6WsXsOBwwjTjW
	 sNaXeCzz0HLeA==
Message-ID: <e0723227-6984-4c04-be7c-c3be852a8607@kernel.org>
Date: Thu, 6 Nov 2025 13:10:17 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org> <aQyn-_GSL_z3a9to@infradead.org>
 <aQzRdTcyc2nhTWqj@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQzRdTcyc2nhTWqj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 11:48 AM, Mike Snitzer wrote:
>>  no_dio:
>>  	/*
>>  	 * No DIO alignment possible - pack into single non-DIO segment.
>> -	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
>>  	 */
>> -	if (args->nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
>> -		args->flags_buffered |= IOCB_DONTCACHE;
>> -	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
>> -				0, total);
>> -	args->nsegs = 1;
>> +	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total,
>> +				0, total, iocb);
>> +	return 1;
>>  }
> Selectively pushing the flag twiddling out to nfsd_direct_write()
> ignores that we don't want to use DONTCACHE for the unaligned
> prefix/suffix. Chuck and I discussed this a fair bit 1-2 days ago.

Agreed. I fixed this up after applying Christoph's patch.

-- 
Chuck Lever

