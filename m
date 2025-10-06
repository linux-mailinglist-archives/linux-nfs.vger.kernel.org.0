Return-Path: <linux-nfs+bounces-14993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39919BBE39E
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 15:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19123ABD7A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0FB2D29AC;
	Mon,  6 Oct 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX5+9fbc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4B1F03D8;
	Mon,  6 Oct 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758614; cv=none; b=e4K9L0x+yWyu+gUwC8p8KmaR7C+yKtT3DHRhj7r3ASY+wSMICn+iInjiVthk1CY54THh1q9gp5BPD9qUZAIovjToKP4TQsKIEMhBpJYRbXEGG4FQKUILlWmFkw2tTa86/I4g6o1eoAScISi6Und+2rzv6M4noQpmpvC+QkqKSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758614; c=relaxed/simple;
	bh=LVbaVwyVG7huS4+RZPtiu2bWEjxrsFBDLHxGQqUS0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lme+Ov1BbFzLhu9mG6UaIR6XE25F0fXHXA+nlqpwx34/q7sE9NagPVLIMHokJrA8UaG6yIJSnWduhD/2tAnpIeJnoQfhkVhKSQPqrS1L+KmcI6p9LET5wcyakEJzM0Gksrhllu5NaMkgR1kQgBbuIfLqvJk+kwy2dhelYv+xdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CX5+9fbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5406FC4CEF5;
	Mon,  6 Oct 2025 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759758613;
	bh=LVbaVwyVG7huS4+RZPtiu2bWEjxrsFBDLHxGQqUS0Kk=;
	h=From:To:Cc:Subject:Date:From;
	b=CX5+9fbcSiHPJuyqmgzEi4EQ8wRy5aZlDJI003Pu0Ws8UUgxVX279Y8XVdF2j9W8/
	 IJsWhq4vhWOA98pKqEYFvqHzCHpA4X1thvmoVMoPkIi10LI2WS4LSyQVWszSrtY7MR
	 EGGwgDsB6CeUrafTVSDhfmXDfgcRlYSj4i5pv6e1zZMi0owRb4e/1WJzz2u9FUX0zJ
	 SW2h0YA3O0J6GppGYSi4YnYUFCy//4tYuVMeLSPqRU6oPAprZCmoOs4YK8u8E+XrVY
	 7Rg9URcaOgiZ7T6toZmyWzhZ5DxPnSB6hPmb6KqxdIOpl1kgwjoZpVrN1O68HklkLR
	 MYPBwFpAlNpXw==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for v6.18
Date: Mon,  6 Oct 2025 09:50:10 -0400
Message-ID: <20251006135010.2165-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus-

One potential merge conflict has been reported for nfsd-6.18.
See the following URLs for recommended resolution:

https://lore.kernel.org/lkml/aN5dMYUPfFly6eUO@sirena.org.uk/

or

https://lore.kernel.org/linux-nfs/aNxL88GmEzJ5hsHl@kernel.org/


--- cut here ---

The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18

for you to fetch changes up to 73cc6ec1a89a6c443a77b9b93ddcea63b7cea223:

  nfsd: discard nfserr_dropit (2025-10-01 15:54:01 -0400)

----------------------------------------------------------------
NFSD 6.18 Release Notes

Mike Snitzer has prototyped a mechanism for disabling I/O caching in
NFSD. This is introduced in v6.18 as an experimental feature. This
enables scaling NFSD in /both/ directions:

- NFS service can be supported on systems with small memory
  footprints, such as low-cost cloud instances
- Large NFS workloads will be less likely to force the eviction of
  server-local activity, helping it avoid thrashing

Jeff Layton contributed a number of fixes to the new attribute
delegation implementation (based on a pending Internet RFC) that we
hope will make attribute delegation reliable enough to enable by
default, as it is on the Linux NFS client.

The remaining patches in this pull request are clean-ups and minor
optimizations. Many thanks to the contributors, reviewers, testers,
and bug reporters who participated during the v6.18 NFSD development
cycle.

----------------------------------------------------------------
Chuck Lever (7):
      NFSD: Relocate the fh_want_write() and fh_drop_write() helpers
      NFSD: Move the fh_getattr() helper
      NFS: Remove rpcbind cleanup for NFSv4.0 callback
      SUNRPC: Move the svc_rpcb_cleanup() call sites
      NFSD: Delay adding new entries to LRU
      NFSD: Reduce DRC bucket size
      NFSD: Do the grace period check in ->proc_layoutget

Colin Ian King (1):
      lockd: Remove space before newline

Dan Carpenter (1):
      nfsd: delete unnecessary NULL check in __fh_verify()

Eric Biggers (4):
      nfsd: Replace open-coded conversion of bytes to hex
      nfsd: Eliminate an allocation in nfs4_make_rec_clidname()
      nfsd: Don't force CRYPTO_LIB_SHA256 to be built-in
      SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it

Jeff Layton (11):
      sunrpc: delay pc_release callback until after the reply is sent
      nfsd: fix assignment of ia_ctime.tv_nsec on delegated mtime update
      nfsd: ignore ATTR_DELEG when checking ia_valid before notify_change()
      vfs: add ATTR_CTIME_SET flag
      nfsd: use ATTR_CTIME_SET for delegated ctime updates
      nfsd: track original timestamps in nfs4_delegation
      nfsd: fix SETATTR updates for delegated timestamps
      nfsd: fix timestamp updates in CB_GETATTR
      nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation
      sunrpc: fix pr_notice in svc_tcp_sendto() to show correct length
      sunrpc: eliminate return pointer in svc_tcp_sendmsg()

Lei Lu (1):
      sunrpc: fix null pointer dereference on zero-length checksum

Mike Snitzer (1):
      NFSD: Add io_cache_{read,write} controls to debugfs

NeilBrown (2):
      nfsd: discard nfsd_file_get_local()
      nfsd: discard nfserr_dropit

Olga Kornievskaia (2):
      nfsd: unregister with rpcbind when deleting a transport
      nfsd: nfserr_jukebox in nlm_fopen should lead to a retry

Scott Mayhew (1):
      nfsd: decouple the xprtsec policy check from check_nfsd_access()

Sergey Bashirov (8):
      sunrpc: Change ret code of xdr_stream_decode_opaque_fixed
      NFSD: Rework encoding and decoding of nfsd4_deviceid
      NFSD: Minor cleanup in layoutcommit processing
      NFSD: Minor cleanup in layoutcommit decoding
      NFSD: Implement large extent array support in pNFS
      NFSD: Fix last write offset handling in layoutcommit
      NFSD: Disallow layoutget during grace period
      NFSD: Allow layoutcommit during grace period

Thorsten Blum (1):
      NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()

Xichao Zhao (2):
      NFSD: Drop redundant conversion to bool
      sunrpc: fix "occurence"->"occurrence"

 fs/attr.c                                          |  44 +++----
 fs/lockd/svc.c                                     |   6 +-
 fs/lockd/svclock.c                                 |   2 +-
 fs/nfs/callback.c                                  |  10 +-
 fs/nfsd/Kconfig                                    |   2 +-
 fs/nfsd/blocklayout.c                              |  32 +++---
 fs/nfsd/blocklayoutxdr.c                           |  86 +++++++++-----
 fs/nfsd/blocklayoutxdr.h                           |   4 +-
 fs/nfsd/debugfs.c                                  |  95 ++++++++++++++-
 fs/nfsd/export.c                                   |  82 +++++++++----
 fs/nfsd/export.h                                   |   3 +
 fs/nfsd/filecache.c                                |  21 ----
 fs/nfsd/filecache.h                                |   1 -
 fs/nfsd/flexfilelayout.c                           |   4 +-
 fs/nfsd/flexfilelayoutxdr.c                        |   3 +-
 fs/nfsd/localio.c                                  |   1 -
 fs/nfsd/lockd.c                                    |  15 ++-
 fs/nfsd/nfs4layouts.c                              |   1 -
 fs/nfsd/nfs4proc.c                                 | 127 +++++++++++++++------
 fs/nfsd/nfs4recover.c                              |  31 +----
 fs/nfsd/nfs4state.c                                |  86 ++++++++++----
 fs/nfsd/nfs4xdr.c                                  |  32 ++----
 fs/nfsd/nfscache.c                                 |  15 +--
 fs/nfsd/nfsctl.c                                   |   2 +-
 fs/nfsd/nfsd.h                                     |  17 +--
 fs/nfsd/nfsfh.c                                    |  51 ++++++++-
 fs/nfsd/nfsfh.h                                    |  38 ++++++
 fs/nfsd/nfssvc.c                                   |   7 +-
 fs/nfsd/pnfs.h                                     |   5 +-
 fs/nfsd/state.h                                    |  16 ++-
 fs/nfsd/vfs.c                                      |  23 +++-
 fs/nfsd/vfs.h                                      |  33 ------
 fs/nfsd/xdr4.h                                     |  39 ++++++-
 include/linux/fs.h                                 |   1 +
 include/linux/nfslocalio.h                         |   1 -
 include/linux/sunrpc/svc_xprt.h                    |   6 +-
 include/linux/sunrpc/xdr.h                         |   4 +-
 net/sunrpc/Kconfig                                 |   3 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |   2 +-
 net/sunrpc/svc.c                                   |  18 ++-
 net/sunrpc/svc_xprt.c                              |  20 +++-
 net/sunrpc/svcsock.c                               |  25 ++--
 net/sunrpc/sysfs.c                                 |   2 +-
 .../C/typedef/decoder/fixed_length_opaque.j2       |   2 +-
 44 files changed, 678 insertions(+), 340 deletions(-)

