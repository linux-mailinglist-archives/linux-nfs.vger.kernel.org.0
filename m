Return-Path: <linux-nfs+bounces-15692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D9C0F20A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25624239C9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989EB310764;
	Mon, 27 Oct 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnq47IY8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8431062E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579994; cv=none; b=l9eSthNNlv1aJ0oqoqAlPhyA5fR9dh9Pyj3S0AZi+tVvqlk0qHZxCwGyf/8vWYf/+NiSwDKInmGfgynr3DSadqMW2CpfcQnUc/RA/DxwZcT2tU8DBkfs3p/HibeUVHInkYiP1wHWbS4H0qftJXQDvkq2mr51oXsDinIfY1TpVgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579994; c=relaxed/simple;
	bh=wUEHgXBvv335vwez17apeadxabuVd44TgrZGnQnx+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHOvND7aY/f8xRHJkdtBGp0lpOyc9mdOBcVyg45QH1TyMcj9jJ4uuFVeY4NNc3B3pW5IS15EbjZp3y5aKCXntks0hsf8PONR9aC7j1eyyKIIHQ3+JXSQaWTtUL3ZzXKypmYahVNUUoGzQ7DWT2F9dMRhMxNcHlPfEJUk95n+EAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnq47IY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2894BC4CEFF;
	Mon, 27 Oct 2025 15:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761579993;
	bh=wUEHgXBvv335vwez17apeadxabuVd44TgrZGnQnx+Lk=;
	h=From:To:Cc:Subject:Date:From;
	b=Bnq47IY8ooQzSclYe/XI7tH9atxmD/Ln3zxCu4luGvFMaWtzQYqxFLypaU97yoMYh
	 59dxrg5aIX1AGTadFxFWy4brawujVzIlbhE9qRxTtwst2MIr4wfSUkd3oPxQyBRoz+
	 t4padKJ0X7qf3S7YzK20u3cjIWmSTuBqUap6aw8qwK1s6d5ctHN18GO3jKd7sSgcYS
	 6dsgZwq16cYrHIeNQQdbgavKXmQHNUGKW1W5bVVvuzxxx0wtK8DI866Ya5LKCG+Ugx
	 ponZX6hA4/6eZO0G0p85Hk2l0vuU0LwXz0WQamvOod+8NgdD0ExzSgq5jG1SWvA5rr
	 oZ4+3ZKYspxMQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 00/12] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Mon, 27 Oct 2025 11:46:18 -0400
Message-ID: <20251027154630.1774-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following on https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
this series includes the patches needed to make NFSD Direct WRITE
operational.

I've reduced the amount of CPU effort needed to determine when
IOCB_DIRECT can be used. Because a receive buffer is comprised of
contiguous pages, the elements in the bvec after the first one
always have bv_offset == 0, thus they are always memory-aligned.
From there, further simplifications are possible. (This is an effort
to address Christoph's observation that the construction of the
bvec array was inefficient and duplicative).

We've also determined that there might be actual work in the storage
layer that might be better off left until a subsequent COMMIT. So
this series no longer promotes all NFSD_IO_DIRECT writes to be
FILE_SYNC, but instead, observes the client's stable_how argument.

If any of these changes results in a regression, I'll revisit.

Noted that one of the fstests triggers the NFS server's kernel
to emit this warning:

WARNING: CPU: 5 PID: 1348 at fs/iomap/buffered-io.c:1402
	iomap_zero_iter+0x1a4/0x390

mlperf_npz_tool.py passes on NFSv3 with both TCP and RDMA, as does
the git regression test suite with jobs=24.

Changes since v7:
* Rebase the series on Mike's original v3 patch
* Address more review comments
* Optimize the "when can NFSD use IOCB_DIRECT" logic
* Revert the "always promote to FILE_SYNC" logic

Changes since v6:
* Patches to address review comments have been split out
* Refactored the iter initialization code

Changes since v5:
* Add a patch to make FILE_SYNC WRITEs persist timestamps
* Address some of Christoph's review comments
* The svcrdma patch has been dropped until we actually need it

Changes since v4:
* Split out refactoring nfsd_buffered_write() into a separate patch
* Expand patch description of 1/4
* Don't set IOCB_SYNC flag

Changes since v3:
* Address checkpatch.pl nits in 2/3
* Add an untested patch to mark ingress RDMA Read chunks

Chuck Lever (11):
  NFSD: Make FILE_SYNC WRITEs comply with spec
  NFSD: Enable return of an updated stable_how to NFS clients
  NFSD: Remove specific error handling
  NFSD: Remove alignment size checking
  NFSD: Clean up struct nfsd_write_dio
  NFSD: Introduce struct nfsd_write_dio_seg
  NFSD: Simplify nfsd_iov_iter_aligned_bvec()
  NFSD: Handle both offset and memory alignment for direct I/O
  NFSD: Combine direct I/O feasibility check with iterator setup
  NFSD: Handle kiocb->ki_flags correctly
  NFSD: Refactor nfsd_vfs_write

Mike Snitzer (1):
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE

 fs/nfsd/debugfs.c   |   1 +
 fs/nfsd/filecache.c |   5 +
 fs/nfsd/filecache.h |   1 +
 fs/nfsd/nfs3proc.c  |   2 +-
 fs/nfsd/nfs4proc.c  |   2 +-
 fs/nfsd/nfsproc.c   |   3 +-
 fs/nfsd/trace.h     |   1 +
 fs/nfsd/vfs.c       | 222 +++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/vfs.h       |   6 +-
 fs/nfsd/xdr3.h      |   2 +-
 10 files changed, 228 insertions(+), 17 deletions(-)

-- 
2.51.0


