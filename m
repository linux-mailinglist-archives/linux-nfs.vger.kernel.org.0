Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A276E5D79
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDRJe1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjDRJeV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:21 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFDF55AC
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2662663CC168;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pLHwOPXptlSa; Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BB21764548A2;
        Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id muDwwMAn3yeP; Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 5104C6431C4A;
        Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/8] export: Uncover NFS subvolume after reboot
Date:   Tue, 18 Apr 2023 11:33:46 +0200
Message-Id: <20230418093350.4550-5-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230418093350.4550-1-richard@nod.at>
References: <20230418093350.4550-1-richard@nod.at>
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

When a re-exporting NFS server reboots, none of the subvolumes are presen=
t.
This is because the NFS client code will mount only upon first access.
So, when we see an NFS handle with an yet unknown fsidnum, lookup in
the reexport database for it.
If one is found, stat the path to trigger the mount.
That way stale NFS handles are avoided after a reboot.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/support/export/cache.c b/support/export/cache.c
index 42a694d0..19bbba55 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -778,6 +778,7 @@ static void nfsd_fh(int f)
 	int dev_missing =3D 0;
 	char buf[RPC_CHAN_BUF_SIZE], *bp;
 	int blen;
+	int did_uncover =3D 0;
=20
 	blen =3D cache_read(f, buf, sizeof(buf));
 	if (blen <=3D 0 || buf[blen-1] !=3D '\n') return;
@@ -815,6 +816,11 @@ static void nfsd_fh(int f)
 		for (exp =3D exportlist[i].p_head; exp; exp =3D next_exp) {
 			char *path;
=20
+			if (!did_uncover && parsed.fsidnum && parsed.fsidtype =3D=3D FSID_NUM=
 && exp->m_export.e_reexport !=3D REEXP_NONE) {
+				reexpdb_uncover_subvolume(parsed.fsidnum);
+				did_uncover =3D 1;
+			}
+
 			if (exp->m_export.e_flags & NFSEXP_CROSSMOUNT) {
 				static nfs_export *prev =3D NULL;
 				static void *mnt =3D NULL;
--=20
2.31.1

