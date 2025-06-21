Return-Path: <linux-nfs+bounces-12607-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992CAE29C1
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B996B3B926D
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853B13C81B;
	Sat, 21 Jun 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm7EGMgs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023EC2E0;
	Sat, 21 Jun 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750518823; cv=none; b=S4OTkohSqb3bpGlmgOWMkUkbkkxW0n0X8Q90DESqGGh3kFf0fL/LVvuhjIx+sAK7ThODaIp+l9CdkzwNVQZjllQIDlDl34hiyj5EMojOcay8BxoHnchImuiQ2yPDkKuUKOVpEHNwEWipiP/UvlUPMIApaAjvmeU+OofGJLcb3NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750518823; c=relaxed/simple;
	bh=i5wqI008MJuV9pDmuCckzYYxukm/wwBTLtaZLeZMBeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8oPvU9PQ7bPe9r61qXPGBtTA1b5h3USJ23nPPn/i8uE5gGjf36pHmcer9c3TWJNDUB8UaF9bFX/esrig1TCtIPuIqBci7umg0RS0YKv6vXRmNNI4xNZV51lQ/5Zo9N2BHNF0bhuPMDTdSVs2ok3QQww4NjVAH6xdD8mO9wJlLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm7EGMgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FFCC4CEE7;
	Sat, 21 Jun 2025 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750518821;
	bh=i5wqI008MJuV9pDmuCckzYYxukm/wwBTLtaZLeZMBeM=;
	h=From:To:Cc:Subject:Date:From;
	b=jm7EGMgsI5SzdR8yilgT5cT40HUjZpUfQJo4X7QRzYyHzxu4A6m+ZauKy1Yo0OqBq
	 1KMJxnoDR7AOsCWy5rAzPvVwScs78rjBmSYZIA9/7TxOjkzig3Ut22oiI9nW2Qs9dR
	 vxlXjobI7+lIF4Q8ZCAW6XpR6FxVuGkehaWbErLhvvh/rFBVaSkp7hS0GmH84qOjGU
	 RmqPW4rkAk2K1hoEw5jhB5XOzNZHeWHGjz4FAZMEjfKP6PR161MsY9RMjRphbDl3Cp
	 c3SX/HbK30xNxf0x8KBHNnHrphcT6Ctt27WtKwIUNVNlO5aT8gyUmU75IEfWUz/QfX
	 tJFl4vcFzkM8Q==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	jeft@web.codeaurora.org
Subject: [GIT PULL] First round of NFSD fixes for v6.16
Date: Sat, 21 Jun 2025 11:13:40 -0400
Message-ID: <20250621151340.499111-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 425364dc49f050b6008b43408aa96d42105a9c1d:

  xdrgen: Fix code generated for counted arrays (2025-05-16 10:58:48 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.16-1

for you to fetch changes up to 94d10a4dba0bc482f2b01e39f06d5513d0f75742:

  sunrpc: handle SVC_GARBAGE during svc auth processing as auth error (2025-06-19 09:35:45 -0400)

----------------------------------------------------------------
nfsd-6.16 fixes:

- Two fixes for commits in the nfsd-6.16 merge
- One fix for the recently-added NFSD netlink facility
- One fix for a remote SunRPC crasher

----------------------------------------------------------------
Benjamin Coddington (1):
      SUNRPC: Cleanup/fix initial rq_pages allocation

Chuck Lever (1):
      NFSD: Avoid corruption of a referring call list

Jeff Layton (2):
      nfsd: use threads array as-is in netlink interface
      sunrpc: handle SVC_GARBAGE during svc auth processing as auth error

 fs/nfsd/nfs4callback.c |  1 +
 fs/nfsd/nfsctl.c       |  5 ++---
 net/sunrpc/svc.c       | 17 +++--------------
 3 files changed, 6 insertions(+), 17 deletions(-)

