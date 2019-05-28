Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA92D073
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfE1Udk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35818 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfE1Udk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:40 -0400
Received: by mail-io1-f65.google.com with SMTP id p2so16942890iol.2
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBJi060n7RhVnSN6xyn5hT8UN0dOckFbLFyVF4AWmVI=;
        b=OFb+fG9ZVNketjNbWCXfMiTe0vlRtnHMVw0Fp4GpSxAPKqwzcW1ACe38I4qk9uJF4Y
         HnVIoE+iG03OJBbGR/PQtWKUC7hb3HIw3GXNx5J14jHerfbMC18+i5vUyz+iHiqxLSRE
         R8AM+AXDzEfCepzkWrcM0R234odckrM4L0PplVoRp+N5Z2k44hwCuZw788Mf7DEqrQd+
         QafSffyIv9a4KQsd03QcxRFUkRkf69c+JukUl2g8lpwo9qqVPYxV5o5cx04LrylPXbFy
         JV2UPiuDmVlUxPTKYPHEoicyimZgDIMJSJRzCmbXfuKpXWBcvzyWlaLYvwKASWDeoWTQ
         03Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBJi060n7RhVnSN6xyn5hT8UN0dOckFbLFyVF4AWmVI=;
        b=rO6+lLnc9Vmj5mqz7d9ghQqPDEUxS6fsw8cV0ehEM6xTjqzsNogBPj712JJE+c1nyr
         0XJSRKSHD9zJTxd4JI2CrCpqhG6yVayBv6AeNn7CBjpnUpmjlqoyQVSvCKgYMthzUce7
         MyyKGIoTRVe3x/ykaTeMuC2C+5lngM68iVWvQfMQHDTtXobBUmNYCEL8a9Z08QakdttE
         PBoCsQMTdP06BiRILyax27TYTDopzs6TmBBb7wpk4+zNYE1sItdFzwH5yS+hKO+FGmpp
         b2+2OPOU9Iusf7m3Epyy72fhFKilOsNOkLMat8+Wr2qlSy1qObd6uhYuisOcW0opRu+O
         b2Xw==
X-Gm-Message-State: APjAAAXSCQQwU4bhW+ybivcpnGxB4RodDz94opW/n8cGy2cFJDo8QOPO
        fFKsl7778VwicKdmNM3lHg==
X-Google-Smtp-Source: APXvYqz2boZ6yRYqFHtGQC2H1n5wmnqDKsFN/f/giY90ILNYg/23CvvQypqGi1Tlj8nyicoaW8MRqw==
X-Received: by 2002:a5d:8783:: with SMTP id f3mr52298990ion.235.1559075619337;
        Tue, 28 May 2019 13:33:39 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:38 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 09/11] Add support for the "[exports] rootdir" nfs.conf option to exportfs
Date:   Tue, 28 May 2019 16:31:20 -0400
Message-Id: <20190528203122.11401-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-9-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
 <20190528203122.11401-8-trond.myklebust@hammerspace.com>
 <20190528203122.11401-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that exportfs also resolves paths relative to the nfsd root
directory

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/exportfs/Makefile.am |  2 +-
 utils/exportfs/exportfs.c  | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
index 4b291610d19b..96524c729359 100644
--- a/utils/exportfs/Makefile.am
+++ b/utils/exportfs/Makefile.am
@@ -10,6 +10,6 @@ exportfs_SOURCES = exportfs.c
 exportfs_LDADD = ../../support/export/libexport.a \
 	       	 ../../support/nfs/libnfs.la \
 		 ../../support/misc/libmisc.a \
-		 $(LIBWRAP) $(LIBNSL)
+		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 333eadcd0228..5cca4175e73a 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -33,6 +33,7 @@
 
 #include "sockaddr.h"
 #include "misc.h"
+#include "nfsd_path.h"
 #include "nfslib.h"
 #include "exportfs.h"
 #include "xlog.h"
@@ -53,6 +54,11 @@ static int _lockfd = -1;
 
 struct state_paths etab;
 
+static ssize_t exportfs_write(int fd, const char *buf, size_t len)
+{
+	return nfsd_path_write(fd, buf, len);
+}
+
 /*
  * If we aren't careful, changes made by exportfs can be lost
  * when multiple exports process run at once:
@@ -109,6 +115,7 @@ main(int argc, char **argv)
 
 	conf_init_file(NFS_CONFFILE);
 	xlog_from_conffile("exportfs");
+	nfsd_path_init();
 
 	/* NOTE: following uses "mountd" section of nfs.conf !!!! */
 	s = conf_get_str("mountd", "state-directory-path");
@@ -505,7 +512,7 @@ static int test_export(nfs_export *exp, int with_fsid)
 	fd = open("/proc/net/rpc/nfsd.export/channel", O_WRONLY);
 	if (fd < 0)
 		return 0;
-	n = write(fd, buf, strlen(buf));
+	n = exportfs_write(fd, buf, strlen(buf));
 	close(fd);
 	if (n < 0)
 		return 0;
@@ -521,7 +528,7 @@ validate_export(nfs_export *exp)
 	 * otherwise trial-export to '-test-client-' and check for failure.
 	 */
 	struct stat stb;
-	char *path = exp->m_export.e_path;
+	char *path = exportent_realpath(&exp->m_export);
 	struct statfs64 stf;
 	int fs_has_fsid = 0;
 
-- 
2.21.0

