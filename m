Return-Path: <linux-nfs+bounces-13210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92CB0F751
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99C51C279DF
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02861F873B;
	Wed, 23 Jul 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUjR4XjX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF61EB5DD
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285434; cv=none; b=G2Vp9tsyGCFrBLfORWf3FTrxPlnHe7NzM3KkTM47Oweb3rXWptFPeMZeinRLz28O2+G9yYH4//wvaHmNEoC79ZMybuEdn7G4jA1WYXFAoI4ghkiXobaEI/BJEYY5TVocH+rl+A9PywACXfvtXZQ/pwMk/iXhZUMZD0GxBh8Wrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285434; c=relaxed/simple;
	bh=eKjNmLTfBR8pEtxB4ZeI8tayw7lRKDeEYZJCuietgys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYIk/4dC3OfGp8d7EWB7xIe7zEEHSVuRwC7Ei08o+ZOXaMBw/7ZEF8fn/N8t9clnBfjg3+CvDSXMLXT7P/K1B9aEeWwjDi5f7GfikUBQL9llSv3buBOpTXnfyxIwQOvkAF3w0d2vMRWONsvGX2Xs31mACyMBppYT97WsMNCmsV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUjR4XjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03327C4CEE7;
	Wed, 23 Jul 2025 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285433;
	bh=eKjNmLTfBR8pEtxB4ZeI8tayw7lRKDeEYZJCuietgys=;
	h=From:To:Cc:Subject:Date:From;
	b=IUjR4XjXPFoKmJ8hGgF9vwmB3bU4yJsav3UX8bCKBAdFl/OYtJwnVIN914mIdePnD
	 ZafGkZYRdcmmUf4zFJU5PDExrUCV/UrdkOPZgX7Dm+K+tJjxvu9ePZ2kxHP6qIfEs6
	 wsTatLY0SzaBD/XBfhgSDuCohqVXXldiHYtbOsga1dFAJJG5pZfxTGOGN1Uljr0kpO
	 Umqfu6XvlHPzBhMfLBpq3I08IJY1JKXRwNq3a3qiLPw/2KHiBhEPl0bFulcPxPtAqB
	 3n8w3QgL3UzKqfCqJcDtEAhBguXaH2FDVGoecY91i0UV9fm9Tk2/UTZqOr9rxO1cUO
	 yUAgScKDQZKBQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO modes
Date: Wed, 23 Jul 2025 11:43:46 -0400
Message-ID: <20250723154351.59042-1-snitzer@kernel.org>
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

Very minor changes for this v4.

Thanks,
Mike

Changes since v3:
- Fix a copy-n-paste bug in nfsd_vfs_write:
  s/nf_dio_read_offset_align/nf_dio_offset_align/
- Rename struct nfsd_dio_io to nfsd_read_dio.

Changes since v2:
- explored suggestion to use string based interface (e.g. "direct"
  instead of 3) but debugfs seems to only supports numeric values.
- shifted numeric values for debugfs interface from 0-2 to 1-3 and
  made 0 UNSPECIFIED (which is the default)
- if user specifies io_cache_read or io_cache_write mode other than 1,
  2 or 3 (via debugfs) they will get an error message
- pass a data structure to nfsd_analyze_read_dio rather than so many
  in/out params
- improved comments as requested (e.g. "Must remove first
  start_extra_page from rqstp->rq_bvec" was reworked)
- use memmove instead of opencoded shift in
  nfsd_complete_misaligned_read_dio
- dropped the still very important "lib/iov_iter: remove piecewise
  bvec length checking in iov_iter_aligned_bvec" patch because it
  needs to be handled separately.
- various other changes to improve code

Mike Snitzer (5):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()
  NFSD: add io_cache_read controls to debugfs interface
  NFSD: add io_cache_write controls to debugfs interface
  NFSD: issue READs using O_DIRECT even if IO is misaligned

 fs/nfsd/debugfs.c          | 102 +++++++++++++++++++
 fs/nfsd/filecache.c        |  32 ++++++
 fs/nfsd/filecache.h        |   4 +
 fs/nfsd/nfs4xdr.c          |   8 +-
 fs/nfsd/nfsd.h             |  10 ++
 fs/nfsd/nfsfh.c            |   4 +
 fs/nfsd/trace.h            |  37 +++++++
 fs/nfsd/vfs.c              | 197 ++++++++++++++++++++++++++++++++++---
 fs/nfsd/vfs.h              |   2 +-
 include/linux/sunrpc/svc.h |   5 +-
 10 files changed, 383 insertions(+), 18 deletions(-)

-- 
2.44.0


