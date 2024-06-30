Return-Path: <linux-nfs+bounces-4416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730E91D2B3
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7ED51F212A1
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4707153BD9;
	Sun, 30 Jun 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYxakxId"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF82153838
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765463; cv=none; b=fL1O+WuxFwmysYf4PlPiBe8wUGBDEyC/Lo5uzz/pnCM85EmqzYB9B8USa9StyhnzYj/UULED1XqBFXgD/sjNLOxefYP4OOULHRoNHgi6Hj+FFMz6ci73iDctrDJpz0mRTx2R8QEzzjQMwtqWDcf7Z6tggH5klRMRRKsQ4id6EYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765463; c=relaxed/simple;
	bh=uX2M82FwJ3Z9/z6+m112zSbWhk2NtArQoUprB89CtVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PT8b3+EsGDi0FenWJMepO4+8bFI3rSvRwNTNOXfWRuNdGmYeBXVXIcIJMZBFct5SmzqBOeDqC2IQlER4wbePV+K+TsFXqR/iRDPDB+4/zxWHsjq34NW7cCVD7wfwHIevZSJeJYHmC1JykJgTmRPuJuNgjHTQNOhQ+3mGgM9u0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYxakxId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6054C2BD10;
	Sun, 30 Jun 2024 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765463;
	bh=uX2M82FwJ3Z9/z6+m112zSbWhk2NtArQoUprB89CtVg=;
	h=From:To:Cc:Subject:Date:From;
	b=jYxakxIdmbMzcmn7MpfwlX12/cJJt80vRAxC1EJeVsDwj0X7fVi75ZK9DCW9LnDXY
	 d+skWFRmP0yoaQk1ML79Qx4tSj8mq1354HgqlBa+Yyb2ZmbgIVtvYhsFil3sv0y4AR
	 BkMmG0mvUksxeHz1U2/lV01QcIItFsT4hVFa+5O9LizXl5+mXBaWY6kOgTUKnbOBgV
	 tZffVJ1RYov/0SkR6Jifrl/mcZ+OBGUmokQ/5GzjMafzVtqKPGc925rIexkIFGpVPT
	 tmiOM4OKGEjGsva3Rkv/nbTnZ5OVo4UUv9qABlxDuM9++jK8LlBKwbVOzM5nmAmAX4
	 /Oqvq3uERgP2w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v10 00/19] nfs/nfsd: add support for localio
Date: Sun, 30 Jun 2024 12:37:22 -0400
Message-ID: <20240630163741.48753-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v9:
- Inverted series so that NFSD changes come before NFS.
- Addressed many of Chuck's various review comments for "[PATCH v9
  13/19] nfsd: add "localio" support"

TODO:
- Hopefully get a favorable response to this patch from XFS engineers:
  https://marc.info/?l=linux-xfs&m=171976530416523&w=2
  (otherwise, will need to revisit using dedicated workqueue patch)

All review and comments are welcome!

Thanks,
Mike

My git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/

This v10 is both branch nfs-localio-for-6.11 (always tracks latest)
and nfs-localio-for-6.11.v10

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

Trond Myklebust (2):
  nfs: enable localio for non-pNFS I/O
  pnfs/flexfiles: enable localio for flexfiles I/O

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
 fs/nfsd/localio.c                         | 329 +++++++++
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
 include/linux/nfslocalio.h                |  42 ++
 include/linux/sunrpc/auth.h               |   4 +
 include/linux/sunrpc/svc.h                |   7 +-
 net/sunrpc/auth.c                         |  15 +
 net/sunrpc/clnt.c                         |   1 -
 net/sunrpc/svc.c                          |  68 +-
 net/sunrpc/svc_xprt.c                     |   2 +-
 net/sunrpc/svcauth_unix.c                 |   3 +-
 44 files changed, 1986 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/localio.rst
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 fs/nfsd/localio.c
 create mode 100644 include/linux/nfslocalio.h

-- 
2.44.0


