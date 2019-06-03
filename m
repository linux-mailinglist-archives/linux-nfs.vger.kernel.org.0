Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CAE33650
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfFCRP7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 13:15:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41254 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfFCRP6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jun 2019 13:15:58 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so14926258ioc.8
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2019 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1UkUfTZsFI//kdDQAkgjA8sveaR01sXEVy3hYpGpgU=;
        b=O+PWbM4X5IO/s7or71I4Nisp4D6ldT9VlOAVIMGioG4xDqAmF7IXYEQ1d1E8u+aX7R
         CAHFlj8LZgomtIi0XTt4AVICdFclpp2hhEgwuPbtRDuYnK8W85xF0AMT306NxpZRUjji
         VAeon4QPwE5oIYKfyUgjTOs5ZkaGcK8f7RZYMxBxxTVcVoaLc44n21YGCH+IRDvTjB3B
         sh65XncYpp2CsqYyl/sprfCekuKM9rkDkKTycRv6OUrb20XpfzLs+ZBKWRARjF4ERD+j
         Av0bzhwxKDKWPGj6+66er6SPppIos+ANEp/FtHZ3g+jtzHVRTSvlfJnks2rFTWkHZYPD
         YIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1UkUfTZsFI//kdDQAkgjA8sveaR01sXEVy3hYpGpgU=;
        b=gtH0tNT5V9CIInvpCn3IsiN0qjLt7f/ZTOfV6n8ow0Nahp3FyLUqU6DxZ/ISkh2Ml4
         dHMTMSHP0H2Ph+BghZ7n4gGJUnuL+ZlypFj4A2iQctuN3oSAFKTughVXm1+HaY3ILZrS
         +3ZijloE8opX3WnETkV8rpZZADK44VbC9ZU4S4iEaMowJJTq0co9YL1v6lJ8jp/d2AXR
         YCayCVOMsaemtQJqTYIbj+c7/i80l1wIAt3MVBggonuUPA+U5rGrdIbW1IIyX2WnVqhm
         JnbT27bzCvA0leAYx0T0TbmOkGxfvzuUGFkWj8j8RxfqQSFc/yzS3j+w0nhso5+jeRa4
         SJgg==
X-Gm-Message-State: APjAAAWIt2epoX+j4CY0LSPLvQY1NJOYwj0WFsVq4xvg1gPAA5mMwuNW
        x+AgVuk9oPjeJhCUDgWeAQAbd9s=
X-Google-Smtp-Source: APXvYqxVK8DlWi0F9zjydtMLkKHQYdYkxdVnueulwP3Xm2u4AvUnwiQEkxDuqN03lq0fCI8w8/8EqA==
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr11490728ioq.50.1559582157600;
        Mon, 03 Jun 2019 10:15:57 -0700 (PDT)
Received: from localhost.localdomain (50-36-175-138.alma.mi.frontiernet.net. [50.36.175.138])
        by smtp.gmail.com with ESMTPSA id b8sm1971375ioj.16.2019.06.03.10.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:15:56 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] mountd: Canonicalise the rootdir in exportent_mkrealpath()
Date:   Mon,  3 Jun 2019 13:12:27 -0400
Message-Id: <20190603171227.29148-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603171227.29148-3-trond.myklebust@hammerspace.com>
References: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
 <20190603171227.29148-2-trond.myklebust@hammerspace.com>
 <20190603171227.29148-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we canonicalise the export path when generating the
real path.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/export/export.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/support/export/export.c b/support/export/export.c
index 82bbb54c5e9e..c753f68e4d63 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -14,6 +14,7 @@
 #include <sys/types.h>
 #include <sys/param.h>
 #include <netinet/in.h>
+#include <limits.h>
 #include <stdlib.h>
 #include <dirent.h>
 #include <errno.h>
@@ -21,6 +22,7 @@
 #include "nfslib.h"
 #include "exportfs.h"
 #include "nfsd_path.h"
+#include "xlog.h"
 
 exp_hash_table exportlist[MCL_MAXTYPES] = {{NULL, {{NULL,NULL}, }}, }; 
 static int export_hash(char *);
@@ -38,8 +40,14 @@ exportent_mkrealpath(struct exportent *eep)
 	const char *chroot = nfsd_path_nfsd_rootdir();
 	char *ret = NULL;
 
-	if (chroot)
-		ret = nfsd_path_prepend_dir(chroot, eep->e_path);
+	if (chroot) {
+		char buffer[PATH_MAX];
+		if (realpath(chroot, buffer))
+			ret = nfsd_path_prepend_dir(buffer, eep->e_path);
+		else
+			xlog(D_GENERAL, "%s: failed to resolve path %s: %m",
+					__func__, chroot);
+	}
 	if (!ret)
 		ret = xstrdup(eep->e_path);
 	eep->e_realpath = ret;
-- 
2.21.0

