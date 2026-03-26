Return-Path: <linux-nfs+bounces-20433-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECMdHjRzxWmN+QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20433-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 18:56:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D633997B
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 18:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22AEB300532D
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1874D402432;
	Thu, 26 Mar 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiHaADjE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955F3F7AB6;
	Thu, 26 Mar 2026 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547739; cv=none; b=slV7CHL+VFlUh3eytsRoBymHqMiiE2VT8MMf9H2T7z8ukB6JWFGjCbP0pKoFwstEQzJjkLIlhb7rWfkbXIS7S55P0v1khjyNJQYrr22eSKC37WQh2N46mOxlZ2/j1LuD+85FaHJFhFPqqXqOnYWYnubCQZj7N8ktFYPwJi3kWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547739; c=relaxed/simple;
	bh=uLyD5297sf/ns4cFdk0dSk0svKay8R3wHZ21f3TtqUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+uZTGjlY7+3Hb/dXOffoNrEcQ+yL2mgTtBWkF4+SojRSZCAlHW96NliSwbJVfjNMPr5Xn+aa5bvh7lSY6JRg4pMJnMOA07W1vNnkAPA2yOAuFrR8qAU2/58u09AMY7hAz4IXRDrg3Sx2qbpy+o5DambZJu0wE3MK4/Rq8ZMLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiHaADjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB333C2BCB2;
	Thu, 26 Mar 2026 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547739;
	bh=uLyD5297sf/ns4cFdk0dSk0svKay8R3wHZ21f3TtqUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KiHaADjE5CriaGtY2euA0PdHvpquSuETjBsS88Ok7hpv8+k95NxCG5YmMYq6uci54
	 66c6TbZqccx0f8ZqEQZdQlsTCkdD6gGnMBmPEJHLVE8oqgQb6MxXrChT6qb1sihaH/
	 fzjUKtWxFLJ3bo9jX5UkA7WwYa6aEeZLuxDmJBpX8VwYy+NdFySGrxjjrTINT/bf2s
	 /wiNzJzlCPOY9k1U9bhd+13cztvrOx450aLk8TDsfAj7Yso2ha0FAg0RmwGz2kDESc
	 6aiIjt2d9roTtbCsqEa34e++GnVnQ9PfCBu4zPu+8DFQgk1wjsYYWmfdyu0wuTMm5+
	 cjt12AsTSYimg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 13:55:21 -0400
Subject: [PATCH v5 2/7] NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-umount-kills-nfsv4-state-v5-2-d2ce071b3570@oracle.com>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
In-Reply-To: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7324;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=4SM6EKj/aaVMxHwb+yWTUFSO8l4FSIf/Ngzf1OFAMoA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxXMYj1WYjtDyANFOnSbO37ErTRUSe72f0Df4q
 DSw35Kqfk6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacVzGAAKCRAzarMzb2Z/
 l8TGD/9lu57v3WWj4w8tk7bxVOrPcikvMnOluY6DCVrTwmc3miR7tnFEIN6bTgsyG5/Dp/IoH4s
 ngWfPHddjzJyCYOd0E449R4gNG9esn19SL4/moHi1etDUgW0j8V/Yw5YjVzV8F+6I9hnhBC0D/A
 Nj12SmERvFQF0DHdVu8ZhqkDCiP1JPbayTLrax5kx6mfcv61RB8jN2JbIqEwD/Bb5NfShC3Xn3m
 f4wXbFal+73I/MwVo+SEORM/vYve/fvTX7s+vBLFnbMbNNucHk9g0zMY8NE6r8kd0BObz+6jxrM
 zoa1RILKAFJqfqNF8g/QebMzL2jbjx+ZGD4C81toa0O25Kv9CJFe8/k/qJ2BoB6knW/fEdAYHcj
 67pEz1BnDauuWD/S0wqK20yeFf7hKhr4dfX+2oT3WaaqJ4oBhfyeOpQsLKTHcdfzKWolksuRWzj
 Dxhkv/ndrAol3NFFh++wYOVFRjMg88dFFr7a8NA+jp74T7khzCm6zURMv1gBdOGvMjDRB6VTqP0
 nNxPS+V26VZcJlAR/vC9Pbzq+2VDLhcMU9UNSHGhzIJi1r5Ss1PmWkNURbQnaVvH6HC+lJeyvnz
 EroMyfYeBv8mPEYO2Hc1/cgvf38y5GercZ6Ka6Ynbu1TW93cbEomvXPHDoctSICeU5RqNL1zZyX
 vVGrbQbntSlIRNA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20433-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F5D633997B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The existing write_unlock_ip procfs interface releases NLM file
locks held by a specific client IP address, but procfs provides
no structured way to extend that operation to other scopes such as
revoking NFSv4 state.

Add NFSD_CMD_UNLOCK_IP as a dedicated netlink command for
releasing NLM locks by client address. The command accepts a
binary sockaddr_in or sockaddr_in6 in its address attribute.
The handler validates the address family and length, then calls
nlmsvc_unlock_all_by_ip() to release matching NLM locks.  Because
lockd is a single global instance, that call operates across
all network namespaces regardless of which namespace the caller
inhabits.

A separate netlink command for filesystem-scoped unlock is added in
a subsequent commit.

The nfsd_ctl_unlock_ip tracepoint is updated from string-based
address logging to __sockaddr, which stores the binary sockaddr
and formats it with %pISpc. This affects both the new netlink path
and the existing procfs write_unlock_ip path, giving consistent
structured output in both cases.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml | 18 ++++++++++++++++
 fs/nfsd/netlink.c                     | 12 +++++++++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/nfsctl.c                      | 40 ++++++++++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 13 ++++++------
 include/uapi/linux/nfsd_netlink.h     |  8 +++++++
 6 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 8ab43c8253b2..9918b9a84d88 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -132,6 +132,15 @@ attribute-sets:
       -
         name: npools
         type: u32
+  -
+    name: unlock-ip
+    attributes:
+      -
+        name: address
+        type: binary
+        doc: struct sockaddr_in or struct sockaddr_in6.
+        checks:
+          min-len: 16
 
 operations:
   list:
@@ -233,3 +242,12 @@ operations:
           attributes:
             - mode
             - npools
+    -
+      name: unlock-ip
+      doc: release NLM locks held by an IP address
+      attribute-set: unlock-ip
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - address
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 81c943345d13..6b7221ce6869 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -48,6 +48,11 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
 	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
 };
 
+/* NFSD_CMD_UNLOCK_IP - do */
+static const struct nla_policy nfsd_unlock_ip_nl_policy[NFSD_A_UNLOCK_IP_ADDRESS + 1] = {
+	[NFSD_A_UNLOCK_IP_ADDRESS] = NLA_POLICY_MIN_LEN(16),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -103,6 +108,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_pool_mode_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_UNLOCK_IP,
+		.doit		= nfsd_nl_unlock_ip_doit,
+		.policy		= nfsd_unlock_ip_nl_policy,
+		.maxattr	= NFSD_A_UNLOCK_IP_ADDRESS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 478117ff6b8c..3c2d5996612f 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -26,6 +26,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 988a79ec4a79..e1e89d52e6de 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -246,7 +246,7 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 	if (rpc_pton(net, fo_path, size, sap, salen) == 0)
 		return -EINVAL;
 
-	trace_nfsd_ctl_unlock_ip(net, buf);
+	trace_nfsd_ctl_unlock_ip(net, sap, svc_addr_len(sap));
 	return nlmsvc_unlock_all_by_ip(sap);
 }
 
@@ -2200,6 +2200,44 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_unlock_ip_doit - release NLM locks held by an IP address
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return: 0 on success or a negative errno.
+ */
+int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sockaddr *sap;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_IP_ADDRESS))
+		return -EINVAL;
+	sap = nla_data(info->attrs[NFSD_A_UNLOCK_IP_ADDRESS]);
+	switch (sap->sa_family) {
+	case AF_INET:
+		if (nla_len(info->attrs[NFSD_A_UNLOCK_IP_ADDRESS]) <
+		    sizeof(struct sockaddr_in))
+			return -EINVAL;
+		break;
+	case AF_INET6:
+		if (nla_len(info->attrs[NFSD_A_UNLOCK_IP_ADDRESS]) <
+		    sizeof(struct sockaddr_in6))
+			return -EINVAL;
+		break;
+	default:
+		return -EAFNOSUPPORT;
+	}
+	/*
+	 * nlmsvc_unlock_all_by_ip() releases matching locks
+	 * across all network namespaces because lockd operates
+	 * a single global instance.
+	 */
+	trace_nfsd_ctl_unlock_ip(genl_info_net(info), sap,
+				 svc_addr_len(sap));
+	return nlmsvc_unlock_all_by_ip(sap);
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 5ad38f50836d..976815f6f30f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1985,19 +1985,20 @@ TRACE_EVENT(nfsd_cb_recall_any_done,
 TRACE_EVENT(nfsd_ctl_unlock_ip,
 	TP_PROTO(
 		const struct net *net,
-		const char *address
+		const struct sockaddr *addr,
+		const unsigned int addrlen
 	),
-	TP_ARGS(net, address),
+	TP_ARGS(net, addr, addrlen),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
-		__string(address, address)
+		__sockaddr(addr, addrlen)
 	),
 	TP_fast_assign(
 		__entry->netns_ino = net->ns.inum;
-		__assign_str(address);
+		__assign_sockaddr(addr, addr, addrlen);
 	),
-	TP_printk("address=%s",
-		__get_str(address)
+	TP_printk("addr=%pISpc",
+		__get_sockaddr(addr)
 	)
 );
 
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 97c7447f4d14..4153e9c69fbf 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -81,6 +81,13 @@ enum {
 	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
 };
 
+enum {
+	NFSD_A_UNLOCK_IP_ADDRESS = 1,
+
+	__NFSD_A_UNLOCK_IP_MAX,
+	NFSD_A_UNLOCK_IP_MAX = (__NFSD_A_UNLOCK_IP_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -91,6 +98,7 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_UNLOCK_IP,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


