Return-Path: <linux-nfs+bounces-17035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7D5CB6278
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 15:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8716E3051613
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E42C15A8;
	Thu, 11 Dec 2025 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZtr57Ny"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DD280325;
	Thu, 11 Dec 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462065; cv=none; b=ZwiNNGlUhAz5JQ+kRg8H7lvTMmBm/OudXW+AA1Vrti0NBgvo+U2c7HJY1XqKIRauHHyCH7ULAt6OXPJu/dkSFBxHxPccja/bF0VnJ7rUmtuZDX8GtwZmJAK/Jk2MvTv/iXDu/S/GjldIaNAT80EdLRM3siN28gZ13XaH1q2iWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462065; c=relaxed/simple;
	bh=uaiJOHOoZxSvKqlzkySuM51W37wHEGtMYLbx9MQkD8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=B6fzxzO2GArZt3khO3X/T+ZAJl3dmHJYk/9OFcUn1gkxd8ypXMZwmExWVHl05mFiuoeYVxcJN3AoEvg+gm9Yiv92cRwtoFHun6i1g8/jo2D9o7/WfEzUm28Yu+UOcQ8VNLQqU5iUzprmKC/ADwSnaX7hwJi+QStRsgV/Sx71bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZtr57Ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F246C4CEF7;
	Thu, 11 Dec 2025 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462064;
	bh=uaiJOHOoZxSvKqlzkySuM51W37wHEGtMYLbx9MQkD8Y=;
	h=Subject:From:To:Cc:Date:From;
	b=nZtr57Nyy9J7p5EwG9m+7YAq1vasm48F1TCUekhzBmZrYoR2CkC2ZG9hSW5SlGyv/
	 a7MIjNjYs1dl0MUPhMR7VdCR40n48nve0WF3ay4furFGdOYu985z4Rv0xeKTNAeOsg
	 l3Bd2h5DJ7DEMfGyHEiQUx5eYozJh2DyWp+cwClykCBV+jWel5UHa28Fy1j38ymSCd
	 xYb+V44pY0dHJZKlNJyOvAjp3SwtUfTsvQNqypBr6sOAhn+QvWqqom6kFR7aFORM9f
	 me7XEG+dKCwrg4k+UZrXfi+UJPM3ynX4RqMQ+gUBDRfqJ+sxJiReAQHT6eb9fGh1R6
	 69a9veRPra8FA==
Message-ID: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
Subject: [GIT PULL] Please pull NFS client updates for Linux 6.19
From: Trond Myklebust <trondmy@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 11 Dec 2025 09:07:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Linus,

The following changes since commit 6a23ae0a96a600d1d12557add110e0bb6e32730c=
:

  Linux 6.18-rc6 (2025-11-16 14:25:38 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.19-=
1

for you to fetch changes up to bd3b04b46c7a9940989ff4b29376e899e93d3a4a:

  NFSv4: Handle NFS4ERR_NOTSUPP errors for directory delegations (2025-12-0=
5 19:34:29 -0500)

Cheers
  Trond

----------------------------------------------------------------
NFS client updates for Linux 6.19

Highlights include:

Bugfixes:
- Fix 'nlink' attribute update races when unlinking a file.
- Add missing initialisers for the directory verifier in various places.
- Don't regress the NFSv4 open state due to misordered racing replies.
- Ensure the NFSv4.x callback server uses the correct transport
  connection.
- Fix potential use-after-free races when shutting down the NFSv4.x
  callback server.
- Fix a pNFS layout commit crash.
- Assorted fixes to ensure correct propagation of mount options when the
  client crosses a filesystem boundary and triggers the VFS automount
  code.
- More localio fixes.

Features and cleanups:
- Add initial support for basic directory delegations.
- SunRPC back channel code cleanups.

----------------------------------------------------------------
Anna Schumaker (5):
      NFS: Add support for sending GDD_GETATTR
      NFS: Request a directory delegation on ACCESS, CREATE, and UNLINK
      NFS: Request a directory delegation during RENAME
      NFS: Shortcut lookup revalidations if we have a directory delegation
      NFS: Add a module option to disable directory delegations

Jonathan Curley (1):
      NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_layout_stateid_in=
valid

Mike Snitzer (2):
      nfs/localio: remove alignment size checking in nfs_is_local_dio_possi=
ble
      nfs/localio: remove 61 byte hole from needless ____cacheline_aligned

Olga Kornievskaia (4):
      NFSv4.1: pass transport for callback shutdown
      SUNRPC: cleanup common code in backchannel request
      SUNRPC: new helper function for stopping backchannel server
      NFSv4.1: protect destroying and nullifying bc_serv structure

Scott Mayhew (1):
      NFSv4: ensure the open stateid seqid doesn't go backwards

Trond Myklebust (11):
      NFS: Avoid changing nlink when file removes and attribute updates rac=
e
      NFS: Initialise verifiers for visible dentries in readdir and lookup
      NFS: Initialise verifiers for visible dentries in nfs_atomic_open()
      NFS: Initialise verifiers for visible dentries in _nfs4_open_and_get_=
state
      Revert "nfs: ignore SB_RDONLY when remounting nfs"
      Revert "nfs: clear SB_RDONLY before getting superblock"
      Revert "nfs: ignore SB_RDONLY when mounting nfs"
      NFS: Automounted filesystems should inherit ro,noexec,nodev,sync flag=
s
      NFS: Fix inheritance of the block sizes when automounting
      NFS: Fix up the automount fs_context to use the correct cred
      NFSv4: Handle NFS4ERR_NOTSUPP errors for directory delegations

 fs/nfs/callback.c                 |   4 +-
 fs/nfs/callback.h                 |   3 +-
 fs/nfs/client.c                   |  21 ++++++--
 fs/nfs/delegation.c               |   8 +++
 fs/nfs/delegation.h               |  13 +++++
 fs/nfs/dir.c                      |  46 ++++++++++++----
 fs/nfs/inode.c                    |   3 ++
 fs/nfs/internal.h                 |   3 +-
 fs/nfs/localio.c                  |   4 +-
 fs/nfs/namespace.c                |  16 +++++-
 fs/nfs/nfs3proc.c                 |   3 +-
 fs/nfs/nfs4client.c               |  27 +++++++---
 fs/nfs/nfs4proc.c                 | 111 +++++++++++++++++++++++++++++++---=
----
 fs/nfs/nfs4trace.h                |   1 +
 fs/nfs/nfs4xdr.c                  | 106 ++++++++++++++++++++++++++++++++++=
++
 fs/nfs/pnfs.c                     |   1 +
 fs/nfs/proc.c                     |   3 +-
 fs/nfs/super.c                    |  33 ++----------
 fs/nfs/unlink.c                   |   3 +-
 include/linux/nfs_fs.h            |   1 +
 include/linux/nfs_fs_sb.h         |   6 +++
 include/linux/nfs_xdr.h           |  10 +++-
 include/linux/sunrpc/bc_xprt.h    |   7 +++
 net/sunrpc/backchannel_rqst.c     |  35 ++++++++++--
 net/sunrpc/xprtrdma/backchannel.c |   8 +--
 25 files changed, 385 insertions(+), 91 deletions(-)


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

