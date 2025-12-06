Return-Path: <linux-nfs+bounces-16975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19903CAA952
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 16:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59D7630BBA64
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D542140E5F;
	Sat,  6 Dec 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LONQw2rE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D233B8D75;
	Sat,  6 Dec 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765035225; cv=none; b=nZ9gh0PE2SaQb5T8T03TNVuMFWJoawg1trunBOsIJSSzJPkjjliqTxg9FznYgw5S1AlE0+SR+cxy7SEjQRphi0u2DWaKrH7PhumgSVctoShtsII4h0lSRLZWvhjEdS5QPPw+V3szVC4xW8H/YWpF5wyWgtTtN2ayd2wjGwzqDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765035225; c=relaxed/simple;
	bh=BhZWmeChvYAdA+x7UJqpPQtMLmY4r3GggKMPHM8g4TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H75N/duRKOdW4GiyrF7XqDi0ExOTujnxCHkHIxdWPJOEFK91Rqu+bo72Ypv6Ff6YQYTWR0cjOrGHHAXSxfFRRgHyLgWnjiePXB7411mora0uWOpE5d0UTu9FxxXE1Zlo79uCQ+gkMxEM/edT17SY19YrU9zS9XS91F0gNNj5Vnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LONQw2rE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB50CC116B1;
	Sat,  6 Dec 2025 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765035225;
	bh=BhZWmeChvYAdA+x7UJqpPQtMLmY4r3GggKMPHM8g4TQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LONQw2rE5yjPoGxaeQNVeVG4U6jDbTPcckmrktc+VWG6A7a8hF1Ad5ehe6IheSPwF
	 q9QGL0vZ46Ark+tcb4nKrOlCsnTE8o18XlpXacWw5BRorTyb3FWTthVk3oadKr3OPp
	 +GY1CZ/ZJSA+C94fEPBBk46y2OMnVV4E1m666SVi3ok1/MfF3TrBxobDs2A6kbCyuU
	 ErDFJaRko7Tt6CbtPPf55rVWVWQWssiENukTDHb6Vm/l+0on3wpLyqJJnJ0f81uc6w
	 nPLLVwDRLTKJUXeUyxAZrJkl/fkjueIUlcmxzz/fFGjqo308DB4mFY3VKgjjEW2+FS
	 Ziaw8x8r3BTxg==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL]: NFSD changes for v6.19
Date: Sat,  6 Dec 2025 10:33:43 -0500
Message-ID: <20251206153343.66592-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus-

Stephen Rothwell reports one merge conflict with VFS changes that
already reside in your tree, and proposes a resolution:

  https://lore.kernel.org/linux-next/20251203101108.02f419d7@canb.auug.org.au/


--- cut here ---

The following changes since commit 6a23ae0a96a600d1d12557add110e0bb6e32730c:

  Linux 6.18-rc6 (2025-11-16 14:25:38 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19

for you to fetch changes up to df8c841dd92a7f262ad4fa649aa493b181e02812:

  NFSD: nfsd-io-modes: Separate lists (2025-12-03 09:05:14 -0500)

----------------------------------------------------------------
NFSD 6.19 Release Notes

Mike Snitzer's mechanism for disabling I/O caching introduced in
v6.18 is extended to include using direct I/O. The goal is to
further reduce the memory footprint consumed by NFS clients
accessing large data sets via NFSD.

The NFSD community adopted a maintainer entry profile during this
cycle. See

  Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst

Work continues on hardening NFSD's implementation of the pNFS block
layout type. This type enables pNFS clients to directly access the
underlying block devices that contain an exported file system,
reducing server overhead and increasing data throughput.

The remaining patches in this pull request are clean-ups and minor
optimizations. Many thanks to the contributors, reviewers, testers,
and bug reporters who participated during the v6.19 NFSD development
cycle.

----------------------------------------------------------------
Bagas Sanjaya (4):
      NFS: nfsd-maintainer-entry-profile: Inline function name prefixes
      NFSD: Add toctree entry for NFSD IO modes docs
      NFSD: nfsd-io-modes: Wrap shell snippets in literal code blocks
      NFSD: nfsd-io-modes: Separate lists

Christoph Hellwig (1):
      MAINTAINERS: add a nfsd blocklayout reviewer

Chuck Lever (14):
      svcrdma: Release transport resources synchronously
      NFSD: Add array bounds-checking in nfsd_iter_read()
      NFSD: Update comment documenting unsupported fattr4 attributes
      svcrdma: Increase the server's default RPC/RDMA credit grant
      NFSD: Relocate the xdr_reserve_space_vec() call site
      NFSD: Implement NFSD_IO_DIRECT for NFS READ
      SUNRPC: Improve "fragment too large" warning
      NFSD: Add a subsystem policy document
      xdrgen: Generalize/harden pathname construction
      xdrgen: Make the xdrgen script location-independent
      xdrgen: Fix the variable-length opaque field decoder template
      xdrgen: Fix union declarations
      xdrgen: Don't generate unnecessary semicolon
      NFSD: Make FILE_SYNC WRITEs comply with spec

Dai Ngo (2):
      NFSD: use correct reservation type in nfsd4_scsi_fence_client
      NFSD: Add trace point for SCSI fencing operation.

Eric Biggers (1):
      nfsd: Use MD5 library instead of crypto_shash

Jeff Layton (3):
      nfsd: switch the default for NFSD_LEGACY_CLIENT_TRACKING to "n"
      sunrpc: allocate a separate bvec array for socket sends
      lockd: don't allow locking on reexported NFSv2/3

Khushal Chitturi (1):
      xdrgen: handle _XdrString in union encoder/decoder

Matvey Kovalev (1):
      nfsd: delete unreachable confusing code in nfs4_open_delegation()

Mike Snitzer (3):
      NFSD: pass nfsd_file to nfsd_iter_read()
      NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
      NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst

NeilBrown (3):
      nfsd: move name lookup out of nfsd4_list_rec_dir()
      nfsd: change nfs4_client_to_reclaim() to allocate data
      nfsd: stop pretending that we cache the SEQUENCE reply.

Olga Kornievskaia (1):
      NFSD: don't start nfsd if sv_permsocks is empty

Sergey Bashirov (4):
      NFSD/blocklayout: Fix minlength check in proc_layoutget
      NFSD/blocklayout: Extract extent mapping from proc_layoutget
      NFSD/blocklayout: Introduce layout content structure
      NFSD/blocklayout: Support multiple extents per LAYOUTGET

 Documentation/filesystems/nfs/index.rst            |   1 +
 Documentation/filesystems/nfs/nfsd-io-modes.rst    | 153 ++++++
 .../nfs/nfsd-maintainer-entry-profile.rst          | 547 +++++++++++++++++++++
 .../maintainer/maintainer-entry-profile.rst        |   1 +
 MAINTAINERS                                        |   5 +
 fs/lockd/svclock.c                                 |  12 +
 fs/lockd/svcshare.c                                |   6 +
 fs/nfsd/Kconfig                                    |   6 +-
 fs/nfsd/blocklayout.c                              | 162 ++++--
 fs/nfsd/blocklayoutxdr.c                           |  36 +-
 fs/nfsd/blocklayoutxdr.h                           |  14 +
 fs/nfsd/debugfs.c                                  |   3 +
 fs/nfsd/nfs4recover.c                              | 195 +++-----
 fs/nfsd/nfs4state.c                                |  85 ++--
 fs/nfsd/nfs4xdr.c                                  |  28 +-
 fs/nfsd/nfsd.h                                     |   4 +-
 fs/nfsd/nfssvc.c                                   |  28 +-
 fs/nfsd/trace.h                                    |  41 ++
 fs/nfsd/vfs.c                                      | 261 +++++++++-
 fs/nfsd/vfs.h                                      |   2 +-
 fs/nfsd/xdr4.h                                     |  21 -
 include/linux/lockd/lockd.h                        |   9 +-
 include/linux/sunrpc/svc_rdma.h                    |   2 +-
 include/linux/sunrpc/svcsock.h                     |   3 +
 net/sunrpc/svcsock.c                               |  62 ++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |  19 +-
 tools/net/sunrpc/xdrgen/generators/__init__.py     |  11 +-
 tools/net/sunrpc/xdrgen/generators/union.py        |  34 +-
 .../xdrgen/templates/C/pointer/decoder/close.j2    |   2 +-
 .../xdrgen/templates/C/pointer/encoder/close.j2    |   2 +-
 .../xdrgen/templates/C/struct/decoder/close.j2     |   2 +-
 .../C/struct/decoder/variable_length_opaque.j2     |   2 +-
 .../xdrgen/templates/C/struct/encoder/close.j2     |   2 +-
 .../xdrgen/templates/C/typedef/decoder/basic.j2    |   2 +-
 .../C/typedef/decoder/fixed_length_array.j2        |   2 +-
 .../C/typedef/decoder/fixed_length_opaque.j2       |   2 +-
 .../xdrgen/templates/C/typedef/decoder/string.j2   |   2 +-
 .../C/typedef/decoder/variable_length_array.j2     |   2 +-
 .../C/typedef/decoder/variable_length_opaque.j2    |   2 +-
 .../xdrgen/templates/C/typedef/encoder/basic.j2    |   2 +-
 .../C/typedef/encoder/fixed_length_array.j2        |   2 +-
 .../C/typedef/encoder/fixed_length_opaque.j2       |   2 +-
 .../xdrgen/templates/C/typedef/encoder/string.j2   |   2 +-
 .../C/typedef/encoder/variable_length_array.j2     |   2 +-
 .../C/typedef/encoder/variable_length_opaque.j2    |   2 +-
 .../xdrgen/templates/C/union/declaration/close.j2  |   4 +
 .../xdrgen/templates/C/union/decoder/close.j2      |   2 +-
 .../xdrgen/templates/C/union/encoder/close.j2      |   2 +-
 .../xdrgen/templates/C/union/encoder/string.j2     |   6 +
 tools/net/sunrpc/xdrgen/xdrgen                     |   5 +
 50 files changed, 1431 insertions(+), 373 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst
 create mode 100644 Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2

