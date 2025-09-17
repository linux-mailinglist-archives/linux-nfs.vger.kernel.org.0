Return-Path: <linux-nfs+bounces-14546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E3B824D1
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 01:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447067A98D0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 23:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE8312814;
	Wed, 17 Sep 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="pdlvyCS2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oASoLIC1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08EF30C636
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151801; cv=none; b=PB19RtBqhLWj1TV90pAxSm1wXDsdjZbhCsYhDID3+TFSLMbUWlAgzs96riYTXz5lEV4oXkYmaE1gW8m0JsknGdU1QjLEpR5xTwakh/518mM+P8Lako6Q19PNSlaoEBIZL4JCVZietyTOF2hW6wjxIQK+EAWwCas3NMSyDgvTRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151801; c=relaxed/simple;
	bh=SaT2FiLb3zLcQxHqUPlat3xRoMX83xs7GodBHsXm/pU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EhqtdkR7P6EG9A/opakQSqKbtubOv0CLZqLvRGKJrrmi5ZuzXUPqatBMW88N4uTr8S3PkryXdbJJd3KH42K9aN+tw7qaHOidijx9Yuj6Clr1btBX3LeAnC2+JR+kBaABsx50zViumHdNSVN3hwBwPMM7THZ5rWJrmfoab+pFvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=pdlvyCS2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oASoLIC1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3AF81400224;
	Wed, 17 Sep 2025 19:29:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 17 Sep 2025 19:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758151797; x=1758238197; bh=z6BCoulruqGHfIou121x8oOzSTkLKug/FjT
	Axa94rKc=; b=pdlvyCS2xx3iAybzlGkN+JlGN0MxO/2sG4k76WDa2aiBBOxidwC
	4s2r20aR6wXPQZgkSwaAR4tVQjRylr2DkyTmQlpTheDe/Cx7HnIYQmve/50GIlBd
	v0G1bG6R1VcB0+eKAZFVR7Usiead8khMHSsq87r3CDgQbCR37gHqY84i/4u9nuQr
	iWxmPPPkvRCZXGcC37LRw6ycUiEuhz+ibqRVZWxAG0pBkDd0Ftpy5JaD0h//xtu1
	WpOnOF1Y2VNql5H46mTqGY3aE2pjYB/lEDzuAXP9UCIHV/y4I6can1AE3hRrXTZh
	zAOLNt7itETv7EHTe0DLfLaNfx7DPAyAhiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758151797; x=
	1758238197; bh=z6BCoulruqGHfIou121x8oOzSTkLKug/FjTAxa94rKc=; b=o
	ASoLIC1fYCXZ8TNmCxq7UsAQPHf8a8O9mdhuNsSYSEpNhvYbY9ird3KZnXt+01Db
	a5KKq7haOnh3/nZxp9Wq7MkrjBo7TiBT+kce0QN1qse1HMinl+NQW9+zc7Y0as5c
	W1qq+4yOYMkZj/Prj2wBLcAX+mgkzJwh+33YBYNCPyxCHtj1XpcNZ9ZSQXTBF91q
	sKTAkrF79obkdm/5i3f/AlSViADUVtVXIkl1UM9gt4Tb9zQ8UtVAgaI0xOuPSYQY
	nmyiHOc3wzqtmr8mXvR5CoyhnmM5tRUnEy+Wy6VV1Wq9Va5cZqEP2zVHNL6eDXIS
	cqs41TDktFYidIUihYq8g==
X-ME-Sender: <xms:dUTLaMtQOz6uCbiyeC-lN6EJQHjjVBpzOz4Jzdak_Xa-YnPojBRU5Q>
    <xme:dUTLaB4jv5fj95QRGx8_za8v18kAhruMMCgfpnPMykcgeGp9CL0D9EqgtqwPZfHwU
    oFanCySv1VscQ>
X-ME-Received: <xmr:dUTLaINXhJ10vYpiNDyb2PONVuueLHSTbLhs88Dfdrfl6xT7b9TBb3uXSFThITXYv4O8YSY8mKWKI_yJP5X3-nQxJEpWuMjunOIOjTppzWAq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptgfgggfhvfevufgjfhffkfhrsehtqhertd
    dttdejnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesohifnhhmrghilhdr
    nhgvtheqnecuggftrfgrthhtvghrnhepleejtdefgeeukeeiteduveehudevfeffvedute
    fgteduhfegvdfgtdeigeeuudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghpth
    htohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnhhfshes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgvhidrtg
    homhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dUTLaPvDMqWuKoT4UJe6Kyw-M7BktRx9cOEqRXaBoLJHy8OLRCYCWA>
    <xmx:dUTLaLYSRdf1Ngv3sMUQKwxGQfSguh_uBv7ZU_4bWA3mveM9cfKqTQ>
    <xmx:dUTLaBzyCNlopM6GnbNB2rrSa89RvdXWS5DBxB3iegaGl2ivESm6fQ>
    <xmx:dUTLaDhC8uoPoY8oeqB2vvN6lDP1jVHKUisaA_zaxy6jHpkEHMWBIA>
    <xmx:dUTLaN6PEtsw8P2KZ1AkKvLrkQlG6ocEzXjoA_Hgj2-BxHXeq85BWBaT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 19:29:55 -0400 (EDT)
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
Cc: jlayton@kernel.org, okorniev@redhat.com, dai.ngo@oracle.com,
 tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
In-reply-to: =?utf-8?q?=3C175811952039=2E19474=2E5813875056701985362=2Estgit?=
 =?utf-8?q?=4091=2E116=2E238=2E104=2Ehost=2Esecureserver=2Enet=3E?=
References: =?utf-8?q?=3C175811882632=2E19474=2E8126763744508709520=2Estgit?=
 =?utf-8?b?QDkxLjExNi4yMzguMTA0Lmhvc3Quc2VjdXJlc2VydmVyLm5ldD4sIDwxNzU4?=
 =?utf-8?q?11952039=2E19474=2E5813875056701985362=2Estgit=4091=2E116=2E238?=
 =?utf-8?q?=2E104=2Ehost=2Esecureserver=2Enet=3E?=
Date: Thu, 18 Sep 2025 09:29:48 +1000
Message-id: <175815178827.1696783.10535533600809037950@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 18 Sep 2025, Chuck Lever wrote:
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
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c |    2 +
>  fs/nfsd/nfsd.h    |    1 +
>  fs/nfsd/trace.h   |    1 +
>  fs/nfsd/vfs.c     |   81 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>  4 files changed, 85 insertions(+)
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
> index 6e2c8e2aab10..bfd41236aff2 100644
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
> index 35880d3f1326..5cd970c1089b 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, stru=
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

This para is confusing.
It starts talking about the xdr_buf not having any contents.  Then it
transitions to a guarantee of page alignment.

If the start of the read requests isn't sufficiently aligned then a gap
will be created in the xdr_buf and that can only be handled at the start
(using page_base).

So as you say we need page_len to be zero.  But nowhere in the code is
this condition tested.

The closest is "!base" before the call to nfsd_direct_read() but when
called from nfsd4_encode_readv()

   base =3D xdr->buf->page_len & ~PAGE_MASK;

so ->page_len could be non-zero despite base being zero.

NeilBrown


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
> +	total =3D *count;
> +	while (total && v < rqstp->rq_maxpages &&
> +	       rqstp->rq_next_page < rqstp->rq_page_end) {
> +		len =3D min_t(size_t, total, PAGE_SIZE);
> +		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> +			      len, 0);
> +
> +		total -=3D len;
> +		++rqstp->rq_next_page;
> +		++v;
> +	}
> +
> +	trace_nfsd_read_direct(rqstp, fhp, offset, *count - total);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v,
> +		      dio_end - dio_start - total);
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
> @@ -1106,6 +1182,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct=
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
>=20
>=20
>=20


