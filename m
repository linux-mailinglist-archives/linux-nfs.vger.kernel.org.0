Return-Path: <linux-nfs+bounces-14568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB6B8590F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 17:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F8A1CC0D8D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB030CDB4;
	Thu, 18 Sep 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAHDdpW2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60D30CB48
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208833; cv=none; b=R6ED4AKlzVlNBu2UFSTdVkGIo9WU3zPyHqIwLFHxSAKrpAO045ecI/Zl8hTl1apMkOHPr9QDYOsNVgdHBoigRWAjjYC6AtUKBN+0qSaoJOBDtT5F7M0aQB40l0dYe5vlidxI8n52pefbyJRQwk7TDfk9emQei/wnYswW+tMUBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208833; c=relaxed/simple;
	bh=3GRigvr76eSPsSh2e9DumBhlXIplbLp2RpkHhjsZiZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juY+hOuLZpeFyVwbJoI2jFdleGFX5Am5bB+b5xQeIaBKK8y0b0SBNu1IuHSMdMEQFCzn+nWykfnyrvrKg/NTA26nD1PY4hu6lQzpTGVwuWo35JTnXLwckflPOi9XNAcDn9xZmn9EbOk8QTxv+odn7dT8OHwzwBPo4pOs2sH7mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAHDdpW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE26AC4CEE7;
	Thu, 18 Sep 2025 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208833;
	bh=3GRigvr76eSPsSh2e9DumBhlXIplbLp2RpkHhjsZiZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAHDdpW29sDcM7F1TXYPmkeR0dNF/iy4yGUcWxZpNiCw6p48agJJmED7oxNY8b3aJ
	 wsJQfK39H+LyjlQHdtPEb4NFAcEKP5CSjetfcKQuZX57epZn/dvIDIkpfbxuBMekaP
	 8G3CvrMwxoj74CTWg/MRSl/cnW2d5BPtcJ/9YDGipswYIb8C9qro007Iwsb8JCU/jv
	 IwqUq7+pm3SRQe39yZePcW1u1/z93tnriorvifQ2KntXUFkaccjh8CrN+Vf3a1p0CC
	 6YtyQUTl31oxr/YS/Pt2ga/327NinS4lEVa5PGQKu5l58i6VIiLGxUCepsYBa5XZ1l
	 +NHJYh16vHU4w==
Date: Thu, 18 Sep 2025 11:20:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <cel@kernel.org>, jlayton@kernel.org, okorniev@redhat.com,
	dai.ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aMwjP8DrrxzOy-5-@kernel.org>
References: <175815178827.1696783.10535533600809037950@noble.neil.brown.name>
 <aMwcUdWdey69k2iK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMwcUdWdey69k2iK@kernel.org>

On Thu, Sep 18, 2025 at 10:50:57AM -0400, Mike Snitzer wrote:
> On Thu, Sep 18, 2025 at 09:29:48AM +1000, NeilBrown wrote:
> > On Thu, 18 Sep 2025, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > Add an experimental option that forces NFS READ operations to use
> > > direct I/O instead of reading through the NFS server's page cache.
> > > 
> > > There are already other layers of caching:
> > >  - The page cache on NFS clients
> > >  - The block device underlying the exported file system
> > > 
> > > The server's page cache, in many cases, is unlikely to provide
> > > additional benefit. Some benchmarks have demonstrated that the
> > > server's page cache is actively detrimental for workloads whose
> > > working set is larger than the server's available physical memory.
> > > 
> > > For instance, on small NFS servers, cached NFS file content can
> > > squeeze out local memory consumers. For large sequential workloads,
> > > an enormous amount of data flows into and out of the page cache
> > > and is consumed by NFS clients exactly once -- caching that data
> > > is expensive to do and totally valueless.
> > > 
> > > For now this is a hidden option that can be enabled on test
> > > systems for benchmarking. In the longer term, this option might
> > > be enabled persistently or per-export. When the exported file
> > > system does not support direct I/O, NFSD falls back to using
> > > either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> > > 
> > > Suggested-by: Mike Snitzer <snitzer@kernel.org>
> > > Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/nfsd/debugfs.c |    2 +
> > >  fs/nfsd/nfsd.h    |    1 +
> > >  fs/nfsd/trace.h   |    1 +
> > >  fs/nfsd/vfs.c     |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 85 insertions(+)
> > > 
> > > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > > index ed2b9e066206..00eb1ecef6ac 100644
> > > --- a/fs/nfsd/debugfs.c
> > > +++ b/fs/nfsd/debugfs.c
> > > @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
> > >   * Contents:
> > >   *   %0: NFS READ will use buffered IO
> > >   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> > > + *   %2: NFS READ will use direct IO
> > >   *
> > >   * This setting takes immediate effect for all NFS versions,
> > >   * all exports, and in all NFSD net namespaces.
> > > @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
> > >  		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> > >  		break;
> > >  	case NFSD_IO_DONTCACHE:
> > > +	case NFSD_IO_DIRECT:
> > >  		/*
> > >  		 * Must disable splice_read when enabling
> > >  		 * NFSD_IO_DONTCACHE.
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index ea87b42894dd..bdb60ee1f1a4 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -157,6 +157,7 @@ enum {
> > >  	/* Any new NFSD_IO enum value must be added at the end */
> > >  	NFSD_IO_BUFFERED,
> > >  	NFSD_IO_DONTCACHE,
> > > +	NFSD_IO_DIRECT,
> > >  };
> > >  
> > >  extern u64 nfsd_io_cache_read __read_mostly;
> > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > index 6e2c8e2aab10..bfd41236aff2 100644
> > > --- a/fs/nfsd/trace.h
> > > +++ b/fs/nfsd/trace.h
> > > @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
> > >  DEFINE_NFSD_IO_EVENT(read_start);
> > >  DEFINE_NFSD_IO_EVENT(read_splice);
> > >  DEFINE_NFSD_IO_EVENT(read_vector);
> > > +DEFINE_NFSD_IO_EVENT(read_direct);
> > >  DEFINE_NFSD_IO_EVENT(read_io_done);
> > >  DEFINE_NFSD_IO_EVENT(read_done);
> > >  DEFINE_NFSD_IO_EVENT(write_start);
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index 35880d3f1326..5cd970c1089b 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> > >  }
> > >  
> > > +/*
> > > + * The byte range of the client's READ request is expanded on both
> > > + * ends until it meets the underlying file system's direct I/O
> > > + * alignment requirements. After the internal read is complete, the
> > > + * byte range of the NFS READ payload is reduced to the byte range
> > > + * that was originally requested.
> > > + *
> > > + * Note that a direct read can be done only when the xdr_buf
> > > + * containing the NFS READ reply does not already have contents in
> > > + * its .pages array. This is due to potentially restrictive
> > > + * alignment requirements on the read buffer. When .page_len and
> > > + * @base are zero, the .pages array is guaranteed to be page-
> > > + * aligned.
> > 
> > This para is confusing.
> > It starts talking about the xdr_buf not having any contents.  Then it
> > transitions to a guarantee of page alignment.
> > 
> > If the start of the read requests isn't sufficiently aligned then a gap
> > will be created in the xdr_buf and that can only be handled at the start
> > (using page_base).
> > 
> > So as you say we need page_len to be zero.  But nowhere in the code is
> > this condition tested.
> > 
> > The closest is "!base" before the call to nfsd_direct_read() but when
> > called from nfsd4_encode_readv()
> > 
> >    base = xdr->buf->page_len & ~PAGE_MASK;
> > 
> > so ->page_len could be non-zero despite base being zero.
> 
> Hi Neil,
> 
> If we verify base is aligned relative to nf->nf_dio_mem_align; this
> incremental change should avoid the concern entirely right?
> 
> [I've verified all my tests pass with this change]

It helps if when testing NFSD you don't have LOCALIO enabled...
please disregard my patch ;)

The patch I provided doesn't work, it'll allow the iov_iter to have
misaligned pages and xfs_file_read_iter->iomap_dio_rw crashes (easily
remedied by checking iov_iter's alignment), but best to just refine
the check that prevents calling into nfsd_direct_read (by explicitly
checking page_len)?

Thanks,
Mike

