Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD6D6128D4
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Oct 2022 08:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJ3Hf6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Oct 2022 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJ3Hfv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Oct 2022 03:35:51 -0400
X-Greylist: delayed 508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Oct 2022 00:35:11 PDT
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF8D9CE26
        for <linux-nfs@vger.kernel.org>; Sun, 30 Oct 2022 00:35:11 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id p2iPojcIb94emp2iPo27xg; Sun, 30 Oct 2022 08:26:42 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 30 Oct 2022 08:26:42 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Fix the share reservation conflict to courteous server logic in nfs4_upgrade_open()
Date:   Sun, 30 Oct 2022 08:26:39 +0100
Message-Id: <7ed2d8f1ee8c441a13b450c5e5c50f13fae3a2b9.1667114760.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

'status != nfserr_share_denied' is known to be true because we test
'status == nfs_ok' the line just above.

So nfs4_resolve_deny_conflicts_locked() can never be called.

Fix the logic and avoid the dead code.

Fixes: 3d6942715180 ("NFSD: add support for share reservation conflict to courteous server")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative.
It is compile tested only.

REVIEW WITH CARE.
---
 fs/nfsd/nfs4state.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1ded89235111..de0565e9485c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5260,15 +5260,13 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	spin_lock(&fp->fi_lock);
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status == nfs_ok) {
-		if (status != nfserr_share_denied) {
-			set_deny(open->op_share_deny, stp);
-			fp->fi_share_deny |=
+		set_deny(open->op_share_deny, stp);
+		fp->fi_share_deny |=
 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
-		} else {
-			if (nfs4_resolve_deny_conflicts_locked(fp, false,
-					stp, open->op_share_deny, false))
-				status = nfserr_jukebox;
-		}
+	} else if (status == nfserr_share_denied) {
+		if (nfs4_resolve_deny_conflicts_locked(fp, false, stp,
+				open->op_share_deny, false))
+			status = nfserr_jukebox;
 	}
 	spin_unlock(&fp->fi_lock);
 
-- 
2.34.1

