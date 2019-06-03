Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC73364F
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfFCRP6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 13:15:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39751 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbfFCRP5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jun 2019 13:15:57 -0400
Received: by mail-it1-f195.google.com with SMTP id j204so22482183ite.4
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2019 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54eXN7xcmcx5yI3W1cCqULRllgy5g2GJtxxP9B6eUlU=;
        b=Vue87Z9+wKhPUx22cv1MMj9KcgiBhGjP3NxmET8NwQtdydsbYU+C2Y7rg2jC5vsALW
         0Ww7DpF6ta1Fw6bCzqOomhgMHlP0fvl8onn1Wb/JgDgweCckYshpY95jWfvRmzT0idB5
         mAArlFEUoNMqGFL9BwLlNRCSs5JElYul56FWlbhfBsZ2r3QAf9Q/LC6zpIzD2mccgrk2
         4fu2gyapaaOr7iiecrh+HiQtE8VIjR38UMxflo902lsBThXzk2PP6HzD4TtVxyHUj7A6
         Vp6cFIiIgG/MXlnzg+MudLfiQqvolB5ighghNx7ojbl1ngemdUg8PnZp7YwHrgSEmiPj
         X0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54eXN7xcmcx5yI3W1cCqULRllgy5g2GJtxxP9B6eUlU=;
        b=CZGGyetdfYtKkiBrxsftCxbPF1nY9/3Ckumqd+lz8Pgw0UfKvuGXkEEuY7EElcCmyK
         HmKjLO/7pJH+BEKf/f6ZBBT2+6OggSciL1+EU1fARUrsaHtHIrbBQdBTmGbEpR9BrKVs
         nYtQI08ctQqZ0m3Limp6+Uf43g80mAGhTutv05yLbePXUUUWxd2xQAXMnIgFUCR4YjRc
         +67xdM2KoTT2vZMWmR8ArOhv0AVIlSt9EkQqTG/BYonfFhWGlBvmXYhshu7B1GbPx1rR
         ltwy1CmYnKJJgCga6a9oqZ2aI6Npniw9rhl3b9H2yiL+eTxFz5jPkpb2IUADHephOq+0
         yi7A==
X-Gm-Message-State: APjAAAWLyKMYBDWya2fhb2EM3B97OGa+SP4P31am3GER1O949V2x+oel
        bRBo+OQ6DWEBqw41FJ4GWlUhG/Q=
X-Google-Smtp-Source: APXvYqzy5m9NUcbwSEdQiZeUWdu8MlNmDsWkEcuBlyCir3gMP628fIJC56Mu7ucbBYfoof3AL+ZkQw==
X-Received: by 2002:a02:7715:: with SMTP id g21mr17853440jac.24.1559582156589;
        Mon, 03 Jun 2019 10:15:56 -0700 (PDT)
Received: from localhost.localdomain (50-36-175-138.alma.mi.frontiernet.net. [50.36.175.138])
        by smtp.gmail.com with ESMTPSA id b8sm1971375ioj.16.2019.06.03.10.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:15:55 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] mountd: Ensure nfsd_path_strip_root() uses the canonicalised path
Date:   Mon,  3 Jun 2019 13:12:26 -0400
Message-Id: <20190603171227.29148-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603171227.29148-2-trond.myklebust@hammerspace.com>
References: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
 <20190603171227.29148-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When attempting to strip the root path, we should first canonicalise
the root pathname.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/misc/nfsd_path.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 2f41a793c534..9b38dd96007f 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <limits.h>
 #include <stdlib.h>
 #include <unistd.h>
 
@@ -62,13 +63,21 @@ nfsd_path_nfsd_rootdir(void)
 char *
 nfsd_path_strip_root(char *pathname)
 {
+	char buffer[PATH_MAX];
 	const char *dir = nfsd_path_nfsd_rootdir();
 	char *ret;
 
-	ret = strstr(pathname, dir);
-	if (!ret || ret != pathname)
-		return pathname;
-	return pathname + strlen(dir);
+	if (!dir)
+		goto out;
+	if (realpath(dir, buffer)) {
+		ret = strstr(pathname, buffer);
+		if (ret == pathname)
+			return pathname + strlen(dir);
+	} else
+		xlog(D_GENERAL, "%s: failed to resolve path %s: %m",
+				__func__, dir);
+out:
+	return pathname;
 }
 
 char *
-- 
2.21.0

