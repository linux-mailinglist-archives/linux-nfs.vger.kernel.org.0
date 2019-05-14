Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5860A1D0D0
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 22:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfENUp2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 16:45:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41605 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENUp2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 16:45:28 -0400
Received: by mail-io1-f67.google.com with SMTP id a17so382967iot.8
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Og7oWbWWeKOcvPck2OBvAqHBM3lVUuH8Q7w6/EYUAu0=;
        b=ElDUkdj0RBtZZADV71OYu2VWFoQ5tHYZO93i8LS0g3iLt/fsdH5Vt3VPs9vXzDF0z1
         6gG9/KGMOfDOHT8BUalpGzVMPcCwoIS/KSya3MtY7dzKUjl0lVWnPo+fxuW+p6nt9RE8
         FEolWppluyFvw7gzdX66agADwcd34EAjfFprbc8lM6diFpGo9v6MD1lpdauTdz72FSKb
         jHLvLh5/rR1EsCL59rqx38gjBI97jsUrm2FQzCf1JLlbTmWjiZYWyMCzL0TKx6hqKW/G
         8N6Js8tk1lIqGAjgzabwLRiVytXga/XtRPJG5CtpYnjX/s606bR6QVLTkV+w8Kg+zTnd
         cDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Og7oWbWWeKOcvPck2OBvAqHBM3lVUuH8Q7w6/EYUAu0=;
        b=IrAKO5r3TVbDY6mjuu+rb/kMa08fryQBybdO9rQSn/QU22XXIo+SZAz4D2srrPDaHA
         fz/X8HEhJWZb9dk61dRGMQ93mg5lW5p2UAf3N54B8a67YR30sWcbhkzctzryv80DzDQW
         /IXaqIY8lWh5eWf9F1kdFIVXNef09SFrT5QA/biYNcpzhPPkZORYLGeOoUAoKo6PGRza
         v7Z1kfBHEp3bV9OxcTXBNUl7as0h9pSKjlYNOIsbrEwR9pPzCvszbk49P2G2RXvG1/Cb
         MFxSm08joRx0MkMRTZWrBaiyXF7kBUAYxEYJMrg7A8rHPXQNuxi31uYrsU7SPX6Ot04V
         /XjA==
X-Gm-Message-State: APjAAAWRJVqNcC9SFEZ0YIYg+Pe6Hzfhh/zMD7FXvyobkhGtwfdYTDXj
        L2nqkUnsBLPFNz3yiI8gQkXcDyA=
X-Google-Smtp-Source: APXvYqxF6V+94qVXd5Fv3tqDFTlhk6EqsSvKk9gUtNiVWOsCaGu+CZyfegnUW67vKXWhb7yvX6e0Bg==
X-Received: by 2002:a5d:8055:: with SMTP id b21mr16760744ior.241.1557866726568;
        Tue, 14 May 2019 13:45:26 -0700 (PDT)
Received: from localhost.localdomain ([172.56.10.94])
        by smtp.gmail.com with ESMTPSA id r139sm64943ita.22.2019.05.14.13.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:45:26 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 4/5] Add support for chrooted exports
Date:   Tue, 14 May 2019 16:41:52 -0400
Message-Id: <20190514204153.79603-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514204153.79603-4-trond.myklebust@hammerspace.com>
References: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
 <20190514204153.79603-2-trond.myklebust@hammerspace.com>
 <20190514204153.79603-3-trond.myklebust@hammerspace.com>
 <20190514204153.79603-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 nfs.conf             |  1 +
 systemd/nfs.conf.man |  3 ++-
 utils/mountd/cache.c | 39 +++++++++++++++++++++++++++++++++++----
 utils/nfsd/nfsd.man  |  4 ++++
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 27e962c8a2a9..aad73035a466 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -60,6 +60,7 @@
 # vers4.1=y
 # vers4.2=y
 # rdma=n
+# chroot=/export
 #
 [statd]
 # debug=0
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index e3654a3c2c2b..bd83e57dd6da 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -136,7 +136,8 @@ Recognized values:
 .BR vers4.0 ,
 .BR vers4.1 ,
 .BR vers4.2 ,
-.BR rdma .
+.BR rdma ,
+.BR chroot .
 
 Version and protocol values are Boolean values as described above,
 and are also used by
diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index bdbd1904eb76..25b0fb84f753 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -33,11 +33,14 @@
 #include "fsloc.h"
 #include "pseudoflavors.h"
 #include "xcommon.h"
+#include "conffile.h"
 
 #ifdef USE_BLKID
 #include "blkid/blkid.h"
 #endif
 
+static struct xthread_workqueue *cache_workqueue;
+
 /*
  * Invoked by RPC service loop
  */
@@ -55,6 +58,32 @@ enum nfsd_fsid {
 	FSID_UUID16_INUM,
 };
 
+static ssize_t cache_write(int fd, const char *buf, size_t len)
+{
+	if (cache_workqueue)
+		return xthread_write(cache_workqueue, fd, buf, len);
+	return write(fd, buf, len);
+}
+
+static void
+cache_setup_workqueue(void)
+{
+	const char *chroot;
+
+	chroot = conf_get_str("nfsd", "chroot");
+	if (!chroot || *chroot == '\0')
+		return;
+	/* Strip leading '/' */
+	while (chroot[0] == '/' && chroot[1] == '/')
+		chroot++;
+	if (chroot[0] == '/' && chroot[1] == '\0')
+		return;
+	cache_workqueue = xthread_workqueue_alloc();
+	if (!cache_workqueue)
+		return;
+	xthread_workqueue_chroot(cache_workqueue, chroot);
+}
+
 /*
  * Support routines for text-based upcalls.
  * Fields are separated by spaces.
@@ -829,7 +858,7 @@ static void nfsd_fh(int f)
 	if (found)
 		qword_add(&bp, &blen, found_path);
 	qword_addeol(&bp, &blen);
-	if (blen <= 0 || write(f, buf, bp - buf) != bp - buf)
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf)
 		xlog(L_ERROR, "nfsd_fh: error writing reply");
 out:
 	if (found_path)
@@ -921,7 +950,7 @@ static int dump_to_cache(int f, char *buf, int buflen, char *domain,
 		qword_adduint(&bp, &blen, now + ttl);
 	qword_addeol(&bp, &blen);
 	if (blen <= 0) return -1;
-	if (write(f, buf, bp - buf) != bp - buf) return -1;
+	if (cache_write(f, buf, bp - buf) != bp - buf) return -1;
 	return 0;
 }
 
@@ -1381,6 +1410,8 @@ extern int manage_gids;
 void cache_open(void) 
 {
 	int i;
+
+	cache_setup_workqueue();
 	for (i=0; cachelist[i].cache_name; i++ ) {
 		char path[100];
 		if (!manage_gids && cachelist[i].cache_handle == auth_unix_gid)
@@ -1508,7 +1539,7 @@ int cache_export(nfs_export *exp, char *path)
 	qword_adduint(&bp, &blen, time(0) + exp->m_export.e_ttl);
 	qword_add(&bp, &blen, exp->m_client->m_hostname);
 	qword_addeol(&bp, &blen);
-	if (blen <= 0 || write(f, buf, bp - buf) != bp - buf) blen = -1;
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf) blen = -1;
 	close(f);
 	if (blen < 0) return -1;
 
@@ -1546,7 +1577,7 @@ cache_get_filehandle(nfs_export *exp, int len, char *p)
 	qword_add(&bp, &blen, p);
 	qword_addint(&bp, &blen, len);
 	qword_addeol(&bp, &blen);
-	if (blen <= 0 || write(f, buf, bp - buf) != bp - buf) {
+	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf) {
 		close(f);
 		return NULL;
 	}
diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
index d83ef869d26e..8fb23721daf6 100644
--- a/utils/nfsd/nfsd.man
+++ b/utils/nfsd/nfsd.man
@@ -167,6 +167,10 @@ Setting these to "off" or similar will disable the selected minor
 versions.  Setting to "on" will enable them.  The default values
 are determined by the kernel, and usually minor versions default to
 being enabled once the implementation is sufficiently complete.
+.B chroot
+Setting this to a valid path causes the nfs server to act as if the
+supplied path is being prefixed to all the exported entries.
+
 
 .SH NOTES
 If the program is built with TI-RPC support, it will enable any protocol and
-- 
2.21.0

