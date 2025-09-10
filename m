Return-Path: <linux-nfs+bounces-14161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B3AB50A89
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 03:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56683A68A0
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042C34CDD;
	Wed, 10 Sep 2025 01:52:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22A2033A
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469164; cv=none; b=IXcElyVNqnwX1mG06u/10EMxXrmBF2yHIeVbihuRJze7XNcUExcK8oEEmJpmqPKLUcN5rDbZ/UzNgkgTuIS0mJ6DKgKOJlDoIULx0o+z6bZcPlerD3dnTqeH5On13f2OM4LlWogxfVTblMrmS+Gup63G7rbHezrvg002CkRXQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469164; c=relaxed/simple;
	bh=itmq43Wqd5oKe5zhpbUzW+AGeppDZxFU36jJmZhjhd8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aWLjawUviiq+neDCJJZgcnck7IhAtPHxDi00DXLTuy9YRXXUBd7ARk0sjLkvyLJp3MJpF5BmYnaX6JpsH4trFmGFynWuaV9Bn4RAd4xDeQa78IxEAjsEPVx/xw4L0gmcaFRdFRi+cLpvYqZp2RW+sdBobxw+ilpfIpMjWmeTUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uwA0i-008tV9-JD;
	Wed, 10 Sep 2025 01:52:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v1 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
In-reply-to: <bb2c9e28-fc38-4990-b881-b652bcccd405@kernel.org>
References: <>, <bb2c9e28-fc38-4990-b881-b652bcccd405@kernel.org>
Date: Wed, 10 Sep 2025 11:52:38 +1000
Message-id: <175746915802.2850467.11582824964664652427@noble.neil.brown.name>

On Wed, 10 Sep 2025, Chuck Lever wrote:
> On 9/9/25 7:37 PM, NeilBrown wrote:
> > On Wed, 10 Sep 2025, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Add an experimental option that forces NFS READ operations to use
> >> direct I/O instead of reading through the NFS server's page cache.
> >>
> >> There are already other layers of caching:
> >>  - The page cache on NFS clients
> >>  - The block device underlying the exported file system
> >>
> >> The server's page cache, in many cases, is unlikely to provide
> >> additional benefit. Some benchmarks have demonstrated that the
> >> server's page cache is actively detrimental for workloads whose
> >> working set is larger than the server's available physical memory.
> >>
> >> For instance, on small NFS servers, cached NFS file content can
> >> squeeze out local memory consumers. For large sequential workloads,
> >> an enormous amount of data flows into and out of the page cache
> >> and is consumed by NFS clients exactly once -- caching that data
> >> is expensive to do and totally valueless.
> >>
> >> For now this is a hidden option that can be enabled on test
> >> systems for benchmarking. In the longer term, this option might
> >> be enabled persistently or per-export. When the exported file
> >> system does not support direct I/O, NFSD falls back to using
> >> either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> >>
> >> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/nfsd/debugfs.c |  2 ++
> >>  fs/nfsd/nfsd.h    |  1 +
> >>  fs/nfsd/trace.h   |  1 +
> >>  fs/nfsd/vfs.c     | 78 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 82 insertions(+)
> >>
> >> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> >> index ed2b9e066206..00eb1ecef6ac 100644
> >> --- a/fs/nfsd/debugfs.c
> >> +++ b/fs/nfsd/debugfs.c
> >> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, =
nfsd_dsr_set, "%llu\n");
> >>   * Contents:
> >>   *   %0: NFS READ will use buffered IO
> >>   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> >> + *   %2: NFS READ will use direct IO
> >>   *
> >>   * This setting takes immediate effect for all NFS versions,
> >>   * all exports, and in all NFSD net namespaces.
> >> @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
> >>  		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
> >>  		break;
> >>  	case NFSD_IO_DONTCACHE:
> >> +	case NFSD_IO_DIRECT:
> >>  		/*
> >>  		 * Must disable splice_read when enabling
> >>  		 * NFSD_IO_DONTCACHE.
> >> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >> index ea87b42894dd..bdb60ee1f1a4 100644
> >> --- a/fs/nfsd/nfsd.h
> >> +++ b/fs/nfsd/nfsd.h
> >> @@ -157,6 +157,7 @@ enum {
> >>  	/* Any new NFSD_IO enum value must be added at the end */
> >>  	NFSD_IO_BUFFERED,
> >>  	NFSD_IO_DONTCACHE,
> >> +	NFSD_IO_DIRECT,
> >>  };
> >> =20
> >>  extern u64 nfsd_io_cache_read __read_mostly;
> >> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> >> index e5af0d058fd0..88901df5fbb1 100644
> >> --- a/fs/nfsd/trace.h
> >> +++ b/fs/nfsd/trace.h
> >> @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
> >>  DEFINE_NFSD_IO_EVENT(read_start);
> >>  DEFINE_NFSD_IO_EVENT(read_splice);
> >>  DEFINE_NFSD_IO_EVENT(read_vector);
> >> +DEFINE_NFSD_IO_EVENT(read_direct);
> >>  DEFINE_NFSD_IO_EVENT(read_io_done);
> >>  DEFINE_NFSD_IO_EVENT(read_done);
> >>  DEFINE_NFSD_IO_EVENT(write_start);
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> index 441267d877f9..9665454743eb 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -1074,6 +1074,79 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
> >>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err=
);
> >>  }
> >> =20
> >> +/*
> >> + * The byte range of the client's READ request is expanded on both
> >> + * ends until it meets the underlying file system's direct I/O
> >> + * alignment requirements. After the internal read is complete, the
> >> + * byte range of the NFS READ payload is reduced to the byte range
> >> + * that was originally requested.
> >> + *
> >> + * Note that a direct read can be done only when the xdr_buf
> >> + * containing the NFS READ reply does not already have contents in
> >> + * its .pages array. This is due to potentially restrictive
> >> + * alignment requirements on the read buffer. When .page_len and
> >> + * @base are zero, the .pages array is guaranteed to be page-
> >> + * aligned.
> >=20
> > Where do we test that this condition is met?
> >=20
> > I can see that nfsd_direct_read() is only called if "base" is zero, but
> > that means the current contents of the .pages array are page-aligned,
> > not that there are now.
> >=20
> >> + */
> >> +static noinline_for_stack __be32
> >> +nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >> +		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
> >> +		 u32 *eof)
> >> +{
> >> +	loff_t dio_start, dio_end;
> >> +	unsigned long v, total;
> >> +	struct iov_iter iter;
> >> +	struct kiocb kiocb;
> >> +	ssize_t host_err;
> >> +	size_t len;
> >> +
> >> +	init_sync_kiocb(&kiocb, nf->nf_file);
> >> +	kiocb.ki_flags |=3D IOCB_DIRECT;
> >> +
> >> +	/* Read a properly-aligned region of bytes into rq_bvec */
> >> +	dio_start =3D round_down(offset, nf->nf_dio_read_offset_align);
> >> +	dio_end =3D round_up(offset + *count, nf->nf_dio_read_offset_align);
> >> +
> >> +	kiocb.ki_pos =3D dio_start;
> >> +
> >> +	v =3D 0;
> >> +	total =3D dio_end - dio_start;
> >> +	while (total) {
> >> +		len =3D min_t(size_t, total, PAGE_SIZE);
> >> +		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> >> +			      len, 0);
> >> +		total -=3D len;
> >> +		++v;
> >> +	}
> >> +	WARN_ON_ONCE(v > rqstp->rq_maxpages);
> >=20
> > I would rather we had an early test rather than a late warn-on.
> > e.g.
> >   if (total > (rqstp->rq_maxpages >> PAGE_SHIFT))
> >      return -EINVAL /* or whatever */;
> >=20
> > Otherwise it seems to be making unstated assumptions about how big the
> > alignment requirements could be.
>=20
> This is the same warn-on test that nfsd_iter_read does for buffered and
> dontcache reads. It's done late because the final value of v is computed
> here, not known before the loop.

True, but in this case "total" could be larger than "*count" which was
size-checked in e.g.  nfsd4_encode_read.  So it could now be larger than
the available space.

>=20
> I think we might be able to turn this into a short read, for all I/O
> modes?

Yes, that could be a clean way to handle the unlikely case that the
reads doesn't fit any more.

Thanks,
NeilBrown

>=20
>=20
> > Thanks,
> > NeilBrown
> >=20
> >> +
> >> +	trace_nfsd_read_direct(rqstp, fhp, offset, *count);
> >> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, dio_end - dio_start=
);
> >> +
> >> +	host_err =3D vfs_iocb_iter_read(nf->nf_file, &kiocb, &iter);
> >> +	if (host_err >=3D 0) {
> >> +		unsigned int pad =3D offset - dio_start;
> >> +
> >> +		/* The returned payload starts after the pad */
> >> +		rqstp->rq_res.page_base =3D pad;
> >> +
> >> +		/* Compute the count of bytes to be returned */
> >> +		if (host_err > pad + *count) {
> >> +			host_err =3D *count;
> >> +		} else if (host_err > pad) {
> >> +			host_err -=3D pad;
> >> +		} else {
> >> +			host_err =3D 0;
> >> +		}
> >> +	} else if (unlikely(host_err =3D=3D -EINVAL)) {
> >> +		pr_info_ratelimited("nfsd: Unexpected direct I/O alignment failure\n"=
);
> >> +		host_err =3D -ESERVERFAULT;
> >> +	}
> >> +
> >> +	return nfsd_finish_read(rqstp, fhp, nf->nf_file, offset, count,
> >> +				eof, host_err);
> >> +}
> >> +
> >>  /**
> >>   * nfsd_iter_read - Perform a VFS read using an iterator
> >>   * @rqstp: RPC transaction context
> >> @@ -1106,6 +1179,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
> >>  	switch (nfsd_io_cache_read) {
> >>  	case NFSD_IO_BUFFERED:
> >>  		break;
> >> +	case NFSD_IO_DIRECT:
> >> +		if (nf->nf_dio_read_offset_align && !base)
> >> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> >> +						count, eof);
> >> +		fallthrough;
> >>  	case NFSD_IO_DONTCACHE:
> >>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
> >>  			kiocb.ki_flags =3D IOCB_DONTCACHE;
> >> --=20
> >> 2.50.0
> >>
> >>
> >>
> >=20
>=20
>=20
> --=20
> Chuck Lever
>=20


