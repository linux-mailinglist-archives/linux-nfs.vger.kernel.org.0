Return-Path: <linux-nfs+bounces-13166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156ECB0CAB9
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 20:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3E3A3387
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199021FF2B;
	Mon, 21 Jul 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmIBfAqa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043A1FE44B;
	Mon, 21 Jul 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124200; cv=none; b=epFEzMehtIK5Rt0J3XCv6N9j2Cbh0YrNNq7SrBwabWweuE5Mol4zWb8xd4TIZN2y2pB/TamYYWrpsMMIO511c2lxOQekWuVjv1Wiaa+Zx7E7lSFVgwx1DWqOCU9kx3Ou4wibVHhG+o/SIAeRMf1bTvgRD1kLnmcC5T/Nj/JANYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124200; c=relaxed/simple;
	bh=mDQlvRg6SHPaxXM/9TiECtY0KfFIquglSxOU2LyfUIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ad1sq1cif1QeqAoqvO0amTjezH4/V1qXA72d/rBSn0sQFhV9na6wmj2dhzcmvueYQCg3ut4/V1cvcdHIT8Xg2NdZehBzxGFi+VuKi5Q4L18HraM0aO3DXeEKZ/fmDNXoP/mFyCY7ze0rG2etRQXo0ZSi967Cl4wV+RLQ/XvOFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmIBfAqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B6C4CEED;
	Mon, 21 Jul 2025 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753124200;
	bh=mDQlvRg6SHPaxXM/9TiECtY0KfFIquglSxOU2LyfUIQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XmIBfAqawdDrGToMZCZ6MsiRTe5D8S6VNpYDkO7CABTeetI/vwpmZLqg5qiooUl2+
	 r2ic+mBgbggF15VW6fUCklwIkQwVQkjCykOHSmTtkLsvOPs/Bk/6qiF4t5ZS25Jf1q
	 XFzh+w2vJ4ksJFDLOD9zCKJTZYl8qDcqaXJHTyHzae6J0xJvmDHOkxySS2eZW1eyvh
	 PgXDWKj1kBrKn8rle1VTdxxS0VtNX7KJQdTIiULtgbbUCwJYMnIoLqiHGPKO3O2n73
	 u6xRw9xLsNw+3jnKNj1D689TNq2SruTpbaSU8+x1XPGsCqpszvH+P0Zu/a9sQLhWZb
	 Db1bky0slqrgQ==
Message-ID: <4ec5af772adc8c6e73fcaa25f894d6506d94e9ad.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFSD: Fix last write offset handling in layoutcommit
From: Jeff Layton <jlayton@kernel.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>, Chuck Lever
	 <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, 	linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,  Konstantin
 Evtushenko <koevtushenko@yandex.com>
Date: Mon, 21 Jul 2025 14:56:38 -0400
In-Reply-To: <20250721184105.137015-3-sergeybashirov@gmail.com>
References: <20250721184105.137015-1-sergeybashirov@gmail.com>
	 <20250721184105.137015-3-sergeybashirov@gmail.com>
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

On Mon, 2025-07-21 at 21:40 +0300, Sergey Bashirov wrote:
> The data type of loca_last_write_offset is newoffset4 and is switched
> on a boolean value, no_newoffset, that indicates if a previous write
> occurred or not. If no_newoffset is FALSE, an offset is not given.

Gah, what a confusing label in the spec. I went down the rabbit hole of
trying to understand why "no_newoffset" being TRUE means that you do
get an offset. The "no_" in this case is just a prefix for "union
newoffset", and not a negation of the flag.


> This means that client does not try to update the file size. Thus,
> server should not try to calculate new file size and check if it fits
> into the segment range. See RFC 8881, section 12.5.4.2.
>=20
> Sometimes the current incorrect logic may cause clients to hang when
> trying to sync an inode. If layoutcommit fails, the client marks the
> inode as dirty again.
>=20
> Fixes: 9cf514ccfacb ("nfsd: implement pNFS operations")
> Cc: stable@vger.kernel.org
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfsd/blocklayout.c |  5 ++---
>  fs/nfsd/nfs4proc.c    | 30 +++++++++++++++---------------
>  2 files changed, 17 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 4c936132eb440..0822d8a119c6f 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -118,7 +118,6 @@ nfsd4_block_commit_blocks(struct inode *inode, struct=
 nfsd4_layoutcommit *lcp,
>  		struct iomap *iomaps, int nr_iomaps)
>  {
>  	struct timespec64 mtime =3D inode_get_mtime(inode);
> -	loff_t new_size =3D lcp->lc_last_wr + 1;
>  	struct iattr iattr =3D { .ia_valid =3D 0 };
>  	int error;
> =20
> @@ -128,9 +127,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct=
 nfsd4_layoutcommit *lcp,
>  	iattr.ia_valid |=3D ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
>  	iattr.ia_atime =3D iattr.ia_ctime =3D iattr.ia_mtime =3D lcp->lc_mtime;
> =20
> -	if (new_size > i_size_read(inode)) {
> +	if (lcp->lc_size_chg) {
>  		iattr.ia_valid |=3D ATTR_SIZE;
> -		iattr.ia_size =3D new_size;
> +		iattr.ia_size =3D lcp->lc_newsize;
>  	}
> =20
>  	error =3D inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 656b2e7d88407..7043fc475458d 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2475,7 +2475,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  	const struct nfsd4_layout_seg *seg =3D &lcp->lc_seg;
>  	struct svc_fh *current_fh =3D &cstate->current_fh;
>  	const struct nfsd4_layout_ops *ops;
> -	loff_t new_size =3D lcp->lc_last_wr + 1;
>  	struct inode *inode;
>  	struct nfs4_layout_stateid *ls;
>  	__be32 nfserr;
> @@ -2491,13 +2490,21 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  		goto out;
>  	inode =3D d_inode(current_fh->fh_dentry);
> =20
> -	nfserr =3D nfserr_inval;
> -	if (new_size <=3D seg->offset)
> -		goto out;
> -	if (new_size > seg->offset + seg->length)
> -		goto out;
> -	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
> -		goto out;
> +	lcp->lc_size_chg =3D false;
> +	if (lcp->lc_newoffset) {
> +		loff_t new_size =3D lcp->lc_last_wr + 1;
> +
> +		nfserr =3D nfserr_inval;
> +		if (new_size <=3D seg->offset)
> +			goto out;
> +		if (new_size > seg->offset + seg->length)
> +			goto out;
> +
> +		if (new_size > i_size_read(inode)) {
> +			lcp->lc_size_chg =3D true;
> +			lcp->lc_newsize =3D new_size;
> +		}
> +	}
> =20
>  	nfserr =3D nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
>  						false, lcp->lc_layout_type,
> @@ -2513,13 +2520,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  	/* LAYOUTCOMMIT does not require any serialization */
>  	mutex_unlock(&ls->ls_mutex);
> =20
> -	if (new_size > i_size_read(inode)) {
> -		lcp->lc_size_chg =3D true;
> -		lcp->lc_newsize =3D new_size;
> -	} else {
> -		lcp->lc_size_chg =3D false;
> -	}
> -
>  	nfserr =3D ops->proc_layoutcommit(inode, rqstp, lcp);
>  	nfs4_put_stid(&ls->ls_stid);
>  out:

Code looks correct to me though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

