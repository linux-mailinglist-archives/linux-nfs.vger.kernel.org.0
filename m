Return-Path: <linux-nfs+bounces-18575-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHTgEzcpeml/3gEAu9opvQ
	(envelope-from <linux-nfs+bounces-18575-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B218A3AC3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D976300B9C8
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30C36BCD3;
	Wed, 28 Jan 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrRe0pSS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE17298CC0
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613585; cv=none; b=R4tHV4TbS2yC2DdTNVzg6bMOAThQVp6q9Dq7max/SH/dmeO3QdXO02kxXCfgz3WggdLA6U/dbkr9pDGcga7MLIEVQwPXWX6huxDm/Vd+oExb4bfoySJGaNYmSYiV7n1iUao8rlAADcWULDnvt/d3bRMWHEPaqx8w3lWyAqKV7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613585; c=relaxed/simple;
	bh=cXb8tolaUofItry2NGVUGZ5l6gn+RYl+FHfSU+1W9E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdpnyqzTkOc7RMEYSPCTuXIqSUpZhtyd2HTJd1M11JVLRmGANE+TaXxRxlPArt8ZM5x87SC6n6I6FHDl684JYuHyRD/el6vxxdGm1YibQYUs2tXKeOvhFXHKaS7MMf6Kq6z/8SIw+2dFFLV/1C2e78LAEsD8rpacGRHfn1SKBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrRe0pSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364F2C4CEF7;
	Wed, 28 Jan 2026 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613584;
	bh=cXb8tolaUofItry2NGVUGZ5l6gn+RYl+FHfSU+1W9E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrRe0pSSkXvC7yc1lmMg7I09Fd4zMiJOj9lzyF0coHG+JoCxmvuLsPuwfhY4jpICZ
	 ZCkKreyvMlZggyXdcrkkdcnHsUHzKiCJOb7OPv1agS1HIKszjJdXDbFh5Mt2Wnygz6
	 DUunSU6CPFfc2S7PDK35z72+8zlk7wKqd3aJBXNsjm41XI09P6EUpK1JkcZjI7nt5C
	 gu0eWhUQyy34SblN0S9ESn7SxgSTACstS26DdaBhUSCQS31BGFlSnxHiISeZgPP+lj
	 BMjzFRxAXFyilrRHRGaI059znv026rCI/Zv+h1apCnUlKb9crpYj0NuTj0s1yJ/n+C
	 X9yUsjkLxolHg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 09/14] lockd: Relocate include/linux/lockd/lockd.h
Date: Wed, 28 Jan 2026 10:19:30 -0500
Message-ID: <20260128151935.1646063-10-cel@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18575-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,swb.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B218A3AC3
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Headers placed in include/linux/ form part of the kernel's
internal API and signal to subsystem maintainers that other
parts of the kernel may depend on them. By moving lockd.h
into fs/lockd/, lockd becomes a more self-contained module
whose internal interfaces are clearly distinguished from its
public contract with the rest of the kernel. This relocation
addresses a long-standing XXX comment in the header itself
that acknowledged the file's misplacement. Future changes to
lockd internals can now proceed with confidence that external
consumers are not inadvertently coupled to implementation
details.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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
index 6ea3448d2d31..65555f5224b1 100644
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
index 87c88a8f9902..0ea2bde7efd3 100644
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
index eebcecd12fae..9bcf89765a69 100644
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
@@ -398,4 +392,4 @@ static inline int nlm_compare_locks(const struct file_lock *fl1,
 
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
index dcd80c4e74c9..9dd7f8e11544 100644
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
index da88b638d90d..86dfeb6ce68d 100644
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
index b08bbd3ee753..10e3937ad69f 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -29,7 +29,8 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/nlm.h>
-#include <linux/lockd/lockd.h>
+
+#include "lockd.h"
 
 #define NLMDBG_FACILITY		NLMDBG_SVCLOCK
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 8441fabd019f..e9a6bcc3bf2e 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -10,9 +10,9 @@
 
 #include <linux/types.h>
 #include <linux/time.h>
-#include <linux/lockd/lockd.h>
 #include <linux/sunrpc/svc_xprt.h>
 
+#include "lockd.h"
 #include "share.h"
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
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
index 678b492d682e..9ee990b55231 100644
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
 
 #define NLMDBG_FACILITY		NLMDBG_SVCSUBS
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


