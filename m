Return-Path: <linux-nfs+bounces-18576-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEDCI08pemlk3QEAu9opvQ
	(envelope-from <linux-nfs+bounces-18576-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E99A3AE2
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EA5F3038FFA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11A36922E;
	Wed, 28 Jan 2026 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUW3DX2d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422536BCE0
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613585; cv=none; b=IeF93E2jYGNMB7/PG+vUKPWj1nDutKFDJxV6S0Ip40j25O7knqNocgnebKOukjvwK7+/BPqffDcWLqVD4JilJWNCRhuRm4oruaqj4h9AI2TFG7ax9yXABDBJ/+aGAlxfM9KI5Gko9g9Ueh/JraEzaAc/LMNYEZboadnPpEQzWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613585; c=relaxed/simple;
	bh=OsjF8NIgqWAjhNwIk7L6VDXuLJFz7f3lzf2g1pGPFMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfuxBVMy94HN1S1h+FRtmQiyxh9GYPs5vHS7VOJE/MAhr+P1gLAqkcuLWs8ceNN3xWRXN1w1aP0ao5yztyqM8BU1w+8umQ0Y/Jus017Eu7sKAfrv6MHkPQF458YQqg6WcClW/5nMysTezulX6FkYOFzGOQ3XIMgJAZ0hAGJOr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUW3DX2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01720C116C6;
	Wed, 28 Jan 2026 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613585;
	bh=OsjF8NIgqWAjhNwIk7L6VDXuLJFz7f3lzf2g1pGPFMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUW3DX2dTEUPtONDXrapp8V2SXFTGL/qS9T/kT+n1imtqNJGtmXGnviCre68UZuGH
	 JYUEw4AK7aG/iShu5PKZf9Sr7g/2/q/ziHBMYezEPRwFW3HD4GXKjVKbahSNTOCu5P
	 PJrhbU21rSfcqLmJJu2YQYioiImarj2VnpausoecivvHC/Pu56SoH3VSWN3hSmMvu7
	 Q/mm34HzjzzZzvVAIq9sfL2zLAay1tw5YHfaXhyAYLUnaYFPuOnFJ2/gorIvufm6FR
	 wQqXTlyGh8Ld3TAatXZoJhCGlIR2PLPfH7S8LhQh9tSBqt4qZBhuojxHsKN3darZwg
	 iDK0pr93vPbzg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 10/14] lockd: Remove lockd/debug.h
Date: Wed, 28 Jan 2026 10:19:31 -0500
Message-ID: <20260128151935.1646063-11-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128151935.1646063-1-cel@kernel.org>
References: <20260128151935.1646063-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18576-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RSPAMD_EMAILBL_FAIL(0.00)[jlayton.kernel.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,swb.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11E99A3AE2
X-Rspamd-Action: no action

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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h            | 24 +++++++++++++++++++++-
 include/linux/lockd/debug.h | 40 -------------------------------------
 2 files changed, 23 insertions(+), 41 deletions(-)
 delete mode 100644 include/linux/lockd/debug.h

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 9bcf89765a69..460ccb701749 100644
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
+ * Requires CONFIG_SUNRPC_DEBUG.
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


