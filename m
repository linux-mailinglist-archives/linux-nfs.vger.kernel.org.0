Return-Path: <linux-nfs+bounces-16186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0EC4099A
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDE51A4452A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE22DF143;
	Fri,  7 Nov 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTXn9JGs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9372239E7F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529666; cv=none; b=j+Dkmscwp3v707leYsHOAsuzQ/7h4q4bb6BuIeWjAKFDlpBsKy6vv8mvVDEvFd6z04HLcDfa0oN5tmVaL8WT7Yiby3qWGVe92yA9ieFQTZiBov+Gh1jIl0iCzfBgPXiWL6kLSOPzwCdv5xtTYYQuMum/9ym5ZC/BLaT5TAvVw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529666; c=relaxed/simple;
	bh=+nF/f2j7sxPxH8iCe/mnKTrMBRXmTkzHrtdzsO1/L/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoYYHhX3U4YmTHvbClZQJbgLNPKwbzEKd+fD4CLN3OYRLBkh1N9MXkZNbFUh0LoJ4eTCi8sGSmbFo1uQ1o1qOGqgHszeiMXtoA7Zqh0Ji0HNayjNylLQkV7hUg0XeEV4VexYumfb0v0RK6Drec1fXu2uhI6IlOXKCHVdZimkSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTXn9JGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC7CC16AAE;
	Fri,  7 Nov 2025 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762529666;
	bh=+nF/f2j7sxPxH8iCe/mnKTrMBRXmTkzHrtdzsO1/L/0=;
	h=From:To:Cc:Subject:Date:From;
	b=nTXn9JGsSL+/dMOuc0gfa5Vu/ueV7/InE2vJYW1LWAQEj0M5IPaLfczWTNF5NLHZo
	 NVHdh6SiglSdENomRaESYVHEuO6HjSLcb04Hgg3v98rATE6+iH0aK9DCRoh0aK4vlL
	 fp3fuPWoSfGVTkatUsCtFafJzgF6Nu053HTKErr+zfDYevWu2hDrWGqM0cuzeMPDv7
	 kYC9Xh89l89uGkd5haaA3AGQMrw5iRoeazm33+oJEKvbBGD7rWUtEt4qNjG+0n0Niw
	 3JPBH2MBQ0L05SBjdzosE1dxv4+1LTHkGq2n0U4kHg/ANI+W246lgymC3QRjrQn2ic
	 MsWu58KYm8NNA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v11 0/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Fri,  7 Nov 2025 10:34:19 -0500
Message-ID: <20251107153422.4373-1-cel@kernel.org>
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

After applying Christoph's patch, I looked at restoring the comment
block in front of iov_iter_bvec_offset(), but it seems to make
slightly more sense to leave it where it is in
nfsd_write_dio_iters_init().

I'm still looking into Neil's comment about adding a trace point
for unaligned segments.

One controversy remains: Whether to set DONTCACHE for the unaligned
segments.

I still see this during fstests runs with NFSD_IO_DIRECT enabled:

WARNING: CPU: 5 PID: 1309 at fs/iomap/buffered-io.c:1402 iomap_zero_iter+0x1a4/0x390

No new test failures, but I need to narrow down which test is
triggering this message.

Applies on: 7f7d8421c7fa2588930146cb461e3e069658ced9
In the branch https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-testing


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
 fs/nfsd/trace.h                               |   1 +
 fs/nfsd/vfs.c                                 | 154 +++++++++++++++++-
 4 files changed, 294 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst

-- 
2.51.0


