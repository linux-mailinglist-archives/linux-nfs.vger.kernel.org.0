Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0914BA0FB
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 14:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiBQNXN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 08:23:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbiBQNXM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 08:23:12 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190BAEF12
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 05:22:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2125560F6B8E;
        Thu, 17 Feb 2022 14:16:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7AdH86T1LhPA; Thu, 17 Feb 2022 14:16:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7AE3860D482C;
        Thu, 17 Feb 2022 14:16:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sDOCmXgzzmK9; Thu, 17 Feb 2022 14:16:40 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E43C9605DEBB;
        Thu, 17 Feb 2022 14:16:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 5/6] nfsd: statfs() every known subvolume upon start
Date:   Thu, 17 Feb 2022 14:15:30 +0100
Message-Id: <20220217131531.2890-6-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220217131531.2890-1-richard@nod.at>
References: <20220217131531.2890-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This will trigger an automount of a subvolume and existing
file handles will continue to work.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 utils/nfsd/Makefile.am |  6 ++++++
 utils/nfsd/nfsd.c      | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/utils/nfsd/Makefile.am b/utils/nfsd/Makefile.am
index 8acc9a04..3acc8354 100644
--- a/utils/nfsd/Makefile.am
+++ b/utils/nfsd/Makefile.am
@@ -11,6 +11,12 @@ noinst_HEADERS =3D nfssvc.h
 nfsd_SOURCES =3D nfsd.c nfssvc.c
 nfsd_LDADD =3D ../../support/nfs/libnfs.la $(LIBTIRPC)
=20
+if CONFIG_REEXPORT
+nfsd_LDADD +=3D ../../support/reexport/libreexport.a $(LIBSQLITE) $(LIBP=
THREAD) -lrt
+endif
+
+nfsd_CPPFLAGS =3D -I$(top_srcdir)/support/reexport
+
 MAINTAINERCLEANFILES =3D Makefile.in
=20
 #######################################################################
diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index b0741718..b5175f7a 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -29,6 +29,7 @@
 #include "nfssvc.h"
 #include "xlog.h"
 #include "xcommon.h"
+#include "reexport.h"
=20
 #ifndef NFSD_NPROC
 #define NFSD_NPROC 8
@@ -347,6 +348,15 @@ main(int argc, char **argv)
 		exit(1);
 	}
=20
+	/*
+	 * Make sure that uncovered NFS subvolumes are present such that
+	 * existing file handles continue working.
+	 */
+	if (reexpdb_init() =3D=3D 0) {
+		reexpdb_uncover_subvolumes(NULL);
+		reexpdb_destroy();
+	}
+
 	/* make sure nfsdfs is mounted if it's available */
 	nfssvc_mount_nfsdfs(progname);
=20
--=20
2.31.1

