Return-Path: <linux-nfs+bounces-20561-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOY7MIYqzGkmQgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20561-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:11:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2450C3710AE
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43BF630BD694
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF083D6477;
	Tue, 31 Mar 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnAjP67M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF483CBE6E;
	Tue, 31 Mar 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987613; cv=none; b=TH+4Wzmz5xozIyjzlF47R2h0EyM01qbPV1Nm+OKCQ8OriRlSQfKwpIhmOoe297Jw87kyZYaS/YoChmkBhkD1GJRVihys6WPfgwtjslm0Of+07q493c5zN8MZpEtL6r0GcKggPTv8CviyYQgpMrd3tQWg9rxo5N/8SzfGlW+H+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987613; c=relaxed/simple;
	bh=noo4W/SAxd9y+MZoKjp2KKQx1jX0GmPv8LXLO/6UGG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXkIGSqYZ3+lkHLlkKLhoHZ0C4eXCnSpUiEtlchs2UMd0I6DSnDoCmN4se8sGElP7LUu2fkKuJfaq0v7UzBPcScFDnAzPwvCsjTmFrJfkBNwREEdpksdON+UqEQYg/gXLCPUXTOKF2i9yz532o6AWsPnrD2OS1kGAiJfLLOe5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnAjP67M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B35BC2BC9E;
	Tue, 31 Mar 2026 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987613;
	bh=noo4W/SAxd9y+MZoKjp2KKQx1jX0GmPv8LXLO/6UGG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PnAjP67MZFuD/+o1DVZVD1JCxygWZKT7LBcmiM6l3mLfU/hwQzw7gXwHktTyvvBBe
	 hVB7YYVuZgWTz+5eO/DwWlI79Y4VQmO6+35/a4oXpCTkeIbqziZ9bg4iXl+PMxotYm
	 /x9kdJhwhmS7oXtdyt9WIxTd7jehkY2Ak2pdpuzmTOMK6up6G6rg+sQh2EplxtCLCm
	 7DpkXAWHo/SjlPjixGclCTJ90g5KUE5PzUDBenfjRRxGs67VgbE8G6wVYTZIX9YEQK
	 MjuBvhZReqxDG3rJOTxbSUKSDH1QTHWbAGoFsgSEWtKGpU3h+ecV2EAer9cTLfE9QD
	 NetVG6FREwrIQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 16:06:10 -0400
Subject: [PATCH v6 3/5] NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink
 command
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v6-3-18250f95f22a@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5685;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=KZQQpZ1eK9sXJbpD/7mfyWLJ9SwPblj3TnYsL7D9BI4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzClZV+gghV2yCwQq+O8And1MWrDKgIAKjyx9Y
 2Ub/5dib3mJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacwpWQAKCRAzarMzb2Z/
 lylBEACiWL1JXvi94A30T75mVYA1mrQA2hoMZc6aiypqY9baBaIK7r27sde924m280pgmcPDDel
 gbu9r2J8Wtk2ofPCk/wiNPh9ipC4o0n625vYf5ZylgL71i5nVFaqckKeyV9uNoxQaBdemOlQGtl
 qeLzTK8+s+p2I7mV2wz2KYLkbr2t5DD/JVrSqi8FjIz4NqpXW9pycEkbRTXa5HBQPDXaz/8UPZc
 dBOuD5ntiX36hRRx97sOQHaIXDBfK0SxXVCoorFdgsz9UfKbf48qYU3EpI3N2V8b2+5X445B/zp
 1IHdnq0IZ45iW7smpkakJIHAv4XNkq02Enxb2uxs657bOBaW9KDIQsloE2Y+2HDR8X1oiX9fVoi
 XLsOHXna6cnE+bHDQc1Onw2PB/aA3pcd1ICWxOD+XCqGgMAPnwuZHofk2YatKSws8E5X+18tS6L
 H/K0T9A1jzhZaL/2kg+0bY5/O0Wm6at/ip/nUOOl/EX+iZ0qdpJhzCGq96zeD5Pk76psP78HhRr
 UAhorp9v3U8Cy3STGSOx0JmSQvHYSsvOFf61X1+ltSOGGjfSx3MN4+uIGFuUoe3hcki5KjtgQI9
 q0qAgVsRg2SXKfmQMdvbkC52f3IirUxk9199Nyvynmcn4A8dkBqv0dAR7QOh2oaRVqx7MbFxirT
 G+wsew6wAnj7W/A==
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
	TAGGED_FROM(0.00)[bounces-20561-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 2450C3710AE
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


