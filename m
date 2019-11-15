Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AAEFE63C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 21:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKOUNW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 15:13:22 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45519 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKOUNW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 15:13:22 -0500
Received: by mail-yb1-f193.google.com with SMTP id i7so4499291ybk.12
        for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2019 12:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jD/NF07l8lxYHOg36HptUa0lQuCyZX439GjlrktAx+E=;
        b=YZHDrdvFdIUHqXDOQfI/Xo4y9A1zXOYUw7B3LOa49azHRkMc4R5I3ePT5trLYo5S5X
         KeXqs0jJa41fEsGOtY4Ty16l4QD5mtRr7O2ROIJ4wpH98uftXD+eUF4KdSRmDnl4heYQ
         gShmjhRbbAiIC6YtAKDj/+B31/yk/3sKTbdielFRwck2U4AZ/AivC71Vr9dJ7dRvH1gY
         +zk7BJfQ6CMjO8z9FoMwiHhTKWb5J2fi3ZypdTRQxukk6kJ4bBpHZxrPKFeGctnXlaCG
         xNnFiY+AuZ5QI+u1cH3or5K5eIcR/x5SPC1wabsK5ANFvFbx4vWEf+SwYM5kPQbdbqqg
         yD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jD/NF07l8lxYHOg36HptUa0lQuCyZX439GjlrktAx+E=;
        b=YcZdbUHu0Qjb4dYlesCw+tCPLKGI+zOn5DvqyNPprYyB3aejAdeJK/U0y3veD1xspa
         Xaz/f6t1jz520bmRvwhFdOT7CxbOWISOM5+i5XK50jy6rsL61RvWc/lqgWZcbvzn6I4N
         LJp6r2ndyR1p0lJ/RweQKi2W15cLOdKan5/PGcb9/vEHaL2+nV91S297gxqejzQcZAgy
         kSF4rCmigFIWkPp+QfQUOddjitTWFtCfwjdKU8vtjsO9jLYabZq37FZZwwZ33x3/GvZg
         VkcoAFno8mflCpafPCrbrwGXHvdQhF0okFEUIKIOs0dmmHCQQ7fwXESRjTUpglRh2vdN
         ycoA==
X-Gm-Message-State: APjAAAVN/M45jBaENtx8UXwUM/47nsCl8HuVDl5WmkJtHf3bSJeElgAq
        1z1H/A37xGXS6xFpR8+bMpE=
X-Google-Smtp-Source: APXvYqwX7kmDghRf0Whr0poucHAvdJOp0Lt9pbiNn5+azlNpxGSeRSzt5S6AxSvWUO3umZTYFazJFQ==
X-Received: by 2002:a25:76d0:: with SMTP id r199mr12991683ybc.267.1573848800687;
        Fri, 15 Nov 2019 12:13:20 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id j66sm4050154ywb.101.2019.11.15.12.13.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 15 Nov 2019 12:13:20 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2 fix memory leak in nfs42_ssc_open
Date:   Fri, 15 Nov 2019 15:13:19 -0500
Message-Id: <20191115201319.3746-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Static analysis with Coverity detected a memory leak

Reported-by: Colin King <colin.king@canonical.com>
Fixes: ec4b09250898 ("NFS: inter ssc open")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e97813b15e23..396ed52c23a5 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -318,7 +318,7 @@ nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
 	struct inode *r_ino = NULL;
 	struct nfs_open_context *ctx;
 	struct nfs4_state_owner *sp;
-	char *read_name;
+	char *read_name = NULL;
 	int len, status = 0;
 
 	server = NFS_SERVER(ss_mnt->mnt_root->d_inode);
@@ -342,14 +342,14 @@ nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
 			NULL);
 	if (IS_ERR(r_ino)) {
 		res = ERR_CAST(r_ino);
-		goto out;
+		goto out_free_name;
 	}
 
 	filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
 				     r_ino->i_fop);
 	if (IS_ERR(filep)) {
 		res = ERR_CAST(filep);
-		goto out;
+		goto out_free_name;
 	}
 	filep->f_mode |= FMODE_READ;
 
@@ -380,6 +380,8 @@ nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
 
 	file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
 	res = filep;
+out_free_name:
+	kfree(read_name);
 out:
 	return res;
 out_stateowner:
@@ -388,7 +390,7 @@ nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
 	put_nfs_open_context(ctx);
 out_filep:
 	fput(filep);
-	goto out;
+	goto out_free_name;
 }
 EXPORT_SYMBOL_GPL(nfs42_ssc_open);
 void nfs42_ssc_close(struct file *filep)
-- 
2.18.1

