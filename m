Return-Path: <linux-nfs+bounces-20191-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NmENc4fuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20191-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:20:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5420D29C2B4
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED0B5306C446
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3273A1E96;
	Mon, 16 Mar 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrvIsVv8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B63A0B3E;
	Mon, 16 Mar 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674119; cv=none; b=NSYKFpH+Pa7pBCm/qk+YXZBt0VHwfGQoLLwDXqZ3F+Pf0ws1FLImJYWCJ3t4C0inyjgKpGoY1T/FT284QyyYc3ooEpmGoL+lztr0MZajULOtF4LTyUgkjxr3aJ85xrsUayCf3Wh/f4gJlfggSC18Pq6wkC5i+F5ZrNHJ18V4zNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674119; c=relaxed/simple;
	bh=NMqyCBf4sgp+Ub5LuggG1DdHfY4oQfmiKnZO0y5QASs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bcgt/HTZKdmHBgKhw3WDrHlGJfi6otHnio3Wii6YKTlNCk6X92jV4zk5v24G2H4JYaVvL/Cg5rd6RzvSNYcXsUmIS0+GRet8ATHT3A8vw6KQkodPThi1tLWtmgw2BDmGy6vpKXeHCKKTO1mW7WzVGJqNAz57DX70wIxlKK9RRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrvIsVv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53521C2BC87;
	Mon, 16 Mar 2026 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674119;
	bh=NMqyCBf4sgp+Ub5LuggG1DdHfY4oQfmiKnZO0y5QASs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qrvIsVv8/S1QGAeTi5kqSJvTAtsQbS9DlA7jtSXWtBCJ4gSBprYxRGPhth2/vkYeZ
	 U2RSMqHPOmmCqe5+NIyUj4FbcO3D96pJwX+nsJd5nZ40KCXDQzlH5qW/ZLjxnmLtlZ
	 lzgg/e1s7LTu5z59CNE7BEKdfnKVl9GwB+O3lw7D4bnpP//N672aOlKo23OcQ2F6nO
	 PeQyoP0D5LOJf0DRCBs/i9qKRUyPpytgjtZY5fgq2ce3EOsWejINDnfzftuZwJdAxL
	 JQdln2JASyq4tRIvDRaTj76Df5kb4ACGNZXIuadoyxFCz4jzzd4i8tRG+Jxk9mOc+H
	 JYFSU7xjzE5bg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:41 -0400
Subject: [PATCH 07/14] sunrpc: add a generic netlink family for cache
 upcalls
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-7-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8890; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NMqyCBf4sgp+Ub5LuggG1DdHfY4oQfmiKnZO0y5QASs=;
 b=owEBbAKT/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB58bNaMr7/hf+dYu7EFzEiX/9urCCqM9YdgQ
 //FPhsom8uJAjIEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefAAKCRAADmhBGVaC
 FUsSD/YwFKR95zxttQckmbrCzzVDnws/iWcyLyOP65nIyUDWzyi+HV0EJ7iMen35RvNjNeMGhdr
 WLEvH9hR4ePvNpBp/Z82FtrCjBDnI1f82Pn0xwAJZfHP+45mbhEYKcuDUbTtm/NFL44xdiHa5wx
 412CZKa7bIADNp7Nc5mVh6NNKXCZ6cbNpK3fpQqU1lU/polulwYCPs9u9luw+ctxgMQRU2y6TMZ
 iIsBOj/AyG90tA+H46gS4gLnSk0jhF9U8ZWl6B4HuH7xBKPEewj7wGgEcszsEZ9pT/4dq09VPII
 aZ0Jr1Ak13/RvCPPTrRESZ7sOMh4JzpC3/ZA1OXXFc/c3O8QneLFpMfd8mQeh0PeQWyVxwjc2Z5
 JQS5VVs1xG/eB/L4vsU3G5/ZWAjAhE7Rn18RzEKklcb7nH1/CbJWfLv0Oyv+WdlQhw4PhiGHjuI
 EAvVirMD1j262EZc8qYN8sZtS60itAPfGcip+Wh/ZVZr57wIfB62qQr2Mern3qbReSHUt+oh/hL
 6S2/PXvnwu/TJOOYxQhMxPhf9U1RcUpnQfJ40mv+2lJ/j1UyAbKSZsOwDRxBRlvs3NxQI03eYgM
 5zhiWcthGGYWgX5fVOgIukzhpfFydfvZlnWmIJ2SCQnsVMmtsv/W9L20bLZYdkTc7lshNVQH+Nr
 2CSrY5X9m9lW1
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20191-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5420D29C2B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The auth.unix.ip and auth.unix.gid caches live in the sunrpc module,
so they cannot use the nfsd generic netlink family. Create a new
"sunrpc" generic netlink family with its own "exportd" multicast
group to support cache upcall notifications for sunrpc-resident
caches.

Define a YAML spec (sunrpc_cache.yaml) with a cache-type enum
(ip_map, unix_gid), a cache-notify multicast event, and the
corresponding uapi header.

Implement sunrpc_cache_notify() which mirrors the nfsd_cache_notify()
pattern: check for listeners on the exportd multicast group, build
and send SUNRPC_CMD_CACHE_NOTIFY with the cache-type attribute.

Register/unregister the sunrpc_nl_family in init_sunrpc() and
cleanup_sunrpc().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/sunrpc_cache.yaml | 40 ++++++++++++++++
 fs/nfsd/netlink.c                             |  2 +-
 include/uapi/linux/sunrpc_netlink.h           | 35 ++++++++++++++
 net/sunrpc/Makefile                           |  2 +-
 net/sunrpc/netlink.c                          | 66 +++++++++++++++++++++++++++
 net/sunrpc/netlink.h                          | 25 ++++++++++
 net/sunrpc/sunrpc_syms.c                      | 10 ++++
 7 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/sunrpc_cache.yaml b/Documentation/netlink/specs/sunrpc_cache.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f4aa699598bca9ce0215bbc418d9ddcae25c0110
--- /dev/null
+++ b/Documentation/netlink/specs/sunrpc_cache.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
+name: sunrpc
+protocol: genetlink
+uapi-header: linux/sunrpc_netlink.h
+
+doc: SUNRPC cache upcall support over generic netlink.
+
+definitions:
+  -
+    type: flags
+    name: cache-type
+    entries: [ip_map, unix_gid]
+
+attribute-sets:
+  -
+    name: cache-notify
+    attributes:
+      -
+        name: cache-type
+        type: u32
+        enum: cache-type
+
+operations:
+  list:
+    -
+      name: cache-notify
+      doc: Notification that there are cache requests that need servicing
+      attribute-set: cache-notify
+      mcgrp: exportd
+      event:
+        attributes:
+          - cache-type
+
+mcast-groups:
+  list:
+    -
+      name: none
+    -
+      name: exportd
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 4e08c1a6b3943cda5b44c2b64bcf3a00173a08db..81c943345d13db849483bf0d6773458115ff0134 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -59,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.cmd		= NFSD_CMD_THREADS_SET,
 		.doit		= nfsd_nl_threads_set_doit,
 		.policy		= nfsd_threads_set_nl_policy,
-		.maxattr	= NFSD_A_SERVER_MAX,
+		.maxattr	= NFSD_A_SERVER_FH_KEY,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/include/uapi/linux/sunrpc_netlink.h b/include/uapi/linux/sunrpc_netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..6135d9b3eef155a9192d9710c8c690283ec49073
--- /dev/null
+++ b/include/uapi/linux/sunrpc_netlink.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/sunrpc_cache.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_SUNRPC_NETLINK_H
+#define _UAPI_LINUX_SUNRPC_NETLINK_H
+
+#define SUNRPC_FAMILY_NAME	"sunrpc"
+#define SUNRPC_FAMILY_VERSION	1
+
+enum sunrpc_cache_type {
+	SUNRPC_CACHE_TYPE_IP_MAP = 1,
+	SUNRPC_CACHE_TYPE_UNIX_GID = 2,
+};
+
+enum {
+	SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE = 1,
+
+	__SUNRPC_A_CACHE_NOTIFY_MAX,
+	SUNRPC_A_CACHE_NOTIFY_MAX = (__SUNRPC_A_CACHE_NOTIFY_MAX - 1)
+};
+
+enum {
+	SUNRPC_CMD_CACHE_NOTIFY = 1,
+
+	__SUNRPC_CMD_MAX,
+	SUNRPC_CMD_MAX = (__SUNRPC_CMD_MAX - 1)
+};
+
+#define SUNRPC_MCGRP_NONE	"none"
+#define SUNRPC_MCGRP_EXPORTD	"exportd"
+
+#endif /* _UAPI_LINUX_SUNRPC_NETLINK_H */
diff --git a/net/sunrpc/Makefile b/net/sunrpc/Makefile
index f89c10fe7e6acc71d47273200d85425a2891a08a..96727df3aa85435a2de63a8483eab9d75d5b3495 100644
--- a/net/sunrpc/Makefile
+++ b/net/sunrpc/Makefile
@@ -14,7 +14,7 @@ sunrpc-y := clnt.o xprt.o socklib.o xprtsock.o sched.o \
 	    addr.o rpcb_clnt.o timer.o xdr.o \
 	    sunrpc_syms.o cache.o rpc_pipe.o sysfs.o \
 	    svc_xprt.o \
-	    xprtmultipath.o
+	    xprtmultipath.o netlink.o
 sunrpc-$(CONFIG_SUNRPC_DEBUG) += debugfs.o
 sunrpc-$(CONFIG_SUNRPC_BACKCHANNEL) += backchannel_rqst.o
 sunrpc-$(CONFIG_PROC_FS) += stats.o
diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
new file mode 100644
index 0000000000000000000000000000000000000000..e59ee82dfab358fc367045d9f04c394000c812ec
--- /dev/null
+++ b/net/sunrpc/netlink.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/sunrpc_cache.yaml */
+/* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+#include <linux/sunrpc/cache.h>
+
+#include "netlink.h"
+
+#include <uapi/linux/sunrpc_netlink.h>
+
+/* Ops table for sunrpc */
+static const struct genl_split_ops sunrpc_nl_ops[] = {
+};
+
+static const struct genl_multicast_group sunrpc_nl_mcgrps[] = {
+	[SUNRPC_NLGRP_NONE] = { "none", },
+	[SUNRPC_NLGRP_EXPORTD] = { "exportd", },
+};
+
+struct genl_family sunrpc_nl_family __ro_after_init = {
+	.name		= SUNRPC_FAMILY_NAME,
+	.version	= SUNRPC_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= sunrpc_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(sunrpc_nl_ops),
+	.mcgrps		= sunrpc_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(sunrpc_nl_mcgrps),
+};
+
+int sunrpc_cache_notify(struct cache_detail *cd, struct cache_head *h,
+			u32 cache_type)
+{
+	struct genlmsghdr *hdr;
+	struct sk_buff *msg;
+
+	if (!genl_has_listeners(&sunrpc_nl_family, cd->net,
+				SUNRPC_NLGRP_EXPORTD))
+		return -ENOLINK;
+
+	msg = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &sunrpc_nl_family, 0,
+			  SUNRPC_CMD_CACHE_NOTIFY);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	if (nla_put_u32(msg, SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE, cache_type)) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	genlmsg_end(msg, hdr);
+	return genlmsg_multicast_netns(&sunrpc_nl_family, cd->net, msg, 0,
+				       SUNRPC_NLGRP_EXPORTD, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(sunrpc_cache_notify);
diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..efb05f87b89513fe738964a1b27637a09f9b88a9
--- /dev/null
+++ b/net/sunrpc/netlink.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/sunrpc_cache.yaml */
+/* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _LINUX_SUNRPC_GEN_H
+#define _LINUX_SUNRPC_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/sunrpc_netlink.h>
+
+enum {
+	SUNRPC_NLGRP_NONE,
+	SUNRPC_NLGRP_EXPORTD,
+};
+
+extern struct genl_family sunrpc_nl_family;
+
+int sunrpc_cache_notify(struct cache_detail *cd, struct cache_head *h,
+			u32 cache_type);
+
+#endif /* _LINUX_SUNRPC_GEN_H */
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index bab6cab2940524a970422b62b3fa4212c61c4f43..ab88ce46afb556cb0a397fe5c9df3901813ad01e 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -23,9 +23,12 @@
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/sunrpc/xprtsock.h>
 
+#include <net/genetlink.h>
+
 #include "sunrpc.h"
 #include "sysfs.h"
 #include "netns.h"
+#include "netlink.h"
 
 unsigned int sunrpc_net_id;
 EXPORT_SYMBOL_GPL(sunrpc_net_id);
@@ -108,6 +111,10 @@ init_sunrpc(void)
 	if (err)
 		goto out5;
 
+	err = genl_register_family(&sunrpc_nl_family);
+	if (err)
+		goto out6;
+
 	sunrpc_debugfs_init();
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	rpc_register_sysctl();
@@ -116,6 +123,8 @@ init_sunrpc(void)
 	init_socket_xprt();	/* clnt sock transport */
 	return 0;
 
+out6:
+	rpc_sysfs_exit();
 out5:
 	unregister_rpc_pipefs();
 out4:
@@ -131,6 +140,7 @@ init_sunrpc(void)
 static void __exit
 cleanup_sunrpc(void)
 {
+	genl_unregister_family(&sunrpc_nl_family);
 	rpc_sysfs_exit();
 	rpc_cleanup_clids();
 	xprt_cleanup_ids();

-- 
2.53.0


