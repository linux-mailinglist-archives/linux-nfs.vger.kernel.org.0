Return-Path: <linux-nfs+bounces-20613-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MB+OHlbzmm/nAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20613-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 14:05:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44395388C75
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84783014BD2
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191463C0610;
	Thu,  2 Apr 2026 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep0k1aKZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288D367F3D;
	Thu,  2 Apr 2026 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131175; cv=none; b=HKMwMA1J6rufGaCAi5KlUoFKXRWSUMnKWoKz+uDYOyw+vsAQmJoldntIIZAQY5LD5rzGKUUtPrNIVwJWVCFkZG+7C/Upm85V+UovVNADDjqtDdXx4TnlkGOruFfLpwOPK1u+fq97jKrn+Q2onYftOTmYKOgND/ElrGc34lhQk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131175; c=relaxed/simple;
	bh=bXjNwuVcvjfUvvg8ib8sDsUa+E+X/TO4yebCgcoJ/Z0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJE7/QCQ4TAFueQzC/A9P6ZiJsJcOxecvMpQrn7IgLlmt87+oq4kKFnJvaLOFpFRhSkseWkuBou/DcTnpusHWkHvnqb1tYEQr6KZdSqfzph2I+mvi3sI06KbnSgsgWkN53aip8UZbvU+lXnmHZ8eDOTqMNaxgU2K/IUSh+U2Wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep0k1aKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A2DC116C6;
	Thu,  2 Apr 2026 11:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775131173;
	bh=bXjNwuVcvjfUvvg8ib8sDsUa+E+X/TO4yebCgcoJ/Z0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ep0k1aKZ3JEAn8Efbb+cvlJlj/g4Fw4GnuChzS9W51z79J1IHcmBN8U/FTNEXkCHX
	 y9r07YYLkiqimfRJeWpMxQJLrJz0c+1dDxlknyua/4QxLfjBVF7/8/ciqsBlQfYhh7
	 hwT5A+jXAF/HNmdWZQIewVJ4nNcHJUNWCWx8Ed6GEcy++wbIxoIT0GplxJ9qCxqMAn
	 YByk3rSyu26E/qOSfXdrdCzgMww+o76VcuAOqGQ69ekIhDgt27fHRpTdsglH+uBnGS
	 Oo2lfAdAMdQ1wJU1DdYw4XDEiR6oKPDixKIktNHruVOX2E06G1KTwY4wxzyKUUSgPc
	 aBLrnkQzE6HuQ==
Message-ID: <09672fa10c77d4fbfa1a13ea16aedf79d23fd8f8.camel@kernel.org>
Subject: Re: [PATCH 1/4] mm: fix IOCB_DONTCACHE write performance with
 rate-limited writeback
From: Jeff Layton <jlayton@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew
 Morton	 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka	 <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan	 <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Mike Snitzer	 <snitzer@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date: Thu, 02 Apr 2026 07:59:30 -0400
In-Reply-To: <ikaam0ox.ritesh.list@gmail.com>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
	 <20260401-dontcache-v1-1-1f5746fab47a@kernel.org>
	 <ikaam0ox.ritesh.list@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20613-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 44395388C75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-02 at 10:13 +0530, Ritesh Harjani wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > IOCB_DONTCACHE calls filemap_flush_range() with nr_to_write=3DLONG_MAX
> > on every write, which flushes all dirty pages in the written range.
> > Under concurrent writers this creates severe serialization on the
> > writeback submission path, causing throughput to collapse to ~47% of
> > buffered I/O with multi-second tail latency.
>=20
> Yes, between concurrent writers, I agree with the theory.
>=20
>=20
> > Even single-client
> > sequential writes suffer: on a 512GB file with 256GB RAM, the
> > aggressive flushing triggers dirty throttling that limits throughput
> > to 575 MB/s vs 1442 MB/s with rate-limited writeback.
>=20
> I am not sure if this 2.5x performance penalty in a "single" sequential
> writer is due to throttling logic. On giving it some thoughts, I suspect
> if this is because, the submission side and the completion side both
> takes the xa_lock and hence could be contending on that.
>=20
> For e.g. since this patch skips doing the flush the second time, (note
> that writeback is active when the same writer dirtied the page during
> previous write), this allows the writer to do more work of writing data
> to page cache pages, instead of waiting on the xa_lock which the
> completion callback could be holding (folio_end_writeback() -> folio_end_=
dropbehind())
>=20
> If I see Peak Dirty data from the link you shared [1] in single writer ca=
se...
>=20
> Mode                    MB/s	p50 (ms)	p99 (ms)	p99.9 (ms)	Peak Dirty	Peak=
 Cache
> dontcache (unpatched)	1179	3.2	    103.3	    170.9	    14 MB	    4.7 GB
> dontcache (patched)	1453	5.4	    43.8	    57.4	    36 GB	    45 GB
>=20
> ... this too shows that the submission side is writing more dirty pages,
> then the completion side able to write it...=20
>=20
> I suspect this contention (between submission and completion) could more
> in IOCB_DONTCACHE case, since the completion side also removes the folio
> from the page cache within the same xa_lock, which is not the same with
> normal buffered writes.
>=20
> Maybe a perf callgraph showing the contention would be nicer thing to add
> here [1] ;).=20
>=20
> [1]: https://markdownpastebin.com/?id=3D96249deb897a401ba32acbce05312dcc
>=20

That's an interesting point.

The theory I've been operating on is that the flusher thread ends up
squatting on the xa_lock for a while when memory gets tight, and that
blocks other readers and writers. Staying ahead of the dirty limits and
limiting the amount of flush work that each writer does alleviates
contention for that lock and that's what improves the performance.

You're right though. I'll plan to play around with perf and see if I
can confirm the theory.

> >=20
> > Replace the filemap_flush_range() call in generic_write_sync() with a
> > new filemap_dontcache_writeback_range() that uses two rate-limiting
> > mechanisms:
> >=20
> >   1. Skip-if-busy: check mapping_tagged(PAGECACHE_TAG_WRITEBACK)
> >      before flushing.  If writeback is already in progress on the
> >      mapping, skip the flush entirely.  This eliminates writeback
> >      submission contention between concurrent writers.
> >=20
> >   2. Proportional cap: when flushing does occur, cap nr_to_write to
> >      the number of pages just written.  This prevents any single
> >      write from triggering a large flush that would starve concurrent
> >      readers.
> >=20
> > Both mechanisms are necessary: skip-if-busy alone causes I/O bursts
> > when the tag clears (reader p99.9 spikes 83x); proportional cap alone
> > still serializes on xarray locks regardless of submission size.
> >=20
> > Pages touched under IOCB_DONTCACHE continue to be marked for eviction
> > (dropbehind), so page cache usage remains bounded.  Ranges skipped by
> > the busy check are eventually flushed by background writeback or by
> > the next writer to find the tag clear.
>=20
> Yes, but the next writer may not write the dirty pages, of the previous
> writer which skipped the flush call right (even if it finds the tag
> clear)? Because filemap_dontcache_writeback_range( ) passes the range
> and nr_to_write that means, unless the previous writer dirtied the same
> range, the new writer won't be able to write the dirty pages of the
> previous writer correct? So, it is mainly only the background writeback
> now, which will flush this dirty pages of the writer which skipped the
> flush (unless of course a fsync/sync call is made).
=20
> But having said that, I agree, this patch series is a nice performance
> improvement overall :)
>=20

Correct. When DONTCACHE writers end up skipping the flush, we rely on
VM dirty limits to eventually take care of flushing the data that got
skipped. That's why the DONTCACHE dirty pagecache max size ends up
looking close to buffered mode's.

I did play with a patch that had the writers attempt to flush 4x more
than they had written when memory was tight to compensate for that, but
it ended up performing worse than this set. It's possible that tuning
that down to 2x or so would do better, but I decided to just stop here
and post what I had.

> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/fs.h |  7 +++++--
> >  mm/filemap.c       | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 8b3dd145b25ec12b00ac1df17a952d9116b88047..53e9cca1b50a946a1276c49=
902294c3ae0ab3500 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2610,6 +2610,8 @@ extern int __must_check file_write_and_wait_range=
(struct file *file,
> >  						loff_t start, loff_t end);
> >  int filemap_flush_range(struct address_space *mapping, loff_t start,
> >  		loff_t end);
> > +int filemap_dontcache_writeback_range(struct address_space *mapping,
> > +		loff_t start, loff_t end, ssize_t nr_written);
> > =20
> >  static inline int file_write_and_wait(struct file *file)
> >  {
> > @@ -2645,8 +2647,9 @@ static inline ssize_t generic_write_sync(struct k=
iocb *iocb, ssize_t count)
> >  	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
> >  		struct address_space *mapping =3D iocb->ki_filp->f_mapping;
> > =20
> > -		filemap_flush_range(mapping, iocb->ki_pos - count,
> > -				iocb->ki_pos - 1);
> > +		filemap_dontcache_writeback_range(mapping,
> > +				iocb->ki_pos - count,
> > +				iocb->ki_pos - 1, count);
> >  	}
> > =20
> >  	return count;
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 406cef06b684a84a1e0c27d8267e95f32282ffdc..af2024b736bef74571cc22a=
b7e3cde2c8e872efe 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -437,6 +437,35 @@ int filemap_flush_range(struct address_space *mapp=
ing, loff_t start,
> >  }
> >  EXPORT_SYMBOL_GPL(filemap_flush_range);
> > =20
> > +/**
> > + * filemap_dontcache_writeback_range - rate-limited writeback for dont=
cache I/O
> > + * @mapping:	target address_space
> > + * @start:	byte offset to start writeback
> > + * @end:	last byte offset (inclusive) for writeback
> > + * @nr_written:	number of bytes just written by the caller
> > + *
> > + * Rate-limited writeback for IOCB_DONTCACHE writes.  Skips the flush
> > + * entirely if writeback is already in progress on the mapping (skip-i=
f-busy),
> > + * and when flushing, caps nr_to_write to the number of pages just wri=
tten
> > + * (proportional cap).  Together these avoid writeback contention betw=
een
> > + * concurrent writers and prevent I/O bursts that starve readers.
> > + *
> > + * Return: %0 on success, negative error code otherwise.
> > + */
> > +int filemap_dontcache_writeback_range(struct address_space *mapping,
> > +		loff_t start, loff_t end, ssize_t nr_written)
> > +{
> > +	long nr;
> > +
> > +	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> > +		return 0;
> > +
> > +	nr =3D (nr_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, &nr,
> > +			WB_REASON_BACKGROUND);
>=20
> Was this rebased against some other tree? I couldn't find it in
> linux-next. I think, that last argument is wrong.=20
>=20

Yes, my apologies. I think this must have been a bad merge on my part
during the rebase. I'll post a v2 in the near future.

> > +}
> > +EXPORT_SYMBOL_GPL(filemap_dontcache_writeback_range);
> > +
> >  /**
> >   * filemap_flush - mostly a non-blocking flush
> >   * @mapping:	target address_space
> >=20
> > --=20
> > 2.53.0

Thanks for the review!
--=20
Jeff Layton <jlayton@kernel.org>

