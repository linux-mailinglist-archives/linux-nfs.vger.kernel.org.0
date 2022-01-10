Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7102489F70
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 19:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbiAJSoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 13:44:39 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:34114 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbiAJSoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 13:44:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8F44E62DA606;
        Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Y0SjC0SNuVRT; Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 261EC62DA60B;
        Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5fzf8hYKB8WV; Mon, 10 Jan 2022 19:44:37 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id AE19662DA606;
        Mon, 10 Jan 2022 19:44:36 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        daire@dneg.com, david.oberhollenzer@sigma-star.at,
        david@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 2/3] fs: namei: Allow follow_down() to uncover auto mounts
Date:   Mon, 10 Jan 2022 19:44:18 +0100
Message-Id: <20220110184419.27665-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220110184419.27665-1-richard@nod.at>
References: <20220110184419.27665-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This function is only used by NFSD to cross mount points.
If a mount point is of type auto mount, follow_down() will
not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
to have ->d_automount() called when NFSD walks down the
mount tree.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..b9de9fc4bfed 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1410,7 +1410,7 @@ int follow_down(struct path *path)
 {
 	struct vfsmount *mnt =3D path->mnt;
 	bool jumped;
-	int ret =3D traverse_mounts(path, &jumped, NULL, 0);
+	int ret =3D traverse_mounts(path, &jumped, NULL, LOOKUP_AUTOMOUNT);
=20
 	if (path->mnt !=3D mnt)
 		mntput(mnt);
--=20
2.26.2

