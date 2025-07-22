Return-Path: <linux-nfs+bounces-13186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E818B0E07C
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E4E7A55D1
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2910926A0A0;
	Tue, 22 Jul 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+O3Bv5X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E6268683
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198199; cv=none; b=eXM5zidhXcjL06O0KDNamP0E5WilbtiBBChVkqMfuIIivdPwPAcGw958w4lEsF+l2dVGh3MKxwde0lvswuYJ8LVMjNz9ELsA0E5vN1s5omAvPff4yc/bgVGZ7w9b/q61OEeH8Ly+a4TSxm38vy4lebsUu4Ni3/m7IyNiwLdhIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198199; c=relaxed/simple;
	bh=oe6PzVJPALZREz452ejOzHqT7rmdiWZbcFXTs+3Iwjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qyHCmHtvC0h3djjoG1iscl/0N1UEzSuzRlOojuotpVyzVo9vuEzdKJg4LXyc2ugTOUQxqjqKHaepty3Tx2CReS9opclvyZQ0dpq5anLWWKjmyDe+HbiJDddpJdV3OTECfAt90bBp/ci9LN5HQZ0TC1Mw86kQyya420rK/vrkuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+O3Bv5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ED8C4CEEB;
	Tue, 22 Jul 2025 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753198198;
	bh=oe6PzVJPALZREz452ejOzHqT7rmdiWZbcFXTs+3Iwjw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L+O3Bv5X45m1OsRHBpJEk01RFQaZFO5DDSbPe3+oOnDWCjXyjajn+dKxIKXgA5H9V
	 S8fq1ZxlBOPSxtQtwukUg4TIVLCI7f/T99TBFH/KaeiAl0LtPVYnVzGnpdejawWvGI
	 a9Heo1mOzaCV1llqOlCfj5oplrcBEFjPokHIo2tGZ6dBPi1oY1Pa8kPbVbUhEGSRZy
	 rmlqgxCIm1dUIyD97rLstrAq84OaDFDLeXLhmI3DGEyKaSUbyJdzhegYdoBJi9gi5K
	 JtChRDUe4ARPaVsYL3HFLAmS9dWX+z4x7MVKqDBRNaweGxZ/Ypmj/tLPdFJUHqLhmD
	 egnYdEkzxsvgg==
Message-ID: <6d363a6f462b0646a065a5d188b6d05a56429efa.camel@kernel.org>
Subject: Re: [PATCH] NFS: Fix filehandle bounds checking in
 nfs_fh_to_dentry()
From: Trond Myklebust <trondmy@kernel.org>
To: "zhangjian (CG)" <zhangjian496@huawei.com>, linux-nfs@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Date: Tue, 22 Jul 2025 11:29:08 -0400
In-Reply-To: <838a9fd6-2a22-4677-9a50-c48341faf08b@huawei.com>
References: 
	<ef93a685e01a281b5e2a25ce4e3428cf9371a205.1753192530.git.trond.myklebust@hammerspace.com>
	 <838a9fd6-2a22-4677-9a50-c48341faf08b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 22:17 +0800, zhangjian (CG) wrote:
>=20
>=20
> On 2025/7/22 21:58, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > The function needs to check the minimal filehandle length before it
> > can
> > access the embedded filehandle.
> >=20
> > Reported-by: zhangjian <zhangjian496@huawei.com>
> > Fixes: 20fa19027286 ("nfs: add export operations")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > =C2=A0fs/nfs/export.c | 11 +++++++++--
> > =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > index e9c233b6fd20..a10dd5f9d078 100644
> > --- a/fs/nfs/export.c
> > +++ b/fs/nfs/export.c
> > @@ -66,14 +66,21 @@ nfs_fh_to_dentry(struct super_block *sb, struct
> > fid *fid,
> > =C2=A0{
> > =C2=A0	struct nfs_fattr *fattr =3D NULL;
> > =C2=A0	struct nfs_fh *server_fh =3D nfs_exp_embedfh(fid->raw);
> > -	size_t fh_size =3D offsetof(struct nfs_fh, data) +
> > server_fh->size;
> > +	size_t fh_size =3D offsetof(struct nfs_fh, data);
> > =C2=A0	const struct nfs_rpc_ops *rpc_ops;
> > =C2=A0	struct dentry *dentry;
> > =C2=A0	struct inode *inode;
> > -	int len =3D EMBED_FH_OFF + XDR_QUADLEN(fh_size);
> > +	int len =3D EMBED_FH_OFF;
> > =C2=A0	u32 *p =3D fid->raw;
> > =C2=A0	int ret;
> > =C2=A0
> > +	/* Initial check of bounds */
> > +	if (fh_len < len + XDR_QUADLEN(fh_size) ||
> > +	=C2=A0=C2=A0=C2=A0 fh_len > XDR_QUADLEN(NFS_MAXFHSIZE))
> > +		return NULL;
>=20
> May this return ERR_PTR(-EINVAL) instead of NULL?
> I'm not sure if it is expected to be translated as ESTALE.

Technically, knfsd should be returning NFSERR_BADHANDLE in both this
case and in the check below, however there doesn't appear to be a way
to get nfsd_set_fh_dentry() to return that error.

For open_by_handle_at(), the manpage documents the error to be returned
as being ESTALE, and that is enforced in 'do_handle_to_path()'.

>=20
> > +	/* Calculate embedded filehandle size */
> > +	fh_size +=3D server_fh->size;
> > +	len +=3D XDR_QUADLEN(fh_size);
> > =C2=A0	/* NULL translates to ESTALE */
> > =C2=A0	if (fh_len < len || fh_type !=3D len)
> > =C2=A0		return NULL;
>=20

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

