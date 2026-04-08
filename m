Return-Path: <linux-nfs+bounces-20733-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPDsIMRL1ml8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20733-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:36:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD0E3BC33C
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC0B5308AE36
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CFE3CA497;
	Wed,  8 Apr 2026 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGglHWq4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C763CA493;
	Wed,  8 Apr 2026 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651412; cv=none; b=pSJklBqnr7e4te20I88/63pdx76G6yMIyElNl+4kvfCnVm54A0ih9rahdsmJ0vCWwpaduLP+AuB2R/5pUiIUdzsdqUfYyjxbC6845eLKk9m/LNP89L0O4aNV9xxscKNKm/wwkzsUR8+b7d2qocfKkH5EdDtmdAVIt1iLk4W0ruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651412; c=relaxed/simple;
	bh=lOMdKk3txwjkm+iO09AURrxB6hV2A6CmuZXnhLbiS6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Co8ggYwuNXxjNBsWeKzSg5Mg/cz9ty1YzDZUE7sqe8tQSmgONfAvn2IsOYu8uMBOtWg+AXnW+DciHSV5rEqGzl9oFi5Ay9owpL8WgOKbvyEbKGnRhkrEHErxqfTlNE60osWmPEX03MLdmgu0snvcoWR8LsRSRGf5U6xaqmSsVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGglHWq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86029C2BCB0;
	Wed,  8 Apr 2026 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651412;
	bh=lOMdKk3txwjkm+iO09AURrxB6hV2A6CmuZXnhLbiS6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QGglHWq47gWqQT40k8pOYyrbypS+mGYPab1wif4Lirn0HFtsMOEUi6M3ki9n3B/Ij
	 fDNggDGQDV8qEE4dqSItJAOzAKghZGQuxo+DbFbmrZ9yQNNOTkM6Kb4+WBdTg5xZwN
	 mAizAUok/hGPfdiPsGsp2ntre15C1Fi2A8QsDiWIGv34EgT712zbFReW2mosE0QkP2
	 ml6NUIVyRLO9EONETvLyg/h6PIeNgv9TSbcTbRuPbRrwSUK/q4sMFN6B3z2Zn7NhCp
	 uLZ2R+YhCO2dJKGdf9ccjdF8zc1B/FAMMCzePi4358MCwbcL0DDTbB4axoKdVn1YK1
	 Utp9KuGkOr55g==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 08 Apr 2026 08:29:54 -0400
Subject: [PATCH v8 4/9] NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-umount-kills-nfsv4-state-v8-4-6e02a1d03d60@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
In-Reply-To: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7423;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=S6fL9u7vaYvp6asaxPkYsJ+FVJzp4wWG6bIB83D6l50=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpPvVjM9zUjmKa1rvU3/K+UU6QpKybANz/+w
 reSh1uuIg6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKTwAKCRAzarMzb2Z/
 l6soD/0b4ox8Uhmi+kCXILOlm/5bk98yzQI5OjvlHM6bF/0XrgWr1Y5gKJ6gjk3v9gcxtOyqA1y
 /oiQXZuemMEObRIW7QKX9W/NJyi+rfi5Z4RKUxG8ERQ0pV137cbtJZvzH8wsXBhbT31OolEHI7k
 LLxL6fRddk/g7jnBF4PecgMWSTS1gDYiqIRqmsEmBQkSfpog0Mkg8Q4QJolxNqPBJEcSTyfZNiW
 uJojcdgcvt+rmqmmPNvtHxteZ/f/kyENKCjBFNfuvao3JjWawyXETAlMA0+0MtZXJye2rRe2qA/
 UV5UTK2A0kmA4bHqmAuTNSSmswfIIEPvPcpE2rxwP4J1nKx4nzjYZrGuK4wG+E0sh6fVMJC/24Z
 qlTaQXwaQ82YkbJKaSRgKB+49tkIEWV6gTDufnMJSJQ5msYKmtbelfkvTKPP/nhXJ1s6CQ7hGSu
 EBnF+txr5XdnqqmxIl0A/Lthj6sEO8DJ4dI8BpliygPRHckpCJZi9BWzWjRgAEyAretV0S5i+LT
 R2MIAs6J/BfYnDdFyaUsHj/KtKVPoCsFIM4GCx9q91qnMLBvXPjLKGhvL4aOoc2RrSgeJ2EJm8R
 BUXvEPakQDmeRY7L8ZudB/Rh49O6YGC1Fdsf45N60YV9MZ8wvjNOlwC50VkZO1zAtdx2J7UcFSN
 K81REwEFifVIS6w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20733-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FD0E3BC33C
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
index 40eca7c15680..2c4883cfd50a 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -301,6 +301,15 @@ attribute-sets:
         type: u32
         enum: cache-type
         enum-as-flags: true
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
@@ -455,6 +464,15 @@ operations:
         request:
           attributes:
             - mask
+    -
+      name: unlock-ip
+      doc: release NLM locks held by an IP address
+      attribute-set: unlock-ip
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - address
 
 mcast-groups:
   list:
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 30c4f8be3df9..96d326095768 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -113,6 +113,11 @@ static const struct nla_policy nfsd_cache_flush_nl_policy[NFSD_A_CACHE_FLUSH_MAS
 	[NFSD_A_CACHE_FLUSH_MASK] = NLA_POLICY_MASK(NLA_U32, 0x3),
 };
 
+/* NFSD_CMD_UNLOCK_IP - do */
+static const struct nla_policy nfsd_unlock_ip_nl_policy[NFSD_A_UNLOCK_IP_ADDRESS + 1] = {
+	[NFSD_A_UNLOCK_IP_ADDRESS] = NLA_POLICY_MIN_LEN(16),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -203,6 +208,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.maxattr	= NFSD_A_CACHE_FLUSH_MASK,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_UNLOCK_IP,
+		.doit		= nfsd_nl_unlock_ip_doit,
+		.policy		= nfsd_unlock_ip_nl_policy,
+		.maxattr	= NFSD_A_UNLOCK_IP_ADDRESS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group nfsd_nl_mcgrps[] = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index cc89732ed71b..88edbbc68453 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -39,6 +39,7 @@ int nfsd_nl_expkey_get_reqs_dumpit(struct sk_buff *skb,
 				   struct netlink_callback *cb);
 int nfsd_nl_expkey_set_reqs_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NFSD_NLGRP_NONE,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3241bcfc2c6f..c5ce4af28287 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -247,7 +247,7 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 	if (rpc_pton(net, fo_path, size, sap, salen) == 0)
 		return -EINVAL;
 
-	trace_nfsd_ctl_unlock_ip(net, buf);
+	trace_nfsd_ctl_unlock_ip(net, sap, svc_addr_len(sap));
 	return nlmsvc_unlock_all_by_ip(sap);
 }
 
@@ -2279,6 +2279,44 @@ int nfsd_cache_notify(struct cache_detail *cd, struct cache_head *h, u32 cache_t
 				       NFSD_NLGRP_EXPORTD, GFP_KERNEL);
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
index 060c43675599..90ef1e686769 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -204,6 +204,13 @@ enum {
 	NFSD_A_CACHE_FLUSH_MAX = (__NFSD_A_CACHE_FLUSH_MAX - 1)
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
@@ -220,6 +227,7 @@ enum {
 	NFSD_CMD_EXPKEY_GET_REQS,
 	NFSD_CMD_EXPKEY_SET_REQS,
 	NFSD_CMD_CACHE_FLUSH,
+	NFSD_CMD_UNLOCK_IP,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


