Return-Path: <linux-nfs+bounces-20387-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPp2MYD4w2nPvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20387-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:00:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049D3275A8
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4AC321A23F
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE13FB07C;
	Wed, 25 Mar 2026 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj0s+rtP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34623FB06A;
	Wed, 25 Mar 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449673; cv=none; b=V3FFbaPHDtq0ThJpwpaxumOd7TQVL/3R6Ix9yHiBpVrbUgocDN5gfR18P/3uKx09VS3maI2y1Ar+1f9TNG7MTX4yzdKgPc6qzkBrC9CYbbBt6+6MbUT20PD+HXnB2Wawc5zIGDWp1imK1YOhx4ajAmNJSsC7URlfKTAmvNQY/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449673; c=relaxed/simple;
	bh=OaapqYw0nA2b3DJ3MpNZ3zm04w2f/GRhSYPxrDWpxf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjiWIwMv3CerIOKNDr4yTtIiXIa8tIsNi/6QgeFSmE4ClzWr4C4aE5XABr5E4WxdtgpjrAOX5NutDX7fu/WBwfwBCQTAXH586YSMNm1/EiJwHLzy/5dKxcOYL9wTbh+16HFgIv8ICotHKCAFy4P4IqB8WuO5W4nHOts+QQzjqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj0s+rtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49B1C19423;
	Wed, 25 Mar 2026 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449673;
	bh=OaapqYw0nA2b3DJ3MpNZ3zm04w2f/GRhSYPxrDWpxf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vj0s+rtPMV3vL8agHdWqjJLBuWc8HA/ixWUg4Ckvo7S2PZaLOdXBJRu7SFVPHq+l8
	 m7GDVllzFc8YHKkbY/KrjWNqehuRZuuVHB8FHmxcbKk/+hnfQISR2qwdSELQJGty/R
	 Yx3QQ4/fvIZJXsaSJ3t2MJVf3v0JUaymMkbHg5CiCWzP3oENzyOSVheTMDMNwCEh/H
	 9ZqMU/1qvtAb60jXOGDS4n6qgtk9DTVXIo7Gh9c1mMQe1yUlDmfozPpkNaenCakbfF
	 u82BkQdaIfrXSSFarvG8SO+FsadL3smAP0Vqv3NODb4L2klDcvOIJCCBrXStFGk4ua
	 wmUQBbWwjYCLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:34 -0400
Subject: [PATCH v2 13/13] nfsd: add NFSD_CMD_CACHE_FLUSH netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-13-067df016ea95@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6012; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OaapqYw0nA2b3DJ3MpNZ3zm04w2f/GRhSYPxrDWpxf8=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGnD8/DIvRbJMYoZ/hpZsqo8Y1cjvBiRLTw9qyngVhQNnittm
 YkCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJpw/PwAAoJEAAOaEEZVoIVXsYP/RCj
 5CkN71iWkmiV+VctbDimWOoMzhDl7CEefP9SHxcNTnjK0Kzfu+tkiqWfrPlfNcXPZC31FPRd//+
 K/ct4Lgnrc4WTVIrm0MX9RjZdmi3CzdXU59n4DMt5RXvd4K875ORWgiQdlV3RJvwxxY50IVQvfB
 AFfl1VYFyi5sKlmZkA2q3qGKhIKlj2EBKoll4LbvZV0voCK3BN3LdTCr1zONY/MT6TgqMGOx/lu
 0fk8NgaPKJQ5EIdBX9xDIxSiNR4bEzG6N3Hd1tpZvxWC6sOrakeNtZIpOPbsoim7uXpf24mEMbD
 0Nmx4uUjaVs+SFf3KBmRpsTI0lVfs82kbrZm3XqIQqYumrslEahMQzHYq1lF9K91iEOfV8iIp4Y
 Qk/wz6Z6DtbiQo+UaCZYSwVpYb2d++uoQP3AmI3rkSQxBsQdcucr8O4JRzYXkbz++1LzOcpbMxj
 ESZUIx32KdgT+cvYylLewIjIf2bcrvl9vksh9RO64Qg7j4FFUHOOqDQyNVqSot69luZDleBn6FO
 0+PFkIvWJdc5Ny9OYmf1KtNdwMJ9g/WsC3gMZXcTaScDAqPY1Qvcd03SNC2Fj16o1sxpgbmDm00
 VtJP2sEUTfm2SivZH+MGZFXKlCMmTEaxZTbEvhpSOfd1kISRQ9MUpDa5Ey4l11iRpAq7QKobpA5
 pvhu2
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20387-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3049D3275A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new NFSD_CMD_CACHE_FLUSH generic netlink command that allows
userspace to flush the nfsd export caches (svc_export and expkey)
without writing to /proc/net/rpc/*/flush.

An optional NFSD_A_CACHE_FLUSH_MASK u32 attribute selects which caches
to flush (bit 1 = svc_export, bit 2 = expkey). If the attribute is
omitted, all nfsd caches are flushed.

This is used by exportfs to replace its /proc-based cache_flush() with a
netlink equivalent, with /proc fallback for older kernels.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 17 +++++++++++++++++
 fs/nfsd/netlink.c                     | 12 ++++++++++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/nfsctl.c                      | 36 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  8 ++++++++
 5 files changed, 74 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index ae9563ca58ee0bf7373fd96d7d2253df411316fd..f8ca70178c67d0e4bd074b86d19dcd1514f127ff 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -305,6 +305,14 @@ attribute-sets:
         type: nest
         nested-attributes: expkey
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
@@ -450,6 +458,15 @@ operations:
           request:
             attributes:
               - requests
+    -
+      name: cache-flush
+      doc: Flush nfsd caches (svc_export and/or expkey)
+      attribute-set: cache-flush
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - mask
 
 mcast-groups:
   list:
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 394230e250a5b07fa0bb6a5b76f7282758e94565..30c4f8be3df98d8ae98ecddbfac488b5f997ab2f 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -108,6 +108,11 @@ static const struct nla_policy nfsd_expkey_set_reqs_nl_policy[NFSD_A_EXPKEY_REQS
 	[NFSD_A_EXPKEY_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_expkey_nl_policy),
 };
 
+/* NFSD_CMD_CACHE_FLUSH - do */
+static const struct nla_policy nfsd_cache_flush_nl_policy[NFSD_A_CACHE_FLUSH_MASK + 1] = {
+	[NFSD_A_CACHE_FLUSH_MASK] = NLA_POLICY_MASK(NLA_U32, 0x3),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -191,6 +196,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.maxattr	= NFSD_A_EXPKEY_REQS_REQUESTS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_CACHE_FLUSH,
+		.doit		= nfsd_nl_cache_flush_doit,
+		.policy		= nfsd_cache_flush_nl_policy,
+		.maxattr	= NFSD_A_CACHE_FLUSH_MASK,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group nfsd_nl_mcgrps[] = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index f5b3387772850692b220bbbf8a66bc416b67801e..cc89732ed71bd77c1eee011dd07f130c6909462b 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -38,6 +38,7 @@ int nfsd_nl_svc_export_set_reqs_doit(struct sk_buff *skb,
 int nfsd_nl_expkey_get_reqs_dumpit(struct sk_buff *skb,
 				   struct netlink_callback *cb);
 int nfsd_nl_expkey_set_reqs_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NFSD_NLGRP_NONE,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0f236046adfd239d0f88f4ed82a14e1a41cb6abe..3241bcfc2c6ff0b3273a81642180d17cf6c5b4a3 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -10,6 +10,7 @@
 #include <linux/ctype.h>
 #include <linux/fs_context.h>
 
+#include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/svcsock.h>
 #include <linux/lockd/bind.h>
 #include <linux/sunrpc/addr.h>
@@ -2215,6 +2216,41 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_cache_flush_doit - flush nfsd caches via netlink
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Flush the svc_export and/or expkey caches. If NFSD_A_CACHE_FLUSH_MASK
+ * is provided, only flush the caches indicated by the bitmask (bit 0 =
+ * svc_export, bit 1 = expkey). If omitted, flush both.
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	u32 mask = ~0U;
+
+	if (info->attrs[NFSD_A_CACHE_FLUSH_MASK])
+		mask = nla_get_u32(info->attrs[NFSD_A_CACHE_FLUSH_MASK]);
+
+	mutex_lock(&nfsd_mutex);
+
+	if ((mask & NFSD_CACHE_TYPE_SVC_EXPORT) &&
+	    nn->svc_export_cache)
+		cache_purge(nn->svc_export_cache);
+
+	if ((mask & NFSD_CACHE_TYPE_EXPKEY) &&
+	    nn->svc_expkey_cache)
+		cache_purge(nn->svc_expkey_cache);
+
+	mutex_unlock(&nfsd_mutex);
+
+	return 0;
+}
+
 int nfsd_cache_notify(struct cache_detail *cd, struct cache_head *h, u32 cache_type)
 {
 	struct genlmsghdr *hdr;
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 2cbd2a36f00ca38e313e95a4ccfaa46a5c1c0df3..2d708d24cbd23770f800fa7e52b351886aec785c 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -206,6 +206,13 @@ enum {
 	NFSD_A_EXPKEY_REQS_MAX = (__NFSD_A_EXPKEY_REQS_MAX - 1)
 };
 
+enum {
+	NFSD_A_CACHE_FLUSH_MASK = 1,
+
+	__NFSD_A_CACHE_FLUSH_MAX,
+	NFSD_A_CACHE_FLUSH_MAX = (__NFSD_A_CACHE_FLUSH_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -221,6 +228,7 @@ enum {
 	NFSD_CMD_SVC_EXPORT_SET_REQS,
 	NFSD_CMD_EXPKEY_GET_REQS,
 	NFSD_CMD_EXPKEY_SET_REQS,
+	NFSD_CMD_CACHE_FLUSH,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


