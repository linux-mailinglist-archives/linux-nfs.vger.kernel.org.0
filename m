Return-Path: <linux-nfs+bounces-20194-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHQBH/sfuGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20194-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:21:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4129C30E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0688E30CC187
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C913A3E9B;
	Mon, 16 Mar 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJL5qiHH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26EA3A3E86;
	Mon, 16 Mar 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674123; cv=none; b=h3MVe92QIDVzOMs2n9qaadD7T8xHGV89aewmB6iouxUw0ZLm2ad0cB5O/7IHChr6kkc+tw7rruZ5nqKrEZRu0BBuwQPgRiXVzanqxsctK2ggun2LbXSQieO5jzZSQTQ5P3R4JaLSwHhOcW5KQhMp2+TOblSQtXJw6qQM42bkjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674123; c=relaxed/simple;
	bh=/3CFP+ANQV2MMgTPxJuapu5JNhEBNvW8koV5ZXFWusU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMQkFlt02AXOBcuwpPaK4jqSndCBuRmxkYwSurxP7d84lLgTFDgJSRYir/AUNmwUCzPPoS4dLQPC8ynhDk3vdnMAp2FEiJUXfiCGBhaZyPJ8F1i2j/u/j4c2hFKc30JlCYpnoEX+VRGnZ7Gjk9T76UXXEnuILBN2wQSAAlEDbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJL5qiHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A2AC19421;
	Mon, 16 Mar 2026 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674122;
	bh=/3CFP+ANQV2MMgTPxJuapu5JNhEBNvW8koV5ZXFWusU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WJL5qiHHsctrAJG6yV76gE8Glu04SGTUgQkf846Yttpwwko32TyD+V0ZW3L08D1qY
	 6163DOuJLlRLDSEriwqQEGYGYxFtyhBWDsnjmQ7HObstLOyZNS6+OCaOd4+QQbDKJh
	 fZRkLVqkY/1qOP45kVYniF6Xjrh//flU+nkFBgNIys9DzSBNF/EZdwMT4GSO6QBPj8
	 US7qCvpycA9qa6OcvQND6LFNVgcBSorv0KEaediQ05GNs5dkSFcQZKfs6en44n35Wd
	 7v69yRsJeHW/cuFqqW8BXrD4rEUMs2YcOV8ljv5EoPhGllxSn0x9jWH/KK0kOz6dcw
	 3aa+wawprLtdA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:44 -0400
Subject: [PATCH 10/14] nfsd: add new netlink spec for svc_export upcall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-10-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17436; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/3CFP+ANQV2MMgTPxJuapu5JNhEBNvW8koV5ZXFWusU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB59eV9QJ2ZkKuXcDm7hVMneWUgj1azqGTDDl
 J/n2+id+t2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefQAKCRAADmhBGVaC
 FTpxD/0buJlqY7PjV/UQ88Pvagcw4Iy/bkbKI+4alYNJ3i81+m8LJ9+4KUT9JV+uPJyHwd876Vt
 y35bpvMQ+cF/B59U5vs0H5FKA8aSPvj7HGV/KRSEZGqn93/anxj3acHR/rxBcyWjNNzKwjVSkf1
 9cbhkc7uAB/TPjB0Akt6q0pP9zel4eVcNi8safNLoRN3HRBAzIh62Pwn6y62J4CAceqpS4/blht
 SehtG1nV2CdTLKeBxYhXs8NY63sfd5hH4UqvBQPCYfhq4bGW+cS/9WG1aHNbYQO4Esz9++IjTtH
 XniVCMQRPMCGoqq4p7mbjZSFbr5Nc1aymD00FDmGPZEYfHTBGzhBCIeeFZIJYAfoMr/gdLgan3R
 wRVhZyD58/6UVcODovmoTmZg56tUY2KnTgOS4ayNnfPvfz3aZ1wpJe/pr1SO7acKkrZ0QVvjmk0
 1K8pyl9/G21rh4SpuPHhWE9UFZ6am6/MFyXiYRdqj1rm8ZCfdaQC8No7TegMcD8GQIqWWG1bSxJ
 Cfg6vv1SDdX5rhChgSr7CTL+idZF5JUolIR3fXAUVBlAODCW8gckTeMheo2lHYPUe2PIGAmCE63
 m8gMl5TGZZcK4GqmyScLgdQaLM22x9Fa90fnWA2XsRZQwUKH/m1p7E10z01WYwPEzjDhEhjHivh
 I8sR76/BlWTpfNw==
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
	TAGGED_FROM(0.00)[bounces-20194-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 1CA4129C30E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

...and generate the headers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 172 ++++++++++++++++++++++++++++++++++
 fs/nfsd/netlink.c                     |  61 ++++++++++++
 fs/nfsd/netlink.h                     |  13 +++
 include/uapi/linux/nfsd_netlink.h     | 102 ++++++++++++++++++++
 net/sunrpc/netlink.c                  |  49 ++--------
 net/sunrpc/netlink.h                  |   6 +-
 6 files changed, 357 insertions(+), 46 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 8ab43c8253b2e83bcc178c3f4fe8c41c2997d153..08322bc3dee7458e6a202372dd332067d03e1be6 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -6,7 +6,49 @@ uapi-header: linux/nfsd_netlink.h
 
 doc: NFSD configuration over generic netlink.
 
+definitions:
+  -
+    type: flags
+    name: cache-type
+    entries: [svc_export]
+  -
+    type: flags
+    name: export-flags
+    entries:
+      - readonly
+      - insecure-port
+      - rootsquash
+      - allsquash
+      - async
+      - gathered-writes
+      - noreaddirplus
+      - security-label
+      - sign-fh
+      - nohide
+      - nosubtreecheck
+      - noauthnlm
+      - msnfs
+      - fsid
+      - crossmount
+      - noacl
+      - v4root
+      - pnfs
+  -
+    type: flags
+    name: xprtsec-mode
+    entries:
+      - none
+      - tls
+      - mtls
+
 attribute-sets:
+  -
+    name: cache-notify
+    attributes:
+      -
+        name: cache-type
+        type: u32
+        enum: cache-type
   -
     name: rpc-status
     attributes:
@@ -132,6 +174,103 @@ attribute-sets:
       -
         name: npools
         type: u32
+  -
+    name: fslocation
+    attributes:
+      -
+        name: host
+        type: string
+      -
+        name: path
+        type: string
+  -
+    name: fslocations
+    attributes:
+      -
+        name: location
+        type: nest
+        nested-attributes: fslocation
+        multi-attr: true
+  -
+    name: auth-flavor
+    attributes:
+      -
+        name: pseudoflavor
+        type: u32
+      -
+        name: flags
+        type: u32
+        enum: export-flags
+        enum-as-flags: true
+  -
+    name: svc-export-req
+    attributes:
+      -
+        name: seqno
+        type: u64
+      -
+        name: client
+        type: string
+      -
+        name: path
+        type: string
+  -
+    name: svc-export
+    attributes:
+      -
+        name: seqno
+        type: u64
+      -
+        name: client
+        type: string
+      -
+        name: path
+        type: string
+      -
+        name: negative
+        type: flag
+      -
+        name: expiry
+        type: u64
+      -
+        name: anon-uid
+        type: u32
+      -
+        name: anon-gid
+        type: u32
+      -
+        name: fslocations
+        type: nest
+        nested-attributes: fslocations
+      -
+        name: uuid
+        type: binary
+      -
+        name: secinfo
+        type: nest
+        nested-attributes: auth-flavor
+        multi-attr: true
+      -
+        name: xprtsec
+        type: u32
+        enum: xprtsec-mode
+        multi-attr: true
+      -
+        name: flags
+        type: u32
+        enum: export-flags
+        enum-as-flags: true
+      -
+        name: fsid
+        type: s32
+  -
+    name: svc-export-reqs
+    attributes:
+      -
+        name: requests
+        type: nest
+        nested-attributes: svc-export
+        multi-attr: true
 
 operations:
   list:
@@ -233,3 +372,36 @@ operations:
           attributes:
             - mode
             - npools
+    -
+      name: cache-notify
+      doc: Notification that there are cache requests that need servicing
+      attribute-set: cache-notify
+      mcgrp: exportd
+      event:
+        attributes:
+          - cache-type
+    -
+      name: svc-export-get-reqs
+      doc: Dump all pending svc_export requests
+      attribute-set: svc-export-reqs
+      flags: [admin-perm]
+      dump:
+          request:
+            attributes:
+              - requests
+    -
+      name: svc-export-set-reqs
+      doc: Respond to one or more svc_export requests
+      attribute-set: svc-export-reqs
+      flags: [admin-perm]
+      do:
+          request:
+            attributes:
+              - requests
+
+mcast-groups:
+  list:
+    -
+      name: none
+    -
+      name: exportd
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 81c943345d13db849483bf0d6773458115ff0134..fb401d7302afb9e41cb074581f7b94e8ece6cf0c 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -12,11 +12,41 @@
 #include <uapi/linux/nfsd_netlink.h>
 
 /* Common nested types */
+const struct nla_policy nfsd_auth_flavor_nl_policy[NFSD_A_AUTH_FLAVOR_FLAGS + 1] = {
+	[NFSD_A_AUTH_FLAVOR_PSEUDOFLAVOR] = { .type = NLA_U32, },
+	[NFSD_A_AUTH_FLAVOR_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x3ffff),
+};
+
+const struct nla_policy nfsd_fslocation_nl_policy[NFSD_A_FSLOCATION_PATH + 1] = {
+	[NFSD_A_FSLOCATION_HOST] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_FSLOCATION_PATH] = { .type = NLA_NUL_STRING, },
+};
+
+const struct nla_policy nfsd_fslocations_nl_policy[NFSD_A_FSLOCATIONS_LOCATION + 1] = {
+	[NFSD_A_FSLOCATIONS_LOCATION] = NLA_POLICY_NESTED(nfsd_fslocation_nl_policy),
+};
+
 const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1] = {
 	[NFSD_A_SOCK_ADDR] = { .type = NLA_BINARY, },
 	[NFSD_A_SOCK_TRANSPORT_NAME] = { .type = NLA_NUL_STRING, },
 };
 
+const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_FSID + 1] = {
+	[NFSD_A_SVC_EXPORT_SEQNO] = { .type = NLA_U64, },
+	[NFSD_A_SVC_EXPORT_CLIENT] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_SVC_EXPORT_PATH] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_SVC_EXPORT_NEGATIVE] = { .type = NLA_FLAG, },
+	[NFSD_A_SVC_EXPORT_EXPIRY] = { .type = NLA_U64, },
+	[NFSD_A_SVC_EXPORT_ANON_UID] = { .type = NLA_U32, },
+	[NFSD_A_SVC_EXPORT_ANON_GID] = { .type = NLA_U32, },
+	[NFSD_A_SVC_EXPORT_FSLOCATIONS] = NLA_POLICY_NESTED(nfsd_fslocations_nl_policy),
+	[NFSD_A_SVC_EXPORT_UUID] = { .type = NLA_BINARY, },
+	[NFSD_A_SVC_EXPORT_SECINFO] = NLA_POLICY_NESTED(nfsd_auth_flavor_nl_policy),
+	[NFSD_A_SVC_EXPORT_XPRTSEC] = NLA_POLICY_MASK(NLA_U32, 0x7),
+	[NFSD_A_SVC_EXPORT_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x3ffff),
+	[NFSD_A_SVC_EXPORT_FSID] = { .type = NLA_S32, },
+};
+
 const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 	[NFSD_A_VERSION_MAJOR] = { .type = NLA_U32, },
 	[NFSD_A_VERSION_MINOR] = { .type = NLA_U32, },
@@ -48,6 +78,16 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
 	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
 };
 
+/* NFSD_CMD_SVC_EXPORT_GET_REQS - dump */
+static const struct nla_policy nfsd_svc_export_get_reqs_nl_policy[NFSD_A_SVC_EXPORT_REQS_REQUESTS + 1] = {
+	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
+};
+
+/* NFSD_CMD_SVC_EXPORT_SET_REQS - do */
+static const struct nla_policy nfsd_svc_export_set_reqs_nl_policy[NFSD_A_SVC_EXPORT_REQS_REQUESTS + 1] = {
+	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -103,6 +143,25 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_pool_mode_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_SVC_EXPORT_GET_REQS,
+		.dumpit		= nfsd_nl_svc_export_get_reqs_dumpit,
+		.policy		= nfsd_svc_export_get_reqs_nl_policy,
+		.maxattr	= NFSD_A_SVC_EXPORT_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= NFSD_CMD_SVC_EXPORT_SET_REQS,
+		.doit		= nfsd_nl_svc_export_set_reqs_doit,
+		.policy		= nfsd_svc_export_set_reqs_nl_policy,
+		.maxattr	= NFSD_A_SVC_EXPORT_REQS_REQUESTS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group nfsd_nl_mcgrps[] = {
+	[NFSD_NLGRP_NONE] = { "none", },
+	[NFSD_NLGRP_EXPORTD] = { "exportd", },
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
@@ -113,4 +172,6 @@ struct genl_family nfsd_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= nfsd_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(nfsd_nl_ops),
+	.mcgrps		= nfsd_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(nfsd_nl_mcgrps),
 };
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 478117ff6b8c0d6e83d6ece09a938935e031c62b..d6ed8d9b0bb149faa4d6493ba94972addf9c26ed 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -13,7 +13,11 @@
 #include <uapi/linux/nfsd_netlink.h>
 
 /* Common nested types */
+extern const struct nla_policy nfsd_auth_flavor_nl_policy[NFSD_A_AUTH_FLAVOR_FLAGS + 1];
+extern const struct nla_policy nfsd_fslocation_nl_policy[NFSD_A_FSLOCATION_PATH + 1];
+extern const struct nla_policy nfsd_fslocations_nl_policy[NFSD_A_FSLOCATIONS_LOCATION + 1];
 extern const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1];
+extern const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_FSID + 1];
 extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1];
 
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
@@ -26,6 +30,15 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_svc_export_get_reqs_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb);
+int nfsd_nl_svc_export_set_reqs_doit(struct sk_buff *skb,
+				     struct genl_info *info);
+
+enum {
+	NFSD_NLGRP_NONE,
+	NFSD_NLGRP_EXPORTD,
+};
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 97c7447f4d14df97c1cba8cdf1f24fba0a7918b3..1ba1c2c167fd06cd0c845d947f5a03702356d991 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -10,6 +10,44 @@
 #define NFSD_FAMILY_NAME	"nfsd"
 #define NFSD_FAMILY_VERSION	1
 
+enum nfsd_cache_type {
+	NFSD_CACHE_TYPE_SVC_EXPORT = 1,
+};
+
+enum nfsd_export_flags {
+	NFSD_EXPORT_FLAGS_READONLY = 1,
+	NFSD_EXPORT_FLAGS_INSECURE_PORT = 2,
+	NFSD_EXPORT_FLAGS_ROOTSQUASH = 4,
+	NFSD_EXPORT_FLAGS_ALLSQUASH = 8,
+	NFSD_EXPORT_FLAGS_ASYNC = 16,
+	NFSD_EXPORT_FLAGS_GATHERED_WRITES = 32,
+	NFSD_EXPORT_FLAGS_NOREADDIRPLUS = 64,
+	NFSD_EXPORT_FLAGS_SECURITY_LABEL = 128,
+	NFSD_EXPORT_FLAGS_SIGN_FH = 256,
+	NFSD_EXPORT_FLAGS_NOHIDE = 512,
+	NFSD_EXPORT_FLAGS_NOSUBTREECHECK = 1024,
+	NFSD_EXPORT_FLAGS_NOAUTHNLM = 2048,
+	NFSD_EXPORT_FLAGS_MSNFS = 4096,
+	NFSD_EXPORT_FLAGS_FSID = 8192,
+	NFSD_EXPORT_FLAGS_CROSSMOUNT = 16384,
+	NFSD_EXPORT_FLAGS_NOACL = 32768,
+	NFSD_EXPORT_FLAGS_V4ROOT = 65536,
+	NFSD_EXPORT_FLAGS_PNFS = 131072,
+};
+
+enum nfsd_xprtsec_mode {
+	NFSD_XPRTSEC_MODE_NONE = 1,
+	NFSD_XPRTSEC_MODE_TLS = 2,
+	NFSD_XPRTSEC_MODE_MTLS = 4,
+};
+
+enum {
+	NFSD_A_CACHE_NOTIFY_CACHE_TYPE = 1,
+
+	__NFSD_A_CACHE_NOTIFY_MAX,
+	NFSD_A_CACHE_NOTIFY_MAX = (__NFSD_A_CACHE_NOTIFY_MAX - 1)
+};
+
 enum {
 	NFSD_A_RPC_STATUS_XID = 1,
 	NFSD_A_RPC_STATUS_FLAGS,
@@ -81,6 +119,64 @@ enum {
 	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
 };
 
+enum {
+	NFSD_A_FSLOCATION_HOST = 1,
+	NFSD_A_FSLOCATION_PATH,
+
+	__NFSD_A_FSLOCATION_MAX,
+	NFSD_A_FSLOCATION_MAX = (__NFSD_A_FSLOCATION_MAX - 1)
+};
+
+enum {
+	NFSD_A_FSLOCATIONS_LOCATION = 1,
+
+	__NFSD_A_FSLOCATIONS_MAX,
+	NFSD_A_FSLOCATIONS_MAX = (__NFSD_A_FSLOCATIONS_MAX - 1)
+};
+
+enum {
+	NFSD_A_AUTH_FLAVOR_PSEUDOFLAVOR = 1,
+	NFSD_A_AUTH_FLAVOR_FLAGS,
+
+	__NFSD_A_AUTH_FLAVOR_MAX,
+	NFSD_A_AUTH_FLAVOR_MAX = (__NFSD_A_AUTH_FLAVOR_MAX - 1)
+};
+
+enum {
+	NFSD_A_SVC_EXPORT_REQ_SEQNO = 1,
+	NFSD_A_SVC_EXPORT_REQ_CLIENT,
+	NFSD_A_SVC_EXPORT_REQ_PATH,
+
+	__NFSD_A_SVC_EXPORT_REQ_MAX,
+	NFSD_A_SVC_EXPORT_REQ_MAX = (__NFSD_A_SVC_EXPORT_REQ_MAX - 1)
+};
+
+enum {
+	NFSD_A_SVC_EXPORT_SEQNO = 1,
+	NFSD_A_SVC_EXPORT_CLIENT,
+	NFSD_A_SVC_EXPORT_PATH,
+	NFSD_A_SVC_EXPORT_NEGATIVE,
+	NFSD_A_SVC_EXPORT_EXPIRY,
+	NFSD_A_SVC_EXPORT_ANON_UID,
+	NFSD_A_SVC_EXPORT_ANON_GID,
+	NFSD_A_SVC_EXPORT_FSLOCATIONS,
+	NFSD_A_SVC_EXPORT_UUID,
+	NFSD_A_SVC_EXPORT_SECINFO,
+	NFSD_A_SVC_EXPORT_XPRTSEC,
+	NFSD_A_SVC_EXPORT_FLAGS,
+	NFSD_A_SVC_EXPORT_FSID,
+
+	__NFSD_A_SVC_EXPORT_MAX,
+	NFSD_A_SVC_EXPORT_MAX = (__NFSD_A_SVC_EXPORT_MAX - 1)
+};
+
+enum {
+	NFSD_A_SVC_EXPORT_REQS_REQUESTS = 1,
+
+	__NFSD_A_SVC_EXPORT_REQS_MAX,
+	NFSD_A_SVC_EXPORT_REQS_MAX = (__NFSD_A_SVC_EXPORT_REQS_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -91,9 +187,15 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_CACHE_NOTIFY,
+	NFSD_CMD_SVC_EXPORT_GET_REQS,
+	NFSD_CMD_SVC_EXPORT_SET_REQS,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
 };
 
+#define NFSD_MCGRP_NONE		"none"
+#define NFSD_MCGRP_EXPORTD	"exportd"
+
 #endif /* _UAPI_LINUX_NFSD_NETLINK_H */
diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
index 44a38aba820d9ad25bd50d0d8c7a827dfe37c2bd..3ac6b0cac5fece964f6e6591f90d074f40e96af1 100644
--- a/net/sunrpc/netlink.c
+++ b/net/sunrpc/netlink.c
@@ -6,7 +6,6 @@
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
-#include <linux/sunrpc/cache.h>
 
 #include "netlink.h"
 
@@ -22,6 +21,14 @@ const struct nla_policy sunrpc_ip_map_nl_policy[SUNRPC_A_IP_MAP_EXPIRY + 1] = {
 	[SUNRPC_A_IP_MAP_EXPIRY] = { .type = NLA_U64, },
 };
 
+const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIRY + 1] = {
+	[SUNRPC_A_UNIX_GID_SEQNO] = { .type = NLA_U64, },
+	[SUNRPC_A_UNIX_GID_UID] = { .type = NLA_U32, },
+	[SUNRPC_A_UNIX_GID_GIDS] = { .type = NLA_U32, },
+	[SUNRPC_A_UNIX_GID_NEGATIVE] = { .type = NLA_FLAG, },
+	[SUNRPC_A_UNIX_GID_EXPIRY] = { .type = NLA_U64, },
+};
+
 /* SUNRPC_CMD_IP_MAP_GET_REQS - dump */
 static const struct nla_policy sunrpc_ip_map_get_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
 	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
@@ -32,14 +39,6 @@ static const struct nla_policy sunrpc_ip_map_set_reqs_nl_policy[SUNRPC_A_IP_MAP_
 	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
 };
 
-const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIRY + 1] = {
-	[SUNRPC_A_UNIX_GID_SEQNO] = { .type = NLA_U64, },
-	[SUNRPC_A_UNIX_GID_UID] = { .type = NLA_U32, },
-	[SUNRPC_A_UNIX_GID_GIDS] = { .type = NLA_U32, },
-	[SUNRPC_A_UNIX_GID_NEGATIVE] = { .type = NLA_FLAG, },
-	[SUNRPC_A_UNIX_GID_EXPIRY] = { .type = NLA_U64, },
-};
-
 /* SUNRPC_CMD_UNIX_GID_GET_REQS - dump */
 static const struct nla_policy sunrpc_unix_gid_get_reqs_nl_policy[SUNRPC_A_UNIX_GID_REQS_REQUESTS + 1] = {
 	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
@@ -98,35 +97,3 @@ struct genl_family sunrpc_nl_family __ro_after_init = {
 	.mcgrps		= sunrpc_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(sunrpc_nl_mcgrps),
 };
-
-int sunrpc_cache_notify(struct cache_detail *cd, struct cache_head *h,
-			u32 cache_type)
-{
-	struct genlmsghdr *hdr;
-	struct sk_buff *msg;
-
-	if (!genl_has_listeners(&sunrpc_nl_family, cd->net,
-				SUNRPC_NLGRP_EXPORTD))
-		return -ENOLINK;
-
-	msg = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	hdr = genlmsg_put(msg, 0, 0, &sunrpc_nl_family, 0,
-			  SUNRPC_CMD_CACHE_NOTIFY);
-	if (!hdr) {
-		nlmsg_free(msg);
-		return -ENOMEM;
-	}
-
-	if (nla_put_u32(msg, SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE, cache_type)) {
-		nlmsg_free(msg);
-		return -ENOMEM;
-	}
-
-	genlmsg_end(msg, hdr);
-	return genlmsg_multicast_netns(&sunrpc_nl_family, cd->net, msg, 0,
-				       SUNRPC_NLGRP_EXPORTD, GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(sunrpc_cache_notify);
diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
index f01477c13f98f6708f3f24391cde164edb21a860..2aec57d27a586e4c6b2fc65c7b4505b0996d9577 100644
--- a/net/sunrpc/netlink.h
+++ b/net/sunrpc/netlink.h
@@ -18,8 +18,7 @@ extern const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIR
 
 int sunrpc_nl_ip_map_get_reqs_dumpit(struct sk_buff *skb,
 				     struct netlink_callback *cb);
-int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb,
-				   struct genl_info *info);
+int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb, struct genl_info *info);
 int sunrpc_nl_unix_gid_get_reqs_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb);
 int sunrpc_nl_unix_gid_set_reqs_doit(struct sk_buff *skb,
@@ -32,7 +31,4 @@ enum {
 
 extern struct genl_family sunrpc_nl_family;
 
-int sunrpc_cache_notify(struct cache_detail *cd, struct cache_head *h,
-			u32 cache_type);
-
 #endif /* _LINUX_SUNRPC_GEN_H */

-- 
2.53.0


