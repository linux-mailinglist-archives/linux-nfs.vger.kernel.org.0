Return-Path: <linux-nfs+bounces-20193-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPTYA/UfuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20193-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:21:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485E29C305
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA1930A7A39
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AD63A3827;
	Mon, 16 Mar 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbhp5fS9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC63A0E9A;
	Mon, 16 Mar 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674121; cv=none; b=WB6fuogM+oOC+SKhGUMWsDKZ9WxxsvRsv/HZkrpbrUxf8KEyn9AHvPaiglGYTjjyVyzv8tTuL7cKOnDmXR4HjmtVTYgMgWnO0WoYrarcbkheYtA7huWnSHAmVHWoeM02HLc9U7ACcNHxbpATKfurOlHVXXTsE4b/cfr3y0VeWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674121; c=relaxed/simple;
	bh=a29/VGykAzsIQd0t1Dj10js2ROjrRaqXqw3BjsUSNvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncP155LnYcCUw3HuNuuDaS5v0qtO++pRPq0ZM1pGDuDZ320y88touXKsUxdijoKDAnozF6PXJJ2ufvPs6nO9AfDt47c98bO8ghxVtDb5a3UMVuGGati9e19G3eMHGKG6GDuwf1HlF5LjA13MfhnlwNVp2zC6A+SGLldGkC5lCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbhp5fS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DFBC2BC9E;
	Mon, 16 Mar 2026 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674121;
	bh=a29/VGykAzsIQd0t1Dj10js2ROjrRaqXqw3BjsUSNvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nbhp5fS9MJnAglNNMPQt12IR8wAf/hADfWqb8oStqPJqEhojB9BLIr4xkfm7TtsyN
	 JnRme6x739UWfg4wT9Ix1c9yJ1u0HBbUUzl2BQSHLoaUMpr4nQTxGpYeNFdNMCMlay
	 8krRG6USh5JH74pUl1JOe+gaGYftygFtcN+4Q2cILY1yXDToS7uCjX/01mxDerrFso
	 ONCF9N1clolosypXywas5Cx6nNLVNdSgcXWFa4loC7xZ/GEqtisRATPVe1XeUuemUQ
	 Rs30AdDB8UVfuo4ff0INSn3Ad8u3rORyUFXw3HUy10hpvcuW8m3w53HsuI1i7EAFoN
	 ZVAU8iaIZvpnA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:43 -0400
Subject: [PATCH 09/14] sunrpc: add netlink upcall for the auth.unix.gid
 cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-9-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13078; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=a29/VGykAzsIQd0t1Dj10js2ROjrRaqXqw3BjsUSNvU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB58hyA+QVe1dKeQwicnEAgUgQ+jsRev2tZO8
 zp6IUfVdVWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefAAKCRAADmhBGVaC
 FSatEADJFJV5NMXJYHufkd3hlN9pnKvJnBEwT1rslbjQeLp0mNWs7JgO3OKeUadtj8gmH1efs+l
 Ftwt/iyXX8fkr35FXuCJ/x2pg1tBbZZgr+AHyrinxAU0uz/ALUVReALQQZ668ysHT66RiWZXmjN
 6stRot8pvLVgrb4bIvo8QFsUP/5AxEDKJSG3CrqLHugndHB1GeYXG5kHIxP2kdoUYtZLjp/I3wD
 mQqO4pzRa1Ux774kTuzEfoKcH34ZydpaQeQOR0iuHLDWvLN8hTGlHnYo1Znrj0kAMP+hJQDhNPb
 5CDL3mJHZpefErWDOtCY4lPo9UnM24cPUI9nBO5ERO8qSxc1yXAV+3TL4jgqiviYgZavGVBFaHm
 IEDMA9mOzKY8chXRzSonJCLByjHKnkTbhdezIcTtWv6kPrsSU0mUaPfC0wz74p0Jir8Cn/yJaE9
 og1o48dxroZLAm6c8VRxh0Ne5wu2AecQMKP8byImr0GJxspTkNDgqMfQJsYtvYBSt2Wv02gJ0r3
 PCuBIpJTH9ceSfb5e0VW/8Xg6tIw2nFBZu3Hp1EXtN1C2pVVXXjUaLJoZeblueHaRUSC+HM84H9
 vKLPGAxe6pX1iEddAB+KMzuHpjU81ENkNiMpPAgYcf6RxZefSCF5PdPLIvjoWWPP7kSTy1CTlqH
 avyiDAD3aGMRhuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20193-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ug.gi:url]
X-Rspamd-Queue-Id: 6485E29C305
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add netlink-based cache upcall support for the unix_gid (auth.unix.gid)
cache, using the sunrpc generic netlink family.

Add unix-gid attribute-set (seqno, uid, gids multi-attr, negative,
expiry), unix-gid-reqs wrapper, and unix-gid-get-reqs /
unix-gid-set-reqs operations to the sunrpc_cache YAML spec and
generated headers.

Implement sunrpc_nl_unix_gid_get_reqs_dumpit() which snapshots pending
unix_gid cache requests and sends each entry's seqno and uid over
netlink.

Implement sunrpc_nl_unix_gid_set_reqs_doit() which parses unix_gid
cache responses from userspace (uid, expiry, gids as u32 multi-attr
or negative flag) and updates the cache via unix_gid_lookup() /
sunrpc_cache_update().

Wire up unix_gid_notify() callback in unix_gid_cache_template so
cache misses trigger SUNRPC_CMD_CACHE_NOTIFY multicast events with
SUNRPC_CACHE_TYPE_UNIX_GID.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/sunrpc_cache.yaml |  45 +++++
 include/uapi/linux/sunrpc_netlink.h           |  20 +++
 net/sunrpc/netlink.c                          |  32 ++++
 net/sunrpc/netlink.h                          |   5 +
 net/sunrpc/svcauth_unix.c                     | 229 ++++++++++++++++++++++++++
 5 files changed, 331 insertions(+)

diff --git a/Documentation/netlink/specs/sunrpc_cache.yaml b/Documentation/netlink/specs/sunrpc_cache.yaml
index 8bcd43f65f3258ba43df4f80a7cfda5f09f2f13e..ed0ddb61ebcf22b6ad889b0760f8a6f470295dbd 100644
--- a/Documentation/netlink/specs/sunrpc_cache.yaml
+++ b/Documentation/netlink/specs/sunrpc_cache.yaml
@@ -49,6 +49,33 @@ attribute-sets:
         type: nest
         nested-attributes: ip-map
         multi-attr: true
+  -
+    name: unix-gid
+    attributes:
+      -
+        name: seqno
+        type: u64
+      -
+        name: uid
+        type: u32
+      -
+        name: gids
+        type: u32
+        multi-attr: true
+      -
+        name: negative
+        type: flag
+      -
+        name: expiry
+        type: u64
+  -
+    name: unix-gid-reqs
+    attributes:
+      -
+        name: requests
+        type: nest
+        nested-attributes: unix-gid
+        multi-attr: true
 
 operations:
   list:
@@ -78,6 +105,24 @@ operations:
           request:
             attributes:
               - requests
+    -
+      name: unix-gid-get-reqs
+      doc: Dump all pending unix_gid requests
+      attribute-set: unix-gid-reqs
+      flags: [admin-perm]
+      dump:
+          request:
+            attributes:
+              - requests
+    -
+      name: unix-gid-set-reqs
+      doc: Respond to one or more unix_gid requests
+      attribute-set: unix-gid-reqs
+      flags: [admin-perm]
+      do:
+          request:
+            attributes:
+              - requests
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/sunrpc_netlink.h b/include/uapi/linux/sunrpc_netlink.h
index b44befb5a34b956e70065e0e12b816e2943da66e..d71c623e92aba4566e3114cc23d0aa553cbdb885 100644
--- a/include/uapi/linux/sunrpc_netlink.h
+++ b/include/uapi/linux/sunrpc_netlink.h
@@ -41,10 +41,30 @@ enum {
 	SUNRPC_A_IP_MAP_REQS_MAX = (__SUNRPC_A_IP_MAP_REQS_MAX - 1)
 };
 
+enum {
+	SUNRPC_A_UNIX_GID_SEQNO = 1,
+	SUNRPC_A_UNIX_GID_UID,
+	SUNRPC_A_UNIX_GID_GIDS,
+	SUNRPC_A_UNIX_GID_NEGATIVE,
+	SUNRPC_A_UNIX_GID_EXPIRY,
+
+	__SUNRPC_A_UNIX_GID_MAX,
+	SUNRPC_A_UNIX_GID_MAX = (__SUNRPC_A_UNIX_GID_MAX - 1)
+};
+
+enum {
+	SUNRPC_A_UNIX_GID_REQS_REQUESTS = 1,
+
+	__SUNRPC_A_UNIX_GID_REQS_MAX,
+	SUNRPC_A_UNIX_GID_REQS_MAX = (__SUNRPC_A_UNIX_GID_REQS_MAX - 1)
+};
+
 enum {
 	SUNRPC_CMD_CACHE_NOTIFY = 1,
 	SUNRPC_CMD_IP_MAP_GET_REQS,
 	SUNRPC_CMD_IP_MAP_SET_REQS,
+	SUNRPC_CMD_UNIX_GID_GET_REQS,
+	SUNRPC_CMD_UNIX_GID_SET_REQS,
 
 	__SUNRPC_CMD_MAX,
 	SUNRPC_CMD_MAX = (__SUNRPC_CMD_MAX - 1)
diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
index baeaf28fda02f120c2cd4778fcb444850ae8868a..44a38aba820d9ad25bd50d0d8c7a827dfe37c2bd 100644
--- a/net/sunrpc/netlink.c
+++ b/net/sunrpc/netlink.c
@@ -32,6 +32,24 @@ static const struct nla_policy sunrpc_ip_map_set_reqs_nl_policy[SUNRPC_A_IP_MAP_
 	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
 };
 
+const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIRY + 1] = {
+	[SUNRPC_A_UNIX_GID_SEQNO] = { .type = NLA_U64, },
+	[SUNRPC_A_UNIX_GID_UID] = { .type = NLA_U32, },
+	[SUNRPC_A_UNIX_GID_GIDS] = { .type = NLA_U32, },
+	[SUNRPC_A_UNIX_GID_NEGATIVE] = { .type = NLA_FLAG, },
+	[SUNRPC_A_UNIX_GID_EXPIRY] = { .type = NLA_U64, },
+};
+
+/* SUNRPC_CMD_UNIX_GID_GET_REQS - dump */
+static const struct nla_policy sunrpc_unix_gid_get_reqs_nl_policy[SUNRPC_A_UNIX_GID_REQS_REQUESTS + 1] = {
+	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
+};
+
+/* SUNRPC_CMD_UNIX_GID_SET_REQS - do */
+static const struct nla_policy sunrpc_unix_gid_set_reqs_nl_policy[SUNRPC_A_UNIX_GID_REQS_REQUESTS + 1] = {
+	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
+};
+
 /* Ops table for sunrpc */
 static const struct genl_split_ops sunrpc_nl_ops[] = {
 	{
@@ -48,6 +66,20 @@ static const struct genl_split_ops sunrpc_nl_ops[] = {
 		.maxattr	= SUNRPC_A_IP_MAP_REQS_REQUESTS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= SUNRPC_CMD_UNIX_GID_GET_REQS,
+		.dumpit		= sunrpc_nl_unix_gid_get_reqs_dumpit,
+		.policy		= sunrpc_unix_gid_get_reqs_nl_policy,
+		.maxattr	= SUNRPC_A_UNIX_GID_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= SUNRPC_CMD_UNIX_GID_SET_REQS,
+		.doit		= sunrpc_nl_unix_gid_set_reqs_doit,
+		.policy		= sunrpc_unix_gid_set_reqs_nl_policy,
+		.maxattr	= SUNRPC_A_UNIX_GID_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group sunrpc_nl_mcgrps[] = {
diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
index 6849faec517ea33ddc5cafab827381984e0dc602..f01477c13f98f6708f3f24391cde164edb21a860 100644
--- a/net/sunrpc/netlink.h
+++ b/net/sunrpc/netlink.h
@@ -14,11 +14,16 @@
 
 /* Common nested types */
 extern const struct nla_policy sunrpc_ip_map_nl_policy[SUNRPC_A_IP_MAP_EXPIRY + 1];
+extern const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIRY + 1];
 
 int sunrpc_nl_ip_map_get_reqs_dumpit(struct sk_buff *skb,
 				     struct netlink_callback *cb);
 int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb,
 				   struct genl_info *info);
+int sunrpc_nl_unix_gid_get_reqs_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb);
+int sunrpc_nl_unix_gid_set_reqs_doit(struct sk_buff *skb,
+				     struct genl_info *info);
 
 enum {
 	SUNRPC_NLGRP_NONE,
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index e4b196742877bd3abf199f2bf815b90615a2be04..b84511ff726c1836f777c802943f6d8e112a0998 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -585,12 +585,241 @@ static int unix_gid_show(struct seq_file *m,
 	return 0;
 }
 
+static int unix_gid_notify(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_notify(cd, h, SUNRPC_CACHE_TYPE_UNIX_GID);
+}
+
+/**
+ * sunrpc_nl_unix_gid_get_reqs_dumpit - dump pending unix_gid requests
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Walk the unix_gid cache's pending request list and create a netlink
+ * message with a nested entry for each cache_request, containing the
+ * seqno and uid.
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int sunrpc_nl_unix_gid_get_reqs_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	struct sunrpc_net *sn;
+	struct cache_detail *cd;
+	struct cache_head **items;
+	u64 *seqnos;
+	int cnt, i;
+	void *hdr;
+	int ret;
+
+	sn = net_generic(sock_net(skb->sk), sunrpc_net_id);
+
+	cd = sn->unix_gid_cache;
+	if (!cd)
+		return -ENODEV;
+
+	/* Second call means we've already dumped everything */
+	if (cb->args[0])
+		return 0;
+
+	cnt = sunrpc_cache_requests_count(cd);
+	if (!cnt)
+		return 0;
+
+	items = kcalloc(cnt, sizeof(*items), GFP_KERNEL);
+	seqnos = kcalloc(cnt, sizeof(*seqnos), GFP_KERNEL);
+	if (!items || !seqnos) {
+		ret = -ENOMEM;
+		goto out_alloc;
+	}
+
+	cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt);
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &sunrpc_nl_family,
+			  NLM_F_MULTI, SUNRPC_CMD_UNIX_GID_GET_REQS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto out_put;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		struct unix_gid *ug;
+		struct nlattr *nest;
+
+		ug = container_of(items[i], struct unix_gid, h);
+
+		nest = nla_nest_start(skb,
+				      SUNRPC_A_UNIX_GID_REQS_REQUESTS);
+		if (!nest) {
+			ret = -ENOBUFS;
+			goto out_cancel;
+		}
+
+		if (nla_put_u64_64bit(skb, SUNRPC_A_UNIX_GID_SEQNO,
+				      seqnos[i], 0) ||
+		    nla_put_u32(skb, SUNRPC_A_UNIX_GID_UID,
+				from_kuid(&init_user_ns, ug->uid))) {
+			nla_nest_cancel(skb, nest);
+			ret = -ENOBUFS;
+			goto out_cancel;
+		}
+
+		nla_nest_end(skb, nest);
+	}
+
+	genlmsg_end(skb, hdr);
+	cb->args[0] = 1;
+	ret = skb->len;
+	goto out_put;
+
+out_cancel:
+	genlmsg_cancel(skb, hdr);
+out_put:
+	for (i = 0; i < cnt; i++)
+		cache_put(items[i], cd);
+out_alloc:
+	kfree(seqnos);
+	kfree(items);
+	return ret;
+}
+
+/**
+ * sunrpc_nl_parse_one_unix_gid - parse one unix_gid entry from netlink
+ * @cd: cache_detail for the unix_gid cache
+ * @attr: nested attribute containing unix_gid fields
+ *
+ * Parses one unix_gid entry from a netlink message and updates the
+ * cache. Mirrors the logic in unix_gid_parse().
+ *
+ * Returns 0 on success or a negative errno.
+ */
+static int sunrpc_nl_parse_one_unix_gid(struct cache_detail *cd,
+					 struct nlattr *attr)
+{
+	struct nlattr *tb[SUNRPC_A_UNIX_GID_EXPIRY + 1];
+	struct unix_gid ug, *ugp;
+	struct timespec64 boot;
+	struct nlattr *gid_attr;
+	int err, rem, gids = 0;
+	kuid_t uid;
+
+	err = nla_parse_nested(tb, SUNRPC_A_UNIX_GID_EXPIRY, attr,
+			       sunrpc_unix_gid_nl_policy, NULL);
+	if (err)
+		return err;
+
+	/* uid (required) */
+	if (!tb[SUNRPC_A_UNIX_GID_UID])
+		return -EINVAL;
+	uid = make_kuid(current_user_ns(),
+			nla_get_u32(tb[SUNRPC_A_UNIX_GID_UID]));
+	ug.uid = uid;
+
+	/* expiry (required, wallclock seconds) */
+	if (!tb[SUNRPC_A_UNIX_GID_EXPIRY])
+		return -EINVAL;
+	getboottime64(&boot);
+	ug.h.flags = 0;
+	ug.h.expiry_time = nla_get_u64(tb[SUNRPC_A_UNIX_GID_EXPIRY]) -
+			   boot.tv_sec;
+
+	if (tb[SUNRPC_A_UNIX_GID_NEGATIVE]) {
+		ug.gi = groups_alloc(0);
+		if (!ug.gi)
+			return -ENOMEM;
+	} else {
+		/* Count gids */
+		nla_for_each_nested_type(gid_attr, SUNRPC_A_UNIX_GID_GIDS,
+					 attr, rem)
+			gids++;
+
+		if (gids > 8192)
+			return -EINVAL;
+
+		ug.gi = groups_alloc(gids);
+		if (!ug.gi)
+			return -ENOMEM;
+
+		gids = 0;
+		nla_for_each_nested_type(gid_attr, SUNRPC_A_UNIX_GID_GIDS,
+					 attr, rem) {
+			kgid_t kgid;
+
+			kgid = make_kgid(current_user_ns(),
+					 nla_get_u32(gid_attr));
+			if (!gid_valid(kgid)) {
+				err = -EINVAL;
+				goto out;
+			}
+			ug.gi->gid[gids++] = kgid;
+		}
+		groups_sort(ug.gi);
+	}
+
+	ugp = unix_gid_lookup(cd, uid);
+	if (ugp) {
+		struct cache_head *ch;
+
+		ch = sunrpc_cache_update(cd, &ug.h, &ugp->h,
+					 unix_gid_hash(uid));
+		if (!ch) {
+			err = -ENOMEM;
+		} else {
+			err = 0;
+			cache_put(ch, cd);
+		}
+	} else {
+		err = -ENOMEM;
+	}
+out:
+	if (ug.gi)
+		put_group_info(ug.gi);
+	return err;
+}
+
+/**
+ * sunrpc_nl_unix_gid_set_reqs_doit - respond to unix_gid requests
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Parse one or more unix_gid cache responses from userspace and
+ * update the unix_gid cache accordingly.
+ *
+ * Returns 0 on success or a negative errno.
+ */
+int sunrpc_nl_unix_gid_set_reqs_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct sunrpc_net *sn;
+	struct cache_detail *cd;
+	const struct nlattr *attr;
+	int rem, ret = 0;
+
+	sn = net_generic(genl_info_net(info), sunrpc_net_id);
+
+	cd = sn->unix_gid_cache;
+	if (!cd)
+		return -ENODEV;
+
+	nlmsg_for_each_attr_type(attr, SUNRPC_A_UNIX_GID_REQS_REQUESTS,
+				 info->nlhdr, GENL_HDRLEN, rem) {
+		ret = sunrpc_nl_parse_one_unix_gid(cd,
+						   (struct nlattr *)attr);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static const struct cache_detail unix_gid_cache_template = {
 	.owner		= THIS_MODULE,
 	.hash_size	= GID_HASHMAX,
 	.name		= "auth.unix.gid",
 	.cache_put	= unix_gid_put,
 	.cache_upcall	= unix_gid_upcall,
+	.cache_notify	= unix_gid_notify,
 	.cache_request	= unix_gid_request,
 	.cache_parse	= unix_gid_parse,
 	.cache_show	= unix_gid_show,

-- 
2.53.0


