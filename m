Return-Path: <linux-nfs+bounces-20434-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNjWBA51xWnw+QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20434-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:03:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A3E339C63
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 19:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1F0307C967
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202DD3A4F4A;
	Thu, 26 Mar 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpWvdR6V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F7406260;
	Thu, 26 Mar 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547740; cv=none; b=Y0Vdw/l2WzjsG1x0xU7OCmwjPi/XX1rHmunkEHjB84R5OtcqN/JGsCAupgZfPZy9BTJpbC4GpumH+dY+szezYzGQAfCqNH9udveDMR0H92Mf9FZI19204XG5+zP4qYTj1HpKHP8M8rySjGcSl1D8Y0WW/D3NJOJcpGFXoZN7R+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547740; c=relaxed/simple;
	bh=dT1KwKV8rtM2REnccDfnT0zX6CH7YrTyipc1G9Lhce4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+bqnVws5Pdp6Or/hSmwN5jX76kiUwW6qVWN0N/tsK1wMh65s4CJ8levfQigs4+MGY+Lux6XIMRjRXo5stJjzwpA5oXSqh+QhJycK0FEBIHxZmv6EVHPP42p5n4/kBLRKEhWt9D+kTQ3+bjX2RF1wakFTsne+BL9v6+xEXUv4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpWvdR6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB61DC19423;
	Thu, 26 Mar 2026 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547740;
	bh=dT1KwKV8rtM2REnccDfnT0zX6CH7YrTyipc1G9Lhce4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WpWvdR6VdGR3g/3tv23F32/vxWVGXSXkPnGD6I3Wq8qgsAq1tF3nPr9L6+3Sm6Nii
	 LvEjG5ejqmo5/746+Gh9ZaFUZ03JdkTDr4dn3KrL6UrnYBdWTZHc+Ie+q0VvxdynQQ
	 +ju2jMQfYn/cFn+pzaPgTvQKBXsWQ2GrOLhYx8dK585Wm8b3gTk25/438+d3Hv6TAq
	 7zN4eH9DU9VZMyrXwo3+tauQxx1Lf8H9WMRtOJ1Aio9LsYY0RDmq9Bje7OpLXQs/RB
	 CFLAYyzCv3Nas3whuQ01bo8/g4JlGXyXkUNpw8tLDLMWTXXNxjwOVdCdvyenO9pTcY
	 4kBCXl+noMryQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 13:55:22 -0400
Subject: [PATCH v5 3/7] NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink
 command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-umount-kills-nfsv4-state-v5-3-d2ce071b3570@oracle.com>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
In-Reply-To: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5638;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=XkXIaJg8nA9zdCDvNvhLZ5FwDXcIEIfVDPi+vt73KFo=;
 b=kA0DAAoBM2qzM29mf5cByyZiAGnFcxiiLtW5x0/4WtqT/KYF2ap2euIykkwZhSVUcNN86RmEo
 YkCMwQAAQoAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJpxXMYAAoJEDNqszNvZn+X2psP/1fD
 BqQtnNCt+ULBChzVMImTZjCI0+VwpdTsBH++45sXJcyzQkBJrhz6OeLI9bmg6aofXsl/Nds4woG
 Zb4o20MzBd/SiyO2GThR+p1ODfreYPC1uP3MUGoMpSWLRBYD/h7tawmgee8x+T6GQmFQiNRGbGE
 q3AWjxT7IKvjsdo9zN264K/PNpuqY95onymblVJnmsvSQjnqrNnyd9SS1Y1wjRCo/ai00C68k/L
 UlkT6kghgw5ckszA9M5lKEH3gS2UxopK5gIOi9eqBjbzqOt7tw1Mi8jZqo3kuwvjnyh7blRqES2
 ShNl/HLyYsg2T1eRdnVzKa2GGjAyThbtgz2Iv4DFSrJEjbsZcQUJz9HzyLBu0a8HizAjYSaQJ4v
 uqDRvCv9UwL2hdd8n8g9BKHOg7on+ixo+P57yKcImUC+JH+vwnCAWtEn9OlTmNJaASfPjZKzU3I
 Ii25TTpN5jz3KRoH3JzjebCtC4yJYd0SrvOWqSrwXMT4/jJRmvjtNssipCFTTd2TZxTy8Z6Ct2J
 ipMCL0zEPvl4XD4nO2LXFMomc0SlfahHA/k57fGB8miEuGld3Sb4tymX4eNeLmOtvlMlS6OT0al
 NhDbBon7KqmpLHyMSmpVCEjZeYK2JZhhoYoUT7/FiZ9WzxCjN7CAZWkZA3Yi7SIrNoJKJmiBQu+
 tRrRo
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
	TAGGED_FROM(0.00)[bounces-20434-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8A3E339C63
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml | 16 ++++++++++++++
 fs/nfsd/netlink.c                     | 12 +++++++++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/nfsctl.c                      | 40 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  8 +++++++
 5 files changed, 77 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 9918b9a84d88..e83209a4a19d 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -141,6 +141,13 @@ attribute-sets:
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
@@ -251,3 +258,12 @@ operations:
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
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 6b7221ce6869..18afebaf4fef 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -53,6 +53,11 @@ static const struct nla_policy nfsd_unlock_ip_nl_policy[NFSD_A_UNLOCK_IP_ADDRESS
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
@@ -115,6 +120,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
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
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 3c2d5996612f..9535782b529a 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -27,6 +27,7 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e1e89d52e6de..ed0d12f77405 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2238,6 +2238,46 @@ int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info)
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
index 4153e9c69fbf..51f926c0b15b 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -88,6 +88,13 @@ enum {
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
@@ -99,6 +106,7 @@ enum {
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
 	NFSD_CMD_UNLOCK_IP,
+	NFSD_CMD_UNLOCK_FILESYSTEM,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.53.0


