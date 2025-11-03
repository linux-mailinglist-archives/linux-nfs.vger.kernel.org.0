Return-Path: <linux-nfs+bounces-15934-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B494C2D472
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBA2188C559
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF9A3101C2;
	Mon,  3 Nov 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4u1KlmW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACED305068
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188834; cv=none; b=g3FfNXY0FHX4gZjOwsbapYsfq+im13ETXAf8N73EDPbCo/QP7zYg4gwlk+UIR3O9gFtDcMCszB2XcGJZvpEwhBbqBG/cQzx/5X/P6ZzUztIPUHBCX7gAcCgOShJyVTA3JWEAlxLrAlylXqy/VbpQZQsNmII4vXLJDm0biWbEOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188834; c=relaxed/simple;
	bh=xHvKNuNkYPl8J/4AtuDaO2i4mG3oGX8NrDuWNSARV04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9+4IHqBG0pzXwVio6y3m7KFRHGr8Ke8kDz7+QOyBtQqIkFgo+f6zO4Us8ZWIZZKwJ/FsGmOhh36SHrUjlxqSNJiuC2IFYRhTPOY9SAyTaIlwr/qyDIqV3AP22qwdYc+VuyebEEBp/wl0QdYQQUwfkXqBFKJaxbp1kFkQ99Ijwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4u1KlmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D8C4CEE7;
	Mon,  3 Nov 2025 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188834;
	bh=xHvKNuNkYPl8J/4AtuDaO2i4mG3oGX8NrDuWNSARV04=;
	h=From:To:Cc:Subject:Date:From;
	b=c4u1KlmWUMUXllh5SKpHMNIUwKZArJfCWO965nstmyUprDkSpNFqUTn2baqkGX8ua
	 TchXMworX1631HN6LgxZUl10NiHuyrFOZ/Kc4CqSAjOVekLlFKkDyWFtq0ZwHnFWb7
	 lwkCgU7w0BFgXsr4KjNkv4gSyP2oM3pZeqQEUwfH8WGJvTd938oJ6DN9fdat4bPAgE
	 I8DvPJKLRcgZUJ9Nva7L9GmMlT4QiemcRGfUuzS/Cp00E+fk7drDER0IFLUAULcaAe
	 /cqTTK6o5iadXC7rGOSQG/S+1vHRXPo6I5qbJg90ve5U8/YbVVfbD3gLRzDmGQjSbJ
	 /98jEOrNGHz2Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v9 00/12] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Mon,  3 Nov 2025 11:53:39 -0500
Message-ID: <20251103165351.10261-1-cel@kernel.org>
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

The Documentation update is taken verbatim from Mike's Sep 3 series.
The document refers to NFSD_IO_DIRECT as working in an "uncached"
mode, but it doesn't explain how UNSTABLE works with NFSD_IO_DIRECT
(why a subsequent COMMIT is still required for durability). And IMO,
it needs a more thorough explanation of "Linux memory management's
page reclaim scalability problems". I prefer a brief root-cause
analysis here rather than a reference to a video or a benchmark
result.

I think the functional code changes come pretty close to what we've
agreed to so far, however. I dropped one R-b due to significant
mechanical changes in that patch.

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

Chuck Lever (10):
  NFSD: Make FILE_SYNC WRITEs comply with spec
  NFSD: Enable return of an updated stable_how to NFS clients
  NFSD: Remove specific error handling
  NFSD: Remove alignment size checking
  NFSD: Clean up struct nfsd_write_dio
  NFSD: Introduce struct nfsd_write_dio_seg
  NFSD: Simplify nfsd_iov_iter_aligned_bvec()
  NFSD: Combine direct I/O feasibility check with iterator setup
  NFSD: Handle kiocb->ki_flags correctly
  NFSD: Refactor nfsd_vfs_write

Mike Snitzer (2):
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
  NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst

 .../filesystems/nfs/nfsd-io-modes.rst         | 144 +++++++++++++
 fs/nfsd/debugfs.c                             |   1 +
 fs/nfsd/nfs3proc.c                            |   2 +-
 fs/nfsd/nfs4proc.c                            |   2 +-
 fs/nfsd/nfsproc.c                             |   3 +-
 fs/nfsd/trace.h                               |   1 +
 fs/nfsd/vfs.c                                 | 199 +++++++++++++++++-
 fs/nfsd/vfs.h                                 |   6 +-
 fs/nfsd/xdr3.h                                |   2 +-
 9 files changed, 343 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst

-- 
2.51.0


