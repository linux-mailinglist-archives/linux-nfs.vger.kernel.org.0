Return-Path: <linux-nfs+bounces-20677-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNF9FFzt02nInwcAu9opvQ
	(envelope-from <linux-nfs+bounces-20677-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 19:29:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 997383A5B16
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A559304C109
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4A392C23;
	Mon,  6 Apr 2026 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYtU/m0y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45D3914FE
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496417; cv=none; b=WR55YqTX7PEc99rIPv8cx5YlXkQgadLtXSiB0x77Wn7ldQR+04rSwFoMsaIV2xOecZB7qU2I9DiwZOL5uys2Jk/W7Oz9jlwWIgE5k5gR+yC6mKWJbOCDThtdlzsxC8SwseU0sbIiBTrJSgGv3zM82fP5rIQc8TDrjcK3kuZLIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496417; c=relaxed/simple;
	bh=QV+EjL8erWJG80vg6I+M+jW93ojDV87ZYKjUuS/g9TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsLTJk6CDj8fEtObp2LhWeP/BI6h7qaNmkmA6zkRU/29ml/Iacfdy7Ql4VzAzdHIefLj6Z91E9lq3jDwgZ4kAYPgolL0WW9MLC7z/oRQQjRQ4ns7ocrzF6lt8AorewdkTahLDnGohDVKpjqLYNy4IzXjECInk2Cjizzn8yB6SdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYtU/m0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F42BC19421;
	Mon,  6 Apr 2026 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775496416;
	bh=QV+EjL8erWJG80vg6I+M+jW93ojDV87ZYKjUuS/g9TY=;
	h=From:To:Cc:Subject:Date:From;
	b=YYtU/m0yiAX5EjIOhy8QRBU3DKm5VU4unKUD1OQVGbtKYey28fhU3n/3Z+yJKE9ps
	 OCMizODi8qeAUc6hye00HJ8GfhcagVSgz2hcbKI6jfx4dNMFGCBxOoM2h+E+HZfcEZ
	 pHviZglTULZi/c5/WCCO5D5ZduLB06+PFx+6vOelU2oe+v8f2tf1wRp1XNnO0uVBzd
	 XS+9mYomIPBc5qcRii7Vgg5FVxXDeQsYMcDhvTVWiMkb2duaRbQdVuVzfWx0/76IJn
	 ZvYn4GJJtcZTcjxSG3jSzcgMVmhoWXrWDlfleyWbsunyiespXVNRayESLjwlP20rw/
	 /DkENfIuwgw8Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2] exportfs: release NFSv4 state when last client is unexported
Date: Mon,  6 Apr 2026 13:26:53 -0400
Message-ID: <20260406172653.1962-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20677-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 997383A5B16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

When exportfs -u removes the last client for a given export path,
NFSv4 state (opens, locks, delegations) acquired through that
export may still hold the underlying filesystem busy, preventing
unmount.

After removing an export entry, check whether any active exports
remain for the same path across all client types.  If none remain,
send NFSD_CMD_UNLOCK_EXPORT to the kernel via generic netlink,
which revokes the associated NFSv4 state and closes cached file
handles.

This uses a new shared helper, nfsd_nl_cmd_str(), in
support/nfs/nfsdnl.c that handles the netlink socket setup, message
construction, and ACK handling for simple nfsd commands carrying
a single string attribute.  The helper is conditionally compiled
when libnl3 is available (gated by the existing nfsdctl configure
option).

Also update the local nfsd_netlink.h copy with the
NFSD_CMD_UNLOCK_IP, NFSD_CMD_UNLOCK_FILESYSTEM, and
NFSD_CMD_UNLOCK_EXPORT command and attribute definitions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 configure.ac                   |   2 +
 support/include/nfsd_netlink.h |  24 +++++++
 support/include/nfsdnl.h       |  34 +++++++++
 support/nfs/Makefile.am        |   7 ++
 support/nfs/nfsdnl.c           | 124 +++++++++++++++++++++++++++++++++
 utils/exportfs/exportfs.c      |  65 ++++++++++++++++-
 utils/exportfs/exportfs.man    |  17 +++++
 7 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 support/include/nfsdnl.h
 create mode 100644 support/nfs/nfsdnl.c

diff --git a/configure.ac b/configure.ac
index 115c611fa5e3..8ca06fd62b47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -256,6 +256,8 @@ PKG_CHECK_MODULES(LIBNL3, libnl-3.0 >= 3.1)
 PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
 
 AC_CHECK_HEADERS(linux/nfsd_netlink.h)
+AC_DEFINE([HAVE_NFSD_NETLINK], 1,
+	  [Define to 1 if nfsd generic netlink support is available])
 
 # ensure we have the expkey attributes
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
diff --git a/support/include/nfsd_netlink.h b/support/include/nfsd_netlink.h
index 2d708d24cbd2..a6a831866be8 100644
--- a/support/include/nfsd_netlink.h
+++ b/support/include/nfsd_netlink.h
@@ -128,6 +128,27 @@ enum {
 	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
 };
 
+enum {
+	NFSD_A_UNLOCK_IP_ADDRESS = 1,
+
+	__NFSD_A_UNLOCK_IP_MAX,
+	NFSD_A_UNLOCK_IP_MAX = (__NFSD_A_UNLOCK_IP_MAX - 1)
+};
+
+enum {
+	NFSD_A_UNLOCK_FILESYSTEM_PATH = 1,
+
+	__NFSD_A_UNLOCK_FILESYSTEM_MAX,
+	NFSD_A_UNLOCK_FILESYSTEM_MAX = (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
+};
+
+enum {
+	NFSD_A_UNLOCK_EXPORT_PATH = 1,
+
+	__NFSD_A_UNLOCK_EXPORT_MAX,
+	NFSD_A_UNLOCK_EXPORT_MAX = (__NFSD_A_UNLOCK_EXPORT_MAX - 1)
+};
+
 enum {
 	NFSD_A_FSLOCATION_HOST = 1,
 	NFSD_A_FSLOCATION_PATH,
@@ -229,6 +250,9 @@ enum {
 	NFSD_CMD_EXPKEY_GET_REQS,
 	NFSD_CMD_EXPKEY_SET_REQS,
 	NFSD_CMD_CACHE_FLUSH,
+	NFSD_CMD_UNLOCK_IP,
+	NFSD_CMD_UNLOCK_FILESYSTEM,
+	NFSD_CMD_UNLOCK_EXPORT,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/support/include/nfsdnl.h b/support/include/nfsdnl.h
new file mode 100644
index 000000000000..352801e5cc43
--- /dev/null
+++ b/support/include/nfsdnl.h
@@ -0,0 +1,34 @@
+/*
+ * Helper for sending nfsd generic netlink commands.
+ *
+ * Used by both nfsdctl and exportfs.
+ */
+
+#ifndef NFS_UTILS_NFSDNL_H
+#define NFS_UTILS_NFSDNL_H
+
+#ifdef HAVE_NFSD_NETLINK
+
+/**
+ * nfsd_nl_cmd_str - send an nfsd netlink command carrying a string attribute
+ * @cmd:   NFSD_CMD_* command number
+ * @attr:  NFSD_A_* attribute number
+ * @value: NUL-terminated string value for the attribute
+ *
+ * Opens a genetlink connection, resolves the "nfsd" family, sends a
+ * single "do" command with one string attribute, waits for the ACK,
+ * and cleans up.
+ *
+ * Returns 0 on success or a negative errno on failure.
+ */
+int nfsd_nl_cmd_str(int cmd, int attr, const char *value);
+
+#else
+
+static inline int nfsd_nl_cmd_str(int cmd, int attr, const char *value)
+{
+	return -ENOSYS;
+}
+
+#endif /* HAVE_NFSD_NETLINK */
+#endif /* NFS_UTILS_NFSDNL_H */
diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
index 5bfd71a9c8da..64ad5d075b9e 100644
--- a/support/nfs/Makefile.am
+++ b/support/nfs/Makefile.am
@@ -11,6 +11,13 @@ libnfs_la_SOURCES = exports.c rmtab.c xio.c rpcmisc.c rpcdispatch.c \
 libnfs_la_LIBADD = libnfsconf.la -luuid
 libnfs_la_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
 
+if CONFIG_NFSDCTL
+libnfs_la_SOURCES += nfsdnl.c
+libnfs_la_CPPFLAGS += $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS) \
+		      -I$(top_srcdir)/utils/nfsdctl
+libnfs_la_LIBADD += $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
+endif
+
 libnfsconf_la_SOURCES = conffile.c xlog.c
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/support/nfs/nfsdnl.c b/support/nfs/nfsdnl.c
new file mode 100644
index 000000000000..ece0b57afd4b
--- /dev/null
+++ b/support/nfs/nfsdnl.c
@@ -0,0 +1,124 @@
+/*
+ * nfsdnl.c -- send nfsd generic netlink commands
+ *
+ * Helper shared by nfsdctl and exportfs.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <string.h>
+
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+
+#include "xlog.h"
+#include "nfsdnl.h"
+
+#ifdef USE_SYSTEM_NFSD_NETLINK_H
+#include <linux/nfsd_netlink.h>
+#else
+#include "nfsd_netlink.h"
+#endif
+
+#define NFSDNL_BUFSIZE	(4096)
+
+static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
+			 void *arg)
+{
+	int *ret = arg;
+	*ret = err->error;
+	return NL_STOP;
+}
+
+static int finish_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+	*ret = 0;
+	return NL_SKIP;
+}
+
+static int ack_handler(struct nl_msg *msg __attribute__((unused)),
+		       void *arg)
+{
+	int *ret = arg;
+	*ret = 0;
+	return NL_STOP;
+}
+
+/**
+ * nfsd_nl_cmd_str - send an nfsd netlink command carrying a string attribute
+ * @cmd:   NFSD_CMD_* command number
+ * @attr:  NFSD_A_* attribute number
+ * @value: NUL-terminated string value for the attribute
+ *
+ * Returns 0 on success or a negative errno on failure.
+ */
+int nfsd_nl_cmd_str(int cmd, int attr, const char *value)
+{
+	struct genlmsghdr *ghdr;
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int family;
+	int ret;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -ENOMEM;
+	if (genl_connect(sock)) {
+		ret = -ECONNREFUSED;
+		goto out_sock;
+	}
+	nl_socket_set_buffer_size(sock, NFSDNL_BUFSIZE, NFSDNL_BUFSIZE);
+
+	family = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
+	if (family < 0) {
+		ret = family;
+		goto out_sock;
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		ret = -ENOMEM;
+		goto out_sock;
+	}
+	if (!genlmsg_put(msg, 0, 0, family, 0, 0, 0, 0)) {
+		ret = -ENOMEM;
+		goto out_msg;
+	}
+
+	ghdr = nlmsg_data(nlmsg_hdr(msg));
+	ghdr->cmd = (__u8)cmd;
+	nla_put_string(msg, attr, value);
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		ret = -ENOMEM;
+		goto out_msg;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0)
+		goto out_cb;
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+
+out_cb:
+	nl_cb_put(cb);
+out_msg:
+	nlmsg_free(msg);
+out_sock:
+	nl_socket_free(sock);
+	return ret;
+}
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 93f0bcd7ad56..768d2db7ea8f 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -39,6 +39,15 @@
 #include "xlog.h"
 #include "conffile.h"
 #include "reexport.h"
+#include "nfsdnl.h"
+
+#ifdef HAVE_NFSD_NETLINK
+#ifdef USE_SYSTEM_NFSD_NETLINK_H
+#include <linux/nfsd_netlink.h>
+#else
+#include "nfsd_netlink.h"
+#endif
+#endif
 
 #include <netlink/genl/genl.h>
 #include <netlink/genl/ctrl.h>
@@ -63,6 +72,7 @@ static void release_lockfile(void);
 
 static const char *lockfile = EXP_LOCKFILE;
 static int _lockfd = -1;
+static int f_unexport_all;
 
 /*
  * If we aren't careful, changes made by exportfs can be lost
@@ -246,7 +256,8 @@ main(int argc, char **argv)
 	 * don't care about what should be exported, as that
 	 * may require DNS lookups..
 	 */
-	if (! ( !f_export && f_all)) {
+	f_unexport_all = !f_export && f_all;
+	if (!f_unexport_all) {
 		/* note: xtab_*_read does not update entries if they already exist,
 		 * so this will not lose new options
 		 */
@@ -380,6 +391,26 @@ exportfs(char *arg, char *options, int verbose)
 		xlog(L_ERROR, "Invalid export syntax: %s", arg);
 }
 
+/*
+ * Check whether any active export remains for the given path across
+ * all client types.  Returns true if at least one export still has
+ * m_xtabent set.
+ */
+static int
+path_still_exported(const char *path, size_t nlen)
+{
+	nfs_export *exp;
+	int i;
+
+	for (i = 0; i < MCL_MAXTYPES; i++)
+		for (exp = exportlist[i].p_head; exp; exp = exp->m_next)
+			if (exp->m_xtabent &&
+			    strlen(exp->m_export.e_path) == nlen &&
+			    strncmp(path, exp->m_export.e_path, nlen) == 0)
+				return 1;
+	return 0;
+}
+
 static void
 unexportfs_parsed(char *hname, char *path, int verbose)
 {
@@ -434,9 +465,39 @@ unexportfs_parsed(char *hname, char *path, int verbose)
 		exp->m_mayexport = 0;
 		success = 1;
 	}
-	if (!success)
+	if (!success) {
 		xlog(L_ERROR, "Could not find '%s:%s' to unexport.", hname, path);
+		goto out;
+	}
 
+	/*
+	 * If no exports remain for this path, ask the kernel to
+	 * revoke any NFSv4 state and close cached file handles
+	 * associated with exports of this path.  This enables the
+	 * underlying filesystem to be unmounted.
+	 *
+	 * Skip this during "exportfs -ua" -- that is a shutdown
+	 * operation.  Clients should wait for nfsd to restart and
+	 * reclaim state through the grace period rather than
+	 * receiving NFS4ERR_ADMIN_REVOKED.
+	 */
+#ifdef HAVE_NFSD_NETLINK
+	if (!f_unexport_all && !path_still_exported(path, nlen)) {
+		char pathbuf[NFS_MAXPATHLEN + 1];
+		int ret;
+
+		memcpy(pathbuf, path, nlen);
+		pathbuf[nlen] = '\0';
+		ret = nfsd_nl_cmd_str(NFSD_CMD_UNLOCK_EXPORT,
+				      NFSD_A_UNLOCK_EXPORT_PATH,
+				      pathbuf);
+		if (ret && ret != -ENOSYS)
+			xlog(L_WARNING,
+			     "Failed to release state for %s: %s",
+			     pathbuf, strerror(-ret));
+	}
+#endif
+out:
 	nfs_freeaddrinfo(ai);
 }
 
diff --git a/utils/exportfs/exportfs.man b/utils/exportfs/exportfs.man
index 3737ee81ab27..b5e0c63a63f2 100644
--- a/utils/exportfs/exportfs.man
+++ b/utils/exportfs/exportfs.man
@@ -256,6 +256,23 @@ pair. This deletes the specified entry from
 .I /var/lib/nfs/etab
 and removes the corresponding kernel entry (if any).
 .PP
+When the last client for a given export path is unexported,
+.B exportfs
+signals the kernel to revoke NFSv4 state (opens, locks, and
+delegations) and release cached state for that path.
+Without this revocation, retained state would prevent the
+underlying filesystem from being unmounted.
+Affected clients receive
+.B NFS4ERR_ADMIN_REVOKED
+errors for operations that use revoked state.
+.PP
+.B "exportfs \-ua"
+does not revoke NFSv4 state, however.
+If
+.B nfsd
+is then restarted, clients may reclaim state during the
+grace period.
+.PP
 .SS Dumping the Export Table
 Invoking
 .B exportfs
-- 
2.53.0


