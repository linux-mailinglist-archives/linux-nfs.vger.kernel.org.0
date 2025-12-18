Return-Path: <linux-nfs+bounces-17189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A0CCD7B9
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7942F302BC64
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0963F2D3A6A;
	Thu, 18 Dec 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5YN7fPC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A72C08C0
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088830; cv=none; b=RQqszGBdgv6Bf+aFqHx/BrySFf3uPrtoe7kpqFCGhVG/4SRu2aaedbldh+na1SwQSZuFRyiqBu1/kblTsLoxsoOjjZiKMTvARehmMz7HvdkMjpw7TQ0Wv6Bt6NVu/EclKQh9sZOhllkTrGVD+Axww9HzwdCrnU6g9CtVory9e1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088830; c=relaxed/simple;
	bh=bDJLqoiGLYQLHmvcrsr5NXstEcy2Oaw8Z20MqBQ1ciE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsbB61XnF6pR1WwkLGWTlXcX/Z722o/dJVO6m4G/YiAdgr7/Ls8KmiiSolhXcpVdqSbdmwKus7xRb2wtN1QMWvpPSa5v9dvwXYm6/hCxt0QbcKhc1gWz7i57GqUnTPJ+sxa6iFCSEuvH33IeGbGg1BBHk7qHo87UJZKcb4EMrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5YN7fPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E76C4CEFB;
	Thu, 18 Dec 2025 20:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088829;
	bh=bDJLqoiGLYQLHmvcrsr5NXstEcy2Oaw8Z20MqBQ1ciE=;
	h=From:To:Cc:Subject:Date:From;
	b=A5YN7fPCbAX9wuL2pzBOzWIcUwIn7t7FOv6aktQvJaJGA08XlLEznpR2VUoCC96ET
	 LNeBOFeUXOqJ13Z/FEXjP2xdna6k5ekn7jjri8DxCrm+aBdbvzEwAG8p2ePxZs05Ub
	 tbT/C8utKZP4eUBEWJJzuThhZU0VsorV4zJQCIeFJ/+nS7UP6gL/Ts4a7glsWFGpsO
	 r5NsMRc7YGB6SJRDHo/xxpEHU5ZoSeMEsoJtRcjhhATP126bwadrLEo5O4fcZAnmMD
	 17iJQyFOjp0cNEN1TO+/4T1+7rOw4xz0vjOMQxNXgTYu5rXtqKYkStOBlqpdFtrjyR
	 bZlB4kIQrTc6g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 00/36] Clarify module API boundaries
Date: Thu, 18 Dec 2025 15:13:10 -0500
Message-ID: <20251218201346.1190928-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The first nine patches in this series refactor the lockd code base
to clearly separate its public API from internal implementation
details.

The lockd subsystem currently exposes internal implementation headers
through include/linux/lockd/, creating implicit API contracts that
complicate maintenance. External consumers such as NFSD and the NFS
client have developed dependencies on internal structures like struct
nlm_host, and wire protocol constants leak into high-level module
interfaces.

These patches work to establish clean architectural boundaries. The
public API in include/linux/lockd/ is reduced to bind.h and nlm.h,
which define the contract between lockd and its consumers. Private
implementation details including XDR definitions, share management,
and host structures are relocated to fs/lockd/ where they belong.
Layering violations are corrected: the NFS client now uses accessor
helpers instead of dereferencing internal structures, and nlm_fopen()
returns errno values instead of wire protocol codes.

These changes enable subsequent work to modernize the NLMv4 XDR
layer using xdrgen without risk of breaking external consumers.
This work appears in the remaining patches in this series, which
are presented here only to provide context for the API adjustments.
No need to review those closely just yet.

The series is based on commit 771cfff228fc in the public
nfsd-testing branch.


Chuck Lever (36):
  lockd: Have nlm_fopen() return errno values
  lockd: Relocate nlmsvc_unlock API declarations
  NFS: Use nlmclnt_rpc_clnt() helper to retrieve nlm_host's rpc_clnt
  lockd: Move xdr4.h from include/linux/lockd/ to fs/lockd/
  lockd: Move share.h from include/linux/lockd/ to fs/lockd/
  lockd: Relocate include/linux/lockd/lockd.h
  lockd: Remove lockd/debug.h
  lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
  Documentation: Add the RPC language description of NLM version 4
  lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
  lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure
  lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 CANCEL procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure
  lockd: Refactor nlm4svc_callback()
  lockd: Use xdrgen XDR functions for the NLMv4 TEST_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_MSG procedure
  lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
  lockd: Convert server-side NLMPROC4_TEST_RES to use xdrgen
  lockd: Convert server-side NLMPROC4_LOCK_RES to use xdrgen
  lockd: Convert server-side NLMPROC4_CANCEL_RES to use xdrgen
  lockd: Convert server-side NLMPROC4_UNLOCK_RES to use xdrgen
  lockd: Convert server-side NLMPROC4_GRANTED_RES to use xdrgen
  lockd: Use xdrgen XDR functions for the NLMv4 SM_NOTIFY procedure
  lockd: Convert server-side undefined procedures to xdrgen
  lockd: Hoist file_lock init out of nlm4svc_decode_shareargs()
  lockd: Update share_file helpers
  lockd: Use xdrgen XDR functions for the NLMv4 SHARE procedure
  lockd: Use xdrgen XDR functions for the NLMv4 UNSHARE procedure
  lockd: Use xdrgen XDR functions for the NLMv4 NM_LOCK procedure
  lockd: Use xdrgen XDR functions for the NLMv4 FREE_ALL procedure
  lockd: Remove utilities that are no longer used
  lockd: Remove dead code from fs/lockd/xdr4.c

 Documentation/sunrpc/xdr/nlm4.x     |  211 ++++
 fs/lockd/Makefile                   |   21 +-
 fs/lockd/clnt4xdr.c                 |    5 +-
 fs/lockd/clntlock.c                 |    2 +-
 fs/lockd/clntproc.c                 |    2 +-
 fs/lockd/clntxdr.c                  |    5 +-
 fs/lockd/host.c                     |    2 +-
 {include/linux => fs}/lockd/lockd.h |   49 +-
 fs/lockd/mon.c                      |    2 +-
 fs/lockd/nlm4xdr_gen.c              |  724 +++++++++++++
 fs/lockd/nlm4xdr_gen.h              |   32 +
 {include/linux => fs}/lockd/share.h |   16 +-
 fs/lockd/svc.c                      |    2 +-
 fs/lockd/svc4proc.c                 | 1562 +++++++++++++++++----------
 fs/lockd/svclock.c                  |    5 +-
 fs/lockd/svcproc.c                  |   13 +-
 fs/lockd/svcshare.c                 |   40 +-
 fs/lockd/svcsubs.c                  |   43 +-
 fs/lockd/trace.h                    |    3 +-
 fs/lockd/xdr.c                      |    3 +-
 {include/linux => fs}/lockd/xdr.h   |   12 +-
 fs/lockd/xdr4.c                     |  347 ------
 fs/lockd/xdr4.h                     |  104 ++
 fs/nfs/sysfs.c                      |   10 +-
 fs/nfsd/lockd.c                     |   51 +-
 fs/nfsd/nfsctl.c                    |    2 +-
 include/linux/lockd/bind.h          |   17 +-
 include/linux/lockd/debug.h         |   40 -
 include/linux/lockd/xdr4.h          |   43 -
 include/linux/sunrpc/xdrgen/nlm4.h  |  231 ++++
 30 files changed, 2513 insertions(+), 1086 deletions(-)
 create mode 100644 Documentation/sunrpc/xdr/nlm4.x
 rename {include/linux => fs}/lockd/lockd.h (94%)
 create mode 100644 fs/lockd/nlm4xdr_gen.c
 create mode 100644 fs/lockd/nlm4xdr_gen.h
 rename {include/linux => fs}/lockd/share.h (63%)
 rename {include/linux => fs}/lockd/xdr.h (94%)
 delete mode 100644 fs/lockd/xdr4.c
 create mode 100644 fs/lockd/xdr4.h
 delete mode 100644 include/linux/lockd/debug.h
 delete mode 100644 include/linux/lockd/xdr4.h
 create mode 100644 include/linux/sunrpc/xdrgen/nlm4.h

-- 
2.52.0


