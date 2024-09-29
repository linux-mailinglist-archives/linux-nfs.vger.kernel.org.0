Return-Path: <linux-nfs+bounces-6699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05559989858
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 00:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1FE1C20DBC
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6C7FBA2;
	Sun, 29 Sep 2024 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hDtqiyD8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0wDXnRmD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DCIgIaEX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vzdrfyIC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497155E48
	for <linux-nfs@vger.kernel.org>; Sun, 29 Sep 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727650525; cv=none; b=D5Phj843P6fe5+T60FP10b8PCqILnTZRWfMzG3bt+e+TE8SCdBkA6t9Bvfv2+2Xgk4/ukhwsJ9xR2Zftjkdm9BGmzf8vbV70vGKzoqqJrYDwVjaQ/F0tQVChaSyc8/S33EtLN5UHilVzBgF+OZb+xRllxFrcYvGOda4JmedeLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727650525; c=relaxed/simple;
	bh=7ENtMod45FtqR8scaO0CMaZGPnQUVQnlB0nK0U3Ek4U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TEuFabSy8Jm2vZ35fy5KQ8JM9eDiNPIJ99a03bWqVBx+5lXeTRPT+B/lwUwREJ2diDQfMsk7eaq3S11uEj1SFTT0upm3gKmCjwoS1ifB6qXydVOySpigaWB/L7oJ1Kx9fjnioelQztJTppw0sBgsFHDG+vN1apC1cMZLlnmgXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hDtqiyD8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0wDXnRmD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DCIgIaEX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vzdrfyIC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1CE4219F9;
	Sun, 29 Sep 2024 22:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727650516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmBQe83kMW0vuHmOCOZwcCm+pD2QdQK9UMYLkCzrKAk=;
	b=hDtqiyD8U3tFmWdDCGMLzbXYjUdYlyGA6BX+cCtMtoiKnY5XT1Jz9yEDfpz9obKjvEOmcS
	LbfZV+szF5X6MrfcxnF7dtVCNxhTvR06ABuEVfFPsccZA/fh+ObzcLAbXeF0abG4c8LNX6
	/LFGmcQ8v0uFWvshqBxv3bsCyyuHCuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727650516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmBQe83kMW0vuHmOCOZwcCm+pD2QdQK9UMYLkCzrKAk=;
	b=0wDXnRmDIzh2rJSdR3Pkgcoxb9vNL2NaPYjer48ZNdsJm7QmdsKOfv0R5rdiyRJkBtX9U7
	rrM3N6fGeTA8YFBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727650515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmBQe83kMW0vuHmOCOZwcCm+pD2QdQK9UMYLkCzrKAk=;
	b=DCIgIaEXZxMM2WYJgvGDm+nW0xPGcx+lHcOtMfZ7JMOol5uZz3JVup5IbUWJy6+yb02ktd
	GoXpwnZazyQ0vjgHlmALWRrT5xaAClRADsNSAkzay7ou4cgjHxpstgnFBGjB3qOF4lj19f
	EuG43C/ZV8hedObtCEXMMBpgYFNS4ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727650515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmBQe83kMW0vuHmOCOZwcCm+pD2QdQK9UMYLkCzrKAk=;
	b=vzdrfyIC8KjA7WNnNIBfEZ0MSVdPNn+SEyA+PY9+4zi+WvXOZC2GciZY4NDwNNMq8yPkfI
	Kg59qFSCYiPJKnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8836B136CB;
	Sun, 29 Sep 2024 22:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b0/ZDtHa+WaGAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 29 Sep 2024 22:55:13 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH] NFSD: Remove unused function parameter
In-reply-to: <20240929162943.10915-1-cel@kernel.org>
References: <20240929162943.10915-1-cel@kernel.org>
Date: Mon, 30 Sep 2024 08:55:01 +1000
Message-id: <172765050138.470955.14527864787896711058@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
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

On Mon, 30 Sep 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Clean up: Commit 65294c1f2c5e ("nfsd: add a new struct file caching
> facility to nfsd") moved the fh_verify() call site out of
> nfsd_open(). That was the only user of nfsd_open's @rqstp parameter,
> so that parameter can be removed.

The above seemed strange to me.  Why would nfsd_open() not need
fh_verify() any more?

What actually happens was that part of nfsd_open() (including the
fh_verify() call) was factored out into __nfsd_open(), and that function
was given the same parameters as nfsd_open(), but didn't use one of
them.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |  3 +--
>  fs/nfsd/vfs.c       | 11 ++++-------
>  fs/nfsd/vfs.h       |  4 ++--
>  3 files changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 19bb88c7eebd..8158406bac18 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1121,8 +1121,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct n=
et *net,
>  			status =3D nfs_ok;
>  			trace_nfsd_file_opened(nf, status);
>  		} else {
> -			ret =3D nfsd_open_verified(rqstp, fhp, may_flags,
> -						 &nf->nf_file);
> +			ret =3D nfsd_open_verified(fhp, may_flags, &nf->nf_file);
>  			if (ret =3D=3D -EOPENSTALE && stale_retry) {
>  				stale_retry =3D false;
>  				nfsd_file_unhash(nf);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 22325b590e17..d0bf4ffa5543 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -861,8 +861,7 @@ int nfsd_open_break_lease(struct inode *inode, int acce=
ss)
>   * N.B. After this call fhp needs an fh_put
>   */
>  static int
> -__nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
> -			int may_flags, struct file **filp)
> +__nfsd_open(struct svc_fh *fhp, umode_t type, int may_flags, struct file *=
*filp)
>  {
>  	struct path	path;
>  	struct inode	*inode;
> @@ -937,7 +936,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, u=
mode_t type,
>  retry:
>  	err =3D fh_verify(rqstp, fhp, type, may_flags);
>  	if (!err) {
> -		host_err =3D __nfsd_open(rqstp, fhp, type, may_flags, filp);
> +		host_err =3D __nfsd_open(fhp, type, may_flags, filp);
>  		if (host_err =3D=3D -EOPENSTALE && !retried) {
>  			retried =3D true;
>  			fh_put(fhp);
> @@ -950,7 +949,6 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, u=
mode_t type,
> =20
>  /**
>   * nfsd_open_verified - Open a regular file for the filecache
> - * @rqstp: RPC request
>   * @fhp: NFS filehandle of the file to open
>   * @may_flags: internal permission flags
>   * @filp: OUT: open "struct file *"
> @@ -958,10 +956,9 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, =
umode_t type,
>   * Returns zero on success, or a negative errno value.
>   */
>  int
> -nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_fla=
gs,
> -		   struct file **filp)
> +nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
>  {
> -	return __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
> +	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
>  }
> =20
>  /*
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 3ff146522556..854fb95dfdca 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -114,8 +114,8 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  int 		nfsd_open_break_lease(struct inode *, int);
>  __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
>  				int, struct file **);
> -int		nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -				   int may_flags, struct file **filp);
> +int		nfsd_open_verified(struct svc_fh *fhp, int may_flags,
> +				struct file **filp);
>  __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct file *file, loff_t offset,
>  				unsigned long *count,
> --=20
> 2.46.2
>=20
>=20


