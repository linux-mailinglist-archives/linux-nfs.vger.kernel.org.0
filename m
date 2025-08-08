Return-Path: <linux-nfs+bounces-13506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E063BB1E823
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 14:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FDCA047CB
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF680265CC8;
	Fri,  8 Aug 2025 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+KeY0pR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2A1E7C34
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655373; cv=none; b=IvFAxOhcJb1BEdv5GxlP5QvEKr0gSGL2AFdZZ7xT4OAQIQZ3JE+paDwAFZRMRVAVV9Ldf/F/IArZWwgnvj+yEpNh1XnQdxOvZFkU6Zd+vcYeKHogmBPosV1yfZbCOo4uh5H3YYhxIRGy3erRUXXZpwyDchhQtU1ddv8aQIWkJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655373; c=relaxed/simple;
	bh=bgb78pJP9jjQ8aQWMF3ecoL1mV5sWzBnaOHPYZb5nSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uw/Z18VgSPCWm9LLZD70DQ/Sw9HAo24GayN+uYhSo6kHgF747WWSfQn9uT/2tukiON9dC9duYi+ytSdreni092D+lefVhcEh3vGdyjZ7JFZfMI2GbuzbJdBoWQ0KF8NH1OWKDmLmnI3fi9WWqz4ewHYpOzt48H4LoqeFlmG5cgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+KeY0pR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0362C4CEED;
	Fri,  8 Aug 2025 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754655373;
	bh=bgb78pJP9jjQ8aQWMF3ecoL1mV5sWzBnaOHPYZb5nSU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U+KeY0pRX2uKlJren5JWKTEfAOEAeoe2skGKRr7z2aC48rg/FLHqIt0gUJuqGEnMg
	 KAc2DEq4S582CqypjeaIu3mxUp1INdzZqKYJ4W5QCZrNX+XtJ2Nh4tHbccnSrC2Zxv
	 +133IK/m6vJwHVy/TM77AxxpY01W3rOB5+OXJ27QUZJITsf+DFccfa6IyXudLFGsP+
	 B6wpqejdmssD4oZDX8gu561qBPGz9Sfo4fHwFZnmQ1/v/t6eeKGxcdVwZCLjHKHTPl
	 IP0ou7Hyn6oqwaXFdCLAY+oLSmT8ov8JcZsj4Ym3vWkky743HnsICTjSTbGe7ndXrQ
	 73zxgFncUgTlQ==
Message-ID: <f7aac49b2a7155ca6d1c9d191fd0dca83f232251.camel@kernel.org>
Subject: Re: [PATCH v5 6/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Fri, 08 Aug 2025 08:16:11 -0400
In-Reply-To: <20250807162544.17191-7-snitzer@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
	 <20250807162544.17191-7-snitzer@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-07 at 12:25 -0400, Mike Snitzer wrote:
> If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> DIO-aligned block (on either end of the READ). The expanded READ is
> verified to have proper offset/len (logical_block_size) and
> dma_alignment checking.
>=20
> Must allocate and use a bounce-buffer page (called 'start_extra_page')
> if/when expanding the misaligned READ requires reading extra partial
> page at the start of the READ so that its DIO-aligned. Otherwise that
> extra page at the start will make its way back to the NFS client and
> corruption will occur. As found, and then this fix of using an extra
> page verified, using the 'dt' utility:
>   dt of=3D/mnt/share1/dt_a.test passes=3D1 bs=3D47008 count=3D2 \
>      iotype=3Dsequential pattern=3Diot onerr=3Dabort oncerr=3Dabort
> see: https://github.com/RobinTMiller/dt.git
>=20
> Any misaligned READ that is less than 32K won't be expanded to be
> DIO-aligned (this heuristic just avoids excess work, like allocating
> start_extra_page, for smaller IO that can generally already perform
> well using buffered IO).
>=20
> Also add EVENT_CLASS nfsd_analyze_dio_class and use it to create
> nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events. This
> prepares for nfsd_vfs_write() to also make use of it when handling
> misaligned WRITEs.
>=20
> This combination of trace events is useful:
>=20
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_read_dio/enable
>  echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
>  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
>=20
> Which for this dd command:
>=20
>  dd if=3D/mnt/share1/test of=3D/dev/null bs=3D47008 count=3D2 iflag=3Ddir=
ect
>=20
> Results in:
>=20
>   nfsd-23908   [010] ..... 10375.141640: nfsd_analyze_read_dio: xid=3D0x8=
2c5923b fh_hash=3D0x857ca4fc offset=3D0 len=3D47008 start=3D0+0 middle=3D0+=
47008 end=3D47008+96
>   nfsd-23908   [010] ..... 10375.141642: nfsd_read_vector: xid=3D0x82c592=
3b fh_hash=3D0x857ca4fc offset=3D0 len=3D47104
>   nfsd-23908   [010] ..... 10375.141643: xfs_file_direct_read: dev 259:2 =
ino 0xc00116 disize 0x226e0 pos 0x0 bytecount 0xb800
>   nfsd-23908   [010] ..... 10375.141773: nfsd_read_io_done: xid=3D0x82c59=
23b fh_hash=3D0x857ca4fc offset=3D0 len=3D47008
>=20
>   nfsd-23908   [010] ..... 10375.142063: nfsd_analyze_read_dio: xid=3D0x8=
3c5923b fh_hash=3D0x857ca4fc offset=3D47008 len=3D47008 start=3D46592+416 m=
iddle=3D47008+47008 end=3D94016+192
>   nfsd-23908   [010] ..... 10375.142064: nfsd_read_vector: xid=3D0x83c592=
3b fh_hash=3D0x857ca4fc offset=3D46592 len=3D47616
>   nfsd-23908   [010] ..... 10375.142065: xfs_file_direct_read: dev 259:2 =
ino 0xc00116 disize 0x226e0 pos 0xb600 bytecount 0xba00
>   nfsd-23908   [010] ..... 10375.142103: nfsd_read_io_done: xid=3D0x83c59=
23b fh_hash=3D0x857ca4fc offset=3D47008 len=3D47008
>=20
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/trace.h            |  61 ++++++++++++++
>  fs/nfsd/vfs.c              | 167 ++++++++++++++++++++++++++++++++++---
>  include/linux/sunrpc/svc.h |   5 +-
>  3 files changed, 221 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index a664fdf1161e9..4173bd9344b6b 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -473,6 +473,67 @@ DEFINE_NFSD_IO_EVENT(write_done);
>  DEFINE_NFSD_IO_EVENT(commit_start);
>  DEFINE_NFSD_IO_EVENT(commit_done);
> =20
> +DECLARE_EVENT_CLASS(nfsd_analyze_dio_class,
> +	TP_PROTO(struct svc_rqst *rqstp,
> +		 struct svc_fh	*fhp,
> +		 u64		offset,
> +		 u32		len,
> +		 loff_t		start,
> +		 ssize_t	start_len,
> +		 loff_t		middle,
> +		 ssize_t	middle_len,
> +		 loff_t		end,
> +		 ssize_t	end_len),
> +	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, =
end, end_len),
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, fh_hash)
> +		__field(u64, offset)
> +		__field(u32, len)
> +		__field(loff_t, start)
> +		__field(ssize_t, start_len)
> +		__field(loff_t, middle)
> +		__field(ssize_t, middle_len)
> +		__field(loff_t, end)
> +		__field(ssize_t, end_len)
> +	),
> +	TP_fast_assign(
> +		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> +		__entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
> +		__entry->offset =3D offset;
> +		__entry->len =3D len;
> +		__entry->start =3D start;
> +		__entry->start_len =3D start_len;
> +		__entry->middle =3D middle;
> +		__entry->middle_len =3D middle_len;
> +		__entry->end =3D end;
> +		__entry->end_len =3D end_len;
> +	),
> +	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x offset=3D%llu len=3D%u start=
=3D%llu+%lu middle=3D%llu+%lu end=3D%llu+%lu",
> +		  __entry->xid, __entry->fh_hash,
> +		  __entry->offset, __entry->len,
> +		  __entry->start, __entry->start_len,
> +		  __entry->middle, __entry->middle_len,
> +		  __entry->end, __entry->end_len)
> +)
> +
> +#define DEFINE_NFSD_ANALYZE_DIO_EVENT(name)			\
> +DEFINE_EVENT(nfsd_analyze_dio_class, nfsd_analyze_##name##_dio,	\
> +	TP_PROTO(struct svc_rqst *rqstp,			\
> +		 struct svc_fh	*fhp,				\
> +		 u64		offset,				\
> +		 u32		len,				\
> +		 loff_t		start,				\
> +		 ssize_t	start_len,			\
> +		 loff_t		middle,				\
> +		 ssize_t	middle_len,			\
> +		 loff_t		end,				\
> +		 ssize_t	end_len),			\
> +	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, =
end, end_len))
> +
> +DEFINE_NFSD_ANALYZE_DIO_EVENT(read);
> +DEFINE_NFSD_ANALYZE_DIO_EVENT(write);
> +
>  DECLARE_EVENT_CLASS(nfsd_err_class,
>  	TP_PROTO(struct svc_rqst *rqstp,
>  		 struct svc_fh	*fhp,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5768244c7a3c3..be083a8812717 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -19,6 +19,7 @@
>  #include <linux/splice.h>
>  #include <linux/falloc.h>
>  #include <linux/fcntl.h>
> +#include <linux/math.h>
>  #include <linux/namei.h>
>  #include <linux/delay.h>
>  #include <linux/fsnotify.h>
> @@ -1073,6 +1074,116 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err)=
;
>  }
> =20
> +struct nfsd_read_dio {
> +	loff_t start;
> +	loff_t end;
> +	unsigned long start_extra;
> +	unsigned long end_extra;
> +	struct page *start_extra_page;
> +};
> +
> +static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
> +{
> +	memset(read_dio, 0, sizeof(*read_dio));
> +	read_dio->start_extra_page =3D NULL;
> +}
> +
> +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> +				  struct nfsd_file *nf, loff_t offset,
> +				  unsigned long len, unsigned int base,
> +				  struct nfsd_read_dio *read_dio)
> +{
> +	const u32 dio_blocksize =3D nf->nf_dio_read_offset_align;
> +	loff_t middle_end, orig_end =3D offset + len;
> +
> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
> +		      "%s: underlying filesystem has not provided DIO alignment info\n=
",
> +		      __func__))
> +		return false;
> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> +		      "%s: underlying storage's dio_blocksize=3D%u > PAGE_SIZE=3D%lu\n=
",
> +		      __func__, dio_blocksize, PAGE_SIZE))
> +		return false;
> +
> +	/* Return early if IO is irreparably misaligned
> +	 * (len < PAGE_SIZE, or base not aligned).
> +	 */
> +	if (unlikely(len < dio_blocksize) ||
> +	    ((base & (nf->nf_dio_mem_align-1)) !=3D 0))
> +		return false;
> +
> +	read_dio->start =3D round_down(offset, dio_blocksize);
> +	read_dio->end =3D round_up(orig_end, dio_blocksize);
> +	read_dio->start_extra =3D offset - read_dio->start;
> +	read_dio->end_extra =3D read_dio->end - orig_end;
> +
> +	/* don't expand READ for IO less than 32K */
> +	if ((read_dio->start_extra || read_dio->end_extra) && (len < (32 << 10)=
)) {
> +		init_nfsd_read_dio(read_dio);
> +		return false;
> +	}
> +
> +	if (read_dio->start_extra) {
> +		read_dio->start_extra_page =3D alloc_page(GFP_KERNEL);
> +		if (WARN_ONCE(read_dio->start_extra_page =3D=3D NULL,
> +			      "%s: Unable to allocate start_extra_page\n", __func__)) {
> +			init_nfsd_read_dio(read_dio);
> +			return false;
> +		}
> +	}
> +
> +	/* Show original offset and count, and how it was expanded for DIO */
> +	middle_end =3D read_dio->end - read_dio->end_extra;
> +	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
> +				    read_dio->start, read_dio->start_extra,
> +				    offset, (middle_end - offset),
> +				    middle_end, read_dio->end_extra);
> +	return true;
> +}
> +
> +static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
> +						 struct nfsd_read_dio *read_dio,
> +						 ssize_t bytes_read,
> +						 unsigned long bytes_expected,
> +						 loff_t *offset,
> +						 unsigned long *rq_bvec_numpages)
> +{
> +	ssize_t host_err =3D bytes_read;
> +	loff_t v;
> +
> +	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
> +	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
> +	 */
> +	if (read_dio->start_extra_page) {
> +		__free_page(read_dio->start_extra_page);
> +		*rq_bvec_numpages -=3D 1;
> +		v =3D *rq_bvec_numpages;
> +		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
> +			v * sizeof(struct bio_vec));
> +	}
> +	/* Eliminate any end_extra bytes from the last page */
> +	v =3D *rq_bvec_numpages;
> +	rqstp->rq_bvec[v].bv_len -=3D read_dio->end_extra;
> +
> +	if (host_err < 0)
> +		return host_err;
> +
> +	/* nfsd_analyze_read_dio() may have expanded the start and end,
> +	 * if so adjust returned read size to reflect original extent.
> +	 */
> +	*offset +=3D read_dio->start_extra;
> +	if (likely(host_err >=3D read_dio->start_extra)) {
> +		host_err -=3D read_dio->start_extra;
> +		if (host_err > bytes_expected)
> +			host_err =3D bytes_expected;
> +	} else {
> +		/* Short read that didn't read any of requested data */
> +		host_err =3D 0;
> +	}
> +
> +	return host_err;
> +}
> +
>  /**
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
> @@ -1094,26 +1205,49 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>  		      unsigned int base, u32 *eof)
>  {
>  	struct file *file =3D nf->nf_file;
> -	unsigned long v, total;
> +	unsigned long v, total, in_count =3D *count;
> +	struct nfsd_read_dio read_dio;
>  	struct iov_iter iter;
>  	struct kiocb kiocb;
> -	ssize_t host_err;
> +	ssize_t host_err =3D 0;
>  	size_t len;
> =20
> +	init_nfsd_read_dio(&read_dio);
>  	init_sync_kiocb(&kiocb, file);
> =20
> +	/*
> +	 * If NFSD_IO_DIRECT enabled, expand any misaligned READ to
> +	 * the next DIO-aligned block (on either end of the READ).
> +	 */
>  	if (nfsd_io_cache_read =3D=3D NFSD_IO_DIRECT) {
> -		/* Verify ondisk DIO alignment, memory addrs checked below */
> -		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
> -		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) =3D=3D 0=
))
> -			kiocb.ki_flags =3D IOCB_DIRECT;
> +		if (nfsd_analyze_read_dio(rqstp, fhp, nf, offset,
> +					  in_count, base, &read_dio)) {
> +			/* trace_nfsd_read_vector() will reflect larger
> +			 * DIO-aligned READ.
> +			 */
> +			offset =3D read_dio.start;
> +			in_count =3D read_dio.end - offset;
> +			/* Verify ondisk DIO alignment, memory addrs checked below */
> +			if (likely(((offset | in_count) &
> +				    (nf->nf_dio_read_offset_align - 1)) =3D=3D 0))
> +				kiocb.ki_flags =3D IOCB_DIRECT;
> +		}
>  	} else if (nfsd_io_cache_read =3D=3D NFSD_IO_DONTCACHE)
>  		kiocb.ki_flags =3D IOCB_DONTCACHE;
> =20
>  	kiocb.ki_pos =3D offset;
> =20
>  	v =3D 0;
> -	total =3D *count;
> +	total =3D in_count;
> +	if (read_dio.start_extra) {
> +		bvec_set_page(&rqstp->rq_bvec[v], read_dio.start_extra_page,
> +			      read_dio.start_extra, PAGE_SIZE - read_dio.start_extra);
> +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
> +			     rqstp->rq_bvec[v].bv_offset & (nf->nf_dio_mem_align - 1)))
> +			kiocb.ki_flags &=3D ~IOCB_DIRECT;
> +		total -=3D read_dio.start_extra;
> +		v++;
> +	}
>  	while (total) {
>  		len =3D min_t(size_t, total, PAGE_SIZE - base);
>  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base)=
;
> @@ -1125,11 +1259,22 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>  		base =3D 0;
>  		v++;
>  	}
> -	WARN_ON_ONCE(v > rqstp->rq_maxpages);
> +	if (WARN_ONCE(v > rqstp->rq_maxpages,
> +		      "%s: v=3D%lu exceeds rqstp->rq_maxpages=3D%lu\n", __func__,
> +		      v, rqstp->rq_maxpages)) {
> +		host_err =3D -EINVAL;
> +	}
> =20
> -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> -	host_err =3D vfs_iocb_iter_read(file, &kiocb, &iter);
> +	if (!host_err) {
> +		trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
> +		iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
> +		host_err =3D vfs_iocb_iter_read(file, &kiocb, &iter);
> +	}
> +
> +	if (read_dio.start_extra || read_dio.end_extra) {
> +		host_err =3D nfsd_complete_misaligned_read_dio(rqstp, &read_dio,
> +					host_err, *count, &offset, &v);
> +	}
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err)=
;
>  }
> =20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e64ab444e0a7f..190c2667500e2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *r=
qstp);
>   * pages, one for the request, and one for the reply.
>   * nfsd_splice_actor() might need an extra page when a READ payload
>   * is not page-aligned.
> + * nfsd_iter_read() might need two extra pages when a READ payload
> + * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
> + * are mutually exclusive (so reuse page reserved for nfsd_splice_actor)=
.
>   */
>  static inline unsigned long svc_serv_maxpages(const struct svc_serv *ser=
v)
>  {
> -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
>  }
> =20
>  /*

Reviewed-by: Jeff Layton <jlayton@kernel.org>

