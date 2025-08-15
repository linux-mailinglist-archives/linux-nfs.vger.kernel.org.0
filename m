Return-Path: <linux-nfs+bounces-13688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D76B288C0
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9678AAC3E25
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A042D3A80;
	Fri, 15 Aug 2025 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4AfKLZo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B62D3EF9
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300606; cv=none; b=fxkLaUrnCkqiPF7LLwQg4o/45geBMYg4XoxUpkeCUFjxI2fXzesue4bIfW5Cgn7SgwKiXh4gHdSEOfUj6+T2ECdwdjIUTXzXHCBQHrdRkd/uoPJMXLCo9Ckxv+apj42RtSUrx6LPt4QKmugUxhBxnwkmH3B5iSAGCRzasmP33Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300606; c=relaxed/simple;
	bh=ZsbVI1cn+hZ0QxHkph2mGqkPoh6CkvICKCxdltqNeSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBXx3dw4hETKKfQUjS/QISXgUB+h2P7vPUmu2wxhXRbI83Hs4LZxxRrAUs3VPTNuzz7S+3HbXOXZ60M1wWwzRgILMqqTHJpHQJVSg7W62a9vIy01EU2Xvr+CfznijjqveobzVExy+0nIxTmdN0z7flHYjljH+z16eJAQ4RIAWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4AfKLZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E70CC4CEEB;
	Fri, 15 Aug 2025 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300604;
	bh=ZsbVI1cn+hZ0QxHkph2mGqkPoh6CkvICKCxdltqNeSw=;
	h=From:To:Cc:Subject:Date:From;
	b=A4AfKLZoC1S0IiULQ5hSSDh6s6XnUUDYU2ThaAzzUMV+zf5G4fgdq5T61iiHbPUNN
	 KHV9bFhbANTDpOpf9+DnWEqJZL9zqB8SdZU98gNHusrZgUUwuV78jHK6eTmjk5113M
	 aiqXGsjF6v8PoEllo1lcxmSqjt0TtVs7T7C+2DSN0qhcqteJtWCu9n8qScc9vhx5eQ
	 ImQgkhW+PhHAKAzjc1MlWIhjse55XUIDdAybBIPJAISlLRrw+XCnD7htQUF90UhKiz
	 6FjUdqVMYoPNgRo2rM0VwvvQnkR2rWq48jM8S8Po4pMJWnQ7WrIqS47zWCm8xEnR2Z
	 nN9EmlO874LlA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 0/9] NFS DIRECT: align misaligned DIO for LOCALIO
Date: Fri, 15 Aug 2025 19:29:54 -0400
Message-ID: <20250815233003.55071-1-snitzer@kernel.org>
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
available system memory. Enter: NFS DIRECT, which makes it possible to
always enable LOCALIO to use O_DIRECT even if the IO is not
DIO-aligned.

Changes since v7:
- Reinstate use of iov_iter_aligned_bvec in terms of local helper
  nfs}_iov_iter_aligned_bvec().
  - Otherwise LOCALIO could send misaligned DIO to XFS, which would
    rightly respond with -EINVAL.
- Add WARN_ON_ONCE to LOCALIO if XFS returns -EINVAL for misaligned IO.
  - Serves as canary for something that shouldn't ever happen.
- Simplify NFS DIRECT's READ support to not expand the READ with
  DIO-aligned front-pad for a misaligned IO.
  - This ensures symmetry with NFS DIRECT's WRITE support -- so both
    READ and WRITE can have a misaligned head and/or tail for any
    given misaligned DIO. Can backfill expanding READ's head to be
    DIO-aligned in future but in practice the increase in complexity
    isn't worth the risk initially.
- Eliminate LOCALIO's support for falling back to NFSD to handle
  misaligned DIO READs.
  - In practice the extra SUNRPC/XDR work needed to go over the
    network isn't worth it. Especially given that LOCALIO can now
    handle misaligned DIO READs (albeit with a possible misaligned
    head that is issued with buffered IO).

Earlier changelog was provided in v7's 0th patch header, see:
https://lore.kernel.org/linux-nfs/20250805232106.8656-1-snitzer@kernel.org/

All review appreciated, thanks.
Mike

Mike Snitzer (9):
  nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
  nfs/localio: make trace_nfs_local_open_fh more useful
  nfs/localio: avoid issuing misaligned IO using O_DIRECT
  nfs/localio: refactor iocb and iov_iter_bvec initialization
  nfs/localio: refactor iocb initialization
  nfs/direct: add misaligned READ handling
  nfs/direct: add misaligned WRITE handling
  nfs/direct: add tracepoints for misaligned DIO READ and WRITE support
  NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support

 fs/nfs/direct.c            | 133 +++++++++++++++++---
 fs/nfs/inode.c             |  15 +++
 fs/nfs/internal.h          |  13 ++
 fs/nfs/localio.c           | 249 ++++++++++++++++++++++++-------------
 fs/nfs/nfstrace.h          |  64 +++++++++-
 fs/nfs/pagelist.c          |   9 +-
 fs/nfsd/localio.c          |  11 ++
 include/linux/nfs_page.h   |   1 +
 include/linux/nfslocalio.h |   2 +
 9 files changed, 394 insertions(+), 103 deletions(-)

-- 
2.44.0


