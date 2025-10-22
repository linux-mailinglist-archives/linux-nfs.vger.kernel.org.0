Return-Path: <linux-nfs+bounces-15528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9EDBFDBEB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468741883830
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5B2E0B68;
	Wed, 22 Oct 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfMURhh2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F372E62A2
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155945; cv=none; b=i4CvfBD8ZfroG5KfkDB5AeEDP8giyd8OdkvR6h76o9nZbYFdN/J4D5Y9gAhVm0f+5Q/cOT71AuSUm+ecfSMuob8wbtViTpyymkG3j+spckx+AKOUcpOU9V7ce5dXzP0KdUIuo+h5DNj/rF1FAv7YiBoEXTvSiilZMBjSt4OZ/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155945; c=relaxed/simple;
	bh=RzM4p5V9h6M/zSWdyIgJjnFU+L96i+GfUUGPVM9+1uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJo7td+wIEqgXD2VNZdYwVwTArTALeJFzgFKXPjawbj0AVH9ynBM2LdnNjDj94I3MBkYUi3Tu6SybFXsGEuaK7BIsiZywpTiSbSX6jPwyhV95OVnlJcLfsKcJXZp9snywM4MKWzFn6XEH/SRwHOPY8tc+3gVaOAHc8W4qKrvwHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfMURhh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FDDC4CEE7;
	Wed, 22 Oct 2025 17:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155945;
	bh=RzM4p5V9h6M/zSWdyIgJjnFU+L96i+GfUUGPVM9+1uA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FfMURhh23AbktQSzlpUdhnuEB1UlkpPN+/grCo5ECqp52uKsiYYzE8yO4GCJM+F0o
	 Ynwvjfh5ykbJvmtXEv3fihvBAVEFaPvB3+zRRpZwfmN8KFXfsrXwA0A9GSJKT3/MxT
	 dZYBrniEf56GNwVNWfW+fxXN2+jEsB4iVi0h1yy2u/oUglLzpUXkbHwbBicnfJsCGn
	 PPli9K5uPtaDIYZdWxHfzSU6yLl3t0Vbo3sEWp2n+hyTZUbMB8TuMm4pODJBHacgHT
	 6xdVk9fKB++f08UfidaouzKVKRvOQlLPrrFvFVZ814K4E4qnLhuxHZJaNUe44js7fT
	 UNHCdqh8XiP8A==
Message-ID: <3728820c-d0a5-46d7-b886-3343606cb776@kernel.org>
Date: Wed, 22 Oct 2025 13:59:04 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org> <aPXihwGTiA7bqTsN@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPXihwGTiA7bqTsN@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 3:19 AM, Christoph Hellwig wrote:
>> +	/*
>> +	 * Any buffered IO issued here will be misaligned, use
>> +	 * sync IO to ensure it has completed before returning.
>> +	 * Also update @stable_how to avoid need for COMMIT.
>> +	 */
>> +	kiocb->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> What do you mean with completed before returning?  I guess you
> mean writeback actually happening, right?  Why do you need that,
> why do you also force it for the direct I/O?

This is the only comment where I'm not clear on what corrective
action to take.

I think IOCB_SYNC would be needed with O_DIRECT to force timestamp
updates. Otherwise, IOCB_SYNC is relevant only when the function is
forced to fall back to some form of write through the page cache.

Is that correct?


-- 
Chuck Lever

