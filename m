Return-Path: <linux-nfs+bounces-14028-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8FB43861
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 12:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A3F1C819C2
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3542FB98F;
	Thu,  4 Sep 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFMth+8y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57EB2F9C23;
	Thu,  4 Sep 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980863; cv=none; b=P0hrheF/gP/weiriRZX5M1nbKZTKDAQz4ImpBVXUU/lO0Q2RaO0vD8J/T62U6OXEJ7O6YQbtpRIAcIOf6lupHpaAYE5kWyOU9fGzuCrhxahO4WRxrroDLevR2UNGldsKLbNPQ1fJ1gHKEEE3T9I9Beggx2TEmchbWWrGP4HahZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980863; c=relaxed/simple;
	bh=YgaPKr4nIMhY2fQ5aeeYjUvjyA4zPoIUKJadNgvGFtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=msJ9PsNB7APliKkBcoqQ1TsUFNrOPIAOAPalyeN1PnQfSolcqL0soMKhXnE70elFcrIQZp6nEmVbgypzM7frwRpeZkrCxX85ZMA4vGPX5U47axAqPzGBiB07gejUWsKcNy7ENMLbSB75i9ia4UR4SietAHZR8TAOuke+QT3zuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFMth+8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD249C4CEF0;
	Thu,  4 Sep 2025 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756980863;
	bh=YgaPKr4nIMhY2fQ5aeeYjUvjyA4zPoIUKJadNgvGFtE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oFMth+8yjSUd2xU9h0xfItCRKg/2fZ1t2ENPQ7eX538sAruSHe2R9+9jLrwh/AXFi
	 WnROr7GWDAXSwyNQ++iqs4ozr9WJAeFSHzrVl6AK5TC/0Mc417FRrcoXJxJw5wYrIz
	 x6qjEN5I2e9yVOb4G69zBFVEgP/4GNah13+hEJouVIlb4cEHeqp2W3plhPePouj0rE
	 2IC5K9GqVouOXh3J8DFhAyhxPehTXV6cuF5MzzxVywDtxoG3xmlENKMSnr/CBByFKR
	 qW7CZS6ZbiLbC1wPWScG3Bc8Nz7fqKybwJ+otOCAxJxHvpi9oQxyjeUdecGJKlmjxc
	 4gplkbBtpV7wA==
Message-ID: <2452805383edf28c67474ecdfcc8a0b8b893c855.camel@kernel.org>
Subject: Re: [PATCH v2] NFSD: Disallow layoutget during grace period
From: Jeff Layton <jlayton@kernel.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>, Chuck Lever	
 <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Konstantin
 Evtushenko <koevtushenko@yandex.com>
Date: Thu, 04 Sep 2025 06:14:21 -0400
In-Reply-To: <20250903193438.62613-1-sergeybashirov@gmail.com>
References: <20250903193438.62613-1-sergeybashirov@gmail.com>
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

On Wed, 2025-09-03 at 22:34 +0300, Sergey Bashirov wrote:
> When the block/scsi layout server is recovering from a reboot and is in a
> grace period, any operation that may result in deletion or reallocation o=
f
> block extents should not be allowed. See RFC 8881, section 18.43.3.
>=20
> If multiple clients write data to the same file, rebooting the server
> during writing can result in the file corruption. Observed this behavior
> while testing pNFS block volume setup.
>=20
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
> Changes in v2:
>  - Push down the check to layout driver level
>=20
>  fs/nfsd/blocklayout.c    | 8 +++++++-
>  fs/nfsd/flexfilelayout.c | 2 +-
>  fs/nfsd/nfs4proc.c       | 3 ++-
>  fs/nfsd/pnfs.h           | 2 +-
>  4 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 0822d8a119c6..1fbc5bbde07f 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -19,7 +19,7 @@
> =20
>  static __be32
>  nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp=
,
> -		struct nfsd4_layoutget *args)
> +		struct nfsd4_layoutget *args, bool in_grace)
>  {
>  	struct nfsd4_layout_seg *seg =3D &args->lg_seg;
>  	struct super_block *sb =3D inode->i_sb;
> @@ -34,6 +34,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const s=
truct svc_fh *fhp,
>  		goto out_layoutunavailable;
>  	}
> =20
> +	if (in_grace)
> +		goto out_grace;
> +
>  	/*
>  	 * Some clients barf on non-zero block numbers for NONE or INVALID
>  	 * layouts, so make sure to zero the whole structure.
> @@ -111,6 +114,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const=
 struct svc_fh *fhp,
>  out_layoutunavailable:
>  	seg->length =3D 0;
>  	return nfserr_layoutunavailable;
> +out_grace:
> +	seg->length =3D 0;
> +	return nfserr_grace;
>  }
> =20
>  static __be32
> diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
> index 3ca5304440ff..274a1e9bb596 100644
> --- a/fs/nfsd/flexfilelayout.c
> +++ b/fs/nfsd/flexfilelayout.c
> @@ -21,7 +21,7 @@
> =20
>  static __be32
>  nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
> -		struct nfsd4_layoutget *args)
> +		struct nfsd4_layoutget *args, bool in_grace)
>  {
>  	struct nfsd4_layout_seg *seg =3D &args->lg_seg;
>  	u32 device_generation =3D 0;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d7c58aa64f06..5d1d343a4e23 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2435,6 +2435,7 @@ static __be32
>  nfsd4_layoutget(struct svc_rqst *rqstp,
>  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
>  {
> +	struct net *net =3D SVC_NET(rqstp);
>  	struct nfsd4_layoutget *lgp =3D &u->layoutget;
>  	struct svc_fh *current_fh =3D &cstate->current_fh;
>  	const struct nfsd4_layout_ops *ops;
> @@ -2498,7 +2499,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
>  		goto out_put_stid;
> =20
>  	nfserr =3D ops->proc_layoutget(d_inode(current_fh->fh_dentry),
> -				     current_fh, lgp);
> +				     current_fh, lgp, locks_in_grace(net));
>  	if (nfserr)
>  		goto out_put_stid;
> =20
> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> index dfd411d1f363..61c2528ef077 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -30,7 +30,7 @@ struct nfsd4_layout_ops {
>  			const struct nfsd4_getdeviceinfo *gdevp);
> =20
>  	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
> -			struct nfsd4_layoutget *lgp);
> +			struct nfsd4_layoutget *lgp, bool in_grace);
>  	__be32 (*encode_layoutget)(struct xdr_stream *xdr,
>  			const struct nfsd4_layoutget *lgp);
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

