Return-Path: <linux-nfs+bounces-4325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C90918E4C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F191C21AA7
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B5190486;
	Wed, 26 Jun 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxZXckzO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729819047F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426280; cv=none; b=nMwr9AGfpVcIcKegacJwknMtA7Ah7YOjLCQ00a83OYfNhFhQM1qOTfFe1KLC9DQXSX8rGBQza5Xl5Eta8JLcNgAE1YpXLKm/SKlZc47Vl4BZF4jjRbf2cNhDQb3+z0njitCvA2AGtDiJ53Em/QCxIc45r3IbNJPhSmKnOc8DEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426280; c=relaxed/simple;
	bh=L0bZQVpwrzA+sDuKHr2ThibblA1SajCNj30woObtejQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Del21yR8FKM5R4HLya/QbnLkOavvRzpQ92z//+fsKI95GSSeEF5+c2rYXHmATsrw78C0G3MZ6lKANTl4F9tiIdvO4PA7tYoUFQs+c176s9dPyfiTB2PV5gjUiZ9WAk7BMwFrGQ0/UtflS1HlNCjz1zHNYVa65ciQuVr3WpMmNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxZXckzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8413AC116B1;
	Wed, 26 Jun 2024 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426279;
	bh=L0bZQVpwrzA+sDuKHr2ThibblA1SajCNj30woObtejQ=;
	h=From:To:Cc:Subject:Date:From;
	b=kxZXckzO4OoFWBDtkwEzM3C0DjyrP0Pp2UkFE4znEW7sW4b3sYAbcVdPq/C+4fnHR
	 R9jOO3ndgVNUDOeJ7bXNy8GbfZIS/cTB/Pft0C2rp97whjgQi7LmQKT5mb3ScDjwuD
	 /179riHBzMfXyTNsuo7ZF4gW6XSzPRB6ogUBAnMMP+ST7PUFhHConAIFWrLCma4VFx
	 RNXzaxWWX/u7NXTkbCErvQJNHsSA/Ig9OPrcn52yWXUOOyU0qHTsQyZAp1psrR9sES
	 4ioV1/wTs1VDWSUNTK1KymRJuwhliUFJQc10xyfnhhzU7T3uAwowKvTSRbqIGGfhMT
	 gzjGh8obvD98A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 00/18] nfs/nfsd: add support for localio
Date: Wed, 26 Jun 2024 14:24:20 -0400
Message-ID: <20240626182438.69539-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v7:
- Switched from using SRCU to percpu_ref to interlock
  nfsd_destroy_serv() and nfsd_open_local_fh().
- Dropped the "nfs/localio: use dedicated workqueues for filesystem
  read and write" patch, will revisit if/when needed based on evidence
- Changed NFSD_MAY_LOCALIO from 0x800000 to 0x2000.
- Various renames in fs/nfsd/localio.c XDR code suggested by Chuck. 
- Fixed localio_procedures1 and ARRAY_SIZE  suggested by Neil.
- Fixed nfsd_uuid_is_local() to dereference nfsd_uuid within rcu
- Removed a few dprintk in fs/{nfs,nfsd}/localio.c
- Documentation improvements suggested by Jeff.

TODO:
- Must fix xfstests generic/355 (clear suid bit on write)
- Must fix localio's nfs_get_vfs_attr() to support NFS v4 same as is
  done with nfsd4_change_attribute(). But first attempt to do so was
  met with a crash due to the extra STATX_BTIME | STATX_CHANGE_COOKIE
  being included in the request_mask passed to vfs_getattr().

All review and comments are welcome!

Thanks,
Mike

My git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

This v8 is both branch nfs-localio-for-6.11 (always tracks latest)
and nfs-localio-for-6.11.v8

Mike Snitzer (10):
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfsd: add "localio" support
  nfsd/localio: manage netns reference in nfsd_open_local_fh
  nfsd: use percpu_ref to interlock nfsd_destroy_serv and nfsd_open_local_fh
  nfs/nfsd: add Kconfig options to allow localio to be enabled
  nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
  SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
  nfs: implement client support for NFS_LOCALIO_PROGRAM
  nfsd: implement server support for NFS_LOCALIO_PROGRAM
  nfs: add Documentation/filesystems/nfs/localio.rst

NeilBrown (1):
  SUNRPC: replace program list with program array

Trond Myklebust (2):
  NFS: Enable localio for non-pNFS I/O
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
 fs/nfs/localio.c                          | 793 ++++++++++++++++++++++
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
 fs/nfsd/localio.c                         | 329 +++++++++
 fs/nfsd/netns.h                           |  12 +-
 fs/nfsd/nfsctl.c                          |   2 +-
 fs/nfsd/nfsd.h                            |   2 +-
 fs/nfsd/nfssvc.c                          | 116 +++-
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
 44 files changed, 1951 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


