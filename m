Return-Path: <linux-nfs+bounces-7732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9199BF82D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 21:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0998B1C21C5E
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9639E20C48C;
	Wed,  6 Nov 2024 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqIOfy6b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0120C484
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925893; cv=none; b=NWetpgOS9ZkkiV7l54sBNXhDiOQC99AD8iVidZQFYay/boGCuzuqowpwysSxpInSkX2f2dqrMQ7jjLUNEt61N1F7iW/YdlhHJ9ebGwVUuVwsmxOKPH0F3q+vlEEMJcsTC+8WObBY7THxRjQarPRYR3VEw35kFKVBESWWvNnpLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925893; c=relaxed/simple;
	bh=4E9S5UpX3yJrfvDBQZcqFjmnJBpobRZPk6nZJP4QhcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cq/YLhzm6JRz9KZQ3YGbSzGdXJOOZA7cWyaVvwQqkZnWERor27yl2/VEqHiNOPPSGOettKg8l2A4cN075YiCrMRGIB+YMad/KQOSPaxLtdgzTT0YJmkLgr3ZAuKCBe5WKks+QrFV597v772PePfDb+UNN4we7SPEklN+DoJIIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqIOfy6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E61C4CECD;
	Wed,  6 Nov 2024 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730925893;
	bh=4E9S5UpX3yJrfvDBQZcqFjmnJBpobRZPk6nZJP4QhcE=;
	h=From:To:Cc:Subject:Date:From;
	b=iqIOfy6bMiNzd8DFoQOqcuDJh7eZNqOAA07BVqt8f2a8i1/DzhAV6vQwRoPlYHd+f
	 YWv5y2eczz4pVYZqfbRW59TdqQtjokK2fjKDVhNZTFvp7qcwG2zw0QT14rCOJr8UhW
	 cwA6HNKJuqVPbxbFSgvbtrpIWGsFcwDNbRvHtbcRpcF8DIt2VDeFgdZabG2+nZG1FM
	 Of+9EY0O2/FqWTE1erfK1l7zOm03HjqoCuyOOlkz2ohczfbzz+i31DVzbccVa1DXun
	 2uwvDhNJkgOab/56nxLNex1mgbddrFqIEKFOK14e368hp0PU+aJi3aFfhbZRF/8EfO
	 CHrodqdbigLfg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] More NFS Client Bugfixes for Linux 6.12-rc
Date: Wed,  6 Nov 2024 15:44:51 -0500
Message-ID: <20241106204451.195522-1-anna@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-3

for you to fetch changes up to 867da60d463bb2a3e28c9235c487e56e96cffa00:

  nfs: avoid i_lock contention in nfs_clear_invalid_mapping (2024-11-04 10:24:19 -0500)

----------------------------------------------------------------
These are mostly fixes that came up during the nfs bakeathon
the other week.

Stable Fixes:
* Fix KMSAN warning in decode_getfattr_attrs()

Other Bugfixes:
* Handle -ENOTCONN in xs_tcp_setup_socked()
* NFSv3: only use NFS timeout for MOUNT when protocols are compatible
* Fix attribute delegation behavior on exclusive create and a/mtime changes
* Fix localio to cope with racing nfs_local_probe()
* Avoid i_lock contention in fs_clear_invalid_mapping()

Thanks,
Anna

----------------------------------------------------------------
Mike Snitzer (2):
      nfs_common: fix localio to cope with racing nfs_local_probe()
      nfs: avoid i_lock contention in nfs_clear_invalid_mapping

NeilBrown (2):
      sunrpc: handle -ENOTCONN in xs_tcp_setup_socket()
      NFSv3: only use NFS timeout for MOUNT when protocols are compatible

Roberto Sassu (1):
      nfs: Fix KMSAN warning in decode_getfattr_attrs()

Trond Myklebust (2):
      NFS: Fix attribute delegation behaviour on exclusive create
      NFS: Further fixes to attribute delegation a/mtime changes

 fs/nfs/client.c            |  3 +-
 fs/nfs/inode.c             | 70 +++++++++++++++++++++++++++++++---------------
 fs/nfs/localio.c           |  3 +-
 fs/nfs/nfs4proc.c          |  4 +++
 fs/nfs/super.c             | 10 ++++++-
 fs/nfs_common/nfslocalio.c | 25 +++++++++++++----
 include/linux/nfslocalio.h |  3 +-
 net/sunrpc/xprtsock.c      |  1 +
 8 files changed, 85 insertions(+), 34 deletions(-)

