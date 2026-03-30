Return-Path: <linux-nfs+bounces-20519-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ2IFhl9ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20519-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F4C35C220
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4009A3014FC2
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28263D564E;
	Mon, 30 Mar 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHb0aBry"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5423D525A
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877927; cv=none; b=i8LBqb+ksmm1aP5J4Nl5BtRuTf66/LhSp4BnJoLWWmLLBNkmKlrb018JHga6ChfaLnCMMNHm03kPgukhihEqcU3VYOqKNGA8U81/d+O3cmCGBfsvTe9oLrcJak6H/4t8lWeKh/cdhVAvRos0efYpEzJLIjp6Q2oL6h1MTOrfW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877927; c=relaxed/simple;
	bh=A16GLi/dESK9ufiFq9VkF4mB3AvHAZ1IYGDzupuVpu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rr3rFltLHiFdiZJ05CoZSWSYZHZAjtHBWucA+oerlaetI3xkS4Lhw82jje5XJ9JI4DrajK3GetCpZ8umCJNESAcZJINWxcqGhefT0dA8c9ZdSG7o+xzo0M7OjucOkeUVe2gWuWhXXyIPgngrL3YHtVNDn6D2iLeX7t4bf0hY49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHb0aBry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF1CC2BCB1;
	Mon, 30 Mar 2026 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877927;
	bh=A16GLi/dESK9ufiFq9VkF4mB3AvHAZ1IYGDzupuVpu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bHb0aBrygTpgADo1KSHPUO6dVsl5xQjqgaVqAsuBTR5ZZW4QRSQyhIjVxnNzkfXK5
	 XT7hKqysv0YyU+gDyBhJqueO3JaUG6mM/1VY5i9cX/EjunzLdUScEnuvQU34GfMdKK
	 MfWIvvC81ksLBaUBBO0GCmvGOXbDkDgnkTtfVfgY7C77HeoIXDDedA95uCVWLvjNRW
	 yRTbSZuEyyqsIp2dfFNer7nE67EvrfV18aj6zwwvQYVScMc1M9mdzaWJfmlOqWnqPr
	 mvYV9g++5i57wjHWdWiRJrX7v/HNSfiAFEfpx6bp1PxWG4JVivQ+BwZVff8H0PVkni
	 Wj/FUhDg15PvQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:24 -0400
Subject: [PATCH nfs-utils v2 04/16] support/include: update netlink headers
 for all cache upcalls
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-4-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7776; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=A16GLi/dESK9ufiFq9VkF4mB3AvHAZ1IYGDzupuVpu0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynze+Hq8748LXqNcjjUXyQPnjcalBH9BGp0d4
 9aGAcCsA+6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp83gAKCRAADmhBGVaC
 FbqdD/9yLCm5LHSsXZWOVPdVT3A5Q9LTUiWtKdEsnFR1wXFE9+LxcL5JkeztaxPgxSVa0L7wHG0
 z5jLWL1hej2A+EyiDj9y/iYpRFQa/ykv8eWGvfzO2RsJt6ZvDe3vXa0NRm7T0oCdCzTAP4UOG5n
 m4A6IMZfQAjOLM4e22ihSjGJzwwsSOm6c/kOI1y3zDNauWYUMX4/tg+UP8l9vOKR5V6IKa6YKG7
 VBFCfQ0CVtPA7ZU9veJ8Q/zK1HlPh2Cw9FD2eJaO/mLdVm5m1TwJctznv15rGqtKcyoR5GyRO+z
 AFAQBd1vKlqYWYBa1MgueK+dMr5jF+vAxbJdpZbjFR3CFEr19RcLQNyZtQM2jskSP+elO6FcB9i
 DiEXeryFkmBFSiqooPvZfAqsUyYHks8po5/5nfuh2vyX7QDtmmzkgcwmSci6LOGskgwnrLMwFmo
 uHEFpSNehQajwxZqlgWjCrvb8h5bYsEq6GcUGdzaurgcgyWRc5LOOZVY62nQbirj4UPQkxUbH8u
 vQf9NGQ6GWq2PLtQ+2Il6nocKJjmCAmLmYu+nacyvE99/AV2tpZlxvlhhQT8kQGhx2qr5YggkCl
 L/3ovCA0bqt/8m2oA0KNTYJ8PFebygiconSjBkGtew8me0lnP4r3ufDci2Un69Q1WxQgVefXQlJ
 xYS/2FDytWlqIOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20519-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03F4C35C220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sync the bundled nfsd_netlink.h with the current kernel UAPI header.
This brings in:
 - NFSD_CACHE_TYPE_EXPKEY in the cache-type enum
 - NFSD_A_SVC_EXPORT_FLAGS and NFSD_A_SVC_EXPORT_FSID attributes
 - NFSD_A_EXPKEY_* and NFSD_A_EXPKEY_REQS_* attribute enums
 - NFSD_CMD_EXPKEY_GET_REQS and NFSD_CMD_EXPKEY_SET_REQS commands
 - NFSD_CMD_CACHE_FLUSH command

Add a new bundled sunrpc_netlink.h header for the sunrpc genl family,
which handles auth.unix.ip and auth.unix.gid cache upcalls via netlink.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/include/Makefile.am      |   1 +
 support/include/nfsd_netlink.h   | 141 +++++++++++++++++++++++++++++++++++++++
 support/include/sunrpc_netlink.h |  84 +++++++++++++++++++++++
 3 files changed, 226 insertions(+)

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
index 97c7447f4d14df97c1cba8cdf1f24fba0a7918b3..2d708d24cbd23770f800fa7e52b351886aec785c 100644
--- a/support/include/nfsd_netlink.h
+++ b/support/include/nfsd_netlink.h
@@ -10,6 +10,53 @@
 #define NFSD_FAMILY_NAME	"nfsd"
 #define NFSD_FAMILY_VERSION	1
 
+enum nfsd_cache_type {
+	NFSD_CACHE_TYPE_SVC_EXPORT = 1,
+	NFSD_CACHE_TYPE_EXPKEY = 2,
+};
+
+/*
+ * These flags are ordered to match the NFSEXP_* flags in
+ * include/linux/nfsd/export.h
+ */
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
+/*
+ * These flags are ordered to match the NFSEXP_XPRTSEC_* flags in
+ * include/linux/nfsd/export.h
+ */
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
@@ -81,6 +128,91 @@ enum {
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
+enum {
+	NFSD_A_CACHE_FLUSH_MASK = 1,
+
+	__NFSD_A_CACHE_FLUSH_MAX,
+	NFSD_A_CACHE_FLUSH_MAX = (__NFSD_A_CACHE_FLUSH_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -91,9 +223,18 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_CACHE_NOTIFY,
+	NFSD_CMD_SVC_EXPORT_GET_REQS,
+	NFSD_CMD_SVC_EXPORT_SET_REQS,
+	NFSD_CMD_EXPKEY_GET_REQS,
+	NFSD_CMD_EXPKEY_SET_REQS,
+	NFSD_CMD_CACHE_FLUSH,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
 };
 
+#define NFSD_MCGRP_NONE		"none"
+#define NFSD_MCGRP_EXPORTD	"exportd"
+
 #endif /* _UAPI_LINUX_NFSD_NETLINK_H */
diff --git a/support/include/sunrpc_netlink.h b/support/include/sunrpc_netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..34677f0ec2f958961f1f460c1dc81c8377cc5157
--- /dev/null
+++ b/support/include/sunrpc_netlink.h
@@ -0,0 +1,84 @@
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
+	SUNRPC_A_CACHE_FLUSH_MASK = 1,
+
+	__SUNRPC_A_CACHE_FLUSH_MAX,
+	SUNRPC_A_CACHE_FLUSH_MAX = (__SUNRPC_A_CACHE_FLUSH_MAX - 1)
+};
+
+enum {
+	SUNRPC_CMD_CACHE_NOTIFY = 1,
+	SUNRPC_CMD_IP_MAP_GET_REQS,
+	SUNRPC_CMD_IP_MAP_SET_REQS,
+	SUNRPC_CMD_UNIX_GID_GET_REQS,
+	SUNRPC_CMD_UNIX_GID_SET_REQS,
+	SUNRPC_CMD_CACHE_FLUSH,
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


