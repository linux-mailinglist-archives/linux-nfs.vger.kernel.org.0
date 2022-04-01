Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69814EF79C
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbiDAQLc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349535AbiDAQI4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 12:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7586DFFB48
        for <linux-nfs@vger.kernel.org>; Fri,  1 Apr 2022 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648827159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/gwv7Px62VyAEaIFavhsWYpeXfWia3hAQmD6wryrDw=;
        b=flSAWbSWbjJQtbs+e1hcCu7IDRdE5HCW5o+AxTTf1kCQlPJB5A4ujgGac5wFSvlEqjPxJy
        gwnKA29XF1u1C8wiXRq2FsDF2iPJw9jE/Vgyo3azJd5OOTt4pfHdTu/sVEr6A583obC77s
        6ufIMuYTtMrJOVpP2+0UQgRpGHYlAQU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-sKmpgSICO2KJdfI8dTOPqg-1; Fri, 01 Apr 2022 11:32:31 -0400
X-MC-Unique: sKmpgSICO2KJdfI8dTOPqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9895380418E;
        Fri,  1 Apr 2022 15:32:28 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-139.gru2.redhat.com [10.97.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6227F7C30;
        Fri,  1 Apr 2022 15:32:24 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH v4 1/7] Create nfsrahead
Date:   Fri,  1 Apr 2022 12:32:02 -0300
Message-Id: <20220401153208.3120851-2-tbecker@redhat.com>
In-Reply-To: <20220401153208.3120851-1-tbecker@redhat.com>
References: <20220401153208.3120851-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Kernel commit c128e575514c ("NFS: Optimise the default readahead size")
changed the calculation for NFS readahead from a multiple of rsize to
the system default, 128 kiB. This setting has been causing read heavy
workloads to underperform by at least 30%, as show below.

$ cat /sys/class/bdi/0\:55/read_ahead_kb
128

$ for i in {0..3} ; do dd if=/mnt/testfile.bin of=/dev/null bs=1M 2>&1 \
      | grep copied ; echo 3 > /proc/sys/vm/drop_caches ; done
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 17.056 s, 252 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 17.1258 s, 251 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 16.5981 s, 259 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 16.5487 s, 260 MB/s

$ echo 15360 > /sys/class/bdi/0\:55/read_ahead_kb

$ for i in {0..3} ; do dd if=/mnt/testfile.bin of=/dev/null bs=1M 2>&1 \
      | grep copied ; echo 3 > /proc/sys/vm/drop_caches ; done
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 12.3855 s, 347 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.2528 s, 382 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.9849 s, 358 MB/s
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.2953 s, 380 MB/s

This patch and the following create a tool for automatically setting NFS
readahead during the mount, nfsrahead. The tool is invoked from udev
when the NFS backing device is created in kernel, and sets the readahead
using the sysfs interface.

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
index 00000000..0359aced
--- /dev/null
+++ b/tools/nfsrahead/main.c
@@ -0,0 +1,7 @@
+#include <stdio.h>
+
+int main(int argc, char **argv)
+{
+	unsigned int readahead = 128;
+	printf("%d\n", readahead);
+}
-- 
2.35.1

