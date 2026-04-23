Return-Path: <linux-nfs+bounces-21060-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAOQHEVi6mmrygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21060-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:17:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC084455FEB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEA51307E481
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470593AC0CE;
	Thu, 23 Apr 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9K1PrOe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491F3A7848
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968110; cv=none; b=MXl27j7PdKKiQT/3fqrtRtiZGBVqTJjmhLIlrWLpC+2dlZsDjGw/FBS8PnIh3OzHSNFKYW0LsWo5Hftm+cn6uQSfJeEyZtqdthJ1qjUc7Gmfr3jNaW6aY0gkFcVwPw5aS0QgqTZNv5gLJY++vqO/JkG6eX0WwfqknqnHH9nDLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968110; c=relaxed/simple;
	bh=qJ7GCB0Hkoi2ICpEuVIHM18Qe3fD3Kf5X68Lc+ZOUtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKiwm9dz0gipA+xESzC2u3z1Kn5tDpI4fuisEVr/7whSN8bzh/GzQpIzAXd+ouG7PloFqYw8cYqOAyajit62mbB2JOexmv3lK2hiGEYwSmNgNy7oLQEBRW2LOIk0jxSqTq1LKbwquea99VoIJVJ5/9d2Ns/Nuy3YZeCZdLM1Z40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9K1PrOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B491C2BCB2;
	Thu, 23 Apr 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968109;
	bh=qJ7GCB0Hkoi2ICpEuVIHM18Qe3fD3Kf5X68Lc+ZOUtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9K1PrOeKiFrTR++dtZc8sdwCMmKQYOGWuydwEOmDknRM5I32WtCxCyP2Exfwcdng
	 zpfw70tBcOT8habpDJQ2XCMuuvYcMbB5mRWDU6oLUY7lKRZExgy9IwgaGCg0F3uvug
	 ff5JQI4EPQO+odJF0NU8AOHpj+sPTHMb3tez+1XT71RiJpmQGNiazq9YPN58ZS7TZE
	 jlWcbUo4nKXmCQGT3irA2u5i3FD5mJ7Ad/5UzsMP1K77CUqEf0ltUHzQ28G4ILnDeV
	 J300uLiyuw+JgRgJAfmTPigiK1iqDA/wGf+kta1JH29RwlUP376FtPdiN6hLaA1ph1
	 jgPZxy4mb/6sA==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH] NFSD: Put cache get-reqs dump attrs under reply
Date: Thu, 23 Apr 2026 14:15:02 -0400
Message-ID: <20260423181505.742554-3-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423181505.742554-1-cel@kernel.org>
References: <20260423181505.742554-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,leemhuis.info];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21060-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,leemhuis.info:email]
X-Rspamd-Queue-Id: EC084455FEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The new get-reqs dump operations added to sunrpc_cache.yaml and
nfsd.yaml place the "requests" nested attribute under dump.request.
A netlink dump carries an empty request; its payload travels back
in the reply. Because the spec names no reply attributes, the YNL
C code generator synthesizes a forward reference to a
<op>_rsp struct that is never defined, breaking any consumer of
these specs.

This first surfaced when Thorsten Leemhuis built tools/net/ynl
against -next:

  nfsd-user.h:746: error: field 'obj' has incomplete type
    struct nfsd_svc_export_get_reqs_rsp obj ...
  nfsd-user.h:826: error: field 'obj' has incomplete type
    struct nfsd_expkey_get_reqs_rsp obj ...
  nfsd-user.c:1211: error: 'nfsd_svc_export_get_reqs_rsp_parse'
    undeclared

sunrpc_cache.yaml has the same defect in ip-map-get-reqs and
unix-gid-get-reqs, but nfsd.yaml errors out first in the Makefile's
alphabetical build order and hides the sunrpc failures.

These bugs were introduced by incorrect merge conflict resolution.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/linux-nfs/f6a3ca6d-e5cb-4a5c-9af2-8d2b1ce33ef0@leemhuis.info/
Fixes: 1045ccf519ce30 ("sunrpc: add netlink upcall for the auth.unix.ip cache")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml         |  4 +--
 Documentation/netlink/specs/sunrpc_cache.yaml |  4 +--
 fs/nfsd/netlink.c                             | 26 +++++--------------
 net/sunrpc/netlink.c                          | 26 +++++--------------
 4 files changed, 16 insertions(+), 44 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 17e714ef683d..8f36fadd68f7 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -445,7 +445,7 @@ operations:
       attribute-set: svc-export-reqs
       flags: [admin-perm]
       dump:
-          request:
+          reply:
             attributes:
               - requests
     -
@@ -463,7 +463,7 @@ operations:
       attribute-set: expkey-reqs
       flags: [admin-perm]
       dump:
-          request:
+          reply:
             attributes:
               - requests
     -
diff --git a/Documentation/netlink/specs/sunrpc_cache.yaml b/Documentation/netlink/specs/sunrpc_cache.yaml
index 55dabc914dbc..f22ff22b9418 100644
--- a/Documentation/netlink/specs/sunrpc_cache.yaml
+++ b/Documentation/netlink/specs/sunrpc_cache.yaml
@@ -101,7 +101,7 @@ operations:
       attribute-set: ip-map-reqs
       flags: [admin-perm]
       dump:
-          request:
+          reply:
             attributes:
               - requests
     -
@@ -119,7 +119,7 @@ operations:
       attribute-set: unix-gid-reqs
       flags: [admin-perm]
       dump:
-          request:
+          reply:
             attributes:
               - requests
     -
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index df5b0e2fb286..fbee3676d253 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -88,21 +88,11 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
 	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
 };
 
-/* NFSD_CMD_SVC_EXPORT_GET_REQS - dump */
-static const struct nla_policy nfsd_svc_export_get_reqs_nl_policy[NFSD_A_SVC_EXPORT_REQS_REQUESTS + 1] = {
-	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
-};
-
 /* NFSD_CMD_SVC_EXPORT_SET_REQS - do */
 static const struct nla_policy nfsd_svc_export_set_reqs_nl_policy[NFSD_A_SVC_EXPORT_REQS_REQUESTS + 1] = {
 	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
 };
 
-/* NFSD_CMD_EXPKEY_GET_REQS - dump */
-static const struct nla_policy nfsd_expkey_get_reqs_nl_policy[NFSD_A_EXPKEY_REQS_REQUESTS + 1] = {
-	[NFSD_A_EXPKEY_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_expkey_nl_policy),
-};
-
 /* NFSD_CMD_EXPKEY_SET_REQS - do */
 static const struct nla_policy nfsd_expkey_set_reqs_nl_policy[NFSD_A_EXPKEY_REQS_REQUESTS + 1] = {
 	[NFSD_A_EXPKEY_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_expkey_nl_policy),
@@ -184,11 +174,9 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.flags	= GENL_CMD_CAP_DO,
 	},
 	{
-		.cmd		= NFSD_CMD_SVC_EXPORT_GET_REQS,
-		.dumpit		= nfsd_nl_svc_export_get_reqs_dumpit,
-		.policy		= nfsd_svc_export_get_reqs_nl_policy,
-		.maxattr	= NFSD_A_SVC_EXPORT_REQS_REQUESTS,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+		.cmd	= NFSD_CMD_SVC_EXPORT_GET_REQS,
+		.dumpit	= nfsd_nl_svc_export_get_reqs_dumpit,
+		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
 		.cmd		= NFSD_CMD_SVC_EXPORT_SET_REQS,
@@ -198,11 +186,9 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-		.cmd		= NFSD_CMD_EXPKEY_GET_REQS,
-		.dumpit		= nfsd_nl_expkey_get_reqs_dumpit,
-		.policy		= nfsd_expkey_get_reqs_nl_policy,
-		.maxattr	= NFSD_A_EXPKEY_REQS_REQUESTS,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+		.cmd	= NFSD_CMD_EXPKEY_GET_REQS,
+		.dumpit	= nfsd_nl_expkey_get_reqs_dumpit,
+		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
 		.cmd		= NFSD_CMD_EXPKEY_SET_REQS,
diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
index 5ccf0967809c..ce09ecc0faa2 100644
--- a/net/sunrpc/netlink.c
+++ b/net/sunrpc/netlink.c
@@ -29,21 +29,11 @@ const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIRY + 1]
 	[SUNRPC_A_UNIX_GID_EXPIRY] = { .type = NLA_U64, },
 };
 
-/* SUNRPC_CMD_IP_MAP_GET_REQS - dump */
-static const struct nla_policy sunrpc_ip_map_get_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
-	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
-};
-
 /* SUNRPC_CMD_IP_MAP_SET_REQS - do */
 static const struct nla_policy sunrpc_ip_map_set_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
 	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
 };
 
-/* SUNRPC_CMD_UNIX_GID_GET_REQS - dump */
-static const struct nla_policy sunrpc_unix_gid_get_reqs_nl_policy[SUNRPC_A_UNIX_GID_REQS_REQUESTS + 1] = {
-	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
-};
-
 /* SUNRPC_CMD_UNIX_GID_SET_REQS - do */
 static const struct nla_policy sunrpc_unix_gid_set_reqs_nl_policy[SUNRPC_A_UNIX_GID_REQS_REQUESTS + 1] = {
 	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
@@ -57,11 +47,9 @@ static const struct nla_policy sunrpc_cache_flush_nl_policy[SUNRPC_A_CACHE_FLUSH
 /* Ops table for sunrpc */
 static const struct genl_split_ops sunrpc_nl_ops[] = {
 	{
-		.cmd		= SUNRPC_CMD_IP_MAP_GET_REQS,
-		.dumpit		= sunrpc_nl_ip_map_get_reqs_dumpit,
-		.policy		= sunrpc_ip_map_get_reqs_nl_policy,
-		.maxattr	= SUNRPC_A_IP_MAP_REQS_REQUESTS,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+		.cmd	= SUNRPC_CMD_IP_MAP_GET_REQS,
+		.dumpit	= sunrpc_nl_ip_map_get_reqs_dumpit,
+		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
 		.cmd		= SUNRPC_CMD_IP_MAP_SET_REQS,
@@ -71,11 +59,9 @@ static const struct genl_split_ops sunrpc_nl_ops[] = {
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-		.cmd		= SUNRPC_CMD_UNIX_GID_GET_REQS,
-		.dumpit		= sunrpc_nl_unix_gid_get_reqs_dumpit,
-		.policy		= sunrpc_unix_gid_get_reqs_nl_policy,
-		.maxattr	= SUNRPC_A_UNIX_GID_REQS_REQUESTS,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
+		.cmd	= SUNRPC_CMD_UNIX_GID_GET_REQS,
+		.dumpit	= sunrpc_nl_unix_gid_get_reqs_dumpit,
+		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
 		.cmd		= SUNRPC_CMD_UNIX_GID_SET_REQS,
-- 
2.53.0


