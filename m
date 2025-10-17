Return-Path: <linux-nfs+bounces-15348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D49BEBFD9
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 01:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12C364E281E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 23:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A86354AE7;
	Fri, 17 Oct 2025 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="n/WI5H5V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CuVKDYqI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4C2494F0
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743449; cv=none; b=p099NUln5GayZuURgQW4rcSTHzKEqj5FfGNR2wyZ6FbszIHJXM/z208sg63gksSbDTNUl/67b2qsMQq+CsCU9KfeXw2UA0y4qY9S47H9eMr/2HLfJLyjdVs7AkB3ieoMdMQT8Q1VgHc2IhCiewqS2GJdnGPlaszLXX3XsEjw8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743449; c=relaxed/simple;
	bh=KP4HGeX7Vr+Dyu2SvHwe+PM2xho2+iVCKF83HVixtEk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LHEdL2j940PoYXngzQFI2XqQJHZ9DegOLo8QDCFUFnB92TmTAv3z8TU43U7rJxU0Y4FZHG8kv0kz7NoJj4vEUyhbuM6eHYp96IZgf+WGr+46E9yWHDfpAPFKMuHKNJlcX7d9t0EewqzWr/x1g5EbgEdceeMLZ+ANqhLEhfyYaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=n/WI5H5V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CuVKDYqI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B8CF91400112;
	Fri, 17 Oct 2025 19:24:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Oct 2025 19:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760743443; x=1760829843; bh=Dd/6rfOtEFsgG7igaMLSvuJ62pm/AyBb7+b
	ArBGMt84=; b=n/WI5H5V8GKjmpZq0RZCqY1HPZMLiuyJtn15VCwMfTVskt6XScH
	Se6DQYEjLkQiL+fyAX75tcPpebXyCLRaiD8dRs+gZUImgIvRPkB/SDeR7sb3rENR
	T/Dwz7Ww4+McXQIDwYBRPrMUU4RjrYKmu8cl4hEZ7fArY7RrXPG9e98NFsMsO/8y
	zMWEUAt+VQJ1LztgFZhkY8WeyeSauPLkM85EhDpGw3mOFtrw7VSA1AMNbXAnut83
	E6VIVVxWDmhUT1mHIkXiINKHru6yhbKIx238xJX8JdDIcdZ8gET+N/oUXn4xj3ek
	Nsa+YcRYqpcrLDtIQWsurqk4XeP11OI+T9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760743443; x=
	1760829843; bh=Dd/6rfOtEFsgG7igaMLSvuJ62pm/AyBb7+bArBGMt84=; b=C
	uVKDYqIVxaZDjhwY43tbiK6oj1wqCrR/sqD2POkphWPH/1Tlt0dYJ+S8QYHZNSsI
	5G+VqLwgx1HxV88iPfMbyHvTk7v0vCA7da0kkM1hx02TSep6mcyquKRJyaX9svHB
	7N/DqO3Xv0ct7mLU3tRw/hozpzxQEH1+94N3mItGc09r8Abg8K6rdiu7ARrWmQvV
	zO4cxVBKvUF4Z48FIiZ5SD3L3I1v+2qIzqp/jZcXWqNfnLmuOzA3YExZixz9bBRn
	WZ7mYyJY5+0XOOjVtVBsVd80wBe+TTWnMJc7048yYj9PgP4pWhk0KhBupvURUaiz
	jrSAhhnRS75AI5D1tHU2g==
X-ME-Sender: <xms:E9DyaGC7NgOZZYdR0EbHoqj1tVB6VJgxWjdgbpysu5W0FOLiKqwdFw>
    <xme:E9DyaPkCjxUbTy8SwJfk4iCVTOQsy3RnzjiEELlYUwYZj8cSeb6NCDK39_kCSmVrx
    ErxxGoeMKutVSZVlQEDpIkYpv1dAHgirCGQ4osM9ErTa4_zfw>
X-ME-Received: <xmr:E9DyaPy3qOmZsSCG3ELM7JjdXuYz3QaYWN31jAUrFsdP4uxbSyUZ_Kg3GAIV4OCRQpOIYDCYuOrpE0L-PDfNL4E2GAr2ucdGppqw_X383mNj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:E9DyaBTcW6saUnQiJuz20u1rVzWH_imTYQoVjmhPa285gRz3dQn5pA>
    <xmx:E9DyaP86heBFU77rzpC7z4B2R08z4P8-nGG7TV5sAhm3dE-RLqxklg>
    <xmx:E9DyaHs2h7EvPL4jPiqzxTKszXv48Bn700DxWiZAApGJrDKv1VrQ5A>
    <xmx:E9DyaPMErHc47wksg_7m-sd2mk0ec3LiZtnn8n3yPP7tGAtlfBUUBw>
    <xmx:E9DyaAF57P8OAA7teBGG2Sidb98p_NJjsWBBGlqRffHJxCEcHsWl6Mnr>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 19:24:00 -0400 (EDT)
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
Cc: "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
In-reply-to: <2e353615-bb40-437b-83ea-e541493f026c@kernel.org>
References: <20251013190113.252097-1-cel@kernel.org>,
 <aPAci7O_XK1ljaum@kernel.org>,
 <2e353615-bb40-437b-83ea-e541493f026c@kernel.org>
Date: Sat, 18 Oct 2025 10:23:58 +1100
Message-id: <176074343899.1793333.5898199588218491717@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 18 Oct 2025, Chuck Lever wrote:
> On 10/15/25 6:13 PM, Mike Snitzer wrote:
> > If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> > middle and end as needed. The large middle extent is DIO-aligned and
> > the start and/or end are misaligned. Synchronous buffered IO (with
> > preference towards using DONTCACHE) is used for the misaligned extents
> > and O_DIRECT is used for the middle DIO-aligned extent.
> >=20
> > nfsd_issue_write_dio() promotes @stable_how to NFS_FILE_SYNC, which
> > allows the client to drop its dirty data and avoid needing an extra
> > COMMIT operation.
> >=20
> > If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
> > invalidate the page cache on behalf of the DIO WRITE, then
> > nfsd_issue_write_dio() will fall back to using buffered IO.
> >=20
> > These changes served as the original starting point for the NFS
> > client's misaligned O_DIRECT support that landed with commit
> > c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and
> > WRITE"). But NFSD's support is simpler because it currently doesn't
> > use AIO completion.
> >=20
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>=20
> Handful of nits, and one interesting question. Please send a v4 to
> address the two comment issues below.
>=20
> Question: How is NFSD supposed to act if the administrator sets the
> async export option and NFSD_IO_DIRECT at the same time?
>=20
> - Direct I/O dispatched but not waited for ?

You have to wait for direct I/O.  The caller owns the memory and has to
wait for the IO path to finish using it.

>=20
> - Fall back to DONTCACHE ?
>=20
> - Ignore the async setting (that's what it appears to do now) ?

I think this is the only sensible approach.  If we one day are a more
formal mechanism for enabling direct IO, then we can discuss and
document the interplace with other export options, but while it ia
debugfs setting, I don't think there is any needs for subtlety.

Thanks,
NeilBrown


>=20
> - Something else ?
>=20
> IMO async + DIRECT seems like a disaster waiting to happen. It should
> be pretty easy to push the NFS server over a cliff because there is no
> connection between clients submitting writes and data getting persisted.
> Dirty data will just pile up in the server's memory because it can't get
> flushed fast enough.
>=20
> Synchronous direct I/O has a very strong connection between how fast
> persistent storage can go and how fast clients can push more writes.
>=20
>=20
> > ---
> >  fs/nfsd/debugfs.c |   1 +
> >  fs/nfsd/trace.h   |   1 +
> >  fs/nfsd/vfs.c     | 218 ++++++++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 215 insertions(+), 5 deletions(-)
> >=20
> > Changes since v2:
> > - rebased ontop of "[PATCH v1] NFSD: Enable return of an updated stable_h=
ow to NFS clients"
> > - set both IOCB_DSYNC and IOCB_SYNC (rather than just IOCB_SYNC) in nfsd_=
issue_write_dio()
> > - update nfsd_issue_write_dio() to promote @stable_how to NFS_FILE_SYNC
> > - push call to trace_nfsd_write_direct down from nfsd_direct_write to nfs=
d_issue_write_dio=20
> > - fix comment block style to have naked '/*' on first line
> >=20
> > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > index 00eb1ecef6ac..7f44689e0a53 100644
> > --- a/fs/nfsd/debugfs.c
> > +++ b/fs/nfsd/debugfs.c
> > @@ -108,6 +108,7 @@ static int nfsd_io_cache_write_set(void *data, u64 va=
l)
> >  	switch (val) {
> >  	case NFSD_IO_BUFFERED:
> >  	case NFSD_IO_DONTCACHE:
> > +	case NFSD_IO_DIRECT:
> >  		nfsd_io_cache_write =3D val;
> >  		break;
> >  	default:
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index bfd41236aff2..ad74439d0105 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -469,6 +469,7 @@ DEFINE_NFSD_IO_EVENT(read_io_done);
> >  DEFINE_NFSD_IO_EVENT(read_done);
> >  DEFINE_NFSD_IO_EVENT(write_start);
> >  DEFINE_NFSD_IO_EVENT(write_opened);
> > +DEFINE_NFSD_IO_EVENT(write_direct);
> >  DEFINE_NFSD_IO_EVENT(write_io_done);
> >  DEFINE_NFSD_IO_EVENT(write_done);
> >  DEFINE_NFSD_IO_EVENT(commit_start);
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index a3dee33a7233..ba7cb698ac68 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1253,6 +1253,210 @@ static int wait_for_concurrent_writes(struct file=
 *file)
> >  	return err;
> >  }
> > =20
> > +struct nfsd_write_dio {
> > +	ssize_t	start_len;	/* Length for misaligned first extent */
> > +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> > +	ssize_t	end_len;	/* Length for misaligned last extent */
> > +};
> > +
> > +static bool
> > +nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> > +		       struct nfsd_file *nf, struct nfsd_write_dio *write_dio)
> > +{
> > +	const u32 dio_blocksize =3D nf->nf_dio_offset_align;
> > +	loff_t start_end, orig_end, middle_end;
> > +
> > +	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
> > +		return false;
> > +	if (unlikely(dio_blocksize > PAGE_SIZE))
> > +		return false;
> > +	if (unlikely(len < dio_blocksize))
> > +		return false;
> > +
> > +	start_end =3D round_up(offset, dio_blocksize);
> > +	orig_end =3D offset + len;
> > +	middle_end =3D round_down(orig_end, dio_blocksize);
> > +
> > +	write_dio->start_len =3D start_end - offset;
> > +	write_dio->middle_len =3D middle_end - start_end;
> > +	write_dio->end_len =3D orig_end - middle_end;
> > +
> > +	return true;
> > +}
> > +
> > +static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
> > +		unsigned int addr_mask, unsigned int len_mask)
>=20
> IIRC you had mentioned that there is possibly a generic utility
> function that does this that we could adopt here. If we are going
> to keep this one in spite of having a generic, it needs a comment
> explaining why we're not using the generic version.
>=20
>=20
> > +{
> > +	const struct bio_vec *bvec =3D i->bvec;
> > +	size_t skip =3D i->iov_offset;
> > +	size_t size =3D i->count;
> > +
> > +	if (size & len_mask)
> > +		return false;
> > +	do {
> > +		size_t len =3D bvec->bv_len;
> > +
> > +		if (len > size)
> > +			len =3D size;
> > +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> > +			return false;
> > +		bvec++;
> > +		size -=3D len;
> > +		skip =3D 0;
> > +	} while (size);
> > +
> > +	return true;
> > +}
> > +
> > +/*
> > + * Setup as many as 3 iov_iter based on extents described by @write_dio.
> > + * Returns the number of iov_iter that were setup.
> > + */
> > +static int
> > +nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_al=
igned,
> > +			   struct bio_vec *rq_bvec, unsigned int nvecs,
> > +			   unsigned long cnt, struct nfsd_write_dio *write_dio,
> > +			   struct nfsd_file *nf)
> > +{
> > +	int n_iters =3D 0;
> > +	struct iov_iter *iters =3D *iterp;
> > +
> > +	/* Setup misaligned start? */
> > +	if (write_dio->start_len) {
> > +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> > +		iters[n_iters].count =3D write_dio->start_len;
> > +		iter_is_dio_aligned[n_iters] =3D false;
> > +		++n_iters;
> > +	}
> > +
> > +	/* Setup DIO-aligned middle */
> > +	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> > +	if (write_dio->start_len)
> > +		iov_iter_advance(&iters[n_iters], write_dio->start_len);
> > +	iters[n_iters].count -=3D write_dio->end_len;
> > +	iter_is_dio_aligned[n_iters] =3D
> > +		nfsd_iov_iter_aligned_bvec(&iters[n_iters],
> > +				nf->nf_dio_mem_align-1, nf->nf_dio_offset_align-1);
> > +	if (unlikely(!iter_is_dio_aligned[n_iters]))
> > +		return 0; /* no DIO-aligned IO possible */
> > +	++n_iters;
> > +
> > +	/* Setup misaligned end? */
> > +	if (write_dio->end_len) {
> > +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> > +		iov_iter_advance(&iters[n_iters],
> > +				 write_dio->start_len + write_dio->middle_len);
> > +		iter_is_dio_aligned[n_iters] =3D false;
> > +		++n_iters;
> > +	}
> > +
> > +	return n_iters;
> > +}
> > +
> > +static int
> > +nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
> > +		    unsigned int nvecs, unsigned long *cnt,
> > +		    struct kiocb *kiocb)
> > +{
> > +	struct iov_iter iter;
> > +	int host_err;
> > +
> > +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > +	host_err =3D vfs_iocb_iter_write(file, kiocb, &iter);
> > +	if (host_err < 0)
> > +		return host_err;
> > +	*cnt =3D host_err;
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct =
nfsd_file *nf,
> > +		     u32 *stable_how, unsigned int nvecs, unsigned long *cnt,
> > +		     struct kiocb *kiocb, struct nfsd_write_dio *write_dio)
> > +{
> > +	struct file *file =3D nf->nf_file;
> > +	bool iter_is_dio_aligned[3];
> > +	struct iov_iter iter_stack[3];
> > +	struct iov_iter *iter =3D iter_stack;
> > +	unsigned int n_iters =3D 0;
> > +	unsigned long in_count =3D *cnt;
> > +	loff_t in_offset =3D kiocb->ki_pos;
> > +	ssize_t host_err;
> > +
> > +	n_iters =3D nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
> > +				rqstp->rq_bvec, nvecs, *cnt, write_dio, nf);
> > +	if (unlikely(!n_iters))
> > +		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
> > +
> > +	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
> > +
> > +	/*
> > +	 * Any buffered IO issued here will be misaligned, use
> > +	 * sync IO to ensure it has completed before returning.
> > +	 * Also update @stable_how to avoid need for COMMIT.
> > +	 */
> > +	kiocb->ki_flags |=3D (IOCB_DSYNC|IOCB_SYNC);
> > +	*stable_how =3D NFS_FILE_SYNC;
> > +
> > +	*cnt =3D 0;
> > +	for (int i =3D 0; i < n_iters; i++) {
> > +		if (iter_is_dio_aligned[i])
> > +			kiocb->ki_flags |=3D IOCB_DIRECT;
> > +		else
> > +			kiocb->ki_flags &=3D ~IOCB_DIRECT;
> > +
> > +		host_err =3D vfs_iocb_iter_write(file, kiocb, &iter[i]);
> > +		if (host_err < 0) {
> > +			/*
> > +			 * VFS will return -ENOTBLK if DIO WRITE fails to
> > +			 * invalidate the page cache. Retry using buffered IO.
> > +			 */
>=20
> I'm debating with myself whether, now that NFSD is using DIO, nfserrno
> should get a mapping from ENOTBLK to nfserr_serverfault or nfserr_io,
> simply as a defensive measure.
>=20
> I kind of like the idea that we get a warning in nfserrno: "hey, I
> didn't expect ENOTBLK here" so I'm leaning towards leaving it as is
> for now.
>=20
>=20
> > +			if (unlikely(host_err =3D=3D -ENOTBLK)) {
> > +				kiocb->ki_flags &=3D ~IOCB_DIRECT;
> > +				*cnt =3D in_count;
> > +				kiocb->ki_pos =3D in_offset;
> > +				return nfsd_buffered_write(rqstp, file,
> > +							   nvecs, cnt, kiocb);
> > +			} else if (unlikely(host_err =3D=3D -EINVAL)) {
> > +				struct inode *inode =3D d_inode(fhp->fh_dentry);
> > +
> > +				pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
> > +						    inode->i_sb->s_id, inode->i_ino);
> > +				host_err =3D -ESERVERFAULT;
> > +			}
> > +			return host_err;
> > +		}
> > +		*cnt +=3D host_err;
> > +		if (host_err < iter[i].count) /* partial write? */
> > +			break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static noinline_for_stack int
> > +nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > +		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
> > +		  unsigned long *cnt, struct kiocb *kiocb)
> > +{
> > +	struct nfsd_write_dio write_dio;
> > +
> > +	/*
> > +	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
> > +	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
> > +	 * be ignored for any DIO issued here).
> > +	 */
> > +	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> > +		kiocb->ki_flags |=3D IOCB_DONTCACHE;
> > +
> > +	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
> > +		return nfsd_issue_write_dio(rqstp, fhp, nf, stable_how, nvecs,
> > +					    cnt, kiocb, &write_dio);
> > +
> > +	return nfsd_buffered_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
> > +}
> > +
> >  /**
> >   * nfsd_vfs_write - write data to an already-open file
> >   * @rqstp: RPC execution context
> > @@ -1281,7 +1485,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> >  	u32			stable =3D *stable_how;
> >  	struct kiocb		kiocb;
> >  	struct svc_export	*exp;
> > -	struct iov_iter		iter;
> >  	errseq_t		since;
> >  	__be32			nfserr;
> >  	int			host_err;
> > @@ -1318,25 +1521,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> >  		kiocb.ki_flags |=3D IOCB_DSYNC;
> > =20
> >  	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> > -	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > +
> >  	since =3D READ_ONCE(file->f_wb_err);
> >  	if (verf)
> >  		nfsd_copy_write_verifier(verf, nn);
> > =20
> >  	switch (nfsd_io_cache_write) {
> > -	case NFSD_IO_BUFFERED:
> > +	case NFSD_IO_DIRECT:
> > +		host_err =3D nfsd_direct_write(rqstp, fhp, nf, stable_how,
> > +					     nvecs, cnt, &kiocb);
> > +		stable =3D *stable_how;
> >  		break;
> >  	case NFSD_IO_DONTCACHE:
> >  		if (file->f_op->fop_flags & FOP_DONTCACHE)
> >  			kiocb.ki_flags |=3D IOCB_DONTCACHE;
> > +		fallthrough; /* must call nfsd_buffered_write */
>=20
> I'm not clear what purpose this comment serves. The fallthrough
> already states what's going to happen next.
>=20
>=20
> > +	case NFSD_IO_BUFFERED:
> > +		host_err =3D nfsd_buffered_write(rqstp, file,
> > +					       nvecs, cnt, &kiocb);
> >  		break;
> >  	}
> > -	host_err =3D vfs_iocb_iter_write(file, &kiocb, &iter);
> >  	if (host_err < 0) {
> >  		commit_reset_write_verifier(nn, rqstp, host_err);
> >  		goto out_nfserr;
> >  	}
> > -	*cnt =3D host_err;
> >  	nfsd_stats_io_write_add(nn, exp, *cnt);
> >  	fsnotify_modify(file);
> >  	host_err =3D filemap_check_wb_err(file->f_mapping, since);
>=20
>=20
> --=20
> Chuck Lever
>=20


