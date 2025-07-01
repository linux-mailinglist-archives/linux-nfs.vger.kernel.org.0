Return-Path: <linux-nfs+bounces-12850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E81AF04F0
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 22:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1401C07419
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9796C2E336C;
	Tue,  1 Jul 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp380xL3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D726057C
	for <linux-nfs@vger.kernel.org>; Tue,  1 Jul 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402027; cv=none; b=dxzKethCHMHMs+g4XrNMX+7KqlANpJpE1XBRRLjL0c+btkwvyQBgzZGaI+aQIn70TfFqSKIUcOJMR+Kw0yxZK0uGuA8uYC8aZE/C03EqgIaNf6MtgBIj+v03+Dr1VjDBhdP/ovTxIMKAnAjwqQ5xRhfsIdCXvh9Vh0wpDd6PC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402027; c=relaxed/simple;
	bh=mOSRkBRV5Sno3b/Ki+d8MZK/HhWmPLSDQtDFJH2x/zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWEp1bQsfuNayZ0sP8iLgXOFnSyYXbUJGhvOT4Hx/08515a+sXgrqm52SCy8XKW2uagJcr9cV/EE71McViZulHBM/mcITsm+qqbB0TAuDUScUeU1/BK0GdCqxqCF6/6Iv03fhe7RaoOmb62DeyeT8IrNTMZWzaeVA1I4uvPj4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp380xL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98206C4CEEB;
	Tue,  1 Jul 2025 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751402026;
	bh=mOSRkBRV5Sno3b/Ki+d8MZK/HhWmPLSDQtDFJH2x/zM=;
	h=From:To:Cc:Subject:Date:From;
	b=Dp380xL3LaLMpHN9TeWBGxcgRpoB+3M2iY2qf5HL69Z2j0TeWSv2mRtFnf6mFG1xQ
	 Z51mZTZ3+qpjQj0NJ+ZiTKfpymFbzOFF2tpkhlhSx/d4xcpoiTT8T0zJ2zJHKF7oWh
	 xcqOgC2tPuX3xeFMP0S88a1rgs2lpaaWjYtLniPSf5yIlLq65Rkt04tEGPMM9n4Xsk
	 0yfWCLPu3FATQPiqQg+0rFjiWq6QaeeJKz289pxFvfilmC60J0Ap9Mk/eumnXWfrGE
	 Y83Wsu8nT5/Sjj/D+8DGSoe1elQJZA84wTsxkRs0ScXqJwA+lT5sgNaO/13/WIFYo8
	 hIdKtSyFhSkCw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 6.16-rc5
Date: Tue,  1 Jul 2025 16:33:45 -0400
Message-ID: <20250701203345.781391-1-anna@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.16-2

for you to fetch changes up to 38074de35b015df5623f524d6f2b49a0cd395c40:

  NFSv4/flexfiles: Fix handling of NFS level errors in I/O (2025-06-26 13:46:44 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.16

* Fix loop in GSS sequence number cache
* Clean up /proc/net/rpc/nfs if nfs_fs_proc_net_init() fails
* Fix a race to wake on NFS_LAYOUT_DRAIN
* Fix handling of NFS level errors in I/O

Thanks,
Anna

----------------------------------------------------------------
Benjamin Coddington (1):
      NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN

Kuniyuki Iwashima (1):
      nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.

Nikhil Jha (1):
      sunrpc: fix loop in gss seqno cache

Trond Myklebust (1):
      NFSv4/flexfiles: Fix handling of NFS level errors in I/O

 fs/nfs/flexfilelayout/flexfilelayout.c | 118 +++++++++++++++++++++++----------
 fs/nfs/inode.c                         |  17 ++++-
 fs/nfs/pnfs.c                          |   4 +-
 net/sunrpc/auth_gss/auth_gss.c         |   2 +-
 4 files changed, 102 insertions(+), 39 deletions(-)

