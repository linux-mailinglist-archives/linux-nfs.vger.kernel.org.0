Return-Path: <linux-nfs+bounces-18050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E241D388FA
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334D3301B4A5
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693A30B535;
	Fri, 16 Jan 2026 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjfX25xy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CC3064AF
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600297; cv=none; b=JxLXzCkTt46J+b3STkpDU8J18uOPKU9RehohzLuBf6yk6EqI+sk+pwRCYKqzFL2yGJGy7rhhJ0RORYMu/HwdLDhuYWj1CiWixhUj/kXDpqGA4/kar2q4l0MAUattt0o5WuHtC1gdiMkvOwSpyxrktnil16nD6RcwKXJ1OhK9Vr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600297; c=relaxed/simple;
	bh=kv6PTYUMXRi16z3ekUCwQwM1tfiVJ/Mg+mk9vx+x8j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KL0IsVnY5iHcaUyrfB6vFrmlz4gmYJ+U5TaS2us+hd5hxBZhXAR/gxnopvWoZ6KIHxtJTFTKJ17GlFduFDxmwLxWle27SFStXWzkKoeec8si/9/ZVNcJGRoVPoh9z08oUHRkauh/I+wu6GOPvhF7ITaL+ob56/TFNaUTtXKdyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjfX25xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B7BC116C6;
	Fri, 16 Jan 2026 21:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600297;
	bh=kv6PTYUMXRi16z3ekUCwQwM1tfiVJ/Mg+mk9vx+x8j4=;
	h=From:To:Cc:Subject:Date:From;
	b=RjfX25xym1UMjDv3+J9n/vrjG4nT0PY+QJB/5JayXOKN1RUjVxrUCwQljHMPfY8Nw
	 Un00oagJM2B7JyX8aquyOw3BTDYUK2jtTlB3K0CDDN69XSNz4XCTk3+fpTNygGP0pj
	 pEkpEMLJ7cSo42NGsBp6k7LpqPmW+dYVhODgz44acQsWO8+UimTOziP3FtQYDjSTr5
	 xfDQLf3zPU82uUscoLvLCKnV9BqC0QuKY6x37wDAKEhAybU0APjemW6OxyPH6QvxbA
	 8guKquWGc8qC8KRZiIbask+R8kGsTGHOnX4z8onmokX5/kHeEk7pE2EjGJ7OfgHVat
	 TPp8VldpBoMjw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 00/14] NFS: Make NFS v4.0 KConfig-urable
Date: Fri, 16 Jan 2026 16:51:21 -0500
Message-ID: <20260116215135.846062-1-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

A desire to deprecate NFS v4.0 came up as a discussion topic during the
October Bake-a-thon last year. This patchset takes the first step by
moving NFS v4.0 only code into new files prefixed with "nfs40" and
introducing a KConfig option to compile without NFS v4.0 support.

At the same time, I promote NFS v4.1 to be the default NFSv4
minorversion included in the kernel to prevent the situation where we
have NFS v4 enabled without any minor versions.

I'm sure I missed a bunch of stuff in nfs4proc.c that can be moved over
to nfs40proc.c, but I figure I should get some eyes on this before going
any farther incase I need to take a different approach somewhere.

Thoughts?
Anna


Anna Schumaker (14):
  NFS: Move nfs40_call_sync_ops into nfs40proc.c
  NFS: Split out the nfs40_reboot_recovery_ops into nfs40client.c
  NFS: Split out the nfs40_nograce_recovery_ops into nfs40proc.c
  NFS: Split out the nfs40_state_renewal_ops into nfs40proc.c
  NFS: Split out the nfs40_mig_recovery_ops to nfs40proc.c
  NFS: Move the NFS v4.0 minor version ops into nfs40proc.c
  NFS: Make the various NFS v4.0 operations static again
  NFS: Move nfs40_shutdown_client into nfs40client.c
  NFS: Move nfs40_init_client into nfs40client.c
  NFS: Move NFS v4.0 pathdown recovery into nfs40client.c
  NFS: Pass a struct nfs_client to nfs4_init_sequence()
  NFS: Move sequence slot operations into minorversion operations
  NFS: Add a way to disable NFS v4.0 via KConfig
  NFS: Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4

 fs/nfs/Kconfig            |  26 +-
 fs/nfs/Makefile           |   4 +-
 fs/nfs/callback.c         |  13 +-
 fs/nfs/callback.h         |   3 -
 fs/nfs/callback_proc.c    |   3 -
 fs/nfs/callback_xdr.c     |  21 --
 fs/nfs/client.c           |   8 +-
 fs/nfs/fs_context.c       |   3 +-
 fs/nfs/internal.h         |  15 +-
 fs/nfs/netns.h            |   4 +-
 fs/nfs/nfs40.h            |  19 ++
 fs/nfs/nfs40client.c      | 247 ++++++++++++++
 fs/nfs/nfs40proc.c        | 395 ++++++++++++++++++++++
 fs/nfs/nfs42proc.c        |  13 +-
 fs/nfs/nfs4_fs.h          |  83 ++---
 fs/nfs/nfs4client.c       | 193 +----------
 fs/nfs/nfs4proc.c         | 682 +++++++-------------------------------
 fs/nfs/nfs4session.c      |   4 -
 fs/nfs/nfs4session.h      |  23 --
 fs/nfs/nfs4state.c        |  91 +----
 fs/nfs/nfs4trace.c        |   2 -
 fs/nfs/nfs4trace.h        |  16 -
 fs/nfs/nfs4xdr.c          |  87 -----
 fs/nfs/pnfs.h             |   6 +-
 fs/nfs/read.c             |   4 +-
 fs/nfs/super.c            |  16 +-
 fs/nfs/sysfs.c            |  10 +-
 fs/nfs/write.c            |   2 +-
 include/linux/nfs_fs_sb.h |   2 -
 include/linux/nfs_xdr.h   |   7 +-
 30 files changed, 881 insertions(+), 1121 deletions(-)
 create mode 100644 fs/nfs/nfs40.h
 create mode 100644 fs/nfs/nfs40client.c
 create mode 100644 fs/nfs/nfs40proc.c

-- 
2.52.0


