Return-Path: <linux-nfs+bounces-15045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E19BC54F4
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB6644F8819
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE623287512;
	Wed,  8 Oct 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCMj2xC6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891672874F8
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931554; cv=none; b=ZkilCOtsxfDDIfNp4faX4IFkBGWC4HkxL6AD7sDgpDhMxPzkhGWHV5NDmSzOQIJYvuiLpGPTuOO1327alI4B5b4+dsohJl9k28BSTpVPqN7LMT3TmlCY1NFUIXvfBrQXNOIr93u1QLoddepW4d9Omw1z24ONd6ha7u8W57jiwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931554; c=relaxed/simple;
	bh=JQ0n4jTh5seoq/uKm4pMZ1OEHZ9aaCvBcl2HmmUyx08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZA0qqw6t2kzZtQND0EHwdEoMx1sjWLIjtjXrq68cu8DeP0ni4pTAHYoYBzJRQ4nolFXi1YrwMzP/8bcyZhODaPXpifjynUfyM+3bpRbUfpFsl++EFtir86m98kVsmkHYRL50OCJOKoB3DPSMw6QLw0hzn///Re5NI9k2bCEOzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCMj2xC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA55C4CEE7;
	Wed,  8 Oct 2025 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931554;
	bh=JQ0n4jTh5seoq/uKm4pMZ1OEHZ9aaCvBcl2HmmUyx08=;
	h=From:To:Cc:Subject:Date:From;
	b=pCMj2xC66z3g7MLrh3evRjpZlTfF4P3/px7TB/iSeLD3dn8GY38Z27w3oJCqmA5xx
	 K+AeJoaTzdifwv1UrW9aAuMcsIuThia5jgfCrcntof5G5HwdV0eOtnowTSVm6FHIGx
	 HUBWjMqb1U7O2BcepGHrXaAGER93AV9odnHTTD4b+gwXQvbjYRWZkq3cDGSJWlUYB6
	 bsKN8GhTzWXpPCRaY3eGgrOE5Zufuewq003zd5FVPxKaVBlgFgq8Pofm8p3MkbLwVJ
	 ehi+CvKxr5pCDOrnzFZ4Wt2mdMmT10GbN0cVnc1bS1/2KXmrKg3M5Yb8hhYt/OCNGQ
	 wI1tMz5EnYJQQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 0/6] NFSD direct I/O read
Date: Wed,  8 Oct 2025 09:52:24 -0400
Message-ID: <20251008135230.2629-1-cel@kernel.org>
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

Changes since v5:
* Rebased on what's now in v6.18-rc1
* getattr failures now properly cleaned up
* Fix patches have been moved to the front of the series

Changes since v4:
* Additional Reviewed-by's; applying v5 to nfsd-testing
* Address Christoph's comments on 4/4
* Suggest a couple of clean-ups for 1/4

Changes since v3:
* Move xdr_reserve_space_vec() call to preserve the page_len value
* Note that "add STATX_DIOALIGN and STATX_DIO_READ_ALIGN ..."
  remains exactly the same as it was in the v3 series

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

Chuck Lever (4):
  NFSD: Prevent a NULL pointer dereference in fh_getattr()
  NFSD: Recover from vfs_getattr() failure in nfsd_file_get_dio_attrs()
  NFSD: Relocate the xdr_reserve_space_vec() call site
  NFSD: Implement NFSD_IO_DIRECT for NFS READ

Mike Snitzer (1):
  NFSD: pass nfsd_file to nfsd_iter_read()

NeilBrown (1):
  nfsd: fix refcount leak in nfsd_set_fh_dentry()

 fs/nfsd/debugfs.c   |  2 +
 fs/nfsd/filecache.c |  5 ++-
 fs/nfsd/nfs4xdr.c   | 28 ++++++++++----
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/nfsfh.c     |  9 ++---
 fs/nfsd/trace.h     |  1 +
 fs/nfsd/vfs.c       | 90 +++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.h       |  2 +-
 8 files changed, 120 insertions(+), 18 deletions(-)

-- 
2.51.0


