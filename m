Return-Path: <linux-nfs+bounces-15722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC5DC12C22
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 04:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37371AA1AEC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 03:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C86B1C5D46;
	Tue, 28 Oct 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkYbN8D4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860838F9C
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622020; cv=none; b=X5fzwOkAUwhBy8Ae6Q4W3zeTBgOgXznXr9IAJW9f0RbwDLDMuh68DUV1X3dGP03DsWvvSI5LY6+JIaaWPa9V4I68U5OqjTN/CPdMsx83/lVrEtt5CnISPrHSBBSGsYG1NK0PnSgjfIfTYXB0vQOm5qHCBYTAMAggCSEPqZutXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622020; c=relaxed/simple;
	bh=Fok/CIMfGj0B32rjEiJPoySedyRRySPsVC3AZdxcFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1OjGcLI7Z6A2dMGton8JnVHYub+nQfGI3jVQj0CsXBu/PJoemP+IiPhitMihy/dtCUentcwxNYr6qIH5pIosUITDdzbHjNHbdFQ3zuRYxPy4FIMgkoDP8FH6OFPci3jOcJEDyD12VhAXk4U8sOkyq82hGtsatxQ31KYlZVtKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkYbN8D4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9478C4CEF1;
	Tue, 28 Oct 2025 03:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761622019;
	bh=Fok/CIMfGj0B32rjEiJPoySedyRRySPsVC3AZdxcFmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkYbN8D4zg6KnCdUPHMltwHybygGH9pwvj12DZg9JyO6iD41xlO7XxY8K+kQNzqQQ
	 7vn3+jj711tm9ptl6RXidSGykONY4JVv+4uwHDJ/GWNyo4K2/oRFPCT8VPFkFZKaVz
	 tz5aq7R8ekQq3jMdd9MC4OIAun9osgvOZ9WMUZbORszhAWdt/e6oB4ha+Ce0rDC8fX
	 Z+p3/6acepBqK2GeVyRDYBocXpbcgtLuWQWeklTBeQcAZWxxICEVsbyFGsql4FAHPZ
	 RRXYXu+zJqcG1XsDsGA7dIKJopM5t86vh3/UnHZ9ZulnVH5DTzWi908aWDRakroB1e
	 ysuPUNEKNZRag==
Date: Mon, 27 Oct 2025 23:26:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aQA4AkzjlDybKzCR@kernel.org>
References: <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a221755a-0868-477d-b978-d2c045011977@kernel.org>

[Apologies, I think I repeated myself 4 slightly different ways below]

On Mon, Oct 27, 2025 at 01:57:25PM -0400, Chuck Lever wrote:
> On 10/27/25 12:05 PM, Mike Snitzer wrote:
> >>> You also need IOCB_DSYNC for direct I/O to hit the media if you want
> >>> to return NFS_FILE_SYNC.  But I still don't understand why we want or
> >>> need to return NFS_FILE_SYNC to start with.
> >> NFS_FILE_SYNC is not required here, but it's better if we can return
> >> that. If the server returns NFS_FILE_SYNC there is no need for the
> >> client to follow up with a COMMIT.
> > Yes, which is why I'm confused by Chuck wanting to do away with
> > NFSD_IO_DIRECT setting NFS_FILE_SYNC "for now".  Not heard compelling
> > reason, but "it is what it is". 😉
> 
> The compelling reason is that it's generally faster (or less work for
> the NFS server and its storage) to sync the metadata after the client
> has sent all of the data it wants to write. This amortizes the cost of
> the metadata operations, and allows the server to get the written data
> persisted (if it makes sense to do that) while waiting for the COMMIT.

But none of that matters if the only safe way to implement mixing
buffered and direct IO is by waiting for the DIO to succeed and with
it any associated page cache invalidation (and associated possible
failure to invalidate the page handled with using buffered IO fallback
by underlying filesystem).

Any buffered or direct IO associated with the misaligned DIO WRITE
handling, in terms of 3 segments, must use IOCB_DSYNC.

So can we please revisit your desire to eliminate the use of
IOCB_DSYNC for NFSD_IO_DIRECT WRITEs?

I contend that NFSD_IO_DIRECT should use IOCB_DSYNC|IOCBD_SYNC for
all 3 segments of a misaligned DIO WRITE (so for both buffered and
direct IO).

> Since your patch asserts IOCB_DSYNC for all direct write segments,
> NFSD_IO_DIRECT (as it is implemented in your patch) does not need a
> subsequent COMMIT operation. Forcing the client to COMMIT is totally
> unnecessary. That's why I suggested promoting all NFSD_IO_DIRECT WRITEs
> to FILE_SYNC.

No, the COMMIT can only be elided (and NFS_FILE_SYNC return to client)
if both IOCB_DSYNC and IOCB_SYNC are set.

But yes, at Bakeathon, the intent/understanding was: if you're already
setting SYNC then you can avoid the COMMIT -- this nuance of DSYNC vs
SYNC wasn't on our radar at the time.

> So perhaps the issue here is that the rationale for using IOCB_DSYNC
> for all NFSD_IO_DIRECT writes is hazy and needs to be clarified.

How is it still hazy?  We've had repeat discussion about the need for
IOCB_DSYNC (and IOCB_SYNC if we really want to honor intent of
NFS_FILE_SYNC).

Christoph has repeatedly said DSYNC is needed with O_DIRECT, yet you
keep removing it.

> > Were we not all concerned about safety first (especially of mixing
> > buffered and DIO) and performance a secondary concern?  Using
> > IOCB_DSYNC|IOCB_SYNC for all WRITEs and returning NFS_FILE_SYNC is
> > really safe right?
> 
> The client ensures that UNSTABLE + COMMIT is just as "safe" as
> FILE_SYNC, generally, by preserving the dirty data in its own page cache
> until the server indicates the written data is durable and is safe to
> evict if needed.

I'm aware UNSTABLE is safe thanks to COMMIT, etc.

But the entire intent behind NFSD's O_DIRECT support is to ensure IO
is on stable storage when it replies to the client.  The client isn't
meant to get involved with driving the correctness of NFSD's O_DIRECT
support (by requiring the client set NFS_FILE_SYNC for the benefit of
a feature it doesn't know enabled in the server).

That cannot be what you're saying, NFSD_IO_DIRECT is entirely managed
by the server as a configurable implementation detail.  So we need to
make sure it is implemented safely without the client being involved.

> If you want to make an argument about data integrity, let's
> be as precise as we can about what we believe might be unsafe. The
> data integrity doubt was with the unaligned ends, IIRC? If we need
> that extra bit of integrity, then WRITEs with an unaligned portion
> will need to be IOCB_DSYNC, and then promoted.

The repeat _valid_ concern from Jeff and you was about the need to
ensure data integrity in the NFSD_IO_DIRECT's misaligned WRITE support
(mixes both buffered IO and direct IO for a single misaligned WRITE).

But now you no longer have that concern and have removed the
IOCB_DSYNC flag which is required for _both_ buffered and direct IO.

(IOCB_SYNC is only required if we'd like to return NFS_FILE_SYNC to
the client, maybe you meant to leave IOCB_DSYNC but remove IOCB_SYNC?
Oh man do I really hope so... ;) If so, please trim from here down)

> An NFS WRITE, even an UNSTABLE one, I believe makes the written data
> visible to other readers. That might be an argument for using IOCB_DSYNC
> with IOCB_DIRECT, so that subsequent NFS READs (and local applications)
> see the written data as soon as NFSD generates a response to an NFS
> WRITE backed by IOCB_DIRECT.

I'm confused, how is using IOCB_DSYNC with IOCB_DIRECT up for question
again?  It is needed for misaligned DIO WRITE (splitting into 3
segments, mixing buffered and direct IO).

From the start, NFSD_IO_DIRECT's WRITE support has been about ensuring
cache coherence on a per WRITE basis (once its acknowledged back to
the client). I have tried to be careful to do that even when handling
misaligned DIO WRITEs.

> I think we also discussed that an NFS WRITE should make updates visible
> in byte order, which is why the segments are handled low offset to high
> offset.

Trond mentioned it as needed relative to ensuring consistent file
offset.  I mentioned that is the case, and with NFSD we get that
simply by issuing the IO in series, in file offset order -- but for
NFS client's LOCALIO I _do_ issue out-of-order segment IOs (head/tail
buffered and then DIO aligned middle, but with care to preserve file
offset integrity even with partial writes of any of the 3 segments).

Maybe its fine to have a mode where NFSD allows O_DIRECT to be used
without setting DSYNC when using UNSTABLE, _but_ it really shouldn't
be the default.

> Or, we might decide that, no, NFS WRITE has no data visibility mandate;
> applications achieve data visibility explicitly using COMMIT and file
> locking, so none of this matters.

We don't have that freedom if we cannot preserve file offset integrity
(as would be the case if we removed IOCB_DSYNC when handling all 3
segments of a misaligned DIO WRITE).  Removing IOCB_DSYNC would
compromise misaligned DIO WRITE as implemented.

> > And we already showed that doing so really isn't slow.
> 
> Well we don't have a comparison with "IOCB_DIRECT without IOCB_DSYNC".
> That might be faster than what you tested? Plus I think your test was
> on esoteric enterprise NVMe devices, not on the significantly more
> commonly deployed SSD devices.

IOCB_DIRECT without IOCB_DSYNC isn't an option because we must ensure
the data is ondisk.

The only related bake-off would be:
1) IOCB_DIRECT | IOCB_DSYNC with UNSTABLE 
 vs
2) IOCB_DIRECT | IOCB_DSYNC | IOCBD_SYNC with NFS_FILE_SYNC

(but on esoteric enterprise storage: there is no difference)

This thread and evolution of the threads before it is jarring:

Just recently we were surprised to find IOCB_DIRECT needs IOCB_DSYNC
to ensure data is ondisk; that you (and I too) thought O_DIRECT would
imply that -- I raised concern given what I saw in the XFS performance
improvement patch that was focused on combining O_DIRECT and O_DSYNC.
Because I couldn't see how to avoid setting DSYNC, and we've since
learned DSYNC needed _to ensure data is ondisk_.

So I'm left confused... and I'm feeling sick and would like to get off
this merry-go-round now ;)

Thanks,
Mike

