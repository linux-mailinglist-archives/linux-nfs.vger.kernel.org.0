Return-Path: <linux-nfs+bounces-14015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A12B42B4D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649ED167652
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB62DCF73;
	Wed,  3 Sep 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuCZRSyg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58D292B44
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932683; cv=none; b=GjgQVVrXWh5zyNFXWoyl12EWcwvPUlA0EtYD0PM+NM0kcd0Y6KBfw5WgirD4DtlOwDpNm9cEWmZ2k/DIncrKmEm1VLg6nT6dt/MPeG3TnVjOC/7R7bLEAZWA88IHzP/kQ8ETaRlQ8wHItiyDdYeI49Isq5m96zNte6xLq8Wh7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932683; c=relaxed/simple;
	bh=ktamuSk1Y4/IB41UxBZS97z4qraC8RPmBNcmSEP7XGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flaHKp0DytNUF/KzZge8jm2LK+qoacXMv7BgW1dnTsjq6qCi3n7KciMnTLKzb7+xWlILZq1FcpzJi3cGxMUnghyiLeppOh3oKjbL9vEgZdyx1xQwG4ArHFts8NKv4kJ4Mq6Q2tSLLVSHq6jAawg9SEo4AaIHBV91GZh95Y2B0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuCZRSyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F073C4CEE7;
	Wed,  3 Sep 2025 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932682;
	bh=ktamuSk1Y4/IB41UxBZS97z4qraC8RPmBNcmSEP7XGM=;
	h=From:To:Cc:Subject:Date:From;
	b=EuCZRSyg8Hs1QJf40Fu+ZnQ35evJr2bR4Sh/VaeZH6kGlaYojrRPL2YnIcvWK+6ZF
	 n8GyNINCUpHVjFAy8H/DfveIj+QRJWULw+8KFN4TFiBkBQQ+AyZiNc3L/jlUvQZMK3
	 VXdHd3pCMIdjfWUq+9sqwct/3fAdZLvhjOBWGuZUE+3mNPq0VLyTmgYRm4c68PhilC
	 CTbzP6pJ7MfzY2ejNmID+G2QwC0zfQAvedkUdEjWqDq7THrF683sMHb5pN/CWEennt
	 H95nlPPrSCLSToqij4xz1IkDGVtLvBbPREb5EUZouLFbOphDxBiP70UnZvFUo/iXKq
	 r+pBxTPrmtegw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 0/9] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO modes
Date: Wed,  3 Sep 2025 16:51:12 -0400
Message-ID: <20250903205121.41380-1-snitzer@kernel.org>
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

This code has proven to work well during my testing.  Any suggestions
for further refinement are welcome.

Thanks,
Mike

Changes since v8:
- Remove a few WARN_ON_ONCE from the misaligned DIO READ and WRITE paths
- pr_warn_ratelimited if EINVAL on misaligned READ and WRITE paths
- handle DIO WRITE -ENOTBLK return by falling back to using buffered IO.
- fix misaligned DIO READ to not use a start_extra_page
- use /end/ of rq_pages for front_pad page
- fix checkpatch warning about 'unsigned' in nfsd_iov_iter_aligned_bvec
- fix NFSD debugfs interfaces to no longer use UNSPECIFIED state,
  explicitly default to NFSD_IO_BUFFERED
- add Documentation/filesystems/nfs/nfsd-io-modes.rst

Mike Snitzer (9):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()
  NFSD: add io_cache_read controls to debugfs interface
  NFSD: add io_cache_write controls to debugfs interface
  NFSD: issue READs using O_DIRECT even if IO is misaligned
  NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
  NFSD: add nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events
  NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst
  NFSD: use /end/ of rq_pages for misaligned DIO READ's start_extra page

 .../filesystems/nfs/nfsd-io-modes.rst         | 144 ++++++
 fs/nfsd/debugfs.c                             |  98 +++++
 fs/nfsd/filecache.c                           |  32 ++
 fs/nfsd/filecache.h                           |   4 +
 fs/nfsd/nfs4xdr.c                             |   8 +-
 fs/nfsd/nfsd.h                                |  10 +
 fs/nfsd/nfsfh.c                               |   4 +
 fs/nfsd/trace.h                               |  61 +++
 fs/nfsd/vfs.c                                 | 409 +++++++++++++++++-
 fs/nfsd/vfs.h                                 |   2 +-
 include/linux/sunrpc/svc.h                    |   5 +-
 11 files changed, 759 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst

-- 
2.44.0


