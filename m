Return-Path: <linux-nfs+bounces-4781-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947092D75D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89526B24E76
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E5A194C79;
	Wed, 10 Jul 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOU0ty+q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EF194C6F;
	Wed, 10 Jul 2024 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632064; cv=none; b=OFhPJaZ59ibZAibf8z1ZVpbj1qzMnj5Qc+0eZfiUnUjmwSPJKhXHY52+IROVlx4/PYiUb3I0Hj+1yCvJikl+4gUu+qxeZ22tsHB0d8pV7Y1DB+g37oBm3+okZJpcP7IplV3aZwt9IK/AZDUOXHlfhLi8HNUNdo0rMrl44yHo0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632064; c=relaxed/simple;
	bh=FF0aSktouEQaGWd9Hm0QcgvEejLKXDoWmf2IlT0telM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKvYb/uN603+bDe8aYDxrGn0S4zqpN6hT8r2mFaYue3wgVaFVhdrZE4kavKBEPwY2qVai5h9Fs+0Xn7ywXFf+1taz6jDkt0L6H1Y7es5VibXFWZBVtSVbcFJzrYxd6Veis2Iecw4et3P+wt1W3KGtDzrFLWXh8hulOJlV320Jmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOU0ty+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9034EC32781;
	Wed, 10 Jul 2024 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720632063;
	bh=FF0aSktouEQaGWd9Hm0QcgvEejLKXDoWmf2IlT0telM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hOU0ty+q8xrVwNpiFshOm/bFyN+vdegtm/F5NX43mkp8WEcX9fQ71ISqToQTtF0e6
	 0j0Y+uRgyOV7jDEBUCGpYbyn/nTLTh2j7uVEKTre8k4g5UevahiEpgcKo8MdAVM1er
	 aMRkDdJovuhi95ObaONk7IXJvyXvYNej0Jagkc90tUIxew+OOhhgPX5qTpw5cJ6kn4
	 ioeptSRxPhsX+7Js4/4Dcy3wkC/mpdF1ZxWk0EWbbIJcSRWP2z+zbl2At9Tg2WLS8x
	 Pv3dgAxCCAI+P+D0naIbSWOr3C5I6Ls+3ffbDaIdUnZtgae5xsJqzuju+pR4QeF/DJ
	 fOgFWDEyauo/A==
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44930ea05b8so13415021cf.1;
        Wed, 10 Jul 2024 10:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEGWtvwlctR/pa1S1Ny731QbDx4QLzMs0ke+my67VpLwPBuhnm3yTXgj01LCrPKO5sjkshmUJM59bJB8+uVcmgKiwgAGxwxut1lo+RnJ6b2o/jMBUshuESfy8jiweNaA7/AOs0cdl/WQHF4kidQttjHxovt3s5lhYrTsyK1g2YL1S/XH62E4pl
X-Gm-Message-State: AOJu0YyBI3SuZ6Ds2qFA5bbhLVIyyCyHXV3SnxnMxZwIEwsUyzeE/W6+
	j7/g+N303eNXY0sxRSZIY4bTsaLo1urFsawIRQkrPVJa+v+x/NvqpSvjg2pSQeEaNIS5vzm2Ofl
	nMa5F9cbdQGCK8jmWtQ7y+sVr1fU=
X-Google-Smtp-Source: AGHT+IE93hixvKRPtGdm2fytIjue/h7k9Qm8hBlA2dg0b0ijKs92ZN9gaaVKBlhiHqiRp+nik0lHjYL9wLIXDLbVNkc=
X-Received: by 2002:ac8:5ace:0:b0:447:efb8:97f4 with SMTP id
 d75a77b69052e-447fa825df1mr69787041cf.2.1720632062902; Wed, 10 Jul 2024
 10:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625-md-fs-nfs-v2-1-2316b64ffaa5@quicinc.com>
 <abe2e12fcd6a64b603179f234ca684a182657d6a.camel@kernel.org>
 <e0a9f5ab-92d4-4a41-8693-358e861f2ef6@quicinc.com> <ab51cd2e8fef48dac690ca4549b409269ff9beae.camel@kernel.org>
In-Reply-To: <ab51cd2e8fef48dac690ca4549b409269ff9beae.camel@kernel.org>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 10 Jul 2024 13:20:46 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfm4OaVa0i5Za2YM9EBL4aCgP6+LZRijazthRY_88_vhig@mail.gmail.com>
Message-ID: <CAFX2Jfm4OaVa0i5Za2YM9EBL4aCgP6+LZRijazthRY_88_vhig@mail.gmail.com>
Subject: Re: [PATCH v2] fs: nfs: add missing MODULE_DESCRIPTION() macros
To: Jeff Layton <jlayton@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:27=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2024-07-09 at 13:47 -0700, Jeff Johnson wrote:
> > On 6/25/2024 9:44 AM, Jeff Layton wrote:
> > > On Tue, 2024-06-25 at 09:42 -0700, Jeff Johnson wrote:
> > > > Fix the 'make W=3D1' warnings:
> > > > WARNING: modpost: missing MODULE_DESCRIPTION() in
> > > > fs/nfs_common/nfs_acl.o
> > > > WARNING: modpost: missing MODULE_DESCRIPTION() in
> > > > fs/nfs_common/grace.o
> > > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfs.o
> > > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv2.o
> > > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv3.o
> > > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o
> > > >
> > > > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > > ---
> > > > Changes in v2:
> > > > - Updated the description in grace.c per Jeff Layton
> > > > - Link to v1:
> > > > https://lore.kernel.org/r/20240527-md-fs-nfs-v1-1-64a15e9b53a6@quic=
inc.com
> > > > ---
> > > >  fs/nfs/inode.c         | 1 +
> > > >  fs/nfs/nfs2super.c     | 1 +
> > > >  fs/nfs/nfs3super.c     | 1 +
> > > >  fs/nfs/nfs4super.c     | 1 +
> > > >  fs/nfs_common/grace.c  | 1 +
> > > >  fs/nfs_common/nfsacl.c | 1 +
> > > >  6 files changed, 6 insertions(+)
> > > >
>
> Given that this is mostly client-side changes, this should probably go
> through the client tree. Anna, could you pick this one up?

Yep, It's been in my linux-next branch for a while now.

Anna

>
> Thanks,
> Jeff
>
> > > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > > > index acef52ecb1bb..57c473e9d00f 100644
> > > > --- a/fs/nfs/inode.c
> > > > +++ b/fs/nfs/inode.c
> > > > @@ -2538,6 +2538,7 @@ static void __exit exit_nfs_fs(void)
> > > >
> > > >  /* Not quite true; I just maintain it */
> > > >  MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> > > > +MODULE_DESCRIPTION("NFS client support");
> > > >  MODULE_LICENSE("GPL");
> > > >  module_param(enable_ino64, bool, 0644);
> > > >
> > > > diff --git a/fs/nfs/nfs2super.c b/fs/nfs/nfs2super.c
> > > > index 467f21ee6a35..b1badc70bd71 100644
> > > > --- a/fs/nfs/nfs2super.c
> > > > +++ b/fs/nfs/nfs2super.c
> > > > @@ -26,6 +26,7 @@ static void __exit exit_nfs_v2(void)
> > > >   unregister_nfs_version(&nfs_v2);
> > > >  }
> > > >
> > > > +MODULE_DESCRIPTION("NFSv2 client support");
> > > >  MODULE_LICENSE("GPL");
> > > >
> > > >  module_init(init_nfs_v2);
> > > > diff --git a/fs/nfs/nfs3super.c b/fs/nfs/nfs3super.c
> > > > index 8a9be9e47f76..20a80478449e 100644
> > > > --- a/fs/nfs/nfs3super.c
> > > > +++ b/fs/nfs/nfs3super.c
> > > > @@ -27,6 +27,7 @@ static void __exit exit_nfs_v3(void)
> > > >   unregister_nfs_version(&nfs_v3);
> > > >  }
> > > >
> > > > +MODULE_DESCRIPTION("NFSv3 client support");
> > > >  MODULE_LICENSE("GPL");
> > > >
> > > >  module_init(init_nfs_v3);
> > > > diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
> > > > index 8da5a9c000f4..b29a26923ce0 100644
> > > > --- a/fs/nfs/nfs4super.c
> > > > +++ b/fs/nfs/nfs4super.c
> > > > @@ -332,6 +332,7 @@ static void __exit exit_nfs_v4(void)
> > > >   nfs_dns_resolver_destroy();
> > > >  }
> > > >
> > > > +MODULE_DESCRIPTION("NFSv4 client support");
> > > >  MODULE_LICENSE("GPL");
> > > >
> > > >  module_init(init_nfs_v4);
> > > > diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
> > > > index 1479583fbb62..27cd0d13143b 100644
> > > > --- a/fs/nfs_common/grace.c
> > > > +++ b/fs/nfs_common/grace.c
> > > > @@ -139,6 +139,7 @@ exit_grace(void)
> > > >  }
> > > >
> > > >  MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
> > > > +MODULE_DESCRIPTION("NFS client and server infrastructure");
> > > >  MODULE_LICENSE("GPL");
> > > >  module_init(init_grace)
> > > >  module_exit(exit_grace)
> > > > diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
> > > > index 5a5bd85d08f8..ea382b75b26c 100644
> > > > --- a/fs/nfs_common/nfsacl.c
> > > > +++ b/fs/nfs_common/nfsacl.c
> > > > @@ -29,6 +29,7 @@
> > > >  #include <linux/nfs3.h>
> > > >  #include <linux/sort.h>
> > > >
> > > > +MODULE_DESCRIPTION("NFS ACL support");
> > > >  MODULE_LICENSE("GPL");
> > > >
> > > >  struct nfsacl_encode_desc {
> > > >
> > > > ---
> > > > base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> > > > change-id: 20240527-md-fs-nfs-42f19eb60b50
> > > >
> > >
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >
> > I don't see this in linux-next yet so following up to see if anything e=
lse is
> > needed to get this merged.
> >
>
> --
> Jeff Layton <jlayton@kernel.org>

