Return-Path: <linux-nfs+bounces-13525-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC15B1F221
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 07:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C757A4E21
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 05:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3EB2E62C;
	Sat,  9 Aug 2025 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBjmbQGY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B61DA3D
	for <linux-nfs@vger.kernel.org>; Sat,  9 Aug 2025 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754715779; cv=none; b=ecLCiG+vjr2Gy9tMFNbOSoYgcCkk2fFXmD5tVMAsENW92OXMURSr+FiuhAz3Ec9oKnbop4UkraTIQipiiFb0H70J/8ifTMT10e+Ntj4lpl0GzCNetpwe/rrqTmAVui0/1dKzRC4BanTDzGanxdFEuLv0sQGYWzA2CJsM6aEo5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754715779; c=relaxed/simple;
	bh=u/JPcGOTTFF7dw9jd2v4voXOso5bIGjxkajkvlVhOlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSkhoqYe1TfzJflgVSciw6nQE4bY+7BveH4nIkhHkAn5mcx6j6b6D+qzFTOlDnfbnZaVzq/OQ9ww6WAgz8lbPAaKt3dGZHJD8+7oo47KPDTy6SKLa0rqNtjqmIdXbNmMHiX1LDzpkDgZx3VBJEV4K1fhxmx0S6AsGMrPhNugvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBjmbQGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88D8C4CEE7;
	Sat,  9 Aug 2025 05:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754715779;
	bh=u/JPcGOTTFF7dw9jd2v4voXOso5bIGjxkajkvlVhOlM=;
	h=From:To:Cc:Subject:Date:From;
	b=rBjmbQGYux0znOqJ7Y5zbU5zN0bfxO3VKCJHP4pR3v3eLOpdg1PZymfvswG13XKNL
	 3cBbx7GfpWyieyXu4T2O++EeE1VWwwuAJBzIHovzWdTDHDJxvxDqACJJmWF7T4zbH1
	 +JNbks9zVnpEEiDrn92K+EbwChDtFD3CQ1ymsoUuBmLTD7u+gD0AgxXQnrdII0upN3
	 eOZhZDJXDSr6cLfTMRYorOV7x+rhP/tFpaamw75N+CB2/2ein/rsRewzG2dZiW8qNn
	 uuvnIL18vTd3KRbDSxvUUkf31gzqpgiAZinvElvtH0ampSx6Cw2fd5JpObxobyLeqF
	 0akt9lkNXSyNw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v6 0/7] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO modes
Date: Sat,  9 Aug 2025 01:02:50 -0400
Message-ID: <20250809050257.27355-1-snitzer@kernel.org>
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

This series builds on what has been staged in the nfsd-testing branch.

This code has proven to work well during my testing.  Any suggestions
for further refinement are welcome.

Thanks,
Mike

Changes since v5:
- #define NFSD_READ_DIO_MIN_KB (32 << 10)
- switch to using pre-increment from post-increment.
- always get DIO alignment when opening regular nfsd_file (dropped
  patch that only did if NFSD_IO_DIRECT).
- fixed nfsd_io_cache_{read,write}_set to not set NFSD_IO_UNSPECIFIED
  if returning -EINVAL due to unrecognized value. 
- use a switch statement in nfsd_iter_read like nfsd_iter_write
- Optimize nfsd_iter_read for default being buffered IO, like was done
  for nfsd_iter_write in v5.

Changes since v4:
- removed use of iov_iter_is_aligned() in earlier patches, we don't
  want any conflict with Keith's patchset that ultimately removes the
  iov_iter_is_aligned() interface.
- refactored the final "NFSD: issue WRITEs using O_DIRECT even if IO
  is misaligned" patch to have the lightest touch possible on
  nfsd_vfs_write() for the default buffered IO case.
- updated patch headers where needed.
- all patches have changed some, so removed all Reviewed-by from Jeff
  and Signed-off-by from Chuck.
- Series checked with checkpatch.pl, sparse and verified bisect safe.

Changes since v3:
- fixed nfsd_vfs_write() so work that only needs to happen once, after
  IO is submitted, isn't performed each iteration of the for loop,
  thanks for catching this Chuck.
- updated NFSD's misaligned READ and WRITE handling to not use
  iov_iter_is_aligned() because it will soon be removed upstream.
  - Chuck, provided both you and Jeff agree with patch 1's incremental
    changes, patch 1 should be folded into what you already have in your
    nfsd-testing branch (more justification in patch 1's header)
- dropped the NFSD misaligned DIO NFS reexport patch in favor of
  adding STATX_DIOALIGN support to NFS (the patch to add support will
  be provided in the next NFS DIRECT v7 patchset that I'll post soon).

Changes since v2:
- fixed patch 2 by moving redundant work out of nfsd_vfs_write()'s for
  loop, thanks to Jeff's review.
- added Jeff's Reviewed-by to patches 1-3.
- Left patch 4 in the series because it is pragmatic, but feel free to
  drop it if you'd prefer to see this cat skinned a different way.

Changes since v1:
- switched to using an EVENT_CLASS to create nfsd_analyze_{read,write}_dio
- added 4th patch, if user configured use of NFSD_IO_DIRECT then NFS
  reexports should use it too (in future, with per-export controls
  we'll have the benefit of finer-grained control; but until then we'd
  do well to offer comprehensive use of NFSD_IO_DIRECT if it enabled).

Thanks,
Mike

Mike Snitzer (7):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()
  NFSD: add io_cache_read controls to debugfs interface
  NFSD: add io_cache_write controls to debugfs interface
  NFSD: issue READs using O_DIRECT even if IO is misaligned
  NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
  NFSD: add nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events

 fs/nfsd/debugfs.c          | 100 ++++++++++
 fs/nfsd/filecache.c        |  32 ++++
 fs/nfsd/filecache.h        |   4 +
 fs/nfsd/nfs4xdr.c          |   8 +-
 fs/nfsd/nfsd.h             |  10 +
 fs/nfsd/nfsfh.c            |   4 +
 fs/nfsd/trace.h            |  61 +++++++
 fs/nfsd/vfs.c              | 366 +++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.h              |   2 +-
 include/linux/sunrpc/svc.h |   5 +-
 10 files changed, 574 insertions(+), 18 deletions(-)

-- 
2.44.0


