Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01119E300
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 07:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgDDFY5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Apr 2020 01:24:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35754 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDFY4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Apr 2020 01:24:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id a13so4706310pfa.2
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 22:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImWtC4Jz16nGF2vzYYftcDrbYkx4HuFFHw2ldXuCG2w=;
        b=ojlPDbsDISs79Q12lW8gMP3OgW8HjLO9N622wnWbRe0tQuLOhkP97UAFVn+Bu12RQ4
         xvdwQLVdMXHqNlnWD7+B4NWXZDZ6AXIO2kJjJ3FZKu8Y87poQzovDU5NUgQlXZgd0aef
         bKUOm5YGBBZMrNKwWwBpJ58+7fPChNQDQgqK7kyoklmtEVnJr1G74S0TqavLFyu78Ip7
         +yWvygJJyYiaHEByNzv5ax2dG6mvw9ZLhSqJsZyWaY84ZvV6MiKnWQLtPsmJPPvSyA3o
         DJVbRvwWCl5Wb1F7QBi0BAlbQJcYsRbU+IQNpt4r8pIVqsydao53d8Rp7Xc6jkL4HWu8
         J1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImWtC4Jz16nGF2vzYYftcDrbYkx4HuFFHw2ldXuCG2w=;
        b=eBl2fBxfIW4zOQEem9/bQrwrROo952wwCp2K6Z82a4y4DpwjP8r/+SMi1c2lYhIsdT
         VWlhPI8D1FtQRJLoTd94tVjblifOsc+ow8V7FVg2Tg/i/J/7ReTenVQ/9ufm1yQp+UBs
         oD/QHPFomt2tsUyTcFnLi3opvxU2oZtyg4cguaA5eRR/nqhUq5holURp10ESSw/Q4fDg
         hCxVCpH2Mu8+oplESXIjQDEKMlFW0gf63WfPKZrq5vHl7FOQvUNkuXzKXc58QITgS2D6
         gNh/QNiShlRCJpU5UHkc3kV9KuvWPbj1El7H8+8IGqNV4hcmLNy7AKcJTUOvNfpEaUZI
         keUQ==
X-Gm-Message-State: AGi0Pubi48Jt9hhfnQ5nwLnG2XTWz4ldYLOf0i9HCckut4yGAmqpSp4z
        JoC3JYsHRBJ7E0rMwUyh9ZMvoWDW5Tw=
X-Google-Smtp-Source: APiQypJ1f0QvTQhXx8BHsNGSkGJZfaqhG7najpiRz2VmjykHlYNIURk8xn7P2HKqtGZg+guD+VjNvQ==
X-Received: by 2002:a63:705d:: with SMTP id a29mr11142673pgn.304.1585977895337;
        Fri, 03 Apr 2020 22:24:55 -0700 (PDT)
Received: from localhost.localdomain (astound-69-42-19-227.ca.astound.net. [69.42.19.227])
        by smtp.gmail.com with ESMTPSA id n100sm6835531pjc.38.2020.04.03.22.24.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 22:24:54 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfs-utils: print time in 64-bit
Date:   Fri,  3 Apr 2020 22:24:52 -0700
Message-Id: <20200404052453.2631191-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

musl 1.2.0 defines time_t as 64-bit, even under 32-bit OSes.

Fixes -Wformat errors.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 support/nfs/cacheio.c |  3 ++-
 utils/idmapd/idmapd.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
index 7c4cf373..126c1283 100644
--- a/support/nfs/cacheio.c
+++ b/support/nfs/cacheio.c
@@ -20,6 +20,7 @@
 #endif
 
 #include <nfslib.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdio_ext.h>
 #include <string.h>
@@ -238,7 +239,7 @@ cache_flush(int force)
 	    stb.st_mtime > now)
 		stb.st_mtime = time(0);
 	
-	sprintf(stime, "%ld\n", stb.st_mtime);
+	sprintf(stime, "%" PRId64 "\n", (int64_t)stb.st_mtime);
 	for (c=0; cachelist[c]; c++) {
 		int fd;
 		sprintf(path, "/proc/net/rpc/%s/flush", cachelist[c]);
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index c187e7d7..893159f1 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -54,6 +54,7 @@
 #include <dirent.h>
 #include <unistd.h>
 #include <netdb.h>
+#include <inttypes.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -172,7 +173,7 @@ flush_nfsd_cache(char *path, time_t now)
 	int fd;
 	char stime[32];
 
-	sprintf(stime, "%ld\n", now);
+	sprintf(stime, "%" PRId64 "\n", (int64_t)now);
 	fd = open(path, O_RDWR);
 	if (fd == -1)
 		return -1;
@@ -625,8 +626,8 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 		/* Name */
 		addfield(&bp, &bsiz, im.im_name);
 		/* expiry */
-		snprintf(buf1, sizeof(buf1), "%lu",
-			 time(NULL) + cache_entry_expiration);
+		snprintf(buf1, sizeof(buf1), "%" PRId64,
+			 (int64_t)time(NULL) + cache_entry_expiration);
 		addfield(&bp, &bsiz, buf1);
 		/* Note that we don't want to write the id if the mapping
 		 * failed; instead, by leaving it off, we write a negative
@@ -653,8 +654,8 @@ nfsdcb(int UNUSED(fd), short which, void *data)
 		snprintf(buf1, sizeof(buf1), "%u", im.im_id);
 		addfield(&bp, &bsiz, buf1);
 		/* expiry */
-		snprintf(buf1, sizeof(buf1), "%lu",
-			 time(NULL) + cache_entry_expiration);
+		snprintf(buf1, sizeof(buf1), "%" PRId64,
+			 (int64_t)time(NULL) + cache_entry_expiration);
 		addfield(&bp, &bsiz, buf1);
 		/* Note we're ignoring the status field in this case; we'll
 		 * just map to nobody instead. */
-- 
2.25.1

