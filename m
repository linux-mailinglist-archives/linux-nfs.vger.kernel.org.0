Return-Path: <linux-nfs+bounces-16784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E07C937C9
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 05:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6C234E0F6F
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 04:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD01205E02;
	Sat, 29 Nov 2025 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIL5PQ1n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196723C17
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389194; cv=none; b=DNgPp5Asmhz0uRDLQlAt7S5wRmYg9+H8Qa+9D+ilzfkvY0EhevHYT+Umt1NKPSi3ZUxOVdA9DzPesJ6ckCN00PHrng2e/Y0p/lNQwAssbV+2pTyfMdKwRJ+svI0g8lnZNdmn0c7IrXjBUbf6H2SpBBvFuHaNTIV0Kfg9KIv1Cew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389194; c=relaxed/simple;
	bh=xJUCiqplZsD6q7/FK3D5G5jWsUgevf0ayVBWzGbC4A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lc0JCcSQ75tThntvlOukMpUxaGRzA7VN7c7gffQQ3AduEdSjV55dITBopKGDEpdpzTTv4hmAxHsFpWhTvtayqVNhwMcjti4ETMMMdAzcSfcjWcsJ+RMK6V9v5cqXu+3ZTT4m5WWES7TwN3+oXIFKDhkkVvcKS/P1/xeMSawbDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIL5PQ1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A181CC4CEF7;
	Sat, 29 Nov 2025 04:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764389193;
	bh=xJUCiqplZsD6q7/FK3D5G5jWsUgevf0ayVBWzGbC4A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIL5PQ1n34ViDgzdtJxqPnX9mvjTbwabyUb927ap3hHXyYG77cRY49+Py4bnN5SJF
	 xkhXQevx/PhJIWrzpG+dSKFadYiI3luoKuVmc2unQ1TjoFDWIw2J5NUntVdBhlOo5T
	 BS3y1iM8TDUa/QsE7Wq8DN9DuPP62O6zd/U0oiuvp9OhEnXuv9r8ZBhj2UNcg8342i
	 vq80RtdP+UTa0efkRNrfeQeZJTQJgdc/o4mFhIu1nq2KWy7ZzOuWynUsBsk3f19vZX
	 zH2ax0qanUtrVsGS0IVX0StWuWhWAWTrYekCO6ABB1jXu29EJ7XW3BPlCW5miry64O
	 +NKNfI7nw1R9A==
From: Trond Myklebust <trondmy@kernel.org>
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/6] Fix up NFS client mount option regressions
Date: Fri, 28 Nov 2025 23:06:26 -0500
Message-ID: <cover.1764388528.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The recent changes to suppress the 'ro' and 'rw' mount options when
mounting the same NFS filesystem with different settings are causing
confusion with users, and are an unnecessary restriction. They represent
a functionality regression.

The following patch set reverts the regressions, before applying a
different set of fixes to address the original problem, which was one of
the NFSv4 mount automounter code failing to propagate the correct mount
options.

Trond Myklebust (6):
  Revert "nfs: ignore SB_RDONLY when remounting nfs"
  Revert "nfs: clear SB_RDONLY before getting superblock"
  Revert "nfs: ignore SB_RDONLY when mounting nfs"
  NFS: Automounted filesystem should inherit ro,noexec,nodev,sync flags
  NFS: Fix inheritance of the block sizes when automounting
  NFS: Fix up the automount fs_context to use the correct cred

 fs/nfs/client.c           | 21 +++++++++++++++++----
 fs/nfs/internal.h         |  3 +--
 fs/nfs/namespace.c        | 16 +++++++++++++++-
 fs/nfs/nfs4client.c       | 18 ++++++++++++++----
 fs/nfs/super.c            | 33 +++------------------------------
 include/linux/nfs_fs_sb.h |  5 +++++
 6 files changed, 55 insertions(+), 41 deletions(-)

-- 
2.52.0


