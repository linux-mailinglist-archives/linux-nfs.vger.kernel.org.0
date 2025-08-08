Return-Path: <linux-nfs+bounces-13501-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC775B1E7BD
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983701889DAA
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 11:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028CE275858;
	Fri,  8 Aug 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjA8Tubv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0E275855
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653871; cv=none; b=mSSOiunXTK8kHWR5wY4OxwoAjWj1C5hR8QcermJFiEYRYc2PsLxqqLj3MyNoJW/0Yrr0l5mBPNKbblFjIq2VNFMkFp49oyG8TGGKz+40XMOvJl7FSqQHAQ2hRpe/yFF6VvkmEuPRPbM8jYuXoKpGaVZhVNmIlD6yTipTrSEJXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653871; c=relaxed/simple;
	bh=vhjJR0rHmrD+5nO38MIKn4WJRNNZX5wzstXSvqijEws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bF9iHn2s03UBEG3uHF3INyFxc2LvyrPpjIGCyv23UNhPQ2n/G781yn2GwpT723tQt44Uq0+RHivSXhnepUoqe2B2iEa20V0qcn8YUQrqMzuUdVEs61yrMMRROocogD6sChGkxegaBykfDS5UkJIz/zsPW3wPqwB6EZDVAyHGaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjA8Tubv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE25C4CEED;
	Fri,  8 Aug 2025 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653871;
	bh=vhjJR0rHmrD+5nO38MIKn4WJRNNZX5wzstXSvqijEws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NjA8TubvXZTdcfM/Yhpktj0NQKbJp3eyEgh+E/bUoO56l0HOmpCR1D7XoLdobK9Fo
	 d/gSO0n1H7zcmnpuZdVMmLHo8ue6KtYeRLhDxNvSDTTJyW0XnjbPm1lhO6bim1IBH3
	 2L3Ma5EQiiN8d1O/0afdZo4IGZ7JIg+MfwsFaZb8gX7dekNpQXFWwl41B0fQZiz5eU
	 mznnO2szZvggd7w+JMVAhCeC59q2pHwerhfZ7wmFr8l4eGI2vfKZ557VMKQqxcFHHK
	 apg5e9AynInA/42y3iia+fq8JoOy9zryMGSDYTOioCxXhrkf8bRms2mqIfsdm4w7uT
	 6/9qMVoRcXHJg==
Message-ID: <24cf97f2ca9da2ce9f93763ce5a491bbe084e3e0.camel@kernel.org>
Subject: Re: [PATCH v5 2/7] NFSD: pass nfsd_file to nfsd_iter_read()
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Fri, 08 Aug 2025 07:51:10 -0400
In-Reply-To: <20250807162544.17191-3-snitzer@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
	 <20250807162544.17191-3-snitzer@kernel.org>
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
> Prepares for nfsd_iter_read() to use DIO alignment stored in nfsd_file.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/nfs4xdr.c | 8 ++++----
>  fs/nfsd/vfs.c     | 7 ++++---
>  fs/nfsd/vfs.h     | 2 +-
>  3 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7d19925f46e45..d519f4156cfad 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4464,7 +4464,7 @@ static __be32 nfsd4_encode_splice_read(
> =20
>  static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
>  				 struct nfsd4_read *read,
> -				 struct file *file, unsigned long maxcount)
> +				 unsigned long maxcount)
>  {
>  	struct xdr_stream *xdr =3D resp->xdr;
>  	unsigned int base =3D xdr->buf->page_len & ~PAGE_MASK;
> @@ -4475,7 +4475,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compo=
undres *resp,
>  	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
>  		return nfserr_resource;
> =20
> -	nfserr =3D nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
> +	nfserr =3D nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
>  				read->rd_offset, &maxcount, base,
>  				&read->rd_eof);
>  	read->rd_length =3D maxcount;
> @@ -4522,7 +4522,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
>  	if (file->f_op->splice_read && splice_ok)
>  		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
>  	else
> -		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> +		nfserr =3D nfsd4_encode_readv(resp, read, maxcount);
>  	if (nfserr) {
>  		xdr_truncate_encode(xdr, eof_offset);
>  		return nfserr;
> @@ -5418,7 +5418,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundre=
s *resp,
>  	if (file->f_op->splice_read && splice_ok)
>  		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
>  	else
> -		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> +		nfserr =3D nfsd4_encode_readv(resp, read, maxcount);
>  	if (nfserr)
>  		return nfserr;
> =20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0c0f25b2c8e38..79439ad93880a 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1075,7 +1075,7 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>   * nfsd_iter_read - Perform a VFS read using an iterator
>   * @rqstp: RPC transaction context
>   * @fhp: file handle of file to be read
> - * @file: opened struct file of file to be read
> + * @nf: opened struct nfsd_file of file to be read
>   * @offset: starting byte offset
>   * @count: IN: requested number of bytes; OUT: number of bytes read
>   * @base: offset in first page of read buffer
> @@ -1088,9 +1088,10 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>   * returned.
>   */
>  __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		      struct file *file, loff_t offset, unsigned long *count,
> +		      struct nfsd_file *nf, loff_t offset, unsigned long *count,
>  		      unsigned int base, u32 *eof)
>  {
> +	struct file *file =3D nf->nf_file;
>  	unsigned long v, total;
>  	struct iov_iter iter;
>  	struct kiocb kiocb;
> @@ -1312,7 +1313,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  	if (file->f_op->splice_read && nfsd_read_splice_ok(rqstp))
>  		err =3D nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
>  	else
> -		err =3D nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
> +		err =3D nfsd_iter_read(rqstp, fhp, nf, offset, count, 0, eof);
> =20
>  	nfsd_file_put(nf);
>  	trace_nfsd_read_done(rqstp, fhp, offset, *count);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 0c0292611c6de..fa46f8b5f1320 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -121,7 +121,7 @@ __be32		nfsd_splice_read(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  				unsigned long *count,
>  				u32 *eof);
>  __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -				struct file *file, loff_t offset,
> +				struct nfsd_file *nf, loff_t offset,
>  				unsigned long *count, unsigned int base,
>  				u32 *eof);
>  bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

