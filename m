Return-Path: <linux-nfs+bounces-11178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24ACA944D1
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549BA1893CAD
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42774153836;
	Sat, 19 Apr 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8ez5Lay"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA454769
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083702; cv=none; b=JM30jughuK0buCAi3EtnNiWF6fFD5qyUAV0KhZrbQY1Q04WPKzhnnpIzpSN3GxKD3C5F5DICn9Dqs7Dgp4zpkqz+TzeeKw7ft2CU6ewqxrmVXLgWqSMA1vbxj/tK7X22W5EY0NBvzuoq9d2HnotcLg6bQG8sd/g0/DEw97k4ouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083702; c=relaxed/simple;
	bh=EHi9HFQqNHKWN71CtAx2j5JiMxeA1LcbPsBFLU3cZPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuH0SV4Jns4vPSk6e2HDj0wv4baoq0kQms5kAAy6fwmg6BjFatsrkg51N9VCROtqIdmBlw9SZ5MBuwBU+T6YYrL9SntfRVhVLJUCH9m4ujNruFWehCXHqp1HHsZHl7Imr5WjoBMbAm66EVKDRy5FQc0mAjxQ4d3/QVIH0jhaVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8ez5Lay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1078C4CEE7;
	Sat, 19 Apr 2025 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083701;
	bh=EHi9HFQqNHKWN71CtAx2j5JiMxeA1LcbPsBFLU3cZPY=;
	h=From:To:Cc:Subject:Date:From;
	b=s8ez5LayBRYv1M+vAAAnBULJ6FCvxU/xV4UAh2/VFrTxsMvKwtIgGfWA4wZ1RQHje
	 x40gI85IyCJest7bgRD50u6ii1CPUR3hQLAoJG9IN1WIHh9YdtxIsxflK3Xk5LXRsf
	 rEXj09IuM2VyEGm/UB82k6Ik5VXwvcuu8k9uA84dVWy3bubzCKYPbGly84BY8GFsAT
	 dPAqpX6g/0RJ2LMIDity04IxbzHfUTNpm/I2Up212zRU77TirtZOpeIaU8lifODWoD
	 igt/Phw5gDfIcpcAuhmAPyHvqE7CgxZxq2CvTSCYJQxgEvHEz7t7KvJQaZNbmcEsj/
	 Dp7/EaXjZ0xRQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 00/10] Allocate payload arrays dynamically
Date: Sat, 19 Apr 2025 13:28:08 -0400
Message-ID: <20250419172818.6945-1-cel@kernel.org>
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

Chuck Lever (9):
  sunrpc: Remove backchannel check in svc_init_buffer()
  sunrpc: Add a helper to derive maxpages from sv_max_mesg
  sunrpc: Replace the rq_pages array with dynamically-allocated memory
  sunrpc: Replace the rq_vec array with dynamically-allocated memory
  sunrpc: Replace the rq_bvec array with dynamically-allocated memory
  sunrpc: Adjust size of socket's receive page array dynamically
  svcrdma: Adjust the number of RDMA contexts per transport
  svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
  svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages

 fs/nfsd/nfs4proc.c                       |  1 -
 fs/nfsd/vfs.c                            |  2 +-
 include/linux/sunrpc/svc.h               | 19 +++++++--
 include/linux/sunrpc/svc_rdma.h          |  6 ++-
 include/linux/sunrpc/svcsock.h           |  4 +-
 net/sunrpc/svc.c                         | 51 +++++++++++++++---------
 net/sunrpc/svc_xprt.c                    | 10 +----
 net/sunrpc/svcsock.c                     | 15 ++++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  8 +++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |  2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 16 ++++++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
 12 files changed, 88 insertions(+), 48 deletions(-)

-- 
2.49.0


Chuck Lever (10):
  sunrpc: Remove backchannel check in svc_init_buffer()
  sunrpc: Add a helper to derive maxpages from sv_max_mesg
  sunrpc: Replace the rq_pages array with dynamically-allocated memory
  sunrpc: Replace the rq_vec array with dynamically-allocated memory
  sunrpc: Replace the rq_bvec array with dynamically-allocated memory
  sunrpc: Adjust size of socket's receive page array dynamically
  svcrdma: Adjust the number of RDMA contexts per transport
  svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
  svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
  sunrpc: Remove the RPCSVC_MAXPAGES macro

 fs/nfsd/nfs4proc.c                       |  1 -
 fs/nfsd/vfs.c                            |  2 +-
 include/linux/sunrpc/svc.h               | 31 +++++++++-----
 include/linux/sunrpc/svc_rdma.h          |  6 ++-
 include/linux/sunrpc/svcsock.h           |  4 +-
 net/sunrpc/svc.c                         | 51 +++++++++++++++---------
 net/sunrpc/svc_xprt.c                    | 10 +----
 net/sunrpc/svcsock.c                     | 15 ++++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  8 +++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |  2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 16 ++++++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
 12 files changed, 93 insertions(+), 55 deletions(-)

-- 
2.49.0


