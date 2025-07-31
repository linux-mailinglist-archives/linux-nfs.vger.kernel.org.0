Return-Path: <linux-nfs+bounces-13350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41302B17725
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 22:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FD05A12B2
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 20:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624C1632DF;
	Thu, 31 Jul 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkkOEGgM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51378C91
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993729; cv=none; b=BI+5plf/VRufU7qJrp9YOfyircfg14JI6YqG+UQf9FNbDBJGLdOSDPw6s5mKzfkfGP7SNbhJ658HFEhEgT2M7lShOjUHqm6q3N4M3v9/pZPqM+Mj4dVAyP6/QSwP1a+7qEKUKSC2pmTOLJtlwIo16iqVmldhP/q0jnZjbAudyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993729; c=relaxed/simple;
	bh=im5m1D1WK8m5QAvHG0vaakWNiMBAVNo9KdlFKZ1bcGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f+ELu1y0bjzSEsKFyNxV4GtKRRyVElK6+6ueHB9cmUkCZU+ED0AXb5EHticihrpqHB6g8O9gm8w6VQQAEEXuSoR2jEa/8RtXZVA8qM/4e1JqkwQe+aQ5mDu4tMvtO8a3LDveBxruRu82iRY540v2be/qmXEQ8/Mg9zTvlRNdhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkkOEGgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61A9C4CEEF;
	Thu, 31 Jul 2025 20:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753993729;
	bh=im5m1D1WK8m5QAvHG0vaakWNiMBAVNo9KdlFKZ1bcGk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TkkOEGgMyaLUKC3TeZuaR0tbrNPOWaH3fUI2yMtvHRJ33DxQ0Nm8e9LgmZEjlBt0z
	 0K9vJsz1j2nMFXK/Kr3UhiHpfzmP9ckLDP1NTSuFfzye0YdX7s7sJ7fje8VBWoSypc
	 KMSdaXCk/g2f4bh9IbJgKeL5I6VLqyFmeVvEasHzqFQjzLGzN5JjliXkA0K48fyx+e
	 //y5u6DKtsbTUl/khjv9yabnKotWHbUDvSDWBGGxXthmygUi6KYtXYxNCcVvj+Sra5
	 KCmqIORd4X4th98LY0NAO/GYzjGBAGqBcTumnSwIFdJdpvWaeLn4cdYoN4PGNrh+PP
	 wXTPrhDTv2+UQ==
Message-ID: <f0191979a381d8bf5f86cb2f92e1bec2eb3dde26.camel@kernel.org>
Subject: Re: [PATCH v2 1/4] NFSD: refactor nfsd_read_vector_dio to
 EVENT_CLASS useful for READ and WRITE
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 31 Jul 2025 16:28:47 -0400
In-Reply-To: <20250731194448.88816-2-snitzer@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
	 <20250731194448.88816-2-snitzer@kernel.org>
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

On Thu, 2025-07-31 at 15:44 -0400, Mike Snitzer wrote:
> Transform nfsd_read_vector_dio trace event into nfsd_analyze_dio_class
> and use it to create nfsd_analyze_read_dio and nfsd_analyze_write_dio
> trace events.
>=20
> This prepares for nfsd_vfs_write() to also make use of it when
> handling misaligned WRITEs.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/trace.h | 52 ++++++++++++++++++++++++++++++++++++-------------
>  fs/nfsd/vfs.c   | 11 ++++++-----
>  2 files changed, 44 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 55055482f8a84..4173bd9344b6b 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -473,25 +473,29 @@ DEFINE_NFSD_IO_EVENT(write_done);
>  DEFINE_NFSD_IO_EVENT(commit_start);
>  DEFINE_NFSD_IO_EVENT(commit_done);
> =20
> -TRACE_EVENT(nfsd_read_vector_dio,
> +DECLARE_EVENT_CLASS(nfsd_analyze_dio_class,
>  	TP_PROTO(struct svc_rqst *rqstp,
>  		 struct svc_fh	*fhp,
>  		 u64		offset,
>  		 u32		len,
> -		 loff_t         start,
> -		 loff_t         start_extra,
> -		 loff_t         end,
> -		 loff_t         end_extra),
> -	TP_ARGS(rqstp, fhp, offset, len, start, start_extra, end, end_extra),
> +		 loff_t		start,
> +		 ssize_t	start_len,
> +		 loff_t		middle,
> +		 ssize_t	middle_len,
> +		 loff_t		end,
> +		 ssize_t	end_len),
> +	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, =
end, end_len),
>  	TP_STRUCT__entry(
>  		__field(u32, xid)
>  		__field(u32, fh_hash)
>  		__field(u64, offset)
>  		__field(u32, len)
>  		__field(loff_t, start)
> -		__field(loff_t, start_extra)
> +		__field(ssize_t, start_len)
> +		__field(loff_t, middle)
> +		__field(ssize_t, middle_len)
>  		__field(loff_t, end)
> -		__field(loff_t, end_extra)
> +		__field(ssize_t, end_len)
>  	),
>  	TP_fast_assign(
>  		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> @@ -499,16 +503,36 @@ TRACE_EVENT(nfsd_read_vector_dio,
>  		__entry->offset =3D offset;
>  		__entry->len =3D len;
>  		__entry->start =3D start;
> -		__entry->start_extra =3D start_extra;
> +		__entry->start_len =3D start_len;
> +		__entry->middle =3D middle;
> +		__entry->middle_len =3D middle_len;
>  		__entry->end =3D end;
> -		__entry->end_extra =3D end_extra;
> +		__entry->end_len =3D end_len;
>  	),
> -	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x offset=3D%llu len=3D%u start=
=3D%llu+%llu end=3D%llu-%llu",
> +	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x offset=3D%llu len=3D%u start=
=3D%llu+%lu middle=3D%llu+%lu end=3D%llu+%lu",
>  		  __entry->xid, __entry->fh_hash,
>  		  __entry->offset, __entry->len,
> -		  __entry->start, __entry->start_extra,
> -		  __entry->end, __entry->end_extra)
> -);
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
> =20
>  DECLARE_EVENT_CLASS(nfsd_err_class,
>  	TP_PROTO(struct svc_rqst *rqstp,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 46189020172fb..35c29b8ade9c3 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1094,7 +1094,7 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *=
rqstp, struct svc_fh *fhp,
>  				  struct nfsd_read_dio *read_dio)
>  {
>  	const u32 dio_blocksize =3D nf->nf_dio_read_offset_align;
> -	loff_t orig_end =3D offset + len;
> +	loff_t middle_end, orig_end =3D offset + len;
> =20
>  	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
>  		      "%s: underlying filesystem has not provided DIO alignment info\n=
",
> @@ -1133,10 +1133,11 @@ static bool nfsd_analyze_read_dio(struct svc_rqst=
 *rqstp, struct svc_fh *fhp,
>  	}
> =20
>  	/* Show original offset and count, and how it was expanded for DIO */
> -	trace_nfsd_read_vector_dio(rqstp, fhp, offset, len,
> -				   read_dio->start, read_dio->start_extra,
> -				   read_dio->end, read_dio->end_extra);
> -
> +	middle_end =3D read_dio->end - read_dio->end_extra;
> +	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
> +				    read_dio->start, read_dio->start_extra,
> +				    offset, (middle_end - offset),
> +				    middle_end, read_dio->end_extra);
>  	return true;
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

