Return-Path: <linux-nfs+bounces-16268-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2716C4EB92
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 16:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712EB4218BE
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B333B6E8;
	Tue, 11 Nov 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln/bS22H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82444328250
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873175; cv=none; b=hjYWFn0rfEyu4FIX8H5gUz0QmBUrJm/cY4gvECqzrd7v0ZD1Zh0jBWW93H91p6mLyJbQersZ+Gbt+far2GR+E/FMeOwgqnV7W6WY5oFUzuFBELYnyU+BAi/FqBk4sTKXlui3df6ZHk8VvMNurL52kYMWNe5zbk9PtfqsXH3NWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873175; c=relaxed/simple;
	bh=gov5bt3uQxcUCmbhTmQjU6XYJltyM+71J4uYk0btSf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8j6eu7L8NVQpAEHrYXNyi3JI9vBakstwTuB0VzL26hobHpIuFxIRGIV7r2B+ArQyr8Ra+pt37Ri38xZoiYVelpNv2ZZGEOTG90LBQk39drEMZJXKNMaxUyS0fKBsbn7V0ZOiml/5JwHbvYGABQkxdZN5OAtDB4tfIT87wMPyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln/bS22H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68325C19421;
	Tue, 11 Nov 2025 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762873175;
	bh=gov5bt3uQxcUCmbhTmQjU6XYJltyM+71J4uYk0btSf4=;
	h=From:To:Cc:Subject:Date:From;
	b=ln/bS22HOr/gGz5pxTcWcCt5N9OG3FI1qLl7uY1RDyyIv4g6bMNwWeA9ocOMuwrLg
	 AFiOhLA5uKqATGlfHU3vlumL4WwSXXRg4uLp0qzYcKnMN1n6MQ0XZQqLNdayrLFSKB
	 PKZOKx1CEjUWW2iJ6Zd0zM7r/5li/Vs1INk6bCjx7DFm58eRifgJFYaIF64bm8tlDm
	 t4HtPqA1VYbJCmqxj3x3lIjod4YmRqRcfGdNViJMTE7aiJxh2BNIKxqPc2km5Rtak7
	 09MUivjgkPecqeClXs0niR8u04iTxNKxvmOogGhVeMXAb00OnTBHyU5bs0HSCh5Tma
	 J3bnlXlaD6ZTg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v12 0/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Tue, 11 Nov 2025 09:59:29 -0500
Message-ID: <20251111145932.23784-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following on https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
this series includes the patches needed to make NFSD Direct WRITE
operational.

I still see this during fstests runs with NFSD_IO_DIRECT enabled:

WARNING: CPU: 5 PID: 1309 at fs/iomap/buffered-io.c:1402 iomap_zero_iter+0x1a4/0x390

No new test failures, but I need to narrow down which test is
triggering this warning.

Applies on the branch:
https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-next


Changes since v11:
* Added trace point to the unaligned write arm
* Reverted to use DONTCACHE on all unaligned writes
* Replaced the comment that mentioned the intent of IOCB_DIRECT

Changes since v10:
* Applied Christoph's clean-ups
* Applied Mike's documentation fixes

Changes since v9:
* Unaligned segments no longer use IOCB_DONTCACHE
* Squashed all review patches into Mike's initial patch
* Squashed Mike's documentation update into the final patch

Changes since v8:
* Drop "NFSD: Handle both offset and memory alignment for direct I/O"
* Include the Sep 3 version of the Documentation update

Changes since v7:
* Rebase the series on Mike's original v3 patch
* Address more review comments
* Optimize the "when can NFSD use IOCB_DIRECT" logic
* Revert the "always promote to FILE_SYNC" logic

Changes since v6:
* Patches to address review comments have been split out
* Refactored the iter initialization code

Changes since v5:
* Add a patch to make FILE_SYNC WRITEs persist timestamps
* Address some of Christoph's review comments
* The svcrdma patch has been dropped until we actually need it

Changes since v4:
* Split out refactoring nfsd_buffered_write() into a separate patch
* Expand patch description of 1/4
* Don't set IOCB_SYNC flag

Changes since v3:
* Address checkpatch.pl nits in 2/3
* Add an untested patch to mark ingress RDMA Read chunks

Chuck Lever (1):
  NFSD: Make FILE_SYNC WRITEs comply with spec

Mike Snitzer (2):
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
  NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst

 .../filesystems/nfs/nfsd-io-modes.rst         | 144 ++++++++++++++++
 fs/nfsd/debugfs.c                             |   1 +
 fs/nfsd/trace.h                               |   2 +
 fs/nfsd/vfs.c                                 | 159 +++++++++++++++++-
 4 files changed, 300 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst

-- 
2.51.0


