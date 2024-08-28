Return-Path: <linux-nfs+bounces-5837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2184F961B48
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 03:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A61C2291F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0911CA0;
	Wed, 28 Aug 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f88PGlbo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eFCMQgzP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f88PGlbo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eFCMQgzP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CE17BCE
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807528; cv=none; b=j7BFwyUOU+jEKK3uUq3I7EkcSQLG09Wp2b94bd9lwlcHwLVtyvG5MqMXsKhop/wlF367RISK0lk+hfvSCSPI1qMbSyqAYx93tnbuZ/30wzQM4hqciv0hluoO5fmJfQl4Q1mcD90Fzh1U9b4Oo+NG+d9cjn/dvXSxaLhmkgTLIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807528; c=relaxed/simple;
	bh=4q/ibt7LOfDHpiFVhaSMf6Us82N3ajPq7P9BwnLEFl4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JffYxdwQ6J11oXp4z0GJokspXYgqfPp3lsb/XFReGsereXntRMhQzFnCPo1PmuyEV3NzmFz0/z6D8u4SRIXntnfFrbZ30u6ydqEcgmkcolXHP9nE/4S3xqumU8oyBvUPYVhR+bjOrDX14rpjhCVi5e2Ws+ruyvOoL6MkCnX3jFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f88PGlbo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eFCMQgzP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f88PGlbo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eFCMQgzP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B855821B31;
	Wed, 28 Aug 2024 01:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724807524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSGbcJkvn+E6jcyFphEoRem0FCGJp0/to26GOBPjexo=;
	b=f88PGlbokN3l9CPNr79N4DffFMvZOXFCL3C4IdDqzfnMp8Oc3gNloR4+esunErkFznq0b9
	jLx6IxFO3y3opmWiUGoRhv9+bpnw6BG6sfsHs51n/QjzluCV0s8i6DzGHbhi0Kd5SOAyhT
	3asojgS5ZQ5UlBrQk21uBOFFJFKsAPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724807524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSGbcJkvn+E6jcyFphEoRem0FCGJp0/to26GOBPjexo=;
	b=eFCMQgzPMP21L/sGAjhvNifk2MEzfaOvmOQxCQiQD/uxpGP9OG++VmxyHulkyrAwmWsUyi
	d+HnSbTkCVVFdeAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f88PGlbo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eFCMQgzP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724807524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSGbcJkvn+E6jcyFphEoRem0FCGJp0/to26GOBPjexo=;
	b=f88PGlbokN3l9CPNr79N4DffFMvZOXFCL3C4IdDqzfnMp8Oc3gNloR4+esunErkFznq0b9
	jLx6IxFO3y3opmWiUGoRhv9+bpnw6BG6sfsHs51n/QjzluCV0s8i6DzGHbhi0Kd5SOAyhT
	3asojgS5ZQ5UlBrQk21uBOFFJFKsAPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724807524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSGbcJkvn+E6jcyFphEoRem0FCGJp0/to26GOBPjexo=;
	b=eFCMQgzPMP21L/sGAjhvNifk2MEzfaOvmOQxCQiQD/uxpGP9OG++VmxyHulkyrAwmWsUyi
	d+HnSbTkCVVFdeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8425713724;
	Wed, 28 Aug 2024 01:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W9kkDmN5zmbeTQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Aug 2024 01:12:03 +0000
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
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Subject:
 Re: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in check_nfsd_access()
In-reply-to: <20240828004445.22634-2-cel@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>,
 <20240828004445.22634-2-cel@kernel.org>
Date: Wed, 28 Aug 2024 11:12:00 +1000
Message-id: <172480752028.4433.11727348270307536121@noble.neil.brown.name>
X-Rspamd-Queue-Id: B855821B31
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 28 Aug 2024, cel@kernel.org wrote:
> From: NeilBrown <neilb@suse.de>
>=20
> LOCALIO-initiated open operations are not running in an nfsd thread
> and thus do not have an associated svc_rqst context.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/export.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 7bb4f2075ac5..46a4d989c850 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1074,10 +1074,29 @@ static struct svc_export *exp_find(struct cache_det=
ail *cd,
>  	return exp;
>  }
> =20
> +/**
> + * check_nfsd_access - check if access to export is allowed.
> + * @exp: svc_export that is being accessed.
> + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> + *
> + * Return values:
> + *   %nfs_ok if access is granted, or
> + *   %nfserr_wrongsec if access is denied
> + */
>  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
>  {
>  	struct exp_flavor_info *f, *end =3D exp->ex_flavors + exp->ex_nflavors;
> -	struct svc_xprt *xprt =3D rqstp->rq_xprt;
> +	struct svc_xprt *xprt;
> +
> +	/*
> +	 * The target use case for rqstp being NULL is LOCALIO, which
> +	 * currently only supports AUTH_UNIX. The behavior for LOCALIO
> +	 * is therefore the same as the AUTH_UNIX check below.

The "AUTH_UNIX check below" only applies if exp->ex_flavours =3D=3D 0.
To make "rqstp =3D=3D NULL" mean "treat like AUTH_UNIX" I think we need
to confirm that=20
  exp->ex_xprtsec_mods & NFSEXP_XPRTSEC_NONE
and either
  exp->ex_nflavours =3D=3D 0
or
  one for the exp->ex_flavors->pseudoflavor values is RPC_AUTH_UNIX

I'm not sure that is all really necessary, but if not then we probably
need a better comment...

NeilBrown


> +	 */
> +	if (!rqstp)
> +		return nfs_ok;
> +
> +	xprt =3D rqstp->rq_xprt;
> =20
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
>  		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
> @@ -1098,17 +1117,17 @@ __be32 check_nfsd_access(struct svc_export *exp, st=
ruct svc_rqst *rqstp)
>  ok:
>  	/* legacy gss-only clients are always OK: */
>  	if (exp->ex_client =3D=3D rqstp->rq_gssclient)
> -		return 0;
> +		return nfs_ok;
>  	/* ip-address based client; check sec=3D export option: */
>  	for (f =3D exp->ex_flavors; f < end; f++) {
>  		if (f->pseudoflavor =3D=3D rqstp->rq_cred.cr_flavor)
> -			return 0;
> +			return nfs_ok;
>  	}
>  	/* defaults in absence of sec=3D options: */
>  	if (exp->ex_nflavors =3D=3D 0) {
>  		if (rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_NULL ||
>  		    rqstp->rq_cred.cr_flavor =3D=3D RPC_AUTH_UNIX)
> -			return 0;
> +			return nfs_ok;
>  	}
> =20
>  	/* If the compound op contains a spo_must_allowed op,
> @@ -1118,7 +1137,7 @@ __be32 check_nfsd_access(struct svc_export *exp, stru=
ct svc_rqst *rqstp)
>  	 */
> =20
>  	if (nfsd4_spo_must_allow(rqstp))
> -		return 0;
> +		return nfs_ok;
> =20
>  denied:
>  	return nfserr_wrongsec;
> --=20
> 2.45.2
>=20
>=20


