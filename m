Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF1437FB3
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 22:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhJVU6c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 16:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhJVU6c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 16:58:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612D0C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id r15so5788534qkp.8
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ujyHcIwqKN6zdaapwS5pbzFVukho+8cIHzt2DF+UzE=;
        b=FC0v/Qrrc4yzyr5vk+mZ6T4nZhn6i/xX5jV2UmZ5cr6P345JCigVhJc5udp9UPTe8c
         BDZKmuK2QtLCDr9MHcWaurFUtnOh7X/6uT+CbJb0Mv7WgRTAJhs/WL9qhPjcVXRjIrif
         P840NgGqBAvajQn2vhbLRHpCNhFUAG0JM0ujslsj2oDHtoNc802TtM4P8d/ZBH7dIXpL
         8qksyEU8S9qmB1yPiZD0drqRE/5FJEWDGgdy4JvWUBTGh/lSRnDvVR7+7wGFP67sLuO/
         59/TfVUkK9dztoVYsYYJoI+w5A+Zi3eLfJH6Rgx22BSF8qE6KikKgp7Kd/JpuL5n9Noy
         xlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1ujyHcIwqKN6zdaapwS5pbzFVukho+8cIHzt2DF+UzE=;
        b=xFov1Y6gdVqZtCV+mxLFeyTQf0fIOE/WEZseuF/hj6BOsKXqhDpQMR5FMehd3T9ftw
         6A8b9rntF8Xlp3q6KD19LgLoEL9PbTWZq6+gKC8OXA5ONw/QdeAgrStzkqOYIjEdbRez
         HK+ys874/dfKYrLiqnkVKVVRiVqSbdVmAWM94f2OOBA1ze+YgT+2pmDELVH6hyUyZxAJ
         tshhfR+EF4qImn9uUNpHYa1adUtXVDCxKTEwphDG+tggK3+0WhOJYG56MHCm95DcLuje
         f7fi97Iy34kBOmpNvRguxpeEctXW25Jch6BUToyWS6286oKHd5Rg5ED8a0kmPsGaqtul
         mz6w==
X-Gm-Message-State: AOAM532U9uVIiTxiRjQ74Zmx/WXhw6bMGYCUU0dfqCMXwE1dfBqRAFNw
        QKPrM8R5nvPXZqwC6ItBNhk=
X-Google-Smtp-Source: ABdhPJzxX/8rylzgiH0sUyci4cfRxmwlXo6UjiyHSwchCB1NH9ADE4rGezyPlMG0hbasznSfE4XaRg==
X-Received: by 2002:a05:620a:4612:: with SMTP id br18mr1920367qkb.405.1634936173515;
        Fri, 22 Oct 2021 13:56:13 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id p9sm4576279qki.51.2021.10.22.13.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:56:13 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 9/9] rpcsys: Add installation to the Makefile
Date:   Fri, 22 Oct 2021 16:56:06 -0400
Message-Id: <20211022205606.66392-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com>
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
 configure.ac             |  1 +
 tools/Makefile.am        |  2 +-
 tools/rpcsys/Makefile.am | 20 ++++++++++++++++++++
 tools/rpcsys/rpcsys      |  5 +++++
 4 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 tools/rpcsys/Makefile.am
 create mode 100644 tools/rpcsys/rpcsys

diff --git a/configure.ac b/configure.ac
index bc2d0f02979c..4df87a22166a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -731,6 +731,7 @@ AC_CONFIG_FILES([
 	tools/rpcgen/Makefile
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
+	tools/rpcsys/Makefile
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
 	tools/nfsdclddb/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 9b4b0803db39..29e5249a2158 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
 endif
 
-SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfsdclnts $(OPTDIRS)
+SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcsys nfsdclnts $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/rpcsys/Makefile.am b/tools/rpcsys/Makefile.am
new file mode 100644
index 000000000000..9e29977c3d11
--- /dev/null
+++ b/tools/rpcsys/Makefile.am
@@ -0,0 +1,20 @@
+## Process this file with automake to produce Makefile.in
+PYTHON_FILES =  rpcsys.py client.py switch.py sysfs.py xprt.py
+tooldir = $(DESTDIR)$(libdir)/rpcsys
+
+man8_MANS = rpcsys.man
+
+all-local: $(PYTHON_FILES)
+
+install-data-hook:
+	mkdir -p $(tooldir)
+	for f in $(PYTHON_FILES) ; do \
+		$(INSTALL) -m 644 $$f $(tooldir)/$$f ; \
+	done
+	chmod +x $(tooldir)/rpcsys.py
+	$(INSTALL) -m 755 rpcsys $(DESTDIR)$(sbindir)/rpcsys
+	sed -i "s|LIBDIR=.|LIBDIR=$(tooldir)|" $(DESTDIR)$(sbindir)/rpcsys
+
+
+
+MAINTAINERCLEANFILES=Makefile.in
diff --git a/tools/rpcsys/rpcsys b/tools/rpcsys/rpcsys
new file mode 100644
index 000000000000..a3f860081a26
--- /dev/null
+++ b/tools/rpcsys/rpcsys
@@ -0,0 +1,5 @@
+#!/bin/bash
+LIBDIR=.
+PYTHON3=/usr/bin/python
+
+exec $PYTHON3 $LIBDIR/rpcsys.py $*
-- 
2.33.1

