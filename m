Return-Path: <linux-nfs+bounces-12616-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B0AE2B5D
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 21:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C9C7A80B6
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB32701B6;
	Sat, 21 Jun 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRNBrBU8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAE26FDA6;
	Sat, 21 Jun 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750532922; cv=none; b=BhZmFGQkMH91iANAYsIOSCQtIt2GDNR5KBRnhonVfm2RgWJGBx80MlLXL5HpB110iIcf9dC4LbWtfed0KpyqWsVsHhZSA55w/FbananQN4TEzNGcZOugQPxo8OBWPImTMFvLPdxE9w7+v55s2yhA1TmTaUtmQZrS5HM2DUJsKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750532922; c=relaxed/simple;
	bh=Cesk730eO7XjSNwju01JDlUYIck8xc5tY9518vxziD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/crWVpna64sQPemA3rI/+oVMHoyE573DugAJV19lEB2OdwZAAf2AvFt8KSHjEyzwcOlHadW108LgdmMiYPCYbL5xHm77zoz3AHvy/ENAeQ+P681L3/ZlqU3fm3TKS1z8TkV315lspT4tTmuRtdKR2LJhQQ6N8mbomxx/h/bHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRNBrBU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDB1C4CEE7;
	Sat, 21 Jun 2025 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750532921;
	bh=Cesk730eO7XjSNwju01JDlUYIck8xc5tY9518vxziD8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PRNBrBU8X26+SR7qxzJ6gKLLhzCgEYYzCkLo3/c4fmDWZ6FGRpc2R6zE7jb/ShM4q
	 rMhfOzardpEV3ioNeIAyVbP5UQexxrjDCDpIjc3eHjibionM9hcsNzJcg1cm0dxecp
	 /xvZ5Gjn/XrIgmfPe2PALUZAhHYiqAtBGiFok2RXCkht81RqwkZbyQ7vdtwFG/W83q
	 MUSJsDjUHiZBPrcLUnxd7QxuucoxdF8izYqVnU0YcYghpnR/lrpz9nESMHuNUzot6r
	 Z7IusmCXC8Gcsm+17Y9n4tAujYVjohtw42hGIW58Md9zRm8QdeFPiCj7xEIi/tfmp6
	 meA4bAFrrs9fg==
Message-ID: <274fa4b71f629429c50073ed1079a1250b5e751b.camel@kernel.org>
Subject: Re: [PATCH v4 2/2] nfsd: Implement large extent array support in
 pNFS
From: Jeff Layton <jlayton@kernel.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>, Chuck Lever
	 <chuck.lever@oracle.com>, Christoph Hellwig <hch@infradead.org>, NeilBrown
	 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Konstantin
 Evtushenko <koevtushenko@yandex.com>
Date: Sat, 21 Jun 2025 15:08:39 -0400
In-Reply-To: <20250621165409.147744-3-sergeybashirov@gmail.com>
References: <20250621165409.147744-1-sergeybashirov@gmail.com>
	 <20250621165409.147744-3-sergeybashirov@gmail.com>
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

On Sat, 2025-06-21 at 19:52 +0300, Sergey Bashirov wrote:
> When pNFS client in the block or scsi layout mode sends layoutcommit
> to MDS, a variable length array of modified extents is supplied within
> the request. This patch allows the server to accept such extent arrays
> if they do not fit within single memory page.
>=20
> The issue can be reproduced when writing to a 1GB file using FIO with
> O_DIRECT, 4K block and large I/O depth without preallocation of the
> file. In this case, the server returns NFSERR_BADXDR to the client.
>=20
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
>  fs/nfsd/blocklayout.c    | 20 ++++++----
>  fs/nfsd/blocklayoutxdr.c | 86 +++++++++++++++++++++++++++-------------
>  fs/nfsd/blocklayoutxdr.h |  4 +-
>  fs/nfsd/nfs4proc.c       |  2 +-
>  fs/nfsd/nfs4xdr.c        | 11 +++--
>  fs/nfsd/pnfs.h           |  1 +
>  fs/nfsd/xdr4.h           |  3 +-
>  7 files changed, 80 insertions(+), 47 deletions(-)
>=20
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 19078a043e85..54fbe157f84a 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -173,16 +173,18 @@ nfsd4_block_proc_getdeviceinfo(struct super_block *=
sb,
>  }
> =20
>  static __be32
> -nfsd4_block_proc_layoutcommit(struct inode *inode,
> +nfsd4_block_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqst=
p,
>  		struct nfsd4_layoutcommit *lcp)
>  {
>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  	__be32 nfserr;
> =20
> -	nfserr =3D nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, &nr_iomaps,
> -			i_blocksize(inode));
> +	memcpy(&rqstp->rq_arg, &lcp->lc_up_layout, sizeof(struct xdr_buf));

Huh? rqstp->rq_arg is an xdr_buf. This is going to end up scri
> +	svcxdr_init_decode(rqstp);
> +
> +	nfserr =3D nfsd4_block_decode_layoutupdate(&rqstp->rq_arg_stream,
> +			&iomaps, &nr_iomaps, i_blocksize(inode));
>  	if (nfserr !=3D nfs_ok)
>  		return nfserr;
> =20
> @@ -313,16 +315,18 @@ nfsd4_scsi_proc_getdeviceinfo(struct super_block *s=
b,
>  	return nfserrno(nfsd4_block_get_device_info_scsi(sb, clp, gdp));
>  }
>  static __be32
> -nfsd4_scsi_proc_layoutcommit(struct inode *inode,
> +nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp=
,
>  		struct nfsd4_layoutcommit *lcp)
>  {
>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  	__be32 nfserr;
> =20
> -	nfserr =3D nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, &nr_iomaps,
> -			i_blocksize(inode));
> +	memcpy(&rqstp->rq_arg, &lcp->lc_up_layout, sizeof(struct xdr_buf));
> +	svcxdr_init_decode(rqstp);
> +
> +	nfserr =3D nfsd4_scsi_decode_layoutupdate(&rqstp->rq_arg_stream,
> +			&iomaps, &nr_iomaps, i_blocksize(inode));
>  	if (nfserr !=3D nfs_ok)
>  		return nfserr;
> =20
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index bcf21fde9120..266b2737882e 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -114,8 +114,7 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *x=
dr,
> =20
>  /**
>   * nfsd4_block_decode_layoutupdate - decode the block layout extent arra=
y
> - * @p: pointer to the xdr data
> - * @len: number of bytes to decode
> + * @xdr: subbuf set to the encoded array
>   * @iomapp: pointer to store the decoded extent array
>   * @nr_iomapsp: pointer to store the number of extents
>   * @block_size: alignment of extent offset and length
> @@ -128,25 +127,24 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream =
*xdr,
>   *
>   * Return values:
>   *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
> - *   %nfserr_bad_xdr: The encoded array in @p is invalid
> + *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
>   *   %nfserr_inval: An unaligned extent found
>   *   %nfserr_delay: Failed to allocate memory for @iomapp
>   */
>  __be32
> -nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomap=
p,
> +nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **i=
omapp,
>  		int *nr_iomapsp, u32 block_size)
>  {
>  	struct iomap *iomaps;
> -	u32 nr_iomaps, i;
> +	u32 nr_iomaps, expected, len, i;
> +	__be32 nfserr;
> =20
> -	if (len < sizeof(u32))
> -		return nfserr_bad_xdr;
> -	len -=3D sizeof(u32);
> -	if (len % PNFS_BLOCK_EXTENT_SIZE)
> +	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
>  		return nfserr_bad_xdr;
> =20
> -	nr_iomaps =3D be32_to_cpup(p++);
> -	if (nr_iomaps !=3D len / PNFS_BLOCK_EXTENT_SIZE)
> +	len =3D sizeof(__be32) + xdr_stream_remaining(xdr);
> +	expected =3D sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
> +	if (len !=3D expected)
>  		return nfserr_bad_xdr;
> =20
>  	iomaps =3D kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
> @@ -155,24 +153,48 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,=
 struct iomap **iomapp,
> =20
>  	for (i =3D 0; i < nr_iomaps; i++) {
>  		struct pnfs_block_extent bex;
> +		ssize_t ret;
> =20
> -		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
> -		p +=3D XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
> +		ret =3D xdr_stream_decode_opaque_fixed(xdr,
> +				&bex.vol_id, sizeof(bex.vol_id));
> +		if (ret < sizeof(bex.vol_id)) {
> +			nfserr =3D nfserr_bad_xdr;
> +			goto fail;
> +		}
> =20
> -		p =3D xdr_decode_hyper(p, &bex.foff);
> +		if (xdr_stream_decode_u64(xdr, &bex.foff)) {
> +			nfserr =3D nfserr_bad_xdr;
> +			goto fail;
> +		}
>  		if (bex.foff & (block_size - 1)) {
> +			nfserr =3D nfserr_inval;
> +			goto fail;
> +		}
> +
> +		if (xdr_stream_decode_u64(xdr, &bex.len)) {
> +			nfserr =3D nfserr_bad_xdr;
>  			goto fail;
>  		}
> -		p =3D xdr_decode_hyper(p, &bex.len);
>  		if (bex.len & (block_size - 1)) {
> +			nfserr =3D nfserr_inval;
> +			goto fail;
> +		}
> +
> +		if (xdr_stream_decode_u64(xdr, &bex.soff)) {
> +			nfserr =3D nfserr_bad_xdr;
>  			goto fail;
>  		}
> -		p =3D xdr_decode_hyper(p, &bex.soff);
>  		if (bex.soff & (block_size - 1)) {
> +			nfserr =3D nfserr_inval;
> +			goto fail;
> +		}
> +
> +		if (xdr_stream_decode_u32(xdr, &bex.es)) {
> +			nfserr =3D nfserr_bad_xdr;
>  			goto fail;
>  		}
> -		bex.es =3D be32_to_cpup(p++);
>  		if (bex.es !=3D PNFS_BLOCK_READWRITE_DATA) {
> +			nfserr =3D nfserr_inval;
>  			goto fail;
>  		}
> =20
> @@ -185,13 +207,12 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,=
 struct iomap **iomapp,
>  	return nfs_ok;
>  fail:
>  	kfree(iomaps);
> -	return nfserr_inval;
> +	return nfserr;
>  }
> =20
>  /**
>   * nfsd4_scsi_decode_layoutupdate - decode the scsi layout extent array
> - * @p: pointer to the xdr data
> - * @len: number of bytes to decode
> + * @xdr: subbuf set to the encoded array
>   * @iomapp: pointer to store the decoded extent array
>   * @nr_iomapsp: pointer to store the number of extents
>   * @block_size: alignment of extent offset and length
> @@ -203,21 +224,22 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,=
 struct iomap **iomapp,
>   *
>   * Return values:
>   *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
> - *   %nfserr_bad_xdr: The encoded array in @p is invalid
> + *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
>   *   %nfserr_inval: An unaligned extent found
>   *   %nfserr_delay: Failed to allocate memory for @iomapp
>   */
>  __be32
> -nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp=
,
> +nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **io=
mapp,
>  		int *nr_iomapsp, u32 block_size)
>  {
>  	struct iomap *iomaps;
> -	u32 nr_iomaps, expected, i;
> +	u32 nr_iomaps, expected, len, i;
> +	__be32 nfserr;
> =20
> -	if (len < sizeof(u32))
> +	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
>  		return nfserr_bad_xdr;
> =20
> -	nr_iomaps =3D be32_to_cpup(p++);
> +	len =3D sizeof(__be32) + xdr_stream_remaining(xdr);
>  	expected =3D sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
>  	if (len !=3D expected)
>  		return nfserr_bad_xdr;
> @@ -229,14 +251,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, =
struct iomap **iomapp,
>  	for (i =3D 0; i < nr_iomaps; i++) {
>  		u64 val;
> =20
> -		p =3D xdr_decode_hyper(p, &val);
> +		if (xdr_stream_decode_u64(xdr, &val)) {
> +			nfserr =3D nfserr_bad_xdr;
> +			goto fail;
> +		}
>  		if (val & (block_size - 1)) {
> +			nfserr =3D nfserr_inval;
>  			goto fail;
>  		}
>  		iomaps[i].offset =3D val;
> =20
> -		p =3D xdr_decode_hyper(p, &val);
> +		if (xdr_stream_decode_u64(xdr, &val)) {
> +			nfserr =3D nfserr_bad_xdr;
> +			goto fail;
> +		}
>  		if (val & (block_size - 1)) {
> +			nfserr =3D nfserr_inval;
>  			goto fail;
>  		}
>  		iomaps[i].length =3D val;
> @@ -247,5 +277,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, st=
ruct iomap **iomapp,
>  	return nfs_ok;
>  fail:
>  	kfree(iomaps);
> -	return nfserr_inval;
> +	return nfserr;
>  }
> diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
> index 15b3569f3d9a..7d25ef689671 100644
> --- a/fs/nfsd/blocklayoutxdr.h
> +++ b/fs/nfsd/blocklayoutxdr.h
> @@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stre=
am *xdr,
>  		const struct nfsd4_getdeviceinfo *gdp);
>  __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>  		const struct nfsd4_layoutget *lgp);
> -__be32 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,
> +__be32 nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr,
>  		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
> -__be32 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len,
> +__be32 nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr,
>  		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
> =20
>  #endif /* _NFSD_BLOCKLAYOUTXDR_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f13abbb13b38..873cd667477c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2533,7 +2533,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  		lcp->lc_size_chg =3D false;
>  	}
> =20
> -	nfserr =3D ops->proc_layoutcommit(inode, lcp);
> +	nfserr =3D ops->proc_layoutcommit(inode, rqstp, lcp);
>  	nfs4_put_stid(&ls->ls_stid);
>  out:
>  	return nfserr;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 3afcdbed6e14..659e60b85d5f 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -604,6 +604,8 @@ static __be32
>  nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
>  			   struct nfsd4_layoutcommit *lcp)
>  {
> +	u32 len;
> +
>  	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
>  		return nfserr_bad_xdr;
>  	if (lcp->lc_layout_type < LAYOUT_NFSV4_1_FILES)
> @@ -611,13 +613,10 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundarg=
s *argp,
>  	if (lcp->lc_layout_type >=3D LAYOUT_TYPE_MAX)
>  		return nfserr_bad_xdr;
> =20
> -	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
> +	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
> +		return nfserr_bad_xdr;
> +	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, len))
>  		return nfserr_bad_xdr;
> -	if (lcp->lc_up_len > 0) {
> -		lcp->lc_up_layout =3D xdr_inline_decode(argp->xdr, lcp->lc_up_len);
> -		if (!lcp->lc_up_layout)
> -			return nfserr_bad_xdr;
> -	}
> =20
>  	return nfs_ok;
>  }
> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> index 925817f66917..dfd411d1f363 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -35,6 +35,7 @@ struct nfsd4_layout_ops {
>  			const struct nfsd4_layoutget *lgp);
> =20
>  	__be32 (*proc_layoutcommit)(struct inode *inode,
> +			struct svc_rqst *rqstp,
>  			struct nfsd4_layoutcommit *lcp);
> =20
>  	void (*fence_client)(struct nfs4_layout_stateid *ls,
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index aa2a356da784..02887029a81c 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -630,8 +630,7 @@ struct nfsd4_layoutcommit {
>  	u64			lc_last_wr;	/* request */
>  	struct timespec64	lc_mtime;	/* request */
>  	u32			lc_layout_type;	/* request */
> -	u32			lc_up_len;	/* layout length */
> -	void			*lc_up_layout;	/* decoded by callback */
> +	struct xdr_buf		lc_up_layout;	/* decoded by callback */
>  	bool			lc_size_chg;	/* response */
>  	u64			lc_newsize;	/* response */
>  };


LGTM. Nice work!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

