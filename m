Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F58BA918
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Sep 2019 21:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbfIVTLS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Sep 2019 15:11:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47045 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395557AbfIVTLR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Sep 2019 15:11:17 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so15058659ioo.13
        for <linux-nfs@vger.kernel.org>; Sun, 22 Sep 2019 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Q1SgdW5s5KuOYg+4fiBiHwx6EAMcxUzOS/apTRs0hc=;
        b=mpDGs4X6+dJV92q8Krw4IW78IJ39l4Rii3XOe/86ryjOkkeMOdCvzy9eMp7zziOx3d
         O4aXCZWj3zLsRLbFVl/NaP8GgNSFn25k+7wC4rf2JsmvvHEbkg4z/GKra2StQbomAnwR
         XyWKsiA9p/XeJI1ihhpcJ4Ao6dLZ+JUUT7JevffZLKBKTCTxZF7Eh1N79JI/j7ErZpSY
         fuaIsjDjJBozNHO5kgC8befHazYXo03j1j4Sr699noKon0+Gc6EMeH2t66Y71K/kB/bt
         a1ZPnUpo1BSgJNxxmjzUlP0D+x1NpGovMEG4duBNhy4TL1D6DCy7285EGMP+qEsKx1BX
         LQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Q1SgdW5s5KuOYg+4fiBiHwx6EAMcxUzOS/apTRs0hc=;
        b=cX7nbRiRtz6+k7xfGslmEi/JoqL+6pmkyVUCKvgswbSCEpyp32hhOUQp6tD0YXbtCq
         ZvR5RZwI8MmoN8SOerLFs1B28LzF3Z8YMc+lAoloWP4OpGU6ogxJWbeFSzQjpZhgAaX0
         2MkZdTW3wJoMuIQ34XfOMGBRxiMO6ThZMfq7ebolIsbnCf6rdGDMy0hOGqxbIeR3weNw
         PzyMTSbAGZd/4oue/z3rX14z0xNBvN82+zmhd1GD3DhY7sY9y1Oxk0f1u4X4gK5gEXs+
         erhyjmZKeIb7+J8oZem06Oq7jaYkBiWmrWbVrsUjaR/Bm+21D4pFuVnecqNz9T282mp0
         t4qw==
X-Gm-Message-State: APjAAAVxLOhH0egJT265xVrCjb0NhwGKnjC86Iodwhfib/dvaGpOCFkG
        HrvYXLwi6ZqAeDvqbYfGpQ==
X-Google-Smtp-Source: APXvYqxz/AvBgKNTKsTwmC4Tn6KuXefkb3vIS3authZ7we6bt9lf7QZ7C0Kz1OuiF5qNokm/VMOzIA==
X-Received: by 2002:a6b:9308:: with SMTP id v8mr13862356iod.221.1569179476519;
        Sun, 22 Sep 2019 12:11:16 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d21sm5666097iom.29.2019.09.22.12.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 12:11:15 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Alkis Georgopoulos <alkisg@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Optimise the default readahead size
Date:   Sun, 22 Sep 2019 15:07:49 -0400
Message-Id: <20190922190749.54156-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In the years since the max readahead size was fixed in NFS, a number of
things have happened:
- Users can now set the value directly using /sys/class/bdi
- NFS max supported block sizes have increased by several orders of
  magnitude from 64K to 1MB.
- Disk access latencies are orders of magnitude faster due to SSD + NVME.

In particular note that if the server is advertising 1MB as the optimal
read size, as that will set the readahead size to 15MB.
Let's therefore adjust down, and try to default to VM_READAHEAD_PAGES.
However let's inform the VM about our preferred block size so that it
can choose to round up in cases where that makes sense.

Reported-by: Alkis Georgopoulos <alkisg@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/internal.h | 8 --------
 fs/nfs/super.c    | 9 ++++++++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e64f810223be..447a3c17fa8e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -16,14 +16,6 @@ extern const struct export_operations nfs_export_ops;
 
 struct nfs_string;
 
-/* Maximum number of readahead requests
- * FIXME: this should really be a sysctl so that users may tune it to suit
- *        their needs. People that do NFS over a slow network, might for
- *        instance want to reduce it to something closer to 1 for improved
- *        interactive response.
- */
-#define NFS_MAX_READAHEAD	(RPC_DEF_SLOT_TABLE - 1)
-
 static inline void nfs_attr_check_mountpoint(struct super_block *parent, struct nfs_fattr *fattr)
 {
 	if (!nfs_fsid_equal(&NFS_SB(parent)->fsid, &fattr->fsid))
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 703f595dce90..c96194e28692 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2627,6 +2627,13 @@ int nfs_clone_sb_security(struct super_block *s, struct dentry *mntroot,
 }
 EXPORT_SYMBOL_GPL(nfs_clone_sb_security);
 
+static void nfs_set_readahead(struct backing_dev_info *bdi,
+			      unsigned long iomax_pages)
+{
+	bdi->ra_pages = VM_READAHEAD_PAGES;
+	bdi->io_pages = iomax_pages;
+}
+
 struct dentry *nfs_fs_mount_common(struct nfs_server *server,
 				   int flags, const char *dev_name,
 				   struct nfs_mount_info *mount_info,
@@ -2669,7 +2676,7 @@ struct dentry *nfs_fs_mount_common(struct nfs_server *server,
 			mntroot = ERR_PTR(error);
 			goto error_splat_super;
 		}
-		s->s_bdi->ra_pages = server->rpages * NFS_MAX_READAHEAD;
+		nfs_set_readahead(s->s_bdi, server->rpages);
 		server->super = s;
 	}
 
-- 
2.21.0

