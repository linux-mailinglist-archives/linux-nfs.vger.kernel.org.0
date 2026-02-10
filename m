Return-Path: <linux-nfs+bounces-18832-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHt8Dj9Zi2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18832-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:13:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8943F11CFA0
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D87C305186D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37E3876C1;
	Tue, 10 Feb 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0ZNjAKt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A43876A8;
	Tue, 10 Feb 2026 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739988; cv=none; b=Y0EKpXDWPrPLSdzZnXK4zYykOjKKRbVHPDb5BuxyOKaYfyIUBoUn71RolfDVKRKK0FSO8kHU4f82K6uzwUyG+sbJ8IKHd7q5aGJ83XHIhohRvG89Dcrg7l9K+aY15K2F7K++1p+M4SixlleGYq7tofoT47CT4wPM8K57xjvEzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739988; c=relaxed/simple;
	bh=8hE9snP3+ieYqJcqiwpH5OZcu+lzf0FjTuv3hDM3yP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXtQiZElE/ViKzTLbWSPPKCkD+NHYUDIKOZJGtYuOZE7zr2RM11qChW7vns86VoW6o4tejkGNtGobfuHHMt+qpNju34Sm1mOYsE6V33aQA5MPRrMIUJ84TWjNOxZPWB/lRdraPA5kDMUqwDO40VsCyXMKaH3jIJu31SqBBkG4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0ZNjAKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114D3C19421;
	Tue, 10 Feb 2026 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770739988;
	bh=8hE9snP3+ieYqJcqiwpH5OZcu+lzf0FjTuv3hDM3yP4=;
	h=From:To:Cc:Subject:Date:From;
	b=U0ZNjAKtqh/nAftx0L7Bt2ylnArp7V5YzHIgEkOuWx4bgruW30KYoa2ofGuSSRZvO
	 GqEGE8i0M9tG8kJUQ13AzUgjsCiMh4dSsfqga0TIo1zdzkke2DeaoHg3I1W8KfY1rq
	 tuW1hhO2zAdEHB0JT8V2Hh4DUFm5BwETwBUVxWfzJNSX9S0JENGQymuCWDL5e/aMRv
	 rOcldQTYUS/C2keIUpZs65qnJC+vtNV/RFUMgy8FosztF+S0PEfklkFn7UhAQZNYVO
	 GRBGrwsewlwt8RKb5UUCQm1FSwk9FrYMfdsBPj89w4qf5lNFyXFqE+Z2gn4Lt3wBic
	 YLk+a7JsyPBeQ==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for the v7.0 merge window
Date: Tue, 10 Feb 2026 11:13:07 -0500
Message-ID: <20260210161307.2356144-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18832-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8943F11CFA0
X-Rspamd-Action: no action

The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.0

for you to fetch changes up to e939bd675634fd52d559b90e2cf58333e16afea8:

  NFSD: Add POSIX ACL file attributes to SUPPATTR bitmasks (2026-01-29 09:48:33 -0500)

----------------------------------------------------------------
NFSD 7.0 Release Notes

Neil Brown and Jeff Layton contributed a dynamic thread pool sizing
mechanism for NFSD. The sunrpc layer now tracks minimum and maximum
thread counts per pool, and NFSD adjusts running thread counts based
on workload: idle threads exit after a timeout when the pool exceeds
its minimum, and new threads spawn automatically when all threads
are busy. Administrators control this behavior via the nfsdctl
netlink interface.

Rick Macklem, FreeBSD NFS maintainer, generously contributed server-
side support for the POSIX ACL extension to NFSv4, as specified in
draft-ietf-nfsv4-posix-acls. This extension allows NFSv4 clients to
get and set POSIX access and default ACLs using native NFSv4
operations, eliminating the need for sideband protocols. The feature
is gated by a Kconfig option since the IETF draft has not yet been
ratified.

Chuck Lever delivered numerous improvements to the xdrgen tool.
Error reporting now covers parsing, AST transformation, and invalid
declarations. Generated enum decoders validate incoming values
against valid enumerator lists. New features include pass-through
line support for embedding C directives in XDR specifications,
16-bit integer types, and program number definitions. Several code
generation issues were also addressed.

When an administrator revokes NFSv4 state for a filesystem via the
unlock_fs interface, ongoing async COPY operations referencing that
filesystem are now cancelled, with CB_OFFLOAD callbacks notifying
affected clients.

The remaining patches in this pull request are clean-ups and minor
optimizations. Sincere thanks to all contributors, reviewers,
testers, and bug reporters who participated in the v7.0 NFSD
development cycle.

----------------------------------------------------------------
Anthony Iliopoulos (2):
      nfsd: never defer requests during idmap lookup
      nfsd: fix return error code for nfsd_map_name_to_[ug]id

Chuck Lever (20):
      NFSD: Clean up nfsd4_check_open_attributes()
      NFSD: Add instructions on how to deal with xdrgen files
      xdrgen: Generate "if" instead of "switch" for boolean union enumerators
      xdrgen: Address some checkpatch whitespace complaints
      xdrgen: Fix struct prefix for typedef types in program wrappers
      xdrgen: Emit the program number definition
      NFS: NFSERR_INVAL is not defined by NFSv2
      xdrgen: Implement short (16-bit) integer types
      xdrgen: Initialize data pointer for zero-length items
      xdrgen: Remove inclusion of nlm4.h header
      xdrgen: Improve parse error reporting
      SUNRPC: auth_gss: fix memory leaks in XDR decoding error paths
      xdrgen: Extend error reporting to AST transformation phase
      xdrgen: Emit a max_arg_sz macro
      xdrgen: Add enum value validation to generated decoders
      nfsd: cancel async COPY operations when admin revokes filesystem state
      xdrgen: Implement pass-through lines in specifications
      NFSD: Add a Kconfig setting to enable support for NFSv4 POSIX ACLs
      Add RPC language definition of NFSv4 POSIX ACL extension
      NFSD: Add POSIX ACL file attributes to SUPPATTR bitmasks

Jeff Layton (10):
      nfsd: prefix notification in nfsd4_finalize_deleg_timestamps() with "nfsd: "
      nfsd: fix nfs4_file refcount leak in nfsd_get_dir_deleg()
      sunrpc: split svc_set_num_threads() into two functions
      sunrpc: remove special handling of NULL pool from svc_start/stop_kthreads()
      sunrpc: track the max number of requested threads in a pool
      sunrpc: introduce the concept of a minimum number of threads per pool
      sunrpc: split new thread creation into a separate function
      sunrpc: allow svc_recv() to return -ETIMEDOUT and -EBUSY
      nfsd: adjust number of running nfsd threads based on activity
      nfsd: add controls to set the minimum number of threads per pool

Khushal Chitturi (1):
      xdrgen: improve error reporting for invalid void declarations

NeilBrown (2):
      locks: ensure vfs_test_lock() never returns FILE_LOCK_DEFERRED
      nfsd: use workqueue enable/disable APIs for v4_end_grace sync

Olga Kornievskaia (1):
      NFSD: fix setting FMODE_NOCMTIME in nfs4_open_delegation

Rick Macklem (9):
      NFSD: Add nfsd4_encode_fattr4_acl_trueform
      NFSD: Add nfsd4_encode_fattr4_acl_trueform_scope
      NFSD: Add nfsd4_encode_fattr4_posix_default_acl
      NFSD: Add nfsd4_encode_fattr4_posix_access_acl
      NFSD: Do not allow NFSv4 (N)VERIFY to check POSIX ACL attributes
      NFSD: Refactor nfsd_setattr()'s ACL error reporting
      NFSD: Add support for XDR decoding POSIX draft ACLs
      NFSD: Add support for POSIX draft ACLs for file creation
      NFSD: Add POSIX draft ACL support to the NFSv4 SETATTR operation

 Documentation/netlink/specs/nfsd.yaml              |   5 +
 Documentation/sunrpc/xdr/nfs4_1.x                  |  61 ++++
 fs/lockd/svc.c                                     |   6 +-
 fs/lockd/svclock.c                                 |   4 -
 fs/locks.c                                         |  17 +-
 fs/nfs/callback.c                                  |  10 +-
 fs/nfsd/Kconfig                                    |  19 ++
 fs/nfsd/Makefile                                   |  10 +-
 fs/nfsd/acl.h                                      |   1 +
 fs/nfsd/netlink.c                                  |   5 +-
 fs/nfsd/netns.h                                    |   7 +-
 fs/nfsd/nfs2acl.c                                  |   2 +-
 fs/nfsd/nfs4acl.c                                  |  17 +-
 fs/nfsd/nfs4idmap.c                                |  52 ++-
 fs/nfsd/nfs4proc.c                                 | 265 ++++++++++++---
 fs/nfsd/nfs4state.c                                |  52 +--
 fs/nfsd/nfs4xdr.c                                  | 363 ++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.c                              | 351 ++++++++++++++++++--
 fs/nfsd/nfs4xdr_gen.h                              |  12 +-
 fs/nfsd/nfsctl.c                                   |   7 +
 fs/nfsd/nfsd.h                                     |  24 +-
 fs/nfsd/nfsproc.c                                  |   2 +-
 fs/nfsd/nfssvc.c                                   |  64 +++-
 fs/nfsd/state.h                                    |   5 +
 fs/nfsd/trace.h                                    |  54 +++
 fs/nfsd/vfs.c                                      |  34 +-
 fs/nfsd/vfs.h                                      |   3 +-
 fs/nfsd/xdr4.h                                     |   7 +
 include/linux/nfs4.h                               |   4 +
 include/linux/sunrpc/svc.h                         |  13 +-
 include/linux/sunrpc/svcsock.h                     |   2 +-
 include/linux/sunrpc/xdrgen/_builtins.h            |  80 ++++-
 include/linux/sunrpc/xdrgen/nfs4_1.h               | 112 ++++++-
 include/uapi/linux/nfs.h                           |   2 +-
 include/uapi/linux/nfsd_netlink.h                  |   1 +
 net/sunrpc/auth_gss/gss_rpc_xdr.c                  |  82 ++++-
 net/sunrpc/svc.c                                   | 216 +++++++-----
 net/sunrpc/svc_xprt.c                              |  51 ++-
 tools/net/sunrpc/xdrgen/README                     |   2 -
 tools/net/sunrpc/xdrgen/generators/__init__.py     |   5 +-
 tools/net/sunrpc/xdrgen/generators/enum.py         |   9 +-
 tools/net/sunrpc/xdrgen/generators/passthru.py     |  26 ++
 tools/net/sunrpc/xdrgen/generators/program.py      |  38 ++-
 tools/net/sunrpc/xdrgen/generators/typedef.py      |   8 +-
 tools/net/sunrpc/xdrgen/generators/union.py        | 115 +++++--
 tools/net/sunrpc/xdrgen/grammars/xdr.lark          |  10 +-
 tools/net/sunrpc/xdrgen/subcmds/declarations.py    |  28 +-
 tools/net/sunrpc/xdrgen/subcmds/definitions.py     |  31 +-
 tools/net/sunrpc/xdrgen/subcmds/lint.py            |  25 +-
 tools/net/sunrpc/xdrgen/subcmds/source.py          |  51 ++-
 .../xdrgen/templates/C/enum/declaration/enum.j2    |   1 -
 .../sunrpc/xdrgen/templates/C/enum/decoder/enum.j2 |  11 +
 .../xdrgen/templates/C/enum/decoder/enum_be.j2     |  20 ++
 .../xdrgen/templates/C/enum/definition/close.j2    |   1 +
 .../xdrgen/templates/C/enum/definition/close_be.j2 |   1 +
 .../xdrgen/templates/C/passthru/definition.j2      |   3 +
 .../sunrpc/xdrgen/templates/C/passthru/source.j2   |   3 +
 .../xdrgen/templates/C/program/decoder/argument.j2 |   4 +
 .../templates/C/program/definition/program.j2      |   5 +
 .../xdrgen/templates/C/program/encoder/result.j2   |   6 +
 .../xdrgen/templates/C/program/maxsize/max_args.j2 |   3 +
 .../sunrpc/xdrgen/templates/C/source_top/client.j2 |   1 -
 .../xdrgen/templates/C/union/decoder/bool_spec.j2  |   7 +
 .../xdrgen/templates/C/union/definition/close.j2   |   1 +
 .../xdrgen/templates/C/union/encoder/bool_spec.j2  |   7 +
 tools/net/sunrpc/xdrgen/xdr_ast.py                 |  49 ++-
 tools/net/sunrpc/xdrgen/xdr_parse.py               | 138 ++++++++
 tools/net/sunrpc/xdrgen/xdrgen                     |   8 +-
 68 files changed, 2267 insertions(+), 372 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/generators/passthru.py
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/passthru/definition.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/passthru/source.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/definition/program.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/program/maxsize/max_args.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/bool_spec.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/bool_spec.j2

