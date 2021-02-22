Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3FC320EF6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 02:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBVBO2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 20:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBVBO0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Feb 2021 20:14:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEA9C061574
        for <linux-nfs@vger.kernel.org>; Sun, 21 Feb 2021 17:13:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c19so7406407pjq.3
        for <linux-nfs@vger.kernel.org>; Sun, 21 Feb 2021 17:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asPAwIwv5YWihV4Iy5aP0HAHXRz5lLWKE7DGULAH8VQ=;
        b=thTlxgFKsLa+WGvUiKAu0tzwu4mlI0f0bcgGR3b4dQA985gMr6/S4aXGYshm0GmQrB
         uGSFBTXGaETH6VQ1ZCCFw7211Nat+Dkf5jIl4zlKuVIxbjYd5Gs0maiHuee/8rvSZibi
         AZNnNxyzqtSnKZmdfQaQScDczrN5r/ZupcGqw9IVGbGLJ2r2u9nvQotqQO3k9vXNgRfW
         EikaXW3wBZ5oE0h3bJwvlSy40kxQuxvScVoNzgXJxFqNB+H6O6mWsEuoKRTweOLHlBZE
         Dc68t8sri09r7+pxBgIlpK91veJP0g6JuEEK0bC+5O6dKBPRwpG4HDvsRn7cZ/egukzD
         +0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=asPAwIwv5YWihV4Iy5aP0HAHXRz5lLWKE7DGULAH8VQ=;
        b=K6N30R/uMF4JCFhK939Ynui2f3UVYTKwap/5ZhKy5ItC1gEnQnOinbKS4xGcgbAkB0
         aOerKKcSh0qpKQMmLwiOHceyjJbb5ibbhRU8dWuWX/1rtkbw1Xj2nVxrhifkXuE2E094
         00not3RdtkqKwKZKj6TcDXYYyDwCFK+osBXwWjxRBicrUHayrfv1YWm+cU3hGX0xX76w
         uChMyBpzJ9vRxYoDA3QsFtySz372Zq5CQqQuff+tzbwPwYJxqqgOPyJ9/029+Zbi9H4m
         5XSiQFD8EVeSgqoaHRIVc/6xeMX3yaXVKYrbnR+FPrsYraCFq3LJT5y3iS+gAWJ2P24H
         0eKQ==
X-Gm-Message-State: AOAM532Dn0HLs6aJwRrn09h0dNRtzt+Vwl6DUoW1Z4C6e01PzBPfP07V
        Y1CvNgfi0Cw8lR9mlFcRUaO5hj69N9Y=
X-Google-Smtp-Source: ABdhPJxEI+Gg8S0aOD1h/sdfrVG4/6kpBJp4sEtX4w6i1QBVo/qceX38Yt6GxNYmqXyRuyRmx+aSOw==
X-Received: by 2002:a17:902:9a48:b029:e1:268d:e800 with SMTP id x8-20020a1709029a48b02900e1268de800mr19512004plv.69.1613956425382;
        Sun, 21 Feb 2021 17:13:45 -0800 (PST)
Received: from athena.localdomain ([27.78.217.99])
        by smtp.gmail.com with ESMTPSA id o13sm16486896pgv.40.2021.02.21.17.13.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2021 17:13:44 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] nfsdcltrack: don't assume time_t is long int
Date:   Mon, 22 Feb 2021 08:11:28 +0700
Message-Id: <20210222011128.30378-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.30.1.629.g12f37433bd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In musl 1.2.x, time_t is defined to 64 bit integer unconditionally.
Let's not assume time_t is long int, but always cast to int64_t for
printf(3).

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 inttypes.h and PRId64 is being used by utils/idmapd, so I think we won't have
 more incompatibility problem with this change.
 utils/nfsdcltrack/nfsdcltrack.c | 3 ++-
 utils/nfsdcltrack/sqlite.c      | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
index e926f1c0..5edf0ca4 100644
--- a/utils/nfsdcltrack/nfsdcltrack.c
+++ b/utils/nfsdcltrack/nfsdcltrack.c
@@ -27,6 +27,7 @@
 #include <stdlib.h>
 #include <ctype.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <stdbool.h>
 #include <getopt.h>
 #include <string.h>
@@ -525,7 +526,7 @@ cltrack_gracedone(const char *timestr)
 	if (*tail)
 		return -EINVAL;
 
-	xlog(D_GENERAL, "%s: grace done. gracetime=%ld", __func__, gracetime);
+	xlog(D_GENERAL, "%s: grace done. gracetime=%" PRId64, __func__, (int64_t)gracetime);
 
 	ret = sqlite_remove_unreclaimed(gracetime);
 
diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
index f79aebb3..4ac805b3 100644
--- a/utils/nfsdcltrack/sqlite.c
+++ b/utils/nfsdcltrack/sqlite.c
@@ -40,6 +40,7 @@
 
 #include <dirent.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <string.h>
@@ -544,8 +545,8 @@ sqlite_remove_unreclaimed(time_t grace_start)
 	int ret;
 	char *err = NULL;
 
-	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %ld",
-			grace_start);
+	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %" PRId64,
+			(int64_t)grace_start);
 	if (ret < 0) {
 		return ret;
 	} else if ((size_t)ret >= sizeof(buf)) {
-- 
2.30.1.629.g12f37433bd

