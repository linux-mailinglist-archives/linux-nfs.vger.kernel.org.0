Return-Path: <linux-nfs+bounces-11706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E9FAB60B1
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 04:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B3F189930A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1C33997;
	Wed, 14 May 2025 02:16:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A52AE8E
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747189015; cv=none; b=h9WySM9EZ52D3biKxBN7bJMXv2ydfTPof843vH+kRwq4p+yGmuRI9WunYn8BhWZJcF/WUdwHvpUOcb9vmlLsshZSzMukX8FywcHD/JqXXGbAwnjUABm0U6g3QdDX0txHBlBbbNgTZDO2Qh0PJpL/+5tNx0/LpN9r96Ap5ywut2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747189015; c=relaxed/simple;
	bh=486X53FkyVkBt3De2ELB9pajIkEVXM1mT1lmnDAfwVE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JkpeK9IdysWGGdsOVmRGrI4CywTUiV8ZnTPdPQWjQMkw6coZRg7jkmb4THDh8PHmovdW4GL8qMDHBZsA5d0Dotiev1fhfxt8blUvZ1PnqpgKjCRj/2ucDyGHrJGQ968Hx8yELCWyLJ0oq6HHD8CMHyvBILna2bzrUb3CjBCOMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uF1fq-003P98-Lp;
	Wed, 14 May 2025 02:16:46 +0000
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
Date: Wed, 14 May 2025 12:16:46 +1000
Message-id: <174718900620.62796.18240600261000060825@noble.neil.brown.name>

On Tue, 13 May 2025, Jeff Layton wrote:
> Back in the 80's someone thought it was a good idea to carve out a set
> of ports that only privileged users could use. When NFS was originally
> conceived, Sun made its server require that clients use low ports.
> Since Linux was following suit with Sun in those days, exportfs has
> always defaulted to requiring connections from low ports.
>=20
> These days, anyone can be root on their laptop, so limiting connections
> to low source ports is of little value.

But who is going to export any filesystem to their laptop?

>=20
> Make the default be "insecure" when creating exports.

So you want to break lots of configurations that are working perfectly
well?

I don't see any really motivation for this change.  Could you provide it
please?

Thanks,
NeilBrown

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


