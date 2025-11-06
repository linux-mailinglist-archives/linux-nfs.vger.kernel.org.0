Return-Path: <linux-nfs+bounces-16132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30495C3BE05
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 15:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA029504354
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189AE34575F;
	Thu,  6 Nov 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9gSgrPP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DC34572E
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440341; cv=none; b=JlSjnzREg6n+zfjXy86s3cKQhDy7ug25U0fnpPrQwT01H40j/WQysjuwIh+os+Bb278tiFNN3BqLyNfNVtowrY5hrbhEAqXssSol+OPDEQWjFQp5q64bZGVVouFTsGmKp3dIad5vI0Z+wYpJeVOLLCVzo4M9oPQfhAEnLiKPck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440341; c=relaxed/simple;
	bh=Ue+JFIZEW0MWnrC4yU8kWJzfO10DM56MUlKrDzNxwcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/fMaQ5AaQCD/z4kIFw5Em/4yCfxe9ojRUH21cNJTO3Y1XbIKzv4QsP0gP/cVmUci5Z1asZend042QvpphXc3cx1wjMsvdkM438B80ncDmjHfeH1BawtHKUu5XVPaGz8ucYQ3SToEeDIRtjwfEjEDLUO5t4wUD/vUa90ldETPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9gSgrPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8E4C116C6;
	Thu,  6 Nov 2025 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762440341;
	bh=Ue+JFIZEW0MWnrC4yU8kWJzfO10DM56MUlKrDzNxwcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g9gSgrPPR5zbTe2VmCe1gBJT0s9RgxSwSK+pFfs0X2josAyrwIo1s2G6vm5Awb2w+
	 OWhloEfcGasjWEChhCUQzU1Gyoz4lSvMQJS2wFDAzNe569PK/g4P532McAYhakY61R
	 9g9mTy2O7C+AQKnbYQYn7MaPFd/s7yMcg4B6OhF5mHr3ttPVNSxLvqzPipyzLulxH8
	 RM/cIU/uW2ioA5LM0+XYsrFc0gHS3aYw4XBGMV0f9+IFULjftzoHS12xyG9NOQ833f
	 k69aNV+L8e2XdhYENiEiU0gAPfVMurNyaSI0Q0/MU4MTZEa79v4XaKaV5H+47QUhJ5
	 Ud8V3BfemHHCw==
Message-ID: <fd7e5de7-bad7-4f0b-83f8-7e1d7d27cffd@kernel.org>
Date: Thu, 6 Nov 2025 09:45:39 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org> <aQyn-_GSL_z3a9to@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQyn-_GSL_z3a9to@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 8:51 AM, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 05:15:45AM -0800, Christoph Hellwig wrote:
>> On Thu, Nov 06, 2025 at 09:11:51PM +1100, NeilBrown wrote:
>>>> +struct nfsd_write_dio_seg {
>>>> +	struct iov_iter			iter;
>>>> +	bool				use_dio;
>>>
>>> This is only used to choose which flags to use.
>>> I think it would be neater the have 'flags' here explicitly.
>>
>> Actually, looking at the grand unified patch now (thanks, this is so
>> much easier to review!), we can just do away with the struct entirely.
>> Just have nfsd_write_dio_iters_init return if direct I/O is possible
>> or not, and do a single vfs_iocb_iter_write on the origin kiocb/iter
>> if not.
> 
> That didn't work out too well, and indeed having flags here seems
> saner.
> 
> Chuck, below is an untested incremental patch I did while reviewing
> it.  Besides this flags thing, it adds the actual NFSD_IO_DIRECT
> definition that was missing,

It's not missing. This series applies on patches that are already in
the nfsd-testing branch, which has a patch that defines that constant.

I'm not sure my tooling enables me to specify a particular base commit
when posting a series. Maybe I can add it to the cover letter.


-- 
Chuck Lever

