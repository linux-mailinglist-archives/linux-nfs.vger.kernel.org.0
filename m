Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA79534F74
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFDR7q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 13:59:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33967 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfFDR7q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jun 2019 13:59:46 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so18103038iot.1
        for <linux-nfs@vger.kernel.org>; Tue, 04 Jun 2019 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuScPeIemDw/G/sUVtG0oFFkp5S32VkMHRBfBR4eWwQ=;
        b=iRFIuiVJ0scLS2gACm+2X3EUXYKGNWUxw6jtEOYwEaB8FBjnigZ47P825UOfki4+1e
         LvSlAHJM2pnSf1XJKj7g7AyytdBjoArBS7x9AjEuOsQgqTlQJWwQGozuQy0iCFG7CKPR
         U2MENpJBVjtL7VdL2P+iOGpXfa54NO44o41v+hOgcwNjCAK8Tb0mxvCZNVoAwZYh/g3N
         9nOqfcQEDrBm3TRtAq3nGmPn1b57ZcwDs/Vnw+79Xie9hf693LGfCgUpFF2ci7iPxCMm
         mSpoF1LDWLsD5n2b5Xz8W8fbECQ2XHgwEPFIpWbOEVoavOwwFbvQx0HBfsNAJCDWwlsk
         cVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuScPeIemDw/G/sUVtG0oFFkp5S32VkMHRBfBR4eWwQ=;
        b=qrmjqQ6UAvJHzFAe6thaXw7G31HGM2dTGXPpdQp6OSH2v3XeahdtmdJ45PBMjlHTDv
         kWVEYnJZ0LwOzl1YWDLL2JSivT2O2memfaE8wFMbM92A1518jcar+8xGvn9oC6FRA45U
         NMAqzjyMjn188iUsz5SITjsn/tHCUc39aVOR3SvKyrksS8n+zvNdGLpo3svbyM5o4lWr
         GtHo+9dqVgRp4Zz0G+TQaulf8F2nvdM3P7rGJRDgX7HINdwgA4DZZhUbCuqB4bBle4wy
         EQuppwcsYVHk5D2rDNWMXdONAHIA85vLbA0JiPW1Ika7glq7zaDm0QCnaepHAuK0TM1R
         hiVw==
X-Gm-Message-State: APjAAAX5xD1EGC0VePkYHtwU83FnvJKyA21XJM8RS2tYnCmfNw65ddGE
        vtykdqAMnLPUtY5gx3aXpA==
X-Google-Smtp-Source: APXvYqzoIMCjEjVxXQTOT9UQ07PPLSFNmeUKMYQFe4hlZsb5ZPW0OC0LPaBjgRB0+npLBxKQE9reJQ==
X-Received: by 2002:a6b:7017:: with SMTP id l23mr19231765ioc.159.1559671185340;
        Tue, 04 Jun 2019 10:59:45 -0700 (PDT)
Received: from localhost.localdomain (50-36-175-138.alma.mi.frontiernet.net. [50.36.175.138])
        by smtp.gmail.com with ESMTPSA id u134sm8355134itb.32.2019.06.04.10.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 10:59:44 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] mountd: Ensure nfsd_path_strip_root() uses the canonicalised path
Date:   Tue,  4 Jun 2019 13:57:33 -0400
Message-Id: <20190604175734.98657-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604175734.98657-2-trond.myklebust@hammerspace.com>
References: <20190604175734.98657-1-trond.myklebust@hammerspace.com>
 <20190604175734.98657-2-trond.myklebust@hammerspace.com>
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
 support/misc/nfsd_path.c | 17 ++++++++++++-----
 utils/mountd/cache.c     |  6 ++++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 2f41a793c534..84e48028071c 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <limits.h>
 #include <stdlib.h>
 #include <unistd.h>
 
@@ -62,13 +63,19 @@ nfsd_path_nfsd_rootdir(void)
 char *
 nfsd_path_strip_root(char *pathname)
 {
+	char buffer[PATH_MAX];
 	const char *dir = nfsd_path_nfsd_rootdir();
-	char *ret;
 
-	ret = strstr(pathname, dir);
-	if (!ret || ret != pathname)
-		return pathname;
-	return pathname + strlen(dir);
+	if (!dir)
+		goto out;
+
+	if (realpath(dir, buffer))
+		return strstr(pathname, buffer) == pathname ?
+			pathname + strlen(buffer) : NULL;
+
+	xlog(D_GENERAL, "%s: failed to resolve path %s: %m", __func__, dir);
+out:
+	return pathname;
 }
 
 char *
diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index d616d526667e..ecda18c75a0f 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -390,7 +390,6 @@ static char *next_mnt(void **v, char *p)
 	FILE *f;
 	struct mntent *me;
 	size_t l = strlen(p);
-	char *mnt_dir = NULL;
 
 	if (*v == NULL) {
 		f = setmntent("/etc/mtab", "r");
@@ -398,7 +397,10 @@ static char *next_mnt(void **v, char *p)
 	} else
 		f = *v;
 	while ((me = getmntent(f)) != NULL && l > 1) {
-		mnt_dir = nfsd_path_strip_root(me->mnt_dir);
+		char *mnt_dir = nfsd_path_strip_root(me->mnt_dir);
+
+		if (!mnt_dir)
+			continue;
 
 		if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] == '/')
 			return mnt_dir;
-- 
2.21.0

