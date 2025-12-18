Return-Path: <linux-nfs+bounces-17194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D342CCD7CF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ECD6303A097
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B02D838E;
	Thu, 18 Dec 2025 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vP/8dw4S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E62D8370
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088834; cv=none; b=P2w/pFNr/FT9hs7mcCL4656Tz7z9AhAKpXQN3I6oCTazxCWu9ZnpqeP+t8dSNVkHtr+HmEZ8gI6flawwCGELm538iZX9qwfK1b1ZhvbkFRf3uRTXPAo7SPbdjjwdL/bKFQPfKi7oPWXA04ALE02r28L2IvnVy8hJzqYYRX5bJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088834; c=relaxed/simple;
	bh=h3nKVkTRq4MEK85me8Juy2EU60mFvRV0xxzZezzuc/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZO9aNEtGQ7V9GDwlwqu0gDBJBlvWtPIC94YKbq9iYAUpG+dxQNoca5CbJz18IRY7pw526Xzuovngl3R8OqZ8uzdE/FCcpCnlJhFzOcD3Wr4GA4PWSt69n1q8I50dPlFlwRIuqAPJknBNM9mpVMp8HFFjAnHIZtfgU8BCoLBREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vP/8dw4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ADDC116D0;
	Thu, 18 Dec 2025 20:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088834;
	bh=h3nKVkTRq4MEK85me8Juy2EU60mFvRV0xxzZezzuc/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vP/8dw4SkGtswBkcvFHdOW237nQZImFnb4dE4EDKpExSQ2AAaR1upAMEXzynPDpbh
	 jHK6uiAzijfTKt/mInfr6g98AyknAQuzy8cArRJCkBl5xo/XpSIaxxj995P7SsPqMm
	 5zP/HVjj1CaO9VerHPdRkc01UY/pyeQytGy91FN/CgusYnf2OKzO2xVQUOeUQ7uTiT
	 +WBRsHImOU2ykOU3QuJ+z5CCQT9lRdX1GpaKm6Nc6AZ7p6WhjAiJXHGs7rYEtikjGb
	 zuY5feznYAtIbPydf83ppEkqgbfg8MyVBvWyH91UMTx4cOtt51IGhB5rnQ62B50JTu
	 /dLxCkkKC/70w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 06/36] lockd: Relocate include/linux/lockd/lockd.h
Date: Thu, 18 Dec 2025 15:13:16 -0500
Message-ID: <20251218201346.1190928-7-cel@kernel.org>
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

Headers placed in include/linux/ form part of the kernel's internal
API and signal to subsystem maintainers that other parts of the
kernel may depend on them. By moving lockd.h into fs/lockd/, lockd
becomes a more self-contained module whose internal interfaces are
clearly distinguished from its public contract with the rest of the
kernel. This relocation addresses a long-standing XXX comment in
the header itself that acknowledged the file's misplacement. Future
changes to lockd internals can now proceed with confidence that
external consumers are not inadvertently coupled to implementation
details.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c                 |  3 ++-
 fs/lockd/clntlock.c                 |  2 +-
 fs/lockd/clntproc.c                 |  2 +-
 fs/lockd/clntxdr.c                  |  3 ++-
 fs/lockd/host.c                     |  2 +-
 {include/linux => fs}/lockd/lockd.h | 12 +++---------
 fs/lockd/mon.c                      |  2 +-
 fs/lockd/svc.c                      |  2 +-
 fs/lockd/svc4proc.c                 |  2 +-
 fs/lockd/svclock.c                  |  3 ++-
 fs/lockd/svcproc.c                  |  2 +-
 fs/lockd/svcshare.c                 |  2 +-
 fs/lockd/svcsubs.c                  |  2 +-
 fs/lockd/trace.h                    |  3 ++-
 fs/lockd/xdr.c                      |  3 +--
 fs/lockd/xdr4.c                     |  2 +-
 16 files changed, 22 insertions(+), 25 deletions(-)
 rename {include/linux => fs}/lockd/lockd.h (98%)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 23896073c7e5..61ee5fa6dfa4 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -13,7 +13,8 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/stats.h>
-#include <linux/lockd/lockd.h>
+
+#include "lockd.h"
 
 #include <uapi/linux/nfs3.h>
 
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index a7e0519ec024..8a38d1b193fc 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -15,9 +15,9 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svc_xprt.h>
-#include <linux/lockd/lockd.h>
 #include <linux/kthread.h>
 
+#include "lockd.h"
 #include "trace.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index cebcc283b7ce..9be003bbf5ad 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -18,8 +18,8 @@
 #include <linux/freezer.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
-#include <linux/lockd/lockd.h>
 
+#include "lockd.h"
 #include "trace.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 30aa5af219d4..56a2adf4f717 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -15,7 +15,8 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/stats.h>
-#include <linux/lockd/lockd.h>
+
+#include "lockd.h"
 
 #include <uapi/linux/nfs2.h>
 
diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 5e6877c37f73..4a6f596f7c73 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -16,13 +16,13 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/svc.h>
-#include <linux/lockd/lockd.h>
 #include <linux/mutex.h>
 
 #include <linux/sunrpc/svc_xprt.h>
 
 #include <net/ipv6.h>
 
+#include "lockd.h"
 #include "netns.h"
 
 #define NLMDBG_FACILITY		NLMDBG_HOSTCACHE
diff --git a/include/linux/lockd/lockd.h b/fs/lockd/lockd.h
similarity index 98%
rename from include/linux/lockd/lockd.h
rename to fs/lockd/lockd.h
index 0ad66072d2a3..0b427a725c23 100644
--- a/include/linux/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -1,16 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/include/linux/lockd/lockd.h
- *
- * General-purpose lockd include file.
- *
  * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
-#ifndef LINUX_LOCKD_LOCKD_H
-#define LINUX_LOCKD_LOCKD_H
-
-/* XXX: a lot of this should really be under fs/lockd. */
+#ifndef _LOCKD_LOCKD_H
+#define _LOCKD_LOCKD_H
 
 #include <linux/exportfs.h>
 #include <linux/in.h>
@@ -385,4 +379,4 @@ static inline int nlm_compare_locks(const struct file_lock *fl1,
 
 extern const struct lock_manager_operations nlmsvc_lock_operations;
 
-#endif /* LINUX_LOCKD_LOCKD_H */
+#endif /* _LOCKD_LOCKD_H */
diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
index b8fc732e1c67..3d3ee88ca4dc 100644
--- a/fs/lockd/mon.c
+++ b/fs/lockd/mon.c
@@ -16,10 +16,10 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/xprtsock.h>
 #include <linux/sunrpc/svc.h>
-#include <linux/lockd/lockd.h>
 
 #include <linux/unaligned.h>
 
+#include "lockd.h"
 #include "netns.h"
 
 #define NLMDBG_FACILITY		NLMDBG_MONITOR
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index d68afa196535..fa57842ada71 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -36,9 +36,9 @@
 #include <net/ip.h>
 #include <net/addrconf.h>
 #include <net/ipv6.h>
-#include <linux/lockd/lockd.h>
 #include <linux/nfs.h>
 
+#include "lockd.h"
 #include "netns.h"
 #include "procfs.h"
 #include "netlink.h"
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 73e6a2d5dba1..b6d1dcddd8a6 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -10,9 +10,9 @@
 
 #include <linux/types.h>
 #include <linux/time.h>
-#include <linux/lockd/lockd.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "lockd.h"
 #include "share.h"
 #include "xdr4.h"
 
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 658294528324..d64326e9e95e 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -29,7 +29,8 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/nlm.h>
-#include <linux/lockd/lockd.h>
+
+#include "lockd.h"
 
 #include "xdr4.h"
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index b32014ab6b88..0e1ac985c757 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -10,9 +10,9 @@
 
 #include <linux/types.h>
 #include <linux/time.h>
-#include <linux/lockd/lockd.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "lockd.h"
 #include "share.h"
 #include "xdr4.h"
 
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index 8e06840834c6..8675ac80ab16 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -14,8 +14,8 @@
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
-#include <linux/lockd/lockd.h>
 
+#include "lockd.h"
 #include "share.h"
 
 static inline int
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index f0bc78217583..6480c2df8df3 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -15,11 +15,11 @@
 #include <linux/mutex.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/addr.h>
-#include <linux/lockd/lockd.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <uapi/linux/nfs2.h>
 
+#include "lockd.h"
 #include "share.h"
 #include "xdr4.h"
 
diff --git a/fs/lockd/trace.h b/fs/lockd/trace.h
index 7461b13b6e74..7214d7e96a42 100644
--- a/fs/lockd/trace.h
+++ b/fs/lockd/trace.h
@@ -8,7 +8,8 @@
 #include <linux/tracepoint.h>
 #include <linux/crc32.h>
 #include <linux/nfs.h>
-#include <linux/lockd/lockd.h>
+
+#include "lockd.h"
 
 #ifdef CONFIG_LOCKD_V4
 #define NLM_STATUS_LIST					\
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index adfcce2bf11b..5aac49d1875a 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -15,13 +15,12 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/stats.h>
-#include <linux/lockd/lockd.h>
 
 #include <uapi/linux/nfs2.h>
 
+#include "lockd.h"
 #include "svcxdr.h"
 
-
 static inline loff_t
 s32_to_loff_t(__s32 offset)
 {
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 5b1e15977697..f57d4881d5f1 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -16,8 +16,8 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/stats.h>
-#include <linux/lockd/lockd.h>
 
+#include "lockd.h"
 #include "svcxdr.h"
 #include "xdr4.h"
 
-- 
2.52.0


