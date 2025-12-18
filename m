Return-Path: <linux-nfs+bounces-17192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 445A1CCD7BD
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 995103023E9F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7782D8796;
	Thu, 18 Dec 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNA1hoeV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE82D8792
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088833; cv=none; b=hHZA1Clh6gXidUbK5SNhmllwwaS2gFZZpoQDlMesT9G+tiakflDh7R6HVH41RRIPLqNs3wa2LXFv6FdZz0CeiKoZQy1lyZ/290gF6bik4QCaHbeDUL4KsCuSWqJNALA4MNFrbIGXUCA3hNdBERH87HojpfiJ+V6iAxM5rF1Ajng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088833; c=relaxed/simple;
	bh=vnLDwpjpqScldErhMWYkjsnoCWP2ZWRToJXHQSjW3Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcHVAXYSrWpXdmHugWXMhJaCsX1HxM7+8H/pvvnfYgT9EhWrD44qwOuPyTuqkv2keRBbkj3B4jOw/3NJ1btLe0ip3fH2qpilLzEYXOBtaWuqiRpgGjkOpWYhqc25DAbefhBK/wRbHDndPIAPpAjVp0b4EbJIL3zbYXm/rt0MxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNA1hoeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E73C16AAE;
	Thu, 18 Dec 2025 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088832;
	bh=vnLDwpjpqScldErhMWYkjsnoCWP2ZWRToJXHQSjW3Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNA1hoeVeueplT2Ujjl9kNwXIjoGWCy8VyvYHWFE/HW+CxXX2Ygqz1K6Jsbxnp8uP
	 7q1Tpq1WzGPlY0GfaLe/JUYU3kcvkAycQwaoXw2zA3vzOhLrDHevETJ7DdGMRpMcub
	 Y9DhexgbKrXtPf5YwTSVcCiEG4V7hxmKT3n61DpyTMI0/ybufOUCcZq7Axua/07qcQ
	 cx97kS4OcDhJcwJg7Bry/QvJ2lwe0hFkGBuUpx9brBQj7DIjPfzQqlAY6TM0ufB2Y5
	 UZHmkurhBJ1xpJVBkyzIXH0T7H/x4j2z6qFfd/D3YrHHd17vSuRLOlLjZDgnD8rqms
	 M6GEzYpi4GV/g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 04/36] lockd: Move xdr4.h from include/linux/lockd/ to fs/lockd/
Date: Thu, 18 Dec 2025 15:13:14 -0500
Message-ID: <20251218201346.1190928-5-cel@kernel.org>
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

The xdr4.h header declares NLMv4-specific XDR encoder/decoder
functions and error codes that are used exclusively within the
lockd subsystem. Moving it from include/linux/lockd/ to fs/lockd/
clarifies the intended scope of these declarations and prevents
external code from depending on lockd-internal interfaces.

This change reduces the public API surface of the lockd module
and makes it easier to refactor NLMv4 internals without risk of
breaking out-of-tree consumers. The header's contents are
implementation details of the NLMv4 wire protocol handling, not
a contract with other kernel subsystems.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c                |  2 ++
 fs/lockd/clntxdr.c                 |  2 ++
 fs/lockd/svc4proc.c                |  2 ++
 fs/lockd/svclock.c                 |  2 ++
 fs/lockd/svcproc.c                 |  2 ++
 fs/lockd/svcsubs.c                 |  2 ++
 fs/lockd/xdr4.c                    |  1 +
 {include/linux => fs}/lockd/xdr4.h | 13 +++----------
 include/linux/lockd/bind.h         |  3 ---
 include/linux/lockd/lockd.h        |  3 ---
 10 files changed, 16 insertions(+), 16 deletions(-)
 rename {include/linux => fs}/lockd/xdr4.h (87%)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 527458db4525..23896073c7e5 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -17,6 +17,8 @@
 
 #include <uapi/linux/nfs3.h>
 
+#include "xdr4.h"
+
 #define NLMDBG_FACILITY		NLMDBG_XDR
 
 #if (NLMCLNT_OHSIZE > XDR_MAX_NETOBJ)
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 6ea3448d2d31..30aa5af219d4 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -19,6 +19,8 @@
 
 #include <uapi/linux/nfs2.h>
 
+#include "xdr4.h"
+
 #define NLMDBG_FACILITY		NLMDBG_XDR
 
 #if (NLMCLNT_OHSIZE > XDR_MAX_NETOBJ)
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4b6f18d97734..3c169d1ab163 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -14,6 +14,8 @@
 #include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "xdr4.h"
+
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
 /*
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 712df1e025d8..658294528324 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -31,6 +31,8 @@
 #include <linux/lockd/nlm.h>
 #include <linux/lockd/lockd.h>
 
+#include "xdr4.h"
+
 #define NLMDBG_FACILITY		NLMDBG_SVCLOCK
 
 #ifdef CONFIG_LOCKD_V4
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 5817ef272332..a7dee25f8dd8 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -14,6 +14,8 @@
 #include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "xdr4.h"
+
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
 #ifdef CONFIG_LOCKD_V4
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 543f8d7e1b2b..c1c21ee35853 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -21,6 +21,8 @@
 #include <linux/mount.h>
 #include <uapi/linux/nfs2.h>
 
+#include "xdr4.h"
+
 #define NLMDBG_FACILITY		NLMDBG_SVCSUBS
 
 
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index e343c820301f..5b1e15977697 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -19,6 +19,7 @@
 #include <linux/lockd/lockd.h>
 
 #include "svcxdr.h"
+#include "xdr4.h"
 
 static inline s64
 loff_t_to_s64(loff_t offset)
diff --git a/include/linux/lockd/xdr4.h b/fs/lockd/xdr4.h
similarity index 87%
rename from include/linux/lockd/xdr4.h
rename to fs/lockd/xdr4.h
index 72831e35dca3..0fe88e317da6 100644
--- a/include/linux/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -1,19 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/include/linux/lockd/xdr4.h
- *
  * XDR types for the NLM protocol
  *
  * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
-#ifndef LOCKD_XDR4_H
-#define LOCKD_XDR4_H
-
-#include <linux/fs.h>
-#include <linux/nfs.h>
-#include <linux/sunrpc/xdr.h>
-#include <linux/lockd/xdr.h>
+#ifndef _LOCKD_XDR4_H
+#define _LOCKD_XDR4_H
 
 /* error codes new to NLMv4 */
 #define	nlm4_deadlock		cpu_to_be32(NLM_DEADLCK)
@@ -40,4 +33,4 @@ bool	nlm4svc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
 extern const struct rpc_version nlm_version4;
 
-#endif /* LOCKD_XDR4_H */
+#endif /* _LOCKD_XDR4_H */
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index e5ba61b7739f..be11b9795934 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -13,9 +13,6 @@
 #include <linux/lockd/nlm.h>
 /* need xdr-encoded error codes too, so... */
 #include <linux/lockd/xdr.h>
-#ifdef CONFIG_LOCKD_V4
-#include <linux/lockd/xdr4.h>
-#endif
 
 /* Dummy declarations */
 struct svc_rqst;
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index e31893ab4ecd..9cffa21906bb 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -22,9 +22,6 @@
 #include <linux/utsname.h>
 #include <linux/lockd/bind.h>
 #include <linux/lockd/xdr.h>
-#ifdef CONFIG_LOCKD_V4
-#include <linux/lockd/xdr4.h>
-#endif
 #include <linux/lockd/debug.h>
 #include <linux/sunrpc/svc.h>
 
-- 
2.52.0


