Return-Path: <linux-nfs+bounces-15624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC0C082A3
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3850118892FB
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B002E2EF1;
	Fri, 24 Oct 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPaCzFBd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38C2FFF8F
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340614; cv=none; b=jYPN9KbMEaoFrMwqqyPz408u1f4IUlI1iq0sYjBIv2wR5q2aes7xjmdBE1gOuTa8dW2xscBoQBdsh4aTnBtn7c6xBXQ03TOWgDcFg75Ff335Rune41Dsq5uz7qFq66NSCPZ+9dOMyHZFjJ+aMaVEujLz9RwKTltG/ECypqADVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340614; c=relaxed/simple;
	bh=fWeP0j+4NvhyGLOn7NdgR+4f8iGsfeivB+R0agBfXWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxuUYxi+C8YNkkD9OJ+3fc/i5+tBjXQnJY4aB2BSX4B4axNjA6zwtqknYcySXRki4FHuIU+I1BTxDBufSpZ/kCIyuli4dHnG0uBj/nlBrtK5ZSnaurNeRQY88YteAPOqOU3ta9FAXGZsFkURY3RnyToG3m4su3yX7u4vFhxkN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPaCzFBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6ECC4CEF1;
	Fri, 24 Oct 2025 21:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761340613;
	bh=fWeP0j+4NvhyGLOn7NdgR+4f8iGsfeivB+R0agBfXWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DPaCzFBdv6NyE6zbg46EC1xEFQbU5xDFouj55eMlWykoQsLt1XLCvuu9tUuwWSA2w
	 0rsbYbhkN4EJKb6NuCdZ0imgKi8viQOzwGrKrafxlhoV3erYYtAvsBlO4M5HkPOVS/
	 TtcRza1Dn5DzZqnNv8w3f788m3H6r9JE9rQeAdZt2F+L/X3lyJh4Dd4o80MDxWGpd9
	 H3zuquH3l1oapnbSqpe+S1cDYO5E9skDR8oWPIBXJHgZkbfs2n9TsLuzB8St6aCGjP
	 Eu03EpTy1uSkH9Vd4bbUbfmy6tccYQv/Cs+8f478O53CjyZKiFou0zwAE5uCQuOs00
	 eA8GYpBc18NUA==
Message-ID: <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
Date: Fri, 24 Oct 2025 17:16:52 -0400
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
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPvjiwF9vcawuHzi@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 4:37 PM, Mike Snitzer wrote:
> On Fri, Oct 24, 2025 at 03:34:00PM -0400, Chuck Lever wrote:
>> On 10/24/25 2:13 PM, Mike Snitzer wrote:
>>>>  	/*
>>>> -	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should persist
>>>> -	 * both written data and dirty time stamps.
>>>> -	 *
>>>> -	 * When falling back to buffered I/O or handling the unaligned
>>>> -	 * first and last segments, the data and time stamps must be
>>>> -	 * durable before nfsd_vfs_write() returns to its caller, matching
>>>> -	 * the behavior of direct I/O.
>>>> +	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should
>>>> +	 * persist both written data and dirty time stamps.
>>>>  	 */
>>>> -	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
>>>> +	args.flags_direct = kiocb->ki_flags | IOCB_SYNC | IOCB_DIRECT;
>>> AFAIK we still need: IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC
>>>
>>> IOCB_DIRECT | IOCB_DSYNC was recently put under a microscope relative
>>> to XFS performance and the resulting improvement was merged for 6.18
>>> with commit c91d38b57f ("xfs: rework datasync tracking and execution")
>>
>> This looks like an xfs-specific fix. I'm reluctant to apply a fix for
>> a specific file system implementation in what's supposed to be generic
>> code.
>>
>> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
>> systems, then it needs an explanatory code comment, which I'm not yet
>> qualified to write. I don't see any textual material in previous
>> incarnations of this code that might help get me started.
> 
> The XFS specific performance improvement isn't the point.  The point
> is that applications (like I think DB2 is what started all this with
> Jan Kara and the XFS filesystem) results in the use of
> O_DIRECT+O_DSYNC.
> 
> It is a clear reality that other filesystems are catering to
> O_DIRECT+O_DSYNC. And given our findings with Christoph that buffered
> IO needs O_DSYNC+O_SYNC, I'd rather we not expose ourselves to not
> having O_DSYNC set.
> 
> Particularly because any filesystem NFSD is writing to _can_ also
> fallback to using buffered IO if O_DIRECT set (NFSD is doing exactly
> that). Which we _know_ (from Christoph) that having O_DSYNC set is
> important when we fallback to using buffered IO (like we do for the
> misaligned head and/or tail).
> 
> Please let's not make the same mistake twice.

To be clear, I'm not refusing to add IOCB_DSYNC with IOCB_DIRECT, I'm
just confused about why it is necessary.

Direct and buffered I/O in the direct write path now each have their own
set of ki_flags. The ki_flags used for buffered writes has SYNC and
DSYNC set. So, for fallback I/O and for the unaligned segments of the
buffer, both flags are set. I think we are in agreement on that.

You might be referring above to this email from Christoph:

> > I think IOCB_SYNC would be needed with O_DIRECT to force timestamp
> > updates. Otherwise, IOCB_SYNC is relevant only when the function is
> > forced to fall back to some form of write through the page cache.
>
> Well, IOCB_SYNC is only needed to commit timestamps.  O_DSYNC is
> always required if you want to commit to stable storage.  As said
> above I don't really understand from the patch why we want to do
> that, but IFF we want to do that, we need IOCB_DSYNC bother for
> direct and buffered I/O.

He says "we need IOCB_DSYNC both... for direct and buffered I/O". Fair
enough, but why does IOCB_DIRECT, which is essentially a synchronous
write already, need to explicitly set IOCB_DSYNC? All I want is
something I can distill into a code comment. "Force a FUA after each
direct write" or something like that.

I'm really surprised that IOCB_DIRECT does not imply IOCB_DSYNC, and
there doesn't seem to be any clear documentation about the semantics
of these flags. Thus I believe a code comment here is warranted.


-- 
Chuck Lever

