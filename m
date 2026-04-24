Return-Path: <linux-nfs+bounces-21082-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OKcBlfX62lISAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21082-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 22:49:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FBF46353E
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 22:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E4DE300C3BE
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2026 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25236E48C;
	Fri, 24 Apr 2026 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxAIhyq1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86803D6475;
	Fri, 24 Apr 2026 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063728; cv=none; b=jfR4BB8wpb/fONgz9p9RF/J3fbA7mztV/WU5lKmO3VJbkzmZGk60jbfu9Zj9c+pi3A4qgA5XxDPuezfP5laD+lB53iuVRGfP1L+lM3acD/Y8AJWuOtVyH4O7MhS7mAIcSPodbeqfrso4/F+8swXhdmqmxMjVHEcBZahUVE0I+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063728; c=relaxed/simple;
	bh=v4UuaV/bAc8W8+bGECZ6/nCpwAwlg20G3osw1jo77eI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=o7PWPe7tjmDoYD85QLJQeodfebzRl/Oy1ipvrhAgMp6k6T01E6JtpsABNt4tW3bDeR9LsJfR5oX40qlfdy22WrJ8DsVtBxSc9coY8irxcV4a/Y7NzRdek184uEwyOr047M4oi+T7NE5DhQ2IhVq1+eRq00xIzbjBac0WOryHUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxAIhyq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33316C19425;
	Fri, 24 Apr 2026 20:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063727;
	bh=v4UuaV/bAc8W8+bGECZ6/nCpwAwlg20G3osw1jo77eI=;
	h=Subject:From:To:Cc:Date:From;
	b=ZxAIhyq1AwWFt/IrF4M5xR79g4sN530C8KYJrcIg13iWBX3byiXdZSI5gw5jyH4CC
	 V3zhxOV9ywAQNF3dzGeE7gCkPWvFy21cLG0PpU2sxvvIZLn5w50/wDF3tBOSZQt1M/
	 cXihUwq63wzWkCONhMeavScPvy9vXrfA5oe7KYXI8fDe95M2fWP/OMKweFy/TpAV4m
	 CFKu/x+Au8VwMvwm1rT/oi6+K9JQL01XOQaDMoNQkePfti1ium+HJeRT8vrSKWbVMR
	 X2wt9CcKnBVqKXRqXYJl8lX4hAMbJ/FBHSH4E3L2eh3+fdP5yf8cXb3NgyALyPxj6e
	 Ogh85T7QQ977A==
Message-ID: <b54851930d1daf66fabe718d0a02df850047ecd8.camel@kernel.org>
Subject: [GIT PULL] Please pull NFS client updates for Linux 7.1
From: Trond Myklebust <trondmy@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Apr 2026 16:48:45 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 16FBF46353E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21082-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hi Linus,

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8=
:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-7.1-1

for you to fetch changes up to e6614b88d59d110ee1a80ed0826e34f24dd35c96:

  NFS: Fix RCU dereference of cl_xprt in nfs_compare_super_address (2026-04=
-22 08:53:23 -0400)

----------------------------------------------------------------
NFS client updates for Linux 7.1

Highlights include:

Bugfixes:
- NFS: Fix handling of ENOSPC so that if we have to resend writes, they
  are written synchronously.
- SUNRPC: RDMA transport fixes from Chuck
- NFSv4.2: Several fixes for delegated timestamps
- NFSv4: Failure to obtain a directory delegation should not cause
  stat() to fail.
- NFSv4: Rename was failing to update timestamps when a directory
  delegation is held.
- NFSv4: Ensure we check rsize/wsize after crossing a NFSv4 filesystem
  boundary.
- NFSv4/pnfs: If the server is down, retry the layout returns on reboot
- NFSv4/pnfs: Fallback to MDS could result in a short write being
  incorrectly logged.

Cleanups:
- NFS: use memcpy_and_pad in decode_fh

----------------------------------------------------------------
Christoph Hellwig (1):
      NFS/blocklayout: print each device used for SCSI layouts

Chuck Lever (7):
      xprtrdma: Close sendctx get/put race that can block a transport
      xprtrdma: Avoid 250 ms delay on backlog wakeup
      xprtrdma: Close lost-wakeup race in xprt_rdma_alloc_slot
      xprtrdma: Decouple frwr_wp_create from frwr_map
      xprtrdma: Replace rpcrdma_mr_seg with xdr_buf cursor
      xprtrdma: Scale receive batch size with credit window
      xprtrdma: Post receive buffers after RPC completion

Jeff Layton (2):
      nfs: fix utimensat() for atime with delegated timestamps
      nfs: update inode ctime after removexattr operation

Jenny Guanni Qu (1):
      pnfs/flexfiles: validate ds_versions_cnt is non-zero

Olga Kornievskaia (5):
      NFS: improve "Server wrote zero bytes" error
      NFS: fix RENAME attr in presence of directory delegations
      NFSv4: retry GETATTR if GET_DIR_DELEGATION failed
      NFS: fix writeback in presence of errors
      NFSv4.2: fix CLONE/COPY attrs in presence of delegated attributes

Sean Chang (2):
      NFS: remove redundant __private attribute from nfs_page_class
      NFS: Fix RCU dereference of cl_xprt in nfs_compare_super_address

Thorsten Blum (1):
      nfs: use memcpy_and_pad in decode_fh

Trond Myklebust (1):
      NFSv4/pnfs: If the server is down, retry the layout returns on reboot

Tushar Sariya (1):
      NFSv4.1: Apply session size limits on clone path

 fs/nfs/blocklayout/dev.c                  |   7 +-
 fs/nfs/callback_xdr.c                     |   3 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   5 +
 fs/nfs/inode.c                            |  12 +-
 fs/nfs/internal.h                         |   2 +
 fs/nfs/localio.c                          |  15 ++-
 fs/nfs/nfs42proc.c                        |  19 +++-
 fs/nfs/nfs42xdr.c                         |  10 +-
 fs/nfs/nfs4client.c                       |   4 +-
 fs/nfs/nfs4proc.c                         |  42 +++++--
 fs/nfs/nfstrace.h                         |   2 +-
 fs/nfs/pagelist.c                         |   3 +
 fs/nfs/pnfs.c                             |  22 +++-
 fs/nfs/super.c                            |  16 ++-
 fs/nfs/write.c                            |  11 +-
 include/linux/nfs_fs.h                    |   1 +
 include/linux/nfs_xdr.h                   |   3 +
 include/linux/sunrpc/xprt.h               |   2 +
 include/trace/events/rpcrdma.h            |  28 ++---
 net/sunrpc/xprt.c                         |  16 +++
 net/sunrpc/xprtrdma/frwr_ops.c            | 179 ++++++++++++++++++++++++--=
----
 net/sunrpc/xprtrdma/rpc_rdma.c            | 177 +++++++++++---------------=
---
 net/sunrpc/xprtrdma/transport.c           |  17 ++-
 net/sunrpc/xprtrdma/verbs.c               |  19 +++-
 net/sunrpc/xprtrdma/xprt_rdma.h           |  43 ++++---
 25 files changed, 443 insertions(+), 215 deletions(-)

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

