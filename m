Return-Path: <linux-nfs+bounces-10942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328FA74BA4
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 14:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310E53A42EF
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 13:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBA176AA1;
	Fri, 28 Mar 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTo2ZmNc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6E192D70;
	Fri, 28 Mar 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169134; cv=none; b=FxNYh3yHB72Y1vI3UPg6Z9N3cwY+4sjWFpGWwuQzxNz0VLU9pd2Gu4AzMW98hg02yQCSqtHnp5M+19VvLQF+d0yl79FeFAY92B7EY/x0dC64eSy6iqI6UMkqhBry1XmwxD5tAx5LHaREcw8o/hojyoUE8VmnaLkH5xO+D84CiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169134; c=relaxed/simple;
	bh=Ot8PlJs5zMx+ImUyzZSzvhXJUZFiZ3hUICBotN2aZQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ckas5tLUuQx12h/+axYwEGqseZQfQ1aIBE/zCRfkELdDMK1ArPSHcjErbT8lomMhm7of9eoek1RgbmrpsedrZyjTb2oli9gEL5B9jaGNhztorgRuaPq61tjJ5cQlcSGKjS6mg+QknSZcr7MX2t3TfRev0+Ns+kyMGEXl8RBvHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTo2ZmNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A9C4CEE4;
	Fri, 28 Mar 2025 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743169134;
	bh=Ot8PlJs5zMx+ImUyzZSzvhXJUZFiZ3hUICBotN2aZQI=;
	h=From:To:Cc:Subject:Date:From;
	b=jTo2ZmNc/UtSpYTx4jZr5EUcwmJDd/UVk9cmKonW6L34LSQUoG/keyMbrNOd5CPQv
	 UP+UALKK2qTBtmjqOQNezFsmglfMAlicgXJvfZU9l14tTcrc/FUmd3pJb09j5PaJNJ
	 dq8NH5eUO3hnghAj62kdSEGO/6c28W1xfLOA1Vju1j4uHjC/HqdKpEl0wpLRAgjRpR
	 Gc5VpytxDj0qEEHjEO/M+ok1FlUe5nZifGCLkamskYspSLX4Lh+7xDmC+mBM/lsTiJ
	 V0g7IFVy4/JrmhZnexcpN+aokk0jO4llsXV9jX4ofNBoJKTnSAPLskx70TTpNJdRSa
	 yTDRMBg4UF1eg==
From: cel@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for v6.15
Date: Fri, 28 Mar 2025 09:38:52 -0400
Message-ID: <20250328133852.2344-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15

for you to fetch changes up to 26a80762153ba0dc98258b5e6d2e9741178c5114:

  NFSD: Add a Kconfig setting to enable delegated timestamps (2025-03-14 10:49:47 -0400)

----------------------------------------------------------------
NFSD 6.15 Release Notes

Neil Brown contributed more scalability improvements to NFSD's
open file cache, and Jeff Layton contributed a menagerie of
repairs to NFSD's NFSv4 callback / backchannel implementation.

Mike Snitzer contributed a change to NFS re-export support that
disables support for file locking on a re-exported NFSv4 mount.
This is because NFSv4 state recovery is currently difficult if
not impossible for re-exported NFS mounts. The change aims to
prevent data integrity exposures after the re-export server
crashes.

Work continues on the evolving NFSD netlink administrative API.

Many thanks to the contributors, reviewers, testers, and bug
reporters who participated during the v6.15 development cycle.

----------------------------------------------------------------
Chuck Lever (9):
      NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up
      NFSD: nfsd_unlink() clobbers non-zero status returned from fh_fill_pre_attrs()
      NFSD: Never return NFS4ERR_FILE_OPEN when removing a directory
      NFSD: Return NFS4ERR_FILE_OPEN only when renaming over an open file
      NFSD: Return NFS4ERR_FILE_OPEN only when linking an open file
      NFSD: Fix trace_nfsd_slot_seqid_sequence
      NFSD: Fix callback decoder status codes
      NFSD: Re-organize nfsd_file_gc_worker()
      NFSD: Add a Kconfig setting to enable delegated timestamps

Dr. David Alan Gilbert (2):
      SUNRPC: Remove unused krb5_decrypt
      SUNRPC: Remove unused make_checksum

Gustavo A. R. Silva (1):
      fs: nfs: acl: Avoid -Wflex-array-member-not-at-end warning

Jeff Layton (19):
      lockd: add netlink control interface
      nfsd: don't ignore the return code of svc_proc_register()
      nfsd: allow SC_STATUS_FREEABLE when searching via nfs4_lookup_stateid()
      nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
      nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
      nfsd: always release slot when requeueing callback
      nfsd: only check RPC_SIGNALLED() when restarting rpc_task
      nfsd: when CB_SEQUENCE gets ESERVERFAULT don't increment seq_nr
      nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
      nfsd: eliminate special handling of NFS4ERR_SEQ_MISORDERED
      nfsd: prevent callback tasks running concurrently
      nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY
      nfsd: replace CB_GETATTR_BUSY with NFSD4_CALLBACK_RUNNING
      nfsd: move cb_need_restart flag into cb_flags
      nfsd: handle errors from rpc_call_async()
      nfsd: reorganize struct nfs4_delegation for better packing
      nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
      nfsd: remove obsolete comment from nfs4_alloc_stid
      nfsd: use a long for the count in nfsd4_state_shrinker_count()

Li Lingfeng (3):
      sunrpc: clean cache_detail immediately when flush is written frequently
      nfsd: remove the redundant mapping of nfserr_mlink
      nfsd: put dl_stid if fail to queue dl_recall

Mike Snitzer (1):
      nfsd: disallow file locking and delegations for NFSv4 reexport

NeilBrown (6):
      nfsd: filecache: remove race handling.
      nfsd: filecache: use nfsd_file_dispose_list() in nfsd_file_close_inode_sync()
      nfsd: filecache: use list_lru_walk_node() in nfsd_file_gc()
      nfsd: filecache: introduce NFSD_FILE_RECENT
      nfsd: filecache: don't repeatedly add/remove files on the lru list
      nfsd: filecache: drop the list_lru lock during lock gc scans

Nicolas Bouchinet (1):
      sysctl: Fixes nsm_local_state bounds

Olga Kornievskaia (3):
      nfsd: fix management of listener transports
      nfsd: adjust WARN_ON_ONCE in revoke_delegation
      svcrdma: do not unregister device for listeners

 Documentation/filesystems/nfs/reexport.rst |  10 +-
 Documentation/netlink/specs/lockd.yaml     |  45 +++++++++
 fs/lockd/Makefile                          |   2 +-
 fs/lockd/netlink.c                         |  44 +++++++++
 fs/lockd/netlink.h                         |  19 ++++
 fs/lockd/netns.h                           |   3 +
 fs/lockd/svc.c                             | 123 ++++++++++++++++++++++--
 fs/nfs/export.c                            |   3 +-
 fs/nfs_common/nfsacl.c                     |   8 +-
 fs/nfsd/Kconfig                            |  12 ++-
 fs/nfsd/filecache.c                        | 122 +++++++++++++-----------
 fs/nfsd/filecache.h                        |   7 ++
 fs/nfsd/nfs4callback.c                     | 146 ++++++++++++++++-------------
 fs/nfsd/nfs4layouts.c                      |   7 +-
 fs/nfsd/nfs4proc.c                         |   2 +-
 fs/nfsd/nfs4state.c                        | 114 ++++++++++++++--------
 fs/nfsd/nfsctl.c                           |  53 ++++++-----
 fs/nfsd/state.h                            |  20 ++--
 fs/nfsd/stats.c                            |   4 +-
 fs/nfsd/stats.h                            |   2 +-
 fs/nfsd/trace.h                            |  24 ++++-
 fs/nfsd/vfs.c                              | 106 +++++++++++++++------
 include/linux/exportfs.h                   |  14 ++-
 include/linux/posix_acl.h                  |  11 ++-
 include/uapi/linux/lockd_netlink.h         |  29 ++++++
 net/sunrpc/auth_gss/gss_krb5_crypto.c      | 144 ----------------------------
 net/sunrpc/auth_gss/gss_krb5_internal.h    |   7 --
 net/sunrpc/cache.c                         |   6 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |   3 +-
 29 files changed, 685 insertions(+), 405 deletions(-)
 create mode 100644 Documentation/netlink/specs/lockd.yaml
 create mode 100644 fs/lockd/netlink.c
 create mode 100644 fs/lockd/netlink.h
 create mode 100644 include/uapi/linux/lockd_netlink.h

