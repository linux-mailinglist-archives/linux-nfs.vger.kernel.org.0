Return-Path: <linux-nfs+bounces-7255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A59A2F34
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 23:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B661A1F24930
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A1B22911B;
	Thu, 17 Oct 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LAtToXI4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tmwyo8Qg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LAtToXI4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tmwyo8Qg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C6227B91
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199195; cv=none; b=UtzgrTMxVaYfog8dB1QafFcPK7aJ9+tsez6H+iMDxa6jcZJ7imn0jtiEVbbwCl/srgVeEVLinT5Voa80Nm0K4YKa4F8zU76FekxwyusR+R69SAV4xRc/9lz7j1rBu2xOo9b7nYFow1yS9H2IkZ80quhJGa4w0LpIMbcGBppHWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199195; c=relaxed/simple;
	bh=/kuh0Y0ckw0j7UU3wlcwmG+Wr8itGavLjyWFcc8JdH0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=e+FuChJ9Q04y7cXX/qg0cVWHVISNkrdpI1DtbXFBO8I163hnefw1qEH3Xsgbb8TH3fq+Y9kwDy5Id+Pvp+QYekQrgjyV4RcHoDz6pcW19ZGK1GWNehpyNlCje2XyEnhf46ah5f+xoz72xrnLOeGXqZvIYeOP0qXZirlaNrizPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LAtToXI4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tmwyo8Qg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LAtToXI4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tmwyo8Qg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85A0921B7C;
	Thu, 17 Oct 2024 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729199191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMJItEGrGUwkqkpBjCfW1qSMCr1VQLvBFLSGqiw9j6U=;
	b=LAtToXI4/byU4UYTL2z8u/CLxtLc2Bvx+6g7kEwnky9TA4FqM6Apy7Z6efcejsfvC0xOFC
	MEDEQ0j2beENVmaZPdsecJoObyPK+KXu6mRTqPey9S37N5ayrArArgpglpm0c+8zrivRQ5
	HUxY/Z6E2Oh3alxTMKPv+/w6S0KrG5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729199191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMJItEGrGUwkqkpBjCfW1qSMCr1VQLvBFLSGqiw9j6U=;
	b=Tmwyo8Qgk4BWQv8MufyAjrZM9eYQAt9CeU0gtE/e7T/FBg/cAAPTWbeJh73i3fiGcqHsE0
	lRFSZ+CwmlXEQxBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729199191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMJItEGrGUwkqkpBjCfW1qSMCr1VQLvBFLSGqiw9j6U=;
	b=LAtToXI4/byU4UYTL2z8u/CLxtLc2Bvx+6g7kEwnky9TA4FqM6Apy7Z6efcejsfvC0xOFC
	MEDEQ0j2beENVmaZPdsecJoObyPK+KXu6mRTqPey9S37N5ayrArArgpglpm0c+8zrivRQ5
	HUxY/Z6E2Oh3alxTMKPv+/w6S0KrG5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729199191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMJItEGrGUwkqkpBjCfW1qSMCr1VQLvBFLSGqiw9j6U=;
	b=Tmwyo8Qgk4BWQv8MufyAjrZM9eYQAt9CeU0gtE/e7T/FBg/cAAPTWbeJh73i3fiGcqHsE0
	lRFSZ+CwmlXEQxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A67813A42;
	Thu, 17 Oct 2024 21:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7fEuNFR8EWeVFAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 17 Oct 2024 21:06:28 +0000
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
Subject: Re: [PATCH 4/5] lockd: Remove unused parameter to nlmsvc_testlock()
In-reply-to: <20241017133631.213274-5-cel@kernel.org>
References: <20241017133631.213274-1-cel@kernel.org>,
 <20241017133631.213274-5-cel@kernel.org>
Date: Fri, 18 Oct 2024 08:06:26 +1100
Message-id: <172919918623.81717.17799856197257053932@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 18 Oct 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> This parameter has been unused since commit 09802fd2a8ca ("lockd:
> rip out deferred lock handling from testlock codepath").

It's a minor point, but the parameter is described as "unused" and
"this" but never as "cookie" or "nlm_cookie".  So I enter the code
section of the patch not being entirely sure what is being removed.

NeilBrown


>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/lockd/svc4proc.c         | 3 ++-
>  fs/lockd/svclock.c          | 2 +-
>  fs/lockd/svcproc.c          | 3 ++-
>  include/linux/lockd/lockd.h | 6 +++---
>  4 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 1d0400d94b3d..2cb603013111 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -108,7 +108,8 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_=
res *resp)
> =20
>  	test_owner =3D argp->lock.fl.c.flc_owner;
>  	/* Now check for conflicting locks */
> -	resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->l=
ock, &resp->cookie);
> +	resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock,
> +				       &resp->lock);
>  	if (resp->status =3D=3D nlm_drop_reply)
>  		rc =3D rpc_drop_reply;
>  	else
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 1f2149db10f2..33e1fd159934 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -609,7 +609,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *fi=
le,
>  __be32
>  nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
>  		struct nlm_host *host, struct nlm_lock *lock,
> -		struct nlm_lock *conflock, struct nlm_cookie *cookie)
> +		struct nlm_lock *conflock)
>  {
>  	int			error;
>  	int			mode;
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index d959a5dbe0ae..f53d5177f267 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -130,7 +130,8 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_r=
es *resp)
>  	test_owner =3D argp->lock.fl.c.flc_owner;
> =20
>  	/* Now check for conflicting locks */
> -	resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lo=
ck, &resp->lock, &resp->cookie));
> +	resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host,
> +						   &argp->lock, &resp->lock));
>  	if (resp->status =3D=3D nlm_drop_reply)
>  		rc =3D rpc_drop_reply;
>  	else
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index 61c4b9c41904..c8f0f9458f2c 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -278,9 +278,9 @@ __be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_fil=
e *,
>  			      struct nlm_host *, struct nlm_lock *, int,
>  			      struct nlm_cookie *, int);
>  __be32		  nlmsvc_unlock(struct net *net, struct nlm_file *, struct nlm_loc=
k *);
> -__be32		  nlmsvc_testlock(struct svc_rqst *, struct nlm_file *,
> -			struct nlm_host *, struct nlm_lock *,
> -			struct nlm_lock *, struct nlm_cookie *);
> +__be32		  nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
> +			struct nlm_host *host, struct nlm_lock *lock,
> +			struct nlm_lock *conflock);
>  __be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, struct=
 nlm_lock *);
>  void		  nlmsvc_retry_blocked(struct svc_rqst *rqstp);
>  void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
> --=20
> 2.46.2
>=20
>=20


