Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3889B55C
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2019 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbfHWRUz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Aug 2019 13:20:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45770 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388955AbfHWRUz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Aug 2019 13:20:55 -0400
Received: by mail-io1-f67.google.com with SMTP id t3so21688408ioj.12
        for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2019 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVbGHESd/LndfRPw8UCON/TcQVEaqeUBCXj68yokbaQ=;
        b=siQRTzOi3Kh+usJC2P51q7LHDYAPrlGD2v+YE+nAOffVKoRsv4rQfULFwuXDJ2NmVI
         yoTQswIpB+GYfrTT9dSMbTEz5oaowcCd7swkobmlgMXzYvEyF/imbwl7HzMC/7tGml2O
         CAAUKcYxx25Wo2EwIc2Zn8HK8aSFi+BJWgkGk7Tz0btxe5UpRseHcnnxQSjDERxnX+Lc
         DKHVIEA1mmzPfmKHZ3qbetdRNERcZLZxHAw3Bc5oa7NMDYnAN95rEIAyA9ILnKuqWaac
         +ql/6xOd/BbGBVMnqXXAMb6hpynNiIKt5PTRxffMQataZJ/fG3jIeNuTfGPaAnqMPGZy
         AKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVbGHESd/LndfRPw8UCON/TcQVEaqeUBCXj68yokbaQ=;
        b=i6W2KocijZgSA/rYKO15GIQvZXRmVe5t+kyv7sR26P2JBHE+TiltJnXqHlrNV9tsLG
         AC9mIdG+0A9M3DN0++N6HYrArVb92TKaLrojJRT3NaVLZNR41iMWQsmLada64Hf98vEU
         7i3D4ps8eIWNun3G4iTAhMNcE6Mdno4TphrJqBfNmdDYny3AQZy8Igo6aYlMbDgPFzXu
         aLsWc04ct67L71iFTX1r5hDQ/ffcZMDQK3/WPkrEdSZMRHbmP7tmQiRHVCxyv6IzuuFQ
         2u1vkRKkFz3/W5mrf00pwfOiOQNFQHp3uV5mMPmnXApV3M5/XGceIywIIPENCUz480Rb
         1uiQ==
X-Gm-Message-State: APjAAAWgeS9Lbrj92jGo55dNgJ/WX3BJQ7qwkiXnPIyzYozQk9ql7mhr
        Czm07lpFHv8Ir+N8nA2QEQcma6iRVw==
X-Google-Smtp-Source: APXvYqwBM0l2k1V5O2Lm5rm1AlFKXN6uL7d6WGuT6abAtzHjp6VupLJgL9h27U5lAK8FGrrRVKWY+w==
X-Received: by 2002:a5d:87c2:: with SMTP id q2mr3901340ios.268.1566580854126;
        Fri, 23 Aug 2019 10:20:54 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v12sm2834401ios.16.2019.08.23.10.20.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 10:20:53 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] pNFS/flexfiles: Don't time out requests on hard mounts
Date:   Fri, 23 Aug 2019 13:18:46 -0400
Message-Id: <20190823171846.27871-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the mount is hard, we should ignore the 'io_maxretrans' module
parameter so that we always keep retrying.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 2c7e1eca1ed7..5657b7f2611f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/nfs_fs.h>
+#include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
 #include <linux/sched/mm.h>
@@ -928,7 +929,9 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	pgm = &pgio->pg_mirrors[0];
 	pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].rsize;
 
-	pgio->pg_maxretrans = io_maxretrans;
+	if (NFS_SERVER(pgio->pg_inode)->flags &
+			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
+		pgio->pg_maxretrans = io_maxretrans;
 	return;
 out_nolseg:
 	if (pgio->pg_error < 0)
@@ -940,6 +943,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 			pgio->pg_lseg);
 	pnfs_put_lseg(pgio->pg_lseg);
 	pgio->pg_lseg = NULL;
+	pgio->pg_maxretrans = 0;
 	nfs_pageio_reset_read_mds(pgio);
 }
 
@@ -1000,7 +1004,9 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 		pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].wsize;
 	}
 
-	pgio->pg_maxretrans = io_maxretrans;
+	if (NFS_SERVER(pgio->pg_inode)->flags &
+			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
+		pgio->pg_maxretrans = io_maxretrans;
 	return;
 
 out_mds:
@@ -1010,6 +1016,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			pgio->pg_lseg);
 	pnfs_put_lseg(pgio->pg_lseg);
 	pgio->pg_lseg = NULL;
+	pgio->pg_maxretrans = 0;
 	nfs_pageio_reset_write_mds(pgio);
 }
 
-- 
2.21.0

