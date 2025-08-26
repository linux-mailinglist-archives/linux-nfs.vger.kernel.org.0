Return-Path: <linux-nfs+bounces-13899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B4EB372B0
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EE51BA3046
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93712E336E;
	Tue, 26 Aug 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiMxDezK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E52D1F40
	for <linux-nfs@vger.kernel.org>; Tue, 26 Aug 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234642; cv=none; b=fuUpiyEySUY3vhKt6BtqJMhYvrAOI5ZF8Hu+WYCzCL5MArh7SJd08YCFAHhneMr7Liv1CY+1pxv12RLMKsZDwrLLiagMo6Er9NYhbrOugOREFe9IeyLrkqHFUYNWlT43+I+GTeAtNnpk2g7xlqrBYVGzjxOdT5zczGgfQ7m/Zb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234642; c=relaxed/simple;
	bh=/GB2R6GBmzO5jvAX8EWiPu3hS8n0YoQG6FKiPfNsgEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nI8kYgSwG0rEuJC4OLyf0dwxMIV98+i1RRidboFcZI8D9lIglfMr9g21o4SeGHSa41WI9zwEuppdzF/QJg0t4RzrUPJoI6omQzfbvfZX6NfZU778nsVYGHK1iA7pMxnW0GqlcWAo7LzWw1+i3PJra9rRdaOOXxCDpTuTTKaCT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiMxDezK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D944C4CEF1;
	Tue, 26 Aug 2025 18:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756234640;
	bh=/GB2R6GBmzO5jvAX8EWiPu3hS8n0YoQG6FKiPfNsgEw=;
	h=From:To:Cc:Subject:Date:From;
	b=qiMxDezKIkKY36vBM3KD4sdW47lZIMv8gcYsFpU9lWWDF8i98u2dsamABmB61lw2Q
	 AToRsQ6yfiVDtBT7tP8J/MLhgzFWrJudCyX01oBuMxRMiun67/nYkrmQsetuO9vQ43
	 CBS7R/hOd91Kt2hTYIlWIxceq/Pr//dl0ERY+eqnrNmZxLe3U49CFcmHdk/OYPC7Q6
	 6OV/2MP6YlJYUlCCw6GCnmWzoRV/ajZcfUbdO7H7y44FUVlCUvoaExeygYKZ+6SEgW
	 aZBgjYG7OqdpM8WvZLm/UMTAXXrm8omlvJx9Z1gkoZLURRPQi4iIihRN/fMUo60PdU
	 HL/LXFWhJ6gjw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 0/7] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO modes
Date: Tue, 26 Aug 2025 14:57:11 -0400
Message-ID: <20250826185718.5593-1-snitzer@kernel.org>
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

Changes since v7:
- Add Jeff's Reviewed-by to patches 3, 4 and 5.
- Use IOCB_SYNC for all buffered WRITEs if NFSD using NFSD_IO_DIRECT
- Fix compiler warning in trace.h, must use %zd for ssize_t in TP_printk

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
 fs/nfsd/vfs.c              | 413 +++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.h              |   2 +-
 include/linux/sunrpc/svc.h |   5 +-
 10 files changed, 621 insertions(+), 18 deletions(-)

-- 
2.44.0


