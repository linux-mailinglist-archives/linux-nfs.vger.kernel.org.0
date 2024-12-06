Return-Path: <linux-nfs+bounces-8404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8219E7B70
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 23:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991141885D1A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40D71C3F36;
	Fri,  6 Dec 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="DmQiQ57n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0691C303E
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523170; cv=none; b=e8EK7lEu4Q18ugyME20cJvSK8YWFANQHfYPUP9YJcbxTRDhIXOwEohBteqFpP6/rYQD0otJdKmKu/PTa/0IKVuSnZnvkgDvU0mW6X9eiUOA+GMHVILQVGgtqMuchLOP122r5N78vIZo+8ep+zGKK3Xn/wJEcwMqTcnGkzqdByjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523170; c=relaxed/simple;
	bh=FSDh6MyLOFAWe9zrHjpyd2q1eJvs++172vf67GHIhEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZpjUjGZa8WLLZwpXT9kYyU9l3eVoKY9tJDBzd+DFkg0i/tUIeZydTfrfPXUKS8+Wj0d63DEzffZ9ljHNl2EV+BmCzGWHJXJI4fNBQTZApwLwEx1kpjiXDeBKVxRSn+1IFc9kq81Fj78+XYgjpDF6gNEelIn9eiI58W5JQ5pDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=DmQiQ57n; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1733523161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiPas3ya9xDbJorX9xJUaZQfq6mAUB0tXHdKnW2HKGY=;
	b=DmQiQ57nGXQarVsxHmo1YhHZgjGjmJrAb3yxJUH+Btv1zpVeB2L7UnxkyLAyXhKQns1/WQ
	6sfhouMz5i0jTowFG9f+Or2haRT7hfNlE/SqzTXCvOIPkvw48vTdtBO0X+aSFYzpH8rmo2
	gFR5MoVYlmvUYABIpau2hNmp3LGj5wgAtNWRKAvqc+UnUleH0HS1OeRiSBTLAscRU3IaKV
	xqQ6GIRV6zm5GQVwdpYXH/S2jwC8c5lB2nuQ6McLPUt5p1gdqmBCwncliTFHxQBqKefEWC
	vOrL3ksicoZbt8MC4o1gTsUqxAds33H/XptIHwITeey+d5Gm3AiI103GzlaVTA==
From: Christopher Bii <christopherbii@hyub.org>
To: steved@redhat.com
Cc: Christopher Bii <christopherbii@hyub.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] nfsd_path.h - nfsd_path.c: - Configured export rootdir must now be an absolute path - Rootdir is into a global variable what will also be used to retrieve   it later on - nfsd_path_nfsd_rootdir(void) is simplified with nfsd_path_rootdir   which returns the global var rather than reprobing config for rootdir   entry
Date: Fri,  6 Dec 2024 17:11:53 -0500
Message-ID: <20241206221202.31507-2-christopherbii@hyub.org>
In-Reply-To: <20241206221202.31507-1-christopherbii@hyub.org>
References: <20241206221202.31507-1-christopherbii@hyub.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Christopher Bii <christopherbii@hyub.org>
---
 support/export/export.c     |  2 +-
 support/include/nfsd_path.h |  2 +-
 support/misc/nfsd_path.c    | 65 ++++++++++++++-----------------------
 3 files changed, 27 insertions(+), 42 deletions(-)

diff --git a/support/export/export.c b/support/export/export.c
index 2c8c3335..3a4fb747 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -40,7 +40,7 @@ static int	export_check(const nfs_export *exp, const struct addrinfo *ai,
 static void
 exportent_mkrealpath(struct exportent *eep)
 {
-	const char *chroot = nfsd_path_nfsd_rootdir();
+	const char *chroot = nfsd_path_rootdir();
 	char *ret = NULL;
 
 	if (chroot) {
diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index aa1e1dd0..2b9b68af 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -11,7 +11,7 @@ struct statfs;
 
 void 		nfsd_path_init(void);
 
-const char *	nfsd_path_nfsd_rootdir(void);
+const char *    nfsd_path_rootdir(void);
 char *		nfsd_path_strip_root(char *pathname);
 char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
 
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index c3dea4f0..5168903d 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -20,57 +20,43 @@
 #include "workqueue.h"
 
 static struct xthread_workqueue *nfsd_wq;
+const char      *rootdir;
+size_t          rootdir_pathlen = 0;
 
-static int
-nfsd_path_isslash(const char *path)
-{
-	return path[0] == '/' && path[1] == '/';
-}
 
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
+        if (path[0] != '/')
+                xlog(L_FATAL, "%s: NFS export rootdir must be an absolute path. "
+                                "Current value: \"%s\"", __func__, path);
 
-	rootdir = nfsd_path_strip(conf_get_str("exports", "rootdir"));
-	if (!rootdir || rootdir[0] ==  '\0')
-		return NULL;
-	if (rootdir[0] == '/' && rootdir[1] == '\0')
-		return NULL;
-	return rootdir;
+        if (!(rootdir = realpath(path, NULL))){
+                free((void*)rootdir);
+                xlog(L_FATAL, "realpath(): Unable to resolve root export path \"%s\"", path);
+        };
+
+        rootdir_pathlen = strlen(rootdir);
 }
 
 char *
 nfsd_path_strip_root(char *pathname)
 {
 	char buffer[PATH_MAX];
-	const char *dir = nfsd_path_nfsd_rootdir();
+	const char *dir = nfsd_path_rootdir();
 
 	if (!dir)
 		goto out;
@@ -106,8 +92,7 @@ nfsd_path_prepend_dir(const char *dir, const char *pathname)
 static void
 nfsd_setup_workqueue(void)
 {
-	const char *rootdir = nfsd_path_nfsd_rootdir();
-
+	nfsd_rootdir_set();
 	if (!rootdir)
 		return;
 
-- 
2.47.1


