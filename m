Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0236C7DCF
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Mar 2023 13:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCXMQS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Mar 2023 08:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCXMQR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Mar 2023 08:16:17 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE2A6A40
        for <linux-nfs@vger.kernel.org>; Fri, 24 Mar 2023 05:16:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3EB9E6431C29;
        Fri, 24 Mar 2023 13:16:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U883YgBzBaX7; Fri, 24 Mar 2023 13:16:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E074E605DED8;
        Fri, 24 Mar 2023 13:16:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KJtiBfdg335F; Fri, 24 Mar 2023 13:16:12 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 8FA4A6431C29;
        Fri, 24 Mar 2023 13:16:12 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     steved@redhat.com
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org,
        chris.chilvers@appsbroker.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH] export: Fix rootdir corner case in next_mnt()
Date:   Fri, 24 Mar 2023 13:16:08 +0100
Message-Id: <20230324121608.16808-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the following setup causes failure:

1. /etc/exports:
/ *(rw,crossmnt,no_subtree_check,fsid=3Droot)

2. /etc/nfs.conf:
[exports]
 rootdir=3D/nfs_srv

3. Mounts:
/root/fs1.ext4 on /nfs_srv type ext4 (rw,relatime)
/root/fs2.ext4 on /nfs_srv/fs2 type ext4 (rw,relatime)

4. On the client:
$ ls /nfs_client/fs2
ls: cannot open directory '/nfs_client/fs2': Stale file handle

The problem is that next_mnt() misses the corner case that
every mount is a sub-mount of "/".
So it fails to see that /nfs_srv/fs2 is a mountpoint when the
client asks for fs2 it and as consequence the crossmnt mechanism
fails.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/cache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 2497d4f48df3..1c526277d3c6 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -410,12 +410,16 @@ static char *next_mnt(void **v, char *p)
 		*v =3D f;
 	} else
 		f =3D *v;
-	while ((me =3D getmntent(f)) !=3D NULL && l > 1) {
+	while ((me =3D getmntent(f)) !=3D NULL && l >=3D 1) {
 		char *mnt_dir =3D nfsd_path_strip_root(me->mnt_dir);
=20
 		if (!mnt_dir)
 			continue;
=20
+		/* Everything below "/" is a proper sub-mount */
+		if (strcmp(p, "/") =3D=3D 0)
+			return mnt_dir;
+
 		if (strncmp(mnt_dir, p, l) =3D=3D 0 && mnt_dir[l] =3D=3D '/')
 			return mnt_dir;
 	}
--=20
2.26.2

