Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9E31F296
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 23:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBRWyq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 17:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhBRWyp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 17:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613688799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sgwxhz8gxuq+JNCh7YtYmopfxScAxC6V8+cRfi+fb7M=;
        b=MTU0BxoKUJx8S3tfM2Kw5V6L3kMs108zqCLkOq4G1RGEcfutLhuZh0E/47V+TUlc3QJ5Ax
        hhG2BudFbJXQqs8P7GXlgI4/iJEydQEMQtoQeresG1P1oy2oJEp0YL3Kq9gNk+vYW4Z57w
        2588I9fTrsXCRk3JsC0ydQqrCE9wQCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-1oTmy3QcOguj2extX0fuQQ-1; Thu, 18 Feb 2021 17:53:16 -0500
X-MC-Unique: 1oTmy3QcOguj2extX0fuQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A69A1966320
        for <linux-nfs@vger.kernel.org>; Thu, 18 Feb 2021 22:53:15 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A69B60BE5
        for <linux-nfs@vger.kernel.org>; Thu, 18 Feb 2021 22:53:15 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 5/6] exportd: Enabled junction support
Date:   Thu, 18 Feb 2021 17:54:49 -0500
Message-Id: <20210218225450.674466-6-steved@redhat.com>
In-Reply-To: <20210218225450.674466-1-steved@redhat.com>
References: <20210218225450.674466-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Moved the junction support from mountd to libexport.a
so both exportd and mountd can use the code.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/export/Makefile.am                | 2 +-
 {utils/mountd => support/export}/fsloc.c  | 0
 {utils/mountd => support/include}/fsloc.h | 0
 utils/exportd/Makefile.am                 | 3 +++
 utils/mountd/Makefile.am                  | 3 +--
 5 files changed, 5 insertions(+), 3 deletions(-)
 rename {utils/mountd => support/export}/fsloc.c (100%)
 rename {utils/mountd => support/include}/fsloc.h (100%)

diff --git a/support/export/Makefile.am b/support/export/Makefile.am
index 7de82a8..a9e710c 100644
--- a/support/export/Makefile.am
+++ b/support/export/Makefile.am
@@ -12,7 +12,7 @@ EXTRA_DIST	= mount.x
 noinst_LIBRARIES = libexport.a
 libexport_a_SOURCES = client.c export.c hostname.c \
 		      xtab.c mount_clnt.c mount_xdr.c \
-			  cache.c auth.c v4root.c
+			  cache.c auth.c v4root.c fsloc.c
 BUILT_SOURCES 	= $(GENFILES)
 
 noinst_HEADERS = mount.h
diff --git a/utils/mountd/fsloc.c b/support/export/fsloc.c
similarity index 100%
rename from utils/mountd/fsloc.c
rename to support/export/fsloc.c
diff --git a/utils/mountd/fsloc.h b/support/include/fsloc.h
similarity index 100%
rename from utils/mountd/fsloc.h
rename to support/include/fsloc.h
diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
index eb0f0a8..eb521f1 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -1,6 +1,9 @@
 ## Process this file with automake to produce Makefile.in
 
 OPTLIBS		=
+if CONFIG_JUNCTION
+OPTLIBS		+= ../../support/junction/libjunction.la $(LIBXML2)
+endif
 
 man8_MANS	= exportd.man
 EXTRA_DIST	= $(man8_MANS)
diff --git a/utils/mountd/Makefile.am b/utils/mountd/Makefile.am
index cac3275..859f28e 100644
--- a/utils/mountd/Makefile.am
+++ b/utils/mountd/Makefile.am
@@ -12,9 +12,8 @@ RPCPREFIX	= rpc.
 KPREFIX		= @kprefix@
 sbin_PROGRAMS	= mountd
 
-noinst_HEADERS = fsloc.h
 mountd_SOURCES = mountd.c mount_dispatch.c rmtab.c \
-		 svc_run.c fsloc.c mountd.h
+		 svc_run.c mountd.h
 mountd_LDADD = ../../support/export/libexport.a \
 	       ../../support/nfs/libnfs.la \
 	       ../../support/misc/libmisc.a \
-- 
2.29.2

