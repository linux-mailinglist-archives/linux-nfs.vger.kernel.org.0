Return-Path: <linux-nfs+bounces-22794-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OBaxEFHkOmpQKQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22794-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 21:53:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF986B9CAD
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 21:53:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ANgvOhT3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22794-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22794-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A143010518
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167553939B0;
	Tue, 23 Jun 2026 19:53:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881430BF4E
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 19:53:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244398; cv=none; b=beCgD7g/a4TSSldxVzl+iblLijBB75208qFVk8l3UpZTO5iFtfyW5jqWgu0Ssn715JRK1r7wgwdWQbybnEMx/GfINC5viakczsqd7666rN/K3uC0zxEyv7F4FRUdpq750BrbQR+x0dQElGg3Nj8T2zNKEzheQr4eHPvXMWHcLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244398; c=relaxed/simple;
	bh=X0FJkl+KP6KfbIYIEk0fjKFYXLrPVaz95pCLItWYeqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKulw1e63rjjWN2PLGII8Y9OoSop0hVTxIp1yYRBApKr1ZFjQ9kdZhCQFkkNx4S5w45BUDzhrO8dlQJiWro/10lEuFQ715IhOigoO3Iq4TKWBmer9HIOJL2+r/aiig1QMh9QK4HAUUdtIC3Sp9jVqq6qB/fAUKrDGy/eSFJQu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANgvOhT3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AE51F000E9;
	Tue, 23 Jun 2026 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244396;
	bh=vANMcY22F0kokrXbwM1vo2J77fJa3gvQY2tNcZ653Q8=;
	h=From:To:Cc:Subject:Date;
	b=ANgvOhT3/34Jpsp4d7wCDVEArBgRBxea2v8nLbxTEMyUi5LUTo6v4hQIbRuYxJOX+
	 mY8mFhFbFEDhpmrb0HyvnyQQrkXRn0EsAuu3U3N3XZjgK2TjI1zWWzvR6dDMSjoi6P
	 a+XiVTYGcG6cn8Ktfmwz1/7GsvphdDMK1q7oAhliT2XSyc9jH03wJq7/gJwpTetrfK
	 Hd3w9JMyYj+jj3O9MeEsDUucjIvkoVZYU7VtWT3w8uMu6ob8vW5qoVCn158899QAEZ
	 yddw8wiN2dAew9STH/OZABUY0ZeOstrGrkdUREp5RWT7fjgmT/t4CD4rWtwB8S3RcH
	 MTuUSp9NaUOmQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 7.2
Date: Tue, 23 Jun 2026 15:53:15 -0400
Message-ID: <20260623195315.829881-1-anna@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:torvalds@linux-foundation.org,m:anna@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22794-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EF986B9CAD

Hi Linus,

The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48:

  Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.2-1

for you to fetch changes up to 284ea3fb4f6715201e1d9ef3474c25e817ad70e9:

  NFS: Use common error handling code in nfs_alloc_server() (2026-06-17 14:07:09 -0400)

----------------------------------------------------------------
NFS Client Updates for Linux 7.2

New Features:
 * XPRTRDMA: Decouple req recycling from RPC completion
 * NFS: Expose FMODE_NOWAIT for read-only files

Bugfixes:
 * SUNRPC: Fix sunrpc sysfs error handling
 * SUNRPC: Fix uninitialized xprt_create_args structure
 * XPRTRDMA: Harden connect and reply handling
 * NFS: Fix EOF updates after fallocate/zero-range
 * NFS: Keep PG_UPTODATE clear after read errors in page groups
 * NFS: Use nfsi->rwsem to protect traversal of the file lock list
 * NFS: Prevent resource leak in nfs_alloc_server()
 * NFSv4: Clear exception state on successful mkdir retry
 * NFSv4: Don't skip revalidate when holding a dir delegation and attrs are stale
 * pNFS: Fix use-after-free in pnfs_update_layout()
 * pNFS: Defer return_range callbacks until after inode unlock
 * pNFS: Fix LAYOUTCOMMIT retry loop on OLD_STATEID
 * pNFS: Reject zero-length r_addr in nfs4_decode_mp_ds_addr
 * NFS/flexfiles: Reject zero-length filehandle version arrays
 * NFS/flexfiles: Fix checking if a layout is striped
 * NFS/flexfiles: Fixes for honoring FF_FLAGS_NO_IO_THRU_MDS

Other Cleanups and Improvements:
 * Remove the fileid field from struct nfs_inode
 * Move long-delayed xprtrdma work onto the system_dfl_long_wq
 * Convert xprtrdma send buffer free list to an llist
 * Show "<redacted>" for cert_serial and privkey_serial mount options

 Thanks,
 Anna

----------------------------------------------------------------
Chris Mason (3):
      xprtrdma: Fix ep kref imbalance on ADDR_CHANGE
      xprtrdma: Initialize re_id before removal registration
      xprtrdma: Fix bcall rep leak and unbounded peek

Chuck Lever (13):
      xprtrdma: Use sendctx DMA state for Send signaling
      xprtrdma: Decouple req recycling from RPC completion
      xprtrdma: Add request-pool slack for delayed recycling
      xprtrdma: Clear receive-side ownership pointers on release
      xprtrdma: Document and assert reply-handler invariants
      xprtrdma: Fix I3 invariant comment in rpcrdma_complete_rqst
      xprtrdma: Remove tautological I2 assertion in rpcrdma_reply_put
      xprtrdma: Convert send buffer free list to llist
      xprtrdma: Check frwr_wp_create() during connect
      xprtrdma: Resize reply buffers before reposting receives
      xprtrdma: Sanitize the reply credit grant after parsing
      xprtrdma: Repost Receive buffers for malformed replies
      xprtrdma: Return sendctx slot after Send preparation failure

Clark Wang (1):
      nfs: keep PG_UPTODATE clear after read errors in page groups

Dai Ngo (2):
      NFS: fix eof updates after NFSv4.2 fallocate/zero-range
      NFSv4/pnfs: defer return_range callbacks until after inode unlock

Dylan Yudaken (2):
      nfs: add nowait version of nfs_start_io_direct
      nfs: expose FMODE_NOWAIT for read-only files

Ethan Nelson-Moore (1):
      NFS: correct CONFIG_NFS_V4 macro name in #endif comment

Hongling Zeng (2):
      sunrpc: Fix error handling in rpc_sysfs_xprt_switch_add_xprt_store()
      sunrpc: fix uninitialized xprt_create_args structure

Igor Raits (1):
      NFSv4: clear exception state on successful mkdir retry

Jeff Layton (4):
      nfs: store the full NFS fileid in inode->i_ino
      nfs: remove nfs_compat_user_ino64() and deprecate enable_ino64
      nfs: replace NFS_FILEID() and nfsi->fileid with inode->i_ino
      nfs: remove fileid field from struct nfs_inode

Lei Yin (1):
      NFSv4.1/pNFS: fix LAYOUTCOMMIT retry loop on OLD_STATEID

Marco Crivellari (1):
      xprtrdma: Move long delayed work on system_dfl_long_wq

Markus Elfring (2):
      NFS: Prevent resource leak in nfs_alloc_server()
      NFS: Use common error handling code in nfs_alloc_server()

Michael Bommarito (2):
      NFSv4/flexfiles: reject zero filehandle version count
      NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr

Mike Snitzer (2):
      NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS on fatal DS connect errors
      NFSv4/flexfiles: honor FF_FLAGS_NO_IO_THRU_MDS in pg_get_mirror_count_write

Sagi Grimberg (2):
      pNFS/filelayout: fix cheking if a layout is striped
      NFS: show redacted cert_serial and privkey_serial in mount options

Tom Haynes (1):
      nfs: don't skip revalidate on directory delegation when attrs flagged stale

Wentao Liang (1):
      pNFS: Fix use-after-free in pnfs_update_layout()

Yang Erkun (1):
      nfs: use nfsi->rwsem to protect traversal of the file lock list

 Documentation/admin-guide/kernel-parameters.txt |   7 -
 fs/nfs/callback_proc.c                          |   9 +-
 fs/nfs/client.c                                 |  14 +-
 fs/nfs/delegation.c                             |   9 +-
 fs/nfs/dir.c                                    |   6 +-
 fs/nfs/direct.c                                 |  12 +-
 fs/nfs/export.c                                 |   6 +-
 fs/nfs/file.c                                   |  16 +-
 fs/nfs/filelayout/filelayout.c                  |   6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c          |  39 ++++-
 fs/nfs/flexfilelayout/flexfilelayout.h          |  16 ++
 fs/nfs/inode.c                                  |  90 ++++--------
 fs/nfs/internal.h                               |   1 +
 fs/nfs/io.c                                     |  41 ++++++
 fs/nfs/nfs42proc.c                              |  15 +-
 fs/nfs/nfs4proc.c                               |  63 ++++++--
 fs/nfs/nfs4trace.h                              |  79 +++++-----
 fs/nfs/nfstrace.h                               |  84 +++++------
 fs/nfs/pagelist.c                               |   2 +-
 fs/nfs/pnfs.c                                   |   8 +-
 fs/nfs/pnfs_nfs.c                               |   4 +-
 fs/nfs/read.c                                   |  25 +++-
 fs/nfs/super.c                                  |   4 +
 fs/nfs/unlink.c                                 |   2 +-
 fs/nfs/write.c                                  |   2 +-
 include/linux/nfs_fs.h                          |  25 ----
 include/linux/nfs_page.h                        |   1 +
 include/linux/nfs_xdr.h                         |   1 -
 net/sunrpc/sysfs.c                              |   4 +-
 net/sunrpc/xprtrdma/backchannel.c               |   5 +-
 net/sunrpc/xprtrdma/frwr_ops.c                  |   2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c                  | 161 ++++++++++++++------
 net/sunrpc/xprtrdma/transport.c                 |  71 +++++++--
 net/sunrpc/xprtrdma/verbs.c                     | 187 ++++++++++++++++++++----
 net/sunrpc/xprtrdma/xprt_rdma.h                 |  12 +-
 35 files changed, 703 insertions(+), 326 deletions(-)

