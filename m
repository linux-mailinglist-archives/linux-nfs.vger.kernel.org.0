Return-Path: <linux-nfs+bounces-20560-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI3VGn4qzGkmQgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20560-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:11:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA13710A3
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2B730B9FD7
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646313D3D01;
	Tue, 31 Mar 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWRAsmmw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC583D1CB1;
	Tue, 31 Mar 2026 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987613; cv=none; b=lepRH6ozGUxk75aeKBnq/oDTUrvChfYBmLBGgjKG9rXjLwuVp+UvU9cZR0gYeVEo+o0O29XgskUx8CxfJEoEhYHAe/U3nRNbow+/R3V5BS30+eyTtrgQ/ZTT74Ebb0Rwc7tmWbVO25/jzTQP4zCRvSGH2pVTdEcAnLorU7iends=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987613; c=relaxed/simple;
	bh=AsGh/gZtEMN4vyk3auhScCsXApCMAs55SxBoK4g2+9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOPRNYMYomszYUs2WmX+RcIYgQb6to7qfmD2Fu8uNfytThiRQT39WnZa7F3PLV5cJ+Ze2VSFxNh6VPJVl7XB8AQUI1tKhNfblAbD1JSDE1ATRBNYO6rieUogD/LoKKFWLJ/W8prVy9lTP3PvQxg7RewTBvJF5u9gaSvTjyn+8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWRAsmmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F56C19423;
	Tue, 31 Mar 2026 20:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987612;
	bh=AsGh/gZtEMN4vyk3auhScCsXApCMAs55SxBoK4g2+9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZWRAsmmwojB4YwqTZkbFru0Wka/Y5cEJBnffaqclIS1O0Tpd9XAVW7sevmagHCQ4w
	 cVanOqdoqv+MnnRrXQ5g8GrGeWzPq0H+SNXryRCPMQEuqcVZDhmItHf9QzEt5QIgoL
	 klCOfOP5M9TY6nHR3B4+0LsaiowO3B6IEUU70VPYdBRuYRzMwyb1+ues3EI9eJpI4P
	 fRFTYn+rtlYTM8tlpG8yzFaKM6Lwpc9rlJS6+Jh/54CI4AKU1qpAXM2osjerYTUPkD
	 o9SYfWIhTYuAklkWOLS06dVOnUvyh68X6H6+Q4b7nPQJXi2QPZtz9TKRZdxb7FZMN+
	 k9SnBIb72dX7Q==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 16:06:09 -0400
Subject: [PATCH v6 2/5] NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v6-2-18250f95f22a@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7371;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=VdroMT4NDkFT+gjFiWFPv/roZAFBcLfxuZTBkO7MJiA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzClZDJUJup9lCpfndvD402fS0A9BrdnNdNwV+
 maeFvceA5WJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacwpWQAKCRAzarMzb2Z/
 l7VJD/sG3onvXFKntgGN/0jFdB4WGIpSxp8dgmAnXiu/zm2AX8WeaY24Ongnj1RUV4mwKwmHbtQ
 93E6dStZuUi2GuTtMYqkFU+SQfs6lCz20+9rpGu+Sh+Jf9TWkagPEo/ZIYeMvkSodGqEg6m7GLU
 tHz61D+HSasHiczfT1yJ7lZFbqK3MHi7VIN2lcppvhs/PgPQsN6RSci3HTZzbxkJvHthBwCbmtH
 jCKQfXKqHW/y7aJ8vfWDgt7lwH5wWXJ8kFD5fNKfes2HZ9O8m7VaGN8tFQtez5Ac1q1P0CGgd4n
 0eXJRsWzpydlYexi37R6/msdJUpkk3d5u3DfDxSH6t9t/RMxedIoopfZiGtVSZe9DwhCG0XgtLk
 q8TDF0trF+Amr4ynDZn9IgBwltQ8I8KhIW5bsfsKHElNmE7CAP2L6QszF4H8d+omvZ1TEjaDad1
 FrL9ryBcpblWCX99jcI13PLV00ok16UQwWe5797mNuKIxcLJ86x4yelX0FdZt9Dc7DJTKd6mQv8
 G1thGxT0hVFxmKCeeRWtfaKkzXrMT+9aHlFNJ5Kwa1A7vBTs1vxWjSLhi3+5bR/YwMukgEqsNgP
 rklHhNL6G9/eI+K1HMh6s6Ph99hUvM+sTFTl7ZPjkEcL7fUXnxxUIa4/RsUL56nBt6BT4r7zbar
 RwHpLtr7PkV5zaQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20560-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 15BA13710A3
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


