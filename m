Return-Path: <linux-nfs+bounces-19812-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAd6MuqoqWlSBwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19812-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:01:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF53215108
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8995D30F5803
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985CB33A6F8;
	Thu,  5 Mar 2026 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHbMdzj6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B12344DB5
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726400; cv=none; b=k4m4D5BrAx+9gyPWpmrIXGABSZ0v2k4j0A45T2IO/Ff5nPWLjdaFJbgz+MEnPdIW1TsS2ZB0GjKOd7V8d7PSPEWk3iiHI+BxO0R4gltKbfmLhzc6Dayli4VJGITGxHoQHnJA9UO7VqdxQ8YP3z9w6U0Y7xjmwgvlRiuNKkAFr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726400; c=relaxed/simple;
	bh=UnL+kaZ+XVVDXlUiCJ9OIugpSHmjjXrQeTIg5YwWNC4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhDVVJ4JCC7NdoVDXb1w3GK1qw7WQ83KoVn2nWJS4ClDnk6pXMMdbuLvzvuWw5m1lzq54grjMqlYrpq/5lACK/5vjbq2XunV7bEUDNP5GoxddLEHYPS5+8dzor+FRIv3mwX6ZPyq2uf8pKWEHkTC3IwlQBveu0P2kEliCON5CwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHbMdzj6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772726394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaMoGoZzXWljYzpkBdZLGKOsp6pBMmLdbHm7Qsy4BxU=;
	b=MHbMdzj68obTXwKOOd0MaDU64wxxKZaWZ1GUbp03acRdpwo34Ua3AxrBOmXemQRd1ZqZ4E
	shX+RIK3MpSyAsN3g4rP23rMUjoIWeABs+psKbQXkQD4KNMDekW4Avyv06lBMOozjkFDFn
	4v2Nh9Al31M1ZB3gk97QrPQOKT9b5BA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-X_Dkpf23OgiulQHoTKWgKg-1; Thu,
 05 Mar 2026 10:59:52 -0500
X-MC-Unique: X_Dkpf23OgiulQHoTKWgKg-1
X-Mimecast-MFC-AGG-ID: X_Dkpf23OgiulQHoTKWgKg_1772726391
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D706318005B8
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:51 +0000 (UTC)
Received: from bighat.com (steved-laptop.mht.redhat.com [10.17.16.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FD53180075E
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:51 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 4/4] Fix access checks when mounting subdirectories in NFSv3
Date: Thu,  5 Mar 2026 10:59:48 -0500
Message-ID: <20260305155948.11261-5-steved@redhat.com>
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
X-Rspamd-Queue-Id: 7AF53215108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-19812-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[smayhew.redhat.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:email]
X-Rspamd-Action: no action

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a NFSv3 client asks to mount a subdirectory of one of the exported
directories, then apply the RPC credential together with any root
or all squash rules that would apply to the client in question.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 nfs.conf                    |  1 +
 support/include/nfsd_path.h |  9 ++++++++-
 support/misc/nfsd_path.c    | 32 ++++++++++++++++++++++++++++++--
 utils/mountd/mountd.c       | 28 ++++++++++++++++++++++++++--
 utils/mountd/mountd.man     | 26 ++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 3cca68c3..ddf0c143 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -46,6 +46,7 @@
 # ttl=1800
 [mountd]
 # debug="all|auth|call|general|parse"
+# apply-root-cred=n
 # manage-gids=n
 # descriptors=0
 # port=0
diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index 3e5a2f5d..06c0f2f4 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -9,6 +9,7 @@
 struct file_handle;
 struct statfs;
 struct nfsd_task_t;
+struct nfs_ucred;
 
 void 		nfsd_path_init(void);
 
@@ -18,7 +19,8 @@ char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
 
 int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
 int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
-int		nfsd_openat(int dirfd, const char *path, int flags);
+int		nfsd_cred_openat(const struct nfs_ucred *cred, int dirfd,
+				 const char *path, int flags);
 
 int		nfsd_path_statfs(const char *pathname,
 				   struct statfs *statbuf);
@@ -31,4 +33,9 @@ ssize_t		nfsd_path_write(int fd, void* buf, size_t len);
 int		nfsd_name_to_handle_at(int fd, const char *path,
 				       struct file_handle *fh,
 				       int *mount_id, int flags);
+
+static inline int nfsd_openat(int dirfd, const char *path, int flags)
+{
+	return nfsd_cred_openat(NULL, dirfd, path, flags);
+}
 #endif
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index dfe88e4f..6466666d 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -17,6 +17,7 @@
 #include "xstat.h"
 #include "nfslib.h"
 #include "nfsd_path.h"
+#include "nfs_ucred.h"
 #include "workqueue.h"
 
 static struct xthread_workqueue *nfsd_wq = NULL;
@@ -204,6 +205,7 @@ nfsd_realpath(const char *path, char *resolved_buf)
 }
 
 struct nfsd_openat_t {
+	const struct nfs_ucred *cred;
 	const char *path;
 	int dirfd;
 	int flags;
@@ -220,15 +222,41 @@ static void nfsd_openatfunc(void *data)
 		d->res_error = errno;
 }
 
-int nfsd_openat(int dirfd, const char *path, int flags)
+static void nfsd_cred_openatfunc(void *data)
+{
+	struct nfsd_openat_t *d = data;
+	struct nfs_ucred *saved = NULL;
+	int ret;
+
+	ret = nfs_ucred_swap_effective(d->cred, &saved);
+	if (ret != 0) {
+		d->res_fd = -1;
+		d->res_error = ret;
+		return;
+	}
+
+	nfsd_openatfunc(data);
+
+	if (saved != NULL) {
+		nfs_ucred_swap_effective(saved, NULL);
+		nfs_ucred_free(saved);
+	}
+}
+
+int nfsd_cred_openat(const struct nfs_ucred *cred, int dirfd, const char *path,
+		     int flags)
 {
 	struct nfsd_openat_t open_buf = {
+		.cred = cred,
 		.path = path,
 		.dirfd = dirfd,
 		.flags = flags,
 	};
 
-	nfsd_run_task(nfsd_openatfunc, &open_buf);
+	if (cred)
+		nfsd_run_task(nfsd_cred_openatfunc, &open_buf);
+	else
+		nfsd_run_task(nfsd_openatfunc, &open_buf);
 	if (open_buf.res_fd == -1)
 		errno = open_buf.res_error;
 	return open_buf.res_fd;
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index f43ebef5..6e6777cd 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -31,6 +31,7 @@
 #include "nfsd_path.h"
 #include "nfslib.h"
 #include "export.h"
+#include "nfs_ucred.h"
 
 extern void my_svc_run(void);
 
@@ -40,6 +41,7 @@ static struct nfs_fh_len *get_rootfh(struct svc_req *, dirpath *, nfs_export **,
 
 int reverse_resolve = 0;
 int manage_gids;
+int apply_root_cred;
 int use_ipaddr = -1;
 
 /* PRC: a high-availability callout program can be specified with -H
@@ -74,9 +76,10 @@ static struct option longopts[] =
 	{ "log-auth", 0, 0, 'l'},
 	{ "cache-use-ipaddr", 0, 0, 'i'},
 	{ "ttl", 1, 0, 'T'},
+	{ "apply-root-cred", 0, 0, 'c' },
 	{ NULL, 0, 0, 0 }
 };
-static char shortopts[] = "o:nFd:p:P:hH:N:V:vurs:t:gliT:";
+static char shortopts[] = "o:nFd:p:P:hH:N:V:vurs:t:gliT:c";
 
 #define NFSVERSBIT(vers)	(0x1 << (vers - 1))
 #define NFSVERSBIT_ALL		(NFSVERSBIT(2) | NFSVERSBIT(3) | NFSVERSBIT(4))
@@ -453,11 +456,27 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 	while (*subpath == '/')
 		subpath++;
 	if (*subpath != '\0') {
+		struct nfs_ucred *cred = NULL;
 		int fd;
 
+		/* Load the user cred */
+		if (!apply_root_cred) {
+			nfs_ucred_get(&cred, rqstp, &exp->m_export);
+			if (cred == NULL) {
+				xlog(L_WARNING, "can't retrieve credential");
+				*error = MNT3ERR_ACCES;
+				close(dirfd);
+				return NULL;
+			}
+			if (manage_gids)
+				nfs_ucred_reload_groups(cred, &exp->m_export);
+		}
+
 		/* Just perform a lookup of the path */
-		fd = nfsd_openat(dirfd, subpath, O_PATH);
+		fd = nfsd_cred_openat(cred, dirfd, subpath, O_PATH);
 		close(dirfd);
+		if (cred)
+			nfs_ucred_free(cred);
 		if (fd == -1) {
 			xlog(L_WARNING, "can't open exported dir %s: %s", p,
 			     strerror(errno));
@@ -681,6 +700,8 @@ read_mountd_conf(char **argv)
 	ttl = conf_get_num("mountd", "ttl", default_ttl);
 	if (ttl > 0)
 		default_ttl = ttl;
+	apply_root_cred = conf_get_bool("mountd", "apply-root-cred",
+					apply_root_cred);
 }
 
 int
@@ -794,6 +815,9 @@ main(int argc, char **argv)
 			}
 			default_ttl = ttl;
 			break;
+		case 'c':
+			apply_root_cred = 1;
+			break;
 		case 0:
 			break;
 		case '?':
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index a206a3e2..f4f1fc23 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -242,6 +242,32 @@ can support both NFS version 2 and the newer version 3.
 Print the version of
 .B rpc.mountd
 and exit.
+.TP
+.B \-c " or " \-\-apply-root-cred
+When mountd is asked to allow a NFSv3 mount to a subdirectory of the
+exported directory, then it will check if the user asking to mount has
+lookup rights to the directories below that exported directory. When
+performing the check, mountd will apply any root squash or all squash
+rules that were specified for that client.
+
+Performing lookup checks as the user requires that the mountd daemon
+be run as root or that it be given CAP_SETUID and CAP_SETGID privileges
+so that it can change its own effective user and effective group settings.
+When troubleshooting, please also note that LSM frameworks such as SELinux
+can sometimes prevent the daemon from changing the effective user/groups
+despite the capability settings.
+
+In earlier versions of mountd, the same checks were performed using the
+mountd daemon's root privileges, meaning that it could authorise access
+to directories that are not normally accessible to the user requesting
+to mount them. This option enables that legacy behaviour.
+
+.BR Note:
+If there is a need to provide access to specific subdirectories that
+are not normally accessible to a client, it is always possible to add
+export entries that explicitly grant such access. That ability does
+not depend on this option being enabled.
+
 .TP
 .B \-g " or " \-\-manage-gids
 Accept requests from the kernel to map user id numbers into  lists of
-- 
2.53.0


