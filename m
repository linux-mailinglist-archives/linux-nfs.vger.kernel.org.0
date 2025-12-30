Return-Path: <linux-nfs+bounces-17352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E2CE9E81
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 15:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66FB8300A6E0
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904E1A2545;
	Tue, 30 Dec 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWVVCN/X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944FF15E97
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104322; cv=none; b=S42UjmFJ1PI8pVprNNWneWrQmQCBO4xSkCOG/s24yHwC+O1bIb+Zx1WwDzn2bS4beaHi7pc9WOBsQARKE9TGXuSu+ahOxoZmCzEtbRJ+jIGU06dUbGe0HoWEva9+NWmFXpYid5eRoZCMFsAfD3kajk/Pegf7oO0ObitigEMbpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104322; c=relaxed/simple;
	bh=y5Yd2HsMJCrgSk4Iod0YCiTi4GBiB+IRpU9sQJ2Fgp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bomgunQasDbKDpnsnFWeho/0eHABYo9e3HD9Rn2QHHq24TVnlVnmxTGyHkKsH+F8XqZr3hW4PzMRufInveABXDt1tYcYt7SDSeKxlLipHmY6S0K+gBxQ8nJvNfjT4wn58VsbOi6T7jSI3gCFIre7FZ/DlruuUhPgmYrPrV6DkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWVVCN/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FE0C4CEFB;
	Tue, 30 Dec 2025 14:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767104322;
	bh=y5Yd2HsMJCrgSk4Iod0YCiTi4GBiB+IRpU9sQJ2Fgp0=;
	h=From:To:Cc:Subject:Date:From;
	b=SWVVCN/XEhR7FIJHkSzb9uffTBMpHrq5rEz1uUwZysm/ZmLzKE+qkYKOASheZavFP
	 jY9ds5nfsSQv6vuhu7qYbo5VOZQgHHiqK9CT+I3YDMGMJipIQBSatIa+jPkEoUiZtK
	 140YfEUC9hK27c2VrJKX9yr7ohYkx9pnOgc7JEjxOy4ljrnacBFMMsgYk/lE0K5Gp/
	 VeqR/WNhjlyCQM6Gy5yNn3dOSU5xtGgK/XYNY6MXBUyFyX8TJESM2rlgvDy2Ur3EO3
	 oWKvHCrrOWPYAtb4M9uOMhA2uPyN1OES/McsJurtbDyT2THqbieZ+ZXpOTrFNFc3ZH
	 iM7aEGCuWE6Fw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/5] Automatic NFSv4 state revocation on filesystem unmount
Date: Tue, 30 Dec 2025 09:18:33 -0500
Message-ID: <20251230141838.2547848-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When an NFS server exports a filesystem and clients hold NFSv4 state
(opens, locks, delegations), unmounting the underlying filesystem
fails with EBUSY. The /proc/fs/nfsd/unlock_fs interface exists for
administrators to manually revoke state before retrying the unmount,
but this approach has significant operational drawbacks.

Manual intervention breaks automation workflows. Containerized NFS
servers, orchestration systems, and unattended maintenance scripts
cannot reliably unmount exported filesystems without implementing
custom logic to detect the failure and invoke unlock_fs. System
administrators managing many exports face tedious, error-prone
procedures when decommissioning storage.

The server also provides no notification to NFS clients when their
state becomes invalid due to filesystem removal. Clients continue
using stale state until they encounter errors, potentially
corrupting data or experiencing mysterious failures long after the
underlying storage disappeared.

This series enables the NFS server to detect filesystem unmount
events and automatically revoke associated state. The mechanism
uses the kernel's existing fs_pin infrastructure, which provides
callbacks during mount lifecycle transitions. When a filesystem
is unmounted, all NFSv4 opens, locks, and delegations referencing
it are revoked, async COPY operations are cancelled with
NFS4ERR_ADMIN_REVOKED sent to clients, NLM locks are released,
and cached file handles are closed.

With automatic revocation, unmount operations complete without
administrator intervention once the brief state cleanup finishes.
Clients receive immediate notification of state loss through
standard NFSv4 error codes, allowing applications to handle the
situation appropriately rather than encountering silent failures.

Chuck Lever (5):
  nfsd: cancel async COPY operations when admin revokes filesystem state
  fs: export pin_insert and pin_remove for modular filesystems
  fs: add pin_insert_group() for superblock-only pins
  nfsd: revoke NFSv4 state when filesystem is unmounted
  nfsd: close cached files on filesystem unmount

 fs/fs_pin.c            |  50 ++++++++
 fs/nfsd/Makefile       |   2 +-
 fs/nfsd/filecache.c    |  39 ++++++
 fs/nfsd/filecache.h    |   1 +
 fs/nfsd/netns.h        |   4 +
 fs/nfsd/nfs4proc.c     | 124 +++++++++++++++++--
 fs/nfsd/nfs4state.c    |  44 +++++--
 fs/nfsd/nfsctl.c       |  11 +-
 fs/nfsd/pin.c          | 272 +++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |   9 ++
 fs/nfsd/xdr4.h         |   1 +
 include/linux/fs_pin.h |   1 +
 12 files changed, 537 insertions(+), 21 deletions(-)
 create mode 100644 fs/nfsd/pin.c

-- 
2.52.0


