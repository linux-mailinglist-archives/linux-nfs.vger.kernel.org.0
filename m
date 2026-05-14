Return-Path: <linux-nfs+bounces-21620-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHpTNJ4mBmqmfgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21620-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 21:46:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1D95467C5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 21:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2510300A3BE
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F038F951;
	Thu, 14 May 2026 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUr75k0I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3430F958
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787974; cv=none; b=gFGbiXvki6royu83WbJaCvumDdtfjQ83cQIVTT8riKZA4Dj4PmUIeWabVakE8Pap2wPxuxm2yCv8OeLB1jKjQX+RHQyBs8RsXJs2G2ccc3fEgPIe1nhPy1g7DTgg4WkACgMsH8QET5lyXC3CvbT9DD031xTnGFt7j4gTotS5UpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787974; c=relaxed/simple;
	bh=/ltOGHUI2+wt5qRyhJ7bRn2Ofwu7rrZ3ZjawEsUFEaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWSHrV1+jygN2g6zo6RPyGFBJecnMOjMm6lLLgb0eXCRTRfltNLmE1QHwU6gN2dqXbQtJDhMxrp3JSx5IyABrcxPIvXvLFXju9xFEW3f1l+dFDV+ELTcCV6Xdzx2Z+PgoFpuPEHbJC3WJFM+gcYHxTZxcaNLipLr6F4pzHwkWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUr75k0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6564CC2BCB3;
	Thu, 14 May 2026 19:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778787974;
	bh=/ltOGHUI2+wt5qRyhJ7bRn2Ofwu7rrZ3ZjawEsUFEaA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UUr75k0Iovsmoj6WpUlBhHsIoWbQ48FspnWJyX4ouHpwMTCajJPTBlS5s/grU3P1Z
	 Kf/g5TnKH9YTufNOrlQw5E7YAefk2Kb3JETiloCNpcISWeI4onkn+bN7kl056LRJal
	 8MmIAAFp5PKO6nsN126MCnYf3bFZje++qW5CRU6TEFFlADtGRKSQWppW4z151P2Iaw
	 Rr1s2sjFuEs2UhO6hVr7e2d/ajNPhUR2MJp7ehrEOMOAdIg7kOcl9xu0ryZpy2HXD5
	 5mLrqIs+5AFpz0QjRmE6+2leM/pGo33xWXcbypcipS9FoNmzxrDl1d5H+zTuGJ6+PJ
	 TRrlMrRMifyHg==
Message-ID: <fd6c3e678669a0abdd32e17f3a519c38e5c1166d.camel@kernel.org>
Subject: Re: [PATCH] exportfs: drop unused is_export parameter from
 xtab_read() and xtab_write()
From: Jeff Layton <jlayton@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 14 May 2026 15:46:07 -0400
In-Reply-To: <20260514-exportd-v1-1-be603d7fac41@kernel.org>
References: <20260514-exportd-v1-1-be603d7fac41@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3E1D95467C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21620-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Oops, I meant to make this '[nfs-utils PATCH]'. Ahh well, anyway, it's
just a bit of cleanup...

-- Jeff


On Thu, 2026-05-14 at 15:40 -0400, Jeff Layton wrote:
> The is_export parameter is always passed as 1. Remove it and simplify
> both functions by eliminating the dead is_export =3D=3D 0 code paths.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  support/export/xtab.c | 39 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)
>=20
> diff --git a/support/export/xtab.c b/support/export/xtab.c
> index 282f15bc79cd..0a9660512b26 100644
> --- a/support/export/xtab.c
> +++ b/support/export/xtab.c
> @@ -33,11 +33,8 @@ int v4root_needed;
>  static void cond_rename(char *newfile, char *oldfile);
> =20
>  static int
> -xtab_read(char *xtab, char *lockfn, int is_export)
> +xtab_read(char *xtab, char *lockfn)
>  {
> -    /* is_export =3D=3D 0  =3D> reading /proc/fs/nfs/exports - we know t=
hese things are exported to kernel
> -     * is_export =3D=3D 1  =3D> reading /var/lib/nfs/etab - these things=
 are allowed to be exported
> -     */
>  	struct exportent	*xp;
>  	nfs_export		*exp;
>  	int			lockid;
> @@ -45,11 +42,10 @@ xtab_read(char *xtab, char *lockfn, int is_export)
>  	if ((lockid =3D xflock(lockfn, "r")) < 0)
>  		return 0;
>  	setexportent(xtab, "r");
> -	if (is_export =3D=3D 1)
> -		v4root_needed =3D 1;
> -	while ((xp =3D getexportent(is_export=3D=3D0)) !=3D NULL) {
> -		if (!(exp =3D export_lookup(xp->e_hostname, xp->e_path, is_export !=3D=
 1)) &&
> -		    !(exp =3D export_create(xp, is_export!=3D1))) {
> +	v4root_needed =3D 1;
> +	while ((xp =3D getexportent(0)) !=3D NULL) {
> +		if (!(exp =3D export_lookup(xp->e_hostname, xp->e_path, 0)) &&
> +		    !(exp =3D export_create(xp, 0))) {
>                          if(xp->e_hostname) {
>                              free(xp->e_hostname);
>                              xp->e_hostname=3DNULL;
> @@ -60,17 +56,10 @@ xtab_read(char *xtab, char *lockfn, int is_export)
>                          }
>  			continue;
>  		}
> -		switch (is_export) {
> -		case 0:
> -			exp->m_exported =3D 1;
> -			break;
> -		case 1:
> -			exp->m_xtabent =3D 1;
> -			exp->m_mayexport =3D 1;
> -			if ((xp->e_flags & NFSEXP_FSID) && xp->e_fsid =3D=3D 0)
> -				v4root_needed =3D 0;
> -			break;
> -		} =20
> +		exp->m_xtabent =3D 1;
> +		exp->m_mayexport =3D 1;
> +		if ((xp->e_flags & NFSEXP_FSID) && xp->e_fsid =3D=3D 0)
> +			v4root_needed =3D 0;
>                  if(xp->e_hostname) {
>                      free(xp->e_hostname);
>                      xp->e_hostname=3DNULL;
> @@ -90,7 +79,7 @@ xtab_read(char *xtab, char *lockfn, int is_export)
>  int
>  xtab_export_read(void)
>  {
> -	return xtab_read(etab.statefn, etab.lockfn, 1);
> +	return xtab_read(etab.statefn, etab.lockfn);
>  }
> =20
>  /*
> @@ -100,7 +89,7 @@ xtab_export_read(void)
>   * fix the auth_reload logic as well...
>   */
>  static int
> -xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
> +xtab_write(char *xtab, char *xtabtmp, char *lockfn)
>  {
>  	struct exportent	xe;
>  	nfs_export		*exp;
> @@ -114,9 +103,7 @@ xtab_write(char *xtab, char *xtabtmp, char *lockfn, i=
nt is_export)
> =20
>  	for (i =3D 0; i < MCL_MAXTYPES; i++) {
>  		for (exp =3D exportlist[i].p_head; exp; exp =3D exp->m_next) {
> -			if (is_export && !exp->m_xtabent)
> -				continue;
> -			if (!is_export && ! exp->m_exported)
> +			if (!exp->m_xtabent)
>  				continue;
> =20
>  			/* write out the export entry using the FQDN */
> @@ -137,7 +124,7 @@ xtab_write(char *xtab, char *xtabtmp, char *lockfn, i=
nt is_export)
>  int
>  xtab_export_write(void)
>  {
> -	return xtab_write(etab.statefn, etab.tmpfn, etab.lockfn, 1);
> +	return xtab_write(etab.statefn, etab.tmpfn, etab.lockfn);
>  }
> =20
>  /*
>=20
> ---
> base-commit: cbbf618b31b64198de06a350c4f5744c76e51ecb
> change-id: 20260514-exportd-ceb123e6fff2
>=20
> Best regards,

--=20
Jeff Layton <jlayton@kernel.org>

