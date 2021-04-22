Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A136870A
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 21:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhDVTSs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 15:18:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236668AbhDVTSs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 22 Apr 2021 15:18:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BF1DB039;
        Thu, 22 Apr 2021 19:18:12 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <steved@redhat.com>,
        NeilBrown <neilb@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: [RFC PATCH 1/1] mount.nfs: Fix mounting on tmpfs
Date:   Thu, 22 Apr 2021 21:18:03 +0200
Message-Id: <20210422191803.31511-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

LTP NFS tests (which use netns) fails on tmpfs since d4066486:

mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp /tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/0
mount.nfs: mounting 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp failed, reason given by server: No such file or directory

Fixes: d4066486 ("mount.nfs: improve version negotiation when vers=4 is specified.")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

not sure, if this is a correct fix thus RFC (I'm not from @umn.edu :)).
I suppose tmpfs is still meant to be supported, but maybe I'm wrong.

I did testing with LTP [1]:

$ for i in 3 4 4.1 4.2; do echo "* version: $i"; PATH="/opt/ltp/testcases/bin:$PATH" nfs01 -v $i -t tcp; done

Core of the tests is nfs_lib.sh [2], which sets network namespace (with
help of tst_net.sh [3]) and setup nfs with exportfs (use fsid to be
working properly on tmpfs) and run various tests with these NFS
versions: 3, 4, 4.1, 4.2.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/network/nfs/nfs_stress/nfs_lib.sh
[3] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_net.sh

 utils/mount/Makefile.am |  3 ++-
 utils/mount/stropts.c   | 29 ++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
index ad0be93b..d3905bec 100644
--- a/utils/mount/Makefile.am
+++ b/utils/mount/Makefile.am
@@ -28,7 +28,8 @@ endif
 mount_nfs_LDADD = ../../support/nfs/libnfs.la \
 		  ../../support/export/libexport.a \
 		  ../../support/misc/libmisc.a \
-		  $(LIBTIRPC)
+		  $(LIBTIRPC) \
+		  $(LIBPTHREAD)
 
 mount_nfs_SOURCES = $(mount_common)
 
diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 174a05f6..3961b8ce 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -31,6 +31,7 @@
 #include <time.h>
 
 #include <sys/socket.h>
+#include <sys/statfs.h>
 #include <sys/mount.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
@@ -50,6 +51,7 @@
 #include "parse_dev.h"
 #include "conffile.h"
 #include "misc.h"
+#include "nfsd_path.h"
 
 #ifndef NFS_PROGRAM
 #define NFS_PROGRAM	(100003)
@@ -104,6 +106,21 @@ struct nfsmount_info {
 				child;		/* forked bg child? */
 };
 
+/*
+ * Returns TRUE if mounting on tmpfs, otherwise FALSE.
+ */
+static int is_tmpfs(struct nfsmount_info *mi)
+{
+	struct statfs64 st;
+
+	if (nfsd_path_statfs64(mi->node, &st)) {
+		nfs_error(_("%s: Failed to statfs64 on path %s: %s"),
+			  progname, mi->node, strerror(errno));
+		return 0;
+	}
+
+	return st.f_type == 0x01021994;
+}
 
 static void nfs_default_version(struct nfsmount_info *mi)
 {
@@ -873,6 +890,9 @@ static int nfs_try_mount_v4(struct nfsmount_info *mi)
 		case EACCES:
 			continue;
 		default:
+			if (is_tmpfs(mi))
+				return 1;
+
 			goto out;
 		}
 	}
@@ -951,9 +971,12 @@ check_result:
 	}
 
 fall_back:
-	if (mi->version.v_mode == V_GENERAL)
-		/* v2,3 fallback not allowed */
-		return result;
+	if (mi->version.v_mode == V_GENERAL) {
+
+		/* v2,3 fallback not allowed unless tmpfs */
+		if (!is_tmpfs(mi))
+			return result;
+	}
 
 	/*
 	 * Save the original errno in case the v3 
-- 
2.31.1

