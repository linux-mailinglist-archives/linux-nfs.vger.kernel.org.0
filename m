Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD97D81FB
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 13:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJZLqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZLqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 07:46:33 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 04:46:29 PDT
Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F46B1A7
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 04:46:29 -0700 (PDT)
Received: from localhost.localdomain ([146.241.115.208])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vynjq3v5QpgXYvynkqNRmH; Thu, 26 Oct 2023 13:45:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1698320724; bh=QFuL8Wqq9npNMw07i07+jC6u8BSIhQzvy3c+e3sLfD4=;
        h=From:To:Subject:Date:MIME-Version;
        b=fDePx19cM4eDIC0PkDoH2NZDmuCiTVcBARsm2HCFgqzFnrxAtg/o2TmOonQZ9KyXg
         HCYCeSxSQKNNYYEp7PGxaqtfcB16PC2nQ87yxABksp6A/KP+lgUkJGEA5Y7M9liz6x
         2xyUI+VGAHIZnk/0/nYmvLY6vztZVPK9bQSVg6kFDIcxw1Jib0+khoNEMgxr0Jw4Lo
         T2k+XatE0FJNXWXW9AzxDP/V4w49f2cjtw3Vc56T7a0v3Y4fQRoqS50mkhZMllCRdm
         z8OGmmBBvI2ama7v4BLHsAKLO1mdXnx/YJpbFv1rqcwO/4nD4UKkGCPztMS7paMwhG
         /3mrKbmrfDOZw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils 1/2] Fix build failure due to glibc <= 2.24 and check for Linux 3.17+
Date:   Thu, 26 Oct 2023 13:45:21 +0200
Message-Id: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBnFJPwrl4qZ93xF+YbgNxlS5bjEzWrXp9fcU/XlXFmw6h7cFTHQeWaXsNoRl+ViXeqkENgUpjqWkM84hBvYGLxqYCfdfgEhDH5x/EQf6yLV0hIfz6/T
 7iFHGNxb4RD3LGx2HMpMdOpIjnkhmUwaknCJ6TW0kUs/U1FV/kVmmUw2OJnFcqBbFdiJx9QzhCCrbKUIKC9/25KTrVxD0de7jh5UM+rI49HFHcx7NDiOPHg8
 lgllnoKP2qfbbYgurwN114AKWzudGxde7upU6BrfKyCbhKXgmodKare8/m6yiLQL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Function getrandom() is present only with glibc 2.24+ so add a direct
syscall otherwise. This is only possible with Linux 3.17+ so let's also
check for it and in case emit error on autotools configure.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 configure.ac                      | 32 +++++++++++++++++++++++++++++++
 support/reexport/backend_sqlite.c | 17 +++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6fbcb974..7efca90c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -328,6 +328,38 @@ AC_CHECK_HEADERS([sched.h], [], [])
 AC_CHECK_FUNCS([unshare fstatat statx], [] , [])
 AC_LIBPTHREAD([])
 
+AC_MSG_CHECKING([for getrandom (Linux 3.17+, glibc 2.25+)])
+AC_LINK_IFELSE([AC_LANG_SOURCE([
+  #include <stdlib.h>  /* for NULL */
+  #include <sys/random.h>
+  int main() {
+    return getrandom(NULL, 0U, 0U);
+  }
+])], [
+    AC_DEFINE([HAVE_GETRANDOM], [1],
+        [Define to 1 if you have the `getrandom' function.])
+    AC_MSG_RESULT([yes])
+], [
+    AC_MSG_RESULT([no])
+
+    AC_MSG_CHECKING([for syscall SYS_getrandom (Linux 3.17+)])
+    AC_LINK_IFELSE([AC_LANG_SOURCE([
+      #include <stdlib.h>  /* for NULL */
+      #include <unistd.h>  /* for syscall */
+      #include <sys/syscall.h>  /* for SYS_getrandom */
+      int main() {
+        syscall(SYS_getrandom, NULL, 0, 0);
+        return 0;
+      }
+    ])], [
+        AC_DEFINE([HAVE_SYSCALL_GETRANDOM], [1],
+            [Define to 1 if you have `syscall' and `SYS_getrandom'.])
+        AC_MSG_RESULT([yes])
+    ], [
+        AC_MSG_ERROR(['syscall' and 'SYS_getrandom' not found.])
+    ])
+])
+
 # rpc/rpc.h can come from the glibc or from libtirpc
 nfsutils_save_CPPFLAGS="${CPPFLAGS}"
 CPPFLAGS="${CPPFLAGS} ${TIRPC_CFLAGS}"
diff --git a/support/reexport/backend_sqlite.c b/support/reexport/backend_sqlite.c
index 132f30c4..f1e390bc 100644
--- a/support/reexport/backend_sqlite.c
+++ b/support/reexport/backend_sqlite.c
@@ -7,13 +7,28 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/random.h>
 #include <unistd.h>
 
 #include "conffile.h"
 #include "reexport_backend.h"
 #include "xlog.h"
 
+/* Fix up glibc <= 2.24 not having getrandom() */
+#if defined HAVE_GETRANDOM
+#include <sys/random.h>
+#else
+#include <sys/syscall.h>
+static ssize_t getrandom(void *buffer, size_t length, unsigned flags)
+{
+# if defined(__NR_getrandom)
+	return syscall(__NR_getrandom, buffer, length, flags);
+# else
+	errno = ENOSYS;
+	return -1;
+# endif
+}
+#endif
+
 #define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
 #define REEXPDB_DBFILE_WAIT_USEC (5000)
 
-- 
2.34.1

