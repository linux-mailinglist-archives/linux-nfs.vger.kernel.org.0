Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FD1966FF
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgC1Pej (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgC1Pee (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:34 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4D52074F
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409673;
        bh=6mPriu0gpOtKj59zFY2FBD+rje0XT523KPDFTm2vWOw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fS8ndF5pKKxXC9ZMVIqBlrNb2BHZloV3/o9BQTiBUhM6/gIjErPrCJ6IDddGc2tSa
         g100RZ2oBNMNPdP/PhrgbnJodv/MBf7c8q+EYYo9rcDfwKm2f3b/W7z9kFPYkePIn6
         pfXvBhxFNUXWAOPg12sOr31mXzHNM7Oy7z5wqMKk=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/22] pNFS/flexfiles: Simplify allocation of the mirror array
Date:   Sat, 28 Mar 2020 11:31:59 -0400
Message-Id: <20200328153220.1352010-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-1-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Just allocate the array at the end of the layout segment structure,
instead of allocating it as a separate array of pointers.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 21 +++++----------------
 fs/nfs/flexfilelayout/flexfilelayout.h |  2 +-
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index e7d8ae4d0cc5..19728206e9c6 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -248,18 +248,10 @@ static void ff_layout_put_mirror(struct nfs4_ff_layout_mirror *mirror)
 
 static void ff_layout_free_mirror_array(struct nfs4_ff_layout_segment *fls)
 {
-	int i;
+	u32 i;
 
-	if (fls->mirror_array) {
-		for (i = 0; i < fls->mirror_array_cnt; i++) {
-			/* normally mirror_ds is freed in
-			 * .free_deviceid_node but we still do it here
-			 * for .alloc_lseg error path */
-			ff_layout_put_mirror(fls->mirror_array[i]);
-		}
-		kfree(fls->mirror_array);
-		fls->mirror_array = NULL;
-	}
+	for (i = 0; i < fls->mirror_array_cnt; i++)
+		ff_layout_put_mirror(fls->mirror_array[i]);
 }
 
 static int ff_layout_check_layout(struct nfs4_layoutget_res *lgr)
@@ -400,16 +392,13 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		goto out_err_free;
 
 	rc = -ENOMEM;
-	fls = kzalloc(sizeof(*fls), gfp_flags);
+	fls = kzalloc(struct_size(fls, mirror_array, mirror_array_cnt),
+			gfp_flags);
 	if (!fls)
 		goto out_err_free;
 
 	fls->mirror_array_cnt = mirror_array_cnt;
 	fls->stripe_unit = stripe_unit;
-	fls->mirror_array = kcalloc(fls->mirror_array_cnt,
-				    sizeof(fls->mirror_array[0]), gfp_flags);
-	if (fls->mirror_array == NULL)
-		goto out_err_free;
 
 	for (i = 0; i < fls->mirror_array_cnt; i++) {
 		struct nfs4_ff_layout_mirror *mirror;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 2f369966abf7..354a031c69b1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -99,7 +99,7 @@ struct nfs4_ff_layout_segment {
 	u64				stripe_unit;
 	u32				flags;
 	u32				mirror_array_cnt;
-	struct nfs4_ff_layout_mirror	**mirror_array;
+	struct nfs4_ff_layout_mirror	*mirror_array[];
 };
 
 struct nfs4_flexfile_layout {
-- 
2.25.1

