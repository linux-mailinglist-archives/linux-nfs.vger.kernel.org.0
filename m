Return-Path: <linux-nfs+bounces-20955-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHkoFN4Y5WlCeQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20955-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:03:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F3424F50
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C78300DF52
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E48228CB8;
	Sun, 19 Apr 2026 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dngvNq8R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577E19CCF7;
	Sun, 19 Apr 2026 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776621787; cv=none; b=EOdN+f7jl7Xbu5tI0hpRGpw7w3tpBhAcDHsjqezz4FWiDYlcxjc3O3TiFltoi9+YKp6EfCbFjd+Rjs+92CsOa0cUify9oVjOAA5XP96BuSR9jftw4dedDfJq0pimf+VJszVD3SFQGzOl2HNzW8AF8PqfrjOlLFLEuUCpS6u2vs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776621787; c=relaxed/simple;
	bh=lSMKX3qjDQ+g9RMDIdTIbZnGv8ovYj5IRqlypsi1Xos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccSSN+Uy/ppHP/EnGB2AQR58iS6zDSZBr66sLH1tBQ1pGRUwkDs6jD13NYxlNu2gIh9D85pxPVCjySf1j4lVK5mVqbCa4PSqpFrEj0Jxv61C6YpXB+gzZ51okVKC3h7oN55AvPLCJlasMLeujCI1bQ2AhVra098YEd/OScIyc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dngvNq8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8378CC2BCAF;
	Sun, 19 Apr 2026 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776621786;
	bh=lSMKX3qjDQ+g9RMDIdTIbZnGv8ovYj5IRqlypsi1Xos=;
	h=From:To:Cc:Subject:Date:From;
	b=dngvNq8Rhdv+OLBT3JMXcWOA+m5zRZfSjNhMYZMJhnLJXgMDzjnyNIwlxNyZVemFD
	 tzLBRN8RPHQvNIdhxrUWXoBbKsyFKpBOK4sUyoGXTXPPGiCmsBUznF8WzwYrZnCwqZ
	 OmlxLN0Mi6GcNbLez1hIOF6Av1jUGj5m8WlR9GCE2BZW1Z+IJkhLbpj8IpvaNjlGNB
	 3pNkr3MQ3tCQ6+GkFmbBzLoMk5YYW2kWnaNVGafl5a7fAgJoUKXeiXdEd+zplXExdU
	 cH4ffyOgvsgqCrjtWEzcKzFSFQMqEOvlKzi3IBFX9/suNpjbV3RHYgZBwUn0ot+mCJ
	 jFZA8+enVJgAg==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for the v7.1 merge window
Date: Sun, 19 Apr 2026 14:03:05 -0400
Message-ID: <20260419180305.2402-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20955-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A77F3424F50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.1

for you to fetch changes up to d644a698de12e996778657f65a4608299368e138:

  NFSD: Docs: clean up pnfs server timeout docs (2026-04-03 09:29:32 -0400)

----------------------------------------------------------------
NFSD 7.1 Release Notes

Benjamin Coddington contributed filehandle signing to defend against
filehandle-guessing attacks. The server now appends a SipHash-2-4
MAC to each filehandle when the new "sign_fh" export option is
enabled. NFSD then verifies filehandles received from clients
against the expected MAC; mismatches return NFS error STALE.

Chuck Lever converted the entire NLMv4 server-side XDR layer from
hand-written C to xdrgen-generated code, spanning roughly thirty
patches. XDR functions are generally boilerplate code and are easy
to get wrong. The goals of this conversion are improved memory
safety, lower maintenance burden, and groundwork for eventual Rust
code generation for these functions.

Dai Ngo improved pNFS block/SCSI layout robustness with two related
changes. SCSI persistent reservation fencing is now tracked per
client and per device via an xarray, to avoid both redundant preempt
operations on devices already fenced and a potential NFSD deadlock
when all nfsd threads are waiting for a layout return.

The remaining patches deliver scalability and infrastructure
improvements. Sincere thanks to all contributors, reviewers,
testers, and bug reporters who participated in the v7.1 NFSD
development cycle.

----------------------------------------------------------------
Andy Shevchenko (3):
      nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()
      sunrpc: Kill RPC_IFDEBUG()
      sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op

Benjamin Coddington (3):
      NFSD: Add a key for signing filehandles
      NFSD/export: Add sign_fh export option
      NFSD: Sign filehandles

Chuck Lever (59):
      lockd: Simplify cast_status() in svcproc.c
      lockd: Relocate and rename nlm_drop_reply
      lockd: Introduce nlm__int__deadlock
      lockd: Have nlm_fopen() return errno values
      lockd: Relocate nlmsvc_unlock API declarations
      NFS: Use nlmclnt_shutdown_rpc_clnt() to safely shut down NLM
      lockd: Move xdr4.h from include/linux/lockd/ to fs/lockd/
      lockd: Move share.h from include/linux/lockd/ to fs/lockd/
      lockd: Relocate include/linux/lockd/lockd.h
      lockd: Remove lockd/debug.h
      lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
      lockd: Make linux/lockd/nlm.h an internal header
      lockd: Move nlm4svc_set_file_lock_range()
      lockd: Relocate svc_version definitions to XDR layer
      Documentation: Add the RPC language description of NLM version 4
      lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
      lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure
      lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv4 CANCEL procedure
      lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure
      lockd: Refactor nlm4svc_callback()
      lockd: Use xdrgen XDR functions for the NLMv4 TEST_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
      lockd: Use xdrgen XDR functions for the NLMv4 TEST_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv4 LOCK_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_RES procedure
      lockd: Use xdrgen XDR functions for the NLMv4 SM_NOTIFY procedure
      lockd: Convert server-side undefined procedures to xdrgen
      lockd: Hoist file_lock init out of nlm4svc_decode_shareargs()
      lockd: Prepare share helpers for xdrgen conversion
      lockd: Use xdrgen XDR functions for the NLMv4 SHARE procedure
      lockd: Use xdrgen XDR functions for the NLMv4 UNSHARE procedure
      lockd: Use xdrgen XDR functions for the NLMv4 NM_LOCK procedure
      lockd: Use xdrgen XDR functions for the NLMv4 FREE_ALL procedure
      lockd: Add LOCKD_SHARE_SVID constant for DOS sharing mode
      lockd: Remove C macros that are no longer used
      lockd: Remove dead code from fs/lockd/xdr4.c
      sunrpc: Add XPT flags missing from SVC_XPRT_FLAG_LIST
      nfsd: use dynamic allocation for oversized NFSv4.0 replay cache
      SUNRPC: Tighten bounds checking in svc_rqst_replace_page
      SUNRPC: Allocate a separate Reply page array
      SUNRPC: Handle NULL entries in svc_rqst_release_pages
      svcrdma: preserve rq_next_page in svc_rdma_save_io_pages
      SUNRPC: Track consumed rq_pages entries
      SUNRPC: Optimize rq_respages allocation in svc_alloc_arg
      svcrdma: Add fair queuing for Send Queue access
      svcrdma: Clean up use of rdma->sc_pd->device in Receive paths
      svcrdma: Clean up use of rdma->sc_pd->device
      svcrdma: Add Write chunk WRs to the RPC's Send WR chain
      svcrdma: Factor out WR chain linking into helper
      SUNRPC: Add svc_rqst_page_release() helper
      svcrdma: Use contiguous pages for RDMA Read sink buffers
      NFSD: use per-operation statidx for callback procedures

Dai Ngo (4):
      NFSD: Track SCSI Persistent Registration Fencing per Client with xarray
      NFSD: fix nfs4_file access extra count in nfsd4_add_rdaccess_to_wrdeleg
      NFSD: Enforce timeout on layout recall and integrate lease manager fencing
      NFSD: convert callback RPC program to per-net namespace

Jeff Layton (8):
      nfsd/sunrpc: add svc_rqst->rq_private pointer and remove rq_lease_breaker
      nfsd/sunrpc: move rq_cachetype into struct nfsd_thread_local_info
      nfsd: add a runtime switch for disabling delegated timestamps
      nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option
      sunrpc: convert queue_lock from global spinlock to per-cache-detail lock
      sunrpc: convert queue_wait from global to per-cache-detail waitqueue
      sunrpc: split cache_detail queue into request and reader lists
      nfsd: convert global state_lock to per-net deleg_lock

Joseph Salisbury (2):
      nfsd: fix comment typo in nfs3xdr
      nfsd: fix comment typo in nfsxdr

NeilBrown (1):
      sunrpc/cache: improve RCU safety in cache_list walking.

Randy Dunlap (2):
      SUNRPC: xdr.h: fix all kernel-doc warnings
      NFSD: Docs: clean up pnfs server timeout docs

Ryota Sakamoto (1):
      SUNRPC: Replace KUnit tests for memcmp() with KUNIT_EXPECT_MEMEQ_MSG()

 .../admin-guide/nfs/pnfs-block-server.rst          |   30 +
 Documentation/admin-guide/nfs/pnfs-scsi-server.rst |   31 +
 Documentation/filesystems/locking.rst              |    2 +
 Documentation/filesystems/nfs/exporting.rst        |   85 +
 Documentation/netlink/specs/nfsd.yaml              |    6 +
 Documentation/sunrpc/xdr/nlm4.x                    |  211 +++
 fs/lockd/Makefile                                  |   30 +-
 fs/lockd/clnt4xdr.c                                |    5 +-
 fs/lockd/clntlock.c                                |    2 +-
 fs/lockd/clntproc.c                                |    2 +-
 fs/lockd/clntxdr.c                                 |    3 +-
 fs/lockd/host.c                                    |   31 +-
 {include/linux => fs}/lockd/lockd.h                |  101 +-
 fs/lockd/mon.c                                     |    2 +-
 {include/linux => fs}/lockd/nlm.h                  |    8 +-
 fs/lockd/nlm4xdr_gen.c                             |  724 ++++++++
 fs/lockd/nlm4xdr_gen.h                             |   32 +
 {include/linux => fs}/lockd/share.h                |   19 +-
 fs/lockd/svc.c                                     |   50 +-
 fs/lockd/svc4proc.c                                | 1786 ++++++++++++++------
 fs/lockd/svclock.c                                 |   21 +-
 fs/lockd/svcproc.c                                 |  126 +-
 fs/lockd/svcshare.c                                |   40 +-
 fs/lockd/svcsubs.c                                 |   32 +-
 fs/lockd/trace.h                                   |    3 +-
 fs/lockd/xdr.c                                     |    6 +-
 {include/linux => fs}/lockd/xdr.h                  |   15 +-
 fs/lockd/xdr4.c                                    |  347 ----
 fs/locks.c                                         |   26 +-
 fs/nfs/blocklayout/blocklayout.c                   |    4 +-
 fs/nfs/nfs3proc.c                                  |    1 +
 fs/nfs/proc.c                                      |    1 +
 fs/nfs/sysfs.c                                     |    4 +-
 fs/nfsd/Kconfig                                    |   12 +-
 fs/nfsd/blocklayout.c                              |  102 +-
 fs/nfsd/debugfs.c                                  |    4 +
 fs/nfsd/export.c                                   |    5 +-
 fs/nfsd/lockd.c                                    |   50 +-
 fs/nfsd/netlink.c                                  |    5 +-
 fs/nfsd/netns.h                                    |    7 +
 fs/nfsd/nfs3xdr.c                                  |    4 +-
 fs/nfsd/nfs4callback.c                             |  113 +-
 fs/nfsd/nfs4layouts.c                              |  152 +-
 fs/nfsd/nfs4proc.c                                 |    3 +-
 fs/nfsd/nfs4state.c                                |  113 +-
 fs/nfsd/nfs4xdr.c                                  |   26 +-
 fs/nfsd/nfscache.c                                 |    3 +-
 fs/nfsd/nfsctl.c                                   |   45 +-
 fs/nfsd/nfsd.h                                     |    6 +
 fs/nfsd/nfsfh.c                                    |   83 +-
 fs/nfsd/nfssvc.c                                   |   10 +-
 fs/nfsd/nfsxdr.c                                   |    2 +-
 fs/nfsd/pnfs.h                                     |    5 +-
 fs/nfsd/state.h                                    |   32 +-
 fs/nfsd/trace.h                                    |   23 +
 include/linux/filelock.h                           |    1 +
 include/linux/lockd/bind.h                         |   26 +-
 include/linux/lockd/debug.h                        |   40 -
 include/linux/lockd/xdr4.h                         |   43 -
 include/linux/sunrpc/cache.h                       |    7 +-
 include/linux/sunrpc/debug.h                       |   10 +-
 include/linux/sunrpc/sched.h                       |    3 -
 include/linux/sunrpc/svc.h                         |   82 +-
 include/linux/sunrpc/svc_rdma.h                    |   23 +-
 include/linux/sunrpc/xdr.h                         |   48 +-
 include/linux/sunrpc/xdrgen/nlm4.h                 |  233 +++
 include/trace/events/sunrpc.h                      |    4 +-
 include/uapi/linux/nfsd/export.h                   |    4 +-
 include/uapi/linux/nfsd_netlink.h                  |    1 +
 net/sunrpc/auth_gss/gss_krb5_test.c                |   93 +-
 net/sunrpc/cache.c                                 |  251 ++-
 net/sunrpc/svc.c                                   |   66 +-
 net/sunrpc/svc_xprt.c                              |   47 +-
 net/sunrpc/svcsock.c                               |    9 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |   28 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c                  |  374 +++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c              |  194 ++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |   33 +-
 78 files changed, 4454 insertions(+), 1757 deletions(-)
 create mode 100644 Documentation/sunrpc/xdr/nlm4.x
 rename {include/linux => fs}/lockd/lockd.h (83%)
 rename {include/linux => fs}/lockd/nlm.h (91%)
 create mode 100644 fs/lockd/nlm4xdr_gen.c
 create mode 100644 fs/lockd/nlm4xdr_gen.h
 rename {include/linux => fs}/lockd/share.h (58%)
 rename {include/linux => fs}/lockd/xdr.h (91%)
 delete mode 100644 fs/lockd/xdr4.c
 delete mode 100644 include/linux/lockd/debug.h
 delete mode 100644 include/linux/lockd/xdr4.h
 create mode 100644 include/linux/sunrpc/xdrgen/nlm4.h

