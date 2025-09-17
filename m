Return-Path: <linux-nfs+bounces-14517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F13B8151A
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1B178BB1
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB1F2BE655;
	Wed, 17 Sep 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbalO1Gc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808334BA33
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133125; cv=none; b=XlZiPu2ITYttJD+9StNYot1pu0TG+pBsuk43Vajm+74xiSJZcFQwuk0txotiF+X9oY1FalNKkzpeM+C2QKH6qLCoeWLgM3X69dT60jUKIxFZbGTUN5xBZ56yoHCh8goj3oRt3SUBmHpNWnMzQk1fXHELfRDsAJ6DFtcoA/Gy+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133125; c=relaxed/simple;
	bh=Im2tgSXfsZeL5tu34JXKQygjg5/kh9skgMUrvx/sIbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKlNT4Zeh1KfhbMoM3iHJ4tGQWrVH20xzQn5t+BtVY0v5pzraPk8jDr7F/ZjB6EJQl8BtJFY2Xx82W1LqRf9XQI4aR8U/GEmq7M0nmy1O1hDZWV2DVo15Rk9ncT7yi0MBk/5seUfysqw+zIwUhksLBq2rQ7XXhO8Bc3FWLSMyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbalO1Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E7CC4CEE7;
	Wed, 17 Sep 2025 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758133124;
	bh=Im2tgSXfsZeL5tu34JXKQygjg5/kh9skgMUrvx/sIbw=;
	h=From:To:Cc:Subject:Date:From;
	b=dbalO1Gctx6epGX+Y/DlaK5KG6i6o5AhZkG8SBhhxJl5zLcpfuNkk52v5nPlkbDSL
	 YVo2+m7O4EuONlfSeDW1hGPGtd8f/ToQYQDTmesxSeMB4XlpS87z08dDkmrxcvJEcl
	 tSB7h5IeISWYniM+k5SHkjHJk8m7bfZjtCzEOs8rSrq+Vmhs/uiRh3q0JbEpL/GcA7
	 jp7EaRilgREUb0UnQxHHi6OZxb8Fu0ZzIZCxBw+Y4Ku7+dymCXWRJOy9Ro30ygjS64
	 31d7VU0b1rQ2HKZuCaFlQ2kvvIToLcGRK8PE6hcXVraHtXw3CY3jbX+jbRr4xaDlh1
	 zyxcciQdB0r1w==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v10 0/7] NFS Direct: align misaligned DIO for LOCALIO
Date: Wed, 17 Sep 2025 14:18:36 -0400
Message-ID: <20250917181843.33865-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anna,

NFS and LOCALIO in particular benefit from avoiding the page cache for
workloads that have a working set that is significantly larger than
available system memory. NFS DIRECT makes it possible to always enable
LOCALIO to use O_DIRECT even if the IO is not DIO-aligned.

This patchset's changes are focused on NFS LOCALIO (fs/nfs/localio.c);
as such they will not impact NFS at all unless CONFIG_NFS_LOCALIO=y

These changes have been tested quite a lot, using workloads from load
generators fio and dt. But also using MLperf benchmark suite's npz
loader library (written in python) that creates a particularly nasty
1MB IO pattern which is DIO-aligned on disk but _not_ in memory (so it
triggers the need to fallback from DIO to buffered IO). I'd be happy
to share more specifics on test tools and commandlines if needed.

Please give this patchset full consideration for merging upstream for
v6.18, I'll fully support this code now, into v6.18-rcX and beyond.

Changes since v9 (09.15.2025):
- Updated patch 3 to make bvec init while loop similar to
  nfsd_iter_read()
- To support both sync and async completion of DIO (sync completion
  will happen if underlying driver is ramdisk, etc): push DIO's
  nfs_local_pgio_done() down from nfs_local_{read,write}_done to
  nfs_local_{read,write}_aio_complete

Changes since v8 (08.15.2025)
- Removed all fs/nfs/direct.c changes and pushed this misaligned DIO
  handling down to LOCALIO where it belongs.
- Updated all commit headers to reflect changes to code.
- Because misaligned DIO is now handled properly in LOCALIO, removed
  the nfs modparam 'localio_O_DIRECT_semantics' that was added during
  v6.14 to require users opt-in to the requirement that all O_DIRECT
  be properly DIO-aligned.
- Enhanced LOCALIO's DIO WRITE code to handle potential for VFS to
  return -ENOTBLK if it fails to invalidate page cache on WRITE.
- Verified various test IO workloads function as expected; including a
  misaligned DIO test that failed with the previous v8 direct.c
  implementation.
- Verified performance remains high with LOCALIO on fast NVMe.
- Verified sparse and checkpatch.pl are clean.

Earlier changelog was provided in v8's 0th patch header, see:
https://lore.kernel.org/linux-nfs/20250815233003.55071-1-snitzer@kernel.org/

All review appreciated, thanks.
Mike

Mike Snitzer (7):
  nfs/localio: make trace_nfs_local_open_fh more useful
  nfs/localio: avoid issuing misaligned IO using O_DIRECT
  nfs/localio: refactor iocb and iov_iter_bvec initialization
  nfs/localio: refactor iocb initialization further
  nfs/localio: add proper O_DIRECT support for READ and WRITE
  nfs/localio: add tracepoints for misaligned DIO READ and WRITE support
  NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support

 fs/nfs/inode.c             |  15 ++
 fs/nfs/internal.h          |  10 +
 fs/nfs/localio.c           | 411 ++++++++++++++++++++++++++++---------
 fs/nfs/nfs3xdr.c           |   2 +-
 fs/nfs/nfstrace.h          |  76 ++++++-
 fs/nfsd/localio.c          |  11 +
 include/linux/nfslocalio.h |   2 +
 7 files changed, 426 insertions(+), 101 deletions(-)

-- 
2.44.0





--------

Mike Snitzer (7):
  nfs/localio: make trace_nfs_local_open_fh more useful
  nfs/localio: avoid issuing misaligned IO using O_DIRECT
  nfs/localio: refactor iocb and iov_iter_bvec initialization
  nfs/localio: refactor iocb initialization
  nfs/localio: add proper O_DIRECT support for READ and WRITE
  nfs/localio: add tracepoints for misaligned DIO READ and WRITE support
  NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support

 fs/nfs/inode.c             |  15 ++
 fs/nfs/internal.h          |  10 +
 fs/nfs/localio.c           | 407 ++++++++++++++++++++++++++++---------
 fs/nfs/nfs3xdr.c           |   2 +-
 fs/nfs/nfstrace.h          |  76 ++++++-
 fs/nfsd/localio.c          |  11 +
 include/linux/nfslocalio.h |   2 +
 7 files changed, 422 insertions(+), 101 deletions(-)

-- 
2.44.0


