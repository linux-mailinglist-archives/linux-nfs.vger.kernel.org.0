Return-Path: <linux-nfs+bounces-4767-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9911C92D189
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC8C1C232C1
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B97191477;
	Wed, 10 Jul 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVcLdY5x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82804848E;
	Wed, 10 Jul 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614471; cv=none; b=lR8sYKtSYhggrzPR8xxy+4Fci6EF9ohJMVcCQBtukv2P0cWiJFNmYb4f9TzZuzbJG51AzO+dufT8EXobgJJGD1tTo8EHkC3gUVsBRc5Jdy7mG3sj7EkUdM+L7DhLkyDoavC+uzrKxTyi5dr58nDAo9bu6ofJH/4pvbrTIdbOj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614471; c=relaxed/simple;
	bh=4wrsszOLddIRNBVCieagn/MyNyNDe45McIeZkYshbCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ss0OCHU57lBo+dAy3wtExx+HKcXPEQwNlD/pozqZnkUlvEEXNoSLDX8JkKij927VfzeJvbeN1riNV8MXa+NzcIRSv0DCVEiv8BC/ykwpF5kvtTRBuDrIswhvT2voOb8L0KMONwrALkrjmLL1+Gf+DDphWEPthZDNEg/jWbmUW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVcLdY5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BB2C32781;
	Wed, 10 Jul 2024 12:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720614471;
	bh=4wrsszOLddIRNBVCieagn/MyNyNDe45McIeZkYshbCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JVcLdY5x3P4C1FGSs4PttCGvweS+vX6H0GMYJaa1s39ZL/FisvxL4wItNYuZ23nfV
	 +p18nfiHU3dSeOT8y71Rz8m6EcFyvcAZWfqI3fpPqE2wvugsueY2rKtagFLTJYndwu
	 C72ZcaCJhqwm08OZTvXENRB0LzHoA9JBg/JftPAFV3Tx/zM4brsw/yX8fUuWd9Msa2
	 5udmhfyEGXFouGKSwWFqLqHj0Xq/IMovCGlxZG5QlAiZ8ioi0LbwC4x24NPauCq7+x
	 EQASDY4mkQT6H59zUqNWgfJxjKgMaqJJtfLOR9ezzB23LEmJmEhmbJ7JEBTAF7wEKj
	 DeEXPtfXgz2xQ==
Message-ID: <ab51cd2e8fef48dac690ca4549b409269ff9beae.camel@kernel.org>
Subject: Re: [PATCH v2] fs: nfs: add missing MODULE_DESCRIPTION() macros
From: Jeff Layton <jlayton@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>,  Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Wed, 10 Jul 2024 08:27:48 -0400
In-Reply-To: <e0a9f5ab-92d4-4a41-8693-358e861f2ef6@quicinc.com>
References: <20240625-md-fs-nfs-v2-1-2316b64ffaa5@quicinc.com>
	 <abe2e12fcd6a64b603179f234ca684a182657d6a.camel@kernel.org>
	 <e0a9f5ab-92d4-4a41-8693-358e861f2ef6@quicinc.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 13:47 -0700, Jeff Johnson wrote:
> On 6/25/2024 9:44 AM, Jeff Layton wrote:
> > On Tue, 2024-06-25 at 09:42 -0700, Jeff Johnson wrote:
> > > Fix the 'make W=3D1' warnings:
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in
> > > fs/nfs_common/nfs_acl.o
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in
> > > fs/nfs_common/grace.o
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfs.o
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv2.o
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv3.o
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o
> > >=20
> > > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > ---
> > > Changes in v2:
> > > - Updated the description in grace.c per Jeff Layton
> > > - Link to v1:
> > > https://lore.kernel.org/r/20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicin=
c.com
> > > ---
> > > =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 1 +
> > > =C2=A0fs/nfs/nfs2super.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > > =C2=A0fs/nfs/nfs3super.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > > =C2=A0fs/nfs/nfs4super.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > > =C2=A0fs/nfs_common/grace.c=C2=A0 | 1 +
> > > =C2=A0fs/nfs_common/nfsacl.c | 1 +
> > > =C2=A06 files changed, 6 insertions(+)
> > >=20

Given that this is mostly client-side changes, this should probably go
through the client tree. Anna, could you pick this one up?

Thanks,
Jeff

> > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > > index acef52ecb1bb..57c473e9d00f 100644
> > > --- a/fs/nfs/inode.c
> > > +++ b/fs/nfs/inode.c
> > > @@ -2538,6 +2538,7 @@ static void __exit exit_nfs_fs(void)
> > > =C2=A0
> > > =C2=A0/* Not quite true; I just maintain it */
> > > =C2=A0MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> > > +MODULE_DESCRIPTION("NFS client support");
> > > =C2=A0MODULE_LICENSE("GPL");
> > > =C2=A0module_param(enable_ino64, bool, 0644);
> > > =C2=A0
> > > diff --git a/fs/nfs/nfs2super.c b/fs/nfs/nfs2super.c
> > > index 467f21ee6a35..b1badc70bd71 100644
> > > --- a/fs/nfs/nfs2super.c
> > > +++ b/fs/nfs/nfs2super.c
> > > @@ -26,6 +26,7 @@ static void __exit exit_nfs_v2(void)
> > > =C2=A0	unregister_nfs_version(&nfs_v2);
> > > =C2=A0}
> > > =C2=A0
> > > +MODULE_DESCRIPTION("NFSv2 client support");
> > > =C2=A0MODULE_LICENSE("GPL");
> > > =C2=A0
> > > =C2=A0module_init(init_nfs_v2);
> > > diff --git a/fs/nfs/nfs3super.c b/fs/nfs/nfs3super.c
> > > index 8a9be9e47f76..20a80478449e 100644
> > > --- a/fs/nfs/nfs3super.c
> > > +++ b/fs/nfs/nfs3super.c
> > > @@ -27,6 +27,7 @@ static void __exit exit_nfs_v3(void)
> > > =C2=A0	unregister_nfs_version(&nfs_v3);
> > > =C2=A0}
> > > =C2=A0
> > > +MODULE_DESCRIPTION("NFSv3 client support");
> > > =C2=A0MODULE_LICENSE("GPL");
> > > =C2=A0
> > > =C2=A0module_init(init_nfs_v3);
> > > diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
> > > index 8da5a9c000f4..b29a26923ce0 100644
> > > --- a/fs/nfs/nfs4super.c
> > > +++ b/fs/nfs/nfs4super.c
> > > @@ -332,6 +332,7 @@ static void __exit exit_nfs_v4(void)
> > > =C2=A0	nfs_dns_resolver_destroy();
> > > =C2=A0}
> > > =C2=A0
> > > +MODULE_DESCRIPTION("NFSv4 client support");
> > > =C2=A0MODULE_LICENSE("GPL");
> > > =C2=A0
> > > =C2=A0module_init(init_nfs_v4);
> > > diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
> > > index 1479583fbb62..27cd0d13143b 100644
> > > --- a/fs/nfs_common/grace.c
> > > +++ b/fs/nfs_common/grace.c
> > > @@ -139,6 +139,7 @@ exit_grace(void)
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
> > > +MODULE_DESCRIPTION("NFS client and server infrastructure");
> > > =C2=A0MODULE_LICENSE("GPL");
> > > =C2=A0module_init(init_grace)
> > > =C2=A0module_exit(exit_grace)
> > > diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
> > > index 5a5bd85d08f8..ea382b75b26c 100644
> > > --- a/fs/nfs_common/nfsacl.c
> > > +++ b/fs/nfs_common/nfsacl.c
> > > @@ -29,6 +29,7 @@
> > > =C2=A0#include <linux/nfs3.h>
> > > =C2=A0#include <linux/sort.h>
> > > =C2=A0
> > > +MODULE_DESCRIPTION("NFS ACL support");
> > > =C2=A0MODULE_LICENSE("GPL");
> > > =C2=A0
> > > =C2=A0struct nfsacl_encode_desc {
> > >=20
> > > ---
> > > base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> > > change-id: 20240527-md-fs-nfs-42f19eb60b50
> > >=20
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> I don't see this in linux-next yet so following up to see if anything els=
e is
> needed to get this merged.
>=20

--=20
Jeff Layton <jlayton@kernel.org>

