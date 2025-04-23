Return-Path: <linux-nfs+bounces-11236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8BAA99242
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A634928361
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274442BE0EE;
	Wed, 23 Apr 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEN/eRjY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154A2BE0F6
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421682; cv=none; b=GLZsjMdFBhI0+dxN+NoDwhK7nch04U/nmndFAdqwKS9V+Fz1VlLoLULV26jLzs7rAl6fub0qvKkaq7d2d1UmZxmjTlfs71NXnLtYIygBhORLKcMqSmImPQBoN/NzhZDsZl8kmfjFecKcQezLClyNzIOZc/qQefb19PnmCYkAGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421682; c=relaxed/simple;
	bh=cTY+sSTWFztRlBbCEjojRRgyMn6pEwablQbUW7Gubcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNKVzvEbshUvZ8uHOFHVea3H2oryKUennkW4oCG36jvaQSLPkUob8AjnBSF51hcIVnOEHRNQAghN5QRcsH89ZMiOBCiM2UBhXh/4JjxHd/U4iUhiGYww0NYtgzxv0c6BMd5jnICxu2mSJVIb3iQBe35UXrD2sBwAeNtCi4A4wzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEN/eRjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62DFC4CEEB;
	Wed, 23 Apr 2025 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421680;
	bh=cTY+sSTWFztRlBbCEjojRRgyMn6pEwablQbUW7Gubcw=;
	h=From:To:Cc:Subject:Date:From;
	b=YEN/eRjY/hTRwW7q/L2iBY92RhR9kVdgzfcj6eXZ7onRD2gc1cYKezBeVbEXvi6+k
	 YyNHmuXupUUgKn6mX/3kHC8HUHP45i5mJmtj5RUECXhRbDdBPVJtSbOs+j+q3yfgRc
	 GN8GPACLv+QDvwd3KrY8Lmm/pBPQyMqPGfi1U4WKvRwyKlJZi1WFwt4FP1cyBN1L3K
	 j0I7tU347qq2Z3BbwGqcGy+nBcObvrtyTEfkKWjnTqE6xm2DXpXLrzVq9P2ONdtqiJ
	 5FzpxTJJqqcf+XkrI4NJdQ5zvtKtlobIqPJ99tVvdocaf9tdkEIO8snnxfqU1EfWDw
	 Y+AXH91EQf2hQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 00/11] Allocate payload arrays dynamically
Date: Wed, 23 Apr 2025 11:21:06 -0400
Message-ID: <20250423152117.5418-1-cel@kernel.org>
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

Changes since v2:
* Address Jeff's review comments
* Address Neil's review comments
* Start removing a few uses of NFSSVC_MAXBLKSIZE

Chuck Lever (11):
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
  NFSD: Remove NFSSVC_MAXBLKSIZE from .pc_xdrressize

 fs/nfsd/nfs3proc.c                       |  4 +-
 fs/nfsd/nfsproc.c                        |  4 +-
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
 13 files changed, 97 insertions(+), 58 deletions(-)

-- 
2.49.0


