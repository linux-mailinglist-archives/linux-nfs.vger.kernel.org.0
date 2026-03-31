Return-Path: <linux-nfs+bounces-20567-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGyQL744zGlFRgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20567-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:12:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684E8371722
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8945E30E0A82
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CAE40149E;
	Tue, 31 Mar 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfD/CYRj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAD423152;
	Tue, 31 Mar 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991228; cv=none; b=iNkdpgdH8CE3mTaI+tMmkfAkoUWwbzxjFNLAPTZf35pFWm/Y7tQhZYO6+BXyMntTMQPMN7fu+oOHAUkVwAiuovakseiBJGHQmpWWXkRVyHXa8potKO3tnK3jfljPOr7O3cLkX+kdIrjqKFD6lE1tpDyJ2dgcJ+wN8QuaaD4goE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991228; c=relaxed/simple;
	bh=AsGh/gZtEMN4vyk3auhScCsXApCMAs55SxBoK4g2+9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgRzcxGoWXcOoSf7kRkFmQePYLNGGJCXiNLl2yPFeBoV8ZJcFAkHG/xfean6w+4+ANMIrb/HChf3C/fWJmdShIYZiZodRqn1NPyNBfJnGZaw1jbvd0W2Pk26coL2zWtrsnBnRJC7gHnkdRZJ1Fxa0DR6xFMYR620zcGOWLTDGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfD/CYRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975DDC2BCB2;
	Tue, 31 Mar 2026 21:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991228;
	bh=AsGh/gZtEMN4vyk3auhScCsXApCMAs55SxBoK4g2+9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JfD/CYRjVpsV+FW5fL69EaQr38qHuzKYxVRKIWRD3WRD5G9KqK6C4O8Zh7JsB2cEW
	 FQh8n/9szqqAJuqarmaV/8EdD24FSRoGwlXFVkIUi40Lc2N23ar1pBEId8W9dZgikv
	 6FvRUgoqSgtXE94GsXhRqMxIVtT34ur79ZLpekNR0MSRjZZJ1qoe082y3O9BGjalu+
	 dpAxE2PMuJMAGLs2c7Mcjldv5nPxL2/jzLS2oMdA08f/TIZWRfd/JfcsyvZJla7k1i
	 0XP7sSzLx7sx1xvPRYDrJ8cn+tyq3HAQyr5gY6wSbwfn8sCsuPEYxxIZN5q0v68Q9W
	 S4NlfVV6DPrMg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 17:06:56 -0400
Subject: [PATCH v7 2/7] NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v7-2-d8d2eee93f53@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v7-0-d8d2eee93f53@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7371;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=VdroMT4NDkFT+gjFiWFPv/roZAFBcLfxuZTBkO7MJiA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzDd5ePjHcx8cCKQEZhnp6jwK/1Aa8P7N49IUE
 Jz7aL5AntKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacw3eQAKCRAzarMzb2Z/
 l85yEADBSWP9hEgG/+qJlGAcfROChYBqRDhj1t6a/uGZlcLaIz91xoXayKoH1fz3nixlrVZZoX5
 MW0Ou3ozzfTJRJx1F/T6C52spNw/85RXAfxKRlYzGz37jXvAYPgH/DLL7cVzEqmqYxZuehLKK2x
 O9MDPlGVM8GhomA0UiK0Ymng4s9UCVpJUZJG+xxF+YB+ufnajl27EzYLrrWgZNyQ7dXWuzPxxvq
 sS44Ty8Fot1Y9ThaOdGJWxerFvT4Rzz3N+ARNoFqrbKQp/4NROatg/MAku99f5IOrIHUSJiQsQ6
 TP3kptCxEKOkcwaUCkPd5/QWFFMubXaeS9ZFL9x3uJxryzlwp/n847PrHNV+BkXVY/NazkYORAF
 08l6L7+L9L8EBCBKzJpHrT0jBe6EPYCFWn3Jfk/iZP4VHemHDkmw7VUTsLUHpXj2kX8oCsVLClv
 YuJ1w8EFmFzGMEbnBieuNNEhLamBlqlbQGvKuYEx+p+H+h6RzLucblyKpzAt1ipVS9HEQiIHdBq
 Vewdj8qesvNIv/k72NdO1ncrxQC/Uqt5ErGSr5N8Jlks8N4bkDxFAU8zmIu1dH1JF0eyUWAChYB
 9SmoVS8osXRw7keX+BLkQYQxb6JGB6Ugdg4Fc662xYzBWyRoShFM1oxYFb2wZxRj1F3vl31dbEI
 Nyz1lqtT/EwXUsQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20567-lists,linux-nfs=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,oracle.com:server fail];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 684E8371722
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


