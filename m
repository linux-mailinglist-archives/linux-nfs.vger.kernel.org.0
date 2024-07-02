Return-Path: <linux-nfs+bounces-4537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10182924384
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43737B256AC
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D71BD4EC;
	Tue,  2 Jul 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+K5+Vaw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5451BD4EA
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937713; cv=none; b=pvdwjw7n4JeZqtcADzzcdPRgOo2fgxwNW+4gyeCWp6k+M45C2HUahobCXqvVMep1KwIyX/uxHyadsGhHyXghNmRDE2aVUuvYxmizOH0ZFPGAPdm6SDW9QxVu86CyatsTBfVdO4K1UQ0cneb4Fd9s2UbEsykTGs7aAqKcfAypLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937713; c=relaxed/simple;
	bh=V6RY6MeyJXYv8vUNNxPRN8VqwevxKf6DMy8isvr8GDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dl9oafLrKccqXJD1J2kT0SVfxurr/8gmz8gAPf4hWu4Sj2fKIuWc5RInXIX8lGq/BTR7aEN1qzzql5e1+98NRUIeGnNCfqKv2f3ffnzAlcsladooizeQEWO7ccZi0GOEsjzkqNOTT4d80Zkj2He5rhfp3Munyq3XK9LZCFA9NoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+K5+Vaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7031FC116B1;
	Tue,  2 Jul 2024 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937712;
	bh=V6RY6MeyJXYv8vUNNxPRN8VqwevxKf6DMy8isvr8GDo=;
	h=From:To:Cc:Subject:Date:From;
	b=p+K5+VawU3Cj8M+hM0Ijpo4BLNTeA41CluZ+zarWajMw0TmicscUVurxbfoiC7Aqv
	 cLpoOYP2UcTX0mJIZTIQC8+LzMxVfNBzPReGrbOPTaomRiDZFpZKYGDxhwUsN25rGn
	 tavlX/l/naLse+MdMmTZBzXstgPrbmrv0WCGwb4vanFfR93dyrcQv46aMc2M+vGWgk
	 FGCz/bhtdAicxvRl1XAjB3+5IGenesOhbQsZqmjyGej5aDcR5ZAZilh/i3VZ80CyMl
	 03GaNlpPabcxnXI/IIDfyzLBv5Rrj2TopMhOY8ZM5pAnN67Ycgw1ne5+s/uIJx8DBf
	 jhcSvZKLSsong==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v11 00/20] nfs/nfsd: add support for localio
Date: Tue,  2 Jul 2024 12:28:11 -0400
Message-ID: <20240702162831.91604-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

There seems to be consensus that these changes worthwhile and
extensively iterated on.  I really appreciate the coordinated
development and review to this point.

I'd very much like these changes to land upstream as-is (unless review
teases out some show-stopper).  These changes have been tested fairly
extensively (via xfstests) at this point.

Can we noew please provide formal review tags and merge these changes
through the NFS client tree for 6.11?

Changes since v10:
- Now that XFS will _not_ be patched with "xfs: enable WQ_MEM_RECLAIM
  on m_sync_workqueue", reintroduce "nfs/localio: use dedicated workqueues for
  filesystem read and write" (patch 18).  Also fixed it so that it passes
  xfstests generic/355.

FYI:
- I do not intend to rebase this series ontop of NeilBrown's partial
  exploration of simplifying away the need for a "fake" svc_rqst
  (noble goals and happy to help those changes land upstream as an
  incremental improvement):
  https://marc.info/?l=linux-nfs&m=171980269529965&w=2

- In addition, tweaks to use nfsd_file_acquire_gc() instead of
  nfsd_file_acquire() aren't a priority.  Each incremental change
  comes with it the potential for regression and we need to lock-down
  and stop churning.  Happy to explore as incremental improvement and
  optimization.

All review and comments are welcome!

Thanks,
Mike

My git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

This v11 is both branch nfs-localio-for-6.11 (always tracks latest)
and nfs-localio-for-6.11.v11

Mike Snitzer (10):
  nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfsd: add Kconfig options to allow localio to be enabled
  nfsd: manage netns reference in nfsd_open_local_fh
  nfsd: use percpu_ref to interlock nfsd_destroy_serv and nfsd_open_local_fh
  nfsd: implement server support for NFS_LOCALIO_PROGRAM
  nfs: fix nfs_localio_vfs_getattr() to properly support v4
  SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
  nfs: implement client support for NFS_LOCALIO_PROGRAM
  nfs: add Documentation/filesystems/nfs/localio.rst

NeilBrown (1):
  SUNRPC: replace program list with program array

Trond Myklebust (3):
  nfs: enable localio for non-pNFS I/O
  pnfs/flexfiles: enable localio for flexfiles I/O
  nfs/localio: use dedicated workqueues for filesystem read and write

Weston Andros Adamson (6):
  SUNRPC: add rpcauth_map_to_svc_cred_local
  nfsd: add "localio" support
  nfs: pass nfs_client to nfs_initiate_pgio
  nfs: pass descriptor thru nfs_initiate_pgio path
  nfs: pass struct file to nfs_init_pgio and nfs_init_commit
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
 fs/nfs/inode.c                            |  61 +-
 fs/nfs/internal.h                         |  61 +-
 fs/nfs/localio.c                          | 891 ++++++++++++++++++++++
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
 fs/nfsd/localio.c                         | 329 ++++++++
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
 include/linux/nfslocalio.h                |  42 +
 include/linux/sunrpc/auth.h               |   4 +
 include/linux/sunrpc/svc.h                |   7 +-
 net/sunrpc/auth.c                         |  15 +
 net/sunrpc/clnt.c                         |   1 -
 net/sunrpc/svc.c                          |  68 +-
 net/sunrpc/svc_xprt.c                     |   2 +-
 net/sunrpc/svcauth_unix.c                 |   3 +-
 44 files changed, 2089 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


