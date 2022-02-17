Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B74BA0FE
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 14:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbiBQNXK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 08:23:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbiBQNXJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 08:23:09 -0500
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 05:22:53 PST
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26B996AE
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 05:22:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E69A160F6B69;
        Thu, 17 Feb 2022 14:16:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lk-DzrSJFwxk; Thu, 17 Feb 2022 14:16:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0D132608A38A;
        Thu, 17 Feb 2022 14:16:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V0GTcbLbDGXO; Thu, 17 Feb 2022 14:16:39 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 71E23605DED6;
        Thu, 17 Feb 2022 14:16:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 4/6] export: Record mounted volumes
Date:   Thu, 17 Feb 2022 14:15:29 +0100
Message-Id: <20220217131531.2890-5-richard@nod.at>
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

As soon a client mounts a volume, record it in the database
to be able to uncover NFS subvolumes after a reboot.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 6039745e..b5763b1d 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -967,8 +967,10 @@ static void nfsd_fh(int f)
 	 * line.
 	 */
 	qword_addint(&bp, &blen, 0x7fffffff);
-	if (found)
+	if (found) {
+		reexpdb_add_subvolume(found_path);
 		qword_add(&bp, &blen, found_path);
+	}
 	qword_addeol(&bp, &blen);
 	if (blen <=3D 0 || cache_write(f, buf, bp - buf) !=3D bp - buf)
 		xlog(L_ERROR, "nfsd_fh: error writing reply");
--=20
2.31.1

