Return-Path: <linux-nfs+bounces-1024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861F82A380
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 22:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177EAB20CE8
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCC74F882;
	Wed, 10 Jan 2024 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNzpJwxU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A14F881
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jan 2024 21:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC13C433C7;
	Wed, 10 Jan 2024 21:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704922996;
	bh=rDd061DPIFPYEe4AFlY72gB7nrv3uDmTO00l9aSgiOU=;
	h=From:To:Cc:Subject:Date:From;
	b=BNzpJwxUnGy4Knqy/ka0V5dY8MNHjwGvyL27X1IF+hFG7vRK/IVQ2m3aWOlmYeYfQ
	 Fawo5/0KuXxznfGR+C6lNb634tK2DqhhhGAE6lbTy8ErIXghYZacWRlIWqFvszpDcB
	 lu17dbVlV24HctnK1W7BMl3DPeXV1LFZZO7m4FjL+p8Yt74P+25EmTGhyy37YaoF5W
	 BgcNyibxmKqSB+Ub0HqIHxoi+2jU06ASlfKwf1nUeryJcb85mK/OhG0l88f97Q8xZ3
	 l2sMc9d/S7YxHMpHmVP6YB/aXHj7RLCpo3+1coL7Qt16n6vcogJTVD3GoSdIfUBh+k
	 EmolmGcClQbDw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 6.8
Date: Wed, 10 Jan 2024 16:43:14 -0500
Message-ID: <20240110214314.36822-1-anna@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 610a9b8f49fbcf1100716370d3b5f6f884a2835a:

  Linux 6.7-rc8 (2023-12-31 12:51:25 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.8-1

for you to fetch changes up to 57331a59ac0d680f606403eb24edd3c35aecba31:

  NFSv4.1: Use the nfs_client's rpc timeouts for backchannel (2024-01-04 17:01:01 -0500)

----------------------------------------------------------------
NFS Client Updates for Linux 6.8

New Features:
  * Always ask for type with READDIR
  * Remove nfs_writepage()

Bugfixes:
  * Fix a suspicious RCU usage warning
  * Fix a blocklayoutdriver reference leak
  * Fix the block driver's calculation of layoutget size
  * Fix handling NFS4ERR_RETURNCONFLICT
  * Fix _xprt_switch_find_current_entry()
  * Fix v4.1 backchannel request timeouts
  * Don't add zero-length pnfs block devices
  * Use the parent cred in nfs_access_login_time()

Cleanups:
  * A few improvements when dealing with referring calls from the server
  * Clean up various unused variables, struct fields, and function calls
  * Various tracepoint improvements

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (4):
      SUNRPC: Clean up unused variable in rpc_xprt_probe_trunked()
      SUNRPC: Remove unused function rpc_clnt_xprt_switch_put()
      SUNRPC: Create a helper function for accessing the rpc_clnt's xprt_switch
      SUNRPC: Fix a suspicious RCU usage warning

Benjamin Coddington (6):
      blocklayoutdriver: Fix reference leak of pnfs_device_node
      pnfs/blocklayout: Don't add zero-length pnfs_block_dev
      NFSv4: Always ask for type with READDIR
      NFS: drop unused nfs_direct_req bytes_left
      SUNRPC: Fixup v4.1 backchannel request timeouts
      NFSv4.1: Use the nfs_client's rpc timeouts for backchannel

Jeff Layton (3):
      nfs: add new tracepoint at nfs4 revalidate entry point
      nfs: rename the nfs_async_rename_done tracepoint
      nfs: print fileid in lookup tracepoints

Markus Elfring (1):
      rpc_pipefs: Replace one label in bl_resolve_deviceid()

Matthew Wilcox (Oracle) (1):
      nfs: Remove writepage

Olga Kornievskaia (1):
      SUNRPC: fix _xprt_switch_find_current_entry logic

Scott Mayhew (1):
      NFS: Use parent's objective cred in nfs_access_login_time()

Trond Myklebust (4):
      NFSv4: Track the number of referring calls in struct cb_process_state
      NFSv4.1: if referring calls are complete, trust the stateid argument
      NFSv4.1/pnfs: Ensure we handle the error NFS4ERR_RETURNCONFLICT
      pNFS: Fix the pnfs block driver's calculation of layoutget size

 fs/nfs/blocklayout/blocklayout.c |  7 ++---
 fs/nfs/blocklayout/dev.c         |  3 +++
 fs/nfs/blocklayout/rpc_pipefs.c  |  2 +-
 fs/nfs/callback.h                |  5 ++--
 fs/nfs/callback_proc.c           | 55 +++++++++++++++++++++++-----------------
 fs/nfs/callback_xdr.c            |  5 ++++
 fs/nfs/dir.c                     |  4 ++-
 fs/nfs/direct.c                  | 11 ++++----
 fs/nfs/file.c                    |  1 -
 fs/nfs/internal.h                |  3 +--
 fs/nfs/nfs4proc.c                |  3 +++
 fs/nfs/nfs4xdr.c                 | 23 ++++++++++++-----
 fs/nfs/nfstrace.h                | 22 +++++++++-------
 fs/nfs/pnfs.c                    |  3 ++-
 fs/nfs/unlink.c                  |  2 +-
 fs/nfs/write.c                   | 11 --------
 include/linux/nfs_fs.h           |  1 -
 include/linux/sunrpc/bc_xprt.h   |  3 ++-
 include/linux/sunrpc/clnt.h      |  1 -
 include/linux/sunrpc/sched.h     | 14 +++++++++-
 include/linux/sunrpc/svc.h       |  2 ++
 include/linux/sunrpc/xprt.h      | 11 --------
 net/sunrpc/clnt.c                | 51 ++++++++++++++++++-------------------
 net/sunrpc/svc.c                 | 11 +++++++-
 net/sunrpc/xprt.c                | 31 ++++++++++++++--------
 net/sunrpc/xprtmultipath.c       | 19 +++++++++++---
 26 files changed, 181 insertions(+), 123 deletions(-)

