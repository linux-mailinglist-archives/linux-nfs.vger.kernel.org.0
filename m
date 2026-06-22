Return-Path: <linux-nfs+bounces-22757-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o2L1J5wjOWqBnQcAu9opvQ
	(envelope-from <linux-nfs+bounces-22757-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 13:59:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1FE6AF415
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 13:59:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JGa1AVG6;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22757-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22757-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4BD830214E6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5732DF3EA;
	Mon, 22 Jun 2026 11:59:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E38274B2A
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 11:59:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129562; cv=none; b=Nn7KrFDiP6UFM0c28/ONsaM/kr6BJWJ24uafaAKuUVD46J1PTzb9plPNOVkZf1dolsqvcAvAGIWjDD2RUV2eu4JCOoS9oow6t121Y4dz9asGncNQg+bW2uCJqy9olwv2QaP0HZaSAvANSW57lPB4zGabIZr2udTZjmKLXnxTTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129562; c=relaxed/simple;
	bh=hmRC8uh3q6fb50i8kvzlJ4O/7QwrmHfO9GGzohpmH2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fARYcyrvKG9YbK8bIRsvYZAAPyF+YT4VXaF6VWyhAWIqYtCEzr/6pn+0lm/DhNFYASIXyXp/xjUHRU1jtxVZWJKEoIRlvYFsvAcfiewn6fmOb2LYnrf3BufowaLUfpK0apiKXPc2V4/QXCPdKaO5Xp9+fiA+sEZgE7+sP4pXiSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGa1AVG6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C23E1F000E9;
	Mon, 22 Jun 2026 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782129560;
	bh=J0VwTXkX2nxC9TXW9DQd2MSgNFm7D3wtEbZqHrjGtoY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JGa1AVG6nSOgoUx7mi+2K6TDDFYvm7QpfvQ3VEwERTQejlgp/eUi7qzUjVpNdRIZZ
	 jo039PH1lGtnlBlMIYcO16dNGiy7+zPEnNFLoLIoIodYPKjtvVhjUbO3kvsaLIKKM+
	 f9oxmbHBjxbescuaacw9d8JHjNED7TaN+BN1U1nDK+RS/HOrJnqCOuHX8eWOburSdL
	 PcBc9ooxReLj6Ht4XGokWj5MO24nRPbE1+BSvTIS+GteW17ugulQ0PNhPiK1KkeeVB
	 g4oVVxLdubNr3WEbDLdISp1jDVXLEPVsyWFkpP3CI/RXMqu1RY0PSzyHx/zc6cllhh
	 BMiVP2CGYKQww==
Message-ID: <de822160263e860b3b85589372712cd5e9deabca.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Replace isdotent() macro
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 22 Jun 2026 07:59:18 -0400
In-Reply-To: <20260621213535.539450-1-cel@kernel.org>
References: <20260621213535.539450-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22757-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC1FE6AF415

On Sun, 2026-06-21 at 17:35 -0400, Chuck Lever wrote:
> The VFS provides name_is_dot_dotdot() as the canonical helper for
> recognizing the "." and ".." directory entries, and fs/ already uses
> it widely. nfsd has instead carried its own open-coded isdotent()
> macro that computes the same predicate for non-empty names, a needless
> duplicate of shared functionality. The macro reads the first name byte
> without first confirming the name is non-empty; name_is_dot_dotdot()
> tests the length first, so it never touches a zero-length buffer.
> Convert every isdotent() call site to the generic helper and remove the
> macro.
>=20
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  fs/nfsd/nfs3proc.c |  2 +-
>  fs/nfsd/nfs3xdr.c  |  2 +-
>  fs/nfsd/nfs4proc.c |  2 +-
>  fs/nfsd/nfs4xdr.c  |  4 ++--
>  fs/nfsd/nfsd.h     |  3 ---
>  fs/nfsd/nfsproc.c  |  2 +-
>  fs/nfsd/vfs.c      | 13 +++++++------
>  7 files changed, 13 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 42adc5461db0..a14827cfeeb8 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -265,7 +265,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> =20
>  	trace_nfsd_vfs_create(rqstp, fhp, S_IFREG, argp->name, argp->len);
> =20
> -	if (isdotent(argp->name, argp->len))
> +	if (name_is_dot_dotdot(argp->name, argp->len))
>  		return nfserr_exist;
>  	if (!(iap->ia_valid & ATTR_MODE))
>  		iap->ia_mode =3D 0;
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 2ff9a991a8fb..e481804bb120 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -987,7 +987,7 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct =
svc_fh *fhp,
>  	dparent =3D cd->fh.fh_dentry;
>  	exp  =3D cd->fh.fh_export;
> =20
> -	if (isdotent(name, namlen)) {
> +	if (name_is_dot_dotdot(name, namlen)) {
>  		if (namlen =3D=3D 2) {
>  			dchild =3D dget_parent(dparent);
>  			/*
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 907b899a90da..654705d1dd37 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -259,7 +259,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	__be32 status;
>  	int host_err;
> =20
> -	if (isdotent(open->op_fname, open->op_fnamelen))
> +	if (name_is_dot_dotdot(open->op_fname, open->op_fnamelen))
>  		return nfserr_exist;
>  	if (!(iap->ia_valid & ATTR_MODE))
>  		iap->ia_mode =3D 0;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 2a0946c630e1..8db16a30d971 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -98,7 +98,7 @@ check_filename(char *str, int len)
>  		return nfserr_inval;
>  	if (len > NFS4_MAXNAMLEN)
>  		return nfserr_nametoolong;
> -	if (isdotent(str, len))
> +	if (name_is_dot_dotdot(str, len))
>  		return nfserr_badname;
>  	for (i =3D 0; i < len; i++)
>  		if (str[i] =3D=3D '/')
> @@ -4241,7 +4241,7 @@ nfsd4_encode_entry4(void *ccdv, const char *name, i=
nt namlen,
>  	__be32 nfserr =3D nfserr_toosmall;
> =20
>  	/* In nfsv4, "." and ".." never make it onto the wire.. */
> -	if (name && isdotent(name, namlen)) {
> +	if (name && name_is_dot_dotdot(name, namlen)) {
>  		cd->common.err =3D nfs_ok;
>  		return 0;
>  	}
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 7c009f07c90b..faf5c1dafa42 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -372,9 +372,6 @@ enum {
>  #define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
>  };
> =20
> -/* Check for dir entries '.' and '..' */
> -#define isdotent(n, l)	(l < 3 && n[0] =3D=3D '.' && (l =3D=3D 1 || n[1] =
=3D=3D '.'))
> -
>  #ifdef CONFIG_NFSD_V4
> =20
>  /* before processing a COMPOUND operation, we have to check that there
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 8873033d1e82..846506445ff9 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -298,7 +298,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	/* Check for NFSD_MAY_WRITE in nfsd_create if necessary */
> =20
>  	resp->status =3D nfserr_exist;
> -	if (isdotent(argp->name, argp->len))
> +	if (name_is_dot_dotdot(argp->name, argp->len))
>  		goto done;
>  	hosterr =3D fh_want_write(dirfhp);
>  	if (hosterr) {
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index eafdf7b7890f..73506e924dc3 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -255,7 +255,7 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  	exp =3D exp_get(fhp->fh_export);
> =20
>  	/* Lookup the name, but don't follow links */
> -	if (isdotent(name, len)) {
> +	if (name_is_dot_dotdot(name, len)) {
>  		if (len=3D=3D1)
>  			dentry =3D dget(dparent);
>  		else if (dparent !=3D exp->ex_path.dentry)
> @@ -1867,7 +1867,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> =20
>  	trace_nfsd_vfs_create(rqstp, fhp, type, fname, flen);
> =20
> -	if (isdotent(fname, flen))
> +	if (name_is_dot_dotdot(fname, flen))
>  		return nfserr_exist;
> =20
>  	err =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_NOP);
> @@ -1969,7 +1969,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  	if (!flen || path[0] =3D=3D '\0')
>  		goto out;
>  	err =3D nfserr_exist;
> -	if (isdotent(fname, flen))
> +	if (name_is_dot_dotdot(fname, flen))
>  		goto out;
> =20
>  	err =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
> @@ -2046,7 +2046,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
>  	if (!len)
>  		goto out;
>  	err =3D nfserr_exist;
> -	if (isdotent(name, len))
> +	if (name_is_dot_dotdot(name, len))
>  		goto out;
> =20
>  	err =3D nfs_ok;
> @@ -2157,7 +2157,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>  	tdentry =3D tfhp->fh_dentry;
> =20
>  	err =3D nfserr_perm;
> -	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
> +	if (!flen || name_is_dot_dotdot(fname, flen) ||
> +	    !tlen || name_is_dot_dotdot(tname, tlen))
>  		goto out;
> =20
>  	err =3D nfserr_xdev;
> @@ -2279,7 +2280,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  	trace_nfsd_vfs_unlink(rqstp, fhp, fname, flen);
> =20
>  	err =3D nfserr_acces;
> -	if (!flen || isdotent(fname, flen))
> +	if (!flen || name_is_dot_dotdot(fname, flen))
>  		goto out;
>  	err =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_REMOVE);
>  	if (err)

Reviewed-by: Jeff Layton <jlayton@kernel.org>

