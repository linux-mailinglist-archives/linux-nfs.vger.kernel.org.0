Return-Path: <linux-nfs+bounces-22645-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RkQPIy+iMWrGogUAu9opvQ
	(envelope-from <linux-nfs+bounces-22645-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 21:21:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E596F694F28
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 21:21:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="OGFos/ZC";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22645-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22645-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 013BE304CFD3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA1E3D7D70;
	Tue, 16 Jun 2026 19:21:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD6344D88
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 19:21:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637676; cv=none; b=W7cmwGeTOqIbx0hykFXy0acl71IkWcQTKIDqCbcT7zQmbAPZGjBK0Jb/75akbMoXmK9Qz4ImwHu2yATc6h+mdjFlzTvSiC0YeJA8xSVBt3Vpf/2N6gW0oS1N8wKIrBFGAAWMnyCjrTmW2wkShp/cjnPIHVCzwgzd+IYSTS8FCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637676; c=relaxed/simple;
	bh=8qXWt6AQk31gr3Vm27YveN9uFy5sYv8gNKViKYulMVU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sV4iSdMGnvevKo1flCHJOVr6chSO3VehGxqtetwXoKWzzV0X6j9jmRIZg2uJ9sYiOt8lW+oaAnhLIX9Re7sGqe26zFKBqEp8hB4cYJsy1FT7eHvvmheV5wNwYXd5PhjFu4Y0A12WX3tEfoDbr3Bi+xJzd6MAcjL8599f92H7CkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGFos/ZC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9194B1F000E9;
	Tue, 16 Jun 2026 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781637674;
	bh=BSH3fL07hYwQ9RUcv5XZESVs7myEhciDrJa+vzTRExo=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=OGFos/ZCGcdlX4msplhlXi3CdITSBNOKZyc2Et37ArTDnxi5zOIIeQSXLnS1wqC5X
	 nzL8b5usLvP79o0jsccP1cKQTQW7pveO33gjzwfnFS/C60oy1l4fs0g+VA88PbCJh3
	 L+MOZyL3aAmn8i/EXDYnR1qaOC6/k8cOOa9obWtp3laOLtq3I+tGVKMn2FRPICJTYM
	 jPdxp5qKDoZYLZNKlGDoxVPvGRbjJ6V1eP3CV+itwdg39BKO+JQlkXW8x8Zj65nMeW
	 piejYQntj9db1thXmMGt9UVW0CgD/5EoPTlBvbd9aO0qcherU2wDAi0SchgoR++SL/
	 XpROXgccMSzTg==
Message-ID: <7065e7822237951c1e24f2a10320fe7bde35fed9.camel@kernel.org>
Subject: Re: [PATCH v3 2/3] nfsd: reject out-of-range nseconds in NFSv3
 SETATTR and create ops
From: Jeff Layton <jlayton@kernel.org>
To: robbieko <robbieko@synology.com>, linux-nfs@vger.kernel.org
Date: Tue, 16 Jun 2026 15:21:13 -0400
In-Reply-To: <20260616054027.2360930-2-robbieko@synology.com>
References: <20260616054027.2360930-1-robbieko@synology.com>
	 <20260616054027.2360930-2-robbieko@synology.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robbieko@synology.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22645-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E596F694F28

On Tue, 2026-06-16 at 13:39 +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
>=20
> A client can send an NFSv3 SETATTR, CREATE, MKDIR, SYMLINK or MKNOD
> carrying an atime or mtime whose nseconds field is out of range. The
> value is well-formed on the wire and decodes cleanly into a valid
> uint32, but it is not a valid timespec64: tv_nsec must be less than
> NSEC_PER_SEC.
>=20
> Nothing in the setattr path clamps it. notify_change() runs the time
> through timestamp_truncate(), which does not reduce tv_nsec below
> NSEC_PER_SEC when the filesystem supports nanosecond granularity
> (s_time_gran =3D=3D 1), and the inode atime/mtime setters store it verbat=
im
> (only ctime is normalized, via inode_set_ctime_to_ts()). The
> un-normalized value then corrupts on-disk metadata: ext4's
> ext4_encode_extra_time() shifts tv_nsec left by EXT4_EPOCH_BITS, which
> overflows the 32-bit extra field and clobbers the seconds-epoch bits, so
> the stored seconds (and thus the year) are wrong on read-back. XFS with
> bigtime mis-stores the timestamp for the same reason.
>=20
> Validate the client-supplied atime/mtime in the proc handlers and return
> NFS3ERR_INVAL before anything is changed. RFC 1813 lists NFS3ERR_INVAL
> for SETATTR and describes it as the error for a value the server 'can
> not store ... in its own representation'; the client maps it to EINVAL.
>=20
> Checking in the proc handlers, rather than in nfsd_setattr(), keeps the
> rejection in front of object creation. The create operations create the
> object before nfsd_create_setattr() runs, so a late failure would leave
> the new object behind and turn a non-idempotent request into a namespace
> change that reports failure. The check is therefore done up front, for
> the create operations before the object is created.
>=20
> tv_nsec is a long, so the comparison casts it to unsigned long (the same
> width) rather than to u32, matching timespec64_valid(). A u32 cast would
> truncate on 64-bit; the unsigned long cast also rejects a value that
> became negative when an out-of-range u32 wire nseconds was assigned to a
> 32-bit long.
>=20
> Only client-supplied times are checked: SET_TO_SERVER_TIME requests
> carry no client value. The sattrguard3 ctime is deliberately left alone:
> an out-of-range guard simply never matches the object's ctime and yields
> NFS3ERR_NOT_SYNC via the existing guardtime comparison, which is the
> protocol-correct outcome rather than rejecting the request.
>=20
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/nfsd/nfs3proc.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 42adc5461db0..32d6b51dbe53 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -29,6 +29,25 @@ static int	nfs3_ftypes[] =3D {
>  	S_IFIFO,		/* NF3FIFO */
>  };
> =20
> +/*
> + * Reject a client-supplied atime or mtime whose nanoseconds field is ou=
t
> + * of range. Such a value is well-formed on the wire but is not a valid
> + * timespec64, and storing it verbatim can corrupt on-disk timestamps.
> + * tv_nsec is a long, so it is cast to unsigned long (the same width) to
> + * catch both an over-large value and one that became negative when an
> + * out-of-range u32 wire nseconds was assigned to a 32-bit long.
> + */
> +static bool nfsd3_time_in_range(const struct iattr *iap)
> +{
> +	if ((iap->ia_valid & ATTR_ATIME_SET) &&
> +	    (unsigned long)iap->ia_atime.tv_nsec >=3D NSEC_PER_SEC)
> +		return false;
> +	if ((iap->ia_valid & ATTR_MTIME_SET) &&
> +	    (unsigned long)iap->ia_mtime.tv_nsec >=3D NSEC_PER_SEC)
> +		return false;
> +	return true;
> +}
> +
>  static __be32 nfsd3_map_status(__be32 status)
>  {
>  	switch (status) {
> @@ -101,9 +120,14 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
>  				SVCFH_fmt(&argp->fh));
> =20
>  	fh_copy(&resp->fh, &argp->fh);
> +	if (!nfsd3_time_in_range(&argp->attrs)) {
> +		resp->status =3D nfserr_inval;
> +		goto out;
> +	}
>  	if (argp->check_guard)
>  		guardtime =3D &argp->guardtime;
>  	resp->status =3D nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
> +out:
>  	resp->status =3D nfsd3_map_status(resp->status);
>  	return rpc_success;
>  }
> @@ -265,6 +289,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> =20
>  	trace_nfsd_vfs_create(rqstp, fhp, S_IFREG, argp->name, argp->len);
> =20
> +	if (!nfsd3_time_in_range(iap))
> +		return nfserr_inval;
>  	if (isdotent(argp->name, argp->len))
>  		return nfserr_exist;
>  	if (!(iap->ia_valid & ATTR_MODE))
> @@ -400,8 +426,13 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
>  	argp->attrs.ia_valid &=3D ~ATTR_SIZE;
>  	fh_copy(&resp->dirfh, &argp->fh);
>  	fh_init(&resp->fh, NFS3_FHSIZE);
> +	if (!nfsd3_time_in_range(&argp->attrs)) {
> +		resp->status =3D nfserr_inval;
> +		goto out;
> +	}
>  	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len=
,
>  				   &attrs, S_IFDIR, 0, &resp->fh);
> +out:
>  	resp->status =3D nfsd3_map_status(resp->status);
>  	return rpc_success;
>  }
> @@ -415,6 +446,10 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
>  		.na_iattr	=3D &argp->attrs,
>  	};
> =20
> +	if (!nfsd3_time_in_range(&argp->attrs)) {
> +		resp->status =3D nfserr_inval;
> +		goto out;
> +	}
>  	if (argp->tlen =3D=3D 0) {
>  		resp->status =3D nfserr_inval;
>  		goto out;
> @@ -471,6 +506,11 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
>  		goto out;
>  	}
> =20
> +	if (!nfsd3_time_in_range(&argp->attrs)) {
> +		resp->status =3D nfserr_inval;
> +		goto out;
> +	}
> +
>  	type =3D nfs3_ftypes[argp->ftype];
>  	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len=
,
>  				   &attrs, type, rdev, &resp->fh);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

