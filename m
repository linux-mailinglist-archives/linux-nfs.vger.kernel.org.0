Return-Path: <linux-nfs+bounces-21466-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK+4OhLiAWq1lwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21466-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:05:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD68C50F9F2
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B24163004689
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D7E3E8C49;
	Mon, 11 May 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etF1amDK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04D3BADAA;
	Mon, 11 May 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507607; cv=none; b=RNGaK21CQyavgNzt1ia5u2aOUHKN2i3rP9mlcewuwEoVg1b7tJ3sw960aucWvGgCMGKq0XkdD/esX0g86XaNyAvK/LsFI4Md4+CQL7ah+DnT5hyT1WcaLRA/bfc8imL3ZTfkw+nAHvpYL6c97d1ySt1HMlJYuhIWxvUAivpsX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507607; c=relaxed/simple;
	bh=zahkTkZQZVlfJg7f6s2PiTNssAJAX60SFD/YmUN+Rso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fxz1josqRssRMAi0YNr0iyWWo4TTfXRqWxLEjMCw7A9reLQTvgJ1sP4DH0rYZui2ZCW2TQRIgK0afrOvQY7jxlq+47mnk9/nA6kxc5Hjo5/yy5cvHwkB20Cp/Qzo9TRZw00YMZ0n9Vf9LeKwxCSixDYE8HYl8yk1A674B7QRg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etF1amDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A13DC2BCB0;
	Mon, 11 May 2026 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507606;
	bh=zahkTkZQZVlfJg7f6s2PiTNssAJAX60SFD/YmUN+Rso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=etF1amDK6dGz1zKr8nfGr7NBy4+PVAPVVEPus9h0qp6qLfSh5W4xd3gp3/KGDpfjL
	 0pAV+0NYM4vDYvzZBcbptTr03v7X3o/4bl7NCP3P8MQjX9J/UPGFOQHHwgyAEbPBwP
	 opWo8SXByrQSo/sVUdRg6vLo5Qmx+HjgqfIESjzTe+3DpunJ3ztCh7P8X/KFikZQXM
	 Z3WaVYmgGbSlvc6GVMSmzNKPW1FnXssnLuIezilSANDV9jOgItpscqexGCjzJ6L5Qb
	 3D6NOwLKLtXpfYot5G/Zbf/E+Y3RzVn/PvJuw9mPmgxqTfcXzP9/soRDimv+HZJNP2
	 Y4HBnUkR67bfg==
Message-ID: <7c0880ee25b13f64f71319203fcd7105f54e5ad0.camel@kernel.org>
Subject: Re: [PATCH v7 3/3] mm: kick writeback flusher for IOCB_DONTCACHE
 with targeted dirty tracking
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)"	 <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett"	 <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport	 <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko	 <mhocko@suse.com>,
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,  Ritesh
 Harjani <ritesh.list@gmail.com>, Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date: Mon, 11 May 2026 09:53:21 -0400
In-Reply-To: <20260511-zusieht-amputation-efe8b5058cb7@brauner>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
	 <20260511-dontcache-v7-3-2848ddce8090@kernel.org>
	 <20260511-zusieht-amputation-efe8b5058cb7@brauner>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DD68C50F9F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21466-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,infradead.org,linux-foundation.org,kernel.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 15:24 +0200, Christian Brauner wrote:
> On Mon, May 11, 2026 at 07:58:29AM -0400, Jeff Layton wrote:
> > The IOCB_DONTCACHE writeback path in generic_write_sync() calls
> > filemap_flush_range() on every write, submitting writeback inline in
> > the writer's context.  Perf lock contention profiling shows the
> > performance problem is not lock contention but the writeback submission
> > work itself =E2=80=94 walking the page tree and submitting I/O blocks t=
he writer
> > for milliseconds, inflating p99.9 latency from 23ms (buffered) to 93ms
> > (dontcache).
> >=20
> > Replace the inline filemap_flush_range() call with a flusher kick that
> > drains dirty pages in the background.  This moves writeback submission
> > completely off the writer's hot path.
> >=20
> > To avoid flushing unrelated buffered dirty data, add a dedicated
> > WB_start_dontcache bit and wb_check_start_dontcache() handler that uses
> > the per-wb WB_DONTCACHE_DIRTY counter to determine how many pages to
> > write back.  The flusher writes back that many pages from the oldest di=
rty
> > inodes (not restricted to dontcache-specific inodes). This helps
> > preserve I/O batching while limiting the scope of expedited writeback.
> >=20
> > Like WB_start_all, the WB_start_dontcache bit coalesces multiple
> > DONTCACHE writes into a single flusher wakeup without per-write
> > allocations.  Use test_and_clear_bit to atomically consume the kick
> > request before reading the dirty counter and starting writeback, so tha=
t
> > concurrent DONTCACHE writes during writeback can re-set the bit and
> > schedule a follow-up flusher run.
> >=20
> > Read the dirty counter with wb_stat_sum() (aggregating per-CPU batches)
> > rather than wb_stat() (which reads only the global counter) to ensure
> > small writes below the percpu batch threshold are visible to the flushe=
r.
> >=20
> > In filemap_dontcache_kick_writeback(), set the WB_start_dontcache bit
> > inside the unlocked_inode_to_wb_begin/end section for correct cgroup
> > writeback domain targeting, but defer the wb_wakeup() call until after
> > the section ends, since wb_wakeup() uses spin_unlock_irq() which would
> > unconditionally re-enable interrupts while the i_pages xa_lock may stil=
l
> > be held under irqsave during a cgroup writeback switch. Pin the wb with
> > wb_get() inside the RCU critical section before calling wb_wakeup()
> > outside it, since cgroup bdi_writeback structures are RCU-freed and the
> > wb pointer could become invalid after unlocked_inode_to_wb_end() drops
> > the RCU read lock.
> >=20
> > Also add WB_REASON_DONTCACHE as a new writeback reason for tracing
> > visibility.
> >=20
> > dontcache-bench results (same host, T6F_SKL_1920GBF, 251 GiB RAM,
> > xfs on NVMe, fio io_uring):
> >=20
> > Buffered and direct I/O paths are unaffected by this patchset. All
> > improvements are confined to the dontcache path:
> >=20
> > Single-stream throughput (MB/s):
> >                         Before    After    Change
> >   seq-write/dontcache      298      897    +201%
> >   rand-write/dontcache     131      236     +80%
> >=20
> > Tail latency improvements (seq-write/dontcache):
> >   p99:    135,266 us  ->  23,986 us   (-82%)
> >   p99.9: 8,925,479 us ->  28,443 us   (-99.7%)
> >=20
> > Multi-writer (4 jobs, sequential write):
> >                                 Before    After    Change
> >   dontcache aggregate (MB/s)     2,529    4,532     +79%
> >   dontcache p99 (us)             8,553    1,002     -88%
> >   dontcache p99.9 (us)         109,314    1,057     -99%
> >=20
> >   Dontcache multi-writer throughput now matches buffered (4,532 vs
> >   4,616 MB/s).
> >=20
> > 32-file write (Axboe test):
> >                                 Before    After    Change
> >   dontcache aggregate (MB/s)     1,548    3,499    +126%
> >   dontcache p99 (us)            10,170      602     -94%
> >   Peak dirty pages (MB)          1,837      213     -88%
> >=20
> >   Dontcache now reaches 81% of buffered throughput (was 35%).
> >=20
> > Competing writers (dontcache vs buffered, separate files):
> >                                 Before    After
> >   buffered writer                  868      433 MB/s
> >   dontcache writer                 415      433 MB/s
> >   Aggregate                      1,284      866 MB/s
> >=20
> >   Previously the buffered writer starved the dontcache writer 2:1.
> >   With per-bdi_writeback tracking, both writers now receive equal
> >   bandwidth. The aggregate matches the buffered-vs-buffered baseline
> >   (863 MB/s), indicating fair sharing regardless of I/O mode.
> >=20
> >   The dontcache writer's p99.9 latency collapsed from 119 ms to
> >   33 ms (-73%), eliminating the severe periodic stalls seen in the
> >   baseline. Both writers now share identical latency profiles,
> >   matching the buffered-vs-buffered pattern.
> >=20
> > The per-bdi_writeback dirty tracking dramatically reduces peak dirty
> > pages in dontcache workloads, with the 32-file test dropping from
> > 1.8 GB to 213 MB. Dontcache sequential write throughput triples and
> > multi-writer throughput reaches parity with buffered I/O, with tail
> > latencies collapsing by 1-2 orders of magnitude.
> >=20
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/fs-writeback.c                | 63 ++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/backing-dev-defs.h |  2 ++
> >  include/linux/fs.h               |  6 ++--
> >  include/trace/events/writeback.h |  3 +-
> >  4 files changed, 69 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 32ecc745f5f7..77d53df97cc3 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2377,6 +2377,27 @@ static long wb_check_start_all(struct bdi_writeb=
ack *wb)
> >  	return nr_pages;
> >  }
> > =20
> > +static long wb_check_start_dontcache(struct bdi_writeback *wb)
> > +{
> > +	long nr_pages;
> > +
> > +	if (!test_and_clear_bit(WB_start_dontcache, &wb->state))
> > +		return 0;
> > +
> > +	nr_pages =3D wb_stat_sum(wb, WB_DONTCACHE_DIRTY);
> > +	if (nr_pages) {
> > +		struct wb_writeback_work work =3D {
> > +			.nr_pages	=3D nr_pages,
> > +			.sync_mode	=3D WB_SYNC_NONE,
> > +			.range_cyclic	=3D 1,
> > +			.reason		=3D WB_REASON_DONTCACHE,
> > +		};
> > +
> > +		nr_pages =3D wb_writeback(wb, &work);
> > +	}
> > +
> > +	return nr_pages;
> > +}
> > =20
> >  /*
> >   * Retrieve work items and do the writeback they describe
> > @@ -2398,6 +2419,11 @@ static long wb_do_writeback(struct bdi_writeback=
 *wb)
> >  	 */
> >  	wrote +=3D wb_check_start_all(wb);
> > =20
> > +	/*
> > +	 * Check for dontcache writeback request
> > +	 */
> > +	wrote +=3D wb_check_start_dontcache(wb);
> > +
> >  	/*
> >  	 * Check for periodic writeback, kupdated() style
> >  	 */
> > @@ -2472,6 +2498,43 @@ void wakeup_flusher_threads_bdi(struct backing_d=
ev_info *bdi,
> >  	rcu_read_unlock();
> >  }
> > =20
> > +/**
> > + * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE =
writes
> > + * @mapping:	address_space that was just written to
> > + *
> > + * Kick the writeback flusher thread to expedite writeback of dontcach=
e dirty
> > + * pages. Queue writeback for the inode's wb for as many pages as ther=
e are
> > + * dontcache pages, but don't restrict writeback to dontcache pages on=
ly.
> > + *
> > + * This significantly improves performance over either writing all wb'=
s pages
> > + * or writing only dontcache pages.  Although it doesn't guarantee qui=
ck
> > + * writeback and reclaim of dontcache pages, it keeps the amount of di=
rty pages
> > + * in check. Over longer term dontcache pages get written and reclaime=
d by
> > + * background writeback even with this rough heuristic.
> > + */
> > +void filemap_dontcache_kick_writeback(struct address_space *mapping)
> > +{
> > +	struct inode *inode =3D mapping->host;
> > +	struct bdi_writeback *wb;
> > +	struct wb_lock_cookie cookie =3D {};
> > +	bool need_wakeup =3D false;
> > +
> > +	wb =3D unlocked_inode_to_wb_begin(inode, &cookie);
> > +	if (wb_has_dirty_io(wb) &&
> > +	    !test_bit(WB_start_dontcache, &wb->state) &&
> > +	    !test_and_set_bit(WB_start_dontcache, &wb->state)) {
>=20
> Doesn't test_and_set_bit() return the old value? IOW, if it sees that
> WB_start_dontcache was already set it'll return true? So you can remove
> the test_bit() call, right?
>=20

Yes.

> > +		wb_get(wb);
> > +		need_wakeup =3D true;
> > +	}
>=20
> Actually, I think you can rewrite this function quite a bit:
>=20
>=20
> > +	unlocked_inode_to_wb_end(inode, &cookie);
> > +
> > +	if (need_wakeup) {
> > +		wb_wakeup(wb);
> > +		wb_put(wb);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(filemap_dontcache_kick_writeback);
>=20
> void filemap_dontcache_kick_writeback(struct address_space *mapping)
> {
> 	struct inode *inode =3D mapping->host;
> 	struct bdi_writeback *wb;
> 	struct wb_lock_cookie cookie =3D {};
>=20
> 	wb =3D unlocked_inode_to_wb_begin(inode, &cookie);
> 	if (wb_has_dirty_io(wb) && !test_and_set_bit(WB_start_dontcache, &wb->st=
ate))
> 		wb_get(wb);
> 	else
> 		wb =3D NULL;
> 	unlocked_inode_to_wb_end(inode, &cookie);
>=20
> 	if (wb) {
> 		wb_wakeup(wb);
> 		wb_put(wb);
> 	}
> }
>=20
> No?
>=20

That does look much cleaner. Do you want to just make that change or
would you rather I resend?

Thanks!

> > +
> >  /*
> >   * Wakeup the flusher threads to start writeback of all currently dirt=
y pages
> >   */
> > diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-d=
ev-defs.h
> > index cb660dd37286..4f1084937315 100644
> > --- a/include/linux/backing-dev-defs.h
> > +++ b/include/linux/backing-dev-defs.h
> > @@ -26,6 +26,7 @@ enum wb_state {
> >  	WB_writeback_running,	/* Writeback is in progress */
> >  	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
> >  	WB_start_all,		/* nr_pages =3D=3D 0 (all) work pending */
> > +	WB_start_dontcache,	/* dontcache writeback pending */
> >  };
> > =20
> >  enum wb_stat_item {
> > @@ -56,6 +57,7 @@ enum wb_reason {
> >  	 */
> >  	WB_REASON_FORKER_THREAD,
> >  	WB_REASON_FOREIGN_FLUSH,
> > +	WB_REASON_DONTCACHE,
> > =20
> >  	WB_REASON_MAX,
> >  };
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 11559c513dfb..df72b42a9e9b 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2624,6 +2624,7 @@ extern int __must_check file_write_and_wait_range=
(struct file *file,
> >  						loff_t start, loff_t end);
> >  int filemap_flush_range(struct address_space *mapping, loff_t start,
> >  		loff_t end);
> > +void filemap_dontcache_kick_writeback(struct address_space *mapping);
> > =20
> >  static inline int file_write_and_wait(struct file *file)
> >  {
> > @@ -2657,10 +2658,7 @@ static inline ssize_t generic_write_sync(struct =
kiocb *iocb, ssize_t count)
> >  		if (ret)
> >  			return ret;
> >  	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
> > -		struct address_space *mapping =3D iocb->ki_filp->f_mapping;
> > -
> > -		filemap_flush_range(mapping, iocb->ki_pos - count,
> > -				iocb->ki_pos - 1);
> > +		filemap_dontcache_kick_writeback(iocb->ki_filp->f_mapping);
> >  	}
> > =20
> >  	return count;
> > diff --git a/include/trace/events/writeback.h b/include/trace/events/wr=
iteback.h
> > index bdac0d685a98..13ee076ccd16 100644
> > --- a/include/trace/events/writeback.h
> > +++ b/include/trace/events/writeback.h
> > @@ -44,7 +44,8 @@
> >  	EM( WB_REASON_PERIODIC,			"periodic")		\
> >  	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
> >  	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
> > -	EMe(WB_REASON_FOREIGN_FLUSH,		"foreign_flush")
> > +	EM( WB_REASON_FOREIGN_FLUSH,		"foreign_flush")	\
> > +	EMe(WB_REASON_DONTCACHE,		"dontcache")
> > =20
> >  WB_WORK_REASON
> > =20
> >=20
> > --=20
> > 2.54.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

