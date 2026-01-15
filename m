Return-Path: <linux-nfs+bounces-17961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABBD283E4
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 20:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29AAB30DDB06
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB1320382;
	Thu, 15 Jan 2026 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLOi3XM8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04031ED87;
	Thu, 15 Jan 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506386; cv=none; b=RMVDfV2dasz0VRDsuD4eFjIn8aDLiGqS1875e3bjpB6aetGhkGioMGRjRI1hMFrERl3gvhnTmmwk5N6JGVNHZJW/LZF0/pCk6ggczt36Z5qlEVB7DgJjxuL1kfB86peAUH4KxHQjUtdORIESovh2k6QZeCZ/Ra0CSv3V1wufuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506386; c=relaxed/simple;
	bh=cK4vFUxoVwcjgbSKWBi/nwdDjFFo9Kk4UWCm+A9EVBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=G24UY1oL2m0/yxwYVuK5VCD4/gLr61okZjFW/b16IDZhK6YTqyHnl5GIpw8jpZpBOT/1++Tj1juIHdpArFwFxSrTYfsyKvRsRKKeWz1J4RVlZglikGUv14kmeuOmysRNiy7my++NVW7N9eVVdS6yPYAQwAykqrAt4HHy4Ufkx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLOi3XM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB852C16AAE;
	Thu, 15 Jan 2026 19:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768506386;
	bh=cK4vFUxoVwcjgbSKWBi/nwdDjFFo9Kk4UWCm+A9EVBQ=;
	h=Subject:From:To:Cc:Date:From;
	b=PLOi3XM89uabaWiIX4J6yyP1qY9rbWXhhzsXuAwPPhyOG+HGFgCbJ19104vX6gtsi
	 mSASwXySlcIZnaSOx8T9S/q092Zv3U6GGXeuIBvqxMn86HyPz/5t55rAGW61NFUdKb
	 83Oouzxc0JX9DNwPkTMk2G1Cbln9JEfXd0LrT8aF/JflA+4/e62wvnn4HWj9OsBf4w
	 B1ykdNwA7plTy3panwLh2gBTSVGDq+VasHKyfU0SvvrC/OTYcoedR22PxeEdsL9YDV
	 BqlU5OZyayTESvAAHp5AfWMDdH1Kb+fqcDWlMxxl5r2GGi2SYX/wiK6kIr1Ddp2CsY
	 fqOnmtnMtmWSg==
Message-ID: <57c6f8f6464f7ba0c0455875d4c53a0f9bf01a2c.camel@kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for Linux 6.19
From: Trond Myklebust <trondmy@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Jan 2026 14:46:24 -0500
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

The following changes since commit 3609fa95fb0f2c1b099e69e56634edb8fc03f87c=
:

  Merge tag 'devicetree-fixes-for-6.19-2' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/robh/linux (2026-01-04 16:57:47 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.19-=
2

for you to fetch changes up to d5811e6297f3fd9020ac31f51fc317dfdb260cb0:

  NFS: Fix size read races in truncate, fallocate and copy offload (2026-01=
-15 14:38:25 -0500)

----------------------------------------------------------------
NFS client bugfixes for Linux 6.19

Bugfixes:
- NFS: Fix another deadlock involving nfs_release_folio()
- NFS/localio: Stop I/O upon hitting a fatal error
- NFS/localio: Deal with page offsets that are > PAGE_SIZE
- NFS: Fix size read races in truncate, fallocate and copy offload
- NFSv4.x: Several bugfixes for the directory delegation client code
- pNFS: Fix a pNFS-related deadlock when returning delegations during open
- pNFS: Fix memory leaks in various error paths

----------------------------------------------------------------
Anna Schumaker (2):
      NFS: Fix directory delegation verifier checks
      NFS: Don't immediately return directory delegations when disabled

Trond Myklebust (8):
      pNFS: Fix a deadlock when returning a delegation during open()
      NFS: Fix a deadlock involving nfs_release_folio()
      NFSv4: Fix nfs_clear_verifier_delegated() for delegated directories
      NFSv4: Don't free slots prematurely if requesting a directory delegat=
ion
      NFSv4.x: Directory delegations don't require any state recovery
      NFS/localio: Stop further I/O upon hitting an error
      NFS/localio: Deal with page bases that are > PAGE_SIZE
      NFS: Fix size read races in truncate, fallocate and copy offload

Zilin Guan (2):
      pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()
      pnfs/blocklayout: Fix memory leak in bl_parse_scsi()

 fs/nfs/blocklayout/dev.c                  |  6 ++-
 fs/nfs/delegation.c                       |  7 ++-
 fs/nfs/dir.c                              | 78 ++++++++++++++++++++-------=
----
 fs/nfs/file.c                             |  3 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  2 +-
 fs/nfs/inode.c                            | 10 ++--
 fs/nfs/io.c                               |  2 +
 fs/nfs/localio.c                          | 32 ++++++-------
 fs/nfs/nfs42proc.c                        | 29 ++++++++----
 fs/nfs/nfs4proc.c                         | 53 ++++++++++++++++-----
 fs/nfs/nfs4state.c                        |  6 ++-
 fs/nfs/nfstrace.h                         |  3 ++
 fs/nfs/pnfs.c                             | 58 ++++++++++++++++-------
 fs/nfs/pnfs.h                             | 17 +++----
 fs/nfs/write.c                            | 33 +++++++++++++
 include/linux/nfs_fs.h                    |  1 +
 16 files changed, 239 insertions(+), 101 deletions(-)

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

