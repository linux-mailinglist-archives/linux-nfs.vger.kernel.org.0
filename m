Return-Path: <linux-nfs+bounces-15626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE3C085B3
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Oct 2025 01:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59843A6525
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 23:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F15242D93;
	Fri, 24 Oct 2025 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjsPlVyU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BFA1F1932
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761350222; cv=none; b=tcToykeYnuyIrTtw5PrimwlvE0PKZybBOIQfo6TdKAuTgm64ANgI/gYmqjlnwu8Jmd2FCpnu5uq/c6+X9+5pT1ZIDi+kw1RvrJsKMXx426OeQHvY0vZu+V54Czu21+7olmVm+lAFO8ELGiTzf+IOVV1ZY1B+t+ukhtPkCyeWzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761350222; c=relaxed/simple;
	bh=kTW5sy5rxR6ryFQzuecDnC0gwxKba2GMBaLDP/bvHQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GINe4vFLLrkO6V8g5Ise2t9qkziDHJ7vkAhIVdvX7Zt8LDlzHbPeT9Ypg2WkxaQrsx6AF+sCymgN1XV9mDVObHFZ/Gz2Vrj/fu9pPdMgxlXcZYk4mL+8yAia82Ur+rzzcmAtFkNisQhTJS1PS2TyzscZ450xMdZN3rycWbbpdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjsPlVyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1CAC4CEF1;
	Fri, 24 Oct 2025 23:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761350221;
	bh=kTW5sy5rxR6ryFQzuecDnC0gwxKba2GMBaLDP/bvHQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjsPlVyUXuPeP18a0IZ8eLJ7FmbOKjSuymH8kzgP7l1MwwztnmVKX3NA3O7mX056+
	 MmrxCtFYyhoVSsfpAGfMBjAx78UamYdioIVV0v8yu23qaUoCknu7i4ed4Y52z0sPcb
	 WdhXz9ibzZEHectyvKQJH52P8L+ffD7oSgNDxbK2D3O40FG5woYiYQn6nhquZZdGR+
	 0N6lMTrW9hDEf8k26+oHJ0qLEx1VQk16PujYmLVS27blLWx9SoQy4dmZHzhM5NauRp
	 p99q41D2+l7kOG538DBaXlyxfysDXN1R3KyatdimAqE2Wlm8OdRDHyCbd2fkZasTkM
	 3WSzfrA04q9Sg==
Date: Fri, 24 Oct 2025 19:56:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aPwSS9NlfqPFqfn2@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>

On Fri, Oct 24, 2025 at 05:16:52PM -0400, Chuck Lever wrote:
> On 10/24/25 4:37 PM, Mike Snitzer wrote:
> > On Fri, Oct 24, 2025 at 03:34:00PM -0400, Chuck Lever wrote:
> >> On 10/24/25 2:13 PM, Mike Snitzer wrote:
> >>>>  	/*
> >>>> -	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should persist
> >>>> -	 * both written data and dirty time stamps.
> >>>> -	 *
> >>>> -	 * When falling back to buffered I/O or handling the unaligned
> >>>> -	 * first and last segments, the data and time stamps must be
> >>>> -	 * durable before nfsd_vfs_write() returns to its caller, matching
> >>>> -	 * the behavior of direct I/O.
> >>>> +	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should
> >>>> +	 * persist both written data and dirty time stamps.
> >>>>  	 */
> >>>> -	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
> >>>> +	args.flags_direct = kiocb->ki_flags | IOCB_SYNC | IOCB_DIRECT;
> >>> AFAIK we still need: IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC
> >>>
> >>> IOCB_DIRECT | IOCB_DSYNC was recently put under a microscope relative
> >>> to XFS performance and the resulting improvement was merged for 6.18
> >>> with commit c91d38b57f ("xfs: rework datasync tracking and execution")
> >>
> >> This looks like an xfs-specific fix. I'm reluctant to apply a fix for
> >> a specific file system implementation in what's supposed to be generic
> >> code.
> >>
> >> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
> >> systems, then it needs an explanatory code comment, which I'm not yet
> >> qualified to write. I don't see any textual material in previous
> >> incarnations of this code that might help get me started.
> > 
> > The XFS specific performance improvement isn't the point.  The point
> > is that applications (like I think DB2 is what started all this with
> > Jan Kara and the XFS filesystem) results in the use of
> > O_DIRECT+O_DSYNC.
> > 
> > It is a clear reality that other filesystems are catering to
> > O_DIRECT+O_DSYNC. And given our findings with Christoph that buffered
> > IO needs O_DSYNC+O_SYNC, I'd rather we not expose ourselves to not
> > having O_DSYNC set.
> > 
> > Particularly because any filesystem NFSD is writing to _can_ also
> > fallback to using buffered IO if O_DIRECT set (NFSD is doing exactly
> > that). Which we _know_ (from Christoph) that having O_DSYNC set is
> > important when we fallback to using buffered IO (like we do for the
> > misaligned head and/or tail).
> > 
> > Please let's not make the same mistake twice.
> 
> To be clear, I'm not refusing to add IOCB_DSYNC with IOCB_DIRECT, I'm
> just confused about why it is necessary.
> 
> Direct and buffered I/O in the direct write path now each have their own
> set of ki_flags. The ki_flags used for buffered writes has SYNC and
> DSYNC set. So, for fallback I/O and for the unaligned segments of the
> buffer, both flags are set. I think we are in agreement on that.
> 
> You might be referring above to this email from Christoph:
> 
> > > I think IOCB_SYNC would be needed with O_DIRECT to force timestamp
> > > updates. Otherwise, IOCB_SYNC is relevant only when the function is
> > > forced to fall back to some form of write through the page cache.
> >
> > Well, IOCB_SYNC is only needed to commit timestamps.  O_DSYNC is
> > always required if you want to commit to stable storage.  As said
> > above I don't really understand from the patch why we want to do
> > that, but IFF we want to do that, we need IOCB_DSYNC bother for
> > direct and buffered I/O.
> 
> He says "we need IOCB_DSYNC both... for direct and buffered I/O". Fair
> enough, but why does IOCB_DIRECT, which is essentially a synchronous
> write already, need to explicitly set IOCB_DSYNC? All I want is
> something I can distill into a code comment. "Force a FUA after each
> direct write" or something like that.

Christoph said here:
https://lore.kernel.org/linux-nfs/aPnChLocfNsu_UN7@infradead.org/

"Well, IOCB_SYNC is only needed to commit timestamps.  O_DSYNC is
always required if you want to commit to stable storage."

^ This should be all you need to say?

Why/how that is also the semantics of O_DIRECT is lost on me at the
moment...

Though this message from Christoph gets into why/how things got less
than ideal due to Linux's historic handling of these flags:
https://lore.kernel.org/linux-nfs/aPnBIGeFjrZLbxBG@infradead.org/

Christoph admits "this is all a bit odd".

> I'm really surprised that IOCB_DIRECT does not imply IOCB_DSYNC, and
> there doesn't seem to be any clear documentation about the semantics
> of these flags. Thus I believe a code comment here is warranted.

I'm with you, it is all "clear as mud" and unintuitive for me too.
But I'm just playing the cards dealt.

Really, even ignoring all the quirkiness of this: that O_DIRECT can
fallback to buffered, and we need IOCB_DSYNC|IOCB_SYNC for our use of
buffered IO when NFSD_IO_DIRECT configured to ensure data has hit
stable storage -- that's enough justification.  Bit circular but
compelling to prove the need.. albeit wordy and a lot to unpack.

Mike

