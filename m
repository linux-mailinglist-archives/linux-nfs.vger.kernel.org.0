Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA862D072
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfE1Udi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32919 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfE1Udi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:38 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so8233114iop.0
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dr8LTDNKO45rO36gvIhPaB8D1XPrwcjls5cN6OG5laE=;
        b=fddSIUaKkpHK5usq50YhQOG0cKr07mx93O0D6bGhfHraewvpsVk+Db1rM/o7q+BI37
         dSRtOjZ1RSMcddmV7Ebc/liNEFzEjx5488ArYF0C2fDQinsfTyYFe8QuwR5i2/TpIUD3
         CSTHeUwcBSDf5/BNt/+1NLnlViMEAYkW4fbXDgsJuxgpROCMhpMrA1P1N1ziiHBPxAmb
         b5r9eoy/w4m74PlOM+J+/CJwwRlbtlO4PbpzoUqMDuqQ5OTV/Eu/tKcLWzlylNxju1Gm
         z706THHpBXXtR3oMvlLMDHyBP4d3roCzk+JBqR/bHg0D6B5HZdoG5WViwNOVDGEj0Ifv
         DN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dr8LTDNKO45rO36gvIhPaB8D1XPrwcjls5cN6OG5laE=;
        b=BeagZJZ9QWyXYen1W1U2fI5p+yUfSTOE2BcomqM9Q3eZNAkeNjo5bPrBR4Zk56ZoUq
         8aRO8hCBDAl6dQ1HEDYZAE2fvef6tMYwYspKNQm+hhEuivL33SiGMzBVBSiqAAsTi0dU
         ES99FaX6aBljaaEt9lIl+Scxlsbd+c1vFWvHC4k5WNwaOGWo/DcEmnNmWBEEIbBN7Lyw
         Xjc23B3mC7jUSJfK3Q5BGjbNP3J1e7Sk4nqKIWHisfrVYsrHB3CpinkAzbX+uSK/KlSD
         TTc9Ad/V0QGzvAgle4t3pOI8zDGJgMBDoo13ZGRhLPW/09bOtWr8uP896scwl6ffYEjV
         HKsw==
X-Gm-Message-State: APjAAAWtp34UVKs27giB2JwsTaxc+SlbmaDzM0uDul2coJyStExTF1vZ
        Ll6MWYmh8uHdVgYKPL9fAQ==
X-Google-Smtp-Source: APXvYqyW97lSgHOP+axYT7ks4XMVNq/N52Pa2VDEsIxbQ5DcaVwQbOXgY3uvuvZnhgiM2m0SW66veQ==
X-Received: by 2002:a5d:80d1:: with SMTP id h17mr22428882ior.58.1559075617002;
        Tue, 28 May 2019 13:33:37 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:36 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 07/11] Add a helper to return the real path given an export entry
Date:   Tue, 28 May 2019 16:31:18 -0400
Message-Id: <20190528203122.11401-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-7-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a helper that can prepend the nfsd root directory path in order
to allow mountd to perform its comparisons with mtab etc.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/export/export.c    | 24 ++++++++++++++++++++++++
 support/include/exportfs.h |  1 +
 support/include/nfslib.h   |  1 +
 support/misc/nfsd_path.c   |  4 +++-
 support/nfs/exports.c      |  4 ++++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/support/export/export.c b/support/export/export.c
index fbe68e84e5b3..82bbb54c5e9e 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -20,6 +20,7 @@
 #include "xmalloc.h"
 #include "nfslib.h"
 #include "exportfs.h"
+#include "nfsd_path.h"
 
 exp_hash_table exportlist[MCL_MAXTYPES] = {{NULL, {{NULL,NULL}, }}, }; 
 static int export_hash(char *);
@@ -30,6 +31,28 @@ static void	export_add(nfs_export *exp);
 static int	export_check(const nfs_export *exp, const struct addrinfo *ai,
 				const char *path);
 
+/* Return a real path for the export. */
+static void
+exportent_mkrealpath(struct exportent *eep)
+{
+	const char *chroot = nfsd_path_nfsd_rootdir();
+	char *ret = NULL;
+
+	if (chroot)
+		ret = nfsd_path_prepend_dir(chroot, eep->e_path);
+	if (!ret)
+		ret = xstrdup(eep->e_path);
+	eep->e_realpath = ret;
+}
+
+char *
+exportent_realpath(struct exportent *eep)
+{
+	if (!eep->e_realpath)
+		exportent_mkrealpath(eep);
+	return eep->e_realpath;
+}
+
 void
 exportent_release(struct exportent *eep)
 {
@@ -39,6 +62,7 @@ exportent_release(struct exportent *eep)
 	free(eep->e_fslocdata);
 	free(eep->e_uuid);
 	xfree(eep->e_hostname);
+	xfree(eep->e_realpath);
 }
 
 static void
diff --git a/support/include/exportfs.h b/support/include/exportfs.h
index 4e0d9d132b4c..daa7e2a06d82 100644
--- a/support/include/exportfs.h
+++ b/support/include/exportfs.h
@@ -171,5 +171,6 @@ struct export_features {
 
 struct export_features *get_export_features(void);
 void fix_pseudoflavor_flags(struct exportent *ep);
+char *exportent_realpath(struct exportent *eep);
 
 #endif /* EXPORTFS_H */
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index b09fce42e677..84d8270b330f 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -84,6 +84,7 @@ struct exportent {
 	char *		e_uuid;
 	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
 	unsigned int	e_ttl;
+	char *		e_realpath;
 };
 
 struct rmtabent {
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index 55bca9bdf4bd..8ddafd65ab76 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -81,9 +81,11 @@ nfsd_path_prepend_dir(const char *dir, const char *pathname)
 		dirlen--;
 	if (!dirlen)
 		return NULL;
+	while (pathname[0] == '/')
+		pathname++;
 	len = dirlen + strlen(pathname) + 1;
 	ret = xmalloc(len + 1);
-	snprintf(ret, len, "%.*s/%s", (int)dirlen, dir, pathname);
+	snprintf(ret, len+1, "%.*s/%s", (int)dirlen, dir, pathname);
 	return ret;
 }
 
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 5f4cb9568814..3ecfde797e3b 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -155,6 +155,7 @@ getexportent(int fromkernel, int fromexports)
 	}
 
 	xfree(ee.e_hostname);
+	xfree(ee.e_realpath);
 	ee = def_ee;
 
 	/* Check for default client */
@@ -358,6 +359,7 @@ dupexportent(struct exportent *dst, struct exportent *src)
 	if (src->e_uuid)
 		dst->e_uuid = strdup(src->e_uuid);
 	dst->e_hostname = NULL;
+	dst->e_realpath = NULL;
 }
 
 struct exportent *
@@ -369,6 +371,8 @@ mkexportent(char *hname, char *path, char *options)
 
 	xfree(ee.e_hostname);
 	ee.e_hostname = xstrdup(hname);
+	xfree(ee.e_realpath);
+	ee.e_realpath = NULL;
 
 	if (strlen(path) >= sizeof(ee.e_path)) {
 		xlog(L_ERROR, "path name %s too long", path);
-- 
2.21.0

