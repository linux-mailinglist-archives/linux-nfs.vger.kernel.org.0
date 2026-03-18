Return-Path: <linux-nfs+bounces-20247-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DhKJAm2umlWawIAu9opvQ
	(envelope-from <linux-nfs+bounces-20247-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:26:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 146D92BD0E0
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F7463188F00
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DB3DA5C4;
	Wed, 18 Mar 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLINcIHQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7F3DBD42;
	Wed, 18 Mar 2026 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843328; cv=none; b=hiivtK0mCoOKRUgfLDQJaaDce/fPLPVodUX8GWX3o4Ze08OonP098XtyYppuxYSNdV+M4jOTmHuMlXfELkX1sDvszWwreUZhKKcyzQ4/BQ+goeaSJkpFQRdXkgdHowz08B7yKdouWKa8QR5GL+YSUz/sjtEaMKVXsdi3GZgq7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843328; c=relaxed/simple;
	bh=k/wlFaQenagq+3XThPITRrCS3wwwo+Uq2MnpCHtwo6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFBt+necvP9UGlfwMLG+Eo/i973tDfNGb1zzQt4d5vzqDj1WANHXdR7vOQA9mm2Jq29HOohfDkhUIhmN+jH0RCDlYFoicECPAv/vngKk0HkKI+JFg4JDvODWluJZcl0lcBjZEQQ+QMdkcOjs6ZU4JE0WDnT0SCpu6aIk5eDnoeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLINcIHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D801C19424;
	Wed, 18 Mar 2026 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843328;
	bh=k/wlFaQenagq+3XThPITRrCS3wwwo+Uq2MnpCHtwo6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZLINcIHQ0e31KY5MESLujmw/WUmoMzJc/QfnvZCZrNbB19sE1LF0D3x5ZgkxuUVKI
	 3/J0Lbl6ZFyVrTKKUKglbqqLj425nfknzm9tSqPdoOgdft8xzocIqEm6IhVhdI+yHs
	 zGlNhnZ/DtLHdNrcDLLmf7Lzdh2LO0Qs+EOIZl1peGx12rUKOJgzxUyJM0jHYrkQiQ
	 e3QVsqfVPFKq9D1nkBXmfDWIWN7U60krauTESpmC1eChS0NrLBZ78omOx71/NNsHx0
	 cw1l/jhtt0j/7JlRoGjXYNlksmbsuLI5g/Q760SRzwLKbIN526XnaAaU1TMvrJ7g22
	 3w/Bi2aqziXEQ==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 18 Mar 2026 10:15:05 -0400
Subject: [PATCH v4 3/6] NFSD: Add filesystem scope to NFSD_CMD_UNLOCK
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-umount-kills-nfsv4-state-v4-3-56aad44ab982@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
In-Reply-To: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5225;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ucKQvrIVPjbwmn76mQgZFwansuJOWg7O1I4h+0zGVO0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpurN8fjmTPbAT893dAnB3u0OamD4mRcclgl87c
 oUtnIeUb8KJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabqzfAAKCRAzarMzb2Z/
 l/6QEACj4hTrAXSdusxPmWrrrhJB+ALvd40vf5bQySAGeXpNf+HBWy13cAjBYnQd1KgXzeIRnK6
 olB8ggjMxjxYn+j5lT740aeob7pPX0NFk2KIyuG/6knYcB0FcDBMaQUA+Sv5veNwlBXs9CLNFAt
 dszoqb75b2qony7y+kw7pSRwEjz+TvakV4qPBuufKddf9+DZm1zrVSSoJytht+YYm5jK2MNlHsz
 xZfU/uzyRsKzFk0HKgu6ZJvYFF47wkssXflBUr1lWoK+fN5YQw6HbbaAYgkXIoEOOp3ja4DRpjt
 89Xa/ZllsrroXI4E7R5e1wBXeNqDkYba+LJ7lAbhIV9N6+zfA5lCwRU8k6nXfuG6ZhPM3ll9yC1
 2Yd8ntIl232U0EFIQLNsMFdWWQLi+PliwLApBGgAggPk1zd2hS3n+s5SX/me8Ua4rd78wU1+p2I
 xbdr5JhiCJrk3qv8dv4WvF98iz2gbpZ9uSTB59QsZc3MjXADfI0GgNA4tMY8HWvFUWdXlozC6Hz
 xtwlBg1TGwSHoJxG8a+LQHpK/JwHJ+iTc30tZUVcJxLRKCF4tJ1E1l3eJmnrAPa7zuky8PBPev7
 5ViVPZJqy1fCvcU/LxA79lRfwbjngWjMmx3WtIaSE7XLKf12fIUtmVUcucHVBf0gf9u2GDYKpmP
 FhsrXsyh+PtjjkQ==
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
	TAGGED_FROM(0.00)[bounces-20247-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 146D92BD0E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Add NFSD_UNLOCK_TYPE_FILESYSTEM to the NFSD_CMD_UNLOCK netlink
command, providing a netlink equivalent of /proc/fs/nfsd/unlock_fs.

The filesystem scope requires a "path" string attribute containing
the filesystem path whose state should be released. The handler
resolves the path to its superblock, then cancels async copies,
releases NLM locks, and revokes NFSv4 state on that superblock --
the same operations performed by write_unlock_fs().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml | 11 ++++++++--
 fs/nfsd/netlink.c                     |  7 +++---
 fs/nfsd/nfsctl.c                      | 41 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/nfsd_netlink.h     |  2 ++
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 02fadfca22ba..1083ef60cac3 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -11,7 +11,7 @@ definitions:
     type: enum
     name: unlock-type
     render-max: true
-    entries: [ip]
+    entries: [ip, filesystem]
 
 attribute-sets:
   -
@@ -149,6 +149,12 @@ attribute-sets:
           Required when type is ip.
         checks:
           min-len: 16
+      -
+        name: path
+        type: string
+        doc: >-
+          Filesystem path whose state should be released.
+          Required when type is filesystem.
 
 operations:
   list:
@@ -251,7 +257,7 @@ operations:
             - npools
     -
       name: unlock
-      doc: release NLM locks by scope
+      doc: release locks or revoke NFS state by scope
       attribute-set: unlock
       flags: [admin-perm]
       do:
@@ -259,3 +265,4 @@ operations:
           attributes:
             - type
             - address
+            - path
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 9ec0d56eaa21..8367d4e3fe4f 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -48,9 +48,10 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
 };
 
 /* NFSD_CMD_UNLOCK - do */
-static const struct nla_policy nfsd_unlock_nl_policy[NFSD_A_UNLOCK_ADDRESS + 1] = {
-	[NFSD_A_UNLOCK_TYPE] = NLA_POLICY_MAX(NLA_U32, 0),
+static const struct nla_policy nfsd_unlock_nl_policy[NFSD_A_UNLOCK_PATH + 1] = {
+	[NFSD_A_UNLOCK_TYPE] = NLA_POLICY_MAX(NLA_U32, NFSD_UNLOCK_TYPE_MAX),
 	[NFSD_A_UNLOCK_ADDRESS] = NLA_POLICY_MIN_LEN(16),
+	[NFSD_A_UNLOCK_PATH] = { .type = NLA_NUL_STRING, .len = PATH_MAX - 1, },
 };
 
 /* Ops table for nfsd */
@@ -112,7 +113,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.cmd		= NFSD_CMD_UNLOCK,
 		.doit		= nfsd_nl_unlock_doit,
 		.policy		= nfsd_unlock_nl_policy,
-		.maxattr	= NFSD_A_UNLOCK_ADDRESS,
+		.maxattr	= NFSD_A_UNLOCK_PATH,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 858f3803c490..d3ed343699bd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2180,7 +2180,44 @@ static int nfsd_nl_unlock_by_ip(struct genl_info *info)
 }
 
 /**
- * nfsd_nl_unlock_doit - release NLM locks by scope
+ * nfsd_nl_unlock_by_filesystem - release locks and state on a filesystem
+ * @info: netlink metadata and command arguments
+ *
+ * Return: 0 on success or a negative errno.
+ */
+static int nfsd_nl_unlock_by_filesystem(struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct path path;
+	int error;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_PATH))
+		return -EINVAL;
+
+	trace_nfsd_ctl_unlock_fs(net,
+				 nla_data(info->attrs[NFSD_A_UNLOCK_PATH]));
+	error = kern_path(nla_data(info->attrs[NFSD_A_UNLOCK_PATH]),
+			  0, &path);
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
+/**
+ * nfsd_nl_unlock_doit - release locks or revoke NFS state
  * @skb: reply buffer
  * @info: netlink metadata and command arguments
  *
@@ -2198,6 +2235,8 @@ int nfsd_nl_unlock_doit(struct sk_buff *skb, struct genl_info *info)
 	switch (type) {
 	case NFSD_UNLOCK_TYPE_IP:
 		return nfsd_nl_unlock_by_ip(info);
+	case NFSD_UNLOCK_TYPE_FILESYSTEM:
+		return nfsd_nl_unlock_by_filesystem(info);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 8edd75590f31..340ad36080fe 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -12,6 +12,7 @@
 
 enum nfsd_unlock_type {
 	NFSD_UNLOCK_TYPE_IP,
+	NFSD_UNLOCK_TYPE_FILESYSTEM,
 
 	/* private: */
 	__NFSD_UNLOCK_TYPE_MAX,
@@ -91,6 +92,7 @@ enum {
 enum {
 	NFSD_A_UNLOCK_TYPE = 1,
 	NFSD_A_UNLOCK_ADDRESS,
+	NFSD_A_UNLOCK_PATH,
 
 	__NFSD_A_UNLOCK_MAX,
 	NFSD_A_UNLOCK_MAX = (__NFSD_A_UNLOCK_MAX - 1)

-- 
2.53.0


