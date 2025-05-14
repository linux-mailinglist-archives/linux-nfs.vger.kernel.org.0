Return-Path: <linux-nfs+bounces-11708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACFAB60C2
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 04:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60AA19E2144
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 02:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1315278E;
	Wed, 14 May 2025 02:38:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D781DFE8
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747190336; cv=none; b=HEXPZzNYl9B49QPE17bGgcC2Zzi+9cxjsDwS2W+jv8fqzx8u3i5FMzr/Aq3PSDugyusuj4OIkAMQZQtjd90KX2jXi8cjo0IqY60JBHkYlN4+cnHbbSL9zdsJn2VKm6wvneljONxxfJDkC3yMkrcicMlDqnPw1lCpatR2KsW8HdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747190336; c=relaxed/simple;
	bh=8tYWfT6OaFyuO7opPCrI5WqyYRlXyQXlCVdz4ilARL4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Sd4D0jIvIQd+8UJ52kb28GQpOjgErkjsZsC8LawXr6m8rMj5xMwfMl/nY8fVVoG0IeNPGJ2tDtfTkfbfhaH57WNBPOFwV89VDFYCbug9AIWglyvDXbl36G/697l78OUUxy4KS/USh64qFslUfPmS3Rn3Aw+eTsJnJM7f+Cym5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uF21D-003Pb5-MZ;
	Wed, 14 May 2025 02:38:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Steve Dickson" <steved@redhat.com>, "Tom Haynes" <loghyr@gmail.com>,
 linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
In-reply-to: <20250513-master-v1-1-e845fe412715@kernel.org>
References: <20250513-master-v1-1-e845fe412715@kernel.org>
Date: Wed, 14 May 2025 12:38:51 +1000
Message-id: <174719033130.62796.892917485792343533@noble.neil.brown.name>

On Tue, 13 May 2025, Jeff Layton wrote:
> Back in the 80's someone thought it was a good idea to carve out a set
> of ports that only privileged users could use. When NFS was originally
> conceived, Sun made its server require that clients use low ports.
> Since Linux was following suit with Sun in those days, exportfs has
> always defaulted to requiring connections from low ports.
>=20
> These days, anyone can be root on their laptop, so limiting connections
> to low source ports is of little value.
>=20
> Make the default be "insecure" when creating exports.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> In discussion at the Bake-a-thon, we decided to just go for making
> "insecure" the default for all exports.
> ---
>  support/nfs/exports.c      | 7 +++++--
>  utils/exportfs/exports.man | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0=
685af3e70ed0b 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -34,8 +34,11 @@
>  #include "reexport.h"
>  #include "nfsd_path.h"
> =20
> -#define EXPORT_DEFAULT_FLAGS	\
> -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTR=
EECHECK)
> +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
> +				 NFSEXP_ROOTSQUASH |	\
> +				 NFSEXP_GATHERED_WRITES |\
> +				 NFSEXP_NOSUBTREECHECK | \
> +				 NFSEXP_INSECURE_PORT)
> =20
>  struct flav_info flav_map[] =3D {
>  	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301=
c4ec97b14d003 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -180,8 +180,8 @@ understands the following export options:
>  .TP
>  .IR secure
>  This option requires that requests not using gss originate on an
> -Internet port less than IPPORT_RESERVED (1024). This option is on by defau=
lt.
> -To turn it off, specify
> +Internet port less than IPPORT_RESERVED (1024). This option is off by defa=
ult
> +but can be explicitly disabled by specifying
>  .IR insecure .

I think you mean "can be explicit enabled if desired" or similar.

If you really want to do this, you should require either "insecure" or
"secure" and generate a warning like we did when changing other defaults
in the past.  After a period of time you can remove that requirement.

NeilBrown


>  (NOTE: older kernels (before upstream kernel version 4.17) enforced this
>  requirement on gss requests as well.)
>=20
> ---
> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
> change-id: 20250513-master-89974087bb04
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20
>=20


