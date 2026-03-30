Return-Path: <linux-nfs+bounces-20529-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHejHDF9ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20529-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:40:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E90235C254
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66B7E3018694
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E973D6484;
	Mon, 30 Mar 2026 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss6r3PZ8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DB3D6469
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877938; cv=none; b=Mp9SHszlDTUpydskv7FuqBNF9ugobNeVcWUL4BgDQ10EGPeyAO8eWqQL3eUZNp1cgYepqw2i/9qTJqRVxxZ7bCpuzB+pL/2i4Y14P9UlBJQgU9oKLy5hTy3YURxktGITAP3ZnoWLi55979shBH0TuUDJmb1fPmHhxbM16eyw63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877938; c=relaxed/simple;
	bh=CqwVd/IrPNhU9GoiOqWmNiU1b1U6E48uAf+HmE2ptAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lU/fnyjHiTguKOpkwBDuVMDPoApSEbnmQXwlmwDZn29ROacllUgNZBbCW0iKwynCKTwM1r2d8DURa6aUqJaLsp/bvhbqpLcW2W/cW2u6vx3d0+Cy6UkYb5eHREqbLEnV9iVhtYKvEznUCDxHw1De9qpa03Ucz7nvcPW60kb0pP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss6r3PZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F8BC4CEF7;
	Mon, 30 Mar 2026 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877938;
	bh=CqwVd/IrPNhU9GoiOqWmNiU1b1U6E48uAf+HmE2ptAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ss6r3PZ8/93RqoUG+xw5SYEXgjuGzWh0g7ea75dt6iXuBddpJKZQKjyTiQOrQNZv1
	 9pw01U0flCwBUsXPk3/FEWjycB+tjKObt/2sk1yuoGsxyErQP35YTRavNYeBZB+dML
	 zwp7Xk3dDnUOWxxUvBeRdSGOC6IBsTC0hoAnBz7E3CSyOEvY8aKA8avcKEK9lgbgqp
	 dv0W+7ameL6VT+QO+N3H/BdBRh4ApL9jWV+PFosR/E4Uec/n4AnOB4CmeOTu3TtnuU
	 jT5yzdOINKKCPElMwxcQO+5J7QfpqJOoDWPpuM7373QOkmsqiy/TjsjgFcqtdRkb14
	 DgrxIo1t1wApg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:34 -0400
Subject: [PATCH nfs-utils v2 14/16] exportfs: add netlink support for cache
 flush with /proc fallback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-14-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7284; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CqwVd/IrPNhU9GoiOqWmNiU1b1U6E48uAf+HmE2ptAY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzhTHbz+lDNmomOi6j8lNKejBYriVXL3nBWA
 ghoYNeZSU+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp84QAKCRAADmhBGVaC
 Fe6dEACH6Xgf1qNWOVlgkeJNy4bxyWTODuJbNhptzeiSR3laaUqMxVeyg0NijDX35ccriLomAR4
 umFib/KUekawBsUrAOCuj1Kz5Zi7RpHYsvnrWiei60g3wcB4FNK0dA+v/0ujm1Eu7HZjUHHhBEi
 qXMR8Pf+nNX5wgp+5LgLo470DbLQbx7VDzvctuYZpd23LhI4Jr/jD3IdUFJ8dmB6p+T66jkmmOc
 r93g/xRXtjZItDjJhkd02/LAWLiU7A9Fm6z8TaNnbLTh9kBR2k1fRg82UufVAMXySP6cnG3PEXl
 XKdfFz8kYDgynzG8itqoyM4n+owVVWGU6qj1ggHydY9eJCtDpGj/hoHv98fUcWpSwgbNn+FcnJ8
 znCESegEwpPON72PibTFzel6qonUlzZ5PCF2Cr2xvPj5aEsR9HfcV5X7pcZ7c1DqUMEoOd617Gz
 CAgFGhZwG9pP6mQkfduMf7mYlLR8a6SqzrREuOprFCaYXtTW4lVZlANlZupS1M8IHHePZ9nMeJb
 qNOaTCi+URE7Xb6QmYACfytwHCEhxaYpJTW/qNU2yGsKk1Ocf3lMw7Dl0PuOA4fha11gOxlmF7V
 G7oVShvAIaJA4JH8MSqVR9+pGaCons5InmI4kAjt5y9C0ksa8qkDryi8kZz11zdjTBOqLgOo6O+
 lZwJUXEEeic4new==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20529-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E90235C254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move cache_flush() from support/nfs/cacheio.c to a new file
support/export/cache_flush.c, which has access to libnl.

The new implementation tries netlink first:
- Sends SUNRPC_CMD_CACHE_FLUSH to flush auth.unix.ip and auth.unix.gid
- Sends NFSD_CMD_CACHE_FLUSH to flush nfsd.fh and nfsd.export
- Flushes sunrpc caches before nfsd caches to maintain dependency order

If the sunrpc genl family cannot be resolved (older kernel), falls back
to the original /proc/net/rpc/*/flush write path.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/Makefile.am   |   2 +-
 support/export/cache_flush.c | 164 +++++++++++++++++++++++++++++++++++++++++++
 support/nfs/cacheio.c        |  49 +------------
 3 files changed, 166 insertions(+), 49 deletions(-)

diff --git a/support/export/Makefile.am b/support/export/Makefile.am
index ae7ace44112b889f1c461c5473fb1bd42a42f182..33416176c41eb6eadd1880f7c7432b4ca2d8c973 100644
--- a/support/export/Makefile.am
+++ b/support/export/Makefile.am
@@ -12,7 +12,7 @@ EXTRA_DIST	= mount.x
 noinst_LIBRARIES = libexport.a
 libexport_a_SOURCES = client.c export.c hostname.c \
 		      xtab.c mount_clnt.c mount_xdr.c \
-		      cache.c auth.c v4root.c fsloc.c \
+		      cache.c cache_flush.c auth.c v4root.c fsloc.c \
 		      v4clients.c
 libexport_a_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport \
 		       $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS)
diff --git a/support/export/cache_flush.c b/support/export/cache_flush.c
new file mode 100644
index 0000000000000000000000000000000000000000..7d7f12b212967e5b3d1a2357de07bc3ba5f0b674
--- /dev/null
+++ b/support/export/cache_flush.c
@@ -0,0 +1,164 @@
+/*
+ * support/export/cache_flush.c
+ *
+ * Flush knfsd caches via netlink with /proc fallback.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <time.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include "nfslib.h"
+#include "xlog.h"
+
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+
+#ifdef USE_SYSTEM_NFSD_NETLINK_H
+#include <linux/nfsd_netlink.h>
+#else
+#include "nfsd_netlink.h"
+#endif
+
+#ifdef USE_SYSTEM_SUNRPC_NETLINK_H
+#include <linux/sunrpc_netlink.h>
+#else
+#include "sunrpc_netlink.h"
+#endif
+
+static int nl_send_flush(struct nl_sock *sock, int family, int cmd)
+{
+	struct nl_msg *msg;
+	int ret;
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		return -ENOMEM;
+
+	if (!genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family,
+			 0, 0, cmd, 0)) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	/* No mask attribute = flush all caches in this family */
+	ret = nl_send_auto(sock, msg);
+	if (ret >= 0)
+		ret = nl_wait_for_ack(sock);
+	nlmsg_free(msg);
+	return ret;
+}
+
+static int cache_nl_flush(void)
+{
+	struct nl_sock *sock;
+	int family, ret, val = 1;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -1;
+
+	if (genl_connect(sock)) {
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	setsockopt(nl_socket_get_fd(sock), SOL_NETLINK, NETLINK_EXT_ACK,
+		   &val, sizeof(val));
+
+	/* Flush sunrpc caches first (dependency order) */
+	family = genl_ctrl_resolve(sock, SUNRPC_FAMILY_NAME);
+	if (family < 0) {
+		xlog(D_NETLINK, "sunrpc genl family not found, "
+		     "skipping netlink flush");
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	ret = nl_send_flush(sock, family, SUNRPC_CMD_CACHE_FLUSH);
+	if (ret < 0) {
+		xlog(D_NETLINK, "sunrpc cache flush failed: %d", ret);
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	/* Flush nfsd caches */
+	family = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
+	if (family < 0) {
+		xlog(D_NETLINK, "nfsd genl family not found, "
+		     "skipping nfsd cache flush");
+		nl_socket_free(sock);
+		return 0;
+	}
+
+	ret = nl_send_flush(sock, family, NFSD_CMD_CACHE_FLUSH);
+	nl_socket_free(sock);
+	if (ret < 0) {
+		xlog(D_NETLINK, "nfsd cache flush failed: %d", ret);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void cache_proc_flush(void)
+{
+	int c;
+	char stime[32];
+	char path[200];
+	time_t now;
+	/* Note: the order of these caches is important.
+	 * They need to be flushed in dependency order. So
+	 * a cache that references items in another cache,
+	 * as nfsd.fh entries reference items in nfsd.export,
+	 * must be flushed before the cache that it references.
+	 */
+	static char *cachelist[] = {
+		"auth.unix.ip",
+		"auth.unix.gid",
+		"nfsd.fh",
+		"nfsd.export",
+		NULL
+	};
+	now = time(0);
+
+	/* Since v4.16-rc2-3-g3b68e6ee3cbd the timestamp written is ignored.
+	 * It is safest always to flush caches if there is any doubt.
+	 * For earlier kernels, writing the next second from now is
+	 * the best we can do.
+	 */
+	sprintf(stime, "%" PRId64 "\n", (int64_t)now+1);
+	for (c=0; cachelist[c]; c++) {
+		int fd;
+		sprintf(path, "/proc/net/rpc/%s/flush", cachelist[c]);
+		fd = open(path, O_RDWR);
+		if (fd >= 0) {
+			if (write(fd, stime, strlen(stime)) != (ssize_t)strlen(stime)) {
+				xlog_warn("Writing to '%s' failed: errno %d (%s)",
+				path, errno, strerror(errno));
+			}
+			close(fd);
+		}
+	}
+}
+
+void
+cache_flush(void)
+{
+	if (cache_nl_flush() == 0) {
+		xlog(D_NETLINK, "cache flush via netlink succeeded");
+		return;
+	}
+	/* Fallback: /proc path */
+	cache_proc_flush();
+}
diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
index bd4da0e5ad93f963bf8090062541f34ededd1e03..95eeabbdb978cd227da9877b81e5ed2d65dedaf9 100644
--- a/support/nfs/cacheio.c
+++ b/support/nfs/cacheio.c
@@ -203,51 +203,4 @@ int qword_get_uint(char **bpp, unsigned int *anint)
 	return 0;
 }
 
-/* flush the kNFSd caches.
- * Set the flush time to the mtime of the etab state file or
- * if force, to now.
- * the caches to flush are:
- *  auth.unix.ip nfsd.export nfsd.fh
- */
-
-void
-cache_flush(void)
-{
-	int c;
-	char stime[32];
-	char path[200];
-	time_t now;
-	/* Note: the order of these caches is important.
-	 * They need to be flushed in dependancy order. So
-	 * a cache that references items in another cache,
-	 * as nfsd.fh entries reference items in nfsd.export,
-	 * must be flushed before the cache that it references.
-	 */
-	static char *cachelist[] = {
-		"auth.unix.ip",
-		"auth.unix.gid",
-		"nfsd.fh",
-		"nfsd.export",
-		NULL
-	};
-	now = time(0);
-
-	/* Since v4.16-rc2-3-g3b68e6ee3cbd the timestamp written is ignored.
-	 * It is safest always to flush caches if there is any doubt.
-	 * For earlier kernels, writing the next second from now is
-	 * the best we can do.
-	 */
-	sprintf(stime, "%" PRId64 "\n", (int64_t)now+1);
-	for (c=0; cachelist[c]; c++) {
-		int fd;
-		sprintf(path, "/proc/net/rpc/%s/flush", cachelist[c]);
-		fd = open(path, O_RDWR);
-		if (fd >= 0) {
-			if (write(fd, stime, strlen(stime)) != (ssize_t)strlen(stime)) {
-				xlog_warn("Writing to '%s' failed: errno %d (%s)",
-				path, errno, strerror(errno));
-			}
-			close(fd);
-		}
-	}
-}
+/* cache_flush() has moved to support/export/cache.c for netlink support */

-- 
2.53.0


