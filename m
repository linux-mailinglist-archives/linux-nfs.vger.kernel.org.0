Return-Path: <linux-nfs+bounces-11921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A25AC50A6
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF923B94BC
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45621348;
	Tue, 27 May 2025 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LURkryTu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A22DCC0C;
	Tue, 27 May 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355428; cv=none; b=Jzo5YEhcyWjFpomVHC6UHrdn7QTckH4Jhy8KckU/FjV+lkQFEaGrPQeq2pIb+MbuVhe8CX5B0axsCHRHgLbnh+C9DO3hKYT8cciZuqA4Va5LKNqUCx5hyJ3TCbUS7OyBzDgmQhx4JQyIhzb8stf3clYEUz3piHPylmP1KkHw21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355428; c=relaxed/simple;
	bh=QSI9xpdPjt2cu7QbFv5alW6FAXC6hJzKmw9uIJmaT0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rH3qTDl6H4C3MQ9NguDO5Uwo9PH01XMZKSvfKEZTDiqXlb3iNj4Hx448Gku2/Nhpg5gGoT7gcqVkpXFZcyYr+X/SeI5d2lC5OIYbnj4ItnB695IzX4fRf/jEm6g5xynPHkGaEeqr8LSWJJVvOsbAxrr1WjEILUNkM6dgcJ2y2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LURkryTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFBCC4CEE9;
	Tue, 27 May 2025 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748355428;
	bh=QSI9xpdPjt2cu7QbFv5alW6FAXC6hJzKmw9uIJmaT0w=;
	h=From:To:Cc:Subject:Date:From;
	b=LURkryTu0jC8GKWUlAOskqna2q1eIsXw2Fs0CzO3fihwnnlvGIIH4a/1glUyv1vYb
	 tMIQ4fWQX5vLOF3iszLF7EoyBLGB8Dz+0MXYAEEdPJP9R/3LVFwXMtlTmOEv4AvKgv
	 mp9G99dfrotMsxYTr9x5szoI2YF4focKIZcrNRaWg1JpsaadlRQ0/Ap92bBwSJkYJh
	 Z11rYMJQnuzMgTbu3m4eNBIZUk6qKcmIurmAqSKyFXbxIEkjY9Dy274R/saefGoteD
	 JpAqRY96ulh8vg2VLCKy0TohfEN2ZQowneeTucyXYxO7jHidYdrM5WLcEpaAvPLDwh
	 WRVgI4mvqyVKA==
From: cel@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for v6.16
Date: Tue, 27 May 2025 10:17:06 -0400
Message-ID: <20250527141706.388993-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.16

for you to fetch changes up to 425364dc49f050b6008b43408aa96d42105a9c1d:

  xdrgen: Fix code generated for counted arrays (2025-05-16 10:58:48 -0400)

----------------------------------------------------------------
NFSD 6.16 Release Notes

The marquee feature for this release is that the limit on the
maximum rsize and wsize has been raised to 4MB. The default remains
at 1MB, but risk-seeking administrators now have the ability to try
larger I/O sizes with NFS clients that support them. Eventually the
default setting will be increased when we have confidence that this
change will not have negative impact.

With v6.16, NFSD now has its own debugfs file system where we can
add experimental features and make them available outside of our
development community without impacting production deployments. The
first experimental setting added is one that makes all NFS READ
operations use vfs_iter_read() instead of the NFSD splice actor. The
plan is to eventually retire the splice actor, as that will enable a
number of new capabilities such as the use of struct bio_vec from the
top to the bottom of the NFSD stack.

Jeff Layton contributed a number of observability improvements. The
use of dprintk() in a number of high-traffic code paths has been
replaced with static trace points.

This release sees the continuation of efforts to harden the NFSv4.2
COPY operation. Soon, the restriction on async COPY operations can
be lifted.

Many thanks to the contributors, reviewers, testers, and bug
reporters who participated during the v6.16 development cycle.

----------------------------------------------------------------
Chuck Lever (32):
      NFSD: OFFLOAD_CANCEL should mark an async COPY as completed
      NFSD: Shorten CB_OFFLOAD response to NFS4ERR_DELAY
      NFSD: Implement CB_SEQUENCE referring call lists
      NFSD: Implement CB_SEQUENCE referring call lists
      NFSD: Record each NFSv4 call's session slot index
      NFSD: Add /sys/kernel/debug/nfsd
      NFSD: Add experimental setting to disable the use of splice read
      MAINTAINERS: Update Neil Brown's email address
      svcrdma: Unregister the device if svc_rdma_accept() fails
      NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
      NFSD: Use sockaddr instead of a generic array
      NFSD: Add a Call equivalent to the NFSD_TRACE_PROC_RES macros
      svcrdma: Reduce the number of rdma_rw contexts per-QP
      sunrpc: Add a helper to derive maxpages from sv_max_mesg
      sunrpc: Remove backchannel check in svc_init_buffer()
      sunrpc: Replace the rq_pages array with dynamically-allocated memory
      sunrpc: Replace the rq_bvec array with dynamically-allocated memory
      NFSD: Use rqstp->rq_bvec in nfsd_iter_read()
      NFSD: De-duplicate the svc_fill_write_vector() call sites
      SUNRPC: Export xdr_buf_to_bvec()
      NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
      SUNRPC: Remove svc_fill_write_vector()
      SUNRPC: Remove svc_rqst :: rq_vec
      sunrpc: Adjust size of socket's receive page array dynamically
      svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
      svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
      sunrpc: Remove the RPCSVC_MAXPAGES macro
      NFSD: Remove NFSD_BUFSIZE
      NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
      NFSD: Add a "default" block size
      SUNRPC: Bump the maximum payload size for the server
      xdrgen: Fix code generated for counted arrays

Eric Biggers (1):
      nfsd: use SHA-256 library API instead of crypto_shash API

Guoqing Jiang (1):
      nfsd: remove redundant WARN_ON_ONCE in nfsd4_write

Jeff Layton (19):
      nfsd: add commit start/done tracepoints around nfsd_commit()
      sunrpc: add info about xprt queue times to svc_xprt_dequeue tracepoint
      sunrpc: allow SOMAXCONN backlogged TCP connections
      nfsd: add a tracepoint for nfsd_setattr
      nfsd: add a tracepoint to nfsd_lookup_dentry
      nfsd: add nfsd_vfs_create tracepoints
      nfsd: add tracepoint to nfsd_symlink
      nfsd: add tracepoint to nfsd_link()
      nfsd: add tracepoints for unlink events
      nfsd: add tracepoint to nfsd_rename
      nfsd: add tracepoint to nfsd_readdir
      nfsd: add tracepoint for getattr and statfs events
      nfsd: remove old v2/3 create path dprintks
      nfsd: remove old v2/3 SYMLINK dprintks
      nfsd: remove old LINK dprintks
      nfsd: remove REMOVE/RMDIR dprintks
      nfsd: remove dprintks for v2/3 RENAME events
      nfsd: remove legacy READDIR dprintks
      nfsd: remove legacy dprintks from GETATTR and STATFS codepaths

Li Lingfeng (1):
      nfsd: Initialize ssc before laundromat_work to prevent NULL dereference

Long Li (2):
      sunrpc: update nextcheck time when adding new cache entries
      sunrpc: fix race in cache cleanup causing stale nextcheck time

Maninder Singh (2):
      NFSD: unregister filesystem in case genl_register_family() fails
      NFSD: fix race between nfsd registration and exports_proc

NeilBrown (1):
      nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request

Olga Kornievskaia (1):
      nfsd: fix access checking for NLM under XPRTSEC policies

 .mailmap                                           |   2 +
 MAINTAINERS                                        |   2 +-
 fs/nfsd/Kconfig                                    |   2 +-
 fs/nfsd/Makefile                                   |   1 +
 fs/nfsd/debugfs.c                                  |  47 ++++
 fs/nfsd/export.c                                   |   3 +-
 fs/nfsd/nfs3proc.c                                 |  68 +----
 fs/nfsd/nfs4callback.c                             | 132 ++++++++-
 fs/nfsd/nfs4proc.c                                 |  35 ++-
 fs/nfsd/nfs4recover.c                              |  61 +----
 fs/nfsd/nfs4state.c                                |  40 +--
 fs/nfsd/nfs4xdr.c                                  |  21 +-
 fs/nfsd/nfsctl.c                                   |  25 +-
 fs/nfsd/nfsd.h                                     |  34 +--
 fs/nfsd/nfsproc.c                                  |  48 +---
 fs/nfsd/nfssvc.c                                   |   8 +-
 fs/nfsd/nfsxdr.c                                   |   4 +-
 fs/nfsd/state.h                                    |  23 ++
 fs/nfsd/trace.h                                    | 302 ++++++++++++++++++++-
 fs/nfsd/vfs.c                                      |  90 ++++--
 fs/nfsd/vfs.h                                      |  10 +-
 fs/nfsd/xdr4.h                                     |   4 +
 fs/nfsd/xdr4cb.h                                   |   5 +-
 include/linux/sunrpc/svc.h                         |  46 ++--
 include/linux/sunrpc/svc_rdma.h                    |   6 +-
 include/linux/sunrpc/svc_xprt.h                    |   1 +
 include/linux/sunrpc/svcsock.h                     |   4 +-
 include/trace/events/sunrpc.h                      |  13 +-
 include/trace/misc/fs.h                            |  21 ++
 net/sunrpc/cache.c                                 |  17 +-
 net/sunrpc/svc.c                                   |  80 ++----
 net/sunrpc/svc_xprt.c                              |  11 +-
 net/sunrpc/svcsock.c                               |  17 +-
 net/sunrpc/xdr.c                                   |   1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |   8 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c                  |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c              |  16 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |  15 +-
 .../C/pointer/encoder/variable_length_array.j2     |   2 +
 .../C/struct/encoder/variable_length_array.j2      |   2 +
 .../C/union/decoder/variable_length_array.j2       |   2 +
 41 files changed, 849 insertions(+), 382 deletions(-)
 create mode 100644 fs/nfsd/debugfs.c

