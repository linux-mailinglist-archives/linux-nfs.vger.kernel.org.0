Return-Path: <linux-nfs+bounces-2754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1A28A0F0D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA8B1F22CD1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F6146A6A;
	Thu, 11 Apr 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0k9VBYe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD714601D;
	Thu, 11 Apr 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830827; cv=none; b=fh4nxlmq/lseSrP2PqwUJndiLs6FaJ03HClIXc+igOfhEGKqkRRoddwX16vlSid7SA09Q+jj3r8Y/EIev7IY6wQ/PwZn+KUOsX8buCBR7dccLEYhRukSPijvWGE9zgyGC43vzi7AqdbdgIiJZ19pquJtUsYDo6uMQ/adQm9tqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830827; c=relaxed/simple;
	bh=xOipst4C5clTz1kuQYWpKSKAIUrDRYTv+kYOAKLHScg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GgzGunrBW4tAEWPtzys266hVgBpEw+/nXH1O1RQoh+u9GrVvs+6hAkjyBfsMfY4Uo4zErQeO4wJrJAHXsGxtnV4aukrD14QHy+ZWGJsm61d3MhLNK8drBENOC3M4bYrfLolJYUipnZb4IRnxBceHyu9EkzZMp7rOA4pk5cuRAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0k9VBYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AB1C433C7;
	Thu, 11 Apr 2024 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712830827;
	bh=xOipst4C5clTz1kuQYWpKSKAIUrDRYTv+kYOAKLHScg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=E0k9VBYekLUSocR2tN2DqotU8TFOhlZ711y7VGJeJ7VRq/Ik2Rs3gCAFD+JyAaYEk
	 Vni3t0SioxlYqbjQxIK7bmmg+9qGa9wu+p/9LT8EEN5BPMx7VdDhZz2FyThnWXtbmX
	 z2vtj8mh25Ubz+rNFNO2OrlIrMmnyuZhZcQRA4X04YuvD3R5at9TdDdd+v15xbiEjE
	 fIPxiznWFIE0jO5TUaEspbq9BJL+PYHLmOyeJyEwk/v6wxcxHgOqfK4qeXBsNjTVJ4
	 8a/Qlig2KXr7v3WTPrI5LWwOtgTfaVpTWd5Ny0hHAvlOwaR841ACNXeofaWLovblOk
	 3xlTKFdF79x+Q==
Message-ID: <267f0fe8665d3f7d89893d163a4cb0b5c215d22f.camel@kernel.org>
Subject: Re: [PATCH] NFSD: fix endianness issue in nfsd4_encode_fattr4
From: Jeff Layton <jlayton@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 11 Apr 2024 06:20:25 -0400
In-Reply-To: <patch.git-0ff58649313e.your-ad-here.call-01712828617-ext-4049@work.hours>
References: 
	<patch.git-0ff58649313e.your-ad-here.call-01712828617-ext-4049@work.hours>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 11:45 +0200, Vasily Gorbik wrote:
> The nfs4 mount fails with EIO on 64-bit big endian architectures since
> v6.7. The issue arises from employing a union in the nfsd4_encode_fattr4(=
)
> function to overlay a 32-bit array with a 64-bit values based bitmap,
> which does not function as intended. Address the endianness issue by
> utilizing bitmap_from_arr32() to copy 32-bit attribute masks into a
> bitmap in an endianness-agnostic manner.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: fce7913b13d0 ("NFSD: Use a bitmask loop to encode FATTR4 results")
> Link: https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2060217
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  fs/nfsd/nfs4xdr.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 10439d569d9c..85d43b3249f9 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3519,11 +3519,13 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struc=
t xdr_stream *xdr,
>  		    struct dentry *dentry, const u32 *bmval,
>  		    int ignore_crossmnt)
>  {
> +	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
>  	struct nfsd4_fattr_args args;
>  	struct svc_fh *tempfh =3D NULL;
>  	int starting_len =3D xdr->buf->len;
>  	__be32 *attrlen_p, status;
>  	int attrlen_offset;
> +	u32 attrmask[3];
>  	int err;
>  	struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
>  	u32 minorversion =3D resp->cstate.minorversion;
> @@ -3531,10 +3533,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct=
 xdr_stream *xdr,
>  		.mnt	=3D exp->ex_path.mnt,
>  		.dentry	=3D dentry,
>  	};
> -	union {
> -		u32		attrmask[3];
> -		unsigned long	mask[2];
> -	} u;
>  	unsigned long bit;
>  	bool file_modified =3D false;
>  	u64 size =3D 0;
> @@ -3550,20 +3548,19 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struc=
t xdr_stream *xdr,
>  	/*
>  	 * Make a local copy of the attribute bitmap that can be modified.
>  	 */
> -	memset(&u, 0, sizeof(u));
> -	u.attrmask[0] =3D bmval[0];
> -	u.attrmask[1] =3D bmval[1];
> -	u.attrmask[2] =3D bmval[2];
> +	attrmask[0] =3D bmval[0];
> +	attrmask[1] =3D bmval[1];
> +	attrmask[2] =3D bmval[2];
> =20
>  	args.rdattr_err =3D 0;
>  	if (exp->ex_fslocs.migrated) {
> -		status =3D fattr_handle_absent_fs(&u.attrmask[0], &u.attrmask[1],
> -						&u.attrmask[2], &args.rdattr_err);
> +		status =3D fattr_handle_absent_fs(&attrmask[0], &attrmask[1],
> +						&attrmask[2], &args.rdattr_err);
>  		if (status)
>  			goto out;
>  	}
>  	args.size =3D 0;
> -	if (u.attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> +	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>  		status =3D nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
>  					&file_modified, &size);
>  		if (status)
> @@ -3582,16 +3579,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struc=
t xdr_stream *xdr,
> =20
>  	if (!(args.stat.result_mask & STATX_BTIME))
>  		/* underlying FS does not offer btime so we can't share it */
> -		u.attrmask[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
> -	if ((u.attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FRE=
E |
> +		attrmask[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
> +	if ((attrmask[0] & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE =
|
>  			FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
> -	    (u.attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FRE=
E |
> +	    (attrmask[1] & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE =
|
>  		       FATTR4_WORD1_SPACE_TOTAL))) {
>  		err =3D vfs_statfs(&path, &args.statfs);
>  		if (err)
>  			goto out_nfserr;
>  	}
> -	if ((u.attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
> +	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
>  	    !fhp) {
>  		tempfh =3D kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
>  		status =3D nfserr_jukebox;
> @@ -3606,10 +3603,10 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struc=
t xdr_stream *xdr,
>  		args.fhp =3D fhp;
> =20
>  	args.acl =3D NULL;
> -	if (u.attrmask[0] & FATTR4_WORD0_ACL) {
> +	if (attrmask[0] & FATTR4_WORD0_ACL) {
>  		err =3D nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
>  		if (err =3D=3D -EOPNOTSUPP)
> -			u.attrmask[0] &=3D ~FATTR4_WORD0_ACL;
> +			attrmask[0] &=3D ~FATTR4_WORD0_ACL;
>  		else if (err =3D=3D -EINVAL) {
>  			status =3D nfserr_attrnotsupp;
>  			goto out;
> @@ -3621,17 +3618,17 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struc=
t xdr_stream *xdr,
> =20
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  	args.context =3D NULL;
> -	if ((u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
> -	     u.attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
> +	if ((attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
> +	     attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
>  		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
>  			err =3D security_inode_getsecctx(d_inode(dentry),
>  						&args.context, &args.contextlen);
>  		else
>  			err =3D -EOPNOTSUPP;
>  		args.contextsupport =3D (err =3D=3D 0);
> -		if (u.attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
> +		if (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) {
>  			if (err =3D=3D -EOPNOTSUPP)
> -				u.attrmask[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> +				attrmask[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
>  			else if (err)
>  				goto out_nfserr;
>  		}
> @@ -3639,8 +3636,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct =
xdr_stream *xdr,
>  #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
> =20
>  	/* attrmask */
> -	status =3D nfsd4_encode_bitmap4(xdr, u.attrmask[0],
> -				      u.attrmask[1], u.attrmask[2]);
> +	status =3D nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
> +				      attrmask[2]);
>  	if (status)
>  		goto out;
> =20
> @@ -3649,7 +3646,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct =
xdr_stream *xdr,
>  	attrlen_p =3D xdr_reserve_space(xdr, XDR_UNIT);
>  	if (!attrlen_p)
>  		goto out_resource;
> -	for_each_set_bit(bit, (const unsigned long *)&u.mask,
> +	bitmap_from_arr32(attr_bitmap, attrmask,
> +			  ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
> +	for_each_set_bit(bit, attr_bitmap,
>  			 ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
>  		status =3D nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
>  		if (status !=3D nfs_ok)

I learned something new today -- I wasn't aware of lib/bitmap.c! This
looks like a nice cleanup too. The union was sort of nasty.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

