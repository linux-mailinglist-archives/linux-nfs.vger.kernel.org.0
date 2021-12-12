Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2505471D17
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Dec 2021 21:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhLLU5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Dec 2021 15:57:20 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:35032 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLLU5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Dec 2021 15:57:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1ED2D62DA5EF;
        Sun, 12 Dec 2021 21:57:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id josJPDSjQV7j; Sun, 12 Dec 2021 21:57:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AE79B62DA5E7;
        Sun, 12 Dec 2021 21:57:17 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7fRBSf1fE7F8; Sun, 12 Dec 2021 21:57:17 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 500FF60F6B8E;
        Sun, 12 Dec 2021 21:57:17 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com, david@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH] NFS: nfs_encode_fh: Improve debug logging
Date:   Sun, 12 Dec 2021 21:57:01 +0100
Message-Id: <20211212205701.15971-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When nfs_encode_fh() refuses to create fhandle due to
S_AUTOMOUNT, print the right log message.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/nfs/export.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 171c424cb6d5..5f6e1b715545 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -42,7 +42,12 @@ nfs_encode_fh(struct inode *inode, __u32 *p, int *max_=
len, struct inode *parent)
 	dprintk("%s: max fh len %d inode %p parent %p",
 		__func__, *max_len, inode, parent);
=20
-	if (*max_len < len || IS_AUTOMOUNT(inode)) {
+	if (IS_AUTOMOUNT(inode)) {
+		dprintk("%s: refusing to create fh for automount inode %p\n",
+			__func__, inode);
+		return FILEID_INVALID;
+	}
+	if (*max_len < len) {
 		dprintk("%s: fh len %d too small, required %d\n",
 			__func__, *max_len, len);
 		*max_len =3D len;
--=20
2.26.2

