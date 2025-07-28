Return-Path: <linux-nfs+bounces-13290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B8BB13D2A
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CB73AE1EE
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA322260C;
	Mon, 28 Jul 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Muy8J/6/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76267944F;
	Mon, 28 Jul 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713036; cv=none; b=C9r29/fsnKxyUJdRb6OjLt9FPMKrBE/GZaRKVhQnixucFo6dv00YOeCqBaYPZvWl/jxk4DNs90Weu+GRxwTrj7JKg3gMx37qzWnw2QueN8AliTrdb0crMLQTcVxrki/kQ8/GKxuWZonTGoxSMxrvYo64wsaFrh0aYhp0Z1SEggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713036; c=relaxed/simple;
	bh=RuC5Q1mW4T9AJ+bufHiWxQmW+y+CvWAKnVIcpkxRlSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSl68JKZeq61ZBL4Ry1pPjWPvQU6k07uLCgiwb6Pw8WhkBNOs/6vHlHJEGKrTs4JqfhiqJJRD03icR84OVtOJeLbDYRMOhhZH7UWya2UPQyVf2VQE1KqDxPRkR6QrpOsuqwLXBcJTtVt1XtQBkbzl+Fsx2VPt5r8O70KVi5FXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Muy8J/6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACC0C4CEE7;
	Mon, 28 Jul 2025 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753713035;
	bh=RuC5Q1mW4T9AJ+bufHiWxQmW+y+CvWAKnVIcpkxRlSc=;
	h=From:To:Cc:Subject:Date:From;
	b=Muy8J/6/aERmHrdANO/EodSdcVtBoA8q0GzseBMTRUfVWsVY69MZJVv7nvJ7sGaIL
	 dLSPEIg36Zpj2QtAMelOA6NEuoGxH8SXb5RZxGPIBcX0O2zKGrzsGkrnHq5blZjy63
	 KBVKO0qSgV10qgrZtnbegJztGamYcnfWnVaFlXnPg0PCEUF58K/Cwbr7OuewaJUzfr
	 yDo7d8D1Hg+6kGUultHPcjp5goewjbtLAYEPIbeWBk6G/cnxfZZcrvTGe9NDXDHE4G
	 3MRqDvbDyIiOVe4Cqan2bZatD9hLdbX/7HgItLO5bjy/CZmykeBhrj8hBDdEL+mojV
	 xDNy+7Wvw8LDQ==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for v6.17
Date: Mon, 28 Jul 2025 10:30:33 -0400
Message-ID: <20250728143033.70585-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.17

for you to fetch changes up to e339967eecf1305557f7c697e1bc10b5cc495454:

  nfsd: Drop dprintk in blocklayout xdr functions (2025-07-14 12:46:50 -0400)

----------------------------------------------------------------
NFSD 6.17 Release Notes

NFSD is finally able to offer write delegations to clients that open
files with O_WRONLY, thanks to patches from Dai Ngo. We're expecting
this to accelerate a few interesting corner cases.

The cap on the number of operations per NFSv4 COMPOUND has been
lifted. Now, clients that send COMPOUNDs containing dozens of
operations (for example, a long stream of LOOKUP operations to walk
a pathname in a single round trip) will no longer be rejected.

This release re-enables the ability for NFSD to perform NFSv4.2 COPY
operations asynchronously. This feature has been disabled to
mitigate the risk of denial-of-service when too many such requests
arrive.

Many thanks to the contributors, reviewers, testers, and bug
reporters who participated during the v6.17 development cycle.

----------------------------------------------------------------
Christoph Hellwig (3):
      sunrpc: simplify xdr_init_encode_pages
      sunrpc: simplify xdr_partial_copy_from_skb
      sunrpc: unexport csum_partial_copy_to_xdr

Chuck Lever (14):
      NFSD: Rename a function parameter
      NFSD: Make nfsd_genl_rqstp::rq_ops array best-effort
      NFSD: Remove the cap on number of operations per NFSv4 COMPOUND
      NFSD: Remove definition for trace_nfsd_file_unhash_and_queue
      NFSD: Remove definitions for unused trace_nfsd_file_lru trace points
      NFSD: Remove definition for trace_nfsd_file_gc_recent
      NFSD: Remove definition for trace_nfsd_ctl_maxconn
      NFSD: Clean up kdoc for nfsd_file_put_local()
      NFSD: Clean up kdoc for nfsd_open_local_fh()
      NFSD: Use vfs_iocb_iter_read()
      NFSD: Use vfs_iocb_iter_write()
      Revert "NFSD: Force all NFSv4.2 COPY requests to be synchronous"
      NFSD: Access a knfsd_fh's fsid by pointer
      NFSD: Simplify struct knfsd_fh

Dai Ngo (3):
      NFSD: Offer write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
      NFSD: release read access of nfs4_file when a write delegation is returned
      NFSD: detect mismatch of file handle and delegation stateid in OPEN op

Gustavo A. R. Silva (1):
      NFSD: Avoid multiple -Wflex-array-member-not-at-end warnings

Jeff Layton (8):
      sunrpc: new tracepoints around svc thread wakeups
      nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()
      sunrpc: fix handling of unknown auth status codes
      sunrpc: remove SVC_SYSERR
      sunrpc: reset rq_accept_statp when starting a new RPC
      sunrpc: return better error in svcauth_gss_accept() on alloc failure
      sunrpc: rearrange struct svc_rqst for fewer cachelines
      sunrpc: make svc_tcp_sendmsg() take a signed sentp pointer

Sergey Bashirov (2):
      nfsd: Use correct error code when decoding extents
      nfsd: Drop dprintk in blocklayout xdr functions

Su Hui (1):
      nfsd: Change the type of ek_fsidtype from int to u8 and use kstrtou8

 fs/nfsd/blocklayout.c             |  20 +++--
 fs/nfsd/blocklayoutxdr.c          | 111 +++++++++++++++-----------
 fs/nfsd/blocklayoutxdr.h          |   8 +-
 fs/nfsd/export.c                  |   8 +-
 fs/nfsd/export.h                  |   2 +-
 fs/nfsd/filecache.c               |   2 +-
 fs/nfsd/localio.c                 |   2 +-
 fs/nfsd/nfs3proc.c                |   2 +-
 fs/nfsd/nfs4layouts.c             |   4 +-
 fs/nfsd/nfs4proc.c                |  21 +----
 fs/nfsd/nfs4state.c               | 119 ++++++++++++++++++++--------
 fs/nfsd/nfs4xdr.c                 |   4 +-
 fs/nfsd/nfsctl.c                  |  31 ++++----
 fs/nfsd/nfsd.h                    |   6 +-
 fs/nfsd/nfsfh.c                   |  16 ++--
 fs/nfsd/nfsfh.h                   |  26 +++---
 fs/nfsd/nfsproc.c                 |   2 +-
 fs/nfsd/state.h                   |   1 +
 fs/nfsd/trace.h                   |  27 +------
 fs/nfsd/vfs.c                     |  17 ++--
 fs/nfsd/xdr4.h                    |   1 -
 include/linux/sunrpc/msg_prot.h   |  18 +++--
 include/linux/sunrpc/svc.h        |   6 +-
 include/linux/sunrpc/svcauth.h    |   1 -
 include/linux/sunrpc/xdr.h        |   5 +-
 include/trace/events/sunrpc.h     |  25 ++++--
 net/sunrpc/auth_gss/svcauth_gss.c |   3 +-
 net/sunrpc/socklib.c              | 162 ++++++++++++++------------------------
 net/sunrpc/svc.c                  |  20 +++--
 net/sunrpc/svcsock.c              |   5 +-
 net/sunrpc/xdr.c                  |  11 +--
 31 files changed, 340 insertions(+), 346 deletions(-)

