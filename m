Return-Path: <linux-nfs+bounces-14758-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306ABA7ED2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 06:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0763A6045
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 04:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CB11D6BB;
	Mon, 29 Sep 2025 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="My0OovDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktigFw6G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7C14A91
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118577; cv=none; b=p89cUDGjxsmLpuWIR2ATKWNl2X+BQe2Yago3p4lexBPh2rYwzHJYAloewgqzHLeBGq6RS/IOE3ns0mwO/NiDgQNOrgDPN8L8Xg0IZFRuCWZ0W9Uyz89/Dji2B1KIlanLLJYZaZMgkKB97VK+orfp87vJ1mr9Senn8wnK1TiRJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118577; c=relaxed/simple;
	bh=BQd/a3T4wavWW/zm0epG2o4rqSzZ1aWT7QhsjLws9yU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ClRAGbrMNESfZNlEKe69rwxqpsVDDHIgTViSi9edSOXu9jJzV0ZpAAGrKq0IMtBWmYalv68EWoEIoIeqaXEzyrmRfXivra9oSXw5W3MKvjz/Xs/78RP6ygbjiPkogw/ACETUfK+VmVoUqFhfjzD+x8fPYFMFxDQyvpbNsZOq7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=My0OovDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktigFw6G; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 326AF1400079;
	Mon, 29 Sep 2025 00:02:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 29 Sep 2025 00:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759118574; x=1759204974; bh=y+3HRM5k5OYKoMFOpU3I3MArlaeWLzgPsbX
	ZOpf+d9Q=; b=My0OovDwRhYeZnOu4ZdBqduM7yqG5xxOjpqUauaBQxl1Z1QiKq9
	5qiOf65oU/kkPEb6S2+ggYx2gAdbMT0fGbs8RMl/vSahFuu9h8sPrWu9ZffXo5Wi
	uICMTE0oZ35MAO4jI4odV/mbekPJEdoCVNyCqIw5fVO+lvLUOb7SMBGeON4a+p0F
	CuI/BOrEMW32MAdx7jHZDax3jvr3ioJAFQhqKyiNcRhwj16BiDNvFzpF1GEg3EYI
	wU7dT/oVBErlw3PSjLm1bkE/1VtPdiBLeePilno/JBGm0OquaTvWg+Cp4c8mbzQm
	nx4Hb86/Vam9kGGsohsELJgdjS5WZCCPQfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759118574; x=
	1759204974; bh=y+3HRM5k5OYKoMFOpU3I3MArlaeWLzgPsbXZOpf+d9Q=; b=k
	tigFw6GLiejn6g/Y8WcbXEk71/bTa0rLGapQzqpK5vj24U0OzQsy2lnOqfYvMLtx
	wijB1vkQmohb0jXBSbR4aT6isViKGlbMIpAsMoW7dGA7Y/01vNBhi2RgzFDf/2s6
	mRplue4V8HucwI4sDkdmT0F7wzuAGk8OjBwOYn78V7CQcozAGEtH1hA6eAT6wETR
	+ZSIDnHSOjyZrFMBgMt16KC2gsKFG0Yoc9FMYjIveW8iOWASKWT1BHVghHCs808w
	RNe4ONUxU+5fq5ejvpkPLBDVLG7W8NqheO3i44AueWPCOm1Q/okFBPtXQEfgkSW+
	BbTsxtduIyfCmx3u6/kPA==
X-ME-Sender: <xms:7QTaaCJIQJAN4gZX6YOVkEMFM6uHw8aTu84RSOb6TW_hnNHpTt5Npg>
    <xme:7QTaaJM97rU4U8TvuZV2epVgMqMY86inZkQSCewm4cPfRuFsEodky_ujHlVPqric4
    ifvH7c4xs7sGMdHG5ZzsYaq3dV5gpEQpaxzP5lHOlqQHqvalA>
X-ME-Received: <xmr:7QTaaI4H01Iq6jMiPY-XiuFTJ-cOs0R22aW4WmmgN0RQx4ZWUKRxbmAUDABAh9MGeMgsaccMi_uvoW6LGrcDnM2QZmQ7ylg1FeAhjOoy91gP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejjedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehsnhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:7QTaaD7pdGy4A-itwCyjVTTNyuYvt0Y7jrObC8nEXrvJWY2ZKzXAtw>
    <xmx:7QTaaOGRuyiHbs76PW-FpqoZxD12M19438tHyrzFuU6wS4PpGfdxVw>
    <xmx:7QTaaLVAEVd266kk7cCfSQi-tPPVXwO_oSqOb82m74_YBVIvAFYn4w>
    <xmx:7QTaaKV7GrJKoiOE3XEXdzha9Lo8fndxj-Wwjyi_r-hdMyG1nshw1g>
    <xmx:7gTaaBMzbbhEeGk_rGLjVMD3-JcBNnPPl1bjrp3MndLTM6jcoJXwut0p>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 00:02:51 -0400 (EDT)
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
Subject: Re: [PATCH v4 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
In-reply-to: <20250926145151.59941-5-cel@kernel.org>
References: <20250926145151.59941-1-cel@kernel.org>,
 <20250926145151.59941-5-cel@kernel.org>
Date: Mon, 29 Sep 2025 14:02:49 +1000
Message-id: <175911856963.1696783.3580168216222964908@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 27 Sep 2025, Chuck Lever wrote:
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
>  fs/nfsd/debugfs.c |  2 ++
>  fs/nfsd/nfsd.h    |  1 +
>  fs/nfsd/trace.h   |  1 +
>  fs/nfsd/vfs.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+)
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
> index 35880d3f1326..2f12d68e5356 100644
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
> @@ -1106,6 +1182,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  	switch (nfsd_io_cache_read) {
>  	case NFSD_IO_BUFFERED:
>  		break;
> +	case NFSD_IO_DIRECT:
> +		if (nf->nf_dio_read_offset_align &&
> +		    !rqstp->rq_res.page_len && !base)
> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
> +						count, eof);
> +		fallthrough;

Reviewed-by: NeilBrown <neil@brown.name>

This is starting to make sense now - thanks.

However ... It seems that the only reason that 'base' is being passed in
to nfsd_iter_read() is so that it doesn't need to dig around in
rqstp->rq_res to find out what the current page offset is.
But now that we *are* digging around (and even directly setting
page_base etc), maybe there is no point having the 'base' argument.

And I don't think you need to test "!base" above.  If page_len is zero
then "base" (which is rq_res.page_len & ~PAGE_MASK from
nfsd4_encode_readv) must also be zero.  So the extra test is redundant.

Thanks,
NeilBrown


>  	case NFSD_IO_DONTCACHE:
>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
>  			kiocb.ki_flags =3D IOCB_DONTCACHE;
> --=20
> 2.51.0
>=20
>=20


