Return-Path: <linux-nfs+bounces-4164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B736910D23
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95E9B28C42
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95741B3737;
	Thu, 20 Jun 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvD7H51h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D781B142E;
	Thu, 20 Jun 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901232; cv=none; b=IrW1lU+MNI3RnVB3Ah5zbWkFl/kXX22dMJJvXyvTzuo62rGVx8nBC5Tk0F5Nzjt3eHGknpT2+Vw2r9lDy8WzElCWkKKPkgAOlRdKwl5pjelfVQ1r5M6lz7YoGSDftycmy0nNlYhbyotLPrjUNTMZo/7u/p2A6B1xmJ4CGlUagBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901232; c=relaxed/simple;
	bh=q4gYku9Cb1LdNHNhntEEY/RKn3x2UuKwiH0lInmvHIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbne+HC0Jg1fCc0yHl78YtDmABfGkyb1KyX1WO9ltbVbCTwEbKu1HBgCBqjM5TNqu3bqDHbaALOrDJ2wRrukyeLuUs3/gEwU/VCTLfF9Ioic/r45/VmXEEBfmXWKM17aG1jrsH6iARcvckbOMQPuCO8YlWi11W00mYJObHGhvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvD7H51h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE25DC2BD10;
	Thu, 20 Jun 2024 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718901232;
	bh=q4gYku9Cb1LdNHNhntEEY/RKn3x2UuKwiH0lInmvHIc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WvD7H51hhi7wJXToQopQZbAXf0TgaYT6iUQ/iOjVk3+ypKpYqaJY51/71ujAuiB6D
	 Igw7d3Xs5lFt5NXfqIEjeqsVB6KoSOIcNgWgdwtIDQBqhO9euLCVE3G2kDF6M5q//P
	 fSib3DIsWtzpbuZTRWXN5z8xxV29j6qH77Aztvyzm7G7/gurQTn3cRO7+pNc8NGQCQ
	 4kYp8Nh6JW2v2a7c1DNs5XbttNRf5Mgkv6sRcVqs89la97u+OEFR4qHrqkPiQT6D08
	 yvhdX3iNGnI4OifmSLTbqujFFBemXl7BR8bDCSYYjpRmonm+o2cDNTgKKQx+aBA3RR
	 aa1fqdcwHM9ww==
Message-ID: <a7e7b2a3e9898225836d8263aff9e01e60390f37.camel@kernel.org>
Subject: Re: [PATCH] fs: nfs: add missing MODULE_DESCRIPTION() macros
From: Jeff Layton <jlayton@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>,  Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Thu, 20 Jun 2024 12:33:49 -0400
In-Reply-To: <20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.com>
References: <20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-27 at 10:58 -0700, Jeff Johnson wrote:
> Fix the 'make W=3D1' warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> fs/nfs_common/nfs_acl.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> fs/nfs_common/grace.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv2.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv3.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 =
+
> =C2=A0fs/nfs/nfs2super.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0fs/nfs/nfs3super.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0fs/nfs/nfs4super.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0fs/nfs_common/grace.c=C2=A0 | 1 +
> =C2=A0fs/nfs_common/nfsacl.c | 1 +
> =C2=A06 files changed, 6 insertions(+)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index acef52ecb1bb..57c473e9d00f 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2538,6 +2538,7 @@ static void __exit exit_nfs_fs(void)
> =C2=A0
> =C2=A0/* Not quite true; I just maintain it */
> =C2=A0MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> +MODULE_DESCRIPTION("NFS client support");
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0module_param(enable_ino64, bool, 0644);
> =C2=A0
> diff --git a/fs/nfs/nfs2super.c b/fs/nfs/nfs2super.c
> index 467f21ee6a35..b1badc70bd71 100644
> --- a/fs/nfs/nfs2super.c
> +++ b/fs/nfs/nfs2super.c
> @@ -26,6 +26,7 @@ static void __exit exit_nfs_v2(void)
> =C2=A0	unregister_nfs_version(&nfs_v2);
> =C2=A0}
> =C2=A0
> +MODULE_DESCRIPTION("NFSv2 client support");
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0
> =C2=A0module_init(init_nfs_v2);
> diff --git a/fs/nfs/nfs3super.c b/fs/nfs/nfs3super.c
> index 8a9be9e47f76..20a80478449e 100644
> --- a/fs/nfs/nfs3super.c
> +++ b/fs/nfs/nfs3super.c
> @@ -27,6 +27,7 @@ static void __exit exit_nfs_v3(void)
> =C2=A0	unregister_nfs_version(&nfs_v3);
> =C2=A0}
> =C2=A0
> +MODULE_DESCRIPTION("NFSv3 client support");
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0
> =C2=A0module_init(init_nfs_v3);
> diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
> index 8da5a9c000f4..b29a26923ce0 100644
> --- a/fs/nfs/nfs4super.c
> +++ b/fs/nfs/nfs4super.c
> @@ -332,6 +332,7 @@ static void __exit exit_nfs_v4(void)
> =C2=A0	nfs_dns_resolver_destroy();
> =C2=A0}
> =C2=A0
> +MODULE_DESCRIPTION("NFSv4 client support");
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0
> =C2=A0module_init(init_nfs_v4);
> diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
> index 1479583fbb62..8f034aa8c88b 100644
> --- a/fs/nfs_common/grace.c
> +++ b/fs/nfs_common/grace.c
> @@ -139,6 +139,7 @@ exit_grace(void)
> =C2=A0}
> =C2=A0
> =C2=A0MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
> +MODULE_DESCRIPTION("lockd and nfsv4 grace period control");

This module has some code that does other things too. It's basically
some core infrastructure shared by the NFS client and server. Maybe
this should read "NFS client and server infrastructure" ?

> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0module_init(init_grace)
> =C2=A0module_exit(exit_grace)
> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
> index 5a5bd85d08f8..ea382b75b26c 100644
> --- a/fs/nfs_common/nfsacl.c
> +++ b/fs/nfs_common/nfsacl.c
> @@ -29,6 +29,7 @@
> =C2=A0#include <linux/nfs3.h>
> =C2=A0#include <linux/sort.h>
> =C2=A0
> +MODULE_DESCRIPTION("NFS ACL support");
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0
> =C2=A0struct nfsacl_encode_desc {
>=20
> ---
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> change-id: 20240527-md-fs-nfs-42f19eb60b50
>=20

--=20
Jeff Layton <jlayton@kernel.org>

