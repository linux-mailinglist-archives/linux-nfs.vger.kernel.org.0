Return-Path: <linux-nfs+bounces-14615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9847B919B4
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6DD16ED0A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A541C62;
	Mon, 22 Sep 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyL99oBk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27801DA23
	for <linux-nfs@vger.kernel.org>; Mon, 22 Sep 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550299; cv=none; b=NfnQcWMNOtKuAflQtl+tAXQoiV1O5SeY5tZWREgcNU77Hm2rPBe9U7LeNzRp50RkqLZusexzuJI/ayjs1bxhkiNyKiEVAYW/sOMacEI1rMMrp/e4n5BDxJ63kG8pWXoUoNiGEoc3y7Bdxadnmd1QBavslfainMvniVF7XsBrY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550299; c=relaxed/simple;
	bh=dUtBdo31UUo2cYNOpcbQdcqJfKuwf0+bCntPYsY1m/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbkG8LtvGw7iNXc/nnEuQ0WTupeyi1s4DATYXapaX7yrxn0TDs/HzzXMsXD8HVbuh+NxAl7J8PSjl1AWEtgYGb3RUOnzpmqtY4AzJaJDqUKRiU2kQ+pfJJq+qYBiQzSP1hL1z387fwdpD6QhhGVx6p29rDL18KBUnpIesXigxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyL99oBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF706C4CEF0;
	Mon, 22 Sep 2025 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550299;
	bh=dUtBdo31UUo2cYNOpcbQdcqJfKuwf0+bCntPYsY1m/0=;
	h=From:To:Cc:Subject:Date:From;
	b=KyL99oBkcraaHkGpGGfUeuhsnvUHx2hv0QWKRdHYwZns6JFQXimK0X1DFSh5OPjK+
	 b7MKZU2UtyJGT6lMluCy1YVZ9p0Gy/lu/F/+CcKFZ6tlMB6lUWRVVVo2a5muQjdIkq
	 BJGA13hGdcDVdtZ1uxQsd9WFBlAK6EO78CUgnyGY6/4v5dgl8q/ZjPRRPoyVZ/Q8wm
	 ZeGvWrAV0VfJCIvnHQQzIOGrLR0nnjtNMNUbMyPbD/F3+LUk8GvEoGK5Ax0WB/T6Gy
	 eKQbG3+PQFLLA5fKgjgbKsRBSL/vpvJdBfFZm0KRwivYuaYp6NBBGh0bO+vTO8Hb6Z
	 UyEQsDFEeInHg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/3] NFSD direct I/O read
Date: Mon, 22 Sep 2025 10:11:34 -0400
Message-ID: <20250922141137.632525-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The goal is to get the experimental read-side direct I/O
implementation merged sooner. We are still thinking through the
implications of mixing direct and buffered I/O when handling an
NFS WRITE that does not meet the dio alignment requirements.

Changes since v2:
* "Add array bounds-checking..." has been applied to nfsd-testing
* Add a page_len check before committing to use direct I/O

Changes since v1:
* Harden the loop that constructs the I/O bvec
* Address review comments

Changes from Mike's v9:
* The LOC introduced by the feature has been reduced considerably.
* A new trace point in nfsd_file_getattr reports each file's dio
  alignment parameters when it is opened.
* The direct I/O path has been taken out-of-line so that it may
  continue to be modified and optimized without perturbing the more
  commonly-used I/O paths.
* When an exported file system does not implement direct I/O, more
  commonly-used modes are employed instead to avoid returning
  EOPNOTSUPP unexpectedly.
* When NFSD_IO_DIRECT is selected, NFS READs of all sizes use direct
  I/O to provide better experimental data about small I/O workloads.

Chuck Lever (1):
  NFSD: Implement NFSD_IO_DIRECT for NFS READ

Mike Snitzer (2):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()

 fs/nfsd/debugfs.c       |  2 +
 fs/nfsd/filecache.c     | 34 ++++++++++++++++
 fs/nfsd/filecache.h     |  4 ++
 fs/nfsd/nfs4xdr.c       |  8 ++--
 fs/nfsd/nfsd.h          |  1 +
 fs/nfsd/nfsfh.c         |  4 ++
 fs/nfsd/trace.h         | 28 +++++++++++++
 fs/nfsd/vfs.c           | 89 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.h           |  2 +-
 include/trace/misc/fs.h | 22 ++++++++++
 10 files changed, 186 insertions(+), 8 deletions(-)

-- 
2.51.0


