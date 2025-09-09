Return-Path: <linux-nfs+bounces-14157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE05B5094F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A6254238E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27B257AC7;
	Tue,  9 Sep 2025 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UlPV2yfS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hujj9UQt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CA225A24
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461054; cv=none; b=SvT4TeDIle7F2UMUhfSKgvflZCElUxv2qhr8jiMJPnu+b6V54rLnhnzvLEoNviQ/OYhhpADfWLeeEJj0nBLDovEPTS8Rx0Fh2+t7N+Tj9F30m9VSagCnczzoEWo5gJ/vbsJ8refVAxTmgR/1wlx/0d0kjbwoWU3BxaLYaPNsCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461054; c=relaxed/simple;
	bh=1Q0xPjEHdaCJfXkAa9OPNb9UjDkbabhQ3XU9EwUEfhc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ft53DMhNh1LzVW4Jqx5XHdzIQbkDl4wy7/7q8cI1O07os4FW1tnItb6yTRJD5fih6luWyIG2qWscCFcDzpsUipA41V/d5eFeA3x5tVno0lxhP3BkFYFEsPuyDbubNd9ZDj/RgoEANJz13P+LfrS5TsYRmE7K8Wl/8cKf0UkAYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UlPV2yfS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hujj9UQt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B24BC1400191;
	Tue,  9 Sep 2025 19:37:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 19:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757461051; x=1757547451; bh=dM09Uax504h67VSJ+akDpkpf97Bdv9qu/X6
	llEd4bps=; b=UlPV2yfSIfCFWjzAchWAFQRfNWedjNUbcjae3FfAPIehEt5rp6Q
	0eGzfuzK/CgpTD6D8CFTQAp5Rnv0X0K1BUAcjs00PExFdWdJ0GbGP6R9htUTIJ0Y
	VAFfInCpZSFSYJtjFUqumAUGYhLopgdDcbQwPK8piFS9/DalLr/iG2JK6+pX1CH8
	73qaoPVMpeKUavV6VDz/DZY7kih87nb4QK1UPVBzQW64pFkOI1Oq4LMTwBHj6H0J
	aoVwrFqOC8uSpIsDPCDVlRNYZkZ+rgH4/ZgN5nDCYUA3Ye8gTK+AJA4fv+uJOVqU
	Yuj3HniX653pnq+zYj67/lgG9O7cYGvVmww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757461051; x=
	1757547451; bh=dM09Uax504h67VSJ+akDpkpf97Bdv9qu/X6llEd4bps=; b=H
	ujj9UQtiY3+MBtwvXCXlqMjKDsRqt02enZQ+lOdHu0YmHZZOHFTxs3t7YH2Oe3I6
	Pk1cj2EHqBuF0hNutH9ib5606sH7CFudHadawadw0w4fNoJ3pN3cAd86YVHohrnX
	z3CLtZj8XfWMXXhIjEliWMkkU3v1kbSqOe9gEfbs4vVCYR2zD26q6/gd6Hg07NIU
	IuB55YbecU6b1H+0v+EqLl5cw6/Cg6wWDwRCJOMxWZbALc7VXkDvrDg2R9Rogqcw
	70s8nwrKcXWyGp3PlrPQEvekLQe1YYmRS36e1w20cCv29p7SclDrqDtkjkANOuQc
	DygI1r7A67mmNBxtANx4A==
X-ME-Sender: <xms:O7rAaINJty-eneoU300zDoqdtiEuouTyW78ikv5y0rYHCEduGF0BOQ>
    <xme:O7rAaL68Zu8-zbmjiSwe0K5Cb3g2QP5q_cedp_6o31rhNlNQxG9XmJeA24N1VUrJ6
    pmblbvbCORyuQ>
X-ME-Received: <xmr:O7rAaK4uYnRsa91L2ga2_Ee_iHVlS9Ti6-hQ2VpzauSonSP6VMBq5gHvKyO114D1rjwxfqljxxeBZsc_SaCWCxz_Wo-cS9kGwMNgBlhgogCm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefurhgjfhffkfesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fhieetveeigeefffelhfdvveeuvefgfffhieevhfdtudffledukedujefhffelueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehsnhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:O7rAaJHCZNjzwPoKF2tcyvn5MzDz_nURUvW5jaENieDOKn27eXoY5w>
    <xmx:O7rAaKUbGaYG-KCyh5nt9LHugzKVasjTzGuuXy9Qo2MlKGQ4Lx_X5g>
    <xmx:O7rAaNVTZlwvs-S42vSf76T9zSWmzQcQzUJCwD6pmXwqskV8YIqm3g>
    <xmx:O7rAaALw8nehrols2dmRV0sjsFMtKzDLJ4osRahu3TjQdnIfRFs6mA>
    <xmx:O7rAaC9UJpe0YWJeRWy0pK2-3RXeAU2afXVD7dEZ873Z8jTBMvgTKY5l>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 19:37:28 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v1 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Reply-to: neil@brown.name
In-reply-to: <20250909190525.7214-4-cel@kernel.org>
References: <20250909190525.7214-1-cel@kernel.org>,
 <20250909190525.7214-4-cel@kernel.org>
Date: Wed, 10 Sep 2025 09:37:27 +1000
Message-id: <175746104715.2850467.8246435920764028613@noble.neil.brown.name>

On Wed, 10 Sep 2025, Chuck Lever wrote:
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
>=20
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
> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfs=
d_dsr_set, "%llu\n");
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
> @@ -1074,6 +1074,79 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
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

Where do we test that this condition is met?

I can see that nfsd_direct_read() is only called if "base" is zero, but
that means the current contents of the .pages array are page-aligned,
not that there are now.

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

I would rather we had an early test rather than a late warn-on.
e.g.
  if (total > (rqstp->rq_maxpages >> PAGE_SHIFT))
     return -EINVAL /* or whatever */;

Otherwise it seems to be making unstated assumptions about how big the
alignment requirements could be.

Thanks,
NeilBrown

> +
> +	trace_nfsd_read_direct(rqstp, fhp, offset, *count);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, dio_end - dio_start);
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
> +		pr_info_ratelimited("nfsd: Unexpected direct I/O alignment failure\n");
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
> @@ -1106,6 +1179,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
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
> --=20
> 2.50.0
>=20
>=20
>=20


