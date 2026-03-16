Return-Path: <linux-nfs+bounces-20198-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP07NcoguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20198-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:24:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFCB29C40D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BDF330DA1CA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716E3A5E87;
	Mon, 16 Mar 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE9xlX72"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7C3A5E7F;
	Mon, 16 Mar 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674127; cv=none; b=h5kmtRAf4jh1mydk67lT0CAkOTsRLXrDwyL2SZeYJWOzjTgegtcQCfghbifvd+bl1sz+p88GFnHTyZ+ATmKozqcn2OxPOooGSNpbfHVTwdwNhEXsSh+QbdSNKhbLoy2Ys1lRSrIu+J//2XMbxkd2ea3YdlGtlzlA60BTaMn0er8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674127; c=relaxed/simple;
	bh=A9Rw84PlLvLsCjZyYBdQk3iW5PsqBOc6SO9yNWSLjU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izmmoHynxckt09Wqs+nC9Rd020h7Y/nNxbJJ5ouuoUBulrlg/7n89a1EwgYStltWj5mcMtyHm+jzNa5CEBmDMJwxQiz/DYs6A5gz8sVnadfdOjNnC4Xz/zWEhpTPzJ6JYsOpwJMSLTBP+mO6TYF2Y6GA5HKoIygmwi+EVf5top0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE9xlX72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8F2C19421;
	Mon, 16 Mar 2026 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674127;
	bh=A9Rw84PlLvLsCjZyYBdQk3iW5PsqBOc6SO9yNWSLjU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WE9xlX72XGTFNkZJpJ5UdbnjMQoldYjF0TjXc5V2P2UuJVeHCsBC8htrKvG8nK8th
	 TkxmA3ymLj0zHNUa/JD0z/H9qNLekev9hr3uaDCKi+Cp9koVBgBIV96tCvo5vGx3Oy
	 TPZE+TmW1cHDQDfEeRQxHeHtzlbTZ/UCUubR0VmqqB6CxWWJonPZKU0AgS2CAi/vIz
	 vHg1guRZqt/K4w+GUQ2voft9syAQA6V54NewlO11rAwg7DqUMiRScy34TUhMNd525U
	 hMzcRPq8id2AicjChAzhwdpPPxKtF+ph00TbKOFl5ReWjgne7wtzT1QAU2Pg+9cVZy
	 +IyO7Fgt7TXxA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:48 -0400
Subject: [PATCH 14/14] nfsd: add NFSD_CMD_CACHE_FLUSH netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-14-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5945; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=A9Rw84PlLvLsCjZyYBdQk3iW5PsqBOc6SO9yNWSLjU0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB5+qaZJuw7HoA3SF+Kci3ALyrvcNxRbIoJvf
 UbqgIk2s6OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefgAKCRAADmhBGVaC
 FY73EACrZTUB90KsKnSQLxrjsifgYD4HZx+ue9Xwo/uLwLAqjU7s6Cw+Hs+Uej5pwaQgoYaoLhb
 IZSVjYaxJITDEEHe5hV7GEa+4axLE3iC4cxp3PNN3yLN6Bs02s7CqBbN0jIwv2QCIFD10Wi/hco
 /Snm0gcrSszfxTLw+MFvCLeZw/JDboup1UEf4IIPAL2/63ADEn7ZYE1+iInU+df4EUhjK0XtTGO
 N8KdYcSFSZE2Fnc0wb+ajHtEhjEqQ+VWbrdm/HjVaZ+voomhKgnK+ulV+gT2/XSH02mqv59gYy7
 nfUnvIBaMNcPFyuppU8j6eLFAM8ILoQjXkdJePexjJrwV6gLmImfX8NNCUx0Ap3hIQKxob/py+o
 hsGhzwliAlcMWRq15J95kfvD6WCokKGCSBrYOyT1KG/CkpfnANYwxr3ueQB3JKlhus9kWnecF0u
 Z4Tik/paZA6k1egXnuhRiuk5JW7TNJvr8VK84FOtZrifXVC52p/xQPTn51NjIB0FLOWqFyeB+8I
 BLnrVi0/I9ks8mV9YghcjxGYSXl0aE5yjK6Qcw8cbtu+UbADpQ9hUV5SnECkYQ9dS5OUPH51TBX
 nYDbUWI/yxvyN6waWwHCQTZzE+hWoHBOu7DbnD0E7fxcP6Ual+6IIVMIDki8YK6QfU7SRqlKCdG
 l08xKXExS4ZMPdw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20198-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BFCB29C40D
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
 fs/nfsd/nfsctl.c                      | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  8 ++++++++
 5 files changed, 70 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 65fd9caf6bf66abca9302ffa3b947b589dbf0dd3..09faeff3b7c20032cd61c992170f1e81f922605e 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -303,6 +303,14 @@ attribute-sets:
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
@@ -448,6 +456,15 @@ operations:
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
index 7edcbe4504a91966db4805a099368edb92ca38ee..98eeb2be56ce4b826611ba378074c522d761cb1e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -10,6 +10,7 @@
 #include <linux/ctype.h>
 #include <linux/fs_context.h>
 
+#include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/svcsock.h>
 #include <linux/lockd/bind.h>
 #include <linux/sunrpc/addr.h>
@@ -2215,6 +2216,37 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
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
+	if ((mask & NFSD_CACHE_TYPE_SVC_EXPORT) &&
+	    nn->svc_export_cache)
+		cache_purge(nn->svc_export_cache);
+
+	if ((mask & NFSD_CACHE_TYPE_EXPKEY) &&
+	    nn->svc_expkey_cache)
+		cache_purge(nn->svc_expkey_cache);
+
+	return 0;
+}
+
 int nfsd_cache_notify(struct cache_detail *cd, struct cache_head *h, u32 cache_type)
 {
 	struct genlmsghdr *hdr;
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e96cc1d23366bce13624084fd476dda65aef140a..08b8a77179f88f596d482d7a2ec5c19ee98b2e77 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -198,6 +198,13 @@ enum {
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
@@ -213,6 +220,7 @@ enum {
 	NFSD_CMD_SVC_EXPORT_SET_REQS,
 	NFSD_CMD_EXPKEY_GET_REQS,
 	NFSD_CMD_EXPKEY_SET_REQS,
+	NFSD_CMD_CACHE_FLUSH,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


