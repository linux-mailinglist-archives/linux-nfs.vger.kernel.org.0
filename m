Return-Path: <linux-nfs+bounces-4351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AAE919961
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 22:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF1C2849DD
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAF15B980;
	Wed, 26 Jun 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lih/TC6I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439914F9F0
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434734; cv=none; b=K3qjUu+97a14dNrGdJHabjsMaYwryrBvgc/a9ZhN1F+exajc2SzzUXlTdZa8ImMlVBqZWt99a1C8VnnvBfI5+sTK8S4vh10eGMxi/GAZX4RagQduTaEohDEr8isasbiaNdl+c2ARjJ7/r1PX4xSI7luuxHW3yKcG93wssjr7tT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434734; c=relaxed/simple;
	bh=ay3njX9q6UsZBwKy2FXBUco8RNlw0kcLVA+Xj0v9/Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCc2Yjvy8equYe4BmLCLAkhq8w7uLj8Dtd5gQlB7oUnUsguGgPahbQAYBWIekYogWJrr99cyIvJ0WpyP6r/YCK2VEqnFoR2ZXLInsCz2w1YfqEMRtkEkLtrmf8GEwEY+viqZfkMabg8HdgQTD0KiHcNnHzVBx7FrwMDuh5h2LUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lih/TC6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473BBC32786
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719434734;
	bh=ay3njX9q6UsZBwKy2FXBUco8RNlw0kcLVA+Xj0v9/Tg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lih/TC6IUU/bEFee0YnOwAz9bHnxsC1P9VxnRtBq3zIHPNwkzPDmxS+CqBZlku/ty
	 W/A8r4Ks9pzUaJtIq9sKKdPLoXTqzUZ+K5zr04ZTvwr+s/sf2dFoX44f7htDLPZQvA
	 N6L+hXaOLNsgl/IyDY1p4IbW5CHLTy31b0FFZhbp/s4n3iU2qx+8k5zm8zTndvZMrF
	 mHzHSt0Jh5cioZ/dwqQFnTbDGO0V/xc92p/oPQ+huqnu2w/gbXgTLkSik311hWEZPT
	 P/CPtbMho9kvS+yK6CNUZ+YKGyZzxKNUub1d8x9qKP/5El5TqddUFeKq/yBdEuLPaJ
	 LOomnuiytnhdw==
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4449beccc7fso22373241cf.0
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 13:45:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqcSuFumqpmmDC02vmQc7pFyU+VbXjbl53DHtFM5y4rw0kX4UI7i5mbQzyzZb74otauXx5altY52wu8eG3YyMk74v9WkpiUtP0
X-Gm-Message-State: AOJu0YxAsyqF6BafaTaS69XZlYoGoIlxn04liepP9XZ/KMJkAnnWsQoY
	d7mvvuds6o23e9j+uzWON+iu/vUJ5RP0c+OKPfR7p28g9aF6TvwlzT11F0k8brl6HrfbnidoLxI
	Xwv3vtoYedN7g31epfgyyAQbCnqE=
X-Google-Smtp-Source: AGHT+IHLvPkssnYZbbo+Vre0KviLkjJYr7boEqFXsb54A2lcAa4TqP/SbRAIfmwRP0iKqOPteZSAxlPGzdOtSbobnB8=
X-Received: by 2002:a05:622a:1802:b0:441:46ed:bcb4 with SMTP id
 d75a77b69052e-444d9215859mr133461311cf.48.1719434733488; Wed, 26 Jun 2024
 13:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626182438.69539-1-snitzer@kernel.org> <Znxio4K8yHfNst7O@tissot.1015granger.net>
In-Reply-To: <Znxio4K8yHfNst7O@tissot.1015granger.net>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 26 Jun 2024 16:45:17 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=U00F_Fyuiwb0E_jC-0Wx7p2vbsfHSO3G9X4qyo=RCGg@mail.gmail.com>
Message-ID: <CAFX2Jf=U00F_Fyuiwb0E_jC-0Wx7p2vbsfHSO3G9X4qyo=RCGg@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] nfs/nfsd: add support for localio
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>, 
	snitzer@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:49=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Wed, Jun 26, 2024 at 02:24:20PM -0400, Mike Snitzer wrote:
> > Hi,
> >
> > Changes since v7:
> > - Switched from using SRCU to percpu_ref to interlock
> >   nfsd_destroy_serv() and nfsd_open_local_fh().
> > - Dropped the "nfs/localio: use dedicated workqueues for filesystem
> >   read and write" patch, will revisit if/when needed based on evidence
> > - Changed NFSD_MAY_LOCALIO from 0x800000 to 0x2000.
> > - Various renames in fs/nfsd/localio.c XDR code suggested by Chuck.
> > - Fixed localio_procedures1 and ARRAY_SIZE  suggested by Neil.
> > - Fixed nfsd_uuid_is_local() to dereference nfsd_uuid within rcu
> > - Removed a few dprintk in fs/{nfs,nfsd}/localio.c
> > - Documentation improvements suggested by Jeff.
> >
> > TODO:
> > - Must fix xfstests generic/355 (clear suid bit on write)
> > - Must fix localio's nfs_get_vfs_attr() to support NFS v4 same as is
> >   done with nfsd4_change_attribute(). But first attempt to do so was
> >   met with a crash due to the extra STATX_BTIME | STATX_CHANGE_COOKIE
> >   being included in the request_mask passed to vfs_getattr().
> >
> > All review and comments are welcome!
> >
> > Thanks,
> > Mike
> >
> > My git tree is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/
> >
> > This v8 is both branch nfs-localio-for-6.11 (always tracks latest)
> > and nfs-localio-for-6.11.v8
> >
> > Mike Snitzer (10):
> >   nfs_common: add NFS LOCALIO auxiliary protocol enablement
> >   nfsd: add "localio" support
> >   nfsd/localio: manage netns reference in nfsd_open_local_fh
> >   nfsd: use percpu_ref to interlock nfsd_destroy_serv and nfsd_open_loc=
al_fh
> >   nfs/nfsd: add Kconfig options to allow localio to be enabled
> >   nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
> >   SUNRPC: remove call_allocate() BUG_ON if p_arglen=3D0 to allow RPC wi=
th void arg
> >   nfs: implement client support for NFS_LOCALIO_PROGRAM
> >   nfsd: implement server support for NFS_LOCALIO_PROGRAM
> >   nfs: add Documentation/filesystems/nfs/localio.rst
> >
> > NeilBrown (1):
> >   SUNRPC: replace program list with program array
> >
> > Trond Myklebust (2):
> >   NFS: Enable localio for non-pNFS I/O
> >   pnfs/flexfiles: Enable localio for flexfiles I/O
> >
> > Weston Andros Adamson (5):
> >   nfs: pass nfs_client to nfs_initiate_pgio
> >   nfs: pass descriptor thru nfs_initiate_pgio path
> >   nfs: pass struct file to nfs_init_pgio and nfs_init_commit
> >   sunrpc: add rpcauth_map_to_svc_cred_local
> >   nfs: add "localio" support
> >
> >  Documentation/filesystems/nfs/localio.rst | 135 ++++
> >  fs/Kconfig                                |   3 +
> >  fs/nfs/Kconfig                            |  14 +
> >  fs/nfs/Makefile                           |   1 +
> >  fs/nfs/blocklayout/blocklayout.c          |   6 +-
> >  fs/nfs/client.c                           |  15 +-
> >  fs/nfs/filelayout/filelayout.c            |  16 +-
> >  fs/nfs/flexfilelayout/flexfilelayout.c    | 131 +++-
> >  fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
> >  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
> >  fs/nfs/inode.c                            |   4 +
> >  fs/nfs/internal.h                         |  60 +-
> >  fs/nfs/localio.c                          | 793 ++++++++++++++++++++++
> >  fs/nfs/nfs4xdr.c                          |  13 -
> >  fs/nfs/nfstrace.h                         |  61 ++
> >  fs/nfs/pagelist.c                         |  32 +-
> >  fs/nfs/pnfs.c                             |  24 +-
> >  fs/nfs/pnfs.h                             |   6 +-
> >  fs/nfs/pnfs_nfs.c                         |   2 +-
> >  fs/nfs/write.c                            |  13 +-
> >  fs/nfs_common/Makefile                    |   3 +
> >  fs/nfs_common/nfslocalio.c                |  74 ++
> >  fs/nfsd/Kconfig                           |  14 +
> >  fs/nfsd/Makefile                          |   1 +
> >  fs/nfsd/filecache.c                       |   2 +-
> >  fs/nfsd/localio.c                         | 329 +++++++++
> >  fs/nfsd/netns.h                           |  12 +-
> >  fs/nfsd/nfsctl.c                          |   2 +-
> >  fs/nfsd/nfsd.h                            |   2 +-
> >  fs/nfsd/nfssvc.c                          | 116 +++-
> >  fs/nfsd/trace.h                           |   3 +-
> >  fs/nfsd/vfs.h                             |   9 +
> >  include/linux/nfs.h                       |   9 +
> >  include/linux/nfs_fs.h                    |   2 +
> >  include/linux/nfs_fs_sb.h                 |  10 +
> >  include/linux/nfs_xdr.h                   |  20 +-
> >  include/linux/nfslocalio.h                |  41 ++
> >  include/linux/sunrpc/auth.h               |   4 +
> >  include/linux/sunrpc/svc.h                |   7 +-
> >  net/sunrpc/auth.c                         |  15 +
> >  net/sunrpc/clnt.c                         |   1 -
> >  net/sunrpc/svc.c                          |  68 +-
> >  net/sunrpc/svc_xprt.c                     |   2 +-
> >  net/sunrpc/svcauth_unix.c                 |   3 +-
> >  44 files changed, 1951 insertions(+), 135 deletions(-)
> >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> >  create mode 100644 fs/nfs/localio.c
> >  create mode 100644 fs/nfs_common/nfslocalio.c
> >  create mode 100644 fs/nfsd/localio.c
> >  create mode 100644 include/linux/nfslocalio.h
> >
> > --
> > 2.44.0
> >
>
> Shall we start to think about how to merge this?
>
> Should all of it go through one tree, or can the NFSD pieces be
> taken via the NFSD tree and the NFS pieces via the NFS client tree?
>
> Trond, Anna, opinions?

I don't have a strong preference either way. If it can be divided up
easily then it could go in through separate trees, but if not I'm okay
with one tree. I'm assuming aim for 6.12 so it has some soak time in
-next?

Anna

>
> --
> Chuck Lever

