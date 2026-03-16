Return-Path: <linux-nfs+bounces-20192-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFdqLbIguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20192-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:24:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D329C3FF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092D23040237
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07F3A256B;
	Mon, 16 Mar 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZtPxxrr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC243A2565;
	Mon, 16 Mar 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674120; cv=none; b=RHy7bgld0Ex1og0nz6bvS+yu736SDg+1+IKZgtDQOkYzF1GRww3g64Fz4+kIJycXUqcE2I5MpN3mGoSUjvW+PE+286fErRG9He3KLZkiRxCXYZ2hm89ozyO0Qc3LOd2cZz8MN9s9qUA0Z/MPfIf5pCSaLgtVm2TxSlikqn1SCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674120; c=relaxed/simple;
	bh=bfUwiBYY9UpU/nzDprBrdX3J33AE5K3VXi/DpNoVG7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUozPZGL6dfRuNKnPDCwNRuwj9FBGL2+bHvI2vINop33jR3laXPFFNuA4XcSrZrzentJFcmvTzINb1UCDvMdht3CeQhn5KJCOY0Hv5cL7CFMRyMmDc1oNI2u8HIP1RXzMFaKSy7kZ/TLFgms9YUFS4PS0hWBb8enlspJ3fMhb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZtPxxrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E117C19425;
	Mon, 16 Mar 2026 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674120;
	bh=bfUwiBYY9UpU/nzDprBrdX3J33AE5K3VXi/DpNoVG7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZtPxxrr8XZxzPxNJgVNvzZ0skv8QOcLau4cZYC9IiI7I4PWGgk0IY0+Di39fRJih
	 yERQyczV+t3tfPo7XbVC1lwAV5i3YWZtyowUZbsnvlxFvOhTQW3iA6O9YG20rrshGG
	 xixeHBOaa6rME3RqN1QOCautqEtyb/AFow+70tW8vtyh/wxZGkGFzFp3wMTWl4Y0WQ
	 +wnfHdkUJc1axUy8AyebKjA7QFnR7cXc1Ad3rQKCdp9Lrz4Nd461MJkn0hx6CSFTXL
	 sboG6F241ajCzFOjLXFgzhnosme68mpv/U2D21JlsV4dCvfA4bgz7c5oAqxKdKnGo3
	 vK/F1gdmCOsRQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:42 -0400
Subject: [PATCH 08/14] sunrpc: add netlink upcall for the auth.unix.ip
 cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-8-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13419; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bfUwiBYY9UpU/nzDprBrdX3J33AE5K3VXi/DpNoVG7k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB58kUzkLGlT4mSInXBanOVHb5qSOb2fABpSU
 Yu5NvPtBGaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefAAKCRAADmhBGVaC
 Fcf5D/4ljm9SmMD66dkRpuAB3Ax9PDABRlNFym01tTNag7BaRoZmJVa0bUac32PCcn7Rs5zUDET
 gh65dZbYPnf1sveeoU/t3s7reAZj611pzhvC564qNCyzWPel+1Ab4NOD27RdcLdblr1IQKubbd0
 8YDIrS3D8fW3D8MB6zoVgUPecnaFABElQOgVzFUu8uiLjwo9e9SUiBjAywFs8iw7zQGzSRkrGtQ
 POq0ZJ1E4CLBQtcWK6YEW7Rj2R9RGS6LKpw+ppOo9pJBZTieUvCU3kGsxbrSvDrWlSycTyYFVtQ
 XsW/LYY55MLVq2gx3VhuxI3WdNVJrPuMCTZxs7wbMyWCrqOZ88D+PmW1ou0kbwVz1YCb9Kz0vtZ
 VTwh5aRP03SS1ULCSpi4m8uw0nE+l7zofs8+2MPoiVsjzjd6wCDfLXzv90M1Y/Lgef29ZlxecaR
 gTwnN0gXgx6p9Dk+N+6c81+iVCQcPc4w3CxXZeAZ9ibL0SSVe+XFplMZatFZvHzohzuL6p7hWS4
 r0FFTLe6Q+Z3b6zxr1xEwZfVH0Xwj5YkDknqKTkRqrfZz/ZgjJ6ojFSW18ReTJ+/gTttpdD1xQj
 kmhR3s8Bf4IQGyMMTU8wiLAqDhjSvKgCYIESqRdZ9wgskCmqXBV4WZo3bnz8HGEzcvWJmJinCDd
 gV76j41WzG0JAKw==
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
	TAGGED_FROM(0.00)[bounces-20192-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B0D329C3FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add netlink-based cache upcall support for the ip_map (auth.unix.ip)
cache, using the sunrpc generic netlink family.

Add ip-map attribute-set (seqno, class, addr, domain, negative, expiry),
ip-map-reqs wrapper, and ip-map-get-reqs / ip-map-set-reqs operations
to the sunrpc_cache YAML spec and generated headers.

Implement sunrpc_nl_ip_map_get_reqs_dumpit() which snapshots pending
ip_map cache requests and sends each entry's seqno, class name, and
IP address over netlink.

Implement sunrpc_nl_ip_map_set_reqs_doit() which parses ip_map cache
responses from userspace (class, addr, expiry, and domain name or
negative flag) and updates the cache via __ip_map_lookup() /
__ip_map_update().

Wire up ip_map_notify() callback in ip_map_cache_template so cache
misses trigger SUNRPC_CMD_CACHE_NOTIFY multicast events with
SUNRPC_CACHE_TYPE_IP_MAP.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/sunrpc_cache.yaml |  47 +++++
 include/uapi/linux/sunrpc_netlink.h           |  21 +++
 net/sunrpc/netlink.c                          |  34 ++++
 net/sunrpc/netlink.h                          |   8 +
 net/sunrpc/svcauth_unix.c                     | 241 ++++++++++++++++++++++++++
 5 files changed, 351 insertions(+)

diff --git a/Documentation/netlink/specs/sunrpc_cache.yaml b/Documentation/netlink/specs/sunrpc_cache.yaml
index f4aa699598bca9ce0215bbc418d9ddcae25c0110..8bcd43f65f3258ba43df4f80a7cfda5f09f2f13e 100644
--- a/Documentation/netlink/specs/sunrpc_cache.yaml
+++ b/Documentation/netlink/specs/sunrpc_cache.yaml
@@ -20,6 +20,35 @@ attribute-sets:
         name: cache-type
         type: u32
         enum: cache-type
+  -
+    name: ip-map
+    attributes:
+      -
+        name: seqno
+        type: u64
+      -
+        name: class
+        type: string
+      -
+        name: addr
+        type: string
+      -
+        name: domain
+        type: string
+      -
+        name: negative
+        type: flag
+      -
+        name: expiry
+        type: u64
+  -
+    name: ip-map-reqs
+    attributes:
+      -
+        name: requests
+        type: nest
+        nested-attributes: ip-map
+        multi-attr: true
 
 operations:
   list:
@@ -31,6 +60,24 @@ operations:
       event:
         attributes:
           - cache-type
+    -
+      name: ip-map-get-reqs
+      doc: Dump all pending ip_map requests
+      attribute-set: ip-map-reqs
+      flags: [admin-perm]
+      dump:
+          request:
+            attributes:
+              - requests
+    -
+      name: ip-map-set-reqs
+      doc: Respond to one or more ip_map requests
+      attribute-set: ip-map-reqs
+      flags: [admin-perm]
+      do:
+          request:
+            attributes:
+              - requests
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/sunrpc_netlink.h b/include/uapi/linux/sunrpc_netlink.h
index 6135d9b3eef155a9192d9710c8c690283ec49073..b44befb5a34b956e70065e0e12b816e2943da66e 100644
--- a/include/uapi/linux/sunrpc_netlink.h
+++ b/include/uapi/linux/sunrpc_netlink.h
@@ -22,8 +22,29 @@ enum {
 	SUNRPC_A_CACHE_NOTIFY_MAX = (__SUNRPC_A_CACHE_NOTIFY_MAX - 1)
 };
 
+enum {
+	SUNRPC_A_IP_MAP_SEQNO = 1,
+	SUNRPC_A_IP_MAP_CLASS,
+	SUNRPC_A_IP_MAP_ADDR,
+	SUNRPC_A_IP_MAP_DOMAIN,
+	SUNRPC_A_IP_MAP_NEGATIVE,
+	SUNRPC_A_IP_MAP_EXPIRY,
+
+	__SUNRPC_A_IP_MAP_MAX,
+	SUNRPC_A_IP_MAP_MAX = (__SUNRPC_A_IP_MAP_MAX - 1)
+};
+
+enum {
+	SUNRPC_A_IP_MAP_REQS_REQUESTS = 1,
+
+	__SUNRPC_A_IP_MAP_REQS_MAX,
+	SUNRPC_A_IP_MAP_REQS_MAX = (__SUNRPC_A_IP_MAP_REQS_MAX - 1)
+};
+
 enum {
 	SUNRPC_CMD_CACHE_NOTIFY = 1,
+	SUNRPC_CMD_IP_MAP_GET_REQS,
+	SUNRPC_CMD_IP_MAP_SET_REQS,
 
 	__SUNRPC_CMD_MAX,
 	SUNRPC_CMD_MAX = (__SUNRPC_CMD_MAX - 1)
diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
index e59ee82dfab358fc367045d9f04c394000c812ec..baeaf28fda02f120c2cd4778fcb444850ae8868a 100644
--- a/net/sunrpc/netlink.c
+++ b/net/sunrpc/netlink.c
@@ -12,8 +12,42 @@
 
 #include <uapi/linux/sunrpc_netlink.h>
 
+/* Common nested types */
+const struct nla_policy sunrpc_ip_map_nl_policy[SUNRPC_A_IP_MAP_EXPIRY + 1] = {
+	[SUNRPC_A_IP_MAP_SEQNO] = { .type = NLA_U64, },
+	[SUNRPC_A_IP_MAP_CLASS] = { .type = NLA_NUL_STRING, },
+	[SUNRPC_A_IP_MAP_ADDR] = { .type = NLA_NUL_STRING, },
+	[SUNRPC_A_IP_MAP_DOMAIN] = { .type = NLA_NUL_STRING, },
+	[SUNRPC_A_IP_MAP_NEGATIVE] = { .type = NLA_FLAG, },
+	[SUNRPC_A_IP_MAP_EXPIRY] = { .type = NLA_U64, },
+};
+
+/* SUNRPC_CMD_IP_MAP_GET_REQS - dump */
+static const struct nla_policy sunrpc_ip_map_get_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
+	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
+};
+
+/* SUNRPC_CMD_IP_MAP_SET_REQS - do */
+static const struct nla_policy sunrpc_ip_map_set_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
+	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
+};
+
 /* Ops table for sunrpc */
 static const struct genl_split_ops sunrpc_nl_ops[] = {
+	{
+		.cmd		= SUNRPC_CMD_IP_MAP_GET_REQS,
+		.dumpit		= sunrpc_nl_ip_map_get_reqs_dumpit,
+		.policy		= sunrpc_ip_map_get_reqs_nl_policy,
+		.maxattr	= SUNRPC_A_IP_MAP_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= SUNRPC_CMD_IP_MAP_SET_REQS,
+		.doit		= sunrpc_nl_ip_map_set_reqs_doit,
+		.policy		= sunrpc_ip_map_set_reqs_nl_policy,
+		.maxattr	= SUNRPC_A_IP_MAP_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group sunrpc_nl_mcgrps[] = {
diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
index efb05f87b89513fe738964a1b27637a09f9b88a9..6849faec517ea33ddc5cafab827381984e0dc602 100644
--- a/net/sunrpc/netlink.h
+++ b/net/sunrpc/netlink.h
@@ -12,6 +12,14 @@
 
 #include <uapi/linux/sunrpc_netlink.h>
 
+/* Common nested types */
+extern const struct nla_policy sunrpc_ip_map_nl_policy[SUNRPC_A_IP_MAP_EXPIRY + 1];
+
+int sunrpc_nl_ip_map_get_reqs_dumpit(struct sk_buff *skb,
+				     struct netlink_callback *cb);
+int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb,
+				   struct genl_info *info);
+
 enum {
 	SUNRPC_NLGRP_NONE,
 	SUNRPC_NLGRP_EXPORTD,
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 87732c4cb8383c64b440538a0d3f3113a3009b4e..e4b196742877bd3abf199f2bf815b90615a2be04 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -17,11 +17,14 @@
 #include <net/ipv6.h>
 #include <linux/kernel.h>
 #include <linux/user_namespace.h>
+#include <net/genetlink.h>
+#include <uapi/linux/sunrpc_netlink.h>
 #include <trace/events/sunrpc.h>
 
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
 #include "netns.h"
+#include "netlink.h"
 
 /*
  * AUTHUNIX and AUTHNULL credentials are both handled here.
@@ -1017,12 +1020,250 @@ struct auth_ops svcauth_unix = {
 	.set_client	= svcauth_unix_set_client,
 };
 
+static int ip_map_notify(struct cache_detail *cd, struct cache_head *h)
+{
+	return sunrpc_cache_notify(cd, h, SUNRPC_CACHE_TYPE_IP_MAP);
+}
+
+/**
+ * sunrpc_nl_ip_map_get_reqs_dumpit - dump pending ip_map requests
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Walk the ip_map cache's pending request list and create a netlink
+ * message with a nested entry for each cache_request, containing the
+ * seqno, class and addr.
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int sunrpc_nl_ip_map_get_reqs_dumpit(struct sk_buff *skb,
+				     struct netlink_callback *cb)
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
+	cd = sn->ip_map_cache;
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
+			  NLM_F_MULTI, SUNRPC_CMD_IP_MAP_GET_REQS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto out_put;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		struct ip_map *im;
+		struct nlattr *nest;
+		char text_addr[40];
+
+		im = container_of(items[i], struct ip_map, h);
+
+		if (ipv6_addr_v4mapped(&im->m_addr))
+			snprintf(text_addr, 20, "%pI4",
+				 &im->m_addr.s6_addr32[3]);
+		else
+			snprintf(text_addr, 40, "%pI6", &im->m_addr);
+
+		nest = nla_nest_start(skb, SUNRPC_A_IP_MAP_REQS_REQUESTS);
+		if (!nest) {
+			ret = -ENOBUFS;
+			goto out_cancel;
+		}
+
+		if (nla_put_u64_64bit(skb, SUNRPC_A_IP_MAP_SEQNO,
+				      seqnos[i], 0) ||
+		    nla_put_string(skb, SUNRPC_A_IP_MAP_CLASS,
+				   im->m_class) ||
+		    nla_put_string(skb, SUNRPC_A_IP_MAP_ADDR, text_addr)) {
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
+ * sunrpc_nl_parse_one_ip_map - parse one ip_map entry from netlink
+ * @cd: cache_detail for the ip_map cache
+ * @attr: nested attribute containing ip_map fields
+ *
+ * Parses one ip_map entry from a netlink message and updates the
+ * cache. Mirrors the logic in ip_map_parse().
+ *
+ * Returns 0 on success or a negative errno.
+ */
+static int sunrpc_nl_parse_one_ip_map(struct cache_detail *cd,
+				      struct nlattr *attr)
+{
+	struct nlattr *tb[SUNRPC_A_IP_MAP_EXPIRY + 1];
+	union {
+		struct sockaddr		sa;
+		struct sockaddr_in	s4;
+		struct sockaddr_in6	s6;
+	} address;
+	struct sockaddr_in6 sin6;
+	struct ip_map *ipmp;
+	struct auth_domain *dom = NULL;
+	struct unix_domain *udom = NULL;
+	struct timespec64 boot;
+	time64_t expiry;
+	char class[8];
+	int err;
+	int len;
+
+	err = nla_parse_nested(tb, SUNRPC_A_IP_MAP_EXPIRY, attr,
+			       sunrpc_ip_map_nl_policy, NULL);
+	if (err)
+		return err;
+
+	/* class (required) */
+	if (!tb[SUNRPC_A_IP_MAP_CLASS])
+		return -EINVAL;
+	len = nla_len(tb[SUNRPC_A_IP_MAP_CLASS]);
+	if (len <= 0 || len > sizeof(class))
+		return -EINVAL;
+	nla_strscpy(class, tb[SUNRPC_A_IP_MAP_CLASS], sizeof(class));
+
+	/* addr (required) */
+	if (!tb[SUNRPC_A_IP_MAP_ADDR])
+		return -EINVAL;
+	if (rpc_pton(cd->net, nla_data(tb[SUNRPC_A_IP_MAP_ADDR]),
+		     nla_len(tb[SUNRPC_A_IP_MAP_ADDR]) - 1,
+		     &address.sa, sizeof(address)) == 0)
+		return -EINVAL;
+
+	switch (address.sa.sa_family) {
+	case AF_INET:
+		sin6.sin6_family = AF_INET6;
+		ipv6_addr_set_v4mapped(address.s4.sin_addr.s_addr,
+				       &sin6.sin6_addr);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		memcpy(&sin6, &address.s6, sizeof(sin6));
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	/* expiry (required, wallclock seconds) */
+	if (!tb[SUNRPC_A_IP_MAP_EXPIRY])
+		return -EINVAL;
+	getboottime64(&boot);
+	expiry = nla_get_u64(tb[SUNRPC_A_IP_MAP_EXPIRY]) - boot.tv_sec;
+
+	/* domain name or negative */
+	if (tb[SUNRPC_A_IP_MAP_NEGATIVE]) {
+		udom = NULL;
+	} else if (tb[SUNRPC_A_IP_MAP_DOMAIN]) {
+		dom = unix_domain_find(nla_data(tb[SUNRPC_A_IP_MAP_DOMAIN]));
+		if (!dom)
+			return -ENOENT;
+		udom = container_of(dom, struct unix_domain, h);
+	} else {
+		return -EINVAL;
+	}
+
+	ipmp = __ip_map_lookup(cd, class, &sin6.sin6_addr);
+	if (ipmp)
+		err = __ip_map_update(cd, ipmp, udom, expiry);
+	else
+		err = -ENOMEM;
+
+	if (dom)
+		auth_domain_put(dom);
+
+	cache_flush();
+	return err;
+}
+
+/**
+ * sunrpc_nl_ip_map_set_reqs_doit - respond to ip_map requests
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Parse one or more ip_map cache responses from userspace and
+ * update the ip_map cache accordingly.
+ *
+ * Returns 0 on success or a negative errno.
+ */
+int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb,
+				   struct genl_info *info)
+{
+	struct sunrpc_net *sn;
+	struct cache_detail *cd;
+	const struct nlattr *attr;
+	int rem, ret = 0;
+
+	sn = net_generic(genl_info_net(info), sunrpc_net_id);
+
+	cd = sn->ip_map_cache;
+	if (!cd)
+		return -ENODEV;
+
+	nlmsg_for_each_attr_type(attr, SUNRPC_A_IP_MAP_REQS_REQUESTS,
+				 info->nlhdr, GENL_HDRLEN, rem) {
+		ret = sunrpc_nl_parse_one_ip_map(cd,
+						 (struct nlattr *)attr);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static const struct cache_detail ip_map_cache_template = {
 	.owner		= THIS_MODULE,
 	.hash_size	= IP_HASHMAX,
 	.name		= "auth.unix.ip",
 	.cache_put	= ip_map_put,
 	.cache_upcall	= ip_map_upcall,
+	.cache_notify	= ip_map_notify,
 	.cache_request	= ip_map_request,
 	.cache_parse	= ip_map_parse,
 	.cache_show	= ip_map_show,

-- 
2.53.0


