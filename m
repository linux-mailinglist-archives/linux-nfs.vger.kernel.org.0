Return-Path: <linux-nfs+bounces-14567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD5B855D2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 16:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D451C07F89
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053DB221294;
	Thu, 18 Sep 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7Pn2ghS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497C21FF24
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207060; cv=none; b=CPu83ZALLKQMFR3p63Wf8rZg8eZ6XKcZRNnNljYyUKylo41A0lQlJ+F3HyYhn/I3iEqyqtn8g26MjyR4W8BLecj2jrloFZUIHqlsde8rcExezCytOczFO/+HtP6anRUBnakMRbfTsNLj7swFywp4Q175whXgWDGNttN8mZH36SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207060; c=relaxed/simple;
	bh=TaONpgWhMHQNJ2JE2TJI5Gh51O6PIrVwjKatytEKdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwY3l89hPlLG8gr9MPQJvxUSEU+yj3Z+uLkUz4p0EF4EEt+sH/yNVrGtR6o72iGZiqodw3PmoCVm8pNy9qvrwSjyCKT5cNr94aGRZRRzOpMtKqltWTkt7LSbnsXSakIdYLOwXlhgohcmOP/+9HUWRpFTDAG3kfqkTKDsHqaqrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7Pn2ghS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE6AC4CEE7;
	Thu, 18 Sep 2025 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207060;
	bh=TaONpgWhMHQNJ2JE2TJI5Gh51O6PIrVwjKatytEKdPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7Pn2ghSrviTsNlSkKzHy/uX1jCtFC3VnAMERHjPzeXA9H9pQNTo2yIuiZezXUwj3
	 ojno2ve2zwavgjbrsNVUldwYkNzf1s9H25sBfPFvWiEoBo2GtGC3TxeEqPKMNZhDk3
	 VchXlfnpugO+uCso0BJTcjDhIR3icBGk5lTWjh9MuRkyTVNOgoLcJBafViOu9IwFzm
	 HqbvThimISx4Er0d8PZQyrGKAJWQbfRK9kgRMV+3xObSpuBul87VBfJBICVZx9iRJY
	 em54vV7ZUiTp/58mk9SjbT/1LwLUUgILxqOCE7S/ZX6H7Y0Is13Ucy9xNaVtVJ7Nu3
	 hesoEaNtpkM7A==
Date: Thu, 18 Sep 2025 10:50:57 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <cel@kernel.org>, jlayton@kernel.org, okorniev@redhat.com,
	dai.ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aMwcUdWdey69k2iK@kernel.org>
References: <175815178827.1696783.10535533600809037950@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175815178827.1696783.10535533600809037950@noble.neil.brown.name>

On Thu, Sep 18, 2025 at 09:29:48AM +1000, NeilBrown wrote:
> On Thu, 18 Sep 2025, Chuck Lever wrote:
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
> > Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/debugfs.c |    2 +
> >  fs/nfsd/nfsd.h    |    1 +
> >  fs/nfsd/trace.h   |    1 +
> >  fs/nfsd/vfs.c     |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 85 insertions(+)
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
> > index 6e2c8e2aab10..bfd41236aff2 100644
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
> > index 35880d3f1326..5cd970c1089b 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
> This para is confusing.
> It starts talking about the xdr_buf not having any contents.  Then it
> transitions to a guarantee of page alignment.
> 
> If the start of the read requests isn't sufficiently aligned then a gap
> will be created in the xdr_buf and that can only be handled at the start
> (using page_base).
> 
> So as you say we need page_len to be zero.  But nowhere in the code is
> this condition tested.
> 
> The closest is "!base" before the call to nfsd_direct_read() but when
> called from nfsd4_encode_readv()
> 
>    base = xdr->buf->page_len & ~PAGE_MASK;
> 
> so ->page_len could be non-zero despite base being zero.

Hi Neil,

If we verify base is aligned relative to nf->nf_dio_mem_align; this
incremental change should avoid the concern entirely right?

[I've verified all my tests pass with this change]
[Chuck, please feel free to fold this in if you agree]

Signed-off-by: Mike Snitzer <snitzer@kernel.org>

 fs/nfsd/vfs.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4694a26238c7..d21b4fb565a6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1088,18 +1088,11 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * alignment requirements. After the internal read is complete, the
  * byte range of the NFS READ payload is reduced to the byte range
  * that was originally requested.
- *
- * Note that a direct read can be done only when the xdr_buf
- * containing the NFS READ reply does not already have contents in
- * its .pages array. This is due to potentially restrictive
- * alignment requirements on the read buffer. When .page_len and
- * @base are zero, the .pages array is guaranteed to be page-
- * aligned.
  */
 static noinline_for_stack __be32
 nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
-		 u32 *eof)
+		 unsigned int base, u32 *eof)
 {
 	loff_t dio_start, dio_end;
 	unsigned long v, total;
@@ -1121,13 +1114,14 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	total = *count;
 	while (total && v < rqstp->rq_maxpages &&
 	       rqstp->rq_next_page < rqstp->rq_page_end) {
-		len = min_t(size_t, total, PAGE_SIZE);
+		len = min_t(size_t, total, PAGE_SIZE - base);
 		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
-			      len, 0);
+			      len, base);
 
 		total -= len;
 		++rqstp->rq_next_page;
 		++v;
+		base = 0;
 	}
 
 	trace_nfsd_read_direct(rqstp, fhp, offset, *count - total);
@@ -1191,9 +1185,10 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case NFSD_IO_BUFFERED:
 		break;
 	case NFSD_IO_DIRECT:
-		if (nf->nf_dio_read_offset_align && !base)
+		if (nf->nf_dio_read_offset_align && nf->nf_dio_mem_align &&
+		    (base & (nf->nf_dio_mem_align-1)) == 0)
 			return nfsd_direct_read(rqstp, fhp, nf, offset,
-						count, eof);
+						count, base, eof);
 		fallthrough;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)

