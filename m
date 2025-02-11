Return-Path: <linux-nfs+bounces-10037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC4A30AA3
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 12:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B813A8B28
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 11:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977C12309AA;
	Tue, 11 Feb 2025 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPdr2qxu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEF81FBC84
	for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273912; cv=none; b=e9fE1KZFnajjNIqh3ruvAXqBJ61lMBAmNGW4Ov1jj7CAcmfqEV8Ka86VmQSMV/Tealh+apSskM62zRsHT8McG9hc3tPbpib3ax1mhzLEMI95Og/AjITY6PzeYCg0Cxk7QU39ahXsnonRs3Z1gvOg7EqKRRMC73f9ul9Ovi7naEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273912; c=relaxed/simple;
	bh=0R0mpq1SdIPVOCvZFYT3a1Gkl1tNQhFBY5fIA1aH4lk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TKDS9U5LZij92fTgBsBVEQ0JaSpZIW6D8cyCy7QprZUpvCZCdEi3+YXvHI7hThR9ep/DEsLmPeJd+HaEcbVeKCFfCwfd9d/cfILR8vj6ijS+lXEcV0UlWezPgY7eC8Pg/Y8IAWlOACBomAf7UCu/yeIE1wJA3Mk7hpFmuXDKBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPdr2qxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D29C4CEE2;
	Tue, 11 Feb 2025 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739273911;
	bh=0R0mpq1SdIPVOCvZFYT3a1Gkl1tNQhFBY5fIA1aH4lk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aPdr2qxuwr67HwIcwT/lC6CXRbksK3VCKz1Q7npj50B/TlTRj+CowvrDZiXu0psUF
	 En+KRKkoNKzHMzdZ3Ho0lnhWiCqUVWz+pvRJ3Otcli4eq6joVFCMEeCfLeIubrpEG5
	 Y2Wm3awA0t5usrvhS1nzHneYxcKaZh0RkL/OEpmya7tnN4v/F6l4RG5QsqXRRRLZBu
	 W5NSJLRNvW+Q7XAtfxFV5LhMdyb4c2e0RO/eqpGfIV17A2vu9S0XLqeCqccZOZ8MMb
	 3pTV/K/S280s9v9vMgwNsbo4BeZCuhVWBeFoKk6gT9jnA8nCmzmmkW+Zar6WqQ3Kyz
	 UgXmUF89EbJ8Q==
Message-ID: <2bda0fa87eb266a93f81ea3116fafb930ed155af.camel@kernel.org>
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Tue, 11 Feb 2025 06:38:30 -0500
In-Reply-To: <Z6qSenQcLKrP2fF1@dread.disaster.area>
References: <20250207051701.3467505-1-neilb@suse.de>
	 <20250207051701.3467505-5-neilb@suse.de>
	 <5e6060d79e247a7e97443f200399061da8d558f9.camel@kernel.org>
	 <Z6qSenQcLKrP2fF1@dread.disaster.area>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-11 at 10:57 +1100, Dave Chinner wrote:
> On Mon, Feb 10, 2025 at 09:01:41AM -0500, Jeff Layton wrote:
> > On Fri, 2025-02-07 at 16:15 +1100, NeilBrown wrote:
> > > The filecache lru is walked in 2 circumstances for 2 different reason=
s.
> > >=20
> > > 1/ When called from the shrinker we want to discard the first few
> > >    entries on the list, ignoring any with NFSD_FILE_REFERENCED set
> > >    because they should really be at the end of the LRU as they have b=
een
> > >    referenced recently.  So those ones are ROTATED.
> > >=20
> > > 2/ When called from the nfsd_file_gc() timer function we want to disc=
ard
> > >    anything that hasn't been used since before the previous call, and
> > >    mark everything else as unused at this point in time.
> > >=20
> > > Using the same flag for both of these can result in some unexpected
> > > outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then =
the
> > > nfsd_file_gc() will think the file hasn't been used in a while, while
> > > really it has.
> > >=20
> > > I think it is easier to reason about the behaviour if we instead have
> > > two flags.
> > >=20
> > >  NFSD_FILE_REFERENCED means "this should be at the end of the LRU, pl=
ease
> > >      put it there when convenient"
> > >  NFSD_FILE_RECENT means "this has been used recently - since the last
> > >      run of nfsd_file_gc()
> > >=20
> > > When either caller finds an NFSD_FILE_REFERENCED entry, that entry
> > > should be moved to the end of the LRU and the flag cleared.  This can
> > > safely happen at any time.  The actual order on the lru might not be
> > > strictly least-recently-used, but that is normal for linux lrus.
> > >=20
> > > The shrinker callback can ignore the "recent" flag.  If it ends up
> > > freeing something that is "recent" that simply means that memory
> > > pressure is sufficient to limit the acceptable cache age to less than
> > > the nfsd_file_gc frequency.
> > >=20
> > > The gc caller should primarily focus on NFSD_FILE_RECENT.  It should
> > > free everything that doesn't have this flag set, and should clear the
> > > flag on everything else.  When it clears the flag it is convenient to
> > > clear the "REFERENCED" flag and move to the end of the LRU too.
> > >=20
> > > With this, calls from the shrinker do not prematurely age files.  It
> > > will focus only on freeing those that are least recently used.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
> > >  fs/nfsd/filecache.h |  1 +
> > >  fs/nfsd/trace.h     |  3 +++
> > >  3 files changed, 23 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 04588c03bdfe..9faf469354a5 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> > >  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> > >  }
> > > =20
> > > -
> > >  static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > >  {
> > >  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
> >=20
> > Technically, I don't think you need the REFERENCED bit at all. This is
> > the only place it's set, and below this is calling list_lru_add_obj().
> > That returns false if the object was already on a per-node LRU.
> >=20
> > Instead of that, you could add a list_lru helper that will rotate the
> > object to the end of its nodelist if it's already on one. OTOH, that
> > might mean more cross NUMA-node accesses to the spinlocks than we get
> > by using a flag and doing this at GC time.
>=20
> No, please don't.
>=20
> Per-object reference bits are required to enable lazy LRU rotation.
> The LRU lists are -hot- objects; touching them every time we touch
> an object on the LRU is prohibitively expensive because of exclusive
> lock/cacheline contention. Hence we defer operations like rotation
> to a context where we already have the list locked and cached
> exclusively for some other reason (i.e. memory reclaim).
>=20
> This is the same reason we use lazy removal from LRUs - it avoids
> LRU list manipulations every time a hot cached object is accessed
> and/or dropped.
>=20
> IOWs, removing the per-object NFSD_FILE_REFERENCED bit will undo one
> of the necessary the optimisations that allow hot caches LRU
> management to work efficiently with minimal overhead.
>=20

Yep, that was the point of my "OTOH" comment. Keeping the REFERENCED
flag is better from a "let's minimize cacheline invalidations"
standpoint.
--=20
Jeff Layton <jlayton@kernel.org>

