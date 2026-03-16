Return-Path: <linux-nfs+bounces-20215-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GToDV8huGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20215-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:27:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78029C521
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C20A31B1E2E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC873A257F;
	Mon, 16 Mar 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7QAa+S6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98A3A2571
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674231; cv=none; b=GtnFhc2gPooOciPAv/JcJXL1zIcavVlzfu3GvzofgXxUb/nzw58Qktysjl6Nq8iBQ4yEtytId/CCqVALCSg/FXr05xtGemYD/mIIgLsAVPUR1YuXuhTRsrxnHL6//DOC90n7F2xzscKc8/Ew6pcYcEnRm/xMzRtmHnkAa4xifcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674231; c=relaxed/simple;
	bh=AhS5JkEOZRC82BQzC41NKsAPZOrL+qW8KYyWLhjO8VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZGxLVofmTNQOZb+4m1BFyYBJ0IhG4Zcnv2JA2HLcUnhgxL/3yHLWUJncRzcXTXZluWAANxcLBz+F9fiWNFNP/5Eu6ywyRYG7gI3ff5NOT5jwGNHFxkvrjuiunXdH2twDRIywakF6sEUyMMW3yYKUePOcplcNSRJFrt5oW7QUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7QAa+S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF46C19425;
	Mon, 16 Mar 2026 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674230;
	bh=AhS5JkEOZRC82BQzC41NKsAPZOrL+qW8KYyWLhjO8VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W7QAa+S6g6FTRF+Xj+18+ol31zpyV960AC42arBKsUQp/strqt805GG+wFY+XjAq3
	 34FpHbevQLkzfn/7auHUjnG+rp3Xkp6tZQSA8lJJh6LYlLkPkuY5ga1mSbiyMZtPXj
	 p2MUKj5wCfEQzh72qz1CquNgSuDfShEaRN3LDThajfafhAVVv7yUix+dP3M6sgWB2y
	 camnkZMmBYIb+WQR8sXA5qwP9h2NKaZIPmoJmkZ+BUwmaDym25rSmgD2d3SNW3/DWX
	 5RDZIiZBM0lf3AmkfwkpUw92fWs6yhQIeT2GeQNMiV2Es9ndGUB1W6r/cotdBM+guv
	 I2gMeOB/fgSIw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:54 -0400
Subject: [PATCH nfs-utils 16/17] exportfs: use netlink to probe kernel
 support, skip export_test
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-16-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3867; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AhS5JkEOZRC82BQzC41NKsAPZOrL+qW8KYyWLhjO8VA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7jb7YeIF1ftwbN2G5xQT673fL97fyqb8mPV
 i9bi0Tt6ryJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4wAKCRAADmhBGVaC
 FZ+AD/sFsFLV9g4SWesrm/oPSqXma4GSyWrqtlJvDjw/fSM/dmbR4PEi+zLRKvZXN8IpD7jlZRq
 mafGMZWvGNq37lZWtEgalzI60kRrfyIJ93KcpwdDIvShObqQwTIP61XaUPFVCjdVfLdCSJIl2C/
 MFVdND1tnfHgRlbqTCLJvu2I+S8yhafrT7r2BEHkmaAt/Mo4N9eI8tfQUFMRhmkG5MIDNoXhssb
 FRZi6LuXWxd9bSBoe4NbnkNLK3rGsGStGBYCTWGk/mfS5PQhI5/JnDukaW11tc63YfLCgT7V1t4
 fibZ1k3LuEF1uSoDgWYr/WxXQuczK8Pgi8NVMd0ifTnPOa0F/RCU9RUSnuaAws4uxXWCqmDaBTr
 L6RcWz3th8wor2idvC6XX6e7fEd41lXdYzRqX8p7SV3Zq0qeryuhdcG8L46VTWNCCYuCiKEuLrt
 fUFwBzgPKqg8qpysXi2kHmdS3pjYZEvVz6PDSxZn872EjtKFFJdK11sOtKco47A0RSI08h0sdhL
 H9KLFqw4TekHXz6n4ltsLv3h+TXL8DzRhW9eU0MQPRvOXb192uJxtyUpd8uWQbdae4Oykr8a11e
 UelEscInWQ5tQN1zWPDQLK0eS4/J3jWICcN2d2GC91upJYomdGAmBbhBFjcysgBMLrgMxDi0oJu
 L3HUCZjoCidL2cQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20215-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makefile.in:url]
X-Rspamd-Queue-Id: 9F78029C521
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor can_test() to first try resolving the sunrpc genl family via
netlink. If successful, the kernel supports the new netlink-based cache
interfaces and we can skip the advisory export_test() probe -- mountd
and exportd will validate exports at cache-fill time via check_export().

can_test() now returns:
  2 = netlink available (skip export_test)
  1 = /proc available (keep export_test as before)
  0 = neither available

Update validate_export() to check this return value and skip the
export_test() calls when netlink is available.

Link exportfs against libnl3/libnl-genl-3 (already a mandatory build
dependency for nfs-utils).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/exportfs/Makefile.am |  6 ++++--
 utils/exportfs/exportfs.c  | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
index 7f8ce9faf2b469c8560f5fbee40b81e3443eab78..8db5fdae1741e1c79639bbdfd5d63f8571363e63 100644
--- a/utils/exportfs/Makefile.am
+++ b/utils/exportfs/Makefile.am
@@ -11,8 +11,10 @@ exportfs_LDADD = ../../support/export/libexport.a \
 	       	 ../../support/nfs/libnfs.la \
 		 ../../support/misc/libmisc.a \
 		 ../../support/reexport/libreexport.a \
-		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
+		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD) \
+		 $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
 
-exportfs_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
+exportfs_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport \
+		    $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 748c38e3e966703c7a870a6aa9589d32708edcd2..04753fa169f97c6b07893613197739ff36e0d09b 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -40,6 +40,15 @@
 #include "conffile.h"
 #include "reexport.h"
 
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+
+#ifdef USE_SYSTEM_SUNRPC_NETLINK_H
+#include <linux/sunrpc_netlink.h>
+#else
+#include "sunrpc_netlink.h"
+#endif
+
 static void	export_all(int verbose);
 static void	exportfs(char *arg, char *options, int verbose);
 static void	unexportfs(char *arg, int verbose);
@@ -476,13 +485,34 @@ unexportfs(char *arg, int verbose)
 		xlog(L_ERROR, "Invalid export syntax: %s", arg);
 }
 
+/* Return values:
+ *   2 = netlink available (skip export_test)
+ *   1 = /proc available (keep export_test)
+ *   0 = neither available
+ */
 static int can_test(void)
 {
+	struct nl_sock *sock;
+	int family;
 	char buf[1024] = { 0 };
 	int fd;
 	int n;
 	size_t bufsiz = sizeof(buf);
 
+	/* Try netlink first: resolve sunrpc genl family */
+	sock = nl_socket_alloc();
+	if (sock) {
+		if (genl_connect(sock) == 0) {
+			family = genl_ctrl_resolve(sock, SUNRPC_FAMILY_NAME);
+			nl_socket_free(sock);
+			if (family >= 0)
+				return 2;
+		} else {
+			nl_socket_free(sock);
+		}
+	}
+
+	/* Fallback: /proc probe */
 	fd = open("/proc/net/rpc/auth.unix.ip/channel", O_WRONLY);
 	if (fd < 0)
 		return 0;
@@ -522,6 +552,7 @@ validate_export(nfs_export *exp)
 	char *path = exportent_realpath(&exp->m_export);
 	struct statfs stf;
 	int fs_has_fsid = 0;
+	int test_result;
 
 	if (stat(path, &stb) < 0) {
 		xlog(L_ERROR, "Failed to stat %s: %m", path);
@@ -532,7 +563,16 @@ validate_export(nfs_export *exp)
 			"Remote access will fail", path);
 		return;
 	}
-	if (!can_test())
+
+	test_result = can_test();
+	if (!test_result)
+		return;
+
+	/*
+	 * When netlink is available, skip the export_test() probe.
+	 * mountd/exportd will validate exports at cache-fill time.
+	 */
+	if (test_result == 2)
 		return;
 
 	if (!statfs(path, &stf) &&

-- 
2.53.0


