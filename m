Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA434F75
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 19:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFDR7s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 13:59:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33884 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfFDR7r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jun 2019 13:59:47 -0400
Received: by mail-it1-f194.google.com with SMTP id u124so3149495itc.1
        for <linux-nfs@vger.kernel.org>; Tue, 04 Jun 2019 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1UkUfTZsFI//kdDQAkgjA8sveaR01sXEVy3hYpGpgU=;
        b=Xu4NxJaHDjm65MH4JTo/NY0/1t8cCRg+hy7oxY7LM6Ck4UO+By9GHRy3pggsM5v85b
         rZH7125ctjq3V8gIPD6WP+aT478pMPPSpdFw/26Ah3TC2UvswOAzDq0uFroeWdfI9PLF
         2Q8wFrZdAcYyAVTLRRXBKlgrCxtB8/zLZhNlXMPouH7lY286GObFOdX3BclxQNl5k/ZH
         +z9N/dTR5sSpE0D1qZx0h84EvKrX69VxoWJy4fuVteZG5brYbnXKT4vCCaiw9CWjy4XJ
         f3cicqyI8Ku/CZuV4j31IBkLF3DVLVVdTTlStzz6ROWETbZCQuknLN6PLP4DKh+ie8D+
         Z6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1UkUfTZsFI//kdDQAkgjA8sveaR01sXEVy3hYpGpgU=;
        b=HbbJPYhxTiBgJ2MQfM7kE9HNHH6JWkOTq+Glj45zGpXV04wE+fp2G8vHlYEvO3lhru
         Xt7TgkOcYqzuvIloi9gzAlN5O9LKEhN5dZC/0UpHCfWBHG42NN3vGa5q+f/+WD2mSW9U
         xLoYmOv4YF94h9zoQlkVAZaxwqmvBVwrTDibBwoY1PhSBTeZ8hvWlo9HIGVvJeABaqSu
         85JsVqpvXV0NPMxiqmGp2ffAxYGY7/HjGl5VUihw7ODuD7RByhSfLFL9ETKgtjL05gQ7
         hMgoD3BMzRDaYTjoqdG+07YJLF8u4vehuXRRZgL4AY4gWEevtt2QpW+edyOqwiep0gDb
         nGjQ==
X-Gm-Message-State: APjAAAVnCGI/cfHYTmKJjxWj8B4GELf3MYuKFkaQl9nFzQ93ULVIf4Rx
        4W7T6YDwSpuofqTh5ETi7NjLJr0=
X-Google-Smtp-Source: APXvYqxTtSRHJShgK6pBgjXNodxETMrwf+rto4FTPl7F553KXVheZD1cQOHUCEg4Ux3o4DcNcakbEA==
X-Received: by 2002:a02:7b2d:: with SMTP id q45mr18317268jac.127.1559671186597;
        Tue, 04 Jun 2019 10:59:46 -0700 (PDT)
Received: from localhost.localdomain (50-36-175-138.alma.mi.frontiernet.net. [50.36.175.138])
        by smtp.gmail.com with ESMTPSA id u134sm8355134itb.32.2019.06.04.10.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 10:59:45 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] mountd: Canonicalise the rootdir in exportent_mkrealpath()
Date:   Tue,  4 Jun 2019 13:57:34 -0400
Message-Id: <20190604175734.98657-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604175734.98657-3-trond.myklebust@hammerspace.com>
References: <20190604175734.98657-1-trond.myklebust@hammerspace.com>
 <20190604175734.98657-2-trond.myklebust@hammerspace.com>
 <20190604175734.98657-3-trond.myklebust@hammerspace.com>
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

