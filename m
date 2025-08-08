Return-Path: <linux-nfs+bounces-13510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF0B1EA00
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC9B17428D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACA827C162;
	Fri,  8 Aug 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKTIQEnY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333402797A0;
	Fri,  8 Aug 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662214; cv=none; b=jAxWF2rlBmEHn4KDKFXdiT1L6NNJ3IKz1+qCXYjWyBpRzy8+aN/7ZAsXaMuGKHeDDHL0Z9AxlOp6pqk6fjf6CkNGTaAPAY5unD/M2uPfo0FyAa/OV7J/6QpAfxRXQGlLxs7ALxOdMYjPFm4/pO/ptWXO9HqWGfBDoy3lUdKCk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662214; c=relaxed/simple;
	bh=8yzHiN5GkemlqbNf2hNv9tTHWiTJLyiaNcXAotGDCuk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WdIlpC+bhpNTuBOhosZm62WPjhq8zPnT4ywBRFnkv74VTjXFSwVAJ8aKKuJFlwdiTKQ24Fn7sOFTlnBJZmW3gh9smceuzgjYr5Z0I3KXHDKegcpJOK+9C1QvWlwXtvI+cuMiI1C0T4vwPb87C3gt/fmbtNNQpF6WRVkSYZYwW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKTIQEnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB7FC4CEED;
	Fri,  8 Aug 2025 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754662214;
	bh=8yzHiN5GkemlqbNf2hNv9tTHWiTJLyiaNcXAotGDCuk=;
	h=Subject:From:To:Cc:Date:From;
	b=tKTIQEnYDWlfBWO6eeDUu99dtxTnYixVxt3SGKWGnZai6NJXtinv+gQRaDvz2S6AC
	 t2dLMqvJb9drgosY04Mr29Mc1e9Y1Yo+X0EX5NLJtsSTK6UxGmLSSYLzI4Lf8arDWz
	 3+42Hfum1rQhw8b3ODZTrpzXYH7s4Qvw1NVap1HWVzgT4ej1PoS+ISH6y0FYQOS9c3
	 pUXhWS5gNvD4lzVo8eN6le/dC6UF6yL45jvBbPSaueWAFmO3nyI6emOI2TKC84TAtk
	 x5Rtqr40+U9x3GJFGejWT+0t0rkpiG60S92kN/7JHkvgzloUO8aiHpBdUJtPN5pOru
	 EOb8NH0EuPLsQ==
Message-ID: <f94837ec978d8ca505006f024b3cae3c920e5f58.camel@kernel.org>
Subject: [GIT PULL] Please pull NFS client changes for Linux 6.17
From: Trond Myklebust <trondmy@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 07:10:12 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Linus,

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911=
:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.17-=
1

for you to fetch changes up to 4ec752ce6debd5a0e7e0febf6bcf780ccda6ab5e:

  NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file (202=
5-08-05 16:45:40 -0700)

----------------------------------------------------------------
NFS client updates for Linux 6.17

Highlights include:

Stable fixes:
- NFS don't inherit NFS filesystem capabilities when crossing from one
  filesystem to another.

Bugfixes:
- NFS wakeup of __nfs_lookup_revalidate() needs memory barriers.
- NFS improve bounds checking in nfs_fh_to_dentry().
- NFS Fix allocation errors when writing to a NFS file backed loopback
  device.
- NFSv4: More listxattr fixes
- SUNRPC: fix client handling of TLS alerts.
- pNFS block/scsi layout fix for an uninitialised pointer dereference.
- pNFS block/scsi layout fixes for the extent encoding, stripe mapping,
  and disk offset overflows.
- pNFS layoutcommit work around for RPC size limitations.
- pNFS/flexfiles avoid looping when handling fatal errors after layoutget.
- localio: fix various race conditions.

Features and cleanups:
- Add NFSv4 support for retrieving the btime.
- NFS: Allow folio migration for the case of mode =3D=3D MIGRATE_SYNC.
- NFS: Support using a kernel keyring to store TLS certificates.
- NFSv4: Speed up delegation lookup using a hash table.
- Assorted cleanups to remove unused variables and struct fields.
- Assorted new tracepoints to improve debugging.

----------------------------------------------------------------
Anne Marie Merritt (1):
      nfs: Add timecreate to nfs inode

Anthony Iliopoulos (3):
      NFS: remove unused wpages field from struct nfs_server
      NFS: remove unused time_delta field from struct nfs_server
      NFS: remove unused pnfs_ld_data field from struct nfs_server

Benjamin Coddington (1):
      NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY

Christoph Hellwig (9):
      NFS: support the kernel keyring for TLS
      nfs: create a kernel keyring
      NFS: pass struct nfs_client_initdata to nfs4_set_client
      NFS: drop __exit from nfs_exit_keyring
      NFS: cleanup error handling in nfs4_server_common_setup
      NFS: cleanup nfs_inode_reclaim_delegation
      NFS: move the delegation_watermark module parameter
      NFS: track active delegations per-server
      NFS: use a hash table for delegation lookup

Dr. David Alan Gilbert (2):
      SUNRPC: Remove unused xdr functions
      NFS: Remove unused function nfs_umount

Jeff Layton (4):
      nfs: add cache_validity to the nfs_inode_event tracepoints
      nfs: add a tracepoint to nfs_inode_detach_delegation_locked
      nfs: new tracepoint in nfs_delegation_need_return
      nfs: new tracepoint in match_stateid operation

Li RongQing (1):
      nfs/localio: use read_seqbegin() rather than read_seqbegin_or_lock()

NeilBrown (1):
      nfs: use lock_two_nondirectories()

Olga Kornievskaia (2):
      NFSv4.2: another fix for listxattr
      sunrpc: fix client side handling of tls alerts

Sergey Bashirov (6):
      pNFS: Fix uninited ptr deref in block/scsi layout
      pNFS: Fix extent encoding in block/scsi layout
      pNFS: Add prepare commit trace to block/scsi layout
      pNFS: Handle RPC size limit for layoutcommits
      pNFS: Fix stripe mapping in block/scsi layout
      pNFS: Fix disk addr range check in block/scsi layout

Tigran Mkrtchyan (2):
      pnfs: add pnfs_ds_connect trace point
      pNFS/flexfiles: don't attempt pnfs on fatal DS errors

Trond Myklebust (12):
      Expand the type of nfs_fattr->valid
      NFS: Return the file btime in the statx results when appropriate
      NFS: Allow folio migration for the case of mode =3D=3D MIGRATE_SYNC
      NFS: Fix wakeup of __nfs_lookup_revalidate() in unblock_revalidate()
      NFS: Clean up pnfs_put_layout_hdr()/pnfs_destroy_layout_final()
      SUNRPC: Silence warnings about parameters not being described
      NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()
      NFS: Fix the setting of capabilities when automounting a new filesyst=
em
      NFSv4: Remove duplicate lookups, capability probes and fsinfo calls
      NFS/localio: nfs_close_local_fh() fix check for file closed
      NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
      NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file

 fs/nfs/blocklayout/blocklayout.c          |   4 +-
 fs/nfs/blocklayout/dev.c                  |   5 +-
 fs/nfs/blocklayout/extent_tree.c          | 104 ++++++++++++++---
 fs/nfs/client.c                           |  47 +++++++-
 fs/nfs/delegation.c                       | 114 +++++++++++-------
 fs/nfs/delegation.h                       |   3 +
 fs/nfs/dir.c                              |   4 +-
 fs/nfs/export.c                           |  11 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |  26 +++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +-
 fs/nfs/fs_context.c                       |  42 +++++++
 fs/nfs/inode.c                            |  69 ++++++++++-
 fs/nfs/internal.h                         |  12 +-
 fs/nfs/localio.c                          |   7 +-
 fs/nfs/mount_clnt.c                       |  68 -----------
 fs/nfs/nfs4_fs.h                          |   5 +-
 fs/nfs/nfs4client.c                       | 185 +++++++++++++-------------=
----
 fs/nfs/nfs4file.c                         |  25 +---
 fs/nfs/nfs4getroot.c                      |  14 +--
 fs/nfs/nfs4proc.c                         | 139 +++++++++++++---------
 fs/nfs/nfs4trace.c                        |   2 +
 fs/nfs/nfs4trace.h                        | 168 ++++++++++++++++++++++++++=
-
 fs/nfs/nfs4xdr.c                          |  24 ++++
 fs/nfs/nfstrace.h                         |  11 +-
 fs/nfs/pnfs.c                             |  39 +++----
 fs/nfs/pnfs_nfs.c                         |  14 ++-
 fs/nfs/write.c                            |   8 +-
 fs/nfs_common/nfslocalio.c                |  28 +++--
 include/linux/nfs_fs.h                    |   8 ++
 include/linux/nfs_fs_sb.h                 |   8 +-
 include/linux/nfs_xdr.h                   |  57 ++++-----
 include/linux/sunrpc/xdr.h                |   9 --
 net/sunrpc/auth_gss/gss_krb5_crypto.c     |   4 +-
 net/sunrpc/xdr.c                          | 110 ------------------
 net/sunrpc/xprtsock.c                     |  40 +++++--
 35 files changed, 858 insertions(+), 562 deletions(-)

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

