Return-Path: <linux-nfs+bounces-6429-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0B97748B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF0DB20B04
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637221C233B;
	Thu, 12 Sep 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z6JiFgl5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QnjukTj6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z6JiFgl5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QnjukTj6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608191C0DEB;
	Thu, 12 Sep 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181557; cv=none; b=QYvUzpF77MyP8nGuDmFkZaqg2bjs1lMDJLhQtWwyxnKKXqkOwQqGemik/D31Hkx1Diy80piM2QxxkpnU00uH072NHjge+Gz89NYxGCUXbsxEoS2XEBzAN94ZtYXEL1QVDvDojsVic1j0WMek82RsrgIQ7iZvL4sFlHE6K+DHsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181557; c=relaxed/simple;
	bh=KzTqOSDUlxlRD7ADWx9PoDz9HKJcKh1SoqouHRiR3mw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hxcARW25I3c5k+3ozVFwZeYRN7WHFNknNp47RJBviRBk2l7jeDHPOFk0NjGNRtwDyYPkkPS/7q59LmCGCbKFeQ3hVY5xj/cxggoYCrEkbXLc7uHdWcMy9xywYQhggwtINW7rGg0Dk07Wyro5TUZA92Gocr52uKBoCZG7WMhDoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z6JiFgl5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QnjukTj6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z6JiFgl5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QnjukTj6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B55881FB9F;
	Thu, 12 Sep 2024 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726181553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9E0rUNPJfwywW28fp/gQGHOmO3iFbDjRnJOCehVTlww=;
	b=z6JiFgl5F6VSpEQIUAzStJzl/LnOZbKHRRN6RcnrWaF0tWNuv98Zeci/KHmVeO/v+0TKGH
	M6mwPavrguB2XoxQyQ5i1HvPdUeXdRjfLDYBuBATrlDyqFkoyS3MM8xRM4q0+Wv38waXZ1
	G/leeOpeiXpz4W0bfBQKMD5IvKVuIYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726181553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9E0rUNPJfwywW28fp/gQGHOmO3iFbDjRnJOCehVTlww=;
	b=QnjukTj6Uf1y9bh1CwfYqIWsjtfQsERqxwE9MpB9ohnrpKL2Uu3PsaRT6fw5X5PZEekEXP
	OUs9LSyfNYAXnkBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726181553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9E0rUNPJfwywW28fp/gQGHOmO3iFbDjRnJOCehVTlww=;
	b=z6JiFgl5F6VSpEQIUAzStJzl/LnOZbKHRRN6RcnrWaF0tWNuv98Zeci/KHmVeO/v+0TKGH
	M6mwPavrguB2XoxQyQ5i1HvPdUeXdRjfLDYBuBATrlDyqFkoyS3MM8xRM4q0+Wv38waXZ1
	G/leeOpeiXpz4W0bfBQKMD5IvKVuIYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726181553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9E0rUNPJfwywW28fp/gQGHOmO3iFbDjRnJOCehVTlww=;
	b=QnjukTj6Uf1y9bh1CwfYqIWsjtfQsERqxwE9MpB9ohnrpKL2Uu3PsaRT6fw5X5PZEekEXP
	OUs9LSyfNYAXnkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0131313A73;
	Thu, 12 Sep 2024 22:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Su1JKq5w42ayGQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 12 Sep 2024 22:52:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
In-reply-to: <20240912221917.23802-1-pali@kernel.org>
References: <20240912221917.23802-1-pali@kernel.org>
Date: Fri, 13 Sep 2024 08:52:20 +1000
Message-id: <172618154004.17050.11278438613021939772@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 13 Sep 2024, Pali Roh=C3=A1r wrote:
> Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not bypass
> only GSS, but bypass any authentication method. This is problem specially
> for NFS3 AUTH_NULL-only exports.
>=20
> The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
> section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> authentication. So few procedures which do not expose security risk used
> during mount time can be called also with AUTH_NONE or AUTH_SYS, to allow
> client mount operation to finish successfully.
>=20
> The problem with current implementation is that for AUTH_NULL-only exports,
> the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX mount
> attempts which confuse NFS3 clients, and make them think that AUTH_UNIX is
> enabled and is working. Linux NFS3 client never switches from AUTH_UNIX to
> AUTH_NONE on active mount, which makes the mount inaccessible.
>=20
> Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT implementation
> and really allow to bypass only exports which have some GSS auth flavor
> enabled.
>=20
> The result would be: For AUTH_NULL-only export if client attempts to do
> mount with AUTH_UNIX flavor then it will receive access errors, which
> instruct client that AUTH_UNIX flavor is not usable and will either try
> other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
>=20
> This should fix problems with AUTH_NULL-only or AUTH_UNIX-only exports if
> client attempts to mount it with other auth flavor (e.g. with AUTH_NULL for
> AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).

The MAY_BYPASS_GSS flag currently also bypasses TLS restrictions.  With
your change it doesn't.  I don't think we want to make that change.

I think that what you want to do makes sense.  Higher security can be
downgraded to AUTH_UNIX, but AUTH_NULL mustn't be upgraded to to
AUTH_UNIX.

Maybe that needs to be explicit in the code.  The bypass is ONLY allowed
for AUTH_UNIX and only if something other than AUTH_NULL is allowed.

Thanks,
NeilBrown



>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  fs/nfsd/export.c   | 19 ++++++++++++++++++-
>  fs/nfsd/export.h   |  2 +-
>  fs/nfsd/nfs4proc.c |  2 +-
>  fs/nfsd/nfs4xdr.c  |  2 +-
>  fs/nfsd/nfsfh.c    | 12 +++++++++---
>  fs/nfsd/vfs.c      |  2 +-
>  6 files changed, 31 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 50b3135d07ac..eb11d3fdffe1 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1074,7 +1074,7 @@ static struct svc_export *exp_find(struct cache_detai=
l *cd,
>  	return exp;
>  }
> =20
> -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, b=
ool may_bypass_gss)
>  {
>  	struct exp_flavor_info *f, *end =3D exp->ex_flavors + exp->ex_nflavors;
>  	struct svc_xprt *xprt =3D rqstp->rq_xprt;
> @@ -1120,6 +1120,23 @@ __be32 check_nfsd_access(struct svc_export *exp, str=
uct svc_rqst *rqstp)
>  	if (nfsd4_spo_must_allow(rqstp))
>  		return 0;
> =20
> +	/* Some calls may be processed without authentication
> +	 * on GSS exports. For example NFS2/3 calls on root
> +	 * directory, see section 2.3.2 of rfc 2623.
> +	 * For "may_bypass_gss" check that export has really
> +	 * enabled some GSS flavor and also check that the
> +	 * used auth flavor is without auth (none or sys).
> +	 */
> +	if (may_bypass_gss && (
> +	     rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_NULL ||
> +	     rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UNIX)) {
> +		for (f =3D exp->ex_flavors; f < end; f++) {
> +			if (f->pseudoflavor =3D=3D RPC_AUTH_GSS ||
> +			    f->pseudoflavor >=3D RPC_AUTH_GSS_KRB5)
> +				return 0;
> +		}
> +	}
> +
>  denied:
>  	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
>  }
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index ca9dc230ae3d..dc7cf4f6ac53 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -100,7 +100,7 @@ struct svc_expkey {
>  #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
> =20
>  int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
> -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
> +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, b=
ool may_bypass_gss);
> =20
>  /*
>   * Function declarations
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2e39cf2e502a..0f67f4a7b8b2 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2791,7 +2791,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> =20
>  			if (current_fh->fh_export &&
>  					need_wrongsec_check(rqstp))
> -				op->status =3D check_nfsd_access(current_fh->fh_export, rqstp);
> +				op->status =3D check_nfsd_access(current_fh->fh_export, rqstp, false);
>  		}
>  encode_op:
>  		if (op->status =3D=3D nfserr_replay_me) {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 97f583777972..b45ea5757652 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3775,7 +3775,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, c=
onst char *name,
>  			nfserr =3D nfserrno(err);
>  			goto out_put;
>  		}
> -		nfserr =3D check_nfsd_access(exp, cd->rd_rqstp);
> +		nfserr =3D check_nfsd_access(exp, cd->rd_rqstp, false);
>  		if (nfserr)
>  			goto out_put;
> =20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index dd4e11a703aa..ed0eabfa3cb0 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -329,6 +329,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, u=
mode_t type, int access)
>  {
>  	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct svc_export *exp =3D NULL;
> +	bool may_bypass_gss =3D false;
>  	struct dentry	*dentry;
>  	__be32		error;
> =20
> @@ -375,8 +376,13 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, =
umode_t type, int access)
>  	 * which clients virtually always use auth_sys for,
>  	 * even while using RPCSEC_GSS for NFS.
>  	 */
> -	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
> +	if (access & NFSD_MAY_LOCK)
>  		goto skip_pseudoflavor_check;
> +	/*
> +	 * NFS4 PUTFH may bypass GSS (see nfsd4_putfh() in nfs4proc.c).
> +	 */
> +	if (access & NFSD_MAY_BYPASS_GSS)
> +		may_bypass_gss =3D true;
>  	/*
>  	 * Clients may expect to be able to use auth_sys during mount,
>  	 * even if they use gss for everything else; see section 2.3.2
> @@ -384,9 +390,9 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, u=
mode_t type, int access)
>  	 */
>  	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
>  			&& exp->ex_path.dentry =3D=3D dentry)
> -		goto skip_pseudoflavor_check;
> +		may_bypass_gss =3D true;
> =20
> -	error =3D check_nfsd_access(exp, rqstp);
> +	error =3D check_nfsd_access(exp, rqstp, may_bypass_gss);
>  	if (error)
>  		goto out;
> =20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29b1f3613800..b2f5ea7c2187 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -320,7 +320,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp,=
 const char *name,
>  	err =3D nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
>  	if (err)
>  		return err;
> -	err =3D check_nfsd_access(exp, rqstp);
> +	err =3D check_nfsd_access(exp, rqstp, false);
>  	if (err)
>  		goto out;
>  	/*
> --=20
> 2.20.1
>=20
>=20


