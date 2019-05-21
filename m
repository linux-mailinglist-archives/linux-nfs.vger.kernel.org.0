Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3936124F2E
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEUMtR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 08:49:17 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33173 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEUMtQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 08:49:16 -0400
Received: by mail-it1-f195.google.com with SMTP id j17so2675175itk.0
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFdtiwK4kHqOG8CPwc58PSZjv/X3NKqeTWbmyNkVOvg=;
        b=E8bEfT/VlZVu4ergefhWlPxKpDpusHPsR3jOKPbubB1uUQuQNQ8/tVHueRrn+sBkke
         P2mAvJbIeAunE7mQm8Eb3VgDv1giro0qd4w/IzPdokcLKnAPAES1xUzPUYoF0/Nr0DWo
         3duFdZYJpOnF0rzy0NkNQ7VmJEVAT+KLhQbsvdPhqeoBduCkfbd7FDge43gFDn5ikdOS
         8FE4wXhyHFm2CY/VttRfC6dciUrtqtJMr7oIwQSTq8oyXedt+9mUMGglf+0yZemwWap0
         bjaLiAIQ4J/OsiKSVt/hdctlg5X9P/Im2ykzKzxdELX7CpG0yRzk/rwNmSPTT7xgSWl1
         qILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFdtiwK4kHqOG8CPwc58PSZjv/X3NKqeTWbmyNkVOvg=;
        b=tuIsAwVhTx+TcuvTmzotNE3gWXOHN+fGtO65+ZDw4uRMuU6zRLAKsYNFkiG7Btsd0v
         SCZ7dPUHEopFO01/XvKAF+sieT2dLtX9A1amPiOhgkPH39KXRDX3MYAoLNwjfM/+/pCt
         BEBpAwfYjiMmPcD+bnlv0uDt49ssCQsMBOPlqNpzmmO7a2zm7PczD+1GEXFMpDpVxpuf
         KZPiuy3Ahpeap1x9flImftLg+r7MO6cVnE/NOMKlHb0wYuJgKEmp/AWr092AOPNuwxli
         YiThzN0Iz3IJazuz4cVojPaNHv94KrvaTDs20UIhyL+HjjEQtlHmFXVZQixFzmO6qOzH
         4+CA==
X-Gm-Message-State: APjAAAW6v+mBCs98e9CyZl9q1sGtvivWh+tG4UqMxwKGEMWztHVSay3x
        lK4RHYslIdpafzuy2VPgDA==
X-Google-Smtp-Source: APXvYqyqYlrhO27EW+o64Cw058gPdJT5wz2Wzr7HvqO9NGsD1TAV2g/z9JjAzUUigR5EXPuxoXgWNg==
X-Received: by 2002:a24:5c90:: with SMTP id q138mr3216925itb.96.1558442955425;
        Tue, 21 May 2019 05:49:15 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v139sm1693180itb.25.2019.05.21.05.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:49:14 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 4/7] Add a helper to return the real path given an export entry
Date:   Tue, 21 May 2019 08:46:58 -0400
Message-Id: <20190521124701.61849-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521124701.61849-4-trond.myklebust@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <20190521124701.61849-2-trond.myklebust@hammerspace.com>
 <20190521124701.61849-3-trond.myklebust@hammerspace.com>
 <20190521124701.61849-4-trond.myklebust@hammerspace.com>
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
index fbe68e84e5b3..229b02eb2dd4 100644
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
+	char *chroot = nfsd_path_nfsd_rootdir();
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
index 481ba49a38fd..386b171f26df 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -77,9 +77,11 @@ nfsd_path_prepend_dir(const char *dir, const char *pathname)
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

