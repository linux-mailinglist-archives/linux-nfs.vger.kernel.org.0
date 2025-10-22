Return-Path: <linux-nfs+bounces-15495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF23BFA08F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 07:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C03A83F7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 05:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8AE2E1F0E;
	Wed, 22 Oct 2025 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IBJzF1Po"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DBC2E229F
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110086; cv=none; b=e3NMqkXkipVDRca6o5+jhY8tnsU4PwbHbSeCfEsFsWWjdrlFZ5y1tvx4vFKDBwQAneDS2K3vyUEQ1nGr51eOKZm9jRYmi7pyAmrH9J99yhmzqxWrZCsVlv8U8vmBBoaxl3Lfyv1O2RT/m4DBkIbOrAkuWzPJjYygJDHv7dmjpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110086; c=relaxed/simple;
	bh=+f00kn33JLTN0G0YPO+GcQ+3XknU/ndzVca0I2PJCf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKkfD4EzCJwe4efLS+vZCmI4uHP0JBJbAFvo5HOawn6Z9PSWZLB/RIyxrmPirxwi74A3xhZ1Z0wVooOFuw+YJ8xWlGDJqWPEUURO4JdGxGl8uePX3yXhKTHWjFcvxHTdCuQi4GTuRT4/0RymCF3/2ycOPUZE32AyvOOUwHWj1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IBJzF1Po; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nfy9oe8yWHvSrMibE2CRqCAEAzBcOF7KfyRVaczhBKQ=; b=IBJzF1PoCOl3cYuMzICPKSzV6Q
	3bHNAFpDvBeUycOh2Ck/IxRZ2nc1TMAatcNY2TQCBxI/8jNzwZysbQHeCZL7+Y1HH1fxhGGXVsOwt
	3usF9vVgR3JnXO7solOeF0VIJEYvNvbP8pnLEp81Se5KIJpP7nTyVBpqv3U/WQnJ/8081GToiMSnv
	jtDbLrHj1/hWD/9b27inFbHZme877cRlfF/g9Ge7GPuV2ZRlHxyhA4idQIhj8XLRXKOpFXeVfFcvw
	rCzHmEJxhi00w5Y9dNlSNsSrKKnokbKlxh+MwTMBCOScYYtL7N2T0R36QSxUhvFJ98WqBMyvIm1ww
	yfpH0qNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBRBK-00000001VjJ-3B84;
	Wed, 22 Oct 2025 05:14:42 +0000
Date: Tue, 21 Oct 2025 22:14:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPhoQtHH8iscmmKJ@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
 <aPXihwGTiA7bqTsN@infradead.org>
 <aPZi2DXtdELwjTu2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZi2DXtdELwjTu2@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 12:27:04PM -0400, Mike Snitzer wrote:
> > Can you define synchronous better here?  The term is unfortunately
> > overloaded between synchronous syscalls vs aio/io_uring and O_(D)SYNC
> > style I/O.  As of now I don't understand which one you mean, especially
> > with the DONTCACHE reference thrown in, but I guess I'll figure it out
> > reading the patch.
> 
> It clearly talks about synchronous IO.  DONTCACHE just happens to be
> the buffered IO that'll be used if supported.
> 
> I don't see anything that needs changing here.

Again, what synchronous?  O_(D)SYNC, or !async?

> 
> > > If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
> > > invalidate the page cache on behalf of the DIO WRITE, then
> > > nfsd_issue_write_dio() will fall back to using buffered IO.
> > 
> > Did you see -ENOTBLK leaking out of the file systems?  Because at
> > least for iomap it is supposed to be an indication that the
> > file system ->write_iter handler needs to retry using buffered
> > I/O and never leak to the caller.
> 
> fs/iomap/direct-io.c:__iomap_dio_rw() will return -ENOTBLK on its own.

Yes, and the callers in the file system methods are supposed to handle
that and fall back to buffered I/O.  Take a look at xfs_file_write_iter.

If this leaks out of ->write_iter we have a problem that needs fixing
in the affected file system.

> 
> > > These changes served as the original starting point for the NFS
> > > client's misaligned O_DIRECT support that landed with
> > > commit c817248fc831 ("nfs/localio: add proper O_DIRECT support for
> > > READ and WRITE"). But NFSD's support is simpler because it currently
> > > doesn't use AIO completion.
> > 
> > I don't understand this paragraph.  What does starting point mean
> > here?  How does it matter for the patch description?
> 
> This patch's NFSD changes were starting point for NFS commit
> c817248fc831

But that commit is already in?  This sentence really confuses me.

> Would prefer that cleanup, if done, to happen with an incremental
> follow-up patch.

Starting out with well structured code is generally a good idea :(

> 
> > > +static bool
> > > +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
> > > +                        unsigned int len_mask)
> > 
> > Wouldn't it make sense to track the alignment when building the bio_vec
> > array instead of doing another walk here touching all cache lines?
> 
> Yes, that is the conventional wisdom that justified Keith removing
> iov_iter_aligned.  But for NFSD's WRITE payload the bio_vec is built
> outside of the fs/nfsd/vfs.c code.  Could be there is a natural way to
> clean this up (to make the sunrpc layer to conditionally care about
> alignment) but I didn't confront that yet.

Well, for the block code it's also build outside the layer consuming it.
But Keith showed that you can easily communicate that information and
avoid extra loops touching the cache lines.

> 
> Room for follow-on improvement to be sure.
> 
> > > +	if (unlikely(dio_blocksize > PAGE_SIZE))
> > > +		return false;
> > 
> > Why does this matter?  Can you add a comment explaining it?
> 
> I did/do have concerns that a bug in the storage driver could expose
> dio_offset_align that is far too large and so bounded dio_blocksize to
> a conservative size.  What is a better constant to check?

I don't think there is a good upper limit, we not do supper LBA sizes
larger than PAGE_SIZE, although I don't think there's any shipping
devices that do that.  But the most important thing is to always add
a comment with the rationale for such non-obvious checks so that someone
who has to lift it later can understand why it is done.

> > > +	 * Also update @stable_how to avoid need for COMMIT.
> > > +	 */
> > > +	kiocb->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> > 
> > What do you mean with completed before returning?  I guess you
> > mean writeback actually happening, right?  Why do you need that,
> > why do you also force it for the direct I/O?
> 
> The IO needs to have reached stable storage.

Please spell that out.  Because that's different from how completed
is generally used in file systems and storage protocols.

> > Also IOCB_SYNC is wrong here, as the only thing it does over
> > IOCB_DSYNC is also forcing back of metadata not needed to find
> > data (aka timestamps), which I can't see any need for here.
> 
> Well, we're eliding any followup SYNC from the NFS client by setting
> stable_how to NFS_FILE_SYNC, so I made sure to use SYNC:

Why do you care about timestamps reaching stable storage?  Which is the
only practical extra thing IOCB_SYNC will give you.  If there is a good
reason for that, add a comment because that's a bit unexpected (and
in general IOCB_SYNC / O_SYNC is just a sign that someone does not know
about SYNC vs DSYNC semantics).

> > The VFS certainly does not, and if it leaks out of a specific file
> > system we need to fix that.
> 
> As I said above, fs/iomap/direct-io.c:__iomap_dio_rw() does.

As stated above that's an internal helper and the code is supposed to
be handled by the file system and never leak out.

> Regardless, the most likely outcome from issing what should be aligned
> DIO only to get -EINVAL is exactly what is addressed with this
> _unlikely_ error handling: misaligned IO..

No.  There is no reason why this is any more likely than any of the
other -EINVAL cases.


