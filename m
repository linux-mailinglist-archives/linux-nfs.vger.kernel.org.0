Return-Path: <linux-nfs+bounces-20203-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGT7Fn0guGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20203-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:23:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A0629C3C4
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B66123128B71
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B078D3A1D07;
	Mon, 16 Mar 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxBLNbj+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD953A63E4
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674217; cv=none; b=okWnwFvcmWOt7m0qFu+7lR5/XfA+zssvPNGrYui9Hol0gPTZFnJ4OqS+6r/8+gF+rdpU24QBbFY5AQ3dv46/VKa61a6ACwYXGOtfWLuf6cEeEsusURrWBb+WoI9NiJvhY/xN4bElaDCHFPu9hM9QkZzWy8MLcSa5ZqSF5OSxZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674217; c=relaxed/simple;
	bh=ZRbosLmJq/rv90DPAp8gpaXrKQdbXg+7Pr5h584gVfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVdCVpbQWtAqbLY2txT2C9J57DT7GMr6J2SJByQcQyR9McTGuaL4eY+NBv7DJgg6/agmU0XDRkyOXP/zUqTqoK1nEVy5iUbHD6oTJqX1wvslQbUA9X0ezJWfBiVx6O1tVsu+4ySWrheAnXp4ZE5l4AtjjxhBhXBihXRy//Iipo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxBLNbj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94903C19421;
	Mon, 16 Mar 2026 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674217;
	bh=ZRbosLmJq/rv90DPAp8gpaXrKQdbXg+7Pr5h584gVfc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QxBLNbj+fZ1X4bjMkdBnQIeu46fs1ZVpsdHwOXcHCaWdUyoRsdAxOWL/WIVWCjItr
	 KpJPcs/kBBo94Ob83USEmUOPlOfsbhsHIrWQ3TTJ1o6vOtNa6551xoylVbwQTZNQXg
	 N5O2c7iqW9ko+kRCpoR2U15hcfHcvJWxSpu3ahn8pPpTEW+vHeF7bPRDgSsqDdInrw
	 CQruHRr3QSeo2Fk3pwV80H+UPbrk2vQfKUmWDBuJJAQ/XD6zFK/w5WxeCBb4c4XYr3
	 L70I5PjVkXzIKK5Ags7Tl9dCrcE9keXGKvFxt9gymtCLs+w9bJvOHjtYHSYkBAD6cC
	 ApHziQVRM1AZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:42 -0400
Subject: [PATCH nfs-utils 04/17] support/include: update netlink headers
 for all cache upcalls
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-4-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7400; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZRbosLmJq/rv90DPAp8gpaXrKQdbXg+7Pr5h584gVfc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7gy1ETTFuid2dCX4bKGtcL8IJMjXbBFueTg
 2TyzhRSN/KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4AAKCRAADmhBGVaC
 FeH0D/9xWhZJeS7rEvbTMI6948ZtKsCiYMpmRggPPdNGI21YDs5J1bSHK1oc0I3Ocx3UQeIU/L8
 PzJJGVtCtyL3SEbVoR2y5GgfqAdMaNbB4v45jR5tbUuNXnkGmfkFPd5OcIyKS1dVpfXDSo+LgGw
 500bejrtsND14cxt5jxZ65Zcu9ZmTG25sdXxeD+cwG9KGIxAaYurMiS100f0hjx0/D5ffqk8F78
 dDc5qz1P64eNSHZx4h07HtGKPWGtj6jb/EytX9REIGrCQiNNvvgdW4JNiE2RUgY0FMTUqZZnG/9
 eKbjo88xi8UOfssEs9KZblQmiVJvGHJvj16f13EKjVC761uePMr+M6dqgOsmLjftqwNMtVhlct1
 APe/ubuahR0crZbD1YrM02b05f9SbLmTAiu8loXa5lkg0Pk1X1wwvZxNBrHG75rQloPA/yYBU23
 WK6MFZB9HPtN/RXgNtjnRy/ERT2NrbvKVuSNYf6gfEhHW+saCjzetKQeQ9ViN01ChUZUPU7b7R/
 Q189D9DOxqpNFbGZ3NjRlBJ3GRGHtHih9HLLtbMuXpB6nhZN3tl2gwzwnMRy366GuYsQe1+uuuU
 BEtt3hJ6LAWvILYrFOJerXcYkcYL5FIbRqiMAx720lML3HJIJ+8ZD/tBur7E+qjCa73QKbhR6Ks
 PskdifrFrQLyXug==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20203-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4A0629C3C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sync the bundled nfsd_netlink.h with the current kernel UAPI header.
This brings in:
 - NFSD_CACHE_TYPE_EXPKEY in the cache-type enum
 - NFSD_A_SVC_EXPORT_FLAGS and NFSD_A_SVC_EXPORT_FSID attributes
 - NFSD_A_EXPKEY_* and NFSD_A_EXPKEY_REQS_* attribute enums
 - NFSD_CMD_EXPKEY_GET_REQS and NFSD_CMD_EXPKEY_SET_REQS commands

Add a new bundled sunrpc_netlink.h header for the sunrpc genl family,
which handles auth.unix.ip and auth.unix.gid cache upcalls via netlink.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/include/Makefile.am      |   1 +
 support/include/nfsd_netlink.h   | 126 +++++++++++++++++++++++++++++++++++++++
 support/include/sunrpc_netlink.h |  77 ++++++++++++++++++++++++
 3 files changed, 204 insertions(+)

diff --git a/support/include/Makefile.am b/support/include/Makefile.am
index 2b45e56b044c35c0e7a11aec5f583d600fcae6a0..9737c476a6bbe9e7a2938213c3fc5042da2d3579 100644
--- a/support/include/Makefile.am
+++ b/support/include/Makefile.am
@@ -15,6 +15,7 @@ noinst_HEADERS = \
 	nfs_ucred.h \
 	nfsd_netlink.h \
 	nfsd_path.h \
+	sunrpc_netlink.h \
 	nfslib.h \
 	nfsrpc.h \
 	nls.h \
diff --git a/support/include/nfsd_netlink.h b/support/include/nfsd_netlink.h
index e9efbc9e63d83ed25fcd790b7a877c0023638f15..e96cc1d23366bce13624084fd476dda65aef140a 100644
--- a/support/include/nfsd_netlink.h
+++ b/support/include/nfsd_netlink.h
@@ -10,6 +10,45 @@
 #define NFSD_FAMILY_NAME	"nfsd"
 #define NFSD_FAMILY_VERSION	1
 
+enum nfsd_cache_type {
+	NFSD_CACHE_TYPE_SVC_EXPORT = 1,
+	NFSD_CACHE_TYPE_EXPKEY = 2,
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
@@ -36,6 +75,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
@@ -80,6 +120,84 @@ enum {
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
+enum {
+	NFSD_A_EXPKEY_SEQNO = 1,
+	NFSD_A_EXPKEY_CLIENT,
+	NFSD_A_EXPKEY_FSIDTYPE,
+	NFSD_A_EXPKEY_FSID,
+	NFSD_A_EXPKEY_NEGATIVE,
+	NFSD_A_EXPKEY_EXPIRY,
+	NFSD_A_EXPKEY_PATH,
+
+	__NFSD_A_EXPKEY_MAX,
+	NFSD_A_EXPKEY_MAX = (__NFSD_A_EXPKEY_MAX - 1)
+};
+
+enum {
+	NFSD_A_EXPKEY_REQS_REQUESTS = 1,
+
+	__NFSD_A_EXPKEY_REQS_MAX,
+	NFSD_A_EXPKEY_REQS_MAX = (__NFSD_A_EXPKEY_REQS_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -90,9 +208,17 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_CACHE_NOTIFY,
+	NFSD_CMD_SVC_EXPORT_GET_REQS,
+	NFSD_CMD_SVC_EXPORT_SET_REQS,
+	NFSD_CMD_EXPKEY_GET_REQS,
+	NFSD_CMD_EXPKEY_SET_REQS,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
 };
 
+#define NFSD_MCGRP_NONE		"none"
+#define NFSD_MCGRP_EXPORTD	"exportd"
+
 #endif /* _UAPI_LINUX_NFSD_NETLINK_H */
diff --git a/support/include/sunrpc_netlink.h b/support/include/sunrpc_netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..52c9aa3f19b6a218ec7d0518b58062beff11c774
--- /dev/null
+++ b/support/include/sunrpc_netlink.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/sunrpc_cache.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_SUNRPC_NETLINK_H
+#define _UAPI_LINUX_SUNRPC_NETLINK_H
+
+#define SUNRPC_FAMILY_NAME	"sunrpc"
+#define SUNRPC_FAMILY_VERSION	1
+
+enum sunrpc_cache_type {
+
+	SUNRPC_CACHE_TYPE_IP_MAP = 1,
+	SUNRPC_CACHE_TYPE_UNIX_GID = 2,
+};
+
+enum {
+	SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE = 1,
+
+	__SUNRPC_A_CACHE_NOTIFY_MAX,
+	SUNRPC_A_CACHE_NOTIFY_MAX = (__SUNRPC_A_CACHE_NOTIFY_MAX - 1)
+};
+
+enum {
+	SUNRPC_A_IP_MAP_SEQNO = 1,
+	SUNRPC_A_IP_MAP_CLASS,
+	SUNRPC_A_IP_MAP_ADDR,
+	SUNRPC_A_IP_MAP_DOMAIN,
+	SUNRPC_A_IP_MAP_NEGATIVE,
+	SUNRPC_A_IP_MAP_EXPIRY,
+
+	__SUNRPC_A_IP_MAP_MAX,
+	SUNRPC_A_IP_MAP_MAX = (__SUNRPC_A_IP_MAP_MAX - 1)
+};
+
+enum {
+	SUNRPC_A_IP_MAP_REQS_REQUESTS = 1,
+
+	__SUNRPC_A_IP_MAP_REQS_MAX,
+	SUNRPC_A_IP_MAP_REQS_MAX = (__SUNRPC_A_IP_MAP_REQS_MAX - 1)
+};
+
+enum {
+	SUNRPC_A_UNIX_GID_SEQNO = 1,
+	SUNRPC_A_UNIX_GID_UID,
+	SUNRPC_A_UNIX_GID_GIDS,
+	SUNRPC_A_UNIX_GID_NEGATIVE,
+	SUNRPC_A_UNIX_GID_EXPIRY,
+
+	__SUNRPC_A_UNIX_GID_MAX,
+	SUNRPC_A_UNIX_GID_MAX = (__SUNRPC_A_UNIX_GID_MAX - 1)
+};
+
+enum {
+	SUNRPC_A_UNIX_GID_REQS_REQUESTS = 1,
+
+	__SUNRPC_A_UNIX_GID_REQS_MAX,
+	SUNRPC_A_UNIX_GID_REQS_MAX = (__SUNRPC_A_UNIX_GID_REQS_MAX - 1)
+};
+
+enum {
+	SUNRPC_CMD_CACHE_NOTIFY = 1,
+	SUNRPC_CMD_IP_MAP_GET_REQS,
+	SUNRPC_CMD_IP_MAP_SET_REQS,
+	SUNRPC_CMD_UNIX_GID_GET_REQS,
+	SUNRPC_CMD_UNIX_GID_SET_REQS,
+
+	__SUNRPC_CMD_MAX,
+	SUNRPC_CMD_MAX = (__SUNRPC_CMD_MAX - 1)
+};
+
+#define SUNRPC_MCGRP_NONE	"none"
+#define SUNRPC_MCGRP_EXPORTD	"exportd"
+
+#endif /* _UAPI_LINUX_SUNRPC_NETLINK_H */

-- 
2.53.0


