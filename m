Return-Path: <linux-nfs+bounces-14145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CDB505D9
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 21:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B16C167D7A
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF01238C0A;
	Tue,  9 Sep 2025 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uApB2Hh8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA47225A24
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444728; cv=none; b=ZRfXf4KBpzkKNtVoKtM7ObfFOUkdG6lATpmCvaempIBvlUHJvT7CjnXJYXEhUf/r2XkHB41WlkwBBqXKryZlZkJVBHilpKJo0CphV6FqnhHlHUPHKay37wY+wNRpEbt5mN96dLF9+5GSb7uz4u0uiP4jwkeYX/UAvEcY+Bj6+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444728; c=relaxed/simple;
	bh=OLQwAE8DTOJRcHiRarW7yEAjtwQqPNcxybneaiuqrCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlgXuW0Fn8MeFtcWF8GwCyV7Re/3NHN8PrhkjpP7hhSOM7KGu/iLTpSyg88T96xxTdHxhgKejaBOi9vC0+xF/AL5cvM7RPH7tiDxwy/8jAUO5d9c1ZNTwo5s8VL2Yd9Bq/YxLYdmsO4bAlE+h0TB+o/SC6wV4e2+5DziVXjAG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uApB2Hh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204A3C4CEF4;
	Tue,  9 Sep 2025 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757444727;
	bh=OLQwAE8DTOJRcHiRarW7yEAjtwQqPNcxybneaiuqrCE=;
	h=From:To:Cc:Subject:Date:From;
	b=uApB2Hh8cfBmbYfYBUAGW3c8zFtWUKcnF5PrM8KxO8cGyinACGhgN7iwTGPlLA7Ba
	 ONdln0wjzZW7d6YeTvyGkcI1TLZCAj8KVW9yJpGiHgVkpT6TZTwDn0ClVvxXmAjeTp
	 1+ARswNZGTSVL6WROQ6pEVnxINz5rhgsrlOj7ZJgO2s0ddHHXhKNuzy/C4ItwGNm/p
	 Jr+9QbBvzXaucsTrig8lnr1LEjaRTxOG0nw4lvYFG+iBqeQm61gTyTGiqRbBZSGeVi
	 QT7MZ8r7MtMdOuJvINDEtN2rp6WhhEdFgSSnANJoJ2hs6aJsH8NQgHs2ggipAJBHQn
	 eJ+rH2oSYAWNQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/3] NFSD direct I/O read
Date: Tue,  9 Sep 2025 15:05:22 -0400
Message-ID: <20250909190525.7214-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This series replaces patches 1, 2, and 5 in Mike's v9 series:

https://lore.kernel.org/linux-nfs/20250903205121.41380-1-snitzer@kernel.org/T/#t

Changes from Mike's v9:
* The LOC introduced by the feature has been reduced considerably.
* A new trace point in nfsd_file_getattr reports each file's dio
  alignment parameters when it is opened.
* The direct I/O path has been taken out-of-line so that it may
  continue to be modified and optimized without perturbing the more
  commonly used I/O paths.
* When an exported file system does not implement direct I/O, more
  commonly used modes are employed instead to avoid returning
  EOPNOTSUPP unexpectedly.
* When NFSD_IO_DIRECT is selected, NFS READs of all sizes use direct
  I/O to provide better experimental data about small I/O workloads.

I haven't found any issues with NFSv3, NFSv4.0, and NFSv4.1 tested
on TCP and RDMA while /sys/kernel/debug/nfsd/io_cache_read is set
to 2. Trace points confirm that NFSD is using direct I/O.

The goal is to get the experimental read-side direct I/O
implementation merged sooner, as the write side has a few gray areas
that still need discussion and resolution.

Chuck Lever (1):
  NFSD: Implement NFSD_IO_DIRECT for NFS READ

Mike Snitzer (2):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()

 fs/nfsd/debugfs.c       |  2 +
 fs/nfsd/filecache.c     | 34 +++++++++++++++++
 fs/nfsd/filecache.h     |  4 ++
 fs/nfsd/nfs4xdr.c       |  8 ++--
 fs/nfsd/nfsd.h          |  1 +
 fs/nfsd/nfsfh.c         |  4 ++
 fs/nfsd/trace.h         | 28 ++++++++++++++
 fs/nfsd/vfs.c           | 85 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.h           |  2 +-
 include/trace/misc/fs.h | 22 +++++++++++
 10 files changed, 182 insertions(+), 8 deletions(-)

-- 
2.50.0


