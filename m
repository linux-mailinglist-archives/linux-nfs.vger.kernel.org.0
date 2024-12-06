Return-Path: <linux-nfs+bounces-8403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50179E7B6F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 23:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5708428223F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7FE1EBFFC;
	Fri,  6 Dec 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="OgrKk3mS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B91C3F36
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523170; cv=none; b=liRr/fYPg/Fj0NIyLVR8w3sGedf11AGjZtGpGYbyx65+/b0K9xd/6de5+0a5FpWfvS3Up/amVsnaUnf+US3+gnVit+1MM9O/UanoCXKDIcixlZUQKSZd753skTRKT1mrpXiGYm5OYih/GEOt7mUF9DtLSJCcbStbWQRp/mKupNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523170; c=relaxed/simple;
	bh=wM9tR2T2nReGdjSUw4oYM5pvNjT+8CEiXg2uJO3uXfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAaxwGuYH2H2D5Zdo1pOdO9/vVJvv0Jpbc4bqnlkn7euKbekcbaDgawyo3YhyTRv1p05acOgRuH14bAQL/clydfcihJ0AtacEiBtyCi4C0tMX7mpM/ZlqroSziDUq1wmsU8kbraavioOgQFTi8v8e/Jrc/OVKejiG1U8594NMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=OgrKk3mS; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1733523162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1pcD76vVjs9nQfGtbcbUn4GbdM9jM/5ncXQ9WcFLA4=;
	b=OgrKk3mSfjdyLO750CU872CCd6+JLVO4+iXRUPxMgiz7eX7u/x55MiGciTOR6GSpetSVJ6
	lLfxXHwHZFUBCMATOn4CqqsBQjeXzNR1tvArDsGqyX7k8aWPEVzNJBAFYg/GHj7rHAyBR3
	kDJA7Ty1kFSl5/ied3WXIcN7hOia/BJCG/eymniPVHmz0+8SoGIC+0wx5sWrhmxgGR2itf
	YUlAxqguhQ1M+KhmfDq/eojbcTFBtNgV++6jTR8a32cctEu/OHLtUfwnsGNeJRxagXgu2A
	93qJ5SAfyFtMb/MEFN7jXOngjOJR2D/9WQUtBbKdB88/0Caku7k7WqutXMQxfg==
From: Christopher Bii <christopherbii@hyub.org>
To: steved@redhat.com
Cc: Christopher Bii <christopherbii@hyub.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] nfsd_path.h - nfsd_path.c: - nfsd_path_prepend_dir(const char*, const char*) -> nfsd_path_prepend_root(const char*)
Date: Fri,  6 Dec 2024 17:11:55 -0500
Message-ID: <20241206221202.31507-4-christopherbii@hyub.org>
In-Reply-To: <20241206221202.31507-1-christopherbii@hyub.org>
References: <20241206221202.31507-1-christopherbii@hyub.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

support/export/export.c
- use of nfsd_path_prepend_root mentionned above to make exportent->e_realpath

Signed-off-by: Christopher Bii <christopherbii@hyub.org>
---
 support/export/export.c     | 17 +++--------------
 support/include/nfsd_path.h |  2 +-
 support/misc/nfsd_path.c    | 26 +++++++++++---------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/support/export/export.c b/support/export/export.c
index 3a4fb747..5da5780f 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -40,20 +40,9 @@ static int	export_check(const nfs_export *exp, const struct addrinfo *ai,
 static void
 exportent_mkrealpath(struct exportent *eep)
 {
-	const char *chroot = nfsd_path_rootdir();
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
+        if (eep->e_realpath == eep->e_path)
+                eep->e_realpath = xstrdup(eep->e_path);
 }
 
 char *
diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index 2b9b68af..214bde47 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -13,7 +13,7 @@ void 		nfsd_path_init(void);
 
 const char *    nfsd_path_rootdir(void);
 char *		nfsd_path_strip_root(char *pathname);
-char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
+char *		nfsd_path_prepend_root(const char* pathname);
 
 int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
 int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index ff946301..0f727d3b 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -63,22 +63,18 @@ nfsd_path_strip_root(char *pathname)
 }
 
 char *
-nfsd_path_prepend_dir(const char *dir, const char *pathname)
+nfsd_path_prepend_root(const char *pathname)
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
+                return (char*)pathname;
+
+        buff = malloc(strlen(pathname) + rootdir_pathlen + 1);
+        memcpy(buff, rootdir, rootdir_pathlen);
+        strcpy(buff + rootdir_pathlen, pathname);
+
+        return buff;
 }
 
 static void
-- 
2.47.1


