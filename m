Return-Path: <linux-nfs+bounces-11937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7982AC5E2C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 02:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875991BA4AB3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 00:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290C54764;
	Wed, 28 May 2025 00:25:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C255E567;
	Wed, 28 May 2025 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391920; cv=none; b=JwAKJVaGsB5Fc4WUUkszL2eCw1KExr7V8v9EZ8vdJgT8APX1bluy6sxougwSUdV3tT9XOImS3nJJzQIAWFvP1wqGlRNbJCWDksVplI9/EFg7GYrBvUaauEv9zsJyqc9HepEsy7WIDoH9+vMeYOMnbBl3OsxgsXEOJcTrMPEk+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391920; c=relaxed/simple;
	bh=kycWT4ewyhl1bjll97d0SYZDsXrvE95yuJRILxtNkHM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TYUd3SPHCd61u1bwMKhrVrAx0ohohRsTNe1L2WKdRz/+M2C+yDQeeWG+p0eYi4kPsJhUO2Y7UCORENhDGmM0UXsMrQSAKGe0gBYhAaBRhP/82MvzZWdVeGd+uzd4aBVdGJjQzMN724dkAGjG0W9dphM8gDX+Fxtjm4EEUSbzsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uK4bS-00C8mx-0k;
	Wed, 28 May 2025 00:25:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neil@brown.name>
To: "Su Hui" <suhui@nfschina.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, "Su Hui" <suhui@nfschina.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: Replace simple_strtoul with kstrtoint in expkey_parse
In-reply-to: <20250527092548.1931636-1-suhui@nfschina.com>
References: <20250527092548.1931636-1-suhui@nfschina.com>
Date: Wed, 28 May 2025 10:25:05 +1000
Message-id: <174839190520.608730.15461813542926388395@noble.neil.brown.name>

On Tue, 27 May 2025, Su Hui wrote:
> kstrtoint() is better because simple_strtoul() ignores overflow and the
> type of 'fsidtype' is 'int' rather than 'unsigned long'.

Thanks for the patch.

Reviewed-by: NeilBrown <neil@brown.name>

The valid values for fsidtype are actually 0-7 so it might be nice to
change the type to u8 everywhere and make this kstrtou8() but that isn't
really needed and shouldn't stop this patch landing.

Thanks,
NeilBrown


>=20
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/nfsd/export.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 0363720280d4..1bc9bc20cac3 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -83,7 +83,6 @@ static int expkey_parse(struct cache_detail *cd, char *me=
sg, int mlen)
>  	struct auth_domain *dom =3D NULL;
>  	int err;
>  	int fsidtype;
> -	char *ep;
>  	struct svc_expkey key;
>  	struct svc_expkey *ek =3D NULL;
> =20
> @@ -109,8 +108,7 @@ static int expkey_parse(struct cache_detail *cd, char *=
mesg, int mlen)
>  	err =3D -EINVAL;
>  	if (qword_get(&mesg, buf, PAGE_SIZE) <=3D 0)
>  		goto out;
> -	fsidtype =3D simple_strtoul(buf, &ep, 10);
> -	if (*ep)
> +	if (kstrtoint(buf, 10, &fsidtype))
>  		goto out;
>  	dprintk("found fsidtype %d\n", fsidtype);
>  	if (key_len(fsidtype)=3D=3D0) /* invalid type */
> --=20
> 2.30.2
>=20
>=20


