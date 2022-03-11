Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F104D68E4
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 20:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiCKTHm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 14:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351025AbiCKTHl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 14:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C33B31AD968
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 11:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647025596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3e/mQr631TVpW2bxB/VmwNQeB3Z+TAfFFb14VYQSzQ=;
        b=TIo+q+9DaAGDc0Kx3D1bDvSn/oe+IQHpvnqFl/tYefP+hqOabPpouvMctcR8wTYM4/OQ63
        0LeDIZECjUb6o7f+uKKc/7GRTYVxQ37T+n7z2nHIzt4eY2ZrUCmI6tT9Ub9BjJ+Ik+g+46
        PF3yxO2zyzqOFV59cYtamOQPzDw227Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-QirQ-K0MNkGMUHxwm-PQ_w-1; Fri, 11 Mar 2022 14:06:35 -0500
X-MC-Unique: QirQ-K0MNkGMUHxwm-PQ_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B4E51091DA1;
        Fri, 11 Mar 2022 19:06:34 +0000 (UTC)
Received: from nyarly.rlyeh.local (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75FB960BF4;
        Fri, 11 Mar 2022 19:06:30 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [RFC v2 PATCH 1/7] Create nfs-readahead-udev
Date:   Fri, 11 Mar 2022 16:06:11 -0300
Message-Id: <20220311190617.3294919-2-tbecker@redhat.com>
In-Reply-To: <20220311190617.3294919-1-tbecker@redhat.com>
References: <20220311190617.3294919-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 .gitignore                           | 1 +
 configure.ac                         | 1 +
 tools/Makefile.am                    | 2 +-
 tools/nfs-readahead-udev/Makefile.am | 3 +++
 tools/nfs-readahead-udev/main.c      | 7 +++++++
 5 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfs-readahead-udev/Makefile.am
 create mode 100644 tools/nfs-readahead-udev/main.c

diff --git a/.gitignore b/.gitignore
index c89d1cd2..c99269a4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -61,6 +61,7 @@ utils/statd/statd
 tools/locktest/testlk
 tools/getiversion/getiversion
 tools/nfsconf/nfsconf
+tools/nfs-readahead-udev/nfs-readahead-udev
 support/export/mount.h
 support/export/mount_clnt.c
 support/export/mount_xdr.c
diff --git a/configure.ac b/configure.ac
index e0f5a930..7e5ba5d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -737,6 +737,7 @@ AC_CONFIG_FILES([
 	tools/rpcgen/Makefile
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
+	tools/nfs-readahead-udev/Makefile
 	tools/rpcctl/Makefile
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index c3feabbe..621cde03 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
 endif
 
-SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts $(OPTDIRS)
+SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts nfs-readahead-udev $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
new file mode 100644
index 00000000..5455e954
--- /dev/null
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -0,0 +1,3 @@
+libexec_PROGRAMS = nfs-readahead-udev
+nfs_readahead_udev_SOURCES = main.c
+
diff --git a/tools/nfs-readahead-udev/main.c b/tools/nfs-readahead-udev/main.c
new file mode 100644
index 00000000..e454108e
--- /dev/null
+++ b/tools/nfs-readahead-udev/main.c
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

