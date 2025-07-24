Return-Path: <linux-nfs+bounces-13229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C42AB111BC
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846E43AF9B0
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2816B21B192;
	Thu, 24 Jul 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDRtJZAw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1C2EE28B
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385464; cv=none; b=tJX7fEKOoWTVzuMOW2DZUhMxnZeikmPDUa1eB3Yl3qr8b4IvbkcfiCvyEO1XicDvfVzPK7M8Ggnvc7m17qwa1dWSBK6qpl8ElCy/eUe+KOz+ZnH/Di7Yyrbv6QyXkrmiStOooUrz7rocoIWXCFQVruYKPFP9GueNSvm6Btiag0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385464; c=relaxed/simple;
	bh=VEK70GT4K1VNFIJD4RuPK2bQQ7LPAZKySVJu6PqeTg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqZ9LZt2KN5PUmQTCzPtEODQJQ61zJcc+VVWB8UyqQaD1Dq4NcgOoKk9vVSzSZfb7PdeFO0Wrh8Duo9pYABjw9RW6EkkaZUGsyrxaZfYpZUt+gRja/AGQSd/LeXQjc4lOmb194dIRNXO5Eb0c29CWjk3GH3vhu3QdP62fDAulIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDRtJZAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F94C4CEED;
	Thu, 24 Jul 2025 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385463;
	bh=VEK70GT4K1VNFIJD4RuPK2bQQ7LPAZKySVJu6PqeTg0=;
	h=From:To:Cc:Subject:Date:From;
	b=JDRtJZAwDnkGzougq9gmPSZARl3zZHNnIoSq2xTYgq0+8+LzMsZJg1d3Vc8vkJw9a
	 vbURDdKaHmzifcXShtyTo+6XoR/csoHKD0VmpL13KGmol0huoGjEoNoS8TenNcT6aj
	 LhdtkgUYaeQ6F1MIBkdMjL5h0MGSZsTgLEbQQ4D6UMQaiBtfsvzNZl2E/SzbeoVhmq
	 C57jHC/7zNUKav5KLkEayjFPzbql9z/BezWcfrFUvG0QLbSvMCw9EGyQAC8exeUVRr
	 mKpoL8faX4J0UubmWPK/wtM2eC4/UxOePna6IZxGxEgup/Ep1ZBRx2zfJcA94nVYTT
	 1wTo39j+qDqDw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 00/13] NFSD DIRECT and NFS DIRECT
Date: Thu, 24 Jul 2025 15:30:49 -0400
Message-ID: <20250724193102.65111-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some workloads benefit from NFSD avoiding the page cache, particularly
those with a working set that is significantly larger than available
system memory.  This patchset introduces _optional_ support to
configure the use of O_DIRECT or DONTCACHE for NFSD's READ and WRITE
support.  The NFSD default to use page cache is left unchanged.

The performance win associated with using NFSD DIRECT was previously
summarized here:
https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
This picture offers a nice summary of performance gains:
https://original.art/NFSD_direct_vs_buffered_IO.jpg

Similarly, NFS and LOCALIO in particular also benefit from avoiding
the page cache for workloads that have a working set that is
significantly larger than available system memory. Enter: NFS DIRECT,
which makes it possible to always enable LOCALIO to use O_DIRECT even
if the IO is not DIO-aligned.

For this v5 I've combined the NFSD and NFSD patchsets because the NFS
changes do depend on the the NFSD changes.  In addition, I think it
makes sense to review/test these changes together.

I'm sharing these again now, soon after posting the NFSD and NFS
updates, to hopefully make it clear where the code stands. Thanks to
Chuck's feedback I have kept the patch "NFSD: issue READs using
O_DIRECT even if IO is misaligned" (and will now finish NFSD's
misaligned WRITE handling, splitting IO to misaligned head and/or tail
and DIO-aligned middle, and will include in the next version of this
patchset -- probably mid next week).

New changes in this v5:
- Combine NFSD DIRECT and NFS DIRECT patches into single patchset.
- Fix a "nsfd" typo in a variable of the NFSD io_cache_read patch that
  was masked because the later " NFSD: issue READs using O_DIRECT even
  if IO is misaligned" patch fixed it.
- Properly include the "NFSD: filecache: only get DIO alignment
  attrs if NFSD_IO_DIRECT enabled" in the patch series.
- Optimize NFS DIRECT's misaligned READ and WRITE support to return
  early if IO irreparably misaligned or already DIO-aligned.  

Thanks,
Mike

Mike Snitzer (13):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()
  NFSD: add io_cache_read controls to debugfs interface
  NFSD: add io_cache_write controls to debugfs interface
  NFSD: filecache: only get DIO alignment attrs if NFSD_IO_DIRECT enabled
  NFSD: issue READs using O_DIRECT even if IO is misaligned
  nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
  nfs/localio: make trace_nfs_local_open_fh more useful
  nfs/localio: add nfsd_file_dio_alignment
  nfs/localio: refactor iocb initialization
  nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
  nfs/direct: add misaligned READ handling
  nfs/direct: add misaligned WRITE handling

 fs/nfs/direct.c                        | 262 +++++++++++++++++++++++--
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/internal.h                      |  17 +-
 fs/nfs/localio.c                       | 231 ++++++++++++++--------
 fs/nfs/nfstrace.h                      |  47 ++++-
 fs/nfs/pagelist.c                      |  22 ++-
 fs/nfsd/debugfs.c                      | 102 ++++++++++
 fs/nfsd/filecache.c                    |  36 ++++
 fs/nfsd/filecache.h                    |   4 +
 fs/nfsd/localio.c                      |  11 ++
 fs/nfsd/nfs4xdr.c                      |   8 +-
 fs/nfsd/nfsd.h                         |  10 +
 fs/nfsd/nfsfh.c                        |   4 +
 fs/nfsd/trace.h                        |  37 ++++
 fs/nfsd/vfs.c                          | 200 +++++++++++++++++--
 fs/nfsd/vfs.h                          |   2 +-
 include/linux/nfs_page.h               |   1 +
 include/linux/nfslocalio.h             |   2 +
 include/linux/sunrpc/svc.h             |   5 +-
 19 files changed, 875 insertions(+), 127 deletions(-)

-- 
2.44.0


