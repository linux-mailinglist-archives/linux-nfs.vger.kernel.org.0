Return-Path: <linux-nfs+bounces-4008-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A628390DD29
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7EFB21FBF
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38DA15EFB1;
	Tue, 18 Jun 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYrlrz6q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078C15E5DB
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741990; cv=none; b=SyYzxTYn4GqFTThyuCC9Lplgv19ZM14dT4V4fV7hrXRCrCsUCB69xsHI7EONGUM7EXxPe/rXqKfmLBkZYju2DUqxjbVlKE72Pb7Bnr5gmlXUbyo23cgF5wUS7euvY1zhV4HU/SzbM99WQ96Y2wPziCBy5/jFGx9O5/sRITiH510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741990; c=relaxed/simple;
	bh=ch9JEbK3Y8rYaPaxE0CUETbKQ6AFDDXCM9ZtzQa05KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OuHbS5Ota27Sdm/xdM/abo2rUEs9th/EW6sH5E8H8XgEh3R+vmjpiM8bhdxkufMwKZp1Y5bkpFLcYqMrCtr9JnMGgCsomIpRmt+TX7Wl/D5uqvBshEw+YpcCai82cHdd3XrpDsk5jhAnj+MoEv3FXE1ufGKGjUaQyZnsyMFF5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYrlrz6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241F5C3277B;
	Tue, 18 Jun 2024 20:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718741990;
	bh=ch9JEbK3Y8rYaPaxE0CUETbKQ6AFDDXCM9ZtzQa05KQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NYrlrz6qQTrTXb4x/0udnc9u2Pzr3Rwmt7R0vRpNK9qmtDn0okyfrfJ5irkF5so6E
	 g/Mj1meuguzD+QTnWPYB/S4vr70CFnC2BLL0IrEdk5tf94bpVLSv//iXCZ5l6NvgXc
	 0qfpP/RhxhT7k4ccYmZuXuP6Ys0eVdPe3Cx66ZJ0fGfWH9b7sP2s5ezvXU0F+SlT9+
	 Xyd+ESFjH3KXVOAUFzkhvBkElS4eYG+08cKHPJfk/5kqCgEawJkkW42ME+9r85bm4B
	 5jnfE/BZFwxgu35lwaEOghC9EyNx7lcGRlaaJjqzBYC7hiEbrWgt8lO3rJd8Iy+/lp
	 nKfGe6JHHzg7A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v5 00/19] nfs/nfsd: add support for localio
Date: Tue, 18 Jun 2024 16:19:30 -0400
Message-ID: <20240618201949.81977-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This v5 is rebased on Chuck's nfsd-next (only required one adjustment
in patch 15 to account for new code that dereferences nn->nfsd_serv).

Only other change is patch 19 to add Documentation/filesystems/nfs/localio.rst

My git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

This v5 is both branch nfs-localio-for-6.11 (always tracks latest)
and nfs-localio-for-6.11.v5

Branches nfs-localio-for-6.11.v[1234] are also available.

To see the changes from v4 to v5 please do:
git remote add snitzer git://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git
git remote update snitzer
git diff snitzer/nfs-localio-for-6.11.v4 snitzer/nfs-localio-for-6.11.v5

[NOTE: there will be noise due to nfsd-next causing the base kernel to
       move from v6.10-rc2 to v6.10-rc3]

All review and comments are welcome!

Thanks,
Mike

Mike Snitzer (11):
  nfs_common: add NFS LOCALIO protocol extension enablement
  nfs: implement v3 and v4 client support for NFS_LOCALIO_PROGRAM
  nfsd: implement v3 and v4 server support for NFS_LOCALIO_PROGRAM
  nfs/nfsd: consolidate {encode,decode}_opaque_fixed in nfs_xdr.h
  nfs/localio: move managing nfsd_open_local_fh symbol to nfs_common
  nfs/nfsd: ensure localio server always uses its network namespace
  nfsd/localio: manage netns reference in nfsd_open_local_fh
  nfsd: prepare to use SRCU to dereference nn->nfsd_serv
  nfsd: use SRCU to dereference nn->nfsd_serv
  nfsd/localio: use SRCU to dereference nn->nfsd_serv in nfsd_open_local_fh
  nfs: add Documentation/filesystems/nfs/localio.rst

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

 Documentation/filesystems/nfs/localio.rst | 101 +++
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
 fs/nfsd/netns.h                           |  16 +-
 fs/nfsd/nfs4state.c                       |  25 +-
 fs/nfsd/nfsctl.c                          |  28 +-
 fs/nfsd/nfsd.h                            |  11 +
 fs/nfsd/nfssvc.c                          | 182 ++++-
 fs/nfsd/trace.h                           |   3 +-
 fs/nfsd/vfs.h                             |   9 +
 fs/nfsd/xdr.h                             |   6 +
 include/linux/nfs.h                       |   2 +
 include/linux/nfs_fs.h                    |   2 +
 include/linux/nfs_fs_sb.h                 |   9 +
 include/linux/nfs_xdr.h                   |  31 +-
 include/linux/nfslocalio.h                |  41 ++
 include/linux/sunrpc/auth.h               |   4 +
 include/uapi/linux/nfs.h                  |   4 +
 net/sunrpc/auth.c                         |  15 +
 49 files changed, 2388 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


