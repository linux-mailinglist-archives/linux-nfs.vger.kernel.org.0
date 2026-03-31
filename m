Return-Path: <linux-nfs+bounces-20564-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H+AA3grzGkmQgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20564-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:15:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1E9371156
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A1F307713C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92043DA49;
	Tue, 31 Mar 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWxqLEly"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89E3BED6F
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987867; cv=none; b=Vq/Ol1cVE83aW2GnefeCJlKtbJk601TMv6hwtP1l5esQrPy0jcQhcyVSo3Jen3z/p/WppJnbFQcLxEEwWm4VkLnPaaxvJLpnAZBYpYK9JgtLkN3iSKisPLtb4r607s7NDl7XpqpOneZPvCmFmJvWrjOZh2SmVfcigyvWA3ZtKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987867; c=relaxed/simple;
	bh=cmDfW89AuFIZ58ZQXLN2jjVZ9RGYSm6Fz3smuQD6LGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTuEjjfMzYOwD6LbSPmvVHixioFOF5QVOqDjr9hgbpBPsoz2EJXdQe9odr+QHqhBoWAAkX5ZhlZLDcs4ZUt1Opeb4Hbx5VKqqxW6rXsN8dlSLKc/OGs3QBE9e+dhk7BiGEWkmN6JyuxERhjAk+bO/Ok+DfhlCLvR6ZrXWgARc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWxqLEly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4B8C19423;
	Tue, 31 Mar 2026 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987866;
	bh=cmDfW89AuFIZ58ZQXLN2jjVZ9RGYSm6Fz3smuQD6LGI=;
	h=From:To:Cc:Subject:Date:From;
	b=NWxqLElyGN4mhTcHBUHzoLA2/UBSvDWEUxle5Cr/v9VqOkGYFWIS7A1qaBG7+F+6W
	 0xYUi9UGAmuHwAHKFbV9gC52SRoGxjRz+fuWeEUABMhFHOjJ2OHbYBkdvai3S8IOpQ
	 FOeau1tp3iloCFSrORNS5LuClCPEfW/53vnc4crOXjP+6LTxfVJqyKR+/0UEZZzmd6
	 MuZ6BnPEVm1em5kqrLcrOYCbWqFD01wVxrD/nyRZNAnAdPeWhb1tgWn8HMLTkoIVxa
	 4RwsDV5aVYeoIIWZi/tqDgE7Ur4GXvqPIEFoVCAlMsQ4Q7ikGH44HWG9KTpOL6lMUc
	 QPMtR3eXlzLqQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] exportfs: release NFSv4 state when last client is unexported
Date: Tue, 31 Mar 2026 16:11:01 -0400
Message-ID: <20260331201102.3002279-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20564-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makefile.in:url,oracle.com:email,libnfsconf.la:url,configure.ac:url]
X-Rspamd-Queue-Id: 5F1E9371156
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
 configure.ac                 |  2 ++
 support/nfs/Makefile.am      |  7 ++++
 utils/exportfs/Makefile.am   |  3 +-
 utils/exportfs/exportfs.c    | 65 ++++++++++++++++++++++++++++++++++--
 utils/exportfs/exportfs.man  | 17 ++++++++++
 utils/nfsdctl/nfsd_netlink.h | 24 +++++++++++++
 6 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index ceae6b2406a6..ee429bade661 100644
--- a/configure.ac
+++ b/configure.ac
@@ -262,6 +262,8 @@ AC_ARG_ENABLE(nfsdctl,
 		PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
 		PKG_CHECK_MODULES(LIBREADLINE, readline)
 		AC_CHECK_HEADERS(linux/nfsd_netlink.h)
+		AC_DEFINE([HAVE_NFSD_NETLINK], 1,
+			  [Define to 1 if nfsd generic netlink support is available])
 
 		# ensure we have the MIN_THREADS attribute
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
index 2e1577cc12df..cfb14e94328c 100644
--- a/support/nfs/Makefile.am
+++ b/support/nfs/Makefile.am
@@ -11,6 +11,13 @@ libnfs_la_SOURCES = exports.c rmtab.c xio.c rpcmisc.c rpcdispatch.c \
 libnfs_la_LIBADD = libnfsconf.la
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
diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
index 7f8ce9faf2b4..57f2503b32eb 100644
--- a/utils/exportfs/Makefile.am
+++ b/utils/exportfs/Makefile.am
@@ -13,6 +13,7 @@ exportfs_LDADD = ../../support/export/libexport.a \
 		 ../../support/reexport/libreexport.a \
 		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
 
-exportfs_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
+exportfs_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport \
+		    -I$(top_srcdir)/utils/nfsdctl
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 748c38e3e966..2983d450143e 100644
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
 
 static void	export_all(int verbose);
 static void	exportfs(char *arg, char *options, int verbose);
@@ -52,6 +61,7 @@ static void release_lockfile(void);
 
 static const char *lockfile = EXP_LOCKFILE;
 static int _lockfd = -1;
+static int f_unexport_all;
 
 /*
  * If we aren't careful, changes made by exportfs can be lost
@@ -229,7 +239,8 @@ main(int argc, char **argv)
 	 * don't care about what should be exported, as that
 	 * may require DNS lookups..
 	 */
-	if (! ( !f_export && f_all)) {
+	f_unexport_all = !f_export && f_all;
+	if (!f_unexport_all) {
 		/* note: xtab_*_read does not update entries if they already exist,
 		 * so this will not lose new options
 		 */
@@ -363,6 +374,26 @@ exportfs(char *arg, char *options, int verbose)
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
@@ -417,9 +448,39 @@ unexportfs_parsed(char *hname, char *path, int verbose)
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
index 6d417a700340..d720b30451b0 100644
--- a/utils/exportfs/exportfs.man
+++ b/utils/exportfs/exportfs.man
@@ -239,6 +239,23 @@ pair. This deletes the specified entry from
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
diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
index e9efbc9e63d8..78d52c210d86 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -80,6 +80,27 @@ enum {
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
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -90,6 +111,9 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_UNLOCK_IP,
+	NFSD_CMD_UNLOCK_FILESYSTEM,
+	NFSD_CMD_UNLOCK_EXPORT,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
-- 
2.53.0


