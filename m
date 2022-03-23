Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8867B4E59C1
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Mar 2022 21:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbiCWUUm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiCWUUl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 16:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C5671CB3A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648066750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Am6lhT2qbsmRqVPaDfBrigBs2TIbVKCJe7CvKinIzaI=;
        b=dG7BRhywrYGAW/h36RvwgUNKCEZlxfeQLrVPFGfu4ZYv4gZpgb2VqfLj7i4el1SxJaSXSe
        yRsHAyoj5pVpF5ff+aWaiV0IjJjVfet8fLBG5fCenUFk0a3sX/IqagG/vuMWe4kdGYIUv2
        EPAM5Arhfve3prJkLrwXN2aT9oM7SVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-_zazaxjzMZakc6zFlgiwVg-1; Wed, 23 Mar 2022 16:18:59 -0400
X-MC-Unique: _zazaxjzMZakc6zFlgiwVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B663E803D7A;
        Wed, 23 Mar 2022 20:18:58 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-121.gru2.redhat.com [10.97.116.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44139401E24;
        Wed, 23 Mar 2022 20:18:54 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH RFC v3 1/6] Create nfsrahead
Date:   Wed, 23 Mar 2022 17:18:36 -0300
Message-Id: <20220323201841.4166549-2-tbecker@redhat.com>
In-Reply-To: <20220323201841.4166549-1-tbecker@redhat.com>
References: <20220323201841.4166549-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This tool is invoked by udev to find and set the readahead value to NFS
mounts.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 .gitignore                  | 1 +
 configure.ac                | 1 +
 tools/Makefile.am           | 2 +-
 tools/nfsrahead/Makefile.am | 3 +++
 tools/nfsrahead/main.c      | 7 +++++++
 5 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfsrahead/Makefile.am
 create mode 100644 tools/nfsrahead/main.c

diff --git a/.gitignore b/.gitignore
index c89d1cd2..38ab1d39 100644
--- a/.gitignore
+++ b/.gitignore
@@ -61,6 +61,7 @@ utils/statd/statd
 tools/locktest/testlk
 tools/getiversion/getiversion
 tools/nfsconf/nfsconf
+tools/nfsrahead/nfsrahead
 support/export/mount.h
 support/export/mount_clnt.c
 support/export/mount_xdr.c
diff --git a/configure.ac b/configure.ac
index e0f5a930..3e1c183b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -737,6 +737,7 @@ AC_CONFIG_FILES([
 	tools/rpcgen/Makefile
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
+	tools/nfsrahead/Makefile
 	tools/rpcctl/Makefile
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index c3feabbe..40c17c37 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
 endif
 
-SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts $(OPTDIRS)
+SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts nfsrahead $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
new file mode 100644
index 00000000..edff7921
--- /dev/null
+++ b/tools/nfsrahead/Makefile.am
@@ -0,0 +1,3 @@
+libexec_PROGRAMS = nfsrahead
+nfsrahead_SOURCES = main.c
+
diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
new file mode 100644
index 00000000..e454108e
--- /dev/null
+++ b/tools/nfsrahead/main.c
@@ -0,0 +1,7 @@
+#include <stdio.h>
+
+int main(int argc, char **argv, char **envp)
+{
+	unsigned int readahead = 128;
+	printf("%d\n", readahead);
+}
-- 
2.35.1

