Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA419E26C
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 05:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDDDD1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 23:03:27 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39401 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgDDDD1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 23:03:27 -0400
Received: by mail-pf1-f182.google.com with SMTP id k15so4587260pfh.6
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 20:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t5ZesI1XBvLSF9A84hXDheobKplhPOXkHL/4QSbwZA0=;
        b=SN+eLgvV2xdvFRRCsNUG4UFB0dXVpCRW/0ewC8cKHMGWTnIrFwetNO9JxqF6fJNdCk
         R3Cfkf3mxXuW8WD8MP5Cq7s5J8zF/IkGj5rxD0XOG5dR348fCSwgKTey0Mqf6NzBaAv+
         /g0UDz/zqlBvJ+dV+8GAY3pSblKIvAXdZET5IYHgwC+YxL5LR0IPGPw5yFnizi480ulH
         DXMch1Lv5sqKtmPW4BpUtRyGXX5Ht/4xv0FOL2AqIX5lJ27bnj5zTMuqHGhD+stIa+4I
         mZxcsruq4bpdNu3hZ7cCvfY2CzKk7dPX+mqZqAMm0lXL+HGwdHERoYOPdQnjHmHLIoHr
         GK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t5ZesI1XBvLSF9A84hXDheobKplhPOXkHL/4QSbwZA0=;
        b=MQqJH55SPEZnTigUaMrqGMWyjm10vnZSv5lOdmKRl2TY1l54BJMtnSOuRyHCTRRQ2e
         2hfZDBXOLn0mYn3N79TcA1q2rEnftVQ8wPw+hNGI3gy/n7JfywyeYvGsLXiC9TFFhNYt
         bI4TAKqxdukihcWQR7JjliQNJakQSU08/ApKlrKUc2FqyzhZK+7ptZbclvQTPLQn53IB
         3p7uJDzOOn+YeSTtfytoBAcEKRR8J6l090nVzEa2mutHmJfM/9Pat2eP1Cmh+t+lg9fL
         l/j1gDCDcsdutpUj0Z3GW6v1H4OR/FRJuzWqNVz1Ov2tgrQc1OrKbqA4hhoJbr2QsfuM
         x0nQ==
X-Gm-Message-State: AGi0PuaPbhEeQNNH6cox7XGYgQx38XZtUPKmy+QytFl/9xVblDlDrWlC
        WbZSj9WRPfWlAhTpJGXayOsJ5a1B2/s=
X-Google-Smtp-Source: APiQypJF4nNv7WSgRslIQBVNwmSRn83iXSk98uEyKhME3MWpNV9AnVpcZO3AkC/tG29EUJ8MGB6Hvw==
X-Received: by 2002:a63:700f:: with SMTP id l15mr8199257pgc.375.1585969405832;
        Fri, 03 Apr 2020 20:03:25 -0700 (PDT)
Received: from localhost.localdomain (astound-69-42-19-227.ca.astound.net. [69.42.19.227])
        by smtp.gmail.com with ESMTPSA id q12sm6689092pfs.48.2020.04.03.20.03.25
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 20:03:25 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCHv2] nfs-utils: print time in 64-bit
Date:   Fri,  3 Apr 2020 20:03:24 -0700
Message-Id: <20200404030324.509218-1-rosenp@gmail.com>
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
 v2: Added missing header.
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

