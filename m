Return-Path: <linux-nfs+bounces-9727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791F5A213D7
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA243A15E0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F7197A87;
	Tue, 28 Jan 2025 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4d8BreN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6719755B
	for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101871; cv=none; b=dePdBn9BTZJAjSg+OFrvfWdY3CJqS27fw7leJ8L3ebJJ3GM9CKAeUF2vRPm1UjbCP0Csa1JuKOMSRyABbVOcFGYJFUH43YNe57di0wtrHvIzeDRjA2rV1aQlxNT+CZ9rLffGKMnmcot8N7feRA2ujYv8v/7SnQfIu4tyBSirEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101871; c=relaxed/simple;
	bh=VG3zGgRQ/mLv7lvJuPkLNbLFpG49HMLt2UKCVjRN5xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VR+qYDorCY4RFAtcHYwmuuBiWQxSYGq5gLd0XlCUIQn01oYWfSxBV85lJdnLL4CBsv2UIO0ErK9O+pmGCm++SKawm64Qby7UN4S5lfKBXBS8nqiv2/6eesEA7jltQF8BdJFFWfD9Ob9mnPB2wbwyGLjID3Ggyd6fXrYlkxc02MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4d8BreN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12BBC4CED3;
	Tue, 28 Jan 2025 22:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738101871;
	bh=VG3zGgRQ/mLv7lvJuPkLNbLFpG49HMLt2UKCVjRN5xA=;
	h=From:To:Cc:Subject:Date:From;
	b=E4d8BreN5zuxZZE8wqHSirDGCE3JK7rLkHbryKk3PECXGL9DjSaS7Nerm/Gq+/bx9
	 YdvMNVgmt72o5u8SVNtqyAPki9BthbfufEG2iGpZ3Zcx8SbQRMl0zYxSJRg6lrDbwp
	 QFCgoLcJ3rp9cl2m4tzAWN5RjPB4urKWkEOn+1ze2Neg0xwFoMBypWVeaN2PSDjUO3
	 41m0P8sZxRv8CKJT45SeD8txjw5HW+r1bGZH4x2xHC0RJLiUZXCJowdg+HdFWP8z0S
	 pynBd+dXzLYJAV77vM80M6yXQWJMCavQS+0Xh4Hr4W/w8H87FStLHt5mhfKuIw46jc
	 iQHym9CCXE6eA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 6.14
Date: Tue, 28 Jan 2025 17:04:29 -0500
Message-ID: <20250128220429.377435-1-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 5bc55a333a2f7316b58edc7573e8e893f7acb532:

  Linux 6.13-rc7 (2025-01-12 14:37:56 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.14-1

for you to fetch changes up to 6f56971841a178e99c502f4150fa28b9d699ed31:

  SUNRPC: do not retry on EKEYEXPIRED when user TGT ticket expired (2025-01-22 15:53:31 -0500)

----------------------------------------------------------------
NFS Client Updates for Linux 6.14

New Features:
  * Enable using direct IO with localio
  * Added localio related tracepoints

Bugfixes:
  * Sunrpc fixes for working with a very large cl_tasks list
  * Fix a possible buffer overflow in nfs_sysfs_link_rpc_client()
  * Fixes for handling reconnections with localio
  * Fix how the NFS_FSCACHE kconfig option interacts with NETFS_SUPPORT
  * Fix COPY_NOTIFY xdr_buf size calculations
  * pNFS/Flexfiles fix for retrying requesting a layout segment for reads
  * Sunrpc fix for retrying on EKEYEXPIRED error when the TGT is expired

Cleanups:
  * Various other nfs & nfsd localio cleanups
  * Prepratory patches for async copy improvements that are under development
  * Make OFFLOAD_CANCEL, LAYOUTSTATS, and LAYOUTERR moveable to other xprts
  * Add netns inum and srcaddr to debugfs rpc_xprt info


Stephen Rothwell did warn about a conflict that he resolved with the
following diff:

diff --cc fs/nfsd/filecache.c
index 2adf95e2b379,dc5c9d8e8202..000000000000
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@@ -1255,8 -1247,8 +1255,8 @@@ nfsd_file_acquire_local(struct net *net
  	__be32 beres;
  
  	beres = nfsd_file_do_acquire(NULL, net, cred, client,
 -				     fhp, may_flags, NULL, pnf, true);
 +				     fhp, may_flags, NULL, pnf, false);
- 	revert_creds(save_cred);
+ 	put_cred(revert_creds(save_cred));
  	return beres;
  }


Thanks,
Anna

----------------------------------------------------------------
Chuck Lever (3):
      NFS: CB_OFFLOAD can return NFS4ERR_DELAY
      NFS: Fix typo in OFFLOAD_CANCEL comment
      NFS: Rename struct nfs4_offloadcancel_data

Dai Ngo (3):
      SUNRPC: only put task on cl_tasks list after the RPC call slot is reserved.
      SUNRPC: display total RPC tasks for RPC client
      SUNRPC: do not retry on EKEYEXPIRED when user TGT ticket expired

Dragan Simic (1):
      nfs: Make NFS_FSCACHE select NETFS_SUPPORT instead of depending on it

Jeff Layton (1):
      sunrpc: add netns inum and srcaddr to debugfs rpc_xprt info

Mike Snitzer (16):
      nfs/localio: add direct IO enablement with sync and async IO support
      nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
      nfs_common: rename functions that invalidate LOCALIO nfs_clients
      nfs_common: move localio_lock to new lock member of nfs_uuid_t
      nfs: cache all open LOCALIO nfsd_file(s) in client
      nfsd: update percpu_ref to manage references on nfsd_net
      nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
      nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
      nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
      nfs_common: track all open nfsd_files per LOCALIO nfs_client
      nfs_common: add nfs_localio trace events
      nfs/localio: remove redundant code and simplify LOCALIO enablement
      nfs: probe for LOCALIO when v4 client reconnects to server
      nfs: probe for LOCALIO when v3 client reconnects to server
      nfs: fix incorrect error handling in LOCALIO
      pnfs/flexfiles: retry getting layout segment for reads

Olga Kornievskaia (3):
      NFSv4.2: fix COPY_NOTIFY xdr buf size calculation
      NFSv4.2: mark OFFLOAD_CANCEL MOVEABLE
      NFSv4.2: make LAYOUTSTATS and LAYOUTERROR MOVEABLE

Zichen Xie (1):
      NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()

 Documentation/filesystems/nfs/localio.rst | 100 ++++++------
 fs/nfs/Kconfig                            |   3 +-
 fs/nfs/callback_proc.c                    |   2 +-
 fs/nfs/client.c                           |   6 +-
 fs/nfs/direct.c                           |   1 +
 fs/nfs/flexfilelayout/flexfilelayout.c    |  52 ++++---
 fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
 fs/nfs/inode.c                            |   3 +
 fs/nfs/internal.h                         |   9 +-
 fs/nfs/localio.c                          | 236 +++++++++++++++++++++-------
 fs/nfs/nfs3proc.c                         |  46 +++++-
 fs/nfs/nfs42proc.c                        |  24 +--
 fs/nfs/nfs42xdr.c                         |   4 +-
 fs/nfs/nfs4state.c                        |   1 +
 fs/nfs/nfstrace.h                         |  32 ----
 fs/nfs/pagelist.c                         |   5 +-
 fs/nfs/sysfs.c                            |   6 +-
 fs/nfs/write.c                            |   3 +-
 fs/nfs_common/Makefile                    |   3 +-
 fs/nfs_common/common.c                    |  89 +++++++++--
 fs/nfs_common/localio_trace.c             |  10 ++
 fs/nfs_common/localio_trace.h             |  56 +++++++
 fs/nfs_common/nfslocalio.c                | 250 ++++++++++++++++++++++++------
 fs/nfsd/filecache.c                       |  20 ++-
 fs/nfsd/localio.c                         |   9 +-
 fs/nfsd/netns.h                           |  12 +-
 fs/nfsd/nfsctl.c                          |   6 +-
 fs/nfsd/nfssvc.c                          |  40 ++---
 include/linux/nfs_common.h                |   3 +-
 include/linux/nfs_fs.h                    |  22 ++-
 include/linux/nfs_fs_sb.h                 |   3 +-
 include/linux/nfs_xdr.h                   |   1 +
 include/linux/nfslocalio.h                |  48 ++++--
 include/linux/sunrpc/clnt.h               |   1 +
 net/sunrpc/clnt.c                         |  29 ++--
 net/sunrpc/debugfs.c                      |  15 ++
 36 files changed, 836 insertions(+), 315 deletions(-)
 create mode 100644 fs/nfs_common/localio_trace.c
 create mode 100644 fs/nfs_common/localio_trace.h

