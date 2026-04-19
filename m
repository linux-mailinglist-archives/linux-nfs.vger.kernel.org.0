Return-Path: <linux-nfs+bounces-20961-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMYMKa8k5WmXegEAu9opvQ
	(envelope-from <linux-nfs+bounces-20961-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809A42520C
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C72D7300AC3F
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2C2FC037;
	Sun, 19 Apr 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDIqVtJ3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD682F9C37;
	Sun, 19 Apr 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624803; cv=none; b=oJwmAlncaWcgjjbThXAsKa5oOb7kncxiEi18QMj7JwrHnK58tM2DeO16uSfYx/Ae5Kd6DymSwJGjme0Wj2Tqj9Pv/tB/DDT6pNfiNaZVO+QQ1R8TmeZY1ooSfbUq9YfKxA24tciWb283Cw96giLQBySO9EmEjOi7CTMY8sOn9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624803; c=relaxed/simple;
	bh=AftLV/+wJjVEI+i3XOqEN5cNQkDKxM+CvGQrz7ITAAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMyImT+mWqE5MJ5lNmhGwm6/8u4gbckegLZk71Gc6RS5bxzkLGCfoyRAVQta/K5sw5jtrPKW6+fNL2KtCBbjqCx7SuydfBkckXKmv+z07WKqqkuV2e7T6gFUyykyfKlSiYiW4s2x10kLK3/TWchtBmoLRAkmGNt10GO448MCDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDIqVtJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F797C2BCC4;
	Sun, 19 Apr 2026 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776624803;
	bh=AftLV/+wJjVEI+i3XOqEN5cNQkDKxM+CvGQrz7ITAAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZDIqVtJ3C85Wwk4o5VmCM13MXmEnrcNMqmjjfoDaP5Rkb0aUke/ZSDUFKR0HHp1yC
	 RTlEp9FuXnSFlco9sIllfqnQF/Qu0f56EU/LMBlL7pYZPRRcKStexhWHj3aLtee2fB
	 4Zjblzy3W5cdUcjDZMDtVf8VTkJF1Odu3zQ4zmalyoR0fe9uKwAeILz8MkbJFlS+Qs
	 dxKpAFPfV+70rLaEk3+JD/+j/6J9o9IrQcL5E9I+xPl1jH96+I4QZFIbgkCaAzV28E
	 RgDsWCZ0pcs15T+8sEv4I+XdfmJVJ4yWixpgXtiP6exfgAckjckJ5lwRHVQqBA8L4w
	 l8wS/7khgF7mw==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 19 Apr 2026 14:53:03 -0400
Subject: [PATCH v9 5/9] NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink
 command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-umount-kills-nfsv4-state-v9-5-0660bd06d2b6@oracle.com>
References: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
In-Reply-To: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5689;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=PADaqiydDsD5GxnN6oVUZUmtedhYz6fcca9CKFXLQ9Q=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp5SSd4m2TjeMpAivmVUkJbLbFUe7dkkJ1jyrX3
 IHiaCWFThWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeUknQAKCRAzarMzb2Z/
 l9VoD/oD4t6hmimO/FZkg2oPfp7qzfPb3GwHYOjLDqAWe7ixMw1T8sG4h4GzlG3pBdmkcq9rMMy
 q1CBaO50tDEyvqAxRTGbG/iGLnxnNGYu0h72KsbPmgmqVrJCTL1ztIl/tJpwrYjwy8XoDrBXuC8
 mRbh3zp02fkTo4Q9QoKPe08F6zStR3gazbH3/YxjY3NesrDw32PewlgKXQd+zDqYl7yMgy1TO0b
 eD/LUHcLhVJcGkPVHhPK97ABrHB62fd337xF4MJ6+U7ehEjFzgVmmGnG7MSoACMpQtVdnq8+Tb+
 Tggbx1wJiX5LT2dkM9ZLTcQNzzGJLHXnSPpDn/QGjhUUjk/wJhHVeGrDmVdnKg2H5jVXzTBSkct
 b9gD2IRugvBh2Hlxa4Jebjr/ONs5AMF3qlU+aJuZF8RWS+Zed9ymAeQ4sQHBuCfV6oBJ56QLAwz
 ff6jJyjSx2AAb/JD4JiRmUA1wLgIr7145ruBm2Lsa/oEA7y/2HXOLTm0Hg8u5qnYIb2ob1x3WdF
 3OoE73lSMjFFtfyIkEkQhpycAqxG8atccd9AFJx0TJZ/bOMHPpUMzPG17F+KysWGgTmcIHTmezE
 eU6qNDIa/wL0yFORx6qj7NF96pvVfQA/dc18tSx2QtQCPTLMj9XcPuPMBH5yEJt8wCZT/kCoT3x
 HzHQoNIBxoHw2ow==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20961-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 6809A42520C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Add NFSD_CMD_UNLOCK_FILESYSTEM as a dedicated netlink command for
revoking NFS state under a filesystem path, providing a netlink
equivalent of /proc/fs/nfsd/unlock_fs.

The command requires a "path" string attribute containing the
filesystem path whose state should be released. The handler
resolves the path to its superblock, then cancels async copies,
releases NLM locks, and revokes NFSv4 state on that superblock.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml | 16 ++++++++++++++
 fs/nfsd/netlink.c                     | 12 +++++++++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/nfsctl.c                      | 40 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  8 +++++++
 5 files changed, 77 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 2c4883cfd50a..f3b21d4ba660 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -310,6 +310,13 @@ attribute-sets:
         doc: struct sockaddr_in or struct sockaddr_in6.
         checks:
           min-len: 16
+  -
+    name: unlock-filesystem
+    attributes:
+      -
+        name: path
+        type: string
+        doc: Filesystem path whose state should be released.
 
 operations:
   list:
@@ -473,6 +480,15 @@ operations:
         request:
           attributes:
             - address
+    -
+      name: unlock-filesystem
+      doc: revoke NFS state under a filesystem path
+      attribute-set: unlock-filesystem
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - path
 
 mcast-groups:
   list:
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 96d326095768..dae7ad560bd8 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -118,6 +118,11 @@ static const struct nla_policy nfsd_unlock_ip_nl_policy[NFSD_A_UNLOCK_IP_ADDRESS
 	[NFSD_A_UNLOCK_IP_ADDRESS] = NLA_POLICY_MIN_LEN(16),
 };
 
+/* NFSD_CMD_UNLOCK_FILESYSTEM - do */
+static const struct nla_policy nfsd_unlock_filesystem_nl_policy[NFSD_A_UNLOCK_FILESYSTEM_PATH + 1] = {
+	[NFSD_A_UNLOCK_FILESYSTEM_PATH] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -215,6 +220,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.maxattr	= NFSD_A_UNLOCK_IP_ADDRESS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_UNLOCK_FILESYSTEM,
+		.doit		= nfsd_nl_unlock_filesystem_doit,
+		.policy		= nfsd_unlock_filesystem_nl_policy,
+		.maxattr	= NFSD_A_UNLOCK_FILESYSTEM_PATH,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group nfsd_nl_mcgrps[] = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 88edbbc68453..29bd5468d401 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -40,6 +40,7 @@ int nfsd_nl_expkey_get_reqs_dumpit(struct sk_buff *skb,
 int nfsd_nl_expkey_set_reqs_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NFSD_NLGRP_NONE,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c5ce4af28287..c35774786374 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2317,6 +2317,46 @@ int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info)
 	return nlmsvc_unlock_all_by_ip(sap);
 }
 
+/**
+ * nfsd_nl_unlock_filesystem_doit - revoke NFS state under a filesystem path
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return: 0 on success or a negative errno.
+ */
+int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb,
+				   struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct path path;
+	int error;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_FILESYSTEM_PATH))
+		return -EINVAL;
+
+	trace_nfsd_ctl_unlock_fs(net,
+			nla_data(info->attrs[NFSD_A_UNLOCK_FILESYSTEM_PATH]));
+	error = kern_path(
+			nla_data(info->attrs[NFSD_A_UNLOCK_FILESYSTEM_PATH]),
+			0, &path);
+	if (error)
+		return error;
+
+	nfsd4_cancel_copy_by_sb(net, path.dentry->d_sb);
+	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
+
+	mutex_lock(&nfsd_mutex);
+	if (nn->nfsd_serv)
+		nfsd4_revoke_states(nn, path.dentry->d_sb);
+	else
+		error = -EINVAL;
+	mutex_unlock(&nfsd_mutex);
+
+	path_put(&path);
+	return error;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 90ef1e686769..d01096c06d72 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -211,6 +211,13 @@ enum {
 	NFSD_A_UNLOCK_IP_MAX = (__NFSD_A_UNLOCK_IP_MAX - 1)
 };
 
+enum {
+	NFSD_A_UNLOCK_FILESYSTEM_PATH = 1,
+
+	__NFSD_A_UNLOCK_FILESYSTEM_MAX,
+	NFSD_A_UNLOCK_FILESYSTEM_MAX = (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -228,6 +235,7 @@ enum {
 	NFSD_CMD_EXPKEY_SET_REQS,
 	NFSD_CMD_CACHE_FLUSH,
 	NFSD_CMD_UNLOCK_IP,
+	NFSD_CMD_UNLOCK_FILESYSTEM,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


