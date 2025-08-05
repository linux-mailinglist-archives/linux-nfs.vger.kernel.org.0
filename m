Return-Path: <linux-nfs+bounces-13447-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA4B1BD06
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A63818A43C4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB506291C1B;
	Tue,  5 Aug 2025 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULefpqDr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776B20B7ED
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436068; cv=none; b=qFGe/LV3WH3tbMUTEzrwK2sILrLEsQTBQqrDvO9cgKm7qBly9nhkbpfNme0sEvHFjfWZnl8ue0sm5qsLXd5b57FpoXwImY/GhRjw/DDNFVNov23bZWUGOvT3lLL9/WlfsGNIFrAuWwl96v9N+xkxpaXKcR8NJHyblVNU3sT8zi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436068; c=relaxed/simple;
	bh=DQmBELO01jSHyUBl2NJB7doge2pqct6BSxgLxWNPDA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMCt3Dp6/zBKPY73roVnEyl8A4zEdlqODdi5tQb09bgX26AZqkhhJOJvTO3AvKn8ubNeiWKcRjKnvSg/LyQKhtE5fniS5a92jWGilgr8VTazlWAA+DeSOkbV9HAXAHF97p912LU7QKWJa0ZZXhtI1nrFIXj2UdBeLl2e55QHTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULefpqDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41B3C4CEF0;
	Tue,  5 Aug 2025 23:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436068;
	bh=DQmBELO01jSHyUBl2NJB7doge2pqct6BSxgLxWNPDA4=;
	h=From:To:Cc:Subject:Date:From;
	b=ULefpqDrHe7FjS3AKoOCRoXCUslr9Slt3IPFegKIewjVYhlvBd+GskG05C4Bj6iBQ
	 jJwhbZJVi8kKtUm2J84jXh0TMH5rmvde5tSmPTdKV1G83eoYJEJ5xAmc6bgI/XyjmL
	 SouSp9uykf2Bp9QBKJMyVYP6rAMg0NlCmYYSULmSXO+AP5z8Ehow1z8s8zer27pQCw
	 q7Vffkj4//DBVX61/gVZP50V3QBCcAkjOZMeDVosQYRSxLz5963COjgo9TCLmFRaTW
	 Q3jvACYCksXU2fhqfsAQpEnPq2LwEN1U1InEuD+IofgPG3O2BH3se5btlKBH34O3sX
	 72DHQppdHAJAQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 00/11] NFS DIRECT: align misaligned DIO for LOCALIO
Date: Tue,  5 Aug 2025 19:20:55 -0400
Message-ID: <20250805232106.8656-1-snitzer@kernel.org>
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

Changes since v6:
- Include Trond's 3 LOCALIO fixes that seem to have been forgotten;
  not related to rest of this patchset other than LOCALIO related.
- Patch 4 is a LOCALIO fix that should be picked up for 6.17 too.
- Update LOCALIO to not use iov_iter_is_aligned() because it will
  soon be removed upstream.
- Add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support

Changes since v5:
- I split the NFS changes back out for v6 since the NFSD DIRECT
  changes have started to land in nfsd-testing
- With the benefit of having updated the NFSD trace points to use an
  EVENT_CLASS I have now updated NFS's equivalents to also use one.
- Updated patch headers.
- Patches 4 and 5, while not strictly needed, are "nice to have"
  because they evolve the NFS LOCALIO code to a better place.

All review appreciated, thanks.
Mike

Mike Snitzer (8):
  nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
  nfs/localio: make trace_nfs_local_open_fh more useful
  nfs/localio: add nfsd_file_dio_alignment
  nfs/localio: refactor iocb initialization
  nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
  nfs/direct: add misaligned READ handling
  nfs/direct: add misaligned WRITE handling
  NFS: add basic STATX_DIOALIGN and STATX_DIO_READ_ALIGN support

Trond Myklebust (3):
  NFS/localio: nfs_close_local_fh() fix check for file closed
  NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
  NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file

 fs/nfs/direct.c            | 258 ++++++++++++++++++++++++++++++++++---
 fs/nfs/inode.c             |  15 +++
 fs/nfs/internal.h          |  17 ++-
 fs/nfs/localio.c           | 232 +++++++++++++++++++++------------
 fs/nfs/nfstrace.h          |  64 ++++++++-
 fs/nfs/pagelist.c          |  22 +++-
 fs/nfs_common/nfslocalio.c |  28 ++--
 fs/nfsd/localio.c          |  11 ++
 include/linux/nfs_page.h   |   1 +
 include/linux/nfslocalio.h |   2 +
 10 files changed, 529 insertions(+), 121 deletions(-)

-- 
2.44.0


