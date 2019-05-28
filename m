Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3322D06E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1Ude (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53446 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfE1Ude (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:34 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so6581279ita.3
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XCyxEssCkoFUZsF1Xsl+Bt7IoweXokZG+MQ8pRyU00=;
        b=iYWsyzTpesb37ABSyErBixcQaBLSmpgpRKwsTAsc9QS/V7xhiUXaC2YvHyCtnKfv44
         713byh221DuRvCrxlYyybI7sgC5nfOpm9qukze53Ug/XmilrnmRico9EO1wVteozRrm0
         jMaa0OtY3wvzZb/ibt1YjoXVmZJPJaf782H6Gi+vy5/aDYFaEwhuy2pNTNCdBKkQcRzB
         a2Z6r8eAKp56sz3jv6QrVL0iqrQwCXgP3PyGlLqhGR49am+GELAFd6aqE6mCRAZVvTmc
         QusXlujWNCSty+xyAwYVZig6QPnlSV0l4CtG3MCGg5FReAxGYAYslgCRWdcbgsUmq+W1
         D9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XCyxEssCkoFUZsF1Xsl+Bt7IoweXokZG+MQ8pRyU00=;
        b=LFT9ZP4aCC0fYH+gy7ybrmmRi7iTYlVW5SfSbPkdeoRXouEHZefnoweFfPr1xxe6oV
         7pf5Id2GeiFLu6OAYmRlsM/nyUbzbdYEb6cD36yKWIvJdkctKQJrMb5DLGzYTcUMPBho
         6fv6Kq7HQqzBPV5ETLTKFepTZx5pZ+cXk0IOyosHPmzyptmEF4mMvtao4/DZOsAfgTan
         kBvVyjhJsKznZWac12WQj5EXU6HKJvwQupfb341QGWbhjNCNwT0b8R2oj2RLz2QR6SI5
         La9YraahJS69PJ6P9ZPynK6S1Uyafowf/XUtCGZw4efnan3eb50TyCG8akRQeRMnIxqK
         rljQ==
X-Gm-Message-State: APjAAAV5sJa9qNH14Zlfqyjjc2Guzg+5Jixb+IhQqa1cCp/7cQomhfr7
        mtMIIraClskbLtpcrMMKbA==
X-Google-Smtp-Source: APXvYqyVRTrlcTE9PIeFlSHADdgq0FGBprHLbKc/OSpEetB4WY+PDMJy/IHseSfhhXWkTffksTXB7w==
X-Received: by 2002:a24:5fc2:: with SMTP id r185mr4444465itb.43.1559075613430;
        Tue, 28 May 2019 13:33:33 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:32 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 03/11] Allow callers to check mountpoint status using a custom lstat function
Date:   Tue, 28 May 2019 16:31:14 -0400
Message-Id: <20190528203122.11401-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-3-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/include/misc.h    | 7 ++++++-
 support/misc/mountpoint.c | 8 +++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/support/include/misc.h b/support/include/misc.h
index 06e2a0c7b061..2b0fef26cb11 100644
--- a/support/include/misc.h
+++ b/support/include/misc.h
@@ -18,7 +18,12 @@ int	weakrandomkey(unsigned char *keyout, int len);
 char *generic_make_pathname(const char *, const char *);
 _Bool generic_setup_basedir(const char *, const char *, char *, const size_t);
 
-extern int is_mountpoint(char *path);
+struct stat;
+
+extern int check_is_mountpoint(const char *path,
+		int (mystat)(const char *, struct stat *));
+#define is_mountpoint(path) \
+	check_is_mountpoint(path, NULL)
 
 /* size of the file pointer buffers for rpc procfs files */
 #define RPC_CHAN_BUF_SIZE 32768
diff --git a/support/misc/mountpoint.c b/support/misc/mountpoint.c
index 9f9ce44ec1e3..c6217f2458d1 100644
--- a/support/misc/mountpoint.c
+++ b/support/misc/mountpoint.c
@@ -9,8 +9,10 @@
 #include "misc.h"
 
 int
-is_mountpoint(char *path)
+check_is_mountpoint(const char *path, int (mystat)(const char *, struct stat *))
 {
+	if (!mystat)
+		mystat = lstat;
 	/* Check if 'path' is a current mountpoint.
 	 * Possibly we should also check it is the mountpoint of the 
 	 * filesystem holding the target directory, but there doesn't
@@ -26,8 +28,8 @@ is_mountpoint(char *path)
 	dotdot = xmalloc(strlen(path)+4);
 
 	strcat(strcpy(dotdot, path), "/..");
-	if (lstat(path, &stb) != 0 ||
-	    lstat(dotdot, &pstb) != 0)
+	if (mystat(path, &stb) != 0 ||
+	    mystat(dotdot, &pstb) != 0)
 		rv = 0;
 	else
 		if (stb.st_dev != pstb.st_dev ||
-- 
2.21.0

