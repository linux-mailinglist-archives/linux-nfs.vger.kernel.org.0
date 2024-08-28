Return-Path: <linux-nfs+bounces-5846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594DC961DD0
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 07:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C001C224A3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 05:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5B2E62C;
	Wed, 28 Aug 2024 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XD+YzJXK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k1FwmxhP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xxms5+YA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WG5Pjwn0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68A18D
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821388; cv=none; b=BnafQ5egOwIJypeWlGtHhG1S6H1bsf710hhuJjm9Bc67zD+4neMSte0AS90QYx/IHrskv0tNuvUOITwTpvqPt6fB4pdEiGkxFW+sKTEMK7D0GyWSrDv78rqJxSn3YQAcO602gQDl52OCglUXUq6dOZwyZaFAEln7yZd4TuXn/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821388; c=relaxed/simple;
	bh=o4N2a/ykZzKSiZxqluwBs2l3hn29jUovE7tqZraFTnM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Bf2ZAITzAe30oG+lnrQGEmA5W56FKg0XTq2Fs+8w+yrn1sg0J2bvsAsb9Tczw9W6xJVRddX41zK1+654HQTjM7TDIv4idz5VnTvSZnBQjC+ST8iGrvgp8Nh5pTNewcUU87DHjwXyvF/FD99QuTdgFsxc89dhtKblvdax9II32Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XD+YzJXK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k1FwmxhP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xxms5+YA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WG5Pjwn0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29A291FBB4;
	Wed, 28 Aug 2024 05:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724821384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFVlV6G+cBQiv5LiWbR6WM+5VMsovIxBhdL/r8xrlkg=;
	b=XD+YzJXKxaHW8W/Z1y9W22Ag/hx7Ut9EbY7ZbzIomRIYhTkBKfPd/C5/K8I7IDS42rV8Cm
	Kr/R/VeHcgTBOWx8U/pgJ9wWceDYVappCIDUrkbge/fMb+Vh0Nl1MdmsDDWTNrrjNIZFTT
	M+1OP215qSlsfwNUusm+2prYJlQ268I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724821384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFVlV6G+cBQiv5LiWbR6WM+5VMsovIxBhdL/r8xrlkg=;
	b=k1FwmxhPOJ/4GAZBHcfrGss7KndNNxJReRLb0FYMWg/9cy+YeZs9Ncrm9qEzS5IrfaEWki
	htPjThubpFE/aJDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xxms5+YA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WG5Pjwn0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724821383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFVlV6G+cBQiv5LiWbR6WM+5VMsovIxBhdL/r8xrlkg=;
	b=Xxms5+YABeggcVvYEdoqRuhElrfsH52G95z5cLt65hVxANA48JySS9Pt7fhtDi4VEHZd0P
	HmNXeyaUmTy0lnh/IsjPgyfeJ7muSWPR8JRH8PHLWJMympbUsHdh/2cRyW/Zi9W3mlJO+8
	54kN4M68P+r8qpCQTDXOmjS1/DXWAoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724821383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFVlV6G+cBQiv5LiWbR6WM+5VMsovIxBhdL/r8xrlkg=;
	b=WG5Pjwn0CAhHqqHCGPxoVjaB+6pBgHxOnq/qeecbBvqF5NMV1ERaMq06sav/JdqLKklMkr
	KurST200Bbl/BGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A36F113724;
	Wed, 28 Aug 2024 05:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wGdLFoWvzma5CgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Aug 2024 05:03:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: cel@kernel.org
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [RFC PATCH 3/6] NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
In-reply-to: <20240828004445.22634-4-cel@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>,
 <20240828004445.22634-4-cel@kernel.org>
Date: Wed, 28 Aug 2024 15:02:42 +1000
Message-id: <172482136244.4433.13629516052198910622@noble.neil.brown.name>
X-Rspamd-Queue-Id: 29A291FBB4
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,oracle.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Wed, 28 Aug 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Currently, fh_verify() makes some daring assumptions about which
> version of file handle the caller wants, based on the things it can
> find in the passed-in rqstp. The about-to-be-introduced LOCALIO use
> case sometimes has no svc_rqst context, so this logic won't work in
> that case.
>=20
> Instead, examine the passed-in file handle. It's .max_size field
> should carry information to allow nfsd_set_fh_dentry() to initialize
> the file handle appropriately.
>=20
> lockd appears to be the only kernel consumer that does not set the
> file handle .max_size when during initialization.
>=20
> write_filehandle() is the other question mark, as it looks possible
> to specify a maxsize between NFS_FHSIZE and NFS3_FHSIZE here.

The file handle used by lockd and the one created by write_filehandle
never need any of the version-specific fields.
Those fields affect things like write requests and getattr requests and
pre/post attributes.

I wonder if the filehandle is really the best place of these flag.
Having them in the file handle works really well for fh_fill_pre_attrs()
and reasonably well in other places, But it makes nfsd_set_fh_dentry a
little clumsy.  Maybe it would be better to moved them to
rqstp->rq_flags.  Or possibly in the "Catering to nfsd" section of
'struct svc_rqst'.

NeilBrown


>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/lockd.c |  6 ++++--
>  fs/nfsd/nfsfh.c | 11 +++++++----
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 46a7f9b813e5..e636d2a1e664 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -32,8 +32,10 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, stru=
ct file **filp,
>  	int		access;
>  	struct svc_fh	fh;
> =20
> -	/* must initialize before using! but maxsize doesn't matter */
> -	fh_init(&fh,0);
> +	if (rqstp->rq_vers =3D=3D 4)
> +		fh_init(&fh, NFS3_FHSIZE);
> +	else
> +		fh_init(&fh, NFS_FHSIZE);
>  	fh.fh_handle.fh_size =3D f->size;
>  	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
>  	fh.fh_export =3D NULL;
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 4b964a71a504..77acc26e8b02 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -267,25 +267,28 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct svc_fh *fhp)
>  	fhp->fh_dentry =3D dentry;
>  	fhp->fh_export =3D exp;
> =20
> -	switch (rqstp->rq_vers) {
> -	case 4:
> +	switch (fhp->fh_maxsize) {
> +	case NFS4_FHSIZE:
>  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
>  			fhp->fh_no_atomic_attr =3D true;
>  		fhp->fh_64bit_cookies =3D true;
>  		break;
> -	case 3:
> +	case NFS3_FHSIZE:
>  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
>  			fhp->fh_no_wcc =3D true;
>  		fhp->fh_64bit_cookies =3D true;
>  		if (exp->ex_flags & NFSEXP_V4ROOT)
>  			goto out;
>  		break;
> -	case 2:
> +	case NFS_FHSIZE:
>  		fhp->fh_no_wcc =3D true;
>  		if (EX_WGATHER(exp))
>  			fhp->fh_use_wgather =3D true;
>  		if (exp->ex_flags & NFSEXP_V4ROOT)
>  			goto out;
> +		break;
> +	case 0:
> +		WARN_ONCE(1, "Uninitialized file handle");
>  	}
> =20
>  	return 0;
> --=20
> 2.45.2
>=20
>=20


