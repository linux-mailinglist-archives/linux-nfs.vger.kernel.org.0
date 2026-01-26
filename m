Return-Path: <linux-nfs+bounces-18503-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLbtAdbGd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18503-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:56:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1728CD16
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 508F230180A7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089828D8FD;
	Mon, 26 Jan 2026 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLPUCMsr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50A28BAB9
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457346; cv=none; b=IO3akYZ7jMNt96GPrWCM7CGYo2fEDaThVvEnjTY1l2QMovfJ9SXd+bPgR4GSKB3rx3hLNTGSGX8c3345R6OVOf4E2bn/dFx3VXGiDnl0GdodS9e1FD68mQStlC+8k1WvMiraGZU802QkqnylH2CNWqoZKYAS5r3mnKjWYrakumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457346; c=relaxed/simple;
	bh=OsjF8NIgqWAjhNwIk7L6VDXuLJFz7f3lzf2g1pGPFMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAOmJiI+FCrltK3vGQxHJ/PHh5cd68fUgdSUxzCZVCoAriyM2mu9X30ok01KAf695/SP0PgvxMWdc3V4/k33RSqLdxgvtuoZLP+SKHkO9k+CysSgFrFtwzC8IcTsoVN5wvqguu/U/TXDJxg28p0ndIKI+JyNE3/KXhRS99TWfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLPUCMsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07E9C116C6;
	Mon, 26 Jan 2026 19:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457346;
	bh=OsjF8NIgqWAjhNwIk7L6VDXuLJFz7f3lzf2g1pGPFMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JLPUCMsrdItwgvLCzbmASs9U1E5IhHEtC3XpHMbNBTaZvSnAweoxer0leftTAPOoZ
	 67Tfshd32VB5tOFgeTR8EZ0UFyMWM30/+sTcymSDC+vmSjTg/Bwny1k3xGrhWKz/gR
	 WAKHID5bfZd13rTy5WsQXgyyzT9HM/d+WloD48uOg994GIG4Z3gDaeQZCsz5MAwORm
	 NDqp4kEGl8vPvvuZr3+/78t950jVPhygskdkA5A796yxv0bGIqLFhXFuQ+WQPIcu/8
	 7+jf4l8q179QX7NK6JkJQPALKcZ23lvHjeqRROsSTcuYvGtE1viVjEt/0O3Ic20xZg
	 LjZfvu5KrGZpg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 10/14] lockd: Remove lockd/debug.h
Date: Mon, 26 Jan 2026 14:55:31 -0500
Message-ID: <20260126195535.154697-11-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126195535.154697-1-cel@kernel.org>
References: <20260126195535.154697-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18503-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,swb.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B1728CD16
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


