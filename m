Return-Path: <linux-nfs+bounces-17498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5D2CF9403
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127FB30821BF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2DB33BBD1;
	Tue,  6 Jan 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd8Nng+4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761733B96E;
	Tue,  6 Jan 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715144; cv=none; b=QXhs96TPwi95DtklaM9Kb+BiR9zjCZGuldqwfDJ7L7G1pWZBz1v+uwIxrG8H8IGBkSZhQeO5yPd4qlXkx+npbUQAWuXMyCdBcXUmZJYa7fIoggmWhk10OZrZIerR/NcpFw93ck6UW2eLmjECiS+G3q3CXrsDaAfLDZpOORgq6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715144; c=relaxed/simple;
	bh=KjGEd0zmSPos0i2P7QN71+lD2YODwZ0rImgauuhA72o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xxcc54sMhl8z6U+8jMSSiPYeRXYD2p9gyblt1ZLkLz19Hp3eymMYNc8jw3mKs9s3+Nu7BXNDjGoOjKgHFfUaAp7HU1cuuqgcaY4GOB3sIJjMa3YRn3fKfdvRFZGNOOavIpAVIIfZ5S6fuLlNEXcLC/Xe7+fjElNcUG28S7BPxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd8Nng+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E85C116C6;
	Tue,  6 Jan 2026 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767715144;
	bh=KjGEd0zmSPos0i2P7QN71+lD2YODwZ0rImgauuhA72o=;
	h=From:To:Cc:Subject:Date:From;
	b=Cd8Nng+4iy6JY2o1wWjxb5xWGGVqzhLbA0ggM6Ulfy/FRJJHI6yROIbiJ5XwIUUYe
	 wPjeVPoKgiR4o1kS7uayYqad2r/6sgZJs8M4IJ0Ct2d4DHG0bCLW4EYpRwoyFrLeRm
	 KbZhHkxfr3o0HAbOQaNGYnu0Pyn7BaRLWfjZYf9wze6tCJevhiw+wA26uoLqtjJjUH
	 1tZSNCYIZhnrk3fYGbReOE5zqUN77LS6XWBeJalN1W+bIjmHpQKZarat22/PyJ5QMd
	 gq4qnBTIbmAxr2peUUXFuPWRuBlxctmzr4wi3UbInjZORMF46VAJfSD5v25r3vvxC+
	 aQ8dafOpKQv2g==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] Third round of fixes for NFSD (6.19)
Date: Tue,  6 Jan 2026 10:59:02 -0500
Message-ID: <20260106155902.3706718-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1f941b2c23fd34c6f3b76d36f9d0a2528fa92b8f:

  nfsd: Drop the client reference in client_states_open() (2025-12-24 21:33:12 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-3

for you to fetch changes up to 0b88bfa42e5468baff71909c2f324a495318532b:

  NFSD: net ref data still needs to be freed even if net hasn't startup (2026-01-02 13:50:14 -0500)

----------------------------------------------------------------
nfsd-6.19 fixes:

A set of NFSD fixes that arrived after the 6.19 merge window.

Issues that need expedient stable backports:
- Remove an invalid NFS status code
- Fix an fstests failure when using pNFS
- Fix a UAF in v4_end_grace()
- Fix the administrative interface used to revoke NFSv4 state
- Fix a memory leak reported by syzbot

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Remove NFSERR_EAGAIN

Edward Adam Davis (1):
      NFSD: net ref data still needs to be freed even if net hasn't startup

NeilBrown (2):
      nfsd: provide locking for v4_end_grace
      nfsd: use correct loop termination in nfsd4_revoke_states()

Olga Kornievskaia (1):
      nfsd: check that server is running in unlock_filesystem

Scott Mayhew (1):
      NFSD: Fix permission check for read access to executable-only files

 fs/nfs_common/common.c   |  1 -
 fs/nfsd/netns.h          |  2 ++
 fs/nfsd/nfs4proc.c       |  2 +-
 fs/nfsd/nfs4state.c      | 49 ++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/nfsctl.c         | 12 +++++++++---
 fs/nfsd/nfsd.h           |  1 -
 fs/nfsd/nfssvc.c         | 28 +++++++++++++--------------
 fs/nfsd/state.h          |  6 +++---
 fs/nfsd/vfs.c            |  4 ++--
 include/trace/misc/nfs.h |  2 --
 include/uapi/linux/nfs.h |  1 -
 11 files changed, 74 insertions(+), 34 deletions(-)

