Return-Path: <linux-nfs+bounces-17285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A273BCD9D66
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA90530B9CB3
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751C29C351;
	Tue, 23 Dec 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt4jWtqi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB612989B0;
	Tue, 23 Dec 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766504216; cv=none; b=a9eRlxnX1Mtt5xNfWDaq+81+1+DD/45bsDEwq/5e2ZrVxzCMY/C2cFcWSB+nR/KpbZW3QCyp7rlNPjFhQQzcOFAI+ZD4elvc3ZPuSasOq9+7gghFhf6p1lcID02UXwNyKSsU3QQMfWulyfzUfQhW2HqTlguPkEIJ5PxOlR1lULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766504216; c=relaxed/simple;
	bh=4xskZ9sB23i7wc0gJ92xb+416qmEl58GferQz5RhbkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nhf2v18Drq3+m4g1X4/UFjScGoWD8ATV0AvPLqBxnVbGEkGJWwDUyZjGZUDfYK6ZOK9MTBRRmJzonfan51Vp9LJReoxteePhlVfQapzSq1d0VtaGIt9qC/LBurvva7MoIVOin0L/ts2vf1WI/+TzOQaGbVBw/CNFF8na1utke1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt4jWtqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F1C116C6;
	Tue, 23 Dec 2025 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766504215;
	bh=4xskZ9sB23i7wc0gJ92xb+416qmEl58GferQz5RhbkM=;
	h=From:To:Cc:Subject:Date:From;
	b=lt4jWtqiSJj9rFCqBKl3vb5tvzKVLXkI8QF7aDDknde/rwF506cHsGorUV5VkE+4Z
	 1nvXGvAqTupFLsYdpi5BJZhY02GoFRaWEsJuYW13hreGnXbEytgt0EpstLs84YVL+n
	 I6bO0hVbKiJFuk+n9K4R7xuukX2s04ePt+cwZsinlH8lLLcjyVBiGP0sxfHw33bS39
	 Oa9PPtPSSjnRIFUw2x8AOqoENcrMaMCKyzyWWV6pYVsMzjlzt7mc4ujbgiv7YxjUuq
	 gCIX2xSjmUKPIStOhECHINmJM34ASe5zaa5beRSGTKGc45sQ0q5jFDACyo55Y3hJyF
	 2UyB4Rju/zfuw==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD fixes for v6.19
Date: Tue, 23 Dec 2025 10:36:54 -0500
Message-ID: <20251223153654.1650936-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit df8c841dd92a7f262ad4fa649aa493b181e02812:

  NFSD: nfsd-io-modes: Separate lists (2025-12-03 09:05:14 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-1

for you to fetch changes up to 913f7cf77bf14c13cfea70e89bcb6d0b22239562:

  NFSD: NFSv4 file creation neglects setting ACL (2025-12-18 11:19:11 -0500)

----------------------------------------------------------------
nfsd-6.19 fixes:

A set of NFSD fixes that arrived just a bit late for the 6.19 merge
window.

Issues reported with v6.19-rc:
- Mark variable __maybe_unused to avoid W=1 build break

Issues that need expedient stable backports:
- NFSv4 file creation neglects setting ACL
- Clear TIME_DELEG in the suppattr_exclcreat bitmap
- Clear SECLABEL in the suppattr_exclcreat bitmap
- Fix memory leak in nfsd_create_serv error paths
- Bound check rq_pages index in inline path
- Return 0 on success from svc_rdma_copy_inline_range
- Use rc_pageoff for memcpy byte offset
- Avoid NULL deref on zero length gss_token in gss_read_proxy_verf

----------------------------------------------------------------
Andy Shevchenko (1):
      nfsd: Mark variable __maybe_unused to avoid W=1 build break

Chuck Lever (3):
      NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
      NFSD: Clear TIME_DELEG in the suppattr_exclcreat bitmap
      NFSD: NFSv4 file creation neglects setting ACL

Joshua Rogers (4):
      SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
      svcrdma: use rc_pageoff for memcpy byte offset
      svcrdma: return 0 on success from svc_rdma_copy_inline_range
      svcrdma: bound check rq_pages index in inline path

Shardul Bankar (1):
      nfsd: fix memory leak in nfsd_create_serv error paths

 fs/nfsd/export.c                  | 2 +-
 fs/nfsd/nfs4xdr.c                 | 5 +++++
 fs/nfsd/nfsd.h                    | 8 +++++++-
 fs/nfsd/nfssvc.c                  | 5 ++++-
 fs/nfsd/vfs.h                     | 3 ++-
 net/sunrpc/auth_gss/svcauth_gss.c | 3 ++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 7 +++++--
 7 files changed, 26 insertions(+), 7 deletions(-)

