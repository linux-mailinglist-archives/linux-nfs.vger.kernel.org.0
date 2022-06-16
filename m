Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7874254EB29
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jun 2022 22:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378671AbiFPU3L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jun 2022 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378667AbiFPU3K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jun 2022 16:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64B4B5C746
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655411344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9T0GnKTcsKnAojWZXM1sG2Cwvgvk3+u089Zo6OvZTh8=;
        b=fl5A8v0tSZq0hqeT4JI9lxGqCdjsNrCzgyDHyNFaFrM3xx8EpWz7siwXZTVthQk4EFjIV7
        15138CtCW9KWdWe5TolO7kWKccKBz5IyyuSekGbs7VPzOJ/XjKq+YzE008FEm+nfg9Ej5F
        XVnB+vn7p1dy4Q/M/G+pPeExFmAf3Rg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-eJ82sWl0MNS0UAdxXh7tXg-1; Thu, 16 Jun 2022 16:29:03 -0400
X-MC-Unique: eJ82sWl0MNS0UAdxXh7tXg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 289DB3C0CD52
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 20:29:03 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (unknown [10.2.16.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF7AC403350
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jun 2022 20:29:02 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/4] configure.ac: Removed a number warnings
Date:   Thu, 16 Jun 2022 16:29:00 -0400
Message-Id: <20220616202902.53969-2-steved@redhat.com>
In-Reply-To: <20220616202902.53969-1-steved@redhat.com>
References: <20220616202902.53969-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 Makefile             | 4 ++--
 configure.ac         | 8 ++++----
 include/builddefs.in | 1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index be7454d..a460e78 100644
--- a/Makefile
+++ b/Makefile
@@ -60,8 +60,8 @@ clean:	# if configure hasn't run, nothing to clean
 endif
 
 $(CONFIGURE): aclocal.m4
+	autoupdate --force
 	autoreconf --install
-	autoconf
 	./configure \
 		--prefix=/ \
 		--exec-prefix=/ \
@@ -96,6 +96,6 @@ install-lib: default
 
 realclean distclean: clean
 	rm -f $(LDIRT) $(CONFIGURE)
-	rm -rf autom4te.cache Logs
+	rm -rf autom4te.cache Logs configure.ac~
 	rm -rf config.guess config.sub configure~
 
diff --git a/configure.ac b/configure.ac
index c624295..3337575 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,5 +1,5 @@
-AC_INIT([nfs4-acl-tools], [0.3.3])
-AC_CONFIG_HEADER(include/config.h)
+AC_INIT([nfs4-acl-tools],[0.3.3])
+AC_CONFIG_HEADERS(include/config.h)
 AC_PREFIX_DEFAULT(/usr/local)
 
 AC_CONFIG_MACRO_DIRS([m4])
@@ -12,7 +12,6 @@ AC_SUBST(enable_shared)
 AC_PROG_INSTALL
 AC_PROG_CC
 
-AC_HEADER_STDC
 AC_CHECK_HEADERS([netinet/in.h stdlib.h string.h unistd.h])
 AC_CHECK_HEADERS([attr/xattr.h sys/xattr.h])
 
@@ -33,4 +32,5 @@ AC_PACKAGE_UTILITIES([nfs4acl])
 AC_PACKAGE_NEED_GETXATTR_LIBATTR
 AC_MANUAL_FORMAT
 
-AC_OUTPUT(include/builddefs)
+AC_CONFIG_FILES([include/builddefs])
+AC_OUTPUT
diff --git a/include/builddefs.in b/include/builddefs.in
index fe49b08..3dab1de 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -43,6 +43,7 @@ LIBNFS4ACL = $(TOPDIR)/libnfs4acl/libnfs4acl.la
 LIBATTR = @libattr@
 
 prefix = @prefix@
+datarootdir = @datarootdir@
 exec_prefix = @exec_prefix@
 
 DESTDIR =
-- 
2.36.1

