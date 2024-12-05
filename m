Return-Path: <linux-nfs+bounces-8348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6572F9E4C1B
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2024 03:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B86B16917B
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2024 02:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77D641C92;
	Thu,  5 Dec 2024 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="MLLQV64X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584AA7E105
	for <linux-nfs@vger.kernel.org>; Thu,  5 Dec 2024 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733364267; cv=none; b=HSHkAR/DTNZ8YAieD8YL1BgmV8vHvf0WlQNmXsxD5+mwExDeQdmVjXuwSFuoYaWYdN8aRnxql1qCEdcN/JcHSA9XIIpuoqIhT+YqDdJRlzsn6ePjvzf7WwvvgZ+411dLYmNupA2oqJAhKCC7vZlwTtkHrICQbR0oOseNNuZgkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733364267; c=relaxed/simple;
	bh=huoyRCTstztPVJesakEEeo32Jh5xi0ZoyN/xBJfZz6w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=oOdCZazrYX/JSYI3nWIYUryWfKrV7B2kJFn3GJX+IDAduZAOQs6CWH959A1uyiUu53Gwm110ebondExY2MOb42/LLJk/HrTfI+KfdZ/RL69tMoZhYxiiB3ahSt/hOcPvAcE2EB9Kr304coC7SnQ/h+7L8dz5SbdsljUZU9hN2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=MLLQV64X; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1733364263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9FERPpYz6WojJjIuN6bvobHseZIakzL5ipS+M+9Zxao=;
	b=MLLQV64X10GW70KFM/WmXeo88fY5fgD7TQIViCOnYEXHwIdLuuE/QcQ2GgcrMKcA31XpBD
	d59rkEmDlrQx0IYQlywFc8i1tXg9+PY0L7gai5auXlR+FNU5HqkrzQksNlcfE32PYGPPCw
	y2DFIFtBNdm1hO6yobGse13YieLVWTqrd/FVltJesMrKm46OUonveORRSJe82xS0sJ7N86
	gbO7ZQSd5Iu3jH9agO0sUIUlG9T3JR871WNsID1dOpcMentHslauvjYBdTT0Yq7z7gq+5E
	dTNMyqQirpjBk/iUuu+LifAuz0B3PaNz0p6L6lAMlcvJKwmV9IXOncDemZkWiQ==
Message-ID: <273abae8-e3c8-4c8c-b082-3bb624271818@hyub.org>
Date: Thu, 5 Dec 2024 02:04:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christopher Bii <christopherbii@hyub.org>
Subject: [PATCH 1/2] Exportfs changes - When a export rootdir is present,
 nfsd_realpath() wrapper is used to avoid symlink exploits. - Removed
 canonicalization of rootdir paths. Export rootdir must now be an absolute
 path. - Implemented nfsd_path.h
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: Christopher Bii <christopherbii@hyub.org>
---
  support/export/export.c     |  24 +--
  support/include/exportfs.h  |   1 +
  support/include/nfsd_path.h |   9 +-
  support/misc/nfsd_path.c    | 362 ++++++++++++------------------------
  support/nfs/exports.c       |  53 +++---
  utils/exportfs/exportfs.c   |   8 +-
  6 files changed, 165 insertions(+), 292 deletions(-)

diff --git a/support/export/export.c b/support/export/export.c
index 2c8c3335..463ba846 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -40,20 +40,7 @@ static int	export_check(const nfs_export *exp, const 
struct addrinfo *ai,
  static void
  exportent_mkrealpath(struct exportent *eep)
  {
-	const char *chroot = nfsd_path_nfsd_rootdir();
-	char *ret = NULL;
-
-	if (chroot) {
-		char buffer[PATH_MAX];
-		if (realpath(chroot, buffer))
-			ret = nfsd_path_prepend_dir(buffer, eep->e_path);
-		else
-			xlog(D_GENERAL, "%s: failed to resolve path %s: %m",
-					__func__, chroot);
-	}
-	if (!ret)
-		ret = xstrdup(eep->e_path);
-	eep->e_realpath = ret;
+        eep->e_realpath = nfsd_path_prepend_root(eep->e_path);
  }
   char *
@@ -64,6 +51,13 @@ exportent_realpath(struct exportent *eep)
  	return eep->e_realpath;
  }
  +void
+exportent_free_realpath(struct exportent* eep)
+{
+        if (eep->e_realpath && eep->e_realpath != eep->e_path)
+                free(eep->e_realpath);
+};
+
  void
  exportent_release(struct exportent *eep)
  {
@@ -73,7 +67,7 @@ exportent_release(struct exportent *eep)
  	free(eep->e_fslocdata);
  	free(eep->e_uuid);
  	xfree(eep->e_hostname);
-	xfree(eep->e_realpath);
+        exportent_free_realpath(eep);
  }
   static void
diff --git a/support/include/exportfs.h b/support/include/exportfs.h
index 9edf0d04..c65e2a1c 100644
--- a/support/include/exportfs.h
+++ b/support/include/exportfs.h
@@ -173,6 +173,7 @@ struct export_features {
   struct export_features *get_export_features(void);
  void fix_pseudoflavor_flags(struct exportent *ep);
+void exportent_free_realpath(struct exportent*);
  char *exportent_realpath(struct exportent *eep);
  int export_test(struct exportent *eep, int with_fsid);
  diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index aa1e1dd0..9c5976e8 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -8,12 +8,13 @@
   struct file_handle;
  struct statfs;
+struct nfsd_task_t;
   void 		nfsd_path_init(void);
  -const char *	nfsd_path_nfsd_rootdir(void);
+const char *    nfsd_path_rootdir(void);
  char *		nfsd_path_strip_root(char *pathname);
-char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
+char *		nfsd_path_prepend_root(char *pathname);
   int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
  int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
@@ -23,8 +24,8 @@ int		nfsd_path_statfs(const char *pathname,
   char *		nfsd_realpath(const char *path, char *resolved_path);
  -ssize_t		nfsd_path_read(int fd, char *buf, size_t len);
-ssize_t		nfsd_path_write(int fd, const char *buf, size_t len);
+ssize_t		nfsd_path_read(int fd, void* buf, size_t len);
+ssize_t		nfsd_path_write(int fd, void* buf, size_t len);
   int		nfsd_name_to_handle_at(int fd, const char *path,
  				       struct file_handle *fh,
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index c3dea4f0..b896f091 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -19,95 +19,79 @@
  #include "nfsd_path.h"
  #include "workqueue.h"
  -static struct xthread_workqueue *nfsd_wq;
+static struct xthread_workqueue *nfsd_wq = NULL;
+const char      *rootdir;
+size_t          rootdir_pathlen = 0;
  -static int
-nfsd_path_isslash(const char *path)
-{
-	return path[0] == '/' && path[1] == '/';
-}
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
  -static int
-nfsd_path_isdot(const char *path)
+const char*
+nfsd_path_rootdir(void)
  {
-	return path[0] == '.' && path[1] == '/';
-}
+        return rootdir;
+};
  -static const char *
-nfsd_path_strip(const char *path)
+/* Set rootdir global variable. Rootdir must be an absolute path
+ * and resolveable by realpath()
+ * */
+static void
+nfsd_rootdir_set(void)
  {
-	if (!path || *path == '\0')
-		goto out;
-	for (;;) {
-		if (nfsd_path_isslash(path)) {
-			path++;
-			continue;
-		}
-		if (nfsd_path_isdot(path)) {
-			path += 2;
-			continue;
-		}
-		break;
-	}
-out:
-	return path;
-}
+        const char             *path;
+        if (!(path = conf_get_str("exports", "rootdir")))
+                return;
  -const char *
-nfsd_path_nfsd_rootdir(void)
-{
-	const char *rootdir;
-
-	rootdir = nfsd_path_strip(conf_get_str("exports", "rootdir"));
-	if (!rootdir || rootdir[0] ==  '\0')
-		return NULL;
-	if (rootdir[0] == '/' && rootdir[1] == '\0')
-		return NULL;
-	return rootdir;
+        if (path[0] != '/')
+                xlog(L_FATAL, "%s: NFS export rootdir must be an 
absolute path. "
+                                "Current value: \"%s\"", __func__, path);
+
+        if (!(rootdir = realpath(path, NULL))){
+                free((void*)rootdir);
+                xlog(L_FATAL, "realpath(): Unable to resolve root 
export path \"%s\"", path);
+        };
+
+        rootdir_pathlen = strlen(rootdir);
  }
   char *
  nfsd_path_strip_root(char *pathname)
  {
-	char buffer[PATH_MAX];
-	const char *dir = nfsd_path_nfsd_rootdir();
-
-	if (!dir)
-		goto out;
-
-	if (realpath(dir, buffer))
-		return strstr(pathname, buffer) == pathname ?
-			pathname + strlen(buffer) : NULL;
+	if (!rootdir)
+                return pathname;
  -	xlog(D_GENERAL, "%s: failed to resolve path %s: %m", __func__, dir);
-out:
-	return pathname;
+        return strstr(pathname, rootdir) == pathname ?
+                pathname + rootdir_pathlen : pathname;
  }
   char *
-nfsd_path_prepend_dir(const char *dir, const char *pathname)
+nfsd_path_prepend_root(char *pathname)
  {
-	size_t len, dirlen;
-	char *ret;
-
-	dirlen = strlen(dir);
-	while (dirlen > 0 && dir[dirlen - 1] == '/')
-		dirlen--;
-	if (!dirlen)
-		return NULL;
-	while (pathname[0] == '/')
-		pathname++;
-	len = dirlen + strlen(pathname) + 1;
-	ret = xmalloc(len + 1);
-	snprintf(ret, len+1, "%.*s/%s", (int)dirlen, dir, pathname);
-	return ret;
+        char*                   buff;
+
+        if (!rootdir)
+                return pathname;
+
+        buff = malloc(strlen(pathname) + rootdir_pathlen + 1);
+        memcpy(buff, rootdir, rootdir_pathlen);
+        strcpy(buff + rootdir_pathlen, pathname);
+
+        return buff;
  }
   static void
  nfsd_setup_workqueue(void)
  {
-	const char *rootdir = nfsd_path_nfsd_rootdir();
-
+	nfsd_rootdir_set();
  	if (!rootdir)
  		return;
  @@ -124,224 +108,119 @@ nfsd_path_init(void)
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
+        return nfsd_run_stat(pathname, (struct stat*)statbuf, (int 
(*)(const char*, struct stat*))statfs);
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
-nfsd_run_write(struct xthread_workqueue *wq, int fd, const char *buf, 
size_t len)
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
@@ -352,23 +231,18 @@ struct nfsd_handle_data {
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
@@ -377,25 +251,19 @@ nfsd_run_name_to_handle_at(struct 
xthread_workqueue *wq,
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
index a6816e60..c8ce8566 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -32,6 +32,7 @@
  #include "xio.h"
  #include "pseudoflavors.h"
  #include "reexport.h"
+#include "nfsd_path.h"
   #define EXPORT_DEFAULT_FLAGS	\
  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
@@ -160,7 +161,7 @@ getexportent(int fromkernel)
  	}
   	xfree(ee.e_hostname);
-	xfree(ee.e_realpath);
+	exportent_free_realpath(&ee);
  	ee = def_ee;
   	/* Check for default client */
@@ -185,28 +186,34 @@ getexportent(int fromkernel)
  	}
  	ee.e_hostname = xstrdup(hostname);
  -	if (parseopts(opt, &ee, NULL) < 0) {
-		if(ee.e_hostname)
-		{
-			xfree(ee.e_hostname);
-			ee.e_hostname=NULL;
-		}
-		if(ee.e_uuid)
-		{
-			xfree(ee.e_uuid);
-			ee.e_uuid=NULL;
-		}
+	if (parseopts(opt, &ee, NULL) < 0)
+                goto out;
  -		return NULL;
-	}
  	/* resolve symlinks */
-	if (realpath(ee.e_path, rpath) != NULL) {
-		rpath[sizeof (rpath) - 1] = '\0';
-		strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
-		ee.e_path[sizeof (ee.e_path) - 1] = '\0';
-	}
+	if (nfsd_realpath(ee.e_path, rpath) == NULL) {
+                xlog(L_ERROR, "realpath(): Unable to resolve path at 
%s", ee.e_path);
+                goto out;
+        };
  -	return &ee;
+        if (strlen(rpath) > sizeof(ee.e_path) - 1){
+                xlog(L_ERROR, "Path %s exceeds limit of %lu chars", 
ee.e_path, sizeof(ee.e_path) - 1);
+                goto out;
+        };
+
+        strcpy(ee.e_path, rpath);
+        return &ee;
+
+out:
+        if (ee.e_hostname){
+                free(ee.e_hostname);
+                ee.e_hostname = NULL;
+        };
+        if (ee.e_uuid){
+                free(ee.e_uuid);
+                ee.e_uuid = NULL;
+        };
+
+        return NULL;
  }
   static const struct secinfo_flag_displaymap {
@@ -424,15 +431,15 @@ mkexportent(char *hname, char *path, char *options)
   	xfree(ee.e_hostname);
  	ee.e_hostname = xstrdup(hname);
-	xfree(ee.e_realpath);
+	exportent_free_realpath(&ee);
  	ee.e_realpath = NULL;
   	if (strlen(path) >= sizeof(ee.e_path)) {
  		xlog(L_ERROR, "path name %s too long", path);
  		return NULL;
  	}
-	strncpy(ee.e_path, path, sizeof (ee.e_path));
-	ee.e_path[sizeof (ee.e_path) - 1] = '\0';
+	strcpy(ee.e_path, path);
+
  	if (parseopts(options, &ee, NULL) < 0)
  		return NULL;
  	return &ee;
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index b03a047b..0697e398 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -266,7 +266,6 @@ export_all(int verbose)
  	}
  }
  -
  static void
  exportfs_parsed(char *hname, char *path, char *options, int verbose)
  {
@@ -512,11 +511,13 @@ validate_export(nfs_export *exp)
  	 * If a path doesn't exist, or is not a dir or file, give an warning
  	 * otherwise trial-export to '-test-client-' and check for failure.
  	 */
-	struct stat stb;
-	char *path = exportent_realpath(&exp->m_export);
+	struct stat     stb;
+	char            *path;
  	struct statfs stf;
  	int fs_has_fsid = 0;
  +        path = exportent_realpath(&exp->m_export);
+
  	if (stat(path, &stb) < 0) {
  		xlog(L_ERROR, "Failed to stat %s: %m", path);
  		return;
@@ -547,6 +548,7 @@ validate_export(nfs_export *exp)
  		return;
   	}
+
  }
   static _Bool
-- 
2.47.1



