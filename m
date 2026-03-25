Return-Path: <linux-nfs+bounces-20381-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO1eJAH4w2nPvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20381-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:58:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1A3274AF
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93B4231FFEA2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F883F54DD;
	Wed, 25 Mar 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACPYGFXL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E63F54CA;
	Wed, 25 Mar 2026 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449662; cv=none; b=SR/B7QAbKuDYVzei/HYsleK737oaD2nog0koq1/sQ3KPBGiZ2HgAYO4dDkqXUVds3DAabrVVizlP1HRzcqShw+kqsmUK/HQdoRL2dTlCARVxOvVveOImdYEp32wpL0m7PmyOtCduTDzsND3Acy3+31zT2FyotzO1NNzdnS1+DbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449662; c=relaxed/simple;
	bh=R95s6KprQ4g2IpY1Qnm+S/XyNYljJLg3MP0mx52dOMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVdhlZkh8UPUo4cnFlsbQSSjKSohSjlXfXgvtIVtW4J1gF8wrHsoq05wOzoJcs/XhM+XbT+MBj+JOQMwoBLL9Vaop0TIK8PIuVmsAJHPWJ+WSvSAXm6rQQ30gHm5QQj8d2VxttfHIl6cdnnZM62OQi/FASxac7zk3uOxO71D914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACPYGFXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32976C4CEF7;
	Wed, 25 Mar 2026 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449662;
	bh=R95s6KprQ4g2IpY1Qnm+S/XyNYljJLg3MP0mx52dOMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ACPYGFXLxabf3oY46V3ufPEIgSpHiqfjYUXrwMqmr+ZS26HyNSi/GGOHnBf9VCvPf
	 eUVTxF9eqLXhgQJky0h93jLcgf6CeG0SzaxHMH3hBro4LvY2qZcCwO0TwwN9QjhCv3
	 zCYwDIr0Y7lI+Fd8YiWlx0DjIRpkld15WuvMOFWnvi0C7CGZ0XXHKovyd5g4u3tX+1
	 gHPCuGF5NpLGm940xA4ulmKNg+hExHuz+etraFFLGwOjYz6PePbYmRBBOH7b7Ggi1A
	 QNrjbz3/fpb9Kht4YhOZZj1Vh+6aQ5UtGD7Ye8CmA9yyOEUTlexJB02owRgSAMzkf4
	 9j03HqnqPZ1Jw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:28 -0400
Subject: [PATCH v2 07/13] sunrpc: add a generic netlink family for cache
 upcalls
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-7-067df016ea95@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
In-Reply-To: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10109; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=R95s6KprQ4g2IpY1Qnm+S/XyNYljJLg3MP0mx52dOMk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/PujPDyYjGHj2OXIqviuGAfsl5x4LJA70VHY
 DvGXAho2BuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7gAKCRAADmhBGVaC
 FSR+EAC/KbEU4/KLRYprUuXVyN8zEsYMovgI1ANRUWFMefScDZUdcj5hezUuYicpEw9ijjFaer/
 CYbdzeNggCqVB6AA/3gJ3cmaJbZ7YzVKvYudRfBXDRwmxRbKY3MSrnJ1gx3v2uIV1L7ykxrpd4Y
 8tfy1fq2UToKWF5zQhoFHsqU721O6ss+LSm0GG+W/v4aJnSfI5lxGqMRNEikLK43oiJy8I+2C3O
 UP4v0SNPJ4La+ADA64hnYgjVYZ9TGtJM54TGxlC6WLtCibIcm3PauCPRzQCl4TOY4yUqdQZJeuM
 54T5xyyB6Pg+NJI1fiKTZ5BmluNHEtBn/AwMw0SIfmBYh5/Rw1PJQjl0QxYViZwKEsFQarkfMve
 kv+83keMVs0+SEc4vSQmKnEz+tMxFrtyH/BAJAD8WTcKh/MfiHATYRCPbbodEt8GkHS3r/cv2Qv
 h1W9be5JieVR7yeRuwW/51IeNHbg6HY4olrQw5k8/tN0DFMCSOBKiRp3kO1FPDCyryfZjd5HZ74
 y8BeMMO7v3EX7stoKzESFxFnUS0wTXdYj2vF+WfExT2S00shPe1NLZlR6jITz81fmGfjlvs9h7p
 uq3oIrR3PM+ntOZ3Jr5Enl3rXTQ8NmEm17+39B+K2UVDm5N0jNVDVaqGTZt9eJqcA4cgvuJ46uL
 2sq07CfFqfBZfEg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20381-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2A1A3274AF
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

Implement sunrpc_cache_notify() in cache.c, which checks for
listeners on the exportd multicast group, builds and sends a
SUNRPC_CMD_CACHE_NOTIFY message with the cache-type attribute.

Register/unregister the sunrpc_nl_family in init_sunrpc() and
cleanup_sunrpc().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/sunrpc_cache.yaml | 40 ++++++++++++++++++++++++
 include/linux/sunrpc/cache.h                  |  2 ++
 include/uapi/linux/sunrpc_netlink.h           | 35 +++++++++++++++++++++
 net/sunrpc/Makefile                           |  2 +-
 net/sunrpc/cache.c                            | 44 +++++++++++++++++++++++++++
 net/sunrpc/netlink.c                          | 34 +++++++++++++++++++++
 net/sunrpc/netlink.h                          | 22 ++++++++++++++
 net/sunrpc/sunrpc_syms.c                      | 10 ++++++
 8 files changed, 188 insertions(+), 1 deletion(-)

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
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index f88dc6bb17c7078781b3cf7e0371f369eddcb563..2735c332ddb736ef043f811b5e9e6ad2f57c9ce7 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -256,6 +256,8 @@ int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
 				   struct cache_head **items,
 				   u64 *seqnos, int max,
 				   u64 min_seqno);
+int sunrpc_cache_notify(struct cache_detail *cd, struct cache_head *h,
+			u32 cache_type);
 
 /* Must store cache_detail in seq_file->private if using next three functions */
 extern void *cache_seq_start_rcu(struct seq_file *file, loff_t *pos);
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
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 1282c61030d35efd924072e2739109cfae3472e2..d477b19dbfa15fdff71f946ade2643b56c35d491 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -33,9 +33,11 @@
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
+#include <net/genetlink.h>
 #include <trace/events/sunrpc.h>
 
 #include "netns.h"
+#include "netlink.h"
 #include "fail.h"
 
 #define	 RPCDBG_FACILITY RPCDBG_CACHE
@@ -1960,3 +1962,45 @@ int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
 	return i;
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_requests_snapshot);
+
+/**
+ * sunrpc_cache_notify - send a netlink notification for a cache event
+ * @cd: cache_detail for the cache
+ * @h: cache_head entry (unused, reserved for future use)
+ * @cache_type: cache type identifier (e.g. SUNRPC_CACHE_TYPE_UNIX_GID)
+ *
+ * Sends a SUNRPC_CMD_CACHE_NOTIFY multicast message on the "exportd"
+ * group if any listeners are present. Returns 0 on success or a
+ * negative errno.
+ */
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
+	msg = genlmsg_new(nla_total_size(sizeof(u32)), GFP_KERNEL);
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
diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
new file mode 100644
index 0000000000000000000000000000000000000000..952de6de85e3f647ef9bc9c1e99651a247649abb
--- /dev/null
+++ b/net/sunrpc/netlink.c
@@ -0,0 +1,34 @@
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
diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..74cf5183d745d778174abbbfed9514c4b6693e30
--- /dev/null
+++ b/net/sunrpc/netlink.h
@@ -0,0 +1,22 @@
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


