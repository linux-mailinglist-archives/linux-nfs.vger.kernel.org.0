Return-Path: <linux-nfs+bounces-8958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B13A04B69
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 22:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8D93A3960
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74C1F471C;
	Tue,  7 Jan 2025 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="bgH/MVaf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B211D8DFE
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284298; cv=none; b=tcJdJknd7zOz/AvzcQxKr3CINCZV0l7/2281Dtq9A3fPPmhMWe+GXA1m3aGfmbtrNYL5Yhr4vbkOrl3LzicTRgqkyANtaFfYQQ820AWYBoz3iNM272rxpXBFPYxqaCkZGcAbWiQ0GFfQaBSOXGlOvO+tMb/lYfQf1hUBb04pBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284298; c=relaxed/simple;
	bh=N/TGVR2XUX5shg09jTL7OevUORVLgozfPuv9SJQR4bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjINSsEeQ0hwynL69p/G90BkROKM6munxECFVnPALuWGh92eLbEZTPQNWYHqMROtfZkr0bK5UL2Mk+27Mub/ZMtmFtufsXMw78Z9rZgB8VIG7qFX6BOw0jtKUVUM2OpzCssHtCsqYEcHESLB0JEGrTWrcad2EfvlYBe8AKg2Uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=bgH/MVaf; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1736279451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=onvBJ+D++PFfLv1hvvS9t7NZTDXkO8sUKUPKx4nWaHA=;
	b=bgH/MVafFe42mtoX0QjirOV4Zdjhd6Cu1QeCkTtiNelz4pvTg1nfHB0+s51xIBezeNd14L
	V+Fhj76TIiOhXswckGnsmnTgpZCvqdI7VESoFxpTeioLa6A8U9GB400vff7igyQjRJG6V3
	YBU9RejPFiEvoIbekjI+8bBK8cOD3t9GzG581GrH591vl7WrUOSjeYyzXjgYjAlJ1tixJM
	kcUmc0P/ur3e9VEsMTRl82Tl18aYbTSzoR+bhDzU+b3hU37eqUxjwlrm2lIBoVk7PDI20v
	SpDcPvwV3LlT3Wx3CoQyrEEjqFMexaMldyyEWGXnKiOR6yzdpvH4Lh3/DOQyRA==
From: Christopher Bii <christopherbii@hyub.org>
To: steved@redhat.com
Cc: neilb@suse.de,
	linux-nfs@vger.kernel.org,
	Christopher Bii <christopherbii@hyub.org>
Subject: [PATCH] NFS export symlink vulnerability fix - Replaced dangerous use of realpath within support/nfs/export.c with   nfsd_realpath variant that is executed within the chrooted thread   rather than main thread. - Implemented nfsd_path.h methods to work securely within chrooted thread   using nfsd_run_task() helper
Date: Tue,  7 Jan 2025 16:11:22 -0500
Message-ID: <20250107211122.28305-1-christopherbii@hyub.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Christopher Bii <christopherbii@hyub.org>
---
 support/include/nfsd_path.h |   5 +-
 support/misc/nfsd_path.c    | 255 +++++++++++-------------------------
 support/nfs/exports.c       |   3 +-
 3 files changed, 80 insertions(+), 183 deletions(-)

diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index 214bde47..8085ddfd 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -8,6 +8,7 @@
 
 struct file_handle;
 struct statfs;
+struct nfsd_task_t;
 
 void 		nfsd_path_init(void);
 
@@ -23,8 +24,8 @@ int		nfsd_path_statfs(const char *pathname,
 
 char *		nfsd_realpath(const char *path, char *resolved_path);
 
-ssize_t		nfsd_path_read(int fd, char *buf, size_t len);
-ssize_t		nfsd_path_write(int fd, const char *buf, size_t len);
+ssize_t		nfsd_path_read(int fd, void* buf, size_t len);
+ssize_t		nfsd_path_write(int fd, void* buf, size_t len);
 
 int		nfsd_name_to_handle_at(int fd, const char *path,
 				       struct file_handle *fh,
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 0f727d3b..38f0a394 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -19,10 +19,21 @@
 #include "nfsd_path.h"
 #include "workqueue.h"
 
-static struct xthread_workqueue *nfsd_wq;
+static struct xthread_workqueue *nfsd_wq = NULL;
 const char      *rootdir;
 size_t          rootdir_pathlen = 0;
 
+struct nfsd_task_t {
+        int             ret;
+        void*           data;
+};
+/* Function used to offload tasks that must be ran within the correct
+ * chroot environment.
+ * */
+static void
+nfsd_run_task(void (*func)(void*), void* data){
+        nfsd_wq ? xthread_work_run_sync(nfsd_wq, func, data) : func(data);
+};
 
 const char*
 nfsd_path_rootdir(void)
@@ -97,224 +108,119 @@ nfsd_path_init(void)
 }
 
 struct nfsd_stat_data {
-	const char *pathname;
-	struct stat *statbuf;
-	int ret;
-	int err;
+	const char      *pathname;
+	struct stat     *statbuf;
+        int             (*stat_handler)(const char*, struct stat*);
 };
 
 static void
-nfsd_statfunc(void *data)
-{
-	struct nfsd_stat_data *d = data;
-
-	d->ret = xstat(d->pathname, d->statbuf);
-	if (d->ret < 0)
-		d->err = errno;
-}
-
-static void
-nfsd_lstatfunc(void *data)
+nfsd_handle_stat(void *data)
 {
-	struct nfsd_stat_data *d = data;
-
-	d->ret = xlstat(d->pathname, d->statbuf);
-	if (d->ret < 0)
-		d->err = errno;
+        struct nfsd_task_t*     t = data;
+	struct nfsd_stat_data*  d = t->data;
+        t->ret = d->stat_handler(d->pathname, d->statbuf);
 }
 
 static int
-nfsd_run_stat(struct xthread_workqueue *wq,
-		void (*func)(void *),
-		const char *pathname,
-		struct stat *statbuf)
+nfsd_run_stat(const char *pathname,
+	        struct stat *statbuf,
+                int (*handler)(const char*, struct stat*))
 {
-	struct nfsd_stat_data data = {
-		pathname,
-		statbuf,
-		0,
-		0
-	};
-	xthread_work_run_sync(wq, func, &data);
-	if (data.ret < 0)
-		errno = data.err;
-	return data.ret;
+        struct nfsd_task_t      t;
+        struct nfsd_stat_data   d = { pathname, statbuf, handler };
+        t.data = &d;
+        nfsd_run_task(nfsd_handle_stat, &t);
+	return t.ret;
 }
 
 int
 nfsd_path_stat(const char *pathname, struct stat *statbuf)
 {
-	if (!nfsd_wq)
-		return xstat(pathname, statbuf);
-	return nfsd_run_stat(nfsd_wq, nfsd_statfunc, pathname, statbuf);
+        return nfsd_run_stat(pathname, statbuf, stat);
 }
 
 int
-nfsd_path_lstat(const char *pathname, struct stat *statbuf)
-{
-	if (!nfsd_wq)
-		return xlstat(pathname, statbuf);
-	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
-}
-
-struct nfsd_statfs_data {
-	const char *pathname;
-	struct statfs *statbuf;
-	int ret;
-	int err;
+nfsd_path_lstat(const char* pathname, struct stat* statbuf){
+        return nfsd_run_stat(pathname, statbuf, lstat);
 };
 
-static void
-nfsd_statfsfunc(void *data)
-{
-	struct nfsd_statfs_data *d = data;
-
-	d->ret = statfs(d->pathname, d->statbuf);
-	if (d->ret < 0)
-		d->err = errno;
-}
-
-static int
-nfsd_run_statfs(struct xthread_workqueue *wq,
-		  const char *pathname,
-		  struct statfs *statbuf)
-{
-	struct nfsd_statfs_data data = {
-		pathname,
-		statbuf,
-		0,
-		0
-	};
-	xthread_work_run_sync(wq, nfsd_statfsfunc, &data);
-	if (data.ret < 0)
-		errno = data.err;
-	return data.ret;
-}
-
 int
-nfsd_path_statfs(const char *pathname, struct statfs *statbuf)
+nfsd_path_statfs(const char* pathname, struct statfs* statbuf)
 {
-	if (!nfsd_wq)
-		return statfs(pathname, statbuf);
-	return nfsd_run_statfs(nfsd_wq, pathname, statbuf);
-}
+        return nfsd_run_stat(pathname, (struct stat*)statbuf, (int (*)(const char*, struct stat*))statfs);
+};
 
-struct nfsd_realpath_data {
-	const char *pathname;
-	char *resolved;
-	int err;
+struct nfsd_realpath_t {
+        const char*     path;
+        char*           resolved_buf;
+        char*           res_ptr;
 };
 
 static void
 nfsd_realpathfunc(void *data)
 {
-	struct nfsd_realpath_data *d = data;
-
-	d->resolved = realpath(d->pathname, d->resolved);
-	if (!d->resolved)
-		d->err = errno;
+        struct nfsd_realpath_t *d = data;
+        d->res_ptr = realpath(d->path, d->resolved_buf);
 }
 
-char *
-nfsd_realpath(const char *path, char *resolved_path)
+char*
+nfsd_realpath(const char *path, char *resolved_buf)
 {
-	struct nfsd_realpath_data data = {
-		path,
-		resolved_path,
-		0
-	};
-
-	if (!nfsd_wq)
-		return realpath(path, resolved_path);
-
-	xthread_work_run_sync(nfsd_wq, nfsd_realpathfunc, &data);
-	if (!data.resolved)
-		errno = data.err;
-	return data.resolved;
+        struct nfsd_realpath_t realpath_buf = {
+                .path = path,
+                .resolved_buf = resolved_buf
+        };
+        nfsd_run_task(nfsd_realpathfunc, &realpath_buf);
+        return realpath_buf.res_ptr;
 }
 
-struct nfsd_read_data {
-	int fd;
-	char *buf;
-	size_t len;
-	ssize_t ret;
-	int err;
+struct nfsd_rw_data {
+	int             fd;
+	void*           buf;
+	size_t          len;
+        ssize_t         bytes_read;
 };
 
 static void
 nfsd_readfunc(void *data)
 {
-	struct nfsd_read_data *d = data;
-
-	d->ret = read(d->fd, d->buf, d->len);
-	if (d->ret < 0)
-		d->err = errno;
+        struct nfsd_rw_data* t = (struct nfsd_rw_data*)data;
+        t->bytes_read = read(t->fd, t->buf, t->len);
 }
 
 static ssize_t
-nfsd_run_read(struct xthread_workqueue *wq, int fd, char *buf, size_t len)
+nfsd_run_read(int fd, void* buf, size_t len)
 {
-	struct nfsd_read_data data = {
-		fd,
-		buf,
-		len,
-		0,
-		0
-	};
-	xthread_work_run_sync(wq, nfsd_readfunc, &data);
-	if (data.ret < 0)
-		errno = data.err;
-	return data.ret;
+        struct nfsd_rw_data d = { .fd = fd, .buf = buf, .len = len };
+        nfsd_run_task(nfsd_readfunc, &d);
+	return d.bytes_read;
 }
 
 ssize_t
-nfsd_path_read(int fd, char *buf, size_t len)
+nfsd_path_read(int fd, void* buf, size_t len)
 {
-	if (!nfsd_wq)
-		return read(fd, buf, len);
-	return nfsd_run_read(nfsd_wq, fd, buf, len);
+	return nfsd_run_read(fd, buf, len);
 }
 
-struct nfsd_write_data {
-	int fd;
-	const char *buf;
-	size_t len;
-	ssize_t ret;
-	int err;
-};
-
 static void
 nfsd_writefunc(void *data)
 {
-	struct nfsd_write_data *d = data;
-
-	d->ret = write(d->fd, d->buf, d->len);
-	if (d->ret < 0)
-		d->err = errno;
+	struct nfsd_rw_data* d = data;
+	d->bytes_read = write(d->fd, d->buf, d->len);
 }
 
 static ssize_t
-nfsd_run_write(struct xthread_workqueue *wq, int fd, const char *buf, size_t len)
+nfsd_run_write(int fd, void* buf, size_t len)
 {
-	struct nfsd_write_data data = {
-		fd,
-		buf,
-		len,
-		0,
-		0
-	};
-	xthread_work_run_sync(wq, nfsd_writefunc, &data);
-	if (data.ret < 0)
-		errno = data.err;
-	return data.ret;
+        struct nfsd_rw_data d = { .fd = fd, .buf = buf, .len = len };
+        nfsd_run_task(nfsd_writefunc, &d);
+	return d.bytes_read;
 }
 
 ssize_t
-nfsd_path_write(int fd, const char *buf, size_t len)
+nfsd_path_write(int fd, void* buf, size_t len)
 {
-	if (!nfsd_wq)
-		return write(fd, buf, len);
-	return nfsd_run_write(nfsd_wq, fd, buf, len);
+	return nfsd_run_write(fd, buf, len);
 }
 
 #if defined(HAVE_NAME_TO_HANDLE_AT)
@@ -325,23 +231,18 @@ struct nfsd_handle_data {
 	int *mount_id;
 	int flags;
 	int ret;
-	int err;
 };
 
 static void
 nfsd_name_to_handle_func(void *data)
 {
 	struct nfsd_handle_data *d = data;
-
-	d->ret = name_to_handle_at(d->fd, d->path,
-			d->fh, d->mount_id, d->flags);
-	if (d->ret < 0)
-		d->err = errno;
+	d->ret = name_to_handle_at(d->fd, d->path, d->fh, d->mount_id, d->flags);
 }
 
 static int
-nfsd_run_name_to_handle_at(struct xthread_workqueue *wq,
-		int fd, const char *path, struct file_handle *fh,
+nfsd_run_name_to_handle_at(int fd, const char *path,
+                struct file_handle *fh,
 		int *mount_id, int flags)
 {
 	struct nfsd_handle_data data = {
@@ -350,25 +251,19 @@ nfsd_run_name_to_handle_at(struct xthread_workqueue *wq,
 		fh,
 		mount_id,
 		flags,
-		0,
 		0
 	};
 
-	xthread_work_run_sync(wq, nfsd_name_to_handle_func, &data);
-	if (data.ret < 0)
-		errno = data.err;
+	nfsd_run_task(nfsd_name_to_handle_func, &data);
 	return data.ret;
 }
 
 int
-nfsd_name_to_handle_at(int fd, const char *path, struct file_handle *fh,
+nfsd_name_to_handle_at(int fd, const char *path,
+                struct file_handle *fh,
 		int *mount_id, int flags)
 {
-	if (!nfsd_wq)
-		return name_to_handle_at(fd, path, fh, mount_id, flags);
-
-	return nfsd_run_name_to_handle_at(nfsd_wq, fd, path, fh,
-			mount_id, flags);
+        return nfsd_run_name_to_handle_at(fd, path, fh, mount_id, flags);
 }
 #else
 int
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index a6816e60..21ec6486 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -32,6 +32,7 @@
 #include "xio.h"
 #include "pseudoflavors.h"
 #include "reexport.h"
+#include "nfsd_path.h"
 
 #define EXPORT_DEFAULT_FLAGS	\
   (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
@@ -200,7 +201,7 @@ getexportent(int fromkernel)
 		return NULL;
 	}
 	/* resolve symlinks */
-	if (realpath(ee.e_path, rpath) != NULL) {
+	if (nfsd_realpath(ee.e_path, rpath) != NULL) {
 		rpath[sizeof (rpath) - 1] = '\0';
 		strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
 		ee.e_path[sizeof (ee.e_path) - 1] = '\0';
-- 
2.47.1


