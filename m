Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8731DFC2
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Feb 2021 20:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhBQTmf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Feb 2021 14:42:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233398AbhBQTme (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Feb 2021 14:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613590868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjLy6YN3S+l95caWxK/rirUFWldIASYd7wSIow/0VnU=;
        b=aGVgz7JFNmvvJqUrEhEQVfC7vvw8su2fZBl3Rwj8uyZDTcf3iAGekD0CNQpWO8169tVh2e
        BN7Rs+vpms3kJud3MFtFXCcQ8KOCNAIAsbBmNeHcEEgzYiOxLYj0X5/UYUjDW/2pJ3Z6sW
        7V4d0nTMWqHAy6Ilc8IMmSFblHMRCbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-QWZF6gzyNV2Jb55nO7v-Og-1; Wed, 17 Feb 2021 14:41:06 -0500
X-MC-Unique: QWZF6gzyNV2Jb55nO7v-Og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 085AD801976
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 19:41:06 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAF2F18B5E
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 19:41:05 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 5/6] exportd: Enabled junction support
Date:   Wed, 17 Feb 2021 14:42:39 -0500
Message-Id: <20210217194240.79915-6-steved@redhat.com>
In-Reply-To: <20210217194240.79915-1-steved@redhat.com>
References: <20210217194240.79915-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 utils/exportd/Makefile.am                 | 5 ++++-
 utils/mountd/Makefile.am                  | 3 +--
 5 files changed, 6 insertions(+), 4 deletions(-)
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
index 0fcd92f..2fd3ba1 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -1,6 +1,9 @@
 ## Process this file with automake to produce Makefile.in
 
-OPTLIBS     =
+OPTLIBS		=
+if CONFIG_JUNCTION
+OPTLIBS		+= ../../support/junction/libjunction.la $(LIBXML2)
+endif
 
 man8_MANS   = exportd.man
 EXTRA_DIST  = $(man8_MANS)
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

