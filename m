Return-Path: <linux-nfs+bounces-9418-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64408A175DC
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 02:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647903A8047
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 01:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63612C499;
	Tue, 21 Jan 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="igX2CbDy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED04A32
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737424172; cv=none; b=UXgekG9YElZdqABk1YJNi+0pA5+Pxen7kTiCPv70CwMF5Nwidv2V/TyarXs9TaDGyKoKp4/wfH8QeMKPXLfd7CQT4NNyuD1H6M6gFurmj1gJKPX9DtDx4X6oT0Vb00u9ei7O7siB1PnBD39TIaxhU6a6B/816BqD31I2qKzmTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737424172; c=relaxed/simple;
	bh=g1YTQq9kTn8DX97gWE1kSbBzUFNTd3JwaFjuQIZeBHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgKoqxjKqTUG+e+sdtI0zjQZimJyqyng05GXACaPcd7Lbu9lXuwMRbHpuJ8SGEt7hDZB1NOZbKH6kCix4xbUFsZO2OTgKFFg/zjSxdhzjIx1IGvyv0Vfd0jJNtbgqfL0i9nN14gpHfvfh3at6Xsu6Q3FqRa7XdCLSF6M2SiYoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=igX2CbDy; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1737419315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I9vj3RGxp9gkK1EpnHyeWkej3RZk6/LyZi83tfDpFUw=;
	b=igX2CbDytBjOAm2HkwAy3OsCGFVyOJu1MrQoPZC3ZxQibZH95zCpZGj5n1vGuDKax9A1Od
	9R5t7aSkZhyaw4OMwAooeaYAeWxoNDoflt42EaB4ZXiYDqHNNydvcxDX7jjDdJzPf0oEBp
	meMoYMAh3z382ZBxSciNTWy9WS1jGKoPNsLHnShsaag0KGIpggrarxZUPO8+48HZHmDnfS
	tAsNpbKA3/rRYHh1+/PiIxelXtUzlgnX2zhHArP5Tn2lgqOd2iP5Ms5vNofwdCqnA218gL
	JFvzBm5cxtQTEU4poR9AMiE3GITpGN12ATJNR2NxlzWr/baEnX8soIDk+CXUzg==
From: Christopher Bii <christopherbii@hyub.org>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Christopher Bii <christopherbii@hyub.org>
Subject: [PATCH] Removed nfsd_path_(read|write) methods as they are pointless.
Date: Mon, 20 Jan 2025 20:48:54 -0500
Message-ID: <20250121014853.7428-2-christopherbii@hyub.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Christopher Bii <christopherbii@hyub.org>
---
 support/export/cache.c      |  4 +--
 support/export/export.c     |  2 +-
 support/include/nfsd_path.h |  3 ---
 support/misc/nfsd_path.c    | 49 -------------------------------------
 4 files changed, 3 insertions(+), 55 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 6859a55b..0f6cf443 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -59,12 +59,12 @@ static int is_mountpoint(const char *path)
 
 static ssize_t cache_read(int fd, char *buf, size_t len)
 {
-	return nfsd_path_read(fd, buf, len);
+	return read(fd, buf, len);
 }
 
 static ssize_t cache_write(int fd, void *buf, size_t len)
 {
-	return nfsd_path_write(fd, buf, len);
+	return write(fd, buf, len);
 }
 
 static bool path_lookup_error(int err)
diff --git a/support/export/export.c b/support/export/export.c
index 2c8c3335..e50af371 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -463,7 +463,7 @@ int export_test(struct exportent *eep, int with_fsid)
 	fd = open("/proc/net/rpc/nfsd.export/channel", O_WRONLY);
 	if (fd < 0)
 		return 0;
-	n = nfsd_path_write(fd, buf, strlen(buf));
+	n = write(fd, buf, strlen(buf));
 	close(fd);
 	if (n < 0)
 		return 0;
diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index f600fb5a..f43040d5 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -24,9 +24,6 @@ int		nfsd_path_statfs(const char *pathname,
 
 char *		nfsd_realpath(const char *path, char *resolved_path);
 
-ssize_t		nfsd_path_read(int fd, void* buf, size_t len);
-ssize_t		nfsd_path_write(int fd, void* buf, size_t len);
-
 int		nfsd_name_to_handle_at(int fd, const char *path,
 				       struct file_handle *fh,
 				       int *mount_id, int flags);
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index caec33ca..99c41206 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -203,55 +203,6 @@ nfsd_realpath(const char *path, char *resolved_buf)
         return realpath_buf.res_ptr;
 }
 
-struct nfsd_rw_data {
-	int             fd;
-	void*           buf;
-	size_t          len;
-        ssize_t         bytes_read;
-};
-
-static void
-nfsd_readfunc(void *data)
-{
-        struct nfsd_rw_data* t = (struct nfsd_rw_data*)data;
-        t->bytes_read = read(t->fd, t->buf, t->len);
-}
-
-static ssize_t
-nfsd_run_read(int fd, void* buf, size_t len)
-{
-        struct nfsd_rw_data d = { .fd = fd, .buf = buf, .len = len };
-        nfsd_run_task(nfsd_readfunc, &d);
-	return d.bytes_read;
-}
-
-ssize_t
-nfsd_path_read(int fd, void* buf, size_t len)
-{
-	return nfsd_run_read(fd, buf, len);
-}
-
-static void
-nfsd_writefunc(void *data)
-{
-	struct nfsd_rw_data* d = data;
-	d->bytes_read = write(d->fd, d->buf, d->len);
-}
-
-static ssize_t
-nfsd_run_write(int fd, void* buf, size_t len)
-{
-        struct nfsd_rw_data d = { .fd = fd, .buf = buf, .len = len };
-        nfsd_run_task(nfsd_writefunc, &d);
-	return d.bytes_read;
-}
-
-ssize_t
-nfsd_path_write(int fd, void* buf, size_t len)
-{
-	return nfsd_run_write(fd, buf, len);
-}
-
 #if defined(HAVE_NAME_TO_HANDLE_AT)
 struct nfsd_handle_data {
 	int fd;
-- 
2.48.0


