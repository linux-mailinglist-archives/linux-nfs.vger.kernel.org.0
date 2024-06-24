Return-Path: <linux-nfs+bounces-4258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805A9153B1
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED492852AE
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CA19DF52;
	Mon, 24 Jun 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn3aikag"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA819AA7E
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246464; cv=none; b=UphA2pFmIvzPMJ+XPkOkYpsqTtNzbGd63n4yoSir8U6uZMWJNpxEbWyPlPG6GB/gLT2WAa7oGfSfUC1Cuq5NrmfA6YH1iVCSoe/IcX2GOEP/otKB+MkscmKMId8yTo53XrwQVwq/5rHKdVf+6HvLim7+WgFTQSCk2EUFDSBjziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246464; c=relaxed/simple;
	bh=g06GviFp/CHSc0liGrZgP/1mGa+hTqvF01U/rd8Zsu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/wLMvzGxhOMzLuZ7hj6kSNMTjOlF4Mzrlchla3vigyVNVbM7oEN8JfJjJigtJRhsD1m6/S04mSLz7RLpH2bXB3GN0UnTU+TytaydIINvAYhBHvCUezfiV55xUCXfiyJ0rtrHdhiWKydii3MXaFhVVPGxZ7sVX1Be0bT2PG/IKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn3aikag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B484C2BBFC;
	Mon, 24 Jun 2024 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246463;
	bh=g06GviFp/CHSc0liGrZgP/1mGa+hTqvF01U/rd8Zsu0=;
	h=From:To:Cc:Subject:Date:From;
	b=fn3aikagig30plidPalhmd3ErTfHxPV8H43P/mUZ3SJqEyBYjCZflWmjxPGIlc7E6
	 R9S6QhlWWapa0WTQOu5SEAWJSOtsnAIGiJ05Xr12lDc7f1Votr8yJcRAjVqviXyBJi
	 1UKjjBr9tFGHC8AXF0XeH2BToHQK3iDhq18fReZbexba83oAXoZr3z/AZ9sQ9G6Ybt
	 mQzwaRPfSwCzZlOxsuFD6Z1NHfd6SFCz2u6REfd3FmsYkO8XPVuUFQX6EGMb0orhWk
	 UwN8WLiamwVE9gla0UYLdpxdUtpzhU+HkpWI+H9Pw9f6eX2QetZ2pp033BSYU17QoL
	 WOa62ownhGs8Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v7 00/20] nfs/nfsd: add support for localio
Date: Mon, 24 Jun 2024 12:27:21 -0400
Message-ID: <20240624162741.68216-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

IANA has assigned the RPC program number 400122 for localio!

Tested with xfstests, all is passing agsint NFS v3 and v4.2 (localio
ontop of XFS) except generic/355 (which tests if suid bit gets cleared
with directio).

My git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

This v7 is both branch nfs-localio-for-6.11 (always tracks latest)
and nfs-localio-for-6.11.v7

Quite a bit has changed since v6:
- Updated to use IANA assigned RPC program number 400122.
- Thanks to Neil the localio protocol stands on its own and is
  simplified, all of Neil's changes were included. But a patch is
  needed to sunrpc to remove the BUG_ON if p_arglen is 0 (otherwise
  the NULL rpc used during connection triggers the BUG_ON.
- Reduced Kconfig knobs down to NFS_LOCALIO and NFSD_LOCALIO. Left
  them piece-wise for reason detailed in the last patch.
- Added MODULE_DESCRIPTION to nfs_localio module.
- Removed all the AIO directio code from fs/nfs/localio.c because it
  wasn't used (since nothing ever set NFS_IOHDR_ODIRECT).  But even if
  enabled the async kiocb completion wasn't ever used in practice.

TODO:
- For directio, fix kiocb so that it conveys IOCB_DIRECT to underlying
  filesystem.
- Must fix xfstests generic/355.
- Look closer at implementing standlone SRCU to avoid bloating
  nfsd_net -- idea of shared SRCU is very unintuitive to me...

FYI:
- Really rather not play games with 'localio_enabled' to get all of
  localio code to build but be disabled by default.. just too fiddley.

All review and comments are welcome!

Thanks,
Mike

Mike Snitzer (11):
  nfs_common: add NFS LOCALIO auxiliary protocol enablement
  nfsd/localio: manage netns reference in nfsd_open_local_fh
  nfs/nfsd: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
  SUNRPC: remove call_allocate() BUG_ON if p_arglen=0 to allow RPC with void arg
  nfs: implement client support for NFS_LOCALIO_PROGRAM
  nfsd: implement server support for NFS_LOCALIO_PROGRAM
  nfsd: prepare to use SRCU to dereference nn->nfsd_serv
  nfsd: use SRCU to dereference nn->nfsd_serv
  nfsd/localio: use SRCU to dereference nn->nfsd_serv in nfsd_open_local_fh
  nfs: add Documentation/filesystems/nfs/localio.rst
  nfs/nfsd: add Kconfig options to allow localio to be enabled

NeilBrown (1):
  SUNRPC: replace program list with program array

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

 Documentation/filesystems/nfs/localio.rst | 134 ++++
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
 fs/nfs/localio.c                          | 851 ++++++++++++++++++++++
 fs/nfs/nfs4xdr.c                          |  13 -
 fs/nfs/nfstrace.h                         |  61 ++
 fs/nfs/pagelist.c                         |  32 +-
 fs/nfs/pnfs.c                             |  24 +-
 fs/nfs/pnfs.h                             |   6 +-
 fs/nfs/pnfs_nfs.c                         |   2 +-
 fs/nfs/write.c                            |  13 +-
 fs/nfs_common/Makefile                    |   3 +
 fs/nfs_common/nfslocalio.c                |  72 ++
 fs/nfsd/Kconfig                           |  14 +
 fs/nfsd/Makefile                          |   1 +
 fs/nfsd/filecache.c                       |  15 +-
 fs/nfsd/localio.c                         | 327 +++++++++
 fs/nfsd/netns.h                           |  18 +-
 fs/nfsd/nfs4state.c                       |  25 +-
 fs/nfsd/nfsctl.c                          |  30 +-
 fs/nfsd/nfsd.h                            |   2 +-
 fs/nfsd/nfssvc.c                          | 165 +++--
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
 45 files changed, 2116 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


