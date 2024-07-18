Return-Path: <linux-nfs+bounces-4985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFCA9352DD
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AC51F210F7
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 21:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280727711F;
	Thu, 18 Jul 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL2a0v0z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FE1EA8F
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336974; cv=none; b=gMxyZ+Ve1W/ccEVNhSIuUnVLiA8WNZwpykMuutzEUhIDPQyXxAWeUvHjEX+SJeSxCJC5Py83zA1cIjW1Cf80p97LdSP4j4GlzduzejOKZkMfd1vl+FvClLFTySzi2rgWUjIweuR+ibyzwJamw/dANEi3pCg8vRnFUduwWd5irJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336974; c=relaxed/simple;
	bh=RiOQWaY0QMTO7hqzd3KtJssMpKii88e6jDGakqxOKA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkbfL79DzascmHMiyIGQMYJoek3gUq1sgrq4hrFjWEGl5TSnoyDiwG5F9OWv2HNNnqi7VRozRyGezilSGiXAyJJeKZg7j4WFGI/34Op5lTu+GlVzNIir9EEozpnXT4euHqweIKSAQBxx8Awu/6e2MTmrizKXEEmdZ+ONO5aDJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL2a0v0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BEAC116B1;
	Thu, 18 Jul 2024 21:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721336973;
	bh=RiOQWaY0QMTO7hqzd3KtJssMpKii88e6jDGakqxOKA0=;
	h=From:To:Cc:Subject:Date:From;
	b=hL2a0v0z8/QFVFWsNoIvAP5HeH+J7lhiLulwOud+DDRnaA28D0N00EG+UCTkDonBr
	 41tHyBR9d4n8McPwes4OxHjGR7S1kGzkvaVwzqKWUeHedcD6ji8mYeYP4+SyTJGPcg
	 /0WnMghWrX7QjCMLW16/MixOdVJrrCvGR6hgFqp4Jelg3AuSHn5LZoALfdgY/PT1Ul
	 EhdbQtPYHVH5j+8qjZ8NAM2lCagT7fkuQfMzNYTxctURtqEUl/xoABkGFmdmS8f0dw
	 v8WK3j+XEkL+VqAoHQo64belIl5TsXP2ob3I+bWmvsxj25nOjnDmahn9iPMCOGiPiK
	 PI6lpS0vPkcjw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 6.11
Date: Thu, 18 Jul 2024 17:09:32 -0400
Message-ID: <20240718210932.703615-1-anna@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.11-1

for you to fetch changes up to b9fae9f06d84ffab0f3f9118f3a96bbcdc528bf6:

  SUNRPC: Fixup gss_status tracepoint error output (2024-07-18 10:49:15 -0400)

----------------------------------------------------------------
NFS Client Updates for Linux 6.11

New Features:
  * Add support for large folios
  * Implement rpcrdma generic device removal notification
  * Add client support for attribute delegations
  * Use a LAYOUTRETURN during reboot recovery to report layoutstats and errors
  * Improve throughput for random buffered writes
  * Add NVMe support to pnfs/blocklayout

Bugfixes:
  * Fix rpcrdma_reqs_reset()
  * Avoid soft lockups when using UDP
  * Fix an nfs/blocklayout premature PR key unregestration
  * Another fix for EXCHGID4_FLAG_USE_PNFS_DS for DS server
  * Do not extend writes to the entire folio
  * Pass explicit offset and count values to tracepoints
  * Fix a race to wake up sleeping SUNRPC sync tasks
  * Fix gss_status tracepoint output

Cleanups:
  * Add missing MODULE_DESCRIPTION() macros
  * Add blocklayout / SCSI layout tracepoints
  * Remove asm-generic headers from xprtrdma verbs.c
  * Remove unused 'struct mnt_fhstatus'
  * Other delegation related cleanups
  * Other folio related cleanups
  * Other pNFS related cleanups
  * Other xprtrdma cleanups

Thanks,
Anna

----------------------------------------------------------------
Benjamin Coddington (2):
      SUNRPC: Fix a race to wake a sync task
      SUNRPC: Fixup gss_status tracepoint error output

Christoph Hellwig (14):
      nfs: add support for large folios
      nfs: remove dead code for the old swap over NFS implementation
      nfs: remove nfs_folio_private_request
      nfs: simplify nfs_folio_find_and_lock_request
      nfs: fold nfs_folio_find_and_lock_request into nfs_lock_and_join_requests
      nfs: fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests
      nfs: move nfs_wait_on_request to write.c
      nfs: don't reuse partially completed requests in nfs_lock_and_join_requests
      nfs: remove the unused max_deviceinfo_size field from struct pnfs_layoutdriver_type
      nfs: remove nfs_page_length
      nfs/blocklayout: add support for NVMe
      nfs: do not extend writes to the entire folio
      nfs: pass explicit offset/count to trace events
      nfs: split nfs_read_folio

Chuck Lever (8):
      xprtrdma: Fix rpcrdma_reqs_reset()
      rpcrdma: Implement generic device removal
      xprtrdma: Handle device removal outside of the CM event handler
      xprtrdma: Clean up synopsis of frwr_mr_unmap()
      xprtrdma: Remove temp allocation of rpcrdma_rep objects
      nfs/blocklayout: Fix premature PR key unregistration
      nfs/blocklayout: Report only when /no/ device is found
      nfs/blocklayout: SCSI layout trace points for reservation key reg/unreg

Dr. David Alan Gilbert (1):
      NFS: remove unused struct 'mnt_fhstatus'

Jan Kara (3):
      nfs: Drop pointless check from nfs_commit_release_pages()
      nfs: Properly initialize server->writeback
      nfs: Block on write congestion

Jeff Johnson (1):
      fs: nfs: add missing MODULE_DESCRIPTION() macros

Lance Shelton (1):
      Return the delegation when deleting sillyrenamed files

Matthew Wilcox (Oracle) (1):
      filemap: Convert generic_perform_write() to support large folios

NeilBrown (1):
      SUNRPC: avoid soft lockup when transmitting UDP to reachable server.

Olga Kornievskaia (1):
      NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS for DS server

Tanzir Hasan (1):
      xprtrdma: removed asm-generic headers from verbs.c

Trond Myklebust (29):
      NFSv4: Clean up open delegation return structure
      NFSv4: Refactor nfs4_opendata_check_deleg()
      NFSv4: Add new attribute delegation definitions
      NFSv4: Plumb in XDR support for the new delegation-only setattr op
      NFSv4: Add CB_GETATTR support for delegated attributes
      NFSv4: Add a flags argument to the 'have_delegation' callback
      NFSv4: Add support for delegated atime and mtime attributes
      NFSv4: Add recovery of attribute delegations
      NFSv4: Add a capability for delegated attributes
      NFSv4: Enable attribute delegations
      NFSv4: Delegreturn must set m/atime when they are delegated
      NFSv4: Fix up delegated attributes in nfs_setattr
      NFSv4: Don't request atime/mtime/size if they are delegated to us
      NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute
      NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
      NFSv4: Add support for OPEN4_RESULT_NO_OPEN_STATEID
      NFSv4: Ask for a delegation or an open stateid in OPEN
      NFSv4: Don't send delegation-related share access modes to CLOSE
      NFSv4/pnfs: Remove redundant list check
      NFSv4.1: constify the stateid argument in nfs41_test_stateid()
      NFSv4: Clean up encode_nfs4_stateid()
      pNFS: Add a flag argument to pnfs_destroy_layouts_byclid()
      NFSv4/pnfs: Add support for the PNFS_LAYOUT_FILE_BULK_RETURN flag
      NFSv4/pNFS: Add a helper to defer failed layoutreturn calls
      NFSv4/pNFS: Handle server reboots in pnfs_poc_release()
      NFSv4/pNFS: Retry the layout return later in case of a timeout or reboot
      NFSv4/pnfs: Give nfs4_proc_layoutreturn() a flags argument
      NFSv4/pNFS: Remove redundant call to unhash the layout
      NFSv4/pNFS: Do layout state recovery upon reboot

 fs/nfs/blocklayout/blocklayout.c       |  25 ++-
 fs/nfs/blocklayout/blocklayout.h       |   9 +-
 fs/nfs/blocklayout/dev.c               | 116 ++++++++---
 fs/nfs/callback.h                      |   5 +-
 fs/nfs/callback_proc.c                 |  19 +-
 fs/nfs/callback_xdr.c                  |  39 +++-
 fs/nfs/client.c                        |   3 +
 fs/nfs/delegation.c                    |  67 ++++--
 fs/nfs/delegation.h                    |  45 +++-
 fs/nfs/dir.c                           |   2 +-
 fs/nfs/file.c                          |  19 +-
 fs/nfs/filelayout/filelayout.c         |   1 -
 fs/nfs/flexfilelayout/flexfilelayout.c |   2 +-
 fs/nfs/fscache.c                       |   2 +-
 fs/nfs/inode.c                         |  88 +++++++-
 fs/nfs/internal.h                      |  25 +--
 fs/nfs/mount_clnt.c                    |   5 -
 fs/nfs/nfs2super.c                     |   1 +
 fs/nfs/nfs3proc.c                      |  10 +-
 fs/nfs/nfs3super.c                     |   1 +
 fs/nfs/nfs4_fs.h                       |   3 +-
 fs/nfs/nfs4client.c                    |   6 +-
 fs/nfs/nfs4proc.c                      | 301 +++++++++++++++++++--------
 fs/nfs/nfs4state.c                     |   4 +-
 fs/nfs/nfs4super.c                     |   1 +
 fs/nfs/nfs4trace.c                     |   7 +
 fs/nfs/nfs4trace.h                     |  88 ++++++++
 fs/nfs/nfs4xdr.c                       | 138 ++++++++++---
 fs/nfs/nfstrace.h                      |  36 ++--
 fs/nfs/pagelist.c                      | 117 +----------
 fs/nfs/pnfs.c                          | 223 +++++++++++++++-----
 fs/nfs/pnfs.h                          |  53 +++--
 fs/nfs/pnfs_dev.c                      |   3 -
 fs/nfs/pnfs_nfs.c                      |  47 -----
 fs/nfs/proc.c                          |  10 +-
 fs/nfs/read.c                          |  80 +++++---
 fs/nfs/unlink.c                        |   2 +
 fs/nfs/write.c                         | 364 ++++++++++++++++-----------------
 fs/nfs_common/grace.c                  |   1 +
 fs/nfs_common/nfsacl.c                 |   1 +
 include/linux/nfs4.h                   |  11 +
 include/linux/nfs_fs_sb.h              |   4 +
 include/linux/nfs_page.h               |   7 +-
 include/linux/nfs_xdr.h                |  47 ++++-
 include/linux/sunrpc/rdma_rn.h         |  27 +++
 include/trace/events/rpcgss.h          |   2 +-
 include/trace/events/rpcrdma.h         |  57 ++++++
 include/uapi/linux/nfs4.h              |   4 +
 mm/filemap.c                           |  40 ++--
 net/sunrpc/clnt.c                      |   3 +-
 net/sunrpc/sched.c                     |   4 +-
 net/sunrpc/xprtrdma/Makefile           |   2 +-
 net/sunrpc/xprtrdma/frwr_ops.c         |   9 +-
 net/sunrpc/xprtrdma/ib_client.c        | 181 ++++++++++++++++
 net/sunrpc/xprtrdma/module.c           |  18 +-
 net/sunrpc/xprtrdma/rpc_rdma.c         |   3 +-
 net/sunrpc/xprtrdma/verbs.c            | 100 +++++----
 net/sunrpc/xprtrdma/xprt_rdma.h        |   5 +-
 58 files changed, 1682 insertions(+), 811 deletions(-)
 create mode 100644 include/linux/sunrpc/rdma_rn.h
 create mode 100644 net/sunrpc/xprtrdma/ib_client.c

