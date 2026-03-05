Return-Path: <linux-nfs+bounces-19811-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHDvAeeoqWlSBwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19811-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:01:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECA4215100
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 204E430F05FE
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0539E3CCA1B;
	Thu,  5 Mar 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDZd1Rh7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD73B3CC9EE
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726398; cv=none; b=eH23k/uxvunf1ycIt893ejv1mdWoNHBLWXOjiNGzSxHMEjv9bJqhE2p6VGOj/j80f94YVtUnjh0ldx9jw3/KPU8i0EN1vc5VXNy/k9BrqcgqjAAl+isDRmp8m19htP4hvxX/oDZFkf6LA9wFf6qRUGWFg7bJda0VFOMnOsIDLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726398; c=relaxed/simple;
	bh=jFrRp26gdvZIdgylJiG6JabpXDQ83LO59SqvdIMcl3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3TVKHaRE8J8oob0OJ5Iz/aoVXj7RRedTKhabjc/pif9jXLKfzZHjMy///531xScK9xGQdKKmfWeGZMKMentE5+fq2G0u/v/ZzS8b68Zy7XRRJ52PV9rDrbA+Hk7Bbkf1r9TvHRikN+hCgVpq6SU9HVnVZhQP2lpnuuCuXflQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDZd1Rh7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772726392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jds170lnA0+WQmLGSxz9Puo1DGtiCKEBLNekRRYbYyA=;
	b=PDZd1Rh7zM2TPRnongL/iX5xB2hlP6xD+BnbNYrIaLsYkGBXFxAb/0CN8z3xJReqzlQMVj
	4KL7d4tVbVLeYKKUp26ukGlVL+9qCzQxphTpXgfWtg2haVleONziewnVpehH557GEok8aZ
	E8ZWBH3miPuPE5svUUCSV0To+02zsK0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-NL0har8OMt6FlDrhzatKgw-1; Thu,
 05 Mar 2026 10:59:51 -0500
X-MC-Unique: NL0har8OMt6FlDrhzatKgw-1
X-Mimecast-MFC-AGG-ID: NL0har8OMt6FlDrhzatKgw_1772726390
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE746195608F
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:50 +0000 (UTC)
Received: from bighat.com (steved-laptop.mht.redhat.com [10.17.16.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58424180075F
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:59:50 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/4] mountd: Separate lookup of the exported directory and the mount path
Date: Thu,  5 Mar 2026 10:59:46 -0500
Message-ID: <20260305155948.11261-3-steved@redhat.com>
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
X-Rspamd-Queue-Id: 9ECA4215100
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
	TAGGED_FROM(0.00)[bounces-19811-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jlayton.kernel.org:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When the caller asks to mount a path that does not terminate with an
exported directory, we want to split up the lookups so that we can
look up the exported directory using the mountd privileged credential,
and the remaining subdirectory lookups using the RPC caller's
credential.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/include/nfsd_path.h |  1 +
 support/misc/nfsd_path.c    | 31 ++++++++++++++++++
 utils/mountd/mountd.c       | 63 +++++++++++++++++++++++++++++++------
 3 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index f600fb5a..3e5a2f5d 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -18,6 +18,7 @@ char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
 
 int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
 int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
+int		nfsd_openat(int dirfd, const char *path, int flags);
 
 int		nfsd_path_statfs(const char *pathname,
 				   struct statfs *statbuf);
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index caec33ca..dfe88e4f 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -203,6 +203,37 @@ nfsd_realpath(const char *path, char *resolved_buf)
         return realpath_buf.res_ptr;
 }
 
+struct nfsd_openat_t {
+	const char *path;
+	int dirfd;
+	int flags;
+	int res_fd;
+	int res_error;
+};
+
+static void nfsd_openatfunc(void *data)
+{
+	struct nfsd_openat_t *d = data;
+
+	d->res_fd = openat(d->dirfd, d->path, d->flags);
+	if (d->res_fd == -1)
+		d->res_error = errno;
+}
+
+int nfsd_openat(int dirfd, const char *path, int flags)
+{
+	struct nfsd_openat_t open_buf = {
+		.path = path,
+		.dirfd = dirfd,
+		.flags = flags,
+	};
+
+	nfsd_run_task(nfsd_openatfunc, &open_buf);
+	if (open_buf.res_fd == -1)
+		errno = open_buf.res_error;
+	return open_buf.res_fd;
+}
+
 struct nfsd_rw_data {
 	int             fd;
 	void*           buf;
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index 39afd4aa..f43ebef5 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -392,7 +392,10 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 	struct nfs_fh_len *fh;
 	char		rpath[MAXPATHLEN+1];
 	char		*p = *path;
+	char		*subpath;
 	char		buf[INET6_ADDRSTRLEN];
+	size_t		epathlen;
+	int		dirfd;
 
 	if (*p == '\0')
 		p = "/";
@@ -412,12 +415,21 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 		*error = MNT3ERR_ACCES;
 		return NULL;
 	}
-	if (nfsd_path_stat(exp->m_export.e_path, &estb) < 0) {
-		xlog(L_WARNING, "can't stat export point %s: %s",
+
+	dirfd = nfsd_openat(AT_FDCWD, exp->m_export.e_path, O_PATH);
+	if (dirfd == -1) {
+		xlog(L_WARNING, "can't open export point %s: %s",
 		     p, strerror(errno));
 		*error = MNT3ERR_NOENT;
 		return NULL;
 	}
+	if (fstat(dirfd, &estb) == -1) {
+		xlog(L_WARNING, "can't stat export point %s: %s",
+		     p, strerror(errno));
+		*error = MNT3ERR_ACCES;
+		close(dirfd);
+		return NULL;
+	}
 	if (exp->m_export.e_mountpoint &&
 		   !check_is_mountpoint(exp->m_export.e_mountpoint[0]?
 				  exp->m_export.e_mountpoint:
@@ -426,18 +438,51 @@ get_rootfh(struct svc_req *rqstp, dirpath *path, nfs_export **expret,
 		xlog(L_WARNING, "request to export an unmounted filesystem: %s",
 		     p);
 		*error = MNT3ERR_NOENT;
+		close(dirfd);
 		return NULL;
 	}
 
-	if (nfsd_path_stat(p, &stb) < 0) {
-		xlog(L_WARNING, "can't stat exported dir %s: %s",
-				p, strerror(errno));
-		if (errno == ENOENT)
-			*error = MNT3ERR_NOENT;
-		else
-			*error = MNT3ERR_ACCES;
+	epathlen = strlen(exp->m_export.e_path);
+	if (epathlen > strlen(p)) {
+		xlog(L_WARNING, "raced with change of exported path: %s", p);
+		*error = MNT3ERR_NOENT;
+		close(dirfd);
 		return NULL;
 	}
+	subpath = &p[epathlen];
+	while (*subpath == '/')
+		subpath++;
+	if (*subpath != '\0') {
+		int fd;
+
+		/* Just perform a lookup of the path */
+		fd = nfsd_openat(dirfd, subpath, O_PATH);
+		close(dirfd);
+		if (fd == -1) {
+			xlog(L_WARNING, "can't open exported dir %s: %s", p,
+			     strerror(errno));
+			if (errno == ENOENT)
+				*error = MNT3ERR_NOENT;
+			else
+				*error = MNT3ERR_ACCES;
+			return NULL;
+		}
+		if (fstat(fd, &stb) == -1) {
+			xlog(L_WARNING, "can't open exported dir %s: %s", p,
+			     strerror(errno));
+			if (errno == ENOENT)
+				*error = MNT3ERR_NOENT;
+			else
+				*error = MNT3ERR_ACCES;
+			close(fd);
+			return NULL;
+		}
+		close(fd);
+	} else {
+		close(dirfd);
+		stb = estb;
+	}
+
 	if (!S_ISDIR(stb.st_mode) && !S_ISREG(stb.st_mode)) {
 		xlog(L_WARNING, "%s is not a directory or regular file", p);
 		*error = MNT3ERR_NOTDIR;
-- 
2.53.0


