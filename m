Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17252CCB7E
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 02:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLCBPt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 20:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgLCBPt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Dec 2020 20:15:49 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58436C0617A6
        for <linux-nfs@vger.kernel.org>; Wed,  2 Dec 2020 17:15:09 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 904294EEA; Wed,  2 Dec 2020 20:14:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 904294EEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606958100;
        bh=QQ0W++hr8SINJR4W2khxxE2YLaCAvJuzeiJRJFcF4eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExVoVPhrxog5sjadXxrQ5+ltQmTlwMovw1XpQ8a7fzyhKsthXthZp2qCIjWnEaFOv
         gE/UgPYmPxUO0THuhvc3sRxakMfLG0X06OwT6jAiGP6omcPNMzyGv+1V0aVnLVxt4R
         f2tpN02rhPNl2JotUfagZTsgQUztNk5x2m6bzCXs=
From:   bfields@fieldses.org
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] mountd: allow high ports on all pseudofs exports
Date:   Wed,  2 Dec 2020 20:14:56 -0500
Message-Id: <1606958097-9041-1-git-send-email-bfields@fieldses.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20201203010546.GB348347@pick.fieldses.org>
References: <20201203010546.GB348347@pick.fieldses.org>
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
 utils/mountd/v4root.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/utils/mountd/v4root.c b/utils/mountd/v4root.c
index a9ea167a07e0..39dd87a94e59 100644
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
@@ -55,13 +55,11 @@ static nfs_export pseudo_root = {
 };
 
 static void
-set_pseudofs_security(struct exportent *pseudo, int flags)
+set_pseudofs_security(struct exportent *pseudo)
 {
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
 
@@ -90,7 +87,7 @@ v4root_create(char *path, nfs_export *export)
 	strncpy(eep.e_path, path, sizeof(eep.e_path)-1);
 	if (strcmp(path, "/") != 0)
 		eep.e_flags &= ~NFSEXP_FSID;
-	set_pseudofs_security(&eep, curexp->e_flags);
+	set_pseudofs_security(&eep);
 	exp = export_create(&eep, 0);
 	if (exp == NULL)
 		return NULL;
@@ -138,7 +135,7 @@ pseudofs_update(char *hostname, char *path, nfs_export *source)
 		return 0;
 	}
 	/* Update an existing V4ROOT export: */
-	set_pseudofs_security(&exp->m_export, source->m_export.e_flags);
+	set_pseudofs_security(&exp->m_export);
 	return 0;
 }
 
-- 
2.28.0

