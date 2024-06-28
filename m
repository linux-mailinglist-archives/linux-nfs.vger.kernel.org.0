Return-Path: <linux-nfs+bounces-4383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7091C7D2
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EDA2826A4
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD376C76;
	Fri, 28 Jun 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp7ToonG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0847603A
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609067; cv=none; b=DLqK7zD0xwI/kGrADkc/W3fNlYcgt/GnqIqgeau8QvEGvhmU7y0ZbzrzpniSoPablYlrZDsEPc93v64IUtRkf+xOM18pSzRpsMuSO4mcfnV5ann3tYmdILEUAz0KHTYTo0vQBq5C9Cwnz+VL3kEJMMlEy85dk45f6+IfC9bw8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609067; c=relaxed/simple;
	bh=wYU/igl6//ktQUtyFScGBamdr6Zf4636uwPS1pBqaC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KlQ/tKOlB6GVK5/NCbQBLLjwLY9SBS9Nr1RDeelP9X1cEElognKF7N5h7JdctL2KPzE/uSB8UN4C8clciNRAtTfssPei/TvPPaQAfos1DU5Kx1kl44SMqpTxwKoksg/Blj8lplG6nI4n/8LBTeeBxaQ98FrQyvt51BrHocmSSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp7ToonG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0455C116B1;
	Fri, 28 Jun 2024 21:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609067;
	bh=wYU/igl6//ktQUtyFScGBamdr6Zf4636uwPS1pBqaC0=;
	h=From:To:Cc:Subject:Date:From;
	b=rp7ToonGzMXuPpolk+7mABCSVWE/YVmeWeB1kwW6ndvFW4iqXP3kiL4fhbZhTbbNI
	 kv95L/gr9CV2RGMCkgZYWSgxfCf8S0Kq7M3x0MvQu4uDsls/KZPMbdkgslAlyTDofG
	 uSQ2VuzKDFZGShKEAxfRJlnCKKWBVFuZ49jkaSIUsPgAfDrl1iNcYQNW4fobhLmGqd
	 A3cXaedh6/8915yQnghXkbLutDXLG7l7ioIa/s+A/d+Rzq6lSp5Byf+7I02s0O5sMs
	 WkjWIQnQm0Ps8Sf+b29yFtj62zXGh1Wn9Rj8ocH82BcjntxQ8606Vrp6X9C1f/UTP9
	 2lMT2MgxNLK2A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 00/19] nfs/nfsd: add support for localio
Date: Fri, 28 Jun 2024 17:10:46 -0400
Message-ID: <20240628211105.54736-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I'd prefer to see these changes land upstream for 6.11 if possible.
They are adequately Kconfig'd to certainly pose no risk if disabled.
And even if localio enabled it has proven to work well with increased
testing.

Worked with Kent Overstreet to enable testing integration with ktest
running xfstests, the dashboard is here:
https://evilpiepirate.org/~testdashboard/ci?branch=snitm-nfs
(it is running way more xfstests tests than is usual for nfs, would be
good to reconcile that with the listing provided here:
https://wiki.linux-nfs.org/wiki/index.php/Xfstests )

Changes since v8:
- Fixed xfstests generic/355 (clear suid after write) as a side-effect
  of dropping the "nfs/localio: use dedicated workqueues for
  filesystem read and write" patch (XFS is looking at the security
  context of the task... which is really odd!)
- Refactored and fixed nfs_local_vfs_getattr() to support NFS v4 as
  requested by Neil.
- Fixed potential for localio file opens to prevent nfsd from shutting
  down (as caught by Jeff's helpful review) by switching to using
  percpu_ref_tryget_live (and renamed nfsd_serv_get to
  nfsd_serv_try_get).
- Removed all dprintk() from fs/nfsd/localio.c
- Removed one dprintk() from fs/nfs/localio.c, left others because the
  nfs client maintainers don't seem so against them (they do require
  explicit enablement after all).

TODO:
- Hopefully get a favorable response to this patch from XFS engineers:
  https://marc.info/?l=linux-xfs&m=171959152810706&w=2
  (otherwise, will need to revisit using dedicated workqueue patch)

All review and comments are welcome!

Thanks,
Mike

My git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

This v9 is both branch nfs-localio-for-6.11 (always tracks latest)
and nfs-localio-for-6.11.v9

Mike Snitzer (11):
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfs/localio: fix nfs_localio_vfs_getattr() to properly support v4
  nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
  SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
  nfs: implement client support for NFS_LOCALIO_PROGRAM
  nfsd: add "localio" support
  nfsd/localio: manage netns reference in nfsd_open_local_fh
  nfsd: use percpu_ref to interlock nfsd_destroy_serv and nfsd_open_local_fh
  nfsd: add Kconfig options to allow localio to be enabled
  nfsd: implement server support for NFS_LOCALIO_PROGRAM
  nfs: add Documentation/filesystems/nfs/localio.rst

NeilBrown (1):
  SUNRPC: replace program list with program array

Trond Myklebust (2):
  nfs: enable localio for non-pNFS I/O
  pnfs/flexfiles: Enable localio for flexfiles I/O

Weston Andros Adamson (5):
  nfs: pass nfs_client to nfs_initiate_pgio
  nfs: pass descriptor thru nfs_initiate_pgio path
  nfs: pass struct file to nfs_init_pgio and nfs_init_commit
  sunrpc: add rpcauth_map_to_svc_cred_local
  nfs: add "localio" support

 Documentation/filesystems/nfs/localio.rst | 135 ++++
 fs/Kconfig                                |   3 +
 fs/nfs/Kconfig                            |  14 +
 fs/nfs/Makefile                           |   1 +
 fs/nfs/blocklayout/blocklayout.c          |   6 +-
 fs/nfs/client.c                           |  15 +-
 fs/nfs/filelayout/filelayout.c            |  16 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    | 131 +++-
 fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |   4 +
 fs/nfs/internal.h                         |  60 +-
 fs/nfs/localio.c                          | 827 ++++++++++++++++++++++
 fs/nfs/nfs4xdr.c                          |  13 -
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  32 +-
 fs/nfs/pnfs.c                             |  24 +-
 fs/nfs/pnfs.h                             |   6 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/write.c                            |  13 +-
 fs/nfs_common/Makefile                    |   3 +
 fs/nfs_common/nfslocalio.c                |  74 ++
 fs/nfsd/Kconfig                           |  14 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/filecache.c                       |   2 +-
 fs/nfsd/localio.c                         | 319 +++++++++
 fs/nfsd/netns.h                           |  12 +-
 fs/nfsd/nfsctl.c                          |   2 +-
 fs/nfsd/nfsd.h                            |   2 +-
 fs/nfsd/nfssvc.c                          | 116 ++-
 fs/nfsd/trace.h                           |   3 +-
 fs/nfsd/vfs.h                             |   9 +
 include/linux/nfs.h                       |   9 +
 include/linux/nfs_fs.h                    |   2 +
 include/linux/nfs_fs_sb.h                 |  10 +
 include/linux/nfs_xdr.h                   |  20 +-
 include/linux/nfslocalio.h                |  41 ++
 include/linux/sunrpc/auth.h               |   4 +
 include/linux/sunrpc/svc.h                |   7 +-
 net/sunrpc/auth.c                         |  15 +
 net/sunrpc/clnt.c                         |   1 -
 net/sunrpc/svc.c                          |  68 +-
 net/sunrpc/svc_xprt.c                     |   2 +-
 net/sunrpc/svcauth_unix.c                 |   3 +-
 44 files changed, 1975 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


