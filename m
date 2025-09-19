Return-Path: <linux-nfs+bounces-14597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3E3B8A00D
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 16:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CAEA7ADE5C
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5A227EA8;
	Fri, 19 Sep 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfRmTwXi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FB314B70
	for <linux-nfs@vger.kernel.org>; Fri, 19 Sep 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292593; cv=none; b=NsRNbaE/Cxf4c07f7hOIiGr1e2zGPSX9rlqd3MNRoM+CXe5Q0yTaKG9QmV8x8F1YTbxYuTwmgIQHv3Q7rafyM8YLAjBY1JLozRsrNEwGVpB+/374xYjxj1WF7SKiJ0FGt3Ttu8/ThlsvxoIbmCkJAkoZProiZy1VThQm+nPFc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292593; c=relaxed/simple;
	bh=liInLsoWIE6qx1sCdUdU4hMKDgOHmifW8W1PuMZ77mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRqbIRduPUhAXrTWFL4n1gYQ6lCwzWygyBuH4W2qwIv2D21UMMVKMadh1U41YT0RHU8ae0ipf73XmQCnjRwnx147T1Vg0mu2L2f4Z/5C+t2XBRexdBsZtzvZ7PMZek9FahZBD9bDwr+gl/g5fO5xTT8KtIApL7eVpGtq0QE5VMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfRmTwXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E689C4CEF0;
	Fri, 19 Sep 2025 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292592;
	bh=liInLsoWIE6qx1sCdUdU4hMKDgOHmifW8W1PuMZ77mk=;
	h=From:To:Cc:Subject:Date:From;
	b=dfRmTwXihbQWKHjrplKWS+dNJ7y729Pesu/2Ql53mWmn2n+PaVtXE9KcgwaOJkHtP
	 AKge5w3rXWsrw4k6YuTczFiaiW+gJem/5ZpAV0ix24zaxxknDM9b/drVo0n8AVa2rG
	 Xy9dangoaU7UJBTYbYimxhyt5M8yqqqCABru4lWeixlwdCUcQxIYy0CzXdZT7fzSKo
	 sID/x1Ye2bUaHw2axhVDvWLLH7NVWwHJpUYBHtRaovOZFeHIR8CVdndVdrvfK9vsYN
	 +X064PU6AgXsBfOeYbSZXqXZaEzNES1/rvNeFJGdvOXBJOqp7yGpYr6lD/oyQaNd06
	 qk0ycMZ7eiDRg==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v11 0/7] NFS Direct: align misaligned DIO for LOCALIO
Date: Fri, 19 Sep 2025 10:36:24 -0400
Message-ID: <20250919143631.44851-1-snitzer@kernel.org>
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
triggers the need to fallback from DIO to buffered IO). I'm happy to
share more specifics on test tools and commandlines if needed.

Changes since v10 (09.17.2025):
- Fixed patch 6's nfstrace.h compiler errors due to #include order in
  nfs2xdr.c
- Rebased patches 2 and 5 to reduce churn/indentation for EINVAL
  error logging.
- Cc Chuck and Jeff for review of patch 2's fs/nfsd/localio.c change
  to add .nfsd_file_dio_alignment callback to nfsd_localio_operations

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
  nfs/localio: refactor iocb initialization
  nfs/localio: add proper O_DIRECT support for READ and WRITE
  nfs/localio: add tracepoints for misaligned DIO READ and WRITE support
  NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support

 fs/nfs/inode.c             |  15 ++
 fs/nfs/internal.h          |  10 +
 fs/nfs/localio.c           | 405 ++++++++++++++++++++++++++++---------
 fs/nfs/nfs2xdr.c           |   2 +-
 fs/nfs/nfs3xdr.c           |   2 +-
 fs/nfs/nfstrace.h          |  76 ++++++-
 fs/nfsd/localio.c          |  11 +
 include/linux/nfslocalio.h |   2 +
 8 files changed, 421 insertions(+), 102 deletions(-)

-- 
2.44.0


