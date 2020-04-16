Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602E11AD2A3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 00:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgDPWPF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 18:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbgDPWPC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:02 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9072223F;
        Thu, 16 Apr 2020 22:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075302;
        bh=XcOH0u56sQC3dCT24oQ04hjxmbOtq4sKYGsePtObZeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qI//DXS3Dl+Ay6ociqIRM5DeFZ6AavbPMvTPyUaWUmEoT+r3ALknm60R0zkV4V3a+
         MztMA31gOCbCmn8q1j2f8+GF1ZHWY40f/lWymgFSO4/qqyibToBfhEwnMhaZG3EBgi
         xB5CC2vWn9ri+VhdF+qcoJg3yR1Ay8alrl84rSOQ=
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] mountd: Fix up path checking helper same_path()
Date:   Thu, 16 Apr 2020 18:12:48 -0400
Message-Id: <20200416221252.82102-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416221252.82102-3-trondmy@kernel.org>
References: <20200416221252.82102-1-trondmy@kernel.org>
 <20200416221252.82102-2-trondmy@kernel.org>
 <20200416221252.82102-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Convert 'same_path()' so that it works when 'rootdir'
is set in the [exports] section of nfs.conf.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/mountd/cache.c | 83 +++++++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index 7d8657c91323..94e9e44b46b9 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -72,6 +72,18 @@ static ssize_t cache_write(int fd, const char *buf, size_t len)
 	return nfsd_path_write(fd, buf, len);
 }
 
+static bool path_lookup_error(int err)
+{
+	switch (err) {
+	case ELOOP:
+	case ENAMETOOLONG:
+	case ENOENT:
+	case ENOTDIR:
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * Support routines for text-based upcalls.
  * Fields are separated by spaces.
@@ -430,23 +442,9 @@ static inline int count_slashes(char *p)
 	return cnt;
 }
 
-static int same_path(char *child, char *parent, int len)
+#if defined(HAVE_STRUCT_FILE_HANDLE)
+static int check_same_path_by_handle(const char *child, const char *parent)
 {
-	static char p[PATH_MAX];
-	struct stat sc, sp;
-
-	if (len <= 0)
-		len = strlen(child);
-	strncpy(p, child, len);
-	p[len] = 0;
-	if (strcmp(p, parent) == 0)
-		return 1;
-
-	/* If number of '/' are different, they must be different */
-	if (count_slashes(p) != count_slashes(parent))
-		return 0;
-
-#if defined(HAVE_NAME_TO_HANDLE_AT) && defined(HAVE_STRUCT_FILE_HANDLE)
 	struct {
 		struct file_handle fh;
 		unsigned char handle[128];
@@ -455,13 +453,17 @@ static int same_path(char *child, char *parent, int len)
 
 	fchild.fh.handle_bytes = 128;
 	fparent.fh.handle_bytes = 128;
-	if (name_to_handle_at(AT_FDCWD, p, &fchild.fh, &mnt_child, 0) != 0) {
-		if (errno == ENOSYS)
-			goto fallback;
-		return 0;
+
+	/* This process should have the CAP_DAC_READ_SEARCH capability */
+	if (nfsd_name_to_handle_at(AT_FDCWD, child, &fchild.fh, &mnt_child, 0) < 0)
+		return -1;
+	if (nfsd_name_to_handle_at(AT_FDCWD, parent, &fparent.fh, &mnt_parent, 0) < 0) {
+		/* If the child resolved, but the parent did not, they differ */
+		if (path_lookup_error(errno))
+			return 0;
+		/* Otherwise, we just don't know */
+		return -1;
 	}
-	if (name_to_handle_at(AT_FDCWD, parent, &fparent.fh, &mnt_parent, 0) != 0)
-		return 0;
 
 	if (mnt_child != mnt_parent ||
 	    fchild.fh.handle_bytes != fparent.fh.handle_bytes ||
@@ -471,14 +473,24 @@ static int same_path(char *child, char *parent, int len)
 		return 0;
 
 	return 1;
-fallback:
+}
+#else
+static int check_same_path_by_handle(const char *child, const char *parent)
+{
+	errno = ENOSYS;
+	return -1;
+}
 #endif
 
+static int check_same_path_by_inode(const char *child, const char *parent)
+{
+	struct stat sc, sp;
+
 	/* This is nearly good enough.  However if a directory is
 	 * bind-mounted in two places and both are exported, it
 	 * could give a false positive
 	 */
-	if (nfsd_path_lstat(p, &sc) != 0)
+	if (nfsd_path_lstat(child, &sc) != 0)
 		return 0;
 	if (nfsd_path_lstat(parent, &sp) != 0)
 		return 0;
@@ -490,6 +502,29 @@ fallback:
 	return 1;
 }
 
+static int same_path(char *child, char *parent, int len)
+{
+	static char p[PATH_MAX];
+	int err;
+
+	if (len <= 0)
+		len = strlen(child);
+	strncpy(p, child, len);
+	p[len] = 0;
+	if (strcmp(p, parent) == 0)
+		return 1;
+
+	/* If number of '/' are different, they must be different */
+	if (count_slashes(p) != count_slashes(parent))
+		return 0;
+
+	/* Try to use filehandle approach before falling back to stat() */
+	err = check_same_path_by_handle(p, parent);
+	if (err != -1)
+		return err;
+	return check_same_path_by_inode(p, parent);
+}
+
 static int is_subdirectory(char *child, char *parent)
 {
 	/* Check is child is strictly a subdirectory of
-- 
2.25.2

