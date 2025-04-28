Return-Path: <linux-nfs+bounces-11315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F001A9F9A0
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC2E464485
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD72973C4;
	Mon, 28 Apr 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS6GbUfq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F7296D23;
	Mon, 28 Apr 2025 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869026; cv=none; b=J9EOuRP7MmyihJeXslILrk5Bsm8+BJ7Wx2cKXWqSAn3DFLUl0O3ZocEXArwox0tZt4PGwrhN7IUClHpc6WGDo8mmOmO8bKfBm2AJbQLKSImd6aCtcEKeMrdmlQKX/GqF6VzSGBObQJcj/GeCkibj3DSj2Rsf5Ev5n+AV2LNr/qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869026; c=relaxed/simple;
	bh=FukxIA++WN9URsXlGgGi1Kwch+UcFfTTHbe70o7gTVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CX1tk/xJabdGLl1+AmKgOATRu4BYx4Z5/qtJOUdo23s1a13X44QcWuoWAQXkKsEUUUgY+LU4BAfEi3vphLPiMTu43sLyjIdJj6OJ+ZakN+Cwltm330PdzL11Ligbx31lDKeRpCGeIIc5J6ybTrzE7TfUDZEAWIrSwUPT84QjA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS6GbUfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A7FC4CEE4;
	Mon, 28 Apr 2025 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869025;
	bh=FukxIA++WN9URsXlGgGi1Kwch+UcFfTTHbe70o7gTVc=;
	h=From:To:Cc:Subject:Date:From;
	b=ZS6GbUfqsWaFrQYKu1DS7BtAsLuI7pY0N3/tY1MGaro3BeyF3JxF1psgQY40vJx6F
	 KepD/a0c4VZ0f5wIudhLYcczIn36azwlQ97DqjJBe3022xL/9omDHsqEnJ+qSLHfuV
	 p2NuHtsf6BGOVz4dIws1M7zEOm6fS3skrfTqmJrc+GEQOgcBCqKQ76RKNfPnLWgl6x
	 QCMogi3ykkjRRtU9156D+HrS+wuo+Q0cYWe8/8Ty99yD3pJMSMq9Ibx39j7MWO+WRl
	 JB2isRTVAgNMh0MpE2hpzzjRj2hJYUkRwPr8q0hzWikvHc45mAZd+Pig39HrTPB5Q8
	 8NYnGV+nLoA4g==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 00/14] Allocate payload arrays dynamically
Date: Mon, 28 Apr 2025 15:36:48 -0400
Message-ID: <20250428193702.5186-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In order to make RPCSVC_MAXPAYLOAD larger (or variable in size), we
need to do something clever with the payload arrays embedded in
struct svc_rqst and elsewhere.

My preference is to keep these arrays allocated all the time because
allocating them on demand increases the risk of a memory allocation
failure during a large I/O. This is a quick-and-dirty approach that
might be replaced once NFSD is converted to use large folios.

The downside of this design choice is that it pins a few pages per
NFSD thread (and that's the current situation already). But note
that because RPCSVC_MAXPAGES is 259, each array is just over a page
in size, making the allocation waste quite a bit of memory beyond
the end of the array due to power-of-2 allocator round up. This gets
worse as the MAXPAGES value is doubled or quadrupled.

This series also addresses similar issues in the socket and RDMA
transports.

v4 is "code complete", unless there are new code change requests.
I'm not convinced that adding XDR pad alignment to svc_reserve()
is good, but I'm willing to consider it further.

It turns out there is already a tuneable for the maximum read and
write size in NFSD:

  /proc/fs/nfsd/max_block_size

Since there is an existing user space API for this, my initial
arguments against adding a tuneable are moot. max_block_size should
be adequate for this purpose, and enabling it to be set to larger
values should not impact the kernel-user space API in any way.

Changes since v3:
* Improved the rdma_rw context count estimate
* Dropped "NFSD: Remove NFSSVC_MAXBLKSIZE from .pc_xdrressize"
* Cleaned up the max size macros a bit
* Completed the implementation of adjustable max_block_size

Changes since v2:
* Address Jeff's review comments
* Address Neil's review comments
* Start removing a few uses of NFSSVC_MAXBLKSIZE

Chuck Lever (14):
  svcrdma: Reduce the number of rdma_rw contexts per-QP
  sunrpc: Add a helper to derive maxpages from sv_max_mesg
  sunrpc: Remove backchannel check in svc_init_buffer()
  sunrpc: Replace the rq_pages array with dynamically-allocated memory
  sunrpc: Replace the rq_vec array with dynamically-allocated memory
  sunrpc: Replace the rq_bvec array with dynamically-allocated memory
  sunrpc: Adjust size of socket's receive page array dynamically
  svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
  svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
  sunrpc: Remove the RPCSVC_MAXPAGES macro
  NFSD: Remove NFSD_BUFSIZE
  NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
  NFSD: Add a "default" block size
  SUNRPC: Bump the maximum payload size for the server

 fs/nfsd/nfs4proc.c                       |  2 +-
 fs/nfsd/nfs4state.c                      |  2 +-
 fs/nfsd/nfs4xdr.c                        |  2 +-
 fs/nfsd/nfsd.h                           | 24 ++++-------
 fs/nfsd/nfsproc.c                        |  4 +-
 fs/nfsd/nfssvc.c                         |  2 +-
 fs/nfsd/nfsxdr.c                         |  4 +-
 fs/nfsd/vfs.c                            |  2 +-
 include/linux/sunrpc/svc.h               | 45 +++++++++++++--------
 include/linux/sunrpc/svc_rdma.h          |  6 ++-
 include/linux/sunrpc/svcsock.h           |  4 +-
 net/sunrpc/svc.c                         | 51 +++++++++++++++---------
 net/sunrpc/svc_xprt.c                    | 10 +----
 net/sunrpc/svcsock.c                     | 15 ++++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  8 +++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |  2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 16 ++++++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 14 ++++---
 18 files changed, 122 insertions(+), 91 deletions(-)

-- 
2.49.0


