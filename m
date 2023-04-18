Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C6B6E5D7E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjDRJeb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjDRJeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:23 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F696580
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EEC6964548AB;
        Tue, 18 Apr 2023 11:34:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WW06JdmeZJiL; Tue, 18 Apr 2023 11:34:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 44AFD6431C58;
        Tue, 18 Apr 2023 11:34:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2GWg6ee8cyin; Tue, 18 Apr 2023 11:34:15 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id BF83764548AB;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 8/8] Add fsid systemd service file
Date:   Tue, 18 Apr 2023 11:33:50 +0200
Message-Id: <20230418093350.4550-9-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230418093350.4550-1-richard@nod.at>
References: <20230418093350.4550-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Co-developed-by: Chris Chilvers <chris.chilvers@appsbroker.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 systemd/Makefile.am   |  3 ++-
 systemd/fsidd.service | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 systemd/fsidd.service

diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 2e250dca..b4483222 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -15,7 +15,8 @@ unit_files =3D  \
     rpc-statd-notify.service \
     rpc-statd.service \
     \
-    proc-fs-nfsd.mount
+    proc-fs-nfsd.mount \
+    fsidd.service
=20
 rpc_pipefs_mount_file =3D \
     var-lib-nfs-rpc_pipefs.mount
diff --git a/systemd/fsidd.service b/systemd/fsidd.service
new file mode 100644
index 00000000..9cb480e3
--- /dev/null
+++ b/systemd/fsidd.service
@@ -0,0 +1,10 @@
+[Unit]
+Description=3DNFS FSID Daemon
+After=3Dlocal-fs.target
+Before=3Dnfs-mountd.service nfs-server.service
+
+[Service]
+ExecStart=3D/usr/sbin/fsidd
+
+[Install]
+RequiredBy=3Dnfs-mountd.service nfs-server.service
--=20
2.31.1

