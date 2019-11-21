Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0A105CED
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2019 23:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfKUW7r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Nov 2019 17:59:47 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40375 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfKUW7r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Nov 2019 17:59:47 -0500
Received: by mail-wr1-f46.google.com with SMTP id 4so3109679wro.7
        for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2019 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=rzeSICxLoPAd1vV48i7uar+sl3/GzKFuv/3pZCGplxM=;
        b=Q5NlYBV0Tv3k0Vftf+S6/WzhuoZI/vUbsxirNQIjR3ShQ3LF4fTz3IOAgK4exTYC/i
         w3gX1fxQu/umZGbg4G2OS/kG7bDcH7wleyNxosXyA68j2Qwo8Uuq0YYLp5DrVoa8ah0h
         mQionoZ2rHFu9AtxMJUtKSa1GpQqbddIUdYC3pJbgqmoMCDrNnEBWqy2KVJqnAoZnTdT
         6TEG4PI/0c81wjNHaundKe59XxDkj4XweEl/uOcCwd7eBaKQxPuaiZwpOCLWTnZ2BSTt
         aN6jpWIf6abqHBRkqYSm6oop6uPrL1t6jvKkBh4pS/Nw1KitkHrrKfAoqcWnSnI/5Sxq
         yqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=rzeSICxLoPAd1vV48i7uar+sl3/GzKFuv/3pZCGplxM=;
        b=Ur+wCXYUjPgu/GyqFr8/cQW7DDD8NvI7O/VrlfaOxcq+B5kAA4ubrbQlU5+dAhgv1l
         xYjaaw+EXUzFAUtZSKfV9CHxGAWcQYdMFfuT8sBlYnIeDnCF/3Pl5zjACCkrLDLDMCDz
         PqMHyxQ4yl7idIjT78Fem2R6vfZadQpoz4SKRMCJwjTySBPnAfCKjpNzI1LEJnTACf22
         83fC767DC3HOKJ8lJAm5Ea7K//oGSF1grhwJWjBFCYHEKxO+l8HiMa/B8Dw7zcuttHAZ
         LVdKH7s93ymLjAdEADMqPAs1/9rUzQjpWdV/wpBJuaCtTj8/ZGSiZBQruvBi/EayXIg3
         91xA==
X-Gm-Message-State: APjAAAX25JgCTmwhj/mDCjWAM+sG1xkTcCtM0KWM03NswUULdFsGHayc
        84IKsJUEKAeFvlZHNN7EjFjJI++A
X-Google-Smtp-Source: APXvYqz/zOEyY40mhOUTkTOzZ34rLep1eO5GwlurACgz6U6Y7U3mpUPeRufYc//FnIF5XoPS6O9BNg==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr12965135wro.259.1574377184420;
        Thu, 21 Nov 2019 14:59:44 -0800 (PST)
Received: from beria.zarb.org ([2a01:e34:ec77:3c10:d494:2021:7d1b:e24])
        by smtp.gmail.com with ESMTPSA id v9sm4754806wrs.95.2019.11.21.14.59.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:59:43 -0800 (PST)
To:     linux-nfs@vger.kernel.org
From:   Guillaume Rousse <guillomovitch@gmail.com>
Subject: [patch] fix compilation with -Werror=format on i586
Message-ID: <d21f152d-1d9d-01c2-900e-39c67eb2cef3@gmail.com>
Date:   Thu, 21 Nov 2019 23:59:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C87B67B5FB2D5847333557BA"
Content-Language: fr-FR
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------C87B67B5FB2D5847333557BA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


--------------C87B67B5FB2D5847333557BA
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-fix-compilation-with-Werror-format-on-i586.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fix-compilation-with-Werror-format-on-i586.patch"

From 571884617231dc4bc70caafd69a62c86e2bca445 Mon Sep 17 00:00:00 2001
From: Guillaume Rousse <guillomovitch@gmail.com>
Date: Thu, 21 Nov 2019 23:58:57 +0100
Subject: [PATCH] fix compilation with  -Werror=format on i586

---
 support/junction/xml.c  |  2 +-
 tools/locktest/testlk.c |  2 +-
 utils/nfsdcld/nfsdcld.c | 14 +++++++-------
 utils/nfsdcld/sqlite.c  |  6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/support/junction/xml.c b/support/junction/xml.c
index 7005e95e..813110b4 100644
--- a/support/junction/xml.c
+++ b/support/junction/xml.c
@@ -327,7 +327,7 @@ junction_parse_xml_read(const char *pathname, int fd, const char *name,
 	if (retval != FEDFS_OK)
 		return retval;
 
-	xlog(D_CALL, "%s: XML document contained in junction:\n%ld.%s",
+	xlog(D_CALL, "%s: XML document contained in junction:\n%zu.%s",
 		__func__, len, (char *)buf);
 
 	retval = junction_parse_xml_buf(pathname, name, buf, len, doc);
diff --git a/tools/locktest/testlk.c b/tools/locktest/testlk.c
index b392f711..ea51f788 100644
--- a/tools/locktest/testlk.c
+++ b/tools/locktest/testlk.c
@@ -81,7 +81,7 @@ main(int argc, char **argv)
 		if (fl.l_type == F_UNLCK) {
 			printf("%s: no conflicting lock\n", fname);
 		} else {
-			printf("%s: conflicting lock by %d on (%ld;%ld)\n",
+			printf("%s: conflicting lock by %d on (%zd;%zd)\n",
 				fname, fl.l_pid, fl.l_start, fl.l_len);
 		}
 		return 0;
diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
index b064336d..9297df51 100644
--- a/utils/nfsdcld/nfsdcld.c
+++ b/utils/nfsdcld/nfsdcld.c
@@ -378,7 +378,7 @@ cld_not_implemented(struct cld_client *clnt)
 	bsize = cld_message_size(cmsg);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize)
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 
 	/* reopen pipe, just to be sure */
@@ -409,7 +409,7 @@ cld_get_version(struct cld_client *clnt)
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -459,7 +459,7 @@ reply:
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -498,7 +498,7 @@ reply:
 			cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -548,7 +548,7 @@ reply:
 			cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -607,7 +607,7 @@ reply:
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
@@ -667,7 +667,7 @@ reply:
 	xlog(D_GENERAL, "Doing downcall with status %d", cmsg->cm_status);
 	wsize = atomicio((void *)write, clnt->cl_fd, cmsg, bsize);
 	if (wsize != bsize) {
-		xlog(L_ERROR, "%s: problem writing to cld pipe (%ld): %m",
+		xlog(L_ERROR, "%s: problem writing to cld pipe (%zd): %m",
 			 __func__, wsize);
 		ret = cld_pipe_open(clnt);
 		if (ret) {
diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 23be7971..09518e22 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -512,7 +512,7 @@ sqlite_startup_query_grace(void)
 	current_epoch = tcur;
 	recovery_epoch = trec;
 	ret = 0;
-	xlog(D_GENERAL, "%s: current_epoch=%lu recovery_epoch=%lu",
+	xlog(D_GENERAL, "%s: current_epoch=%"PRIu64" recovery_epoch=%"PRIu64,
 		__func__, current_epoch, recovery_epoch);
 out:
 	sqlite3_finalize(stmt);
@@ -1223,7 +1223,7 @@ sqlite_grace_start(void)
 
 	current_epoch = tcur;
 	recovery_epoch = trec;
-	xlog(D_GENERAL, "%s: current_epoch=%lu recovery_epoch=%lu",
+	xlog(D_GENERAL, "%s: current_epoch=%"PRIu64" recovery_epoch=%"PRIu64,
 		__func__, current_epoch, recovery_epoch);
 
 out:
@@ -1282,7 +1282,7 @@ sqlite_grace_done(void)
 	}
 
 	recovery_epoch = 0;
-	xlog(D_GENERAL, "%s: current_epoch=%lu recovery_epoch=%lu",
+	xlog(D_GENERAL, "%s: current_epoch=%"PRIu64" recovery_epoch=%"PRIu64,
 		__func__, current_epoch, recovery_epoch);
 
 out:
-- 
2.23.0


--------------C87B67B5FB2D5847333557BA--
