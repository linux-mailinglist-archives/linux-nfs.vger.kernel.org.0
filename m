Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765AE2B4E8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2019 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfE0MVk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 May 2019 08:21:40 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:39758 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfE0MVj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 May 2019 08:21:39 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id HQMe2000R3XaVaC01QMe3y; Mon, 27 May 2019 14:21:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEdG-0001Tc-H0; Mon, 27 May 2019 14:21:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEdG-0001TP-Fr; Mon, 27 May 2019 14:21:38 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [trivial] nfsd: Spelling s/EACCESS/EACCES/
Date:   Mon, 27 May 2019 14:21:32 +0200
Message-Id: <20190527122132.5617-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The correct spelling is EACCES:

include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/nfsd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fc24ee47eab51ad4..c85783e536d595de 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -404,7 +404,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	/*
 	 * If utimes(2) and friends are called with times not NULL, we should
 	 * not set NFSD_MAY_WRITE bit. Otherwise fh_verify->nfsd_permission
-	 * will return EACCESS, when the caller's effective UID does not match
+	 * will return EACCES, when the caller's effective UID does not match
 	 * the owner of the file, and the caller is not privileged. In this
 	 * situation, we should return EPERM(notify_change will return this).
 	 */
-- 
2.17.1

