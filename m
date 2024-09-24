Return-Path: <linux-nfs+bounces-6631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D424F984CA2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 23:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4BC28426A
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80E12D758;
	Tue, 24 Sep 2024 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxzUxYiC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05976139D
	for <linux-nfs@vger.kernel.org>; Tue, 24 Sep 2024 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212678; cv=none; b=Ub2Nd7sZvTy3csV5SBVJQgGCH8vIRAYqHlwOXMoJojzjHcGtINQy6wG05wATZLPcSIRS9ACus53uY/eBfGzi5BsFWp5i7GG5prOXbYkSKZZLoeGv/X0XlvULahYQFsdt1S567JJdsoJ4sEWKEG/eyULiIuz2uGQN4Dv3m5Z0c+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212678; c=relaxed/simple;
	bh=gF2wCzx+krOYhSa4r9m9SKKUfo3L3A4BhB+Ejnw1X3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvGha+kCXT+XTvMHhTxAHQx/7NAVM5gC4ZgMkEd9xvuGyQXUuLrzksLQMw7NtQ24lOBLe3XH5mrmBPwIVSD9c/L2mBkKK8VyQbFgUklioSwMbiZdZz8qmQH+Crd4tSb5VmLslbuaPGGgn8CdmArSXV7ui0ZdWXKBIG+s2/D09zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxzUxYiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8E1C4CEC4;
	Tue, 24 Sep 2024 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727212677;
	bh=gF2wCzx+krOYhSa4r9m9SKKUfo3L3A4BhB+Ejnw1X3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=OxzUxYiCZpJg2AL1u9N0UFIAT/rQC4bYQOR7qf7r9wK1kGHMrOZLr4n3ibJj/DsSr
	 PTZh/dva/9nZNssWepqVA6uJ1lIIX23Xk2agabJPSP4Cr6riKvpBKABFp4JX8xFchJ
	 3aOMN8+q33M+v7DNCCg18JhY+JFQGm0QrPH6cnumMFlVZBK68IuqSxknzfkRzSBLoo
	 aIoUKzJmSy+QVO+ZCiDaMnP87z1Hl3s1UB552IZC9LWL+gwTqHDepl7hqdgWBUPJVg
	 4IKbfWofxP8tw+/L0lAlzPh3XKHeBJdJWU0VwOTrPl4UKMpRV3WCmhsy4JRut3Csal
	 v9ZhPcn1tyS6A==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please pull NFS CLient Updates for Linux 6.12
Date: Tue, 24 Sep 2024 17:17:55 -0400
Message-ID: <20240924211755.186104-1-anna@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 8c04a6d6e07ce565928ea98ae8c534cac871af19:

  Merge tag 'nfsd-6.12' into linux-next-with-localio (2024-09-23 15:00:07 -0400)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-1

for you to fetch changes up to 68898131d2df70d1a9ad5c2f93f0f54dd6d5c336:

  nfs: Fix `make htmldocs` warnings in the localio documentation (2024-09-24 11:16:34 -0400)

----------------------------------------------------------------
NFS Client Updates for Linux 6.12

New Features:
  * Add a 'noalignwrite' mount option for lock-less 'lost writes' prevention
  * Add support for the LOCALIO protocol extention

Bugfixes:
  * Fix memory leak in error path of nfs4_do_reclaim()
  * Simplify and guarantee lock owner uniqueness
  * Fix -Wformat-truncation warning
  * Fix folio refcounts by using folio_attach_private()
  * Fix failing the mount system call when the server is down
  * Fix detection of "Proxying of Times" server support

Cleanups:
  * Annotate struct nfs_cache_array with __counted_by()
  * Remove unnecessary NULL checks before kfree()
  * Convert RPC_TASK_* constants to an enum
  * Remove obsolete or misleading comments and declerations


The localio patches needed some of the NFSD changes contained in Chuck's
earlier pull request. I merged that into my tree so everything applies
cleanly, so hopefully that's the right way to do it. I'm happy to
fix this up if not!

Anna

----------------------------------------------------------------
Anna Schumaker (1):
      nfs: Fix `make htmldocs` warnings in the localio documentation

Chuck Lever (2):
      NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
      NFSD: Short-circuit fh_verify tracepoints for LOCALIO

Dan Aloni (1):
      nfs: add 'noalignwrite' option for lock-less 'lost writes' prevention

Gaosheng Cui (1):
      nfs: Remove obsoleted declaration for nfs_read_prepare

Hongbo Li (1):
      net/sunrpc: make use of the helper macro LIST_HEAD()

Kunwu Chan (1):
      SUNRPC: Fix -Wformat-truncation warning

Li Lingfeng (2):
      nfs: fix memory leak in error path of nfs4_do_reclaim
      nfs: fix the comment of nfs_get_root

Mike Snitzer (12):
      nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
      nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
      nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
      nfsd: add nfsd_serv_try_get and nfsd_serv_put
      SUNRPC: remove call_allocate() BUG_ONs
      nfs_common: add NFS LOCALIO auxiliary protocol enablement
      nfs_common: prepare for the NFS client to use nfsd_file for LOCALIO
      nfsd: implement server support for NFS_LOCALIO_PROGRAM
      nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
      nfs: implement client support for NFS_LOCALIO_PROGRAM
      nfs: add Documentation/filesystems/nfs/localio.rst
      nfs: add "NFS Client and Server Interlock" section to localio.rst

NeilBrown (6):
      nfs: simplify and guarantee owner uniqueness.
      NFSD: Handle @rqstp == NULL in check_nfsd_access()
      NFSD: Refactor nfsd_setuser_and_check_port()
      nfsd: factor out __fh_verify to allow NULL rqstp to be passed
      nfsd: add nfsd_file_acquire_local()
      SUNRPC: replace program list with program array

Roi Azarzar (1):
      NFSv4.2: Fix detection of "Proxying of Times" server support

Siddh Raman Pant (1):
      SUNRPC: clnt.c: Remove misleading comment

Stephen Brennan (1):
      SUNRPC: convert RPC_TASK_* constants to enum

Thorsten Blum (2):
      nfs: Annotate struct nfs_cache_array with __counted_by()
      nfs: Remove unnecessary NULL check before kfree()

Trond Myklebust (5):
      NFSv4: Fail mounts if the lease setup times out
      nfs: enable localio for non-pNFS IO
      pnfs/flexfiles: enable localio support
      nfs/localio: use dedicated workqueues for filesystem read and write
      nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst

Weston Andros Adamson (3):
      SUNRPC: add svcauth_map_clnt_to_svc_cred_local
      nfsd: add LOCALIO support
      nfs: add LOCALIO support

Zhaoyang Huang (1):
      fs: nfs: fix missing refcnt by replacing folio_set_private by folio_attach_private

 Documentation/filesystems/nfs/index.rst   |   1 +
 Documentation/filesystems/nfs/localio.rst | 357 ++++++++++++++
 fs/Kconfig                                |  23 +
 fs/nfs/Kconfig                            |   1 +
 fs/nfs/Makefile                           |   1 +
 fs/nfs/client.c                           |  21 +-
 fs/nfs/dir.c                              |   6 +-
 fs/nfs/filelayout/filelayout.c            |   6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |  56 ++-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/fs_context.c                       |   8 +
 fs/nfs/getroot.c                          |   2 +-
 fs/nfs/inode.c                            |  57 ++-
 fs/nfs/internal.h                         |  54 ++-
 fs/nfs/localio.c                          | 757 ++++++++++++++++++++++++++++++
 fs/nfs/nfs2xdr.c                          |  70 +--
 fs/nfs/nfs3xdr.c                          | 108 +----
 fs/nfs/nfs4_fs.h                          |   2 +-
 fs/nfs/nfs4proc.c                         |  16 +-
 fs/nfs/nfs4state.c                        |  22 +-
 fs/nfs/nfs4xdr.c                          |  90 +---
 fs/nfs/nfstrace.h                         |  61 +++
 fs/nfs/pagelist.c                         |  16 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/read.c                             |   3 +-
 fs/nfs/super.c                            |   3 +
 fs/nfs/write.c                            |  21 +-
 fs/nfs_common/Makefile                    |   5 +
 fs/nfs_common/common.c                    | 134 ++++++
 fs/nfs_common/nfslocalio.c                | 172 +++++++
 fs/nfsd/Kconfig                           |   1 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/export.c                          |  30 +-
 fs/nfsd/filecache.c                       | 101 +++-
 fs/nfsd/filecache.h                       |   5 +
 fs/nfsd/localio.c                         | 169 +++++++
 fs/nfsd/netns.h                           |  12 +-
 fs/nfsd/nfsctl.c                          |  27 +-
 fs/nfsd/nfsd.h                            |   6 +-
 fs/nfsd/nfsfh.c                           | 137 ++++--
 fs/nfsd/nfsfh.h                           |   2 +
 fs/nfsd/nfssvc.c                          | 105 ++++-
 fs/nfsd/trace.h                           |  21 +-
 fs/nfsd/vfs.h                             |   2 +
 include/linux/nfs.h                       |   9 +
 include/linux/nfs_common.h                |  17 +
 include/linux/nfs_fs_sb.h                 |  13 +-
 include/linux/nfs_xdr.h                   |  22 +-
 include/linux/nfslocalio.h                |  74 +++
 include/linux/sunrpc/sched.h              |  16 +-
 include/linux/sunrpc/svc.h                |   7 +-
 include/linux/sunrpc/svcauth.h            |   5 +
 net/sunrpc/cache.c                        |  10 +-
 net/sunrpc/clnt.c                         |  13 +-
 net/sunrpc/svc.c                          |  68 +--
 net/sunrpc/svc_xprt.c                     |   2 +-
 net/sunrpc/svcauth.c                      |  28 ++
 net/sunrpc/svcauth_unix.c                 |   3 +-
 58 files changed, 2521 insertions(+), 466 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/common.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfs_common.h
 create mode 100644 include/linux/nfslocalio.h

