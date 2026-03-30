Return-Path: <linux-nfs+bounces-20530-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNV0Kwl/ymmR9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20530-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:47:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DAE35C42E
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 903C430A75B3
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2CB3D648B;
	Mon, 30 Mar 2026 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5QN2/7l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBF3D47BF
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877940; cv=none; b=bAElDxmZPb9gpdNL+PHVBxwsohxUfpOXFmc/PvraRFip7OxTt3xC3Cf8bXxngQ562gQuLW00kBLKi3s79BrrOx/YZFdDcO5MtHR5c/CzUNRZeneF1XXlCtWdN9lsUJdgFYTUD7KyuLK4bNnblKYjDN/RzigGI+GzF6roJ6Ta5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877940; c=relaxed/simple;
	bh=JUiR8+K3NRLTbUxQp16eaaZvcHN4D3LqkIS17oMjuko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHxTJnXuGY9wOzkhyPxpGonMwIM4dJrQHQ1FwXmUvchd0KlnS7E4kQFZT5E8sCPqUnlQjqUZP7gUDzO2M0IoF89eEnXWcEijOFHFAfQjlLEh770tSWzEa/eoQpPB01/To3vLbkX1y0t94m0ahsrNQDpJG82l9ub/7sFihCcy024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5QN2/7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C16C2BCB1;
	Mon, 30 Mar 2026 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877939;
	bh=JUiR8+K3NRLTbUxQp16eaaZvcHN4D3LqkIS17oMjuko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m5QN2/7lqHwPpXGup/Is37tMSkeIEjqfHyU79uR8H/Ym2iOxRotsCX5CAIDeWHWUF
	 iVuCbu7b96Awr0+V7D3DqfvGA6enT6Kw9F1GeCQ/CNoaBMw6Y9Gsd/iKNM+tyBag1B
	 IYllIF1apbF+Mv84xocCbrQ/tu4y1qkzNHtiUIWilZGfMebJaVTCqlDiRRJijmKxIo
	 xRePOFejdP7dbPr2Tl9aTGFHtVfIZ4VNImao7nCkfts96Fup+SyCLRV3a/GylT5Pfe
	 1NZEXSTYjm70yyT5+pU/Zg1Qys2G3Uq6SKAuY8vlltfwrMygw8uf1YqNffMrlsH459
	 83mF41FwWxrCw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:35 -0400
Subject: [PATCH nfs-utils v2 15/16] exportfs: use netlink to probe kernel
 support, skip export_test
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-15-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3867; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JUiR8+K3NRLTbUxQp16eaaZvcHN4D3LqkIS17oMjuko=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzh/dTpQT1u4EO9Ek7MLifLtr1u779B2VhEs
 tcH14X/fOOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp84QAKCRAADmhBGVaC
 FWveD/oD7gxrOYGDREXSC5il9qBPz2tjoe8dF8a1MM8ydZP+1sIpC9h7ihAESkTDHM380V+8pHN
 /Un9ugGWOIOHOe+uGVe4bvCNEdivKx1WELJcjbm+RSN/8p32lfMp5Pcnz/s9npxWcRqws/8IZ6O
 XwRqwzkdkrvq9DGv20RnzAR74aD1d+tvtVdFpikCoaADfyYmwI2bVEkS7BMmIBJxJe+bjQgHCgX
 wOawr214P17ZDMIWu4bPn4l0K1amC8U/9MjHohR9ynjZ2/fzGDGJQKU+LURBXzb23L755diZNVM
 flKGJMYMWZw/EVPPbp12/6slFB1dFW0DaTgRDTygE5Ub70kPBuka33/z4lDkcRsJ/RyhjJvg1Bv
 TDS1/Ibrd67t02ehKERqmYUhzA2HUlIeguahpgENLQnXNcN9yeLefptWH55G0cSbyqZwCogfsKX
 WxUs9Dt9cWg4N3orLWvV73ig8zjWkkdmZyW22ylpMk2r/HNNGBrQvJHfVWsFzhSVf+uM+JxQwg7
 Zt5iwSvWFrgQArtYAdb4VrrNf8oF8Kc3hyVxjlrzHmyzNkHB7Bh3kdBNfiosT/kOvFmYG/6h7Ak
 ceDXkJZI5HgcX4X3acfJoFs6BAkNikMRyBXqt1Y00GSD+nc3+omMznRTECv1ZdTWuQ75l2ZzxzF
 u56ExJHQexAM/TA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20530-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28DAE35C42E
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
index 54ce62c5ce9acf48f3b9d26d1309d9b195d08824..1f726746ebc5185ef00a177760fc7a7fa44126c5 100644
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


