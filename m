Return-Path: <linux-nfs+bounces-14441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE368B580FC
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1905B7AB81F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67F978F36;
	Mon, 15 Sep 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGPmF9Br"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1727442
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950877; cv=none; b=IcnSkE48M84zg0KGe2/MeJ3W+vMeft9J50CCEx38T2gZkzMqTxtwfGbZ0ATAPaMqBshdbg0nD7SoB4pTHAQ0Vg4oo0a7CQXNYOL194cSbY7x7ZXos47siLqCvV9dwOMuC6FKPdSNSVfohFsKhZ4iprrtAASVebw+7vPkRODSEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950877; c=relaxed/simple;
	bh=UNurFErihtNBy4mvbfluEw2TnS/JX7L2fHVE/Lmncx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcxI23z1o3KSmSKq28ecbL9cF1asEL/rdWNfDAHYtoq+Rz8p8fAd+zlecX9Ws2JaojGkjzq2O2v9pIIhuOjKXt5FxN4DuuPI/OLOgra3Ot3Hg4QYydmafh1RwZAaTWvtywWVZ80Llcs73dzHK7fq7KDU6h3uh3QpbSQ7qrwS5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGPmF9Br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0687AC4CEF1;
	Mon, 15 Sep 2025 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950877;
	bh=UNurFErihtNBy4mvbfluEw2TnS/JX7L2fHVE/Lmncx8=;
	h=From:To:Cc:Subject:Date:From;
	b=tGPmF9BrYuLerqsqFSgQiMk+BmXYfYdMy+7sDBSCFJvdiJh//V1xpiIuqlinFZAmK
	 E3nV76d8QmYz90gW74wCCJu7E0xdM24HkqqRkYno/Ll9USxASvkQ7wFvBiMu2W0snN
	 dMZ0CNyO8ZfGPY4vs2Yo5TZzYUABtXivLZg/hfj8muMvG7IxRYMSj69VfWmoETuuxC
	 W0yKagWqwwmzxTMs9YaeFwaT4kkhczV32m3VbL+bEse3VHpOIi5nRhltqu5cH0ijNv
	 kDr15JdS0TqMmp+3+1Zukdma/rUtOywIHl9aC8/+tb5WxI5mhjGFmmJRjRv/p++5Dc
	 UqECU1K8UNHIw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 0/7] NFS DIRECT: align misaligned DIO for LOCALIO
Date: Mon, 15 Sep 2025 11:41:08 -0400
Message-ID: <20250915154115.19579-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

NFS and LOCALIO in particular benefit from avoiding the page cache for
workloads that have a working set that is significantly larger than
available system memory. NFS DIRECT makes it possible to always enable
LOCALIO to use O_DIRECT even if the IO is not DIO-aligned.

This patchset's changes are focused on NFS LOCALIO (fs/nfs/localio.c);
as such they will not impact NFS at all unless CONFIG_NFS_LOCALIO=y

Please give this patchset full consideration for merging upstream for
v6.18, I'll fully support this code now, into v6.18-rcX and beyond.

Changes since v8 (08.15.2025):
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


