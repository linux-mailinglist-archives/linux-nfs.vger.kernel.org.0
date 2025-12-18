Return-Path: <linux-nfs+bounces-17195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB09DCCD7D8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 094FF303C991
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEBB2D8792;
	Thu, 18 Dec 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJkwHjO3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C62D8370
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088835; cv=none; b=LtqURwlSEW9IqOAUcxqLvEyDjv1ElHObU4n2mjHDj5TNLMXInrt3Z0EO7L5Dnl53ELjDRaXUxr+0OLvmO6GmKP2UXJv18i2D73iRhWlw5lRy6xeArUlJTVLIDkty37lVZGwOdUbC3PsVkhWLB/i2TrnpOtzvMzfth3zIr6o0wSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088835; c=relaxed/simple;
	bh=4IsbP/Pqc2GmyZwMan4MOIQOdBcCjkwp8p9EOlYoUgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiZfSkzxDYgaR5BWtkIgM2g2p3HmVMTYiuiSs4KFlNfZpYUrFA5JO214HDxgQvTWWvPinFEf2HLHEt4n+yB/TDVicEghGkw4zcPm2jaMLRxNDvMdKm2l7Ao5PLXDHz1WAiFSzD00frcwCPOIYPO+YkjKK7bPUqlluQ5jq1M7LDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJkwHjO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DEDC113D0;
	Thu, 18 Dec 2025 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088835;
	bh=4IsbP/Pqc2GmyZwMan4MOIQOdBcCjkwp8p9EOlYoUgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJkwHjO3oJW8lDsXoDU/c/lJxM+bO9EA73pkOedgCEO9eug0piNCt+ly0GyfCaVZz
	 GjXP2Tyye+V4BmDp6QY+7VfL0G9B9426iVFlWy/VORx7g6JR0rYQKmb1Lzi9DlwVcx
	 eonyy1/flc0ukTiA2VR4A5KeVM+Vx6XlRkomnNH3ATJh6MXnSgljn/L2t8jTLSrLfr
	 LXWx4MC7Zj109gGeZ+dygVS3ppjLWFGTcnm3ZUlbdDJTOBol17SXfp/GIUgosEkK0w
	 QyxSYCApEiyBR4P4XkwRem21TvwvMAcRxaZQRdkyP7KTSZzMveT1OtKjkoIjC8FHnI
	 ChBqbKJjT89zQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 07/36] lockd: Remove lockd/debug.h
Date: Thu, 18 Dec 2025 15:13:17 -0500
Message-ID: <20251218201346.1190928-8-cel@kernel.org>
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

The lockd include structure has unnecessary indirection. The header
include/linux/lockd/debug.h is consumed only by fs/lockd/lockd.h,
creating an extra compilation dependency and making the code harder
to navigate.

Fold the debug.h definitions directly into lockd.h and remove the
now-redundant header. This reduces the include tree depth and makes
the debug-related definitions easier to find when working on lockd
internals.

Build-tested with lockd built as module and built-in.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h            | 24 +++++++++++++++++++++-
 include/linux/lockd/debug.h | 40 -------------------------------------
 2 files changed, 23 insertions(+), 41 deletions(-)
 delete mode 100644 include/linux/lockd/debug.h

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 0b427a725c23..535f752d5de1 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -16,9 +16,31 @@
 #include <linux/utsname.h>
 #include <linux/lockd/bind.h>
 #include <linux/lockd/xdr.h>
-#include <linux/lockd/debug.h>
+#include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/svc.h>
 
+/*
+ * Enable lockd debugging.
+ * Requires RPC_DEBUG.
+ */
+#undef ifdebug
+#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
+# define ifdebug(flag)		if (unlikely(nlm_debug & NLMDBG_##flag))
+#else
+# define ifdebug(flag)		if (0)
+#endif
+
+#define NLMDBG_SVC		0x0001
+#define NLMDBG_CLIENT		0x0002
+#define NLMDBG_CLNTLOCK		0x0004
+#define NLMDBG_SVCLOCK		0x0008
+#define NLMDBG_MONITOR		0x0010
+#define NLMDBG_CLNTSUBS		0x0020
+#define NLMDBG_SVCSUBS		0x0040
+#define NLMDBG_HOSTCACHE	0x0080
+#define NLMDBG_XDR		0x0100
+#define NLMDBG_ALL		0x7fff
+
 /*
  * Version string
  */
diff --git a/include/linux/lockd/debug.h b/include/linux/lockd/debug.h
deleted file mode 100644
index eede2ab5246f..000000000000
--- a/include/linux/lockd/debug.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/include/linux/lockd/debug.h
- *
- * Debugging stuff.
- *
- * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
- */
-
-#ifndef LINUX_LOCKD_DEBUG_H
-#define LINUX_LOCKD_DEBUG_H
-
-#include <linux/sunrpc/debug.h>
-
-/*
- * Enable lockd debugging.
- * Requires RPC_DEBUG.
- */
-#undef ifdebug
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define ifdebug(flag)		if (unlikely(nlm_debug & NLMDBG_##flag))
-#else
-# define ifdebug(flag)		if (0)
-#endif
-
-/*
- * Debug flags
- */
-#define NLMDBG_SVC		0x0001
-#define NLMDBG_CLIENT		0x0002
-#define NLMDBG_CLNTLOCK		0x0004
-#define NLMDBG_SVCLOCK		0x0008
-#define NLMDBG_MONITOR		0x0010
-#define NLMDBG_CLNTSUBS		0x0020
-#define NLMDBG_SVCSUBS		0x0040
-#define NLMDBG_HOSTCACHE	0x0080
-#define NLMDBG_XDR		0x0100
-#define NLMDBG_ALL		0x7fff
-
-#endif /* LINUX_LOCKD_DEBUG_H */
-- 
2.52.0


