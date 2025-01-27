Return-Path: <linux-nfs+bounces-9681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF6A1D88B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD82F3A3B83
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D33D64;
	Mon, 27 Jan 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4aID6Xo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5C1EB3E;
	Mon, 27 Jan 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988749; cv=none; b=t1ZFopKxean/wFsexIIBs3SJ9WnOYJ5j+4Zq/LvhKWBaf9q7SsyvkoeZJS4IgHtHTfoueNBgBWp+0K8JBkhtAQMq7pHsM9jToah3K/YJOo5iouVOpoJBqpzltQDG0LZWIPRLmHg59ZV6tq+b1fY+0ter99io+nov87zsHPhdrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988749; c=relaxed/simple;
	bh=LfnHHGbeKdmpI3o6gKE0/9J1lYyAuLS65r0EzXiC80w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8UIvs503QisopPwHelcJjV1ZQlE6iMX2U8VzQa8bvqq4m5vvobZYN1q4yz68ONjrFiVcEuPQichQhyBQ5Up75i91J6HMEOBPFc4dtoaYZKH6G4QpQvzHs/uslL5f0tRY/B5/2cK6VTQOBxpS0Dirlpzn33Jbup4ZklxcIWTaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4aID6Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47493C4CED2;
	Mon, 27 Jan 2025 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737988748;
	bh=LfnHHGbeKdmpI3o6gKE0/9J1lYyAuLS65r0EzXiC80w=;
	h=From:To:Cc:Subject:Date:From;
	b=m4aID6Xoc+QkPvpdbjtdIrl+pbJX3qTBfGNkfyTT5iViHkJFqYJ9Iqx5Syt62dzAH
	 KLHUIcu0pypPeQxiIA9z0i2gyUvN5/j7FdyfQ0Edk5Q53yCyrgcrszI7XtBEZFbGo5
	 JZZjgQivqisqT1UUUnihxj3QVlG7vGps0PF4+swhKphp/78hrO+DQxWlndY2IW3ngH
	 JV+e7Y2BHNn1yOnIIh+xl4HlPJNKfrTXMdGcs2ABw123W8jx6uDIbh/M9ehvha01/C
	 NOaj+6SvO1x+3w/9JE6pwmNd1BDQ9HU67PCoyzt484H2nHjaLoBCex037bgQ3kKtl8
	 BTKj42JCU+cqg==
From: cel@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for v6.14
Date: Mon, 27 Jan 2025 09:39:07 -0500
Message-ID: <20250127143907.5349-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.14

for you to fetch changes up to c92066e78600b058638785288274a1f1426fe268:

  sunrpc: Remove gss_{de,en}crypt_xdr_buf deadcode (2025-01-21 15:30:01 -0500)

----------------------------------------------------------------
NFSD 6.14 Release Notes

Jeff Layton contributed an implementation of NFSv4.2+ attribute
delegation, as described here:

https://www.ietf.org/archive/id/draft-ietf-nfsv4-delstid-08.html

This interoperates with similar functionality introduced into the
Linux NFS client in v6.11. An attribute delegation permits an NFS
client to manage a file's mtime, rather than flushing dirty data to
the NFS server so that the file's mtime reflects the last write,
which is considerably slower.

Neil Brown contributed dynamic NFSv4.1 session slot table resizing.
This facility enables NFSD to increase or decrease the number of
slots per NFS session depending on server memory availability. More
session slots means greater parallelism.

Chuck Lever fixed a long-standing latent bug where NFSv4 COMPOUND
encoding screws up when crossing a page boundary in the encoding
buffer. This is a zero-day bug, but hitting it is rare and depends
on the NFS client implementation. The Linux NFS client does not
happen to trigger this issue.

A variety of bug fixes and other incremental improvements fill out
the list of commits in this release. Great thanks to all
contributors, reviewers, testers, and bug reporters who participated
during this development cycle.

----------------------------------------------------------------
Chen Hanxiao (1):
      nfsd: trace: remove redundant stateid even deleg_recall

Chuck Lever (11):
      NFSD: Clean up unused variable
      NFSD: Encode COMPOUND operation status on page boundaries
      NFSD: Insulate nfsd4_encode_read() from page boundaries in the encode buffer
      NFSD: Insulate nfsd4_encode_read_plus() from page boundaries in the encode buffer
      NFSD: Insulate nfsd4_encode_read_plus_data() from page boundaries in the encode buffer
      NFSD: Insulate nfsd4_encode_readlink() from page boundaries in the encode buffer
      NFSD: Refactor nfsd4_do_encode_secinfo() again
      NFSD: Insulate nfsd4_encode_secinfo() from page boundaries in the encode buffer
      NFSD: Insulate nfsd4_encode_fattr4() from page boundaries in the encode buffer
      SUNRPC: Document validity guarantees of the pointer returned by reserve_space
      Revert "SUNRPC: Reduce thread wake-up rate when receiving large RPC messages"

Dr. David Alan Gilbert (3):
      sunrpc: Remove unused xprt_iter_get_xprt
      sunrpc: Remove gss_generic_token deadcode
      sunrpc: Remove gss_{de,en}crypt_xdr_buf deadcode

Jeff Layton (10):
      nfsd: fix handling of delegated change attr in CB_GETATTR
      nfs_common: make include/linux/nfs4.h include generated nfs4_1.h
      nfsd: switch to autogenerated definitions for open_delegation_type4
      nfsd: rename NFS4_SHARE_WANT_* constants to OPEN4_SHARE_ACCESS_WANT_*
      nfsd: prepare delegation code for handing out *_ATTRS_DELEG delegations
      nfsd: add support for FATTR4_OPEN_ARGUMENTS
      nfsd: rework NFS4_SHARE_WANT_* flag handling
      nfsd: add support for delegated timestamps
      nfsd: handle delegated timestamps in SETATTR
      nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION

NeilBrown (10):
      nfsd: use new wake_up_var interfaces.
      sunrpc/svc: use store_release_wake_up()
      nfsd: don't use sv_nrthreads in connection limiting calculations.
      sunrpc: remove all connection limit configuration
      nfsd: use an xarray to store v4.1 session slots
      nfsd: remove artificial limits on the session-based DRC
      nfsd: add session slot count to /proc/fs/nfsd/clients/*/info
      nfsd: allocate new session-based DRC slots on demand.
      nfsd: add support for freeing unused session-DRC slots
      nfsd: add shrinker to reduce number of slots allocated per session

Olga Kornievskaia (2):
      NFSD: fix decoding in nfs4_xdr_dec_cb_getattr
      NFSD: add cb opcode to WARN_ONCE on failed callback

Scott Mayhew (1):
      nfsd: fix legacy client tracking initialization

Yang Erkun (4):
      SUNRPC: introduce cache_check_rcu to help check in rcu context
      nfsd: no need get cache ref when protected by rcu
      SUNRPC: no need get cache ref when protected by rcu
      nfsd: fix UAF when access ex_uuid or ex_stats

 Documentation/sunrpc/xdr/nfs4_1.x       | 186 +++++++++++
 fs/lockd/svc.c                          |   8 -
 fs/nfs/callback.c                       |   4 -
 fs/nfs/callback_xdr.c                   |   1 +
 fs/nfsd/Makefile                        |  16 +-
 fs/nfsd/export.c                        |  25 +-
 fs/nfsd/netns.h                         |   6 -
 fs/nfsd/nfs4callback.c                  |  60 +++-
 fs/nfsd/nfs4proc.c                      |  31 +-
 fs/nfsd/nfs4recover.c                   |   1 -
 fs/nfsd/nfs4state.c                     | 526 +++++++++++++++++++++++---------
 fs/nfsd/nfs4xdr.c                       | 338 +++++++++++++-------
 fs/nfsd/nfs4xdr_gen.c                   | 256 ++++++++++++++++
 fs/nfsd/nfs4xdr_gen.h                   |  25 ++
 fs/nfsd/nfsctl.c                        |  42 ---
 fs/nfsd/nfsd.h                          |  13 +-
 fs/nfsd/nfsfh.c                         |   2 +
 fs/nfsd/nfssvc.c                        |  37 ---
 fs/nfsd/state.h                         |  36 ++-
 fs/nfsd/trace.h                         |   1 -
 fs/nfsd/xdr4.h                          |   2 -
 fs/nfsd/xdr4cb.h                        |  10 +-
 include/linux/nfs4.h                    |   9 +-
 include/linux/nfs_xdr.h                 |   5 -
 include/linux/sunrpc/cache.h            |   2 +
 include/linux/sunrpc/gss_asn1.h         |  81 -----
 include/linux/sunrpc/gss_krb5.h         |   1 -
 include/linux/sunrpc/svc.h              |  13 +-
 include/linux/sunrpc/svc_xprt.h         |  22 ++
 include/linux/sunrpc/xdrgen/nfs4_1.h    | 153 ++++++++++
 include/linux/sunrpc/xprtmultipath.h    |   1 -
 include/linux/time64.h                  |   5 +
 include/uapi/linux/nfs4.h               |   7 +-
 net/sunrpc/auth_gss/Makefile            |   2 +-
 net/sunrpc/auth_gss/gss_generic_token.c | 231 --------------
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |  55 ----
 net/sunrpc/auth_gss/gss_krb5_internal.h |   7 -
 net/sunrpc/auth_gss/gss_mech_switch.c   |   1 -
 net/sunrpc/cache.c                      |  53 ++--
 net/sunrpc/svc_xprt.c                   |  38 +--
 net/sunrpc/svcsock.c                    |  12 +-
 net/sunrpc/xdr.c                        |   6 +
 net/sunrpc/xprtmultipath.c              |  17 --
 43 files changed, 1462 insertions(+), 885 deletions(-)
 create mode 100644 Documentation/sunrpc/xdr/nfs4_1.x
 create mode 100644 fs/nfsd/nfs4xdr_gen.c
 create mode 100644 fs/nfsd/nfs4xdr_gen.h
 delete mode 100644 include/linux/sunrpc/gss_asn1.h
 create mode 100644 include/linux/sunrpc/xdrgen/nfs4_1.h
 delete mode 100644 net/sunrpc/auth_gss/gss_generic_token.c

