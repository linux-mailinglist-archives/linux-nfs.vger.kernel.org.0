Return-Path: <linux-nfs+bounces-20246-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJBFOOezumlWawIAu9opvQ
	(envelope-from <linux-nfs+bounces-20246-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:17:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600A2BCE28
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D37CD3017FB8
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9D3DB65E;
	Wed, 18 Mar 2026 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/0In1H5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D383DB649;
	Wed, 18 Mar 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843327; cv=none; b=ITWB2gJehCKpsOCrN6ejlDkhV5WEEDq8rVaJZkjpxIKsmswrQjOvGSnzR4H8AbARKD/WPAnbOLxhby3TXkmSefE3eFQCeE345X7UTvlT93zFo9jXOePSZ4Osw3GupDQQH/ncgABruJrYVBuspvAErTXB4ArDF/mZpZfzCY8hmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843327; c=relaxed/simple;
	bh=EBIdPEn/eYIGWSsc/2o0Y5VI/86wokwptXxUHNnYsKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBDuFDae15pYa5OB1UNCKLf81xCifk2q7aKjOqiAmehstAArZxLFD7CDCyKNrpn07kvRRjB3vavz5weTNs7LosOMtJSX5vltpZ3Ke8SPpHtAIdJaC+g/fivcxa5kWCTWBlwFkM5WhaocabtdEft1F2iI76iVlT6W4/fI+N9CZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/0In1H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99450C2BCAF;
	Wed, 18 Mar 2026 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843327;
	bh=EBIdPEn/eYIGWSsc/2o0Y5VI/86wokwptXxUHNnYsKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s/0In1H5B1D2Epp9G3FDYtv4BAYTDnFkDFQvbZKO0QnhusDmCwU6dI6jQLl1XuD6K
	 7BaJHysfry8R4rOe5wdskGOoUcH3waLpsam7YutIsSUrc7jnKIS7ZIRoF93b3/Mttm
	 djLwO5fx3ZdjHap9UbeMK8BiDoYqYNSkmjejv31Pcbsb9lFyp2esRP1WsrWrQ/ICiZ
	 YlpL8A3ko69lhthPNmhZK56NGIpG5hLcBKaOuQkcLd8INTJNe0gb5559kiNiz3PPg5
	 VtrywIfWntqrVxjeJDy921tpzGblS14X8/mPktYY5OKHeEdWJzVYv9wQpcA+7zGSCl
	 k5zx5OU5ujuKA==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 18 Mar 2026 10:15:04 -0400
Subject: [PATCH v4 2/6] NFSD: Add NFSD_CMD_UNLOCK netlink command with ip
 scope
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-umount-kills-nfsv4-state-v4-2-56aad44ab982@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
In-Reply-To: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8796;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=QISD3TCI6F11mqyrAZ2/XnvW0Y2y681eMj9mzkWORCQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpurN8RbG3WapvxUuOAOL8bDPMpVcr/8Zq3w6Ja
 +aiUjtdiViJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabqzfAAKCRAzarMzb2Z/
 l6lsEACrner7spUu6YdXe+oBlAvrPfP/HC8ru3aCYGQqYRpLWXDgkxnI18h/umHux/6xGeh3b9S
 +MzJCszDOevWmcZh8HodqsDLg7RBcDaYFhlTkaw50LoNXbqnhqFxxbUxDpbvtBtuF+JrCAezRWP
 6m+nkofL8KCr4DdvPXkTTMl/qDFszKLzlA44tXZ3bENd8DvWP7U7y6lRGN1vwj+O8FnBRch9Iqa
 qQQqv9VXG3YofBl76rQiOqI+bf1PFrWWwmEpK5z8FVfVn3eSbLEHXqprOnnk+7tNz50V19PnNdV
 OOT0Nle0J5fRiQcZGcMui0eDsiN3fnq4SCAompoEnGMKaAbCuXJ7wOEBoCsgPdR8a8bgDxd4jCa
 4p7RIkjVzNEBHsYE4k3OMMEMlxE3d5vhJ1vPAP5quHUWy1KPJ8ZhFvgUJCWejdmJRn9HYxYIez5
 bmPoBggcZjWgMtfimQ2bkz3O17YlY2HeUBdQKsUiQLT8kD/GDBkVG9+tTJnqVyY4+j60nPQ8eJB
 q7ElI9LJ10JCivqr7OMlNyMyKOwAQ4pxleax8uAazsoefmIXP/5+L6dpQxMxPUEue/rXSWLzYjH
 cEtMltqLJWPQFDrpnVZBs9LTZoJTvIsNaJISx3eVtG/y4bHzIRIJectim+9zQnbRkjUNsVaa0ui
 crt1O+oI930/msw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20246-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7600A2BCE28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The existing write_unlock_ip procfs interface releases NLM file
locks held by a specific client IP address, but procfs provides
no structured way to extend that operation to other scopes such
as revoking NFSv4 state. A netlink command allows the operation
to carry typed, validated attributes and supports future scope
values without interface proliferation.

NFSD_CMD_UNLOCK accepts an unlock-type attribute selecting the
scope and an address attribute carrying a binary sockaddr_in
or sockaddr_in6. The handler validates the address family
and length, then calls nlmsvc_unlock_all_by_ip() to release
matching NLM locks. Because lockd is a single global instance,
that call operates across all network namespaces regardless of
which namespace the caller inhabits. The command requires admin
privileges via GENL_ADMIN_PERM.

The unlock-type enum begins with a single value, ip, and is
defined with render-max so that future values can be added
without breaking existing userspace.

The nfsd_ctl_unlock_ip tracepoint is updated from string-based
address logging to __sockaddr, which stores the binary sockaddr
and formats it with %pISpc. This affects both the new netlink
path and the existing procfs write_unlock_ip path, giving
consistent structured output in both cases.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml | 32 ++++++++++++++++++
 fs/nfsd/netlink.c                     | 13 ++++++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/nfsctl.c                      | 63 ++++++++++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 13 ++++----
 include/uapi/linux/nfsd_netlink.h     | 17 ++++++++++
 6 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index f87b5a05e5e9..02fadfca22ba 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -6,6 +6,13 @@ uapi-header: linux/nfsd_netlink.h
 
 doc: NFSD configuration over generic netlink.
 
+definitions:
+  -
+    type: enum
+    name: unlock-type
+    render-max: true
+    entries: [ip]
+
 attribute-sets:
   -
     name: rpc-status
@@ -127,6 +134,21 @@ attribute-sets:
       -
         name: npools
         type: u32
+  -
+    name: unlock
+    attributes:
+      -
+        name: type
+        type: u32
+        enum: unlock-type
+      -
+        name: address
+        type: binary
+        doc: >-
+          struct sockaddr_in or struct sockaddr_in6.
+          Required when type is ip.
+        checks:
+          min-len: 16
 
 operations:
   list:
@@ -227,3 +249,13 @@ operations:
           attributes:
             - mode
             - npools
+    -
+      name: unlock
+      doc: release NLM locks by scope
+      attribute-set: unlock
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - type
+            - address
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 887525964451..9ec0d56eaa21 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -47,6 +47,12 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
 	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
 };
 
+/* NFSD_CMD_UNLOCK - do */
+static const struct nla_policy nfsd_unlock_nl_policy[NFSD_A_UNLOCK_ADDRESS + 1] = {
+	[NFSD_A_UNLOCK_TYPE] = NLA_POLICY_MAX(NLA_U32, 0),
+	[NFSD_A_UNLOCK_ADDRESS] = NLA_POLICY_MIN_LEN(16),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -102,6 +108,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_pool_mode_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_UNLOCK,
+		.doit		= nfsd_nl_unlock_doit,
+		.policy		= nfsd_unlock_nl_policy,
+		.maxattr	= NFSD_A_UNLOCK_ADDRESS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 478117ff6b8c..3ece774e5f52 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -26,6 +26,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_unlock_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 4cc8a58fa56a..858f3803c490 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -236,7 +236,7 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 	if (rpc_pton(net, fo_path, size, sap, salen) == 0)
 		return -EINVAL;
 
-	trace_nfsd_ctl_unlock_ip(net, buf);
+	trace_nfsd_ctl_unlock_ip(net, sap, svc_addr_len(sap));
 	return nlmsvc_unlock_all_by_ip(sap);
 }
 
@@ -2142,6 +2142,67 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_unlock_by_ip - release NLM locks held by an IP address
+ * @info: netlink metadata and command arguments
+ *
+ * Return: 0 on success or a negative errno.
+ */
+static int nfsd_nl_unlock_by_ip(struct genl_info *info)
+{
+	struct sockaddr *sap;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_ADDRESS))
+		return -EINVAL;
+	sap = nla_data(info->attrs[NFSD_A_UNLOCK_ADDRESS]);
+	switch (sap->sa_family) {
+	case AF_INET:
+		if (nla_len(info->attrs[NFSD_A_UNLOCK_ADDRESS]) <
+		    sizeof(struct sockaddr_in))
+			return -EINVAL;
+		break;
+	case AF_INET6:
+		if (nla_len(info->attrs[NFSD_A_UNLOCK_ADDRESS]) <
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
+/**
+ * nfsd_nl_unlock_doit - release NLM locks by scope
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return: 0 on success or a negative errno.
+ */
+int nfsd_nl_unlock_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	u32 type;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_TYPE))
+		return -EINVAL;
+
+	type = nla_get_u32(info->attrs[NFSD_A_UNLOCK_TYPE]);
+
+	switch (type) {
+	case NFSD_UNLOCK_TYPE_IP:
+		return nfsd_nl_unlock_by_ip(info);
+	default:
+		return -EINVAL;
+	}
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1d0b0dd0545..c770c5e6b1e7 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1984,19 +1984,20 @@ TRACE_EVENT(nfsd_cb_recall_any_done,
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
index e9efbc9e63d8..8edd75590f31 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -10,6 +10,14 @@
 #define NFSD_FAMILY_NAME	"nfsd"
 #define NFSD_FAMILY_VERSION	1
 
+enum nfsd_unlock_type {
+	NFSD_UNLOCK_TYPE_IP,
+
+	/* private: */
+	__NFSD_UNLOCK_TYPE_MAX,
+	NFSD_UNLOCK_TYPE_MAX = (__NFSD_UNLOCK_TYPE_MAX - 1)
+};
+
 enum {
 	NFSD_A_RPC_STATUS_XID = 1,
 	NFSD_A_RPC_STATUS_FLAGS,
@@ -80,6 +88,14 @@ enum {
 	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
 };
 
+enum {
+	NFSD_A_UNLOCK_TYPE = 1,
+	NFSD_A_UNLOCK_ADDRESS,
+
+	__NFSD_A_UNLOCK_MAX,
+	NFSD_A_UNLOCK_MAX = (__NFSD_A_UNLOCK_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -90,6 +106,7 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_UNLOCK,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


