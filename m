Return-Path: <linux-nfs+bounces-19813-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEytFumoqWlSBwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19813-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:01:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F4C215110
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96BFA303FFD1
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA93C6A2E;
	Thu,  5 Mar 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXv+RHmU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81333031F
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726400; cv=none; b=bEBqgRCZ5hiRy2UHhE+FPeMebOg3s9gs9HQXC8H+6opASl0WnqFjryIIhYC9eJuJHfWpiy5dqXylZFBxp/SDDDln38Y/tSO6KPz9oPOUGbZoTndzyNRznUiDr6D22Td6P7AGOcP2+zzeZNwCGutHbIgTji1i1MX/FDjUROZMhoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726400; c=relaxed/simple;
	bh=a89QkGaMXwDvy/+yJKHP8sAF5Yyy57Xm407l/t2Qnwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXTt0k2mzGG0tPe3RQqkWc4UQ4FPqkcrTwpjuGJ6DMi1zGT01jyk5IJcrMN+i0lea07hNDBqkFAibJ6B8bXercyWT+ygeyW/OUijHk/7sT0dS7vixbQvD5SpgOcSF1JkJ9jkk1lmcA6bMXsWtZyw9MrXYPfXysFHvavk4aZJrZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXv+RHmU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772726393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ql3jB6SyHWVtT/SNvRiRMC8h4oUhLXxsYSuHIO+IE6k=;
	b=eXv+RHmUhJ4bmb434abEbA0l5+83y6oUc3uHtXzMJit6+5UmUiOwMJJAm+Auz2cYj+QS6n
	EistugOFwqqE+a7yH/URBZ4Qp3YnrE/OUb/B3kT4drTwuaS9VDfqOIS/9Tn/PrfsFZqDHB
	XCp9bfaO23zuxHGm5k8YH+DISOwgmr0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-IJFX-rGnP4-t7Kmpey34eg-1; Thu,
 05 Mar 2026 10:59:52 -0500
X-MC-Unique: IJFX-rGnP4-t7Kmpey34eg-1
X-Mimecast-MFC-AGG-ID: IJFX-rGnP4-t7Kmpey34eg_1772726391
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C00B1956089
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:51 +0000 (UTC)
Received: from bighat.com (steved-laptop.mht.redhat.com [10.17.16.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E95B81800673
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:50 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/4] support: Add a mini-library to extract and apply RPC credentials
Date: Thu,  5 Mar 2026 10:59:47 -0500
Message-ID: <20260305155948.11261-4-steved@redhat.com>
In-Reply-To: <20260305155948.11261-1-steved@redhat.com>
References: <20260305155948.11261-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 52F4C215110
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19813-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.993];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:email,libnfsconf.la:url]
X-Rspamd-Action: no action

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add server functionality to extract the credentials from the client RPC
call, and apply them. This is needed in order to perform access checking
on the requested path in the mountd daemon.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 aclocal/libtirpc.m4         |  12 +++
 support/include/Makefile.am |   1 +
 support/include/nfs_ucred.h |  44 ++++++++++
 support/misc/Makefile.am    |   2 +-
 support/misc/ucred.c        | 162 ++++++++++++++++++++++++++++++++++++
 support/nfs/Makefile.am     |   2 +-
 support/nfs/ucred.c         | 147 ++++++++++++++++++++++++++++++++
 7 files changed, 368 insertions(+), 2 deletions(-)
 create mode 100644 support/include/nfs_ucred.h
 create mode 100644 support/misc/ucred.c
 create mode 100644 support/nfs/ucred.c

diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
index ef48a2ae..06629db9 100644
--- a/aclocal/libtirpc.m4
+++ b/aclocal/libtirpc.m4
@@ -31,6 +31,18 @@ AC_DEFUN([AC_LIBTIRPC], [
                          [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1],
                                     [Define to 1 if your tirpc library provides rpc_gss_seccreate])],,
                          [${LIBS}])])
+
+     AS_IF([test -n "${LIBTIRPC}"],
+           [AC_CHECK_LIB([tirpc], [rpc_gss_getcred],
+                         [AC_DEFINE([HAVE_TIRPC_GSS_GETCRED], [1],
+                                    [Define to 1 if your tirpc library provides rpc_gss_getcred])],,
+                         [${LIBS}])])
+
+     AS_IF([test -n "${LIBTIRPC}"],
+           [AC_CHECK_LIB([tirpc], [authdes_getucred],
+                         [AC_DEFINE([HAVE_TIRPC_AUTHDES_GETUCRED], [1],
+                                    [Define to 1 if your tirpc library provides authdes_getucred])],,
+                         [${LIBS}])])
   AC_SUBST([AM_CPPFLAGS])
   AC_SUBST(LIBTIRPC)
 
diff --git a/support/include/Makefile.am b/support/include/Makefile.am
index 1373891a..631a84f8 100644
--- a/support/include/Makefile.am
+++ b/support/include/Makefile.am
@@ -10,6 +10,7 @@ noinst_HEADERS = \
 	misc.h \
 	nfs_mntent.h \
 	nfs_paths.h \
+	nfs_ucred.h \
 	nfsd_path.h \
 	nfslib.h \
 	nfsrpc.h \
diff --git a/support/include/nfs_ucred.h b/support/include/nfs_ucred.h
new file mode 100644
index 00000000..d58b61e4
--- /dev/null
+++ b/support/include/nfs_ucred.h
@@ -0,0 +1,44 @@
+#ifndef _NFS_UCRED_H
+#define _NFS_UCRED_H
+
+#include <sys/types.h>
+
+struct nfs_ucred {
+	uid_t uid;
+	gid_t gid;
+	int ngroups;
+	gid_t *groups;
+};
+
+struct svc_req;
+struct exportent;
+
+int nfs_ucred_get(struct nfs_ucred **credp, struct svc_req *rqst,
+		  const struct exportent *ep);
+
+void nfs_ucred_squash_groups(struct nfs_ucred *cred,
+			     const struct exportent *ep);
+int nfs_ucred_reload_groups(struct nfs_ucred *cred, const struct exportent *ep);
+int nfs_ucred_swap_effective(const struct nfs_ucred *cred,
+			     struct nfs_ucred **savedp);
+
+static inline void nfs_ucred_free(struct nfs_ucred *cred)
+{
+	free(cred->groups);
+	free(cred);
+}
+
+static inline void nfs_ucred_init_groups(struct nfs_ucred *cred, gid_t *groups,
+					 int ngroups)
+{
+	cred->groups = groups;
+	cred->ngroups = ngroups;
+}
+
+static inline void nfs_ucred_free_groups(struct nfs_ucred *cred)
+{
+	free(cred->groups);
+	nfs_ucred_init_groups(cred, NULL, 0);
+}
+
+#endif /* _NFS_UCRED_H */
diff --git a/support/misc/Makefile.am b/support/misc/Makefile.am
index f9993e3a..7ea2d798 100644
--- a/support/misc/Makefile.am
+++ b/support/misc/Makefile.am
@@ -2,6 +2,6 @@
 
 noinst_LIBRARIES = libmisc.a
 libmisc_a_SOURCES = tcpwrapper.c from_local.c mountpoint.c file.c \
-		    nfsd_path.c workqueue.c xstat.c
+		    nfsd_path.c ucred.c workqueue.c xstat.c
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/support/misc/ucred.c b/support/misc/ucred.c
new file mode 100644
index 00000000..92d97912
--- /dev/null
+++ b/support/misc/ucred.c
@@ -0,0 +1,162 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <alloca.h>
+#include <errno.h>
+#include <pwd.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <grp.h>
+
+#include "exportfs.h"
+#include "nfs_ucred.h"
+
+#include "xlog.h"
+
+void nfs_ucred_squash_groups(struct nfs_ucred *cred, const struct exportent *ep)
+{
+	int i;
+
+	if (!(ep->e_flags & NFSEXP_ROOTSQUASH))
+		return;
+	if (cred->gid == 0)
+		cred->gid = ep->e_anongid;
+	for (i = 0; i < cred->ngroups; i++) {
+		if (cred->groups[i] == 0)
+			cred->groups[i] = ep->e_anongid;
+	}
+}
+
+static int nfs_ucred_init_effective(struct nfs_ucred *cred)
+{
+	int ngroups = getgroups(0, NULL);
+
+	if (ngroups > 0) {
+		size_t sz = ngroups * sizeof(gid_t);
+		gid_t *groups = malloc(sz);
+		if (groups == NULL)
+			return ENOMEM;
+		if (getgroups(ngroups, groups) == -1) {
+			free(groups);
+			return errno;
+		}
+		nfs_ucred_init_groups(cred, groups, ngroups);
+	} else
+		nfs_ucred_init_groups(cred, NULL, 0);
+	cred->uid = geteuid();
+	cred->gid = getegid();
+	return 0;
+}
+
+static size_t nfs_ucred_getpw_r_size_max(void)
+{
+	long buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+
+	if (buflen == -1)
+		return 16384;
+	return buflen;
+}
+
+int nfs_ucred_reload_groups(struct nfs_ucred *cred, const struct exportent *ep)
+{
+	struct passwd pwd, *pw;
+	uid_t uid = cred->uid;
+	gid_t gid = cred->gid;
+	size_t buflen;
+	char *buf;
+	int ngroups = 0;
+	int ret;
+
+	if (ep->e_flags & (NFSEXP_ALLSQUASH | NFSEXP_ROOTSQUASH) &&
+	    (int)uid == ep->e_anonuid)
+		return 0;
+	buflen = nfs_ucred_getpw_r_size_max();
+	buf = alloca(buflen);
+	ret = getpwuid_r(uid, &pwd, buf, buflen, &pw);
+	if (ret != 0)
+		return ret;
+	if (!pw)
+		return ENOENT;
+	if (getgrouplist(pw->pw_name, gid, NULL, &ngroups) == -1 &&
+	    ngroups > 0) {
+		gid_t *groups = malloc(ngroups * sizeof(groups[0]));
+		if (groups == NULL)
+			return ENOMEM;
+		if (getgrouplist(pw->pw_name, gid, groups, &ngroups) == -1) {
+			free(groups);
+			return ENOMEM;
+		}
+		free(cred->groups);
+		nfs_ucred_init_groups(cred, groups, ngroups);
+		nfs_ucred_squash_groups(cred, ep);
+	} else
+		nfs_ucred_free_groups(cred);
+	return 0;
+}
+
+static int nfs_ucred_set_effective(const struct nfs_ucred *cred,
+				   const struct nfs_ucred *saved)
+{
+	uid_t suid = saved ? saved->uid : geteuid();
+	gid_t sgid = saved ? saved->gid : getegid();
+	int ret;
+
+	/* Start with a privileged effective user */
+	if (setresuid(-1, 0, -1) < 0) {
+		xlog(L_WARNING, "can't change privileged user %u-%u. %s",
+		     geteuid(), getegid(), strerror(errno));
+		return errno;
+	}
+
+	if (setgroups(cred->ngroups, cred->groups) == -1) {
+		xlog(L_WARNING, "can't change groups for user %u-%u. %s",
+		     geteuid(), getegid(), strerror(errno));
+		return errno;
+	}
+	if (setresgid(-1, cred->gid, sgid) == -1) {
+		xlog(L_WARNING, "can't change gid for user %u-%u. %s",
+		     geteuid(), getegid(), strerror(errno));
+		ret = errno;
+		goto restore_groups;
+	}
+	if (setresuid(-1, cred->uid, suid) == -1) {
+		xlog(L_WARNING, "can't change uid for user %u-%u. %s",
+		     geteuid(), getegid(), strerror(errno));
+		ret = errno;
+		goto restore_gid;
+	}
+	return 0;
+restore_gid:
+	if (setresgid(-1, sgid, -1) < 0) {
+		xlog(L_WARNING, "can't restore privileged user %u-%u. %s",
+		     geteuid(), getegid(), strerror(errno));
+	}
+restore_groups:
+	if (saved)
+		setgroups(saved->ngroups, saved->groups);
+	else
+		setgroups(0, NULL);
+	return ret;
+}
+
+int nfs_ucred_swap_effective(const struct nfs_ucred *cred,
+			     struct nfs_ucred **savedp)
+{
+	struct nfs_ucred *saved = malloc(sizeof(*saved));
+	int ret;
+
+	if (saved == NULL)
+		return ENOMEM;
+	ret = nfs_ucred_init_effective(saved);
+	if (ret != 0) {
+		free(saved);
+		return ret;
+	}
+	ret = nfs_ucred_set_effective(cred, saved);
+	if (savedp == NULL || ret != 0)
+		nfs_ucred_free(saved);
+	else
+		*savedp = saved;
+	return ret;
+}
diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
index 2e1577cc..f6921265 100644
--- a/support/nfs/Makefile.am
+++ b/support/nfs/Makefile.am
@@ -7,7 +7,7 @@ libnfs_la_SOURCES = exports.c rmtab.c xio.c rpcmisc.c rpcdispatch.c \
 		   xcommon.c wildmat.c mydaemon.c \
 		   rpc_socket.c getport.c \
 		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
-		   svc_create.c atomicio.c strlcat.c strlcpy.c
+		   svc_create.c atomicio.c strlcat.c strlcpy.c ucred.c
 libnfs_la_LIBADD = libnfsconf.la
 libnfs_la_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
 
diff --git a/support/nfs/ucred.c b/support/nfs/ucred.c
new file mode 100644
index 00000000..6ea8efdf
--- /dev/null
+++ b/support/nfs/ucred.c
@@ -0,0 +1,147 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <rpc/rpc.h>
+
+#include "exportfs.h"
+#include "nfs_ucred.h"
+
+#ifdef HAVE_TIRPC_GSS_GETCRED
+#include <rpc/rpcsec_gss.h>
+#endif /* HAVE_TIRPC_GSS_GETCRED */
+#ifdef HAVE_TIRPC_AUTHDES_GETUCRED
+#include <rpc/auth_des.h>
+#endif /* HAVE_TIRPC_AUTHDES_GETUCRED */
+
+static int nfs_ucred_copy_cred(struct nfs_ucred *cred, uid_t uid, gid_t gid,
+			       const gid_t *groups, int ngroups)
+{
+	if (ngroups > 0) {
+		size_t sz = ngroups * sizeof(groups[0]);
+		cred->groups = malloc(sz);
+		if (cred->groups == NULL)
+			return ENOMEM;
+		cred->ngroups = ngroups;
+		memcpy(cred->groups, groups, sz);
+	} else
+		nfs_ucred_init_groups(cred, NULL, 0);
+	cred->uid = uid;
+	cred->gid = gid;
+	return 0;
+}
+
+static int nfs_ucred_init_cred_squashed(struct nfs_ucred *cred,
+					const struct exportent *ep)
+{
+	cred->uid = ep->e_anonuid;
+	cred->gid = ep->e_anongid;
+	nfs_ucred_init_groups(cred, NULL, 0);
+	return 0;
+}
+
+static int nfs_ucred_init_cred(struct nfs_ucred *cred, uid_t uid, gid_t gid,
+			       const gid_t *groups, int ngroups,
+			       const struct exportent *ep)
+{
+	if (ep->e_flags & NFSEXP_ALLSQUASH) {
+		nfs_ucred_init_cred_squashed(cred, ep);
+	} else if (ep->e_flags & NFSEXP_ROOTSQUASH && uid == 0) {
+		nfs_ucred_init_cred_squashed(cred, ep);
+		if (gid != 0)
+			cred->gid = gid;
+	} else {
+		int ret = nfs_ucred_copy_cred(cred, uid, gid, groups, ngroups);
+		if (ret != 0)
+			return ret;
+		nfs_ucred_squash_groups(cred, ep);
+	}
+	return 0;
+}
+
+static int nfs_ucred_init_null(struct nfs_ucred *cred,
+			       const struct exportent *ep)
+{
+	return nfs_ucred_init_cred_squashed(cred, ep);
+}
+
+static int nfs_ucred_init_unix(struct nfs_ucred *cred, struct svc_req *rqst,
+			       const struct exportent *ep)
+{
+	struct authunix_parms *aup;
+
+	aup = (struct authunix_parms *)rqst->rq_clntcred;
+	return nfs_ucred_init_cred(cred, aup->aup_uid, aup->aup_gid,
+				   aup->aup_gids, aup->aup_len, ep);
+}
+
+#ifdef HAVE_TIRPC_GSS_GETCRED
+static int nfs_ucred_init_gss(struct nfs_ucred *cred, struct svc_req *rqst,
+			      const struct exportent *ep)
+{
+	rpc_gss_ucred_t *gss_ucred = NULL;
+
+	if (!rpc_gss_getcred(rqst, NULL, &gss_ucred, NULL) || gss_ucred == NULL)
+		return EINVAL;
+	return nfs_ucred_init_cred(cred, gss_ucred->uid, gss_ucred->gid,
+				   gss_ucred->gidlist, gss_ucred->gidlen, ep);
+}
+#endif /* HAVE_TIRPC_GSS_GETCRED */
+
+#ifdef HAVE_TIRPC_AUTHDES_GETUCRED
+int authdes_getucred(struct authdes_cred *adc, uid_t *uid, gid_t *gid,
+		     int *grouplen, gid_t *groups);
+
+static int nfs_ucred_init_des(struct nfs_ucred *cred, struct svc_req *rqst,
+			      const struct exportent *ep)
+{
+	struct authdes_cred *des_cred;
+	uid_t uid;
+	gid_t gid;
+	int grouplen;
+	gid_t groups[NGROUPS];
+
+	des_cred = (struct authdes_cred *)rqst->rq_clntcred;
+	if (!authdes_getucred(des_cred, &uid, &gid, &grouplen, &groups[0]))
+		return EINVAL;
+	return nfs_ucred_init_cred(cred, uid, gid, groups, grouplen, ep);
+}
+#endif /* HAVE_TIRPC_AUTHDES_GETUCRED */
+
+int nfs_ucred_get(struct nfs_ucred **credp, struct svc_req *rqst,
+		  const struct exportent *ep)
+{
+	struct nfs_ucred *cred = malloc(sizeof(*cred));
+	int ret;
+
+	*credp = NULL;
+	if (cred == NULL)
+		return ENOMEM;
+	switch (rqst->rq_cred.oa_flavor) {
+	case AUTH_UNIX:
+		ret = nfs_ucred_init_unix(cred, rqst, ep);
+		break;
+#ifdef HAVE_TIRPC_GSS_GETCRED
+	case RPCSEC_GSS:
+		ret = nfs_ucred_init_gss(cred, rqst, ep);
+		break;
+#endif /* HAVE_TIRPC_GSS_GETCRED */
+#ifdef HAVE_TIRPC_AUTHDES_GETUCRED
+	case AUTH_DES:
+		ret = nfs_ucred_init_des(cred, rqst, ep);
+		break;
+#endif /* HAVE_TIRPC_AUTHDES_GETUCRED */
+	default:
+		ret = nfs_ucred_init_null(cred, ep);
+		break;
+	}
+	if (ret == 0) {
+		*credp = cred;
+		return 0;
+	}
+	free(cred);
+	return ret;
+}
-- 
2.53.0


