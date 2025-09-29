Return-Path: <linux-nfs+bounces-14771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBCBA9E41
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFDA3BD8E5
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845830B520;
	Mon, 29 Sep 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjlA9H+Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44492EAB66
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161409; cv=none; b=oQr3twxZSeT3H4OzRVIDB9riMSG8yyBCS7uaoLCkG4RdjIXciQxR1eAPMwULX2tlOHB7PAZhDlbX3k0WeNDjUc2KvhMoAbPE9nTbbBNbG6ff4fzrtZhc7Zuwd80L63cCOAKwxoNKfN/mezVsQpAwuAWcTVK8zy5DRLMr4hWtSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161409; c=relaxed/simple;
	bh=hFnEZ3LKUVpOA/KBX/RxCll17t5W2D5/xZ09Kdc16Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLCBsWTWKvGoYeOIllX2EPisYb1qnHSlaqkp7zr4mrH49A2KtHlDm6n7UVaoj9Eewtd/ePEaOsjjh/JbOixUyDUJkR39tmCDdPfmIP0fL/rUEJUmYvn2rPI448kL1G/LpaFOk2GV0eUDyWjelmp6BkLquiBF1sNDVds/ao/CXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjlA9H+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BE6C4CEF4;
	Mon, 29 Sep 2025 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161408;
	bh=hFnEZ3LKUVpOA/KBX/RxCll17t5W2D5/xZ09Kdc16Wo=;
	h=From:To:Cc:Subject:Date:From;
	b=FjlA9H+Qo83YXQu0hESNrfMNl8ftDchsfZhxej9VOR4QUYHK9hbcbyDdV+Dt9WJZc
	 YGYEwx6/VaDzgqosyABt+TAx8XfzrkidC5qcqb9Od9Xh2TctOmVmcdiux/q8vFTHQw
	 HuM8WL9Sks1m4uwNdA6LeCD7yql7DpSrVC9dBrFzW1nXsj/WLnHlZVdWzsMfI/P+PV
	 DmCElmf2I0hBgU6C0vC9wwBnoWcvK9DymXqDqWaaewFl+V18dM6czElG6Wjd+V+XR+
	 6jbXRhSfIjmAwH5JmaIF7WUg6kQNRxLaK9dBMnTZ+eNQukx+nxBMLTX27ACIpm/fHL
	 +pdYMBMvXYbHg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 0/6] NFSD direct I/O read
Date: Mon, 29 Sep 2025 11:56:40 -0400
Message-ID: <20250929155646.4818-1-cel@kernel.org>
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
  NFSD: Relocate the xdr_reserve_space_vec() call site
  NFSD: Implement NFSD_IO_DIRECT for NFS READ
  NFSD: Prevent a NULL pointer dereference in fh_getattr()
  NFSD: Ignore vfs_getattr() failure in nfsd_file_get_dio_attrs()

Mike Snitzer (2):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()

 fs/nfsd/debugfs.c       |  2 +
 fs/nfsd/filecache.c     | 33 +++++++++++++++
 fs/nfsd/filecache.h     |  4 ++
 fs/nfsd/nfs4xdr.c       | 28 +++++++++----
 fs/nfsd/nfsd.h          |  1 +
 fs/nfsd/nfsfh.c         |  3 ++
 fs/nfsd/trace.h         | 28 +++++++++++++
 fs/nfsd/vfs.c           | 92 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.h           |  2 +-
 include/trace/misc/fs.h | 22 ++++++++++
 10 files changed, 203 insertions(+), 12 deletions(-)

-- 
2.51.0


