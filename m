Return-Path: <linux-nfs+bounces-17364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB06CEB014
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C80703009240
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 01:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7066C2D77E5;
	Wed, 31 Dec 2025 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH5HdtW5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C202D592E;
	Wed, 31 Dec 2025 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767145220; cv=none; b=HM6tLqKuTTvqIWmecihdRGvs/jyQg+xpI0pHjm+9VAe2M+ZYwfTE3JvCkt7CKm4a3ax0De5Dp1GCcA6FWn3ZwccYltm6TXp7se/3kkPAKkPhN+BVFHjamikZ2KHkLxwubRkb4JVIwgjfkqWE9tbYL3AoCGg4k4olhkGOTOzu2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767145220; c=relaxed/simple;
	bh=K21ek2NGsbvUG71baaR/ZsC/6OCfNmTq/pwToSDPgnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVg0jFO2IHfL0rr/XV94aYSu7JKQpstCPt1Lw3+6pqSQLN8iTpL0AoAqCvoBxmf6pMHDSpz/MXnAKSb3w2FA9hEh7HjSKVpTrfCtO6c85zR2X3U62TJKPplSuKB9QpeQUwUGunLHp6b6kKQ7Q4FW0X/9Cdnzv0iixM3fwvRlgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH5HdtW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2E5C116C6;
	Wed, 31 Dec 2025 01:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767145219;
	bh=K21ek2NGsbvUG71baaR/ZsC/6OCfNmTq/pwToSDPgnA=;
	h=From:To:Cc:Subject:Date:From;
	b=pH5HdtW5Jea/yVhjZHbnOZtsGiEkGxH4oP21I1ckIv+bTus8wYvZsyU5PZ1mT6yMu
	 Modq/eMuo9Z0pnNkDP886rv3BFWk97X9BBjt9BOeOYn/6vpxBJdkYUIBd0/O4JXogZ
	 MFoar+Qu6yGNIOJfbFoY01HMOXHJaMFTfEyONwqn2POF6ettCWQbCUKYT+Rdtk02c9
	 2yOJx9L6O88gw/o2R81X0k/jMcaZX/MZQ6rt5QWhLnoLZN71zzTM5IPa5lTsK4zz0x
	 +8ajyhOJOW2UH0NX8ec3YTe/iSeO8MiQji39eFSfrZIjnNu8MRuUfneV1D+5yh7Eu0
	 Nz9JYWhSOhuOg==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] More NFSD fixes for v6.19-rc
Date: Tue, 30 Dec 2025 20:40:18 -0500
Message-ID: <20251231014018.2635778-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 913f7cf77bf14c13cfea70e89bcb6d0b22239562:

  NFSD: NFSv4 file creation neglects setting ACL (2025-12-18 11:19:11 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-2

for you to fetch changes up to 1f941b2c23fd34c6f3b76d36f9d0a2528fa92b8f:

  nfsd: Drop the client reference in client_states_open() (2025-12-24 21:33:12 -0500)

----------------------------------------------------------------
nfsd-6.19 fixes:

A set of NFSD fixes that arrived just a bit late for the 6.19 merge
window.

Issues reported with v6.19-rc:
- Avoid unnecessarily breaking a timestamp delegation

Issues that need expedient stable backports:
- Fix a crasher in nlm4svc_proc_test()
- Fix nfsd_file reference leak during write delegation
- Fix error flow in client_states_open()

----------------------------------------------------------------
Chuck Lever (1):
      nfsd: fix nfsd_file reference leak in nfsd4_add_rdaccess_to_wrdeleg()

Haoxiang Li (1):
      nfsd: Drop the client reference in client_states_open()

Jeff Layton (1):
      nfsd: use ATTR_DELEG in nfsd4_finalize_deleg_timestamps()

NeilBrown (1):
      lockd: fix vfs_test_lock() calls

 fs/lockd/svc4proc.c |  4 +---
 fs/lockd/svclock.c  | 21 ++++++++++++---------
 fs/lockd/svcproc.c  |  5 +----
 fs/locks.c          | 12 ++++++++++--
 fs/nfsd/nfs4state.c | 20 ++++++++++++++------
 5 files changed, 38 insertions(+), 24 deletions(-)

