Return-Path: <linux-nfs+bounces-13074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F6B058C9
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 13:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519DC1A6657D
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 11:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74D2DCF5D;
	Tue, 15 Jul 2025 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY6ScinZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89FE2DCF56
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578925; cv=none; b=QDfVwlIsNhAN21GWHzWoPHDI99NtDetAh+z9Rq1l4lewVS+cb/8hanGAY1fcTwRqdQLXBseEl9O3Y+mzNaHYAxMOtWogWVCzBgyoCvX7r37hsUkF5h4OmssC96aQhwZan9y36dNoFZVj0jzn378JSW+EdyubAwC7YmolB5Zhdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578925; c=relaxed/simple;
	bh=2pIZvCCs0rLA67/s4z9oCBFXjuaSQg/cNRqmPhQU284=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0vwWtv3Fe8tYVRLth5arqTo2uLDMt6S9c1XEJjagXUphcR6/yzSB4BLWBYDxgm5Jo2Z70Z+3iqrfm+UOmeu3piO16ecezXpcPFuj47EyrUNAOhfV+VsMld2Rvj2Zk6/7bam9ft2zaXNBVS77mA7VaafC3jV0cF3ysVUX3j4264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY6ScinZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDD0C4CEF6;
	Tue, 15 Jul 2025 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752578925;
	bh=2pIZvCCs0rLA67/s4z9oCBFXjuaSQg/cNRqmPhQU284=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EY6ScinZjZvScolsTxcJq7VISABnCo9hEFV9VqedPFKtGD7CAIF3PHNCcqVr7dtt/
	 sbypbAXez3hi/lsnwBuf24NWKfGSz+qJIHSfFZiIKKHKz4qTxRIdivbUmFGEiEZwJm
	 PRp1jjYOmx2reKH/K5HVHbH0MWmfOTxsakIqGZ6pL3AT8dNHU7jGHGcqQk1STFfPRu
	 yxxTScwEDnuAuyQAoYJAAF3G4XJPjPNvqF3aDnOt/UIEpApwPdhHB15MjBiM+ZqcvI
	 gDG8QIcgwSaBz3u+GWntCmD2/mmEOSnslx1UKffOxIrAn2WltwTgZ2McjcYEs79T32
	 vejVFGj+s0TNA==
Message-ID: <1c3196b0d57c94f29f7a29402ae6e66ae44c9d02.camel@kernel.org>
Subject: Re: [PATCH v3 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO
 modes
From: Jeff Layton <jlayton@kernel.org>
To: Daire Byrne <daire@dneg.com>, Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Tue, 15 Jul 2025 07:28:43 -0400
In-Reply-To: <CAPt2mGOwiXi3U5X3Pq1f425VmsKRJOSn6zA1S6CdoDx_twsv2Q@mail.gmail.com>
References: <20250714224216.14329-1-snitzer@kernel.org>
	 <CAPt2mGOwiXi3U5X3Pq1f425VmsKRJOSn6zA1S6CdoDx_twsv2Q@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Understood. We're not looking to abandon you guys. I think bog-standard
buffered I/O will be the default option for the forseeable future. We
are pretty keen to add other I/O modes as an _option_, however because
they do help other important workloads.

The hard part is how we make this tunable without shooting our future
selves in our collective feet. That's the main reason this is all being
done in debugfs for the moment, since that carries no ABI guarantees.

-- Jeff

On Tue, 2025-07-15 at 10:24 +0100, Daire Byrne wrote:
> Just a quick note to say that we are one of the examples (batch render
> farm) where we rely on the NFSD pagecache a lot.
>=20
> We have read heavy workloads where many clients share much of the same
> input data (e.g. rendering sequential frames).
>=20
> In fact, our 2 x 100gbit servers have 3TB of RAM and serve 70% of all
> reads from nfsd pagecache. It is not uncommon to max out the 200gbit
> network in this way even with spinning rust storage.
>=20
> Anyway, as you were.
>=20
> Daire
>=20
> On Mon, 14 Jul 2025 at 23:42, Mike Snitzer <snitzer@kernel.org> wrote:
> >=20
> > Hi,
> >=20
> > Summary (by Jeff Layton [0]):
> > "The basic problem is that the pagecache is pretty useless for
> > satisfying READs from nfsd. Most NFS workloads don't involve I/O to
> > the same files from multiple clients. The client ends up having most
> > of the data in its cache already and only very rarely do we need to
> > revisit the data on the server.
> >=20
> > At the same time, it's really easy to overwhelm the storage with
> > pagecache writeback with modern memory sizes. Having nfsd bypass the
> > pagecache altogether is potentially a huge performance win, if it can
> > be made to work safely."
> >=20
> > The performance win associated with using NFSD DIRECT was previously
> > summarized here:
> > https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> > This picture offers a nice summary of performance gains:
> > https://original.art/NFSD_direct_vs_buffered_IO.jpg
> >=20
> > This v3 series was developed ontop of Chuck's nfsd_testing which has 2
> > patches that saw fh_getattr() moved, etc (v2 of this series included
> > those patches but since they got review during v2 and Chuck already
> > has them staged in nfsd-testing I didn't think it made sense to keep
> > them included in this v3).
> >=20
> > Changes since v2 include:
> > - explored suggestion to use string based interface (e.g. "direct"
> >   instead of 3) but debugfs seems to only supports numeric values.
> > - shifted numeric values for debugfs interface from 0-2 to 1-3 and
> >   made 0 UNSPECIFIED (which is the default)
> > - if user specifies io_cache_read or io_cache_write mode other than 1,
> >   2 or 3 (via debugfs) they will get an error message
> > - pass a data structure to nfsd_analyze_read_dio rather than so many
> >   in/out params
> > - improved comments as requested (e.g. "Must remove first
> >   start_extra_page from rqstp->rq_bvec" was reworked)
> > - use memmove instead of opencoded shift in
> >   nfsd_complete_misaligned_read_dio
> > - dropped the still very important "lib/iov_iter: remove piecewise
> >   bvec length checking in iov_iter_aligned_bvec" patch because it
> >   needs to be handled separately.
> > - various other changes to improve code
> >=20
> > Thanks,
> > Mike
> >=20
> > [0]: https://lore.kernel.org/linux-nfs/b1accdad470f19614f9d3865bb3a4c69=
958e5800.camel@kernel.org/
> >=20
> > Mike Snitzer (5):
> >   NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
> >   NFSD: pass nfsd_file to nfsd_iter_read()
> >   NFSD: add io_cache_read controls to debugfs interface
> >   NFSD: add io_cache_write controls to debugfs interface
> >   NFSD: issue READs using O_DIRECT even if IO is misaligned
> >=20
> >  fs/nfsd/debugfs.c          | 102 +++++++++++++++++++
> >  fs/nfsd/filecache.c        |  32 ++++++
> >  fs/nfsd/filecache.h        |   4 +
> >  fs/nfsd/nfs4xdr.c          |   8 +-
> >  fs/nfsd/nfsd.h             |  10 ++
> >  fs/nfsd/nfsfh.c            |   4 +
> >  fs/nfsd/trace.h            |  37 +++++++
> >  fs/nfsd/vfs.c              | 197 ++++++++++++++++++++++++++++++++++---
> >  fs/nfsd/vfs.h              |   2 +-
> >  include/linux/sunrpc/svc.h |   5 +-
> >  10 files changed, 383 insertions(+), 18 deletions(-)
> >=20
> > --
> > 2.44.0
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

