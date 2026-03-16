Return-Path: <linux-nfs+bounces-20197-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNwUJGgguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20197-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:23:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E2D29C3A7
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B21523088396
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1A3A543E;
	Mon, 16 Mar 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTf43bMT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F032B3A1A38;
	Mon, 16 Mar 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674126; cv=none; b=LkZz2dQbzEq6kVYm2SE+mcwanKKA1SiG3rn4HITeNK6sdUuM5kFKL3F03114nzMf/mqyynZWCPPtA2zOd5Qfrz1yJIqYvxksMidIM4VDYn6cB2fqNdFHKzocfjkFzcfZ/RBKsHHC+pW7pVv8Gq4DW3/5jjTa25o2Rz0qvJg1gkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674126; c=relaxed/simple;
	bh=OxGhnlUBkot6TJTrZW99YZR3StOdNEnOnPus13qKpRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkUpURwsyUdwx81Bw8vAfTfilzeYFHJEY2Pz3k4JtY8q/HOQYgJeLnurQLaZkTPqbU4QY39jxAiY8EgmhUcdrW6Pe1b402ILSmExaffcZ8O/DsJmTFbC3/n9cdh/65NLti1/kv4TuB2W0yzwp4D1ni86YGhyA+bKFvmvRQ/k87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTf43bMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FF2C19421;
	Mon, 16 Mar 2026 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674125;
	bh=OxGhnlUBkot6TJTrZW99YZR3StOdNEnOnPus13qKpRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uTf43bMTY3dJYk0g8NGCwAjeJMkfKut6qkkSMskTvcB6WVKI8vrn5ipF7qqXdogvW
	 p/9G7dO/HSHCnNT83iYV4h2UXQFeXjdbLUhVOZokfCL3624wthD4WSfY6iPhHAyhWU
	 94yjAgRu8to9NjwL/HCnawyOpuriELnhvOgTclkHvIJRtWTNyZ+WADTFor8/F598Xm
	 fRbraBn43V+EOocXDDfzHvfT6MFrdcAJf6HuIDkHAPjcs1ObZ0d0MYPh9wDZD88xsm
	 5QOiDz4/NPzurp+mTzLjhDtLwivOc0nIRiEmkqwKVuQfttpNttjcCotxck5ZHkv8e0
	 W40P7kaiZInng==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:47 -0400
Subject: [PATCH 13/14] sunrpc: add SUNRPC_CMD_CACHE_FLUSH netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-13-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7165; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OxGhnlUBkot6TJTrZW99YZR3StOdNEnOnPus13qKpRg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB59bM5OmlDgR84KagSz9fcKGeW9LTz0TYLIo
 hzbmF5eAreJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefQAKCRAADmhBGVaC
 Ff2/EACXwWL2s4gVik8U086OlbvnKZKiOMMU5R7JYQOGwrvYP+Ex9LA8p/fcmdzKFGiQSUz0791
 3vi0WcSmZ8dU8thU+vVDBq6cuLcIrOGD6jY2IV8R2KSsRkxFGCHsyqgPbuGT9RwW0g4attg3/rB
 zQgssBAHOezHF2+5THjFmysp+POGjEwhViwAW0adLs/Kaq9GfhZtaMn0hT1ixtSUitJbFDylWjX
 xoQSXLG324PXNmhu8pgj7a6nVZU/t4xXqexVzOVx7yPmkuUssphXDv38yp31l0+vFv6mShAwx1y
 52cGFo37u2ibaEQk3oAEbOZXhuHiok1VwLVbL4ZGHQdRi8YYsuTvm7zuqh5hQyRnAjbSVguPyDr
 yLlKUh4X9XE8t7hjt5XtGjHKH6UBNaOCCeDDtTGTrQWpxKZrjeUYtrxMuolnUCPOfeXcE3eJ+yb
 SD5wFEgO9zPBxu0zJFAypGzajS5YAm5cQmbof8nNZWj2BxdYAUUOS+BYHRBvQOLFxUTpPOUP2R5
 B6etZTbbDsDJdkXcjZ58XmE8djhrfiAyMN3NzQ2uFSJ4KUV3+MIa9F7HVPngsGk7L01QbRMKaAf
 kMd6Ed6L41/yni/bIsgwPWGa2XSzbNoPp3ILWA1D2lLoh2qwmQGuHyuJxS1QVY1cShzRD8JNIeb
 H7PQSUIk40IskTw==
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
	TAGGED_FROM(0.00)[bounces-20197-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 16E2D29C3A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new SUNRPC_CMD_CACHE_FLUSH generic netlink command that allows
userspace to flush the sunrpc auth caches (ip_map and unix_gid) without
writing to /proc/net/rpc/*/flush.

An optional SUNRPC_A_CACHE_FLUSH_MASK u32 attribute selects which caches
to flush (bit 1 = ip_map, bit 2 = unix_gid). If the attribute is
omitted, all sunrpc caches are flushed.

This is used by exportfs to replace its /proc-based cache_flush() with a
netlink equivalent, with /proc fallback for older kernels.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/sunrpc_cache.yaml | 17 ++++++++++
 include/uapi/linux/sunrpc_netlink.h           |  8 +++++
 net/sunrpc/netlink.c                          | 45 +++++++++++++++++++++++++++
 net/sunrpc/netlink.h                          |  4 +++
 net/sunrpc/svcauth_unix.c                     | 32 +++++++++++++++++++
 5 files changed, 106 insertions(+)

diff --git a/Documentation/netlink/specs/sunrpc_cache.yaml b/Documentation/netlink/specs/sunrpc_cache.yaml
index ed0ddb61ebcf22b6ad889b0760f8a6f470295dbd..55dabc914dbc8693e10a8765a654b11021b32872 100644
--- a/Documentation/netlink/specs/sunrpc_cache.yaml
+++ b/Documentation/netlink/specs/sunrpc_cache.yaml
@@ -76,6 +76,14 @@ attribute-sets:
         type: nest
         nested-attributes: unix-gid
         multi-attr: true
+  -
+    name: cache-flush
+    attributes:
+      -
+        name: mask
+        type: u32
+        enum: cache-type
+        enum-as-flags: true
 
 operations:
   list:
@@ -123,6 +131,15 @@ operations:
           request:
             attributes:
               - requests
+    -
+      name: cache-flush
+      doc: Flush sunrpc caches (ip_map and/or unix_gid)
+      attribute-set: cache-flush
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - mask
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/sunrpc_netlink.h b/include/uapi/linux/sunrpc_netlink.h
index d71c623e92aba4566e3114cc23d0aa553cbdb885..34677f0ec2f958961f1f460c1dc81c8377cc5157 100644
--- a/include/uapi/linux/sunrpc_netlink.h
+++ b/include/uapi/linux/sunrpc_netlink.h
@@ -59,12 +59,20 @@ enum {
 	SUNRPC_A_UNIX_GID_REQS_MAX = (__SUNRPC_A_UNIX_GID_REQS_MAX - 1)
 };
 
+enum {
+	SUNRPC_A_CACHE_FLUSH_MASK = 1,
+
+	__SUNRPC_A_CACHE_FLUSH_MAX,
+	SUNRPC_A_CACHE_FLUSH_MAX = (__SUNRPC_A_CACHE_FLUSH_MAX - 1)
+};
+
 enum {
 	SUNRPC_CMD_CACHE_NOTIFY = 1,
 	SUNRPC_CMD_IP_MAP_GET_REQS,
 	SUNRPC_CMD_IP_MAP_SET_REQS,
 	SUNRPC_CMD_UNIX_GID_GET_REQS,
 	SUNRPC_CMD_UNIX_GID_SET_REQS,
+	SUNRPC_CMD_CACHE_FLUSH,
 
 	__SUNRPC_CMD_MAX,
 	SUNRPC_CMD_MAX = (__SUNRPC_CMD_MAX - 1)
diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
index 3ac6b0cac5fece964f6e6591f90d074f40e96af1..47491c2e63ebb8cacf4f8fe2fa913e31541c77a5 100644
--- a/net/sunrpc/netlink.c
+++ b/net/sunrpc/netlink.c
@@ -6,6 +6,7 @@
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
+#include <linux/sunrpc/cache.h>
 
 #include "netlink.h"
 
@@ -49,6 +50,11 @@ static const struct nla_policy sunrpc_unix_gid_set_reqs_nl_policy[SUNRPC_A_UNIX_
 	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
 };
 
+/* SUNRPC_CMD_CACHE_FLUSH - do */
+static const struct nla_policy sunrpc_cache_flush_nl_policy[SUNRPC_A_CACHE_FLUSH_MASK + 1] = {
+	[SUNRPC_A_CACHE_FLUSH_MASK] = NLA_POLICY_MASK(NLA_U32, 0x3),
+};
+
 /* Ops table for sunrpc */
 static const struct genl_split_ops sunrpc_nl_ops[] = {
 	{
@@ -79,6 +85,13 @@ static const struct genl_split_ops sunrpc_nl_ops[] = {
 		.maxattr	= SUNRPC_A_UNIX_GID_REQS_REQUESTS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= SUNRPC_CMD_CACHE_FLUSH,
+		.doit		= sunrpc_nl_cache_flush_doit,
+		.policy		= sunrpc_cache_flush_nl_policy,
+		.maxattr	= SUNRPC_A_CACHE_FLUSH_MASK,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group sunrpc_nl_mcgrps[] = {
@@ -97,3 +110,35 @@ struct genl_family sunrpc_nl_family __ro_after_init = {
 	.mcgrps		= sunrpc_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(sunrpc_nl_mcgrps),
 };
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
index 2aec57d27a586e4c6b2fc65c7b4505b0996d9577..7eec78cb32ff3c7ae9ed2b1b1c6b75e2a403f68e 100644
--- a/net/sunrpc/netlink.h
+++ b/net/sunrpc/netlink.h
@@ -23,6 +23,7 @@ int sunrpc_nl_unix_gid_get_reqs_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb);
 int sunrpc_nl_unix_gid_set_reqs_doit(struct sk_buff *skb,
 				     struct genl_info *info);
+int sunrpc_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	SUNRPC_NLGRP_NONE,
@@ -31,4 +32,7 @@ enum {
 
 extern struct genl_family sunrpc_nl_family;
 
+int sunrpc_cache_notify(struct cache_detail *cd, struct cache_head *h,
+			u32 cache_type);
+
 #endif /* _LINUX_SUNRPC_GEN_H */
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index b84511ff726c1836f777c802943f6d8e112a0998..dd90beebd74c1e243535d11e753668589ae1fe18 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -813,6 +813,38 @@ int sunrpc_nl_unix_gid_set_reqs_doit(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * sunrpc_nl_cache_flush_doit - flush sunrpc caches via netlink
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Flush the ip_map and/or unix_gid caches. If SUNRPC_A_CACHE_FLUSH_MASK
+ * is provided, only flush the caches indicated by the bitmask (bit 1 =
+ * ip_map, bit 2 = unix_gid). If omitted, flush both.
+ *
+ * Return 0 on success or a negative errno.
+ */
+int sunrpc_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sunrpc_net *sn;
+	u32 mask = ~0U;
+
+	sn = net_generic(genl_info_net(info), sunrpc_net_id);
+
+	if (info->attrs[SUNRPC_A_CACHE_FLUSH_MASK])
+		mask = nla_get_u32(info->attrs[SUNRPC_A_CACHE_FLUSH_MASK]);
+
+	if ((mask & SUNRPC_CACHE_TYPE_IP_MAP) &&
+	    sn->ip_map_cache)
+		cache_purge(sn->ip_map_cache);
+
+	if ((mask & SUNRPC_CACHE_TYPE_UNIX_GID) &&
+	    sn->unix_gid_cache)
+		cache_purge(sn->unix_gid_cache);
+
+	return 0;
+}
+
 static const struct cache_detail unix_gid_cache_template = {
 	.owner		= THIS_MODULE,
 	.hash_size	= GID_HASHMAX,

-- 
2.53.0


