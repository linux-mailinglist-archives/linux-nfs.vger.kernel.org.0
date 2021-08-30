Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1623FB983
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhH3P6G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbhH3P6A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 11:58:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A92C0617AE
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:05 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id e18so8586015qvo.1
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SROUaiAMehrmiT3ELGDnLtiEyOT7RUgBLqWqJFw66F0=;
        b=P0N0s3UzPGci6qyOUjHT/NxZ5oKXk5IOYqJgPl/3aPSKP3QPxVLfJknh26b5lzQffy
         MRselXfM1Rw0Sbjmr28ou7FU6YUb9im1SiV9+Lj089MhzjJV84H3f2K5LRn/CS9ycfLg
         ZYtH6LoC3VZvBJKUMYieHLqIvu6hgUwURpNPCKWjbDbAwUL9bBLP6xNpK4o4REQE/dQU
         5LuKT12tafZhNEdeujci7bND4b+rTX7enT5aqb3jKIj16Y455QXCvXBjPiC4g8cfaMap
         14gv/ofW/0/Z+2aGnIej+/C6o+SiWQy+ujhFqRcKtsS+fEhJuhQljQ5O7A6YqmyZEPI5
         uivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SROUaiAMehrmiT3ELGDnLtiEyOT7RUgBLqWqJFw66F0=;
        b=HPsc8p5Q93iLgSVXxNQTRXVwHjOuoGa0zOv3HPMYohvQgKBNP5OU5FvHLavrNR2Esq
         QsM+ECJsPiM0w7Ts6ywu23NH47QdO/BUmWlxVUp+iMF+0u9RbIT8wdgHhOoAdSy5h0Kv
         TvODoqxkpolYZwY/F3H4bbe7jxl13WvrE4zyyktlLASXR4f7Bxnt0Zvsr4bwy4rJiy5m
         PrDbIc7RmpP4G0DYHpU+psGwK1sBFNPZ8mKXDfL3i2rIinPw8O1HYlKQkzz8pcLvwbDt
         CKLaD8TjNp3pDrhWeQH9BFAaMqn9jmnY1w9mZL+IpNqvS4D70NevKQlC5Jh/DKrqb05q
         6WzQ==
X-Gm-Message-State: AOAM533zy7kLMILt2Qws0ixCCzlUaqYVgvVB9ATX0AOslwBqlPn7GYT3
        xlgG88j15UOX8/n4bJtHXdE=
X-Google-Smtp-Source: ABdhPJzJ4iweZFguGRDhWRf2q1JvfRHxIEH8nSzmq+2WHr52nAcqOELjAVWIO6IWVqbUFDA8NZuf7A==
X-Received: by 2002:a0c:e790:: with SMTP id x16mr23587015qvn.6.1630339024736;
        Mon, 30 Aug 2021 08:57:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id 12sm8585217qtt.16.2021.08.30.08.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:57:04 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 9/9] nfssysfs: Add installation to the Makefile
Date:   Mon, 30 Aug 2021 11:56:53 -0400
Message-Id: <20210830155653.1386161-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And create a shell script that launches the python program from the
$(libdir)

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 configure.ac               |  1 +
 tools/Makefile.am          |  2 +-
 tools/nfssysfs/Makefile.am | 20 ++++++++++++++++++++
 tools/nfssysfs/nfssysfs    |  5 +++++
 4 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfssysfs/Makefile.am
 create mode 100644 tools/nfssysfs/nfssysfs

diff --git a/configure.ac b/configure.ac
index bc2d0f02979c..57ad341948a3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -731,6 +731,7 @@ AC_CONFIG_FILES([
 	tools/rpcgen/Makefile
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
+	tools/nfssysfs/Makefile
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
 	tools/nfsdclddb/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 9b4b0803db39..12c68b57b8ae 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
 endif
 
-SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfsdclnts $(OPTDIRS)
+SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfssysfs nfsdclnts $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/nfssysfs/Makefile.am b/tools/nfssysfs/Makefile.am
new file mode 100644
index 000000000000..983b128f5c98
--- /dev/null
+++ b/tools/nfssysfs/Makefile.am
@@ -0,0 +1,20 @@
+## Process this file with automake to produce Makefile.in
+PYTHON_FILES =  nfssysfs.py client.py switch.py sysfs.py xprt.py
+tooldir = $(DESTDIR)$(libdir)/nfssysfs
+
+man8_MANS = nfssysfs.man
+
+all-local: $(PYTHON_FILES)
+
+install-data-hook:
+	mkdir -p $(tooldir)
+	for f in $(PYTHON_FILES) ; do \
+		$(INSTALL) -m 644 $$f $(tooldir)/$$f ; \
+	done
+	chmod +x $(tooldir)/nfssysfs.py
+	$(INSTALL) -m 755 nfssysfs $(DESTDIR)$(sbindir)/nfssysfs
+	sed -i "s|LIBDIR=.|LIBDIR=$(tooldir)|" $(DESTDIR)$(sbindir)/nfssysfs
+
+
+
+MAINTAINERCLEANFILES=Makefile.in
diff --git a/tools/nfssysfs/nfssysfs b/tools/nfssysfs/nfssysfs
new file mode 100644
index 000000000000..82dd2da6f539
--- /dev/null
+++ b/tools/nfssysfs/nfssysfs
@@ -0,0 +1,5 @@
+#!/bin/bash
+LIBDIR=.
+PYTHON3=/usr/bin/python
+
+exec $PYTHON3 $LIBDIR/nfssysfs.py $*
-- 
2.33.0

