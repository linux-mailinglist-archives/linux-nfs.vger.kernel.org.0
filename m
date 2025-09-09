Return-Path: <linux-nfs+bounces-14160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD1CB50969
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CC11C2204C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 23:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131B28CF41;
	Tue,  9 Sep 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBlSbdya"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A328C01E
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462176; cv=none; b=DwTZ4QHFjaEMoqlqHVV4bbOwSydDPhuLSolrpTRyBibg/uExDZQ4SeqN587dFxSQ83rGbvl3h/2ufSi4ORgcSIY4soGdbh74YSTrrrTBj2ex7Y8wOqd1n4+y8wOyNb+HftJpJN1jh76oCp+EwteRBKSIDbZueGIrrbQSHyMqhOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462176; c=relaxed/simple;
	bh=8M1UiJ2l6Pgt31oIy8tlcy2WjjcO+PmeExSgcy4lb+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8VjpipxfVDUzYQca186WsdXqJWvAKgsO1rgLdQDbgAEmKszOkHxduc9+6thNbK7j4sN12eDjfN/S9Xg6qkd/laahQmCPnmSZWlu5izdxDMHmFZS9b97EIIblyNlWfkFVJbL/CqbmYr89rrKBJvTOKcisaKTa/+c5hlx5UAHdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBlSbdya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DA6C4CEF4;
	Tue,  9 Sep 2025 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757462175;
	bh=8M1UiJ2l6Pgt31oIy8tlcy2WjjcO+PmeExSgcy4lb+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBlSbdyarV6foRkcboadvYSOju1fftgp5Q1xthdABznwgMYxqKj8gaBjE9vFmKHOY
	 gjILEFBh/QYSxvx/IV0u6z2nJOGi9EmGLPQdfJ/IXvqahfKtHen/6Cqs+3QV04vY8H
	 Hwvbag4cFsjI3ZugclgoRHT5/ydZ2F2bva1EMg0RFeBzixKZLy/KCZn3ClsCs6V/7E
	 YzRg18KFiqOeiyhJtI0sGJoWweAOl94n6nLnjvBbm8rHTkIJobN7w7v/iecMFpVtN4
	 xz8Qb9yEN6ZNnnUPhNsrr3apl7RXvz+uSEsMBJ6uyVkeuqIUfNFoiaDfAqZNOXVrri
	 iBCMqBOz7HMxA==
Date: Tue, 9 Sep 2025 19:56:14 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aMC-nsD3lHSzbGPx@kernel.org>
References: <20250909190525.7214-1-cel@kernel.org>
 <20250909190525.7214-4-cel@kernel.org>
 <175746104715.2850467.8246435920764028613@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175746104715.2850467.8246435920764028613@noble.neil.brown.name>

On Wed, Sep 10, 2025 at 09:37:27AM +1000, NeilBrown wrote:
> On Wed, 10 Sep 2025, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Add an experimental option that forces NFS READ operations to use
> > direct I/O instead of reading through the NFS server's page cache.
> > 
> > There are already other layers of caching:
> >  - The page cache on NFS clients
> >  - The block device underlying the exported file system
> > 
> > The server's page cache, in many cases, is unlikely to provide
> > additional benefit. Some benchmarks have demonstrated that the
> > server's page cache is actively detrimental for workloads whose
> > working set is larger than the server's available physical memory.
> > 
> > For instance, on small NFS servers, cached NFS file content can
> > squeeze out local memory consumers. For large sequential workloads,
> > an enormous amount of data flows into and out of the page cache
> > and is consumed by NFS clients exactly once -- caching that data
> > is expensive to do and totally valueless.
> > 
> > For now this is a hidden option that can be enabled on test
> > systems for benchmarking. In the longer term, this option might
> > be enabled persistently or per-export. When the exported file
> > system does not support direct I/O, NFSD falls back to using
> > either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> > 
> > Suggested-by: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/debugfs.c |  2 ++
> >  fs/nfsd/nfsd.h    |  1 +
> >  fs/nfsd/trace.h   |  1 +
> >  fs/nfsd/vfs.c     | 78 +++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 82 insertions(+)
> > 
> > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > index ed2b9e066206..00eb1ecef6ac 100644
> > --- a/fs/nfsd/debugfs.c
> > +++ b/fs/nfsd/debugfs.c
> > @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
> >   * Contents:
> >   *   %0: NFS READ will use buffered IO
> >   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> > + *   %2: NFS READ will use direct IO
> >   *
> >   * This setting takes immediate effect for all NFS versions,
> >   * all exports, and in all NFSD net namespaces.
> > @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
> >  		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> >  		break;
> >  	case NFSD_IO_DONTCACHE:
> > +	case NFSD_IO_DIRECT:
> >  		/*
> >  		 * Must disable splice_read when enabling
> >  		 * NFSD_IO_DONTCACHE.
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index ea87b42894dd..bdb60ee1f1a4 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -157,6 +157,7 @@ enum {
> >  	/* Any new NFSD_IO enum value must be added at the end */
> >  	NFSD_IO_BUFFERED,
> >  	NFSD_IO_DONTCACHE,
> > +	NFSD_IO_DIRECT,
> >  };
> >  
> >  extern u64 nfsd_io_cache_read __read_mostly;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index e5af0d058fd0..88901df5fbb1 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
> >  DEFINE_NFSD_IO_EVENT(read_start);
> >  DEFINE_NFSD_IO_EVENT(read_splice);
> >  DEFINE_NFSD_IO_EVENT(read_vector);
> > +DEFINE_NFSD_IO_EVENT(read_direct);
> >  DEFINE_NFSD_IO_EVENT(read_io_done);
> >  DEFINE_NFSD_IO_EVENT(read_done);
> >  DEFINE_NFSD_IO_EVENT(write_start);
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 441267d877f9..9665454743eb 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1074,6 +1074,79 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> >  }
> >  
> > +/*
> > + * The byte range of the client's READ request is expanded on both
> > + * ends until it meets the underlying file system's direct I/O
> > + * alignment requirements. After the internal read is complete, the
> > + * byte range of the NFS READ payload is reduced to the byte range
> > + * that was originally requested.
> > + *
> > + * Note that a direct read can be done only when the xdr_buf
> > + * containing the NFS READ reply does not already have contents in
> > + * its .pages array. This is due to potentially restrictive
> > + * alignment requirements on the read buffer. When .page_len and
> > + * @base are zero, the .pages array is guaranteed to be page-
> > + * aligned.
> 
> Where do we test that this condition is met?
> 
> I can see that nfsd_direct_read() is only called if "base" is zero, but
> that means the current contents of the .pages array are page-aligned,
> not that there are now.
> 
> > + */
> > +static noinline_for_stack __be32
> > +nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > +		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
> > +		 u32 *eof)
> > +{
> > +	loff_t dio_start, dio_end;
> > +	unsigned long v, total;
> > +	struct iov_iter iter;
> > +	struct kiocb kiocb;
> > +	ssize_t host_err;
> > +	size_t len;
> > +
> > +	init_sync_kiocb(&kiocb, nf->nf_file);
> > +	kiocb.ki_flags |= IOCB_DIRECT;
> > +
> > +	/* Read a properly-aligned region of bytes into rq_bvec */
> > +	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
> > +	dio_end = round_up(offset + *count, nf->nf_dio_read_offset_align);
> > +
> > +	kiocb.ki_pos = dio_start;
> > +
> > +	v = 0;
> > +	total = dio_end - dio_start;
> > +	while (total) {
> > +		len = min_t(size_t, total, PAGE_SIZE);
> > +		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> > +			      len, 0);
> > +		total -= len;
> > +		++v;
> > +	}
> > +	WARN_ON_ONCE(v > rqstp->rq_maxpages);
> 
> I would rather we had an early test rather than a late warn-on.
> e.g.
>   if (total > (rqstp->rq_maxpages >> PAGE_SHIFT))
>      return -EINVAL /* or whatever */;

-EINVAL is the devil. ;)

My follow-up patch should avoid any possibility of this WARN_ON_ONCE
ever triggering:
https://lore.kernel.org/linux-nfs/20250909233315.80318-2-snitzer@kernel.org/
(and should/could be folded into this 3/3 patch?)

> Otherwise it seems to be making unstated assumptions about how big the
> alignment requirements could be.

Just FYI, nfsd_direct_read's while loop code is nearly identical to
that which is in nfsd_iter_read().

So if an early return warranted in nfsd_direct_read, it is also
warranted in nfsd_iter_read.

(I had an early return in nfsd_iter_read N iterations ago, decided it
not needed given its not something that we'll ever hit.. really just a
canary in the coal mine that offers companionship until one of us dies
of black lung)

Mike

