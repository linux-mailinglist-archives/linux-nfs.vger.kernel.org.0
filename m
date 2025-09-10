Return-Path: <linux-nfs+bounces-14170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A5BB515E4
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 13:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282A91C811C2
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0776B283C87;
	Wed, 10 Sep 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na1KPN9/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A00239E7D
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504225; cv=none; b=Ih3HZGy1hYqcQ+KydVGp7CzUQZXpJsvWnkdW+b0baUK3/0VYD5Iv5eR3BJdC7utA76R1ZlA1SKsvP9pt1arkjxg/lodQtCwzuft8fjRCOPtETPk3hdXw5XCxTyS6iVKobk1XLJZTqLaxRTOtR/01Zo/l+wRvagK9azmKCvT4fmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504225; c=relaxed/simple;
	bh=D2olJUciKC5Du8CAaVaQKhMudJ5nnQH4Wu3BxdUzGc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UfoNu+NBRFQh6L4q3+Jdj8a/05MCy5fTmBSIQiC76HjIfugZnb8ap+fRQWM0BP5yGdnNopAARSDizN0HgWAX8KDUq2zlUBDRlFa9CMk4Zp+27ySCJzYD0KsAETecC7BJIo/h44HBsLkUf8hV8AJgHohIy6wYDdZD1SKxUbvct/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na1KPN9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BE8C4CEF0;
	Wed, 10 Sep 2025 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757504225;
	bh=D2olJUciKC5Du8CAaVaQKhMudJ5nnQH4Wu3BxdUzGc4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=na1KPN9/BvkDhu7S6YNNvSYLN6XDO5HDFpxS2sfbxFZ27oIf7zb2Fpr7VzpdXG4x2
	 zMJg6ONvg5wyNmmB/nylXeuZgMH0sK22njCmOfEOafN6fLJ1bA0OaT4CQd94YVAdoX
	 fr6asNQMVx8MvWhfDsEGQrHdEOiB+H0LZuFsvKjMHa5dWp2nXqyQshdQqodmz3xR3p
	 Isu76IGRhjSs79iD9dr0cXcVCoJKn3rWsEsrQxaZNnARPszpNN6PnJK0S9Ecr5Te0+
	 OghoML3Cu5T/GZSTcxkcal1sQX1/4Pmyb/JY6IAG9aGQpxheaKMdT4FB3w0Z2ohwNI
	 bK6mnEaTtXNnQ==
Message-ID: <cf95dd055906b1d26a4fb26356157499cff9c817.camel@kernel.org>
Subject: Re: [PATCH v1 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, Mike
 Snitzer <snitzer@kernel.org>
Date: Wed, 10 Sep 2025 07:37:03 -0400
In-Reply-To: <20250909190525.7214-4-cel@kernel.org>
References: <20250909190525.7214-1-cel@kernel.org>
	 <20250909190525.7214-4-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-09 at 15:05 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Add an experimental option that forces NFS READ operations to use
> direct I/O instead of reading through the NFS server's page cache.
>=20
> There are already other layers of caching:
>  - The page cache on NFS clients
>  - The block device underlying the exported file system
>=20
> The server's page cache, in many cases, is unlikely to provide
> additional benefit. Some benchmarks have demonstrated that the
> server's page cache is actively detrimental for workloads whose
> working set is larger than the server's available physical memory.
>=20
> For instance, on small NFS servers, cached NFS file content can
> squeeze out local memory consumers. For large sequential workloads,
> an enormous amount of data flows into and out of the page cache
> and is consumed by NFS clients exactly once -- caching that data
> is expensive to do and totally valueless.
>=20
> For now this is a hidden option that can be enabled on test
> systems for benchmarking. In the longer term, this option might
> be enabled persistently or per-export. When the exported file
> system does not support direct I/O, NFSD falls back to using
> either DONTCACHE or buffered I/O to fulfill NFS READ requests.

> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c |  2 ++
>  fs/nfsd/nfsd.h    |  1 +
>  fs/nfsd/trace.h   |  1 +
>  fs/nfsd/vfs.c     | 78 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 82 insertions(+)
>=20
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index ed2b9e066206..00eb1ecef6ac 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, n=
fsd_dsr_set, "%llu\n");
>   * Contents:
>   *   %0: NFS READ will use buffered IO
>   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> + *   %2: NFS READ will use direct IO
>   *
>   * This setting takes immediate effect for all NFS versions,
>   * all exports, and in all NFSD net namespaces.
> @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
>  		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
>  		break;
>  	case NFSD_IO_DONTCACHE:
> +	case NFSD_IO_DIRECT:
>  		/*
>  		 * Must disable splice_read when enabling
>  		 * NFSD_IO_DONTCACHE.
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index ea87b42894dd..bdb60ee1f1a4 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -157,6 +157,7 @@ enum {
>  	/* Any new NFSD_IO enum value must be added at the end */
>  	NFSD_IO_BUFFERED,
>  	NFSD_IO_DONTCACHE,
> +	NFSD_IO_DIRECT,
>  };
> =20
>  extern u64 nfsd_io_cache_read __read_mostly;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index e5af0d058fd0..88901df5fbb1 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
>  DEFINE_NFSD_IO_EVENT(read_start);
>  DEFINE_NFSD_IO_EVENT(read_splice);
>  DEFINE_NFSD_IO_EVENT(read_vector);
> +DEFINE_NFSD_IO_EVENT(read_direct);
>  DEFINE_NFSD_IO_EVENT(read_io_done);
>  DEFINE_NFSD_IO_EVENT(read_done);
>  DEFINE_NFSD_IO_EVENT(write_start);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 441267d877f9..9665454743eb 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1074,6 +1074,79 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err)=
;
>  }
> =20
> +/*
> + * The byte range of the client's READ request is expanded on both
> + * ends until it meets the underlying file system's direct I/O
> + * alignment requirements. After the internal read is complete, the
> + * byte range of the NFS READ payload is reduced to the byte range
> + * that was originally requested.
> + *
> + * Note that a direct read can be done only when the xdr_buf
> + * containing the NFS READ reply does not already have contents in
> + * its .pages array. This is due to potentially restrictive
> + * alignment requirements on the read buffer. When .page_len and
> + * @base are zero, the .pages array is guaranteed to be page-
> + * aligned.
> + */
> +static noinline_for_stack __be32
> +nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
> +		 u32 *eof)
> +{
> +	loff_t dio_start, dio_end;
> +	unsigned long v, total;
> +	struct iov_iter iter;
> +	struct kiocb kiocb;
> +	ssize_t host_err;
> +	size_t len;
> +
> +	init_sync_kiocb(&kiocb, nf->nf_file);
> +	kiocb.ki_flags |=3D IOCB_DIRECT;
> +
> +	/* Read a properly-aligned region of bytes into rq_bvec */
> +	dio_start =3D round_down(offset, nf->nf_dio_read_offset_align);
> +	dio_end =3D round_up(offset + *count, nf->nf_dio_read_offset_align);
> +
> +	kiocb.ki_pos =3D dio_start;
> +
> +	v =3D 0;
> +	total =3D dio_end - dio_start;
> +	while (total) {
> +		len =3D min_t(size_t, total, PAGE_SIZE);
> +		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> +			      len, 0);
> +		total -=3D len;
> +		++v;
> +	}
> +	WARN_ON_ONCE(v > rqstp->rq_maxpages);
> +
> +	trace_nfsd_read_direct(rqstp, fhp, offset, *count);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, dio_end - dio_start)=
;
> +
> +	host_err =3D vfs_iocb_iter_read(nf->nf_file, &kiocb, &iter);
> +	if (host_err >=3D 0) {
> +		unsigned int pad =3D offset - dio_start;
> +
> +		/* The returned payload starts after the pad */
> +		rqstp->rq_res.page_base =3D pad;
> +
> +		/* Compute the count of bytes to be returned */
> +		if (host_err > pad + *count) {
> +			host_err =3D *count;
> +		} else if (host_err > pad) {
> +			host_err -=3D pad;
> +		} else {
> +			host_err =3D 0;
> +		}
> +	} else if (unlikely(host_err =3D=3D -EINVAL)) {
> +		pr_info_ratelimited("nfsd: Unexpected direct I/O alignment failure\n")=
;
> +		host_err =3D -ESERVERFAULT;
> +	}
> +
> +	return nfsd_finish_read(rqstp, fhp, nf->nf_file, offset, count,
> +				eof, host_err);
> +}
> +
>  /**
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
> @@ -1106,6 +1179,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  	switch (nfsd_io_cache_read) {
>  	case NFSD_IO_BUFFERED:
>  		break;
> +	case NFSD_IO_DIRECT:
> +		if (nf->nf_dio_read_offset_align && !base)
> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> +						count, eof);
> +		fallthrough;
>  	case NFSD_IO_DONTCACHE:
>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
>  			kiocb.ki_flags =3D IOCB_DONTCACHE;

This looks fine:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

Since this is a "hidden" option, it may also be a good idea to add a
pr_info that pops when someone enables it. Then if we get a bug report
involving this later, that would at least show up in the log.

