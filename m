Return-Path: <linux-nfs+bounces-18370-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HdqHq/Dc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18370-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5979CC1
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C821C300BB98
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F9254B03;
	Fri, 23 Jan 2026 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSvrvc/g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5E248176
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194390; cv=none; b=fIIvdsrc9dgNerk6nCCM5l0EdB4GyrY7Bflilx2Z5Q4zJebgZ1v+fU8ozHWIiv0IwXClw0fb9N1k5FQwExACoo1T7ZPTgl2Hv5bCy2jrJWzHejKwNwOlWe2k+iwrYwIq2Cp2bh6/Ssfgw2oDEVANZDWbBrNynF3pWUG6DQHnckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194390; c=relaxed/simple;
	bh=tlYPZXoS4k4ks/9XtwpvNx1NJcnlsSZ79Z4DZkMcgGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDIh5YDyP6dCjR0vmWrmr1anPmm38UKqSo4QxfLuYucvj9wdC+JMzC+PFeBqXK3qhwl9DtXpqziOkS9LRiPE+Q3yKQgBN+NDK+wQEUDXWS5C/ozC1/9Tqc56nmgoPZYVPXIL5J+9tVl/p3CuvG1FCasu71WRCqLr3pD3InZyAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSvrvc/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6B6C19423;
	Fri, 23 Jan 2026 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194390;
	bh=tlYPZXoS4k4ks/9XtwpvNx1NJcnlsSZ79Z4DZkMcgGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSvrvc/gj5rmNglhojr5nro647f2ZYaJYr5WHA+eI96gIW2lPYyIJG1hEtTV/c06W
	 dB0jAaYiZQRpA5GefkpU0vhjLDOWCIQAt8/Nps2OXNBZVwWmt9i4uYsHOJvZ+sgTQD
	 wZnHhGByZIqiy6TpzDtir6YBFrwUGhTO8r7voNPwJldOp7pZ+laPgSwykyDtswpzCG
	 G7xrje8Hk3AGfve7TUqn5j5RvNqevPJrl6zTv8W2TuKxVf52PKI4aEwatTkNjAEO+q
	 tLiAhXw9gSwqTysXWDGA+12GsoOMMQkZOzt6Ots38545+BMEYZjk798VnenfQSJTuf
	 wZ/Ya08B6qjAw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 09/42] lockd: Remove lockd/debug.h
Date: Fri, 23 Jan 2026 13:52:26 -0500
Message-ID: <20260123185259.1215767-10-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18370-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,swb.de:email]
X-Rspamd-Queue-Id: 09C5979CC1
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h            | 24 +++++++++++++++++++++-
 include/linux/lockd/debug.h | 40 -------------------------------------
 2 files changed, 23 insertions(+), 41 deletions(-)
 delete mode 100644 include/linux/lockd/debug.h

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 43813444091a..3ddbf8772b59 100644
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


