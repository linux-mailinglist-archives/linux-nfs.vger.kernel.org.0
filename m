Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA7489F71
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 19:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiAJSoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 13:44:39 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:34132 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiAJSoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 13:44:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F072E62DA609;
        Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n48sH9chEAtN; Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 952CC60CEF32;
        Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KQ1hl9k3Y_wg; Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 21A3262DA609;
        Mon, 10 Jan 2022 19:44:37 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        daire@dneg.com, david.oberhollenzer@sigma-star.at,
        david@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 3/3] NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
Date:   Mon, 10 Jan 2022 19:44:19 +0100
Message-Id: <20220110184419.27665-4-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220110184419.27665-1-richard@nod.at>
References: <20220110184419.27665-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now with NFSD being able to cross into auto mounts,
the check can be removed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/nfs/export.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 8c8028959863..6d56a52c424a 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -54,11 +54,6 @@ nfs_encode_fh(struct inode *inode, __u32 *p, int *max_=
len, struct inode *parent)
 	dprintk("%s: max fh len %d inode %p parent %p",
 		__func__, *max_len, inode, parent);
=20
-	if (IS_AUTOMOUNT(inode)) {
-		dprintk("%s: refusing to create fh for automount inode %p\n",
-			__func__, inode);
-		return FILEID_INVALID;
-	}
 	if (*max_len < len) {
 		dprintk("%s: fh len %d too small, required %d\n",
 			__func__, *max_len, len);
--=20
2.26.2

