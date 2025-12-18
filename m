Return-Path: <linux-nfs+bounces-17193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C07BCCD7CB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AAFC3035A57
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2AA2D8DB1;
	Thu, 18 Dec 2025 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFFSShQY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F412C3248
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088834; cv=none; b=BGgLyZa9Qs1yz9jcAcbAf54wG7pZwaEqIblq43qeN7zkNRzcdpgpuwNDa4EPz0HT8xyGU+Y+24ssXR7s7a3DUE63amlBf2STYsU3vYMqKF+PMsSrn3/hCwuhXYjbbhbWf8GxcIDw0rAD7449ANRN/zSYkovKQZanSzXzYvi+1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088834; c=relaxed/simple;
	bh=GfSy+VcI0kwXgk+J7GLU4DcuUZBr9tfc5wn4iVOjXu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf64Wrj04EWxdop26dOKCALaA2H0btA4ttoFFh1WjQruXdKZ8CWcuRwwTbfCOIM1FMkWyUtbbmnwyueI9RBEEvfYomGfqWeLJcZuNXmu6xmdk5dm4YCqXsFkOoHtmjFnhcUilGBOnpwMUTIj3A9YOf7wxJ6uLY/CoB4+N4te5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFFSShQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F47AC4CEFB;
	Thu, 18 Dec 2025 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088833;
	bh=GfSy+VcI0kwXgk+J7GLU4DcuUZBr9tfc5wn4iVOjXu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFFSShQYOxp/H1+qakTCoUcMnHONiKDixH+YXmU1zIJ+1vmc9XpmPIkn1BUY/P8AX
	 oNd+gLRorQYj0vkzYAT3+JUBq5J46clXKQ2BFjSI95msQWnH35iNr5n2S798JumPzK
	 NnOESADmqX3d8qykTHzExDq/+iR1sXjpxAxHDPFrSuil+pbbso/tMx1oTn4OJGM08X
	 Aq8kZAgD2BNSkAn9VuJUnrlcfgWYIZLRl2Jz1HERanh72UsGrcdg8CLpIgOsxQEv6G
	 BfaSKeu5OrKO6eJEfO2mCW36kRKHqUgY0brVrbngBBZb+HN3+O32FgqF/2dLr8cwlE
	 YOiR2weY6nrDA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 05/36] lockd: Move share.h from include/linux/lockd/ to fs/lockd/
Date: Thu, 18 Dec 2025 15:13:15 -0500
Message-ID: <20251218201346.1190928-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The share.h header declares struct nlm_share and the DOS share
management functions used by the NLM server to implement NLM_SHARE
and NLM_UNSHARE operations. These interfaces are used exclusively
within the lockd subsystem and are not referenced by any external
code.

Relocating this header from include/linux/lockd/ to fs/lockd/
narrows the public API surface of the lockd module and prevents
out-of-tree code from depending on these internal interfaces.
Future refactoring of the share management implementation can
proceed without concern for breaking external consumers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 {include/linux => fs}/lockd/share.h | 8 +++-----
 fs/lockd/svc4proc.c                 | 2 +-
 fs/lockd/svcproc.c                  | 2 +-
 fs/lockd/svcshare.c                 | 3 ++-
 fs/lockd/svcsubs.c                  | 2 +-
 include/linux/lockd/lockd.h         | 2 ++
 6 files changed, 10 insertions(+), 9 deletions(-)
 rename {include/linux => fs}/lockd/share.h (85%)

diff --git a/include/linux/lockd/share.h b/fs/lockd/share.h
similarity index 85%
rename from include/linux/lockd/share.h
rename to fs/lockd/share.h
index 1f18a9faf645..d8f4ebd9c278 100644
--- a/include/linux/lockd/share.h
+++ b/fs/lockd/share.h
@@ -1,14 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/include/linux/lockd/share.h
- *
  * DOS share management for lockd.
  *
  * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
  */
 
-#ifndef LINUX_LOCKD_SHARE_H
-#define LINUX_LOCKD_SHARE_H
+#ifndef _LOCKD_SHARE_H
+#define _LOCKD_SHARE_H
 
 /*
  * DOS share for a specific file
@@ -29,4 +27,4 @@ __be32	nlmsvc_unshare_file(struct nlm_host *, struct nlm_file *,
 void	nlmsvc_traverse_shares(struct nlm_host *, struct nlm_file *,
 					       nlm_host_match_fn_t);
 
-#endif /* LINUX_LOCKD_SHARE_H */
+#endif /* _LOCKD_SHARE_H */
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 3c169d1ab163..73e6a2d5dba1 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -11,9 +11,9 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "share.h"
 #include "xdr4.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index a7dee25f8dd8..b32014ab6b88 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -11,9 +11,9 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "share.h"
 #include "xdr4.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index 88c81ce1148d..8e06840834c6 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -15,7 +15,8 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
+
+#include "share.h"
 
 static inline int
 nlm_cmp_owner(struct nlm_share *share, struct xdr_netobj *oh)
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index c1c21ee35853..f0bc78217583 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -16,11 +16,11 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <uapi/linux/nfs2.h>
 
+#include "share.h"
 #include "xdr4.h"
 
 #define NLMDBG_FACILITY		NLMDBG_SVCSUBS
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 9cffa21906bb..0ad66072d2a3 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -146,6 +146,8 @@ struct nlm_rqst {
 	void *	a_callback_data; /* sent to nlmclnt_operations callbacks */
 };
 
+struct nlm_share;
+
 /*
  * This struct describes a file held open by lockd on behalf of
  * an NFS client.
-- 
2.52.0


