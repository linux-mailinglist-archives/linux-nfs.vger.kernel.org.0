Return-Path: <linux-nfs+bounces-18368-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEHIAL7Dc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18368-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D679CDE
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68AF1300C7DC
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0C299927;
	Fri, 23 Jan 2026 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7wKVeH9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A72848AA
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194389; cv=none; b=P81dJnWXo+KDa+Sf7vsmrichhQq2zvSqWdUOmSRLQYeTbe0aLG8xcVP6iDjOS6A5/91jyJJBK69nlskzXsBtD4pPpMgMY4p4YsBxcQwLal1qlN5E9nJr2GRUHD7IQXNC79JPoOEp9NI968e0Jdg28U879lNd4Y2JKub1iuDpZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194389; c=relaxed/simple;
	bh=RtMuM+Tj7rVhL87Kof/hUNoKu7cR7IRc+egmRISn9MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipFg8awQ/ypptHR/NiB4hiUbZzX4WIEpPnFOQvUIlRD4RxFn1nRz8lqwydY2yye8AK/pfRETe7u4UHAIwkZ3/JUqyPvIDBQUP5xQXDTzs+qy71bbe6t5qRc6nViIq+Z9mPmFAIhU8bADgC+GaH9IPVgB4AtOpzh1Ew/EJju5fiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7wKVeH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F40AC4CEF1;
	Fri, 23 Jan 2026 18:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194388;
	bh=RtMuM+Tj7rVhL87Kof/hUNoKu7cR7IRc+egmRISn9MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7wKVeH9IuCjhal70QGfx4M+1ZLn9FD8qqAXBPxRgM0/XJHUBuhcm5SB5w/l2Q341
	 Zi1GxzwuRcxKKKKj1yzeX2XaifwbKM15RtRrRBAZ1x+JjY7GrjX3FY02X+G29rM5BL
	 BKHMz/yjvqOtkGsCKxqoz7FcsKVrW27HmMlqtFZR2CWgx8CBZZ2ziiQEL7/okLzE8q
	 0XmCmeCXh+NC3hmRsEgMsBbAwIYmP/6S7Uhyh4iuBS1SNkxggv04gyfEQFXpHMqpRA
	 oLLoeavT0b66GtG/oUAaIohp+SyVz2hStWGuibOvol95dxRFDlb//JBFTEYbmOCaTd
	 85A805KhK+n8Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 07/42] lockd: Move share.h from include/linux/lockd/ to fs/lockd/
Date: Fri, 23 Jan 2026 13:52:24 -0500
Message-ID: <20260123185259.1215767-8-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18368-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,swb.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 064D679CDE
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The share.h header defines struct nlm_share and declares the DOS
share management functions used by the NLM server to implement
NLM_SHARE and NLM_UNSHARE operations. These interfaces are used
exclusively within the lockd subsystem. A git grep search confirms
no external code references them.

Relocating this header from include/linux/lockd/ to fs/lockd/
narrows the public API surface of the lockd module. Out-of-tree
code cannot depend on these internal interfaces after this change.
Future refactoring of the share management implementation thus
requires no consideration of external consumers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 {include/linux => fs}/lockd/share.h | 8 +++-----
 fs/lockd/svc4proc.c                 | 2 +-
 fs/lockd/svcproc.c                  | 3 ++-
 fs/lockd/svcshare.c                 | 3 ++-
 fs/lockd/svcsubs.c                  | 3 ++-
 include/linux/lockd/lockd.h         | 2 ++
 6 files changed, 12 insertions(+), 9 deletions(-)
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
index eb485bc6c7dd..0be5e5ce9de1 100644
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
index 557dfd9c2a9e..c06b592756ee 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -11,9 +11,10 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "share.h"
+
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
 #ifdef CONFIG_LOCKD_V4
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
index e3ceb0745464..827861dd788f 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -16,11 +16,12 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/lockd/lockd.h>
-#include <linux/lockd/share.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <uapi/linux/nfs2.h>
 
+#include "share.h"
+
 #define NLMDBG_FACILITY		NLMDBG_SVCSUBS
 
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 6852bbc8f51a..1dee8ddab108 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -155,6 +155,8 @@ struct nlm_rqst {
 	void *	a_callback_data; /* sent to nlmclnt_operations callbacks */
 };
 
+struct nlm_share;
+
 /*
  * This struct describes a file held open by lockd on behalf of
  * an NFS client.
-- 
2.52.0


