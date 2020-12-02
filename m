Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB872CCA1E
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Dec 2020 23:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgLBW51 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 17:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgLBW51 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Dec 2020 17:57:27 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E245C0617A7
        for <linux-nfs@vger.kernel.org>; Wed,  2 Dec 2020 14:56:47 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 26CC936E1; Wed,  2 Dec 2020 17:56:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 26CC936E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606949806;
        bh=e23lMBrIqh6/a1IB0MTiMhnf/lgSgpVBGyI898DqklY=;
        h=From:To:Cc:Subject:Date:From;
        b=UFaKV5zFKjSMWHcImsYwj8KLX51BIpiqdYUhFTyWSz/FXaUG26rc50Lrm1+sFLhhz
         e0NnOoSyW58sj9EO/2OBMNbl8kqUrgswF3LSzmKEbQKABdbRZ05F26Zzue0V5KO0bW
         sbC2N1TS2D6K1jj+giuwBY90V847/zl4JJEFQBz8=
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] mountd: allow high ports on all pseudofs exports
Date:   Wed,  2 Dec 2020 17:56:43 -0500
Message-Id: <1606949804-31417-1-git-send-email-bfields@fieldses.org>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

We originally tried to grant permissions on the v4 pseudoroot filesystem
that were the absolute minimum required for a client to reach a given
export.  This turns out to be complicated, and we've never gotten it
quite right.  Also, the tradition from the MNT protocol was to allow
anyone to browse the list of exports.

So, do as we already did with security flavors and just allow clients
from high ports to access the whole pseudofilesystem.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 utils/mountd/v4root.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/utils/mountd/v4root.c b/utils/mountd/v4root.c
index a9ea167a07e0..2ac4e87898c0 100644
--- a/utils/mountd/v4root.c
+++ b/utils/mountd/v4root.c
@@ -36,7 +36,7 @@ static nfs_export pseudo_root = {
 		.e_path = "/",
 		.e_flags = NFSEXP_READONLY | NFSEXP_ROOTSQUASH
 				| NFSEXP_NOSUBTREECHECK | NFSEXP_FSID
-				| NFSEXP_V4ROOT,
+				| NFSEXP_V4ROOT | NFSEXP_INSECURE_PORT,
 		.e_anonuid = 65534,
 		.e_anongid = 65534,
 		.e_squids = NULL,
@@ -60,8 +60,6 @@ set_pseudofs_security(struct exportent *pseudo, int flags)
 	struct flav_info *flav;
 	int i;
 
-	if (flags & NFSEXP_INSECURE_PORT)
-		pseudo->e_flags |= NFSEXP_INSECURE_PORT;
 	if ((flags & NFSEXP_ROOTSQUASH) == 0)
 		pseudo->e_flags &= ~NFSEXP_ROOTSQUASH;
 	for (flav = flav_map; flav < flav_map + flav_map_size; flav++) {
@@ -70,8 +68,7 @@ set_pseudofs_security(struct exportent *pseudo, int flags)
 		i = secinfo_addflavor(flav, pseudo);
 		new = &pseudo->e_secinfo[i];
 
-		if (flags & NFSEXP_INSECURE_PORT)
-			new->flags |= NFSEXP_INSECURE_PORT;
+		new->flags |= NFSEXP_INSECURE_PORT;
 	}
 }
 
-- 
2.28.0

