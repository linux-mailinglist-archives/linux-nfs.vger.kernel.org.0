Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7E24F31
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfEUMtT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 08:49:19 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52019 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEUMtS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 08:49:18 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so4723758itl.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0J7r1j+ktNhdVDgcbWhWVBMoXoEOq9RiXDpoM7+ALM=;
        b=bHcOW+Eh2FxwiVt7kYYa/RNhwl9ArM0nb7cKvLLzLWBHF2OIoqMu798PYR4UcBptMH
         KTGexYjrOQqml+P7fYvqLklPS92d+JtmIgeu6Q+vvtXOo4iT03aM43cFKLQxcW/wBZGG
         Imf0bwNFyvg0Np52lXqdNqys6zKB0OZpzL4gNijiohyCuL69tyOZfkM9P4MskS6m/YU6
         TAVbv4Vxd0XkU0kncgtakC4GVhDA4YpoeH1xaFUyR60C+QmjPkldXiHJVxXcTQz/1vnw
         fWAv/SJTPsFxHJpnLCVS//IAKcEhfkXS2nCnOaFbSy8G2EhXV/moMgYPDJvep/kHCYX9
         YT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0J7r1j+ktNhdVDgcbWhWVBMoXoEOq9RiXDpoM7+ALM=;
        b=CLum99fjfZIDqH75kVfPruyiML4j8pu5gUfM3UumCk5X0d9inOXw64fHd3pdhbzHCv
         JHCfA2Gx5woTTcx2z8iVGEs0OzysnnQENCTfeeCcPCWlCbW30hGyFIDdG8gtHXXzPSPn
         olKl+eiOilYZwj65b4m90wSmS8HsnOBZ12bUj/ssXl6VP+sIqPp9VRYkVuG6yJgwjOMp
         33zO3/9p2sjEWZJYalukNQVJqu78yxlEmWlqnAx8sYY7S0umbvBzE0j+81JKqk7/hMXX
         rPhFfSXwqwbjPvtwmFkkaXp12cdpaiwUAYFBRoL5ChsXU4GD/Q82dqJ+9DL1ba7bXtgk
         W1eA==
X-Gm-Message-State: APjAAAXDi+VWmT1TkSmPT5J5QifBTG5zNm9ld9FTzuIB8w02xoV+LKu1
        WogHtWOoBbuWYS1bOOoe1Q==
X-Google-Smtp-Source: APXvYqzr6yxkBn3ctXMdIM3Noi4U4r3/L452G6E4X4ufIgvpLgEuHuioqW7yDKEz4/WnfXfOmdXHdA==
X-Received: by 2002:a24:9187:: with SMTP id i129mr3583451ite.137.1558442957752;
        Tue, 21 May 2019 05:49:17 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v139sm1693180itb.25.2019.05.21.05.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:49:17 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 7/7] Add support for the nfsd root directory to exportfs
Date:   Tue, 21 May 2019 08:47:01 -0400
Message-Id: <20190521124701.61849-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521124701.61849-7-trond.myklebust@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
 <20190521124701.61849-2-trond.myklebust@hammerspace.com>
 <20190521124701.61849-3-trond.myklebust@hammerspace.com>
 <20190521124701.61849-4-trond.myklebust@hammerspace.com>
 <20190521124701.61849-5-trond.myklebust@hammerspace.com>
 <20190521124701.61849-6-trond.myklebust@hammerspace.com>
 <20190521124701.61849-7-trond.myklebust@hammerspace.com>
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
 utils/exportfs/exportfs.c  | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

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
index 333eadcd0228..05481ad3f896 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -33,8 +33,10 @@
 
 #include "sockaddr.h"
 #include "misc.h"
+#include "nfsd_path.h"
 #include "nfslib.h"
 #include "exportfs.h"
+#include "workqueue.h"
 #include "xlog.h"
 #include "conffile.h"
 
@@ -52,6 +54,29 @@ static const char *lockfile = EXP_LOCKFILE;
 static int _lockfd = -1;
 
 struct state_paths etab;
+static struct xthread_workqueue *exportfs_wq;
+
+static ssize_t exportfs_write(int fd, const char *buf, size_t len)
+{
+	if (exportfs_wq)
+		return xthread_write(exportfs_wq, fd, buf, len);
+	return write(fd, buf, len);
+}
+
+static void
+exportfs_setup_workqueue(void)
+{
+	const char *chroot = nfsd_path_nfsd_rootdir();
+
+	if (!chroot || chroot[0] == '\0')
+		return;
+	if (chroot[0] == '/' && chroot[1] == '\0')
+		return;
+	exportfs_wq = xthread_workqueue_alloc();
+	if (!exportfs_wq)
+		return;
+	xthread_workqueue_chroot(exportfs_wq, chroot);
+}
 
 /*
  * If we aren't careful, changes made by exportfs can be lost
@@ -109,6 +134,7 @@ main(int argc, char **argv)
 
 	conf_init_file(NFS_CONFFILE);
 	xlog_from_conffile("exportfs");
+	nfsd_path_init();
 
 	/* NOTE: following uses "mountd" section of nfs.conf !!!! */
 	s = conf_get_str("mountd", "state-directory-path");
@@ -181,6 +207,8 @@ main(int argc, char **argv)
 		}
 	}
 
+	exportfs_setup_workqueue();
+
 	/*
 	 * Serialize things as best we can
 	 */
@@ -505,7 +533,7 @@ static int test_export(nfs_export *exp, int with_fsid)
 	fd = open("/proc/net/rpc/nfsd.export/channel", O_WRONLY);
 	if (fd < 0)
 		return 0;
-	n = write(fd, buf, strlen(buf));
+	n = exportfs_write(fd, buf, strlen(buf));
 	close(fd);
 	if (n < 0)
 		return 0;
@@ -521,7 +549,7 @@ validate_export(nfs_export *exp)
 	 * otherwise trial-export to '-test-client-' and check for failure.
 	 */
 	struct stat stb;
-	char *path = exp->m_export.e_path;
+	char *path = exportent_realpath(&exp->m_export);
 	struct statfs64 stf;
 	int fs_has_fsid = 0;
 
-- 
2.21.0

