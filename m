Return-Path: <linux-nfs+bounces-4299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4946916E58
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 18:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0A1F249C6
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9A175550;
	Tue, 25 Jun 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVx0S+Ig"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F565174EC6;
	Tue, 25 Jun 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333870; cv=none; b=rPINKiI4sE9Jbkp8sGedtwp50WyxHdkW83tunaygq4jkppzCDfdJRtX6JeFEnJeNYu9Mr1lusXKbvB380+0Odw/hYQG93IBuXusEQgK5O+JveWfH6FE4NxCTiz0TKPdt2fEWPIZMSh5QPl92TeLs20uhLJyO4axOOVruqY6pVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333870; c=relaxed/simple;
	bh=T3EQ9ejCbWFfXVJQ4DjTr0lEc1PmW02Q64V8AJQ+Vqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tCy0CYsDWZZP2iCZVp2B8eb08KDxuWvVNOLtzpUS7B2MsDgoesDyLMItB5+uZcVtvsppXQ0ATLZhwo8ZkxDCVwcdn+olflGEUxXw1aOTggFPlhHMlq8vo8vEVHL2KoeI8dLwukNjU93ZIEIOfAjjs4emMwLfY1t4si6I3+90Kqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVx0S+Ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DF5C32781;
	Tue, 25 Jun 2024 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719333869;
	bh=T3EQ9ejCbWFfXVJQ4DjTr0lEc1PmW02Q64V8AJQ+Vqo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iVx0S+Iglbvi1wB3nVFFpB/ufAptdVzPYfLpg4E5jI8AtK/FnOG0jJZpTtzmaFcCs
	 fZTY8DSNn9TDujFUOduzl7Gmx8xBmoze8ezz8OYgpmBSL+wCRnLAYEq6bRB/Yysz/7
	 uwMswzOSpvrueY6TgB5M3GJKi8F7YwmpZ6xDxf+KmStHvACgYwZNEiBjeI6oq24oK/
	 R/fX0UMxPDQELhI+tF4XPimm1cOidOC7sQZoMGP4qg2oqLgfXq2corhD4Qla/7x3EY
	 77DCZq6sVDC8CvOwqhIOv55gbGeUPcG9DayPeE6D2fIACo4jecvgQ1Zb3+w3z9qYeB
	 LrWLi7YrReDYA==
Message-ID: <abe2e12fcd6a64b603179f234ca684a182657d6a.camel@kernel.org>
Subject: Re: [PATCH v2] fs: nfs: add missing MODULE_DESCRIPTION() macros
From: Jeff Layton <jlayton@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>,  Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Tue, 25 Jun 2024 12:44:26 -0400
In-Reply-To: <20240625-md-fs-nfs-v2-1-2316b64ffaa5@quicinc.com>
References: <20240625-md-fs-nfs-v2-1-2316b64ffaa5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 09:42 -0700, Jeff Johnson wrote:
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
> Changes in v2:
> - Updated the description in grace.c per Jeff Layton
> - Link to v1:
> https://lore.kernel.org/r/20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.co=
m
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
> index 1479583fbb62..27cd0d13143b 100644
> --- a/fs/nfs_common/grace.c
> +++ b/fs/nfs_common/grace.c
> @@ -139,6 +139,7 @@ exit_grace(void)
> =C2=A0}
> =C2=A0
> =C2=A0MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
> +MODULE_DESCRIPTION("NFS client and server infrastructure");
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
> base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> change-id: 20240527-md-fs-nfs-42f19eb60b50
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

