Return-Path: <linux-nfs+bounces-15622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6005FC07EBC
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 21:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EC4400858
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1392BE622;
	Fri, 24 Oct 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUD1oQl1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646522BE621
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334444; cv=none; b=W/S/T3wkcrJAhLAwR5JyRtx+oOEtloFEC8cij6KBDe98HO1OUB4efxZ/GRWpxukS3AjhTAbiK6cIoOU3kt71Ee/+eL5u0NyNDtF0Nc48MB3Gr22+s9yzcD1Z9oDTpWZ0KndSLCEXR0sRXUFKlXSUYgTlHB1CBugE9/6KWAOGncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334444; c=relaxed/simple;
	bh=oAUyReURXZE+qO+32PFP0LkU2jior0aAGHXSI0PKFwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eivTBxS3nF9ZfDxBlW51FAx6ON7Xp43FMxdxxWu697PGo8xlRE7+DgpOu13BnbKL9qVBx3wk1s+DwvI8XwoI1UWK/jm4h75aBlwXomNtooRLbpCUK/fDO3Hg5IEa+8do2O5brjIvHEkf8qduwqdke3O3lA1v4XmleR14tS7T4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUD1oQl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CC2C4CEF1;
	Fri, 24 Oct 2025 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761334442;
	bh=oAUyReURXZE+qO+32PFP0LkU2jior0aAGHXSI0PKFwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aUD1oQl14ibrkybj7KEyaXscxtDwMOMnbFD0cse8+DmmSoWE5aopYb+DVZvbbbM5+
	 KZLOKObwdstR8OaYDf7m1Cj3L0q6Tm2izNE+I+C3FAxDsZbhhsYc3YrLjdALgYKzoH
	 BXs/tn3oZUk/b6fSkyhmHeWN4j12XjDFHACIa/iail8lGAz0vrWdPxD546pY7vuuJE
	 qQ3RmgeWeCKq97JtQcViWInxTnkgUtYi2Lpma0BhRJFtv6/Y3KQMP0m3QNIgv/4HD4
	 sY9hoiMZUCx8HfVT9+I0p4fvFuQe10d351n/treEqxyXTPqGslDzAbAvCnGNsWe9Tk
	 Y1hJ94qSXynAA==
Message-ID: <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
Date: Fri, 24 Oct 2025 15:34:00 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org> <aPvBtWOIe9hJBrKC@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPvBtWOIe9hJBrKC@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 2:13 PM, Mike Snitzer wrote:
>>  	/*
>> -	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should persist
>> -	 * both written data and dirty time stamps.
>> -	 *
>> -	 * When falling back to buffered I/O or handling the unaligned
>> -	 * first and last segments, the data and time stamps must be
>> -	 * durable before nfsd_vfs_write() returns to its caller, matching
>> -	 * the behavior of direct I/O.
>> +	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should
>> +	 * persist both written data and dirty time stamps.
>>  	 */
>> -	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
>> +	args.flags_direct = kiocb->ki_flags | IOCB_SYNC | IOCB_DIRECT;
> AFAIK we still need: IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC
> 
> IOCB_DIRECT | IOCB_DSYNC was recently put under a microscope relative
> to XFS performance and the resulting improvement was merged for 6.18
> with commit c91d38b57f ("xfs: rework datasync tracking and execution")

This looks like an xfs-specific fix. I'm reluctant to apply a fix for
a specific file system implementation in what's supposed to be generic
code.

If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
systems, then it needs an explanatory code comment, which I'm not yet
qualified to write. I don't see any textual material in previous
incarnations of this code that might help get me started.


-- 
Chuck Lever

