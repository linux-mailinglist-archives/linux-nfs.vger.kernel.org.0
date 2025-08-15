Return-Path: <linux-nfs+bounces-13669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892BB2826C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 16:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23763AA6C8
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9721D3C9;
	Fri, 15 Aug 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiXzZuym"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE31DE894
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269169; cv=none; b=KinzCA91hwONBSPMO27UZt5FBmSggPke0YFNctTC4zahcum9nI2GK17GDtj9CQF/dzA7OqOkgMqR0ub2My4ZUOfeiMhRjrL1ft6xgQ4wWadiCfH2lCPY2pAK7/3Wpse1Pdojmvicsk23gZH4vV7LMr/HM/6NnkcNYE429ogTlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269169; c=relaxed/simple;
	bh=80E1UIXiUi2sd9mbCI2LbsPqtXafwhohhVGtrsGcY/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1WNKSc1tjUhhT88dK+5wyU/ltWorIGHNgXfG8Z8Pyg5I2iMHQ9ZxxrXh3IjoTWjMTkpmHdo5jiyN6efNubNAvrcJ5Mr1iC491y2KdBBq6z0MEzff1U5Pyv5tM06O0TJx19gyo+4h3Rz39r1m5COG8lSORBHDSPoalKGMgu3W14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiXzZuym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD62C4CEEB;
	Fri, 15 Aug 2025 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755269169;
	bh=80E1UIXiUi2sd9mbCI2LbsPqtXafwhohhVGtrsGcY/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=uiXzZuym5jpPWUtBVDzXXTs2GfOgeOww+Gt2+ZGOAGDDDlfDKKO0IORtLBwNK2Gfz
	 Q9E1wr11Ud1VzxcbMjsEQrCq0FpQ4exgAl54/axk3/ZxV0eV9Zi64Fh5ZfQYYSGYub
	 C9Yt6oIG82U3bDJFu7xgSbAFruF6So2gmpR9JH5HJ0FTYCVWxZ8CxailCn33c2pbNT
	 WXA8oSdT9fVkFIBv4rFUJIKj7UqGE6iREaKQMAZZ4Yzy6SR81l6xFphv/A4eo9eKyb
	 Et/pLFX3eeu4ClZg/KERP/pS8yTJlMJbbUr9WtJHoqZXIbVtodLApRgYiYqs6XXRbK
	 ZFKBX1+Hanm0Q==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 0/7] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO modes
Date: Fri, 15 Aug 2025 10:46:00 -0400
Message-ID: <20250815144607.50967-1-snitzer@kernel.org>
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

Changes since v6:
- reinstate use of iov_iter_aligned_bvec, in terms of local helper
  nfsd_iov_iter_aligned_bvec, otherwise underlying filesystem could be
  sent misaligned DIO that it will respond to with -EINVAL.
- add WARN_ON_ONCE if NFSD_IO_DIRECT and underlying filesystem returns
  -EINVAL (shouldn't happen, so its best to be loud if it does)

Earlier changelog was provided in v6's 0th patch header, see:
https://lore.kernel.org/linux-nfs/20250809050257.27355-1-snitzer@kernel.org/

Mike Snitzer (7):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()
  NFSD: add io_cache_read controls to debugfs interface
  NFSD: add io_cache_write controls to debugfs interface
  NFSD: issue READs using O_DIRECT even if IO is misaligned
  NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
  NFSD: add nfsd_analyze_read_dio and nfsd_analyze_write_dio trace events

 fs/nfsd/debugfs.c          | 100 +++++++++
 fs/nfsd/filecache.c        |  32 +++
 fs/nfsd/filecache.h        |   4 +
 fs/nfsd/nfs4xdr.c          |   8 +-
 fs/nfsd/nfsd.h             |  10 +
 fs/nfsd/nfsfh.c            |   4 +
 fs/nfsd/trace.h            |  61 ++++++
 fs/nfsd/vfs.c              | 408 +++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.h              |   2 +-
 include/linux/sunrpc/svc.h |   5 +-
 10 files changed, 616 insertions(+), 18 deletions(-)

-- 
2.44.0


