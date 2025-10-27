Return-Path: <linux-nfs+bounces-15705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C86C0F2B8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87181884108
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFD030E824;
	Mon, 27 Oct 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyShEO8Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525C30E825
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581145; cv=none; b=EqbUdZCcb3EMWO/46SW6h+lpFp/kOR3/sEqMXUo/aJv/0iWzLTcwsaVf10+LlyrEloEXt+iGp4MvPHbE+UU9eMuXM6retZi2p4BczX2bT2iFT5fVxps+LdMSHaDYdiXsRNLBzMz5y0jszLd9DHRoU7kTdIS5hGN1AL4YUXFaQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581145; c=relaxed/simple;
	bh=BYwL7sNHuRD7lVlcyvZNaQxy41DzWyU3x2bmSnq36hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oncIggd+ClsQh+9vjLd4MqhFEQiFxQZ7Wi2X5hBxl6+U2DHTZCXa7DGeZ4fEj7mrGalJvvsNnH2fnUR8ppzpD0T/h/U/inIg65PpkUx/LR7m2B2GBnSAtRIKWdmOmYQmfQNdvRWwQieDYvJMDjM6Jh/Ffpg4ip+CqQUKahl+N6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyShEO8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D38C4CEF1;
	Mon, 27 Oct 2025 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581144;
	bh=BYwL7sNHuRD7lVlcyvZNaQxy41DzWyU3x2bmSnq36hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyShEO8Y17gMdW6N1bFXeb8pNityk4916GVbmY7mcRSTrS7Gp+Ol9e8sDvxILbzlD
	 m9449CJlMt0oWDTnWcGANEtApi4+vowE3wscybnbLa9MK73LFKhX1oSdB3uUoPBpJe
	 VQqgEyq00p0LwEg5nBkaIrWveJ0vnu5fBHzMLkmhZ83ljYGjybPzsJgINIDcXRhzja
	 Jw/MKYVxQIZtNsuU0RQ2JCZSnhE1tajXlyW8lwBU7s3zHBKbmHVeiPKo8OPSVtX2GQ
	 nUvB8q5YO1I+acfZPksWNMDz04Z8n7sFK2AxKxR8VLCpIFJmUniDo9AO1YVhNuU77m
	 ddx9oY7FERKNA==
Date: Mon, 27 Oct 2025 12:05:43 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP-YV2i8Y9jsrPF9@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>

On Mon, Oct 27, 2025 at 06:50:03AM -0400, Jeff Layton wrote:
> On Mon, 2025-10-27 at 01:15 -0700, Christoph Hellwig wrote:
> > On Fri, Oct 24, 2025 at 07:56:59PM -0400, Mike Snitzer wrote:
> > > Really, even ignoring all the quirkiness of this: that O_DIRECT can
> > > fallback to buffered, and we need IOCB_DSYNC|IOCB_SYNC for our use of
> > > buffered IO when NFSD_IO_DIRECT configured to ensure data has hit
> > > stable storage -- that's enough justification.  Bit circular but
> > > compelling to prove the need.. albeit wordy and a lot to unpack.
> > 
> > You always need IOCB_DSYNC for data to hit stable storage, both for
> > buffered and direct I/O.  You need IOCB_SYNC in addition to also sync
> > out the timestamps, which I think we now agree we need.  I still don't
> > understand why using direct I/O implies that we want NFS stable writes
> > and not two-stage writes, though.
> 
> That's certainly a possibility too. Consider the case where we have a
> WRITE with unaligned parts at both ends. This set so far just does the
> ends as synchronous I/Os.
> 
> We could do the end bits as non-synchronous writes, and follow up with
> a vfs_fsync_range() call before returning NFS_FILE_SYNC.
> 
> We could also just return NFS_FILE_UNSTABLE and let the client follow
> up with a commit when the write is unaligned. That may be the most
> efficient scheme if you have a client streaming unaligned writes to the
> server without gaps.

Yes, that is how I handled streaming unaligned writes last I needed to
benchmark it (IO500's IOR_HARD benchmark uses IO size of 47008 bytes).

Use buffered IO for misaligned WRITE's head/tail.  In addition, I had
the heuristic to always used buffered IO for any READ less than 32K
(the misaligned head and tail included).  This allows to leverage page
cache for RMW needed to service the unaligned streaming WRITE.

> My feeling is that if you're doing a lot of unaligned I/Os, you're
> probably better off not enabling DIO support and just doing regular
> buffered (or DONTCACHE) I/Os.

DONTCACHE will not do well for RMW because it'll immediately drop IO
it just read.

But will be testing this further...

> That said, we don't really know either way (which is why all of this is
> behind debugfs switch instead of a more permanent interface).

Yeap.
 
> > You also need IOCB_DSYNC for direct I/O to hit the media if you want
> > to return NFS_FILE_SYNC.  But I still don't understand why we want or
> > need to return NFS_FILE_SYNC to start with.
> 
> NFS_FILE_SYNC is not required here, but it's better if we can return
> that. If the server returns NFS_FILE_SYNC there is no need for the
> client to follow up with a COMMIT.

Yes, which is why I'm confused by Chuck wanting to do away with
NFSD_IO_DIRECT setting NFS_FILE_SYNC "for now".  Not heard compelling
reason, but "it is what it is". ;)

Were we not all concerned about safety first (especially of mixing
buffered and DIO) and performance a secondary concern?  Using
IOCB_DSYNC|IOCB_SYNC for all WRITEs and returning NFS_FILE_SYNC is
really safe right?

And we already showed that doing so really isn't slow.

