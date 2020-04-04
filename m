Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B435F19E25C
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 04:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDDCWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 22:22:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40028 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDCWA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Apr 2020 22:22:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so3540260plk.7
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2020 19:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqRzsyJkoc/CwuMypHRqWYz8FRuuf1MkbWEe5TW0st8=;
        b=PXFCg0TYPmh2d11rrwGfa2E8oCwuzu3AjFKEkS8lTDgyAj0mBxcPWtz3mrmMKfsW/e
         9hJ8Ur5ugFqvb7d1itvLFYENbO57TqGqPtGV3Y8msaiVhhCpPMFNNKTuGG5almYhz7nG
         L7bPYgyVQgM3iVJQAOlTAW0indPPWpqIYOU7I5Z1mNRvacJERC337NKMY3iWhEp/odtY
         X6C+Ft9KiU4nefm7AQ880cbOjl5PK6v9mGmRbRY9JZKQ2XCjaSu9K9wzYcdQM/t5aUyn
         vl52wgPkMQtAbPRFE5u+NZ8Bgr7QKcEChwUNAINdCEPJgkHiZnxsn3Dh0ZeFp4UDq4zC
         RYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqRzsyJkoc/CwuMypHRqWYz8FRuuf1MkbWEe5TW0st8=;
        b=ukiHXO2qZHgsdrNHYa2m3eBVguHIuWjJEwmaqw2TE0MbZs+hAOJjI5H/jJgi3+xDSn
         A/U4AvSi2Mi4r1GTZGdauwkui6jx/du6Y48Ai6yVtSuItJW7RgiipSg1ViBXKt8eVhfg
         JQzi9BSODXPcs8um0t/KEaT3oM65i9tFeX2/3YvMchkVSLVFEP7VCzoRpCfRv7Fx1BzN
         9hmIjMEE/OfvM4/1iU04QYKIvNMpWhPZBpzJhXh7hlB5cmJn2bjJ8QF9USruPJgt2j1q
         0JUGSNZsep6QI3lhCOXDcxGONPCD5P6fXfbQyVCHR9Vhal1JrB0khpXTne3nziODlZQq
         6VUQ==
X-Gm-Message-State: AGi0PubTbwhEhjJ3jl1NhD7wLpftOPvu8ZbcKqntmCY3xZYwneDKj5LS
        w7JSWeukSzqUbMkcdsSoqs9xpIiNO/E=
X-Google-Smtp-Source: APiQypK01Jv6lzKi7e2W4ARZQESmL8HnfnPRN7aWfVwsjzXqekBLrSsKVifVR3waMK0OLWyRSOn+4Q==
X-Received: by 2002:a17:90a:26ed:: with SMTP id m100mr13346120pje.130.1585966918699;
        Fri, 03 Apr 2020 19:21:58 -0700 (PDT)
Received: from localhost.localdomain (astound-69-42-19-227.ca.astound.net. [69.42.19.227])
        by smtp.gmail.com with ESMTPSA id iq23sm6711429pjb.18.2020.04.03.19.21.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 19:21:58 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs-utils: print time in 64-bit
Date:   Fri,  3 Apr 2020 19:21:56 -0700
Message-Id: <20200404022156.3731617-1-rosenp@gmail.com>
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
 support/nfs/cacheio.c |  2 +-
 utils/idmapd/idmapd.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
index 7c4cf373..5e47078c 100644
--- a/support/nfs/cacheio.c
+++ b/support/nfs/cacheio.c
@@ -238,7 +238,7 @@ cache_flush(int force)
 	    stb.st_mtime > now)
 		stb.st_mtime = time(0);
 	
-	sprintf(stime, "%ld\n", stb.st_mtime);
+	sprintf(stime, "%" PRId64 "\n", (int64_t)stb.st_mtime);
 	for (c=0; cachelist[c]; c++) {
 		int fd;
 		sprintf(path, "/proc/net/rpc/%s/flush", cachelist[c]);
diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index c187e7d7..fe62e2b5 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -172,7 +172,7 @@ flush_nfsd_cache(char *path, time_t now)
 	int fd;
 	char stime[32];
 
-	sprintf(stime, "%ld\n", now);
+	sprintf(stime, "%" PRId64 "\n", (int64_t)now);
 	fd = open(path, O_RDWR);
 	if (fd == -1)
 		return -1;
@@ -625,8 +625,8 @@ nfsdcb(int UNUSED(fd), short which, void *data)
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
@@ -653,8 +653,8 @@ nfsdcb(int UNUSED(fd), short which, void *data)
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

