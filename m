Return-Path: <linux-nfs+bounces-11408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1794AAA826A
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 21:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FC85A425E
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB327A471;
	Sat,  3 May 2025 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlD/oQx/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D212FF69;
	Sat,  3 May 2025 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302382; cv=none; b=mm5ssBCudp/irla54y54UO29iimv+XuDbE/GhIfwhbOV5mj9qtTO++C05uYSBmiY0GTU7YR7C/ghT6O17C9unPWRyjeT2VR8l/ry0Yn7mZUb+eZvCi5InYU+lqIHTUA61VcDbZBc8Hkh3pVmoTsbVqe4n1gf/12tVocep2Tfwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302382; c=relaxed/simple;
	bh=xdegIXPd1JWcMcmfp1mSeFksw70Hpw5bI8hkCWcHnJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMdspp2GTQmxW9BhzkvbS1NT3cM89BvFnjBWeXtEKeLT+kK/yjSygYqXQcOMBr9gz1rre97JKYLaUrdlCDth+tGZSgLsozzaHb9QFwDpufCjPKb9as37q5VPSSD2I32qX860EVPY3QrO26zohfNRQwxvKi+2g1bAx5GCL8vLfhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlD/oQx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89186C4CEE3;
	Sat,  3 May 2025 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302381;
	bh=xdegIXPd1JWcMcmfp1mSeFksw70Hpw5bI8hkCWcHnJA=;
	h=From:To:Cc:Subject:Date:From;
	b=tlD/oQx/KYK05XytravvvIDJqni8I6GmTqXKACB2mjXaXHyIc555oCckUEY3MwoEq
	 W/V9mUehvGbTXaCQqNv/KtKju/qV4z6uOPeUK71vetXYHZ3eZyEE7lWtLwa7Dj0jal
	 fyDo0au8OCZ+mRRN34uVsTZIe2sZA7Tao6WmTyf1HnxGRAnvKK7kNaCjrj5uZN3rN3
	 mGSPYVk00qiUXmAIezDGDZa9Xzb/JMVRdkzrSoN6APSbS/qhV/n2f0rP+bZSm+OE85
	 twN6ZkCSXyOAEruFsufgU834hvBYm+GB5Exkh5H0PbVkLLiNw16BVh+yAwcNjq9TcQ
	 3EE2Xv5A/1iOQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 00/18] nfsd: observability improvements
Date: Sat,  3 May 2025 15:59:18 -0400
Message-ID: <20250503195936.5083-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

These needed enough cosmetic changes that a v4 posting is warranted.

Some of these could add a few more arguments, but the basic
infrastructure is solid enough to run with.

Changes in v4:
- Replace usage of __array/memcpy for capturing sockaddrs
- Add NFSD_TRACE_PROC_CALL macros instead of re-using SVC_RQST_ENDPOINT
- Const-ify tracepoint pointer arguments
- Rename nfsd_setattr and nfsd_lookup_dentry tracepoints to include _vfs_
- Restructure the new READDIR tracepoint to capture the "count" argument
- Add non-empty patch descriptions to silence checkpatch.pl
- Link to v3: https://lore.kernel.org/r/20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org

Changes in v3:
- move most of the tracepoints into non-version specific nfsd/vfs.c calls
- rename them with a nfsd_vfs_* prefix
- remove the dprintks in separate patches
- Link to v2: https://lore.kernel.org/r/20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org

Changes in v2:
- Break tracepoints out into multiple patches
- Flesh out the tracepoints in these locations to display the same info
  as legacy dprintks.
- have all the tracepoints SVC_XPRT_ENDPOINT_* info
- update svc_xprt_dequeue tracepoint to show how long xprt was on queue
- Link to v1: https://lore.kernel.org/r/20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org

Chuck Lever (2):
  NFSD: Use sockaddr instead of a generic array
  NFSD: Add a Call equivalent to the NFSD_TRACE_PROC_RES macros

Jeff Layton (16):
  nfsd: add a tracepoint for nfsd_setattr
  nfsd: add a tracepoint to nfsd_lookup_dentry
  nfsd: add nfsd_vfs_create tracepoints
  nfsd: add tracepoint to nfsd_symlink
  nfsd: add tracepoint to nfsd_link()
  nfsd: add tracepoints for unlink events
  nfsd: add tracepoint to nfsd_rename
  nfsd: add tracepoint to nfsd_readdir
  nfsd: add tracepoint for getattr and statfs events
  nfsd: remove old v2/3 create path dprintks
  nfsd: remove old v2/3 SYMLINK dprintks
  nfsd: remove old LINK dprintks
  nfsd: remove REMOVE/RMDIR dprintks
  nfsd: remove dprintks for v2/3 RENAME events
  nfsd: remove legacy READDIR dprintks
  nfsd: remove legacy dprintks from GETATTR and STATFS codepaths

 fs/nfsd/nfs3proc.c      |  63 +--------
 fs/nfsd/nfs4proc.c      |   5 +
 fs/nfsd/nfsproc.c       |  35 +----
 fs/nfsd/trace.h         | 300 ++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.c           |  16 ++-
 include/trace/misc/fs.h |  21 +++
 6 files changed, 336 insertions(+), 104 deletions(-)

-- 
2.49.0


