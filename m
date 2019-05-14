Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AABC1D0D1
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfENUp3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 16:45:29 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34431 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENUp3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 16:45:29 -0400
Received: by mail-it1-f194.google.com with SMTP id p18so3688556itm.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 May 2019 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLFiZF5mHp7zkvqSK8XIsompacTeyXE20QIyu2YrAIo=;
        b=DoOfqF786GUL1ijS9+7zrTwjHp9xY3dINqjdU8aSyD/kmaWytoSjaFm1OWSO9zBD+i
         5w2ELBz96B5NtmLXH+GQMyDMEO8EejqScqOU7fxfjEGYSvlV63VfEtJB44ipSe/ldk/F
         ZMrER8J58JmV/dR6+GtfQQbOpm0kP1eMCbGe+yNs5A4avWtAT6Rmu4rmxbUgzdz4TVIn
         JPETN1sV+cB2dGJMv9/oZC8iMzNWfq0m1H7qMLU3Ic6fOa0Yz9Eh9VBe3zzGtVZDhaXC
         tgfzK4x7TYj5ZvcBQ9U1mo+UYAfTH14GV4a0vWbi48tTCx1+78gqx7h+8LXgc+4I0wne
         wDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLFiZF5mHp7zkvqSK8XIsompacTeyXE20QIyu2YrAIo=;
        b=YBYzQQzTNHaBesyfLQVECze6LUCgYrV5Fn6p+IbUe+61WZ1/SHbyDwyWVEAeGS/tG6
         JwsFGeh+Rf6IUAF6apvwyAY1GjUTrSeN3UUW/R7BlpLLEbZpxFgrGYlkAfl89nduLVqp
         LdGx8Y2eU+alnfXo97e43JvL9JbjbmxBF/uFF6URRahYQLNBD1eCARpX/B5ZveIRhCSX
         UcJac3u/NA3RzsiaXp+6DJnmqNCpNjgreeXOIskkQpntYrTK83lzXjtRq4qS1PPARtBD
         8Hfe1NKF2lkMSpMYNd7FBQ8OPeBzF/6Ulb3ljqyH7GvBU1Esv5K6xCqePgZZEpOgsZJ9
         PauQ==
X-Gm-Message-State: APjAAAUbbNfoiLACDeRTjGRaD1on5OZeZjhUplc3cl/mpshaLVRB2R7m
        +bS6x+8vRFyUYVM8urKlBtSGzfM=
X-Google-Smtp-Source: APXvYqx880Srtnit6H8SSPSCRxKY4XXObZnD3gaMPi+oAGhakE52NOJBRoj0dkss2a11phyeBEDVDA==
X-Received: by 2002:a24:fa42:: with SMTP id v63mr5055243ith.20.1557866727981;
        Tue, 14 May 2019 13:45:27 -0700 (PDT)
Received: from localhost.localdomain ([172.56.10.94])
        by smtp.gmail.com with ESMTPSA id r139sm64943ita.22.2019.05.14.13.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:45:27 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 5/5] Add support for chroot in exportfs
Date:   Tue, 14 May 2019 16:41:53 -0400
Message-Id: <20190514204153.79603-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514204153.79603-5-trond.myklebust@hammerspace.com>
References: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
 <20190514204153.79603-2-trond.myklebust@hammerspace.com>
 <20190514204153.79603-3-trond.myklebust@hammerspace.com>
 <20190514204153.79603-4-trond.myklebust@hammerspace.com>
 <20190514204153.79603-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/exportfs/Makefile.am |  2 +-
 utils/exportfs/exportfs.c  | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

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
index 333eadcd0228..bc87d7fe4ee1 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -52,6 +52,33 @@ static const char *lockfile = EXP_LOCKFILE;
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
+	exportfs_wq = xthread_workqueue_alloc();
+	if (!exportfs_wq)
+		return;
+	xthread_workqueue_chroot(exportfs_wq, chroot);
+}
 
 /*
  * If we aren't careful, changes made by exportfs can be lost
@@ -181,6 +208,8 @@ main(int argc, char **argv)
 		}
 	}
 
+	exportfs_setup_workqueue();
+
 	/*
 	 * Serialize things as best we can
 	 */
@@ -505,7 +534,7 @@ static int test_export(nfs_export *exp, int with_fsid)
 	fd = open("/proc/net/rpc/nfsd.export/channel", O_WRONLY);
 	if (fd < 0)
 		return 0;
-	n = write(fd, buf, strlen(buf));
+	n = exportfs_write(fd, buf, strlen(buf));
 	close(fd);
 	if (n < 0)
 		return 0;
-- 
2.21.0

