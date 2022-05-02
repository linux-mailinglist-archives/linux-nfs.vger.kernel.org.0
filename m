Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B7516C86
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383909AbiEBIzM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383910AbiEBIzL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 04:55:11 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BA613F7A
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 01:51:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C8358607198A;
        Mon,  2 May 2022 10:51:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JeVAsQQhzYR9; Mon,  2 May 2022 10:51:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1AEB36081105;
        Mon,  2 May 2022 10:51:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qXckNiyBi4Ji; Mon,  2 May 2022 10:51:30 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 00C946081103;
        Mon,  2 May 2022 10:51:29 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, steved@redhat.com,
        chris.chilvers@appsbroker.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/5] reexport: Make state database location configurable
Date:   Mon,  2 May 2022 10:50:45 +0200
Message-Id: <20220502085045.13038-6-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220502085045.13038-1-richard@nod.at>
References: <20220502085045.13038-1-richard@nod.at>
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

With the database location configurable it is possible to
place the sqlite database on a shared filesystem.
That way the reexport state can be shared among multiple
re-exporting NFS servers.

Be careful with shared filesystems, SQLite assumes that file locking
works on such filesystems. Not all filesystems implement this
correctly.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 nfs.conf                    | 3 +++
 support/reexport/reexport.c | 5 ++++-
 systemd/nfs.conf.man        | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/nfs.conf b/nfs.conf
index 8c714ff7..f19c346a 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -96,3 +96,6 @@ rdma-port=3D20049
 #
 [svcgssd]
 # principal=3D
+
+[reexport]
+# sqlitedb=3D
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index 51e49834..61574fc5 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -12,6 +12,7 @@
 #include <unistd.h>
=20
 #include "nfsd_path.h"
+#include "conffile.h"
 #include "nfslib.h"
 #include "reexport.h"
 #include "xcommon.h"
@@ -55,7 +56,9 @@ int reexpdb_init(void)
 	if (prng_init() !=3D 0)
 		return -1;
=20
-	ret =3D sqlite3_open_v2(REEXPDB_DBFILE, &db, SQLITE_OPEN_READWRITE | SQ=
LITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, NULL);
+	ret =3D sqlite3_open_v2(conf_get_str_with_def("reexport", "sqlitedb", R=
EEXPDB_DBFILE),
+			      &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_F=
ULLMUTEX,
+			      NULL);
 	if (ret !=3D SQLITE_OK) {
 		xlog(L_ERROR, "Unable to open reexport database: %s", sqlite3_errstr(r=
et));
 		return -1;
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 4436a38a..afd2b3f8 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -295,6 +295,12 @@ Only
 .B debug=3D
 is recognized.
=20
+.TP
+.B reexport
+Only
+.B sqlitedb=3D
+is recognized, path to the state database.
+
 .SH FILES
 .TP 10n
 .I /etc/nfs.conf
--=20
2.31.1

