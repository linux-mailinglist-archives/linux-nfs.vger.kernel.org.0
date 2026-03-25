Return-Path: <linux-nfs+bounces-20386-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFaHNVj3w2nPvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20386-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:55:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7863273E7
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A3C63054CAC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420473FAE08;
	Wed, 25 Mar 2026 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie1dmXq/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F873FADF6;
	Wed, 25 Mar 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449671; cv=none; b=ZlDTpobPDRCCEdyi18OXq/vWBuRYxYuPAoZfiDQ842eqH/zylZArmCaNJ9Zw+DsyyAipNyiU5XL8rkRtp907bHDbP7/cpfjgM4o25Zwn6A0PesNBOpn4qTy1vFv5/J36bFRDmyFfLx+l/2QxNnTDMCuipWei7Td81YlU68Mp4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449671; c=relaxed/simple;
	bh=l00TRpXd2f1+4p+T4txcGsDt1BUsxxeKdZQhqcki53c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5iFXLPn+IPvjONjrsirXdMugK+9ihrKIdLaeUi21M59EpiJl5B5sE/oPqhYZwrKka0SJPPB98yeGJVYtZvcdLUMmKqKou/q+at+X48MKjWg7AtUx64kksya6kyogtuvegLS9Za8cyC/2yZZjFu4Pg+P9ZuNoauZTKmy1/b2+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie1dmXq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B06BC116C6;
	Wed, 25 Mar 2026 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449671;
	bh=l00TRpXd2f1+4p+T4txcGsDt1BUsxxeKdZQhqcki53c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ie1dmXq/eZQx/++jlkYRtT61jxPjtVAjaPie2LL2jDQC6VxaTz7AYD65e49as6RWu
	 QG32QHSc5B7lKL/GWUG0umuaHiPgDZYi3UR8hIbHwb5N1zCq/N44VhKZ7znt3/uUu9
	 UA4UKfabG4rDp5WaNqohbguJBIA0lF/hHt6TUL1b3ZDROibxp8rD949ZkP7RUuHGm9
	 7+V+P+DvJsdtWXSamkPzd6EkTdamP2gPSOtcMR7YX+rvMrKyk0QLvNM3CUtExzzIiH
	 Jo4up4NmZ8PIgkRiDs20lzKZ07MVjwaQS2RxgqXud1KYORO7W/7jo4GFyamJT1ZgVj
	 FZWP/8oCW2w1Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:33 -0400
Subject: [PATCH v2 12/13] sunrpc: add SUNRPC_CMD_CACHE_FLUSH netlink
 command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-12-067df016ea95@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5832; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=l00TRpXd2f1+4p+T4txcGsDt1BUsxxeKdZQhqcki53c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/PwMgdB2OXJ8EfCAX4LMzVfUfVHcb59+ZG0I
 sXQgo/5ZTOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz8AAKCRAADmhBGVaC
 Fa5jD/kBwTT/CYyMO241SqrAcM1fDYerhfKh6BzpixfKT+Jhj3YAAf1n+XD3bHmIJ3B1WzAHvr7
 l57ewXYb9IGXpVWcXkPYzC0W+uOAxDG0fohzhJk9lrW3tHFFCXN4xbXBfMvQLPT0kr1vieJ87Ah
 BMI8GWSj4/D34lkND12IiNEjPHPYg2W7CEg88NuuXC/pwEwde4cSbFdeKulKB4Mrebi55S1Hmxr
 UwguV4r+LBTwWhxK1sMDjP0MqmC6ZhCTJKXV+Dbkw6OBPFj8Ujc3gbjuZJHhCc21tmpiLTvp1pt
 mgXhfoeR7WrhT2KSkzkUMbmApi3w/D+yVGd9GI+B29JrmlrSEmkGts2gAAI8duoAxHTxYyKPaWg
 dt446F/TwhrkTsJdZ75JSXZweMUmmiHlnUB3dsd3wzeaGW9fPhGcAbiFwhI2Gd5L3AkUeOn8kJX
 ASyeh85cT5p/bjNCyprZjqdpVD7wdnaqSzY11kml6LDzAKHDkrWDqbYZ17ewqkyHUJDDlv0QPaP
 95oq1NXlsx6vNGTffM9FHFs8jgUQvFpPhy6rPuUIuWqn/+SAwH8vyBDW6BQ1LW8nfKauyHgndRP
 oLt3XtKZy6AnEjISTq4XL27tkfCY7Nmx8H+iHfFif0OAwujPpRRSIaYA0FBViJ5uWCuworgqFWC
 bRdrP6FqYu86LFQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20386-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D7863273E7
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
 Documentation/netlink/specs/sunrpc_cache.yaml | 17 ++++++++++++++
 include/uapi/linux/sunrpc_netlink.h           |  8 +++++++
 net/sunrpc/netlink.c                          | 12 ++++++++++
 net/sunrpc/netlink.h                          |  1 +
 net/sunrpc/svcauth_unix.c                     | 32 +++++++++++++++++++++++++++
 5 files changed, 70 insertions(+)

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
index 3ac6b0cac5fece964f6e6591f90d074f40e96af1..5ccf0967809c4d3cbc58fde5dd20279e1ec29301 100644
--- a/net/sunrpc/netlink.c
+++ b/net/sunrpc/netlink.c
@@ -49,6 +49,11 @@ static const struct nla_policy sunrpc_unix_gid_set_reqs_nl_policy[SUNRPC_A_UNIX_
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
@@ -79,6 +84,13 @@ static const struct genl_split_ops sunrpc_nl_ops[] = {
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
diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
index 2aec57d27a586e4c6b2fc65c7b4505b0996d9577..2c1012303d48bcbaad01192eca1c306790a4522b 100644
--- a/net/sunrpc/netlink.h
+++ b/net/sunrpc/netlink.h
@@ -23,6 +23,7 @@ int sunrpc_nl_unix_gid_get_reqs_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb);
 int sunrpc_nl_unix_gid_set_reqs_doit(struct sk_buff *skb,
 				     struct genl_info *info);
+int sunrpc_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	SUNRPC_NLGRP_NONE,
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 7703523d424617a6033fa7ab48e25728b4c14abb..64a2658faddbe6c217f548c565a3a434b5573a76 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -818,6 +818,38 @@ int sunrpc_nl_unix_gid_set_reqs_doit(struct sk_buff *skb,
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


