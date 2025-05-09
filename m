Return-Path: <linux-nfs+bounces-11622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789AAB1CF5
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366073A9860
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7F924166E;
	Fri,  9 May 2025 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogl+ekKJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDE241661;
	Fri,  9 May 2025 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817437; cv=none; b=jlIIfdCcifC89ZwdUuLcAaGM8RhIAGFyciIRnn4rI0aaEz5TktsWpYASP4vQqjKFeb7e3YA/PUKvd1Oo9zsYB5vMDJ/M2ZQgLj3oeH3qkEHh60nfHY1h5WekVXI7psxTjWff+zbhKGoToKl3KEjzUfdYIN0/+TmfBOMQAQsKeR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817437; c=relaxed/simple;
	bh=Rx1UztUuuMc7zNG5cM1iHfYJOuIbjsS952oGwaC2+p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWD8cs0VXiESrAxkEWJyJ/xkQZpsr416kKedPGyMl7xezWN3CRiPeXdPm1cMxHvs2tfvOSOme55AErm0Tctt49FszGIKWzgcsXT7DuEjk/g7QYjp3Izs3ji3k7rgRIf9MYASL+8Rak7jUyyqVj7YImvm8wycNt1/M03V0g5CGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogl+ekKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177C9C4CEE4;
	Fri,  9 May 2025 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817436;
	bh=Rx1UztUuuMc7zNG5cM1iHfYJOuIbjsS952oGwaC2+p0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ogl+ekKJ/5bxR3/rUr8/uRaT2txWaxpFowDoe/H3rllQSje3/RbZE+V8HtXlIuDeC
	 tE2fE3Mu1G1nzLLGMW+/KB+5KE7p+R/SEbMoeZfp0jZMNj4aGkDl7cpio1nmvgJ7cj
	 AfB/e0qbFXY2q783GfSIFfHBVRgcPfFONzHGiE25cn81SMxSfQT/UwUZuZbYglckaS
	 c10Vp3YVY3MCk1smyjOzMSsvp6nMHCiPJPpYrs5lVi7s2LfTKCm9w1JUcHmuysEAln
	 Jgzsxh8aZtItPJWDkA3bqWP3kW/rFlDTXRby2GpW8UDYIwkZG0TDWZg9myc5dt2SJh
	 spF4DJsBzTUWQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 00/19] Allocate payload arrays dynamically
Date: Fri,  9 May 2025 15:03:34 -0400
Message-ID: <20250509190354.5393-1-cel@kernel.org>
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

Changes since v4:
* Replace the use of rq_vec instead of allocating it dynamically

Changes since v3:
* Improved the rdma_rw context count estimate
* Dropped "NFSD: Remove NFSSVC_MAXBLKSIZE from .pc_xdrressize"
* Cleaned up the max size macros a bit
* Completed the implementation of adjustable max_block_size

Changes since v2:
* Address Jeff's review comments
* Address Neil's review comments
* Start removing a few uses of NFSSVC_MAXBLKSIZE

Chuck Lever (19):
  svcrdma: Reduce the number of rdma_rw contexts per-QP
  sunrpc: Add a helper to derive maxpages from sv_max_mesg
  sunrpc: Remove backchannel check in svc_init_buffer()
  sunrpc: Replace the rq_pages array with dynamically-allocated memory
  sunrpc: Replace the rq_bvec array with dynamically-allocated memory
  NFSD: Use rqstp->rq_bvec in nfsd_iter_read()
  NFSD: De-duplicate the svc_fill_write_vector() call sites
  SUNRPC: Export xdr_buf_to_bvec()
  NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
  SUNRPC: Remove svc_fill_write_vector()
  SUNRPC: Remove svc_rqst :: rq_vec
  sunrpc: Adjust size of socket's receive page array dynamically
  svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
  svcrdma: Adjust the number of entries in svc_rdma_send_ctxt::sc_pages
  sunrpc: Remove the RPCSVC_MAXPAGES macro
  NFSD: Remove NFSD_BUFSIZE
  NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
  NFSD: Add a "default" block size
  SUNRPC: Bump the maximum payload size for the server

 fs/nfsd/nfs3proc.c                       |  5 +-
 fs/nfsd/nfs4proc.c                       | 10 +--
 fs/nfsd/nfs4state.c                      |  2 +-
 fs/nfsd/nfs4xdr.c                        |  2 +-
 fs/nfsd/nfsd.h                           | 24 +++----
 fs/nfsd/nfsproc.c                        | 13 ++--
 fs/nfsd/nfssvc.c                         |  2 +-
 fs/nfsd/nfsxdr.c                         |  4 +-
 fs/nfsd/vfs.c                            | 67 ++++++++++++++------
 fs/nfsd/vfs.h                            | 10 +--
 include/linux/sunrpc/svc.h               | 46 ++++++++------
 include/linux/sunrpc/svc_rdma.h          |  6 +-
 include/linux/sunrpc/svcsock.h           |  4 +-
 net/sunrpc/svc.c                         | 80 +++++++-----------------
 net/sunrpc/svc_xprt.c                    | 10 +--
 net/sunrpc/svcsock.c                     | 15 +++--
 net/sunrpc/xdr.c                         |  1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  8 ++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |  2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 16 ++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 14 +++--
 21 files changed, 170 insertions(+), 171 deletions(-)

-- 
2.49.0


