Return-Path: <linux-nfs+bounces-4089-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A8990F798
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DEE1F22350
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35D158D6C;
	Wed, 19 Jun 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtR2ymSn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946D46426
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829634; cv=none; b=IBEOzAXiw/oCnTxelLkpyQ0AZl/2tqIYA9Aqk7wqTiJv3pGBAVjWXNdUN9UmCFgfpAy4p0t2qQkvS2xZ43V43ifkODvvmPQL5cvljYjMNkmu+AQFQJYKLwic4zo9w5YWnHQh9uQ6EnvWpjoTzh49ML+KLZabgTOu2CtxoGgqKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829634; c=relaxed/simple;
	bh=YQMG5M6h19EeN9pSDndPZ2RQ95UwFOX6Ogoj3/zkkfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmFdpGRDxMoS1k5FUV/qxTWRPrGHXgPK0zkmcMsI5LR48fQIkH2gVV/UhEn15gG8ipdNpchP2jSKNfHKCbdPTmF+cS6BTPkcPiJFcpweemKbcM/ugNPp3unE7SJat2fvUx6Tk5xdNfmCtCe2ywXif64adCR4quTGygghiwMlvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtR2ymSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C57C2BBFC;
	Wed, 19 Jun 2024 20:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829634;
	bh=YQMG5M6h19EeN9pSDndPZ2RQ95UwFOX6Ogoj3/zkkfo=;
	h=From:To:Cc:Subject:Date:From;
	b=UtR2ymSnBsG5F2+jucV/MIHeRS+X7z4xQfGqo9SPDyUv8w27+cNfKxq368HSSZn5o
	 llbTcLxaV1X+AbTqAd0cN0MzyBCpsrKEUMgu4rqBiOK9u0bacAVXJQ4xL3dKv6rjb2
	 7DgQqJl6rsnCTa5joMQ3bDGvmVHM9wAk9MkPtFzr2DbkwFROxZgrzGZDDTl3Lo3Cxa
	 WqbXLpAp1GQmXEqGfoSHsI6IYnR9hzRdiMmMU+9Al1xGZQZgKbSRLzQ1D3+6bV4Y/7
	 qie+x0wCdt1ncBMfWnBfNpFyqK6RXIrEwE+1Qh/S+LOQvNnHnCcCLo1doBdcunA5zc
	 i+mjw7ylbPhMw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 00/18] nfs/nfsd: add support for localio
Date: Wed, 19 Jun 2024 16:40:14 -0400
Message-ID: <20240619204032.93740-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This v6 changes include:
- Quite a bit of rebasing to eliminate intermediate steps that include
  throwaway code (thanks to Jeff Layton for calling those out).
- Moved the Kconfig changes to the end of the series to ensure that
  localio cannot be enabled until the code is feature complete.
- Removed needless nfsd_serv_sync() call from nfsd_create_serv().
- Removed inline from fs/nfsd/localio.c:nfs_stat_to_errno
- Wrapped localio struct nfs_client members and related
  fs/nfs/client.c init code with #if IS_ENABLED(CONFIG_NFS_LOCALIO)
- Requested a unique RPC program number from IANA but switched to
  using 0x20000002 until one is assigned.
- Improved the Documentation and some code comments.

Otherwise, not a lot of actual code changes.

My git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

This v6 is both branch nfs-localio-for-6.11 (always tracks latest)
and nfs-localio-for-6.11.v6

Branches nfs-localio-for-6.11.v[12345] are also available.

To see the changes from v5 to v6 please do:
git remote add snitzer git://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git
git remote update snitzer
git diff snitzer/nfs-localio-for-6.11.v5 snitzer/nfs-localio-for-6.11.v6

All review and comments are welcome!

Thanks,
Mike

Mike Snitzer (10):
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfsd/localio: manage netns reference in nfsd_open_local_fh
  nfs: implement v3 and v4 client support for NFS_LOCALIO_PROGRAM
  nfsd: implement v3 and v4 server support for NFS_LOCALIO_PROGRAM
  nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h
  nfsd: prepare to use SRCU to dereference nn->nfsd_serv
  nfsd: use SRCU to dereference nn->nfsd_serv
  nfsd/localio: use SRCU to dereference nn->nfsd_serv in nfsd_open_local_fh
  nfs: add Documentation/filesystems/nfs/localio.rst
  nfs/nfsd: add Kconfig options to allow localio to be enabled

Trond Myklebust (3):
  NFS: Enable localio for non-pNFS I/O
  pnfs/flexfiles: Enable localio for flexfiles I/O
  nfs/localio: use dedicated workqueues for filesystem read and write

Weston Andros Adamson (5):
  nfs: pass nfs_client to nfs_initiate_pgio
  nfs: pass descriptor thru nfs_initiate_pgio path
  nfs: pass struct file to nfs_init_pgio and nfs_init_commit
  sunrpc: add rpcauth_map_to_svc_cred_local
  nfs/nfsd: add "localio" support

 Documentation/filesystems/nfs/localio.rst | 148 ++++
 fs/Kconfig                                |   3 +
 fs/nfs/Kconfig                            |  30 +
 fs/nfs/Makefile                           |   1 +
 fs/nfs/blocklayout/blocklayout.c          |   6 +-
 fs/nfs/client.c                           |  15 +-
 fs/nfs/filelayout/filelayout.c            |  16 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    | 131 +++-
 fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
 fs/nfs/inode.c                            |  61 +-
 fs/nfs/internal.h                         |  88 ++-
 fs/nfs/localio.c                          | 850 ++++++++++++++++++++++
 fs/nfs/nfs3_fs.h                          |   1 +
 fs/nfs/nfs3client.c                       |  25 +
 fs/nfs/nfs3proc.c                         |   3 +
 fs/nfs/nfs3xdr.c                          |  58 ++
 fs/nfs/nfs4_fs.h                          |   2 +
 fs/nfs/nfs4client.c                       |  23 +
 fs/nfs/nfs4proc.c                         |   3 +
 fs/nfs/nfs4xdr.c                          |  65 +-
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  32 +-
 fs/nfs/pnfs.c                             |  24 +-
 fs/nfs/pnfs.h                             |   6 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/write.c                            |  13 +-
 fs/nfs_common/Makefile                    |   3 +
 fs/nfs_common/nfslocalio.c                |  71 ++
 fs/nfsd/Kconfig                           |  30 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/filecache.c                       |  15 +-
 fs/nfsd/localio.c                         | 398 ++++++++++
 fs/nfsd/netns.h                           |  18 +-
 fs/nfsd/nfs4state.c                       |  25 +-
 fs/nfsd/nfsctl.c                          |  28 +-
 fs/nfsd/nfsd.h                            |  11 +
 fs/nfsd/nfssvc.c                          | 181 ++++-
 fs/nfsd/trace.h                           |   3 +-
 fs/nfsd/vfs.h                             |   9 +
 fs/nfsd/xdr.h                             |   6 +
 include/linux/nfs.h                       |   2 +
 include/linux/nfs_fs.h                    |   2 +
 include/linux/nfs_fs_sb.h                 |  10 +
 include/linux/nfs_xdr.h                   |  31 +-
 include/linux/nfslocalio.h                |  41 ++
 include/linux/sunrpc/auth.h               |   4 +
 include/uapi/linux/nfs.h                  |   4 +
 net/sunrpc/auth.c                         |  15 +
 49 files changed, 2438 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


