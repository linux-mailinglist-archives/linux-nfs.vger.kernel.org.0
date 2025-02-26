Return-Path: <linux-nfs+bounces-10369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AF5A4667E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 17:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDCE1616A9
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE121D580;
	Wed, 26 Feb 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5yWVfge"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE472206A9
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585511; cv=none; b=OpJVoSq6xH17ejPLfjwSaT1snziLk3v72vUfwmLdS0L6t7Teotcn8EDk5cPFmuoWVRoT5GgkWf/dISavAdw0Hvf/56MitGgEUXoqRgJ1vC1IL1601ie9666FRZFM2bqMkgHOSTvvSnOc58+Mx4lSyjvUGpSQHCKmJDx0V9UBOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585511; c=relaxed/simple;
	bh=VPBbHB+bWgbMIvLLNoEfVFL+I7hj52O9p9SkstEiegw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUaUprmjXvWgvjvWRWcXQaqKrWKz7ax8Lt8QW3UZlRms+9GLio6+dV1QuIlUQjydYZwfWLRTZv4nWrzkMFAOYYphLM0uuRjzStWIG40en5vq5gL3IpVhKa6g+zpZ5d/EsrvE1MyZDurrG2sV4rOEe2ArDU3WBCCAcH5t2EyHkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5yWVfge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949A5C4CEE4;
	Wed, 26 Feb 2025 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740585510;
	bh=VPBbHB+bWgbMIvLLNoEfVFL+I7hj52O9p9SkstEiegw=;
	h=From:To:Cc:Subject:Date:From;
	b=O5yWVfgezsmDz9jXVlRkwSiFcoUArr3JmEdYSz6hzoERP0RK2vCBHuq02ebMLgRil
	 w50GgzC/ENdQfEj0uSF3AqCbvEI+BlEcD/HxAPVKMnGxvZV58Wb1nQpEbLIivWTZ7B
	 ZjRpndgnSILpREMmKn8QrWvsa84CFVckoQ5A9t6oKgTy0vY90kQKgw63SVHaW+fqL1
	 bArqxWsY3jaHw09iv0yb6kAopc0CsUnLxcXTuo3PbisM4FfaaDZy96sXnUBM4h7+2X
	 X9WCT1znaOzVulZT0gSkhEhjj6GDJxra7zoXjYf796yOUvfoqUfnJtqjie5eZVQKFP
	 wrBvqx+aEwe/w==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 6.14-rc
Date: Wed, 26 Feb 2025 10:58:29 -0500
Message-ID: <20250226155829.134451-1-anna@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.14-2

for you to fetch changes up to 9084ed79ddaaaa1ec01cd304af9fb532c26252db:

  lsm,nfs: fix memory leak of lsm_context (2025-02-25 15:07:24 -0500)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.14-rc

Stable Fixes:
  * O_DIRECT writes should adjust file length

Other Bugfixes:
  * Adjust delegated timestamps for O_DIRECT reads and writes
  * Prevent looping due to rpc_signal_task() races
  * Fix a deadlock when recovering state on a sillyrenamed file
  * Properly handle -ETIMEDOUT errors from tlshd
  * Suppress build warnings for unused procfs functions
  * Fix memory leak of lsm_contexts

Thanks,
Anna

----------------------------------------------------------------
Arnd Bergmann (1):
      sunrpc: suppress warnings for unused procfs functions

Benjamin Coddington (1):
      SUNRPC: Handle -ETIMEDOUT return from tlshd

Stephen Smalley (1):
      lsm,nfs: fix memory leak of lsm_context

Trond Myklebust (4):
      NFS: O_DIRECT writes must check and adjust the file length
      NFS: Adjust delegated timestamps for O_DIRECT reads and writes
      SUNRPC: Prevent looping due to rpc_signal_task() races
      NFSv4: Fix a deadlock when recovering state on a sillyrenamed file

 fs/nfs/delegation.c           | 37 +++++++++++++++++++++++++++++++++++++
 fs/nfs/delegation.h           |  1 +
 fs/nfs/direct.c               | 23 +++++++++++++++++++++++
 fs/nfs/nfs4proc.c             | 10 +++++++---
 include/linux/nfs4.h          |  1 +
 include/linux/sunrpc/sched.h  |  3 +--
 include/trace/events/sunrpc.h |  3 +--
 net/sunrpc/cache.c            | 10 +++-------
 net/sunrpc/sched.c            |  2 --
 net/sunrpc/xprtsock.c         | 10 +++++++++-
 10 files changed, 83 insertions(+), 17 deletions(-)

