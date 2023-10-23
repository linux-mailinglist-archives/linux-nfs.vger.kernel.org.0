Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4680D7D3E96
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 20:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjJWSIV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Oct 2023 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjJWSIS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Oct 2023 14:08:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19AE6;
        Mon, 23 Oct 2023 11:08:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4079ed65582so28087645e9.1;
        Mon, 23 Oct 2023 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698084494; x=1698689294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/4592R+T7IB98a3SI4y1MkF8iw2wBK2DFGO14wuaUU=;
        b=IPkgKqQV9uUJsU1OG6vHUcsAx9lulP9MFXqHT9KzcZyLSrO4a1WVbnSH5Ae39Usteh
         24YgSGFAdjGMpm/8VE0A+9HbnSymGAQt3u53zUQdk/EO+HqzFjU/zQMVRiKJAtTmwmu1
         Knt8+iTS1miNfgklo23x+IWyoiTmCR+KgRH2737f7dv102iUW0xN/xOOhOJwN/yXfylb
         KfZ3+LGBEnfKewAidRnCPDyKwPH7oj1PCbVbiOjV8ITbiekhsoqHtz/+1t7cYYpmPxqB
         yTZicCMPuOPxH23CuAZXvL8Ar1twARaS1lsC2dwRSkb06yLu7xbVliLwsSzWRDF8mGHO
         /Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084494; x=1698689294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/4592R+T7IB98a3SI4y1MkF8iw2wBK2DFGO14wuaUU=;
        b=nkn3bJNMbvRbZ/9nkSgRt3vf27G/4BxClV1o8Zqu7QZJqcRbYMrR8YpVuDmsB8zr9E
         qqNhVN+PpZDq2xew+pu5mEGuVyOKBVdVwkJV5I0/t9jdotsYiWeE+Uj5NwxT6HcFUKz/
         OtKSUhvl5jyr5pjyVxTkAcg8tYrIuP7UyYn4RIIuxu1c9TM4X/fWzsrCkFfYxJNBeWP8
         dqODLVxrw46YKgnaIaXl0SYyZdC9oPUGlCn0WrVW8yVTx0o+RKzwQokjKQR/EUJHtakV
         7DEx0SzLonn3WVtEqZVtIXpvnD4qItkdzyFLVBGfAZ2FY/2EDpU5WDLTE+0h7GUnKvm1
         589A==
X-Gm-Message-State: AOJu0YxQHWgZFK4uIYNMpM5HOsr4SCm2ssGju23Ap8fypCkd7VrIBr2e
        m6aeHV7k/jumpiCWJ5QY6ew=
X-Google-Smtp-Source: AGHT+IF8nGdbNz2Ysuf47HIhp7e+AyUj4v7QpgqiaDVG3rDeiqMzg0HpT4n9LSq2gdgZtFr4rhnK8Q==
X-Received: by 2002:a05:600c:4715:b0:408:fba2:f4bc with SMTP id v21-20020a05600c471500b00408fba2f4bcmr3563643wmo.24.1698084494154;
        Mon, 23 Oct 2023 11:08:14 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id c39-20020a05600c4a2700b0040588d85b3asm14391492wmp.15.2023.10.23.11.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:08:13 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/4] exportfs: define FILEID_INO64_GEN* file handle types
Date:   Mon, 23 Oct 2023 21:08:00 +0300
Message-Id: <20231023180801.2953446-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023180801.2953446-1-amir73il@gmail.com>
References: <20231023180801.2953446-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Similar to the common FILEID_INO32* file handle types, define common
FILEID_INO64* file handle types.

The type values of FILEID_INO64_GEN and FILEID_INO64_GEN_PARENT are the
values returned by fuse and xfs for 64bit ino encoded file handle types.

Note that these type value are filesystem specific and they do not define
a universal file handle format, for example:
fuse encodes FILEID_INO64_GEN as [ino-hi32,ino-lo32,gen] and xfs encodes
FILEID_INO64_GEN as [hostr-order-ino64,gen] (a.k.a xfs_fid64).

The FILEID_INO64_GEN fhandle type is going to be used for file ids for
fanotify from filesystems that do not support NFS export.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/inode.c          |  7 ++++---
 include/linux/exportfs.h | 11 +++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb..e63f966698a5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1002,7 +1002,7 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	}
 
 	*max_len = len;
-	return parent ? 0x82 : 0x81;
+	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
 }
 
 static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
@@ -1010,7 +1010,8 @@ static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
 {
 	struct fuse_inode_handle handle;
 
-	if ((fh_type != 0x81 && fh_type != 0x82) || fh_len < 3)
+	if ((fh_type != FILEID_INO64_GEN &&
+	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
 		return NULL;
 
 	handle.nodeid = (u64) fid->raw[0] << 32;
@@ -1024,7 +1025,7 @@ static struct dentry *fuse_fh_to_parent(struct super_block *sb,
 {
 	struct fuse_inode_handle parent;
 
-	if (fh_type != 0x82 || fh_len < 6)
+	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
 		return NULL;
 
 	parent.nodeid = (u64) fid->raw[3] << 32;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 85bd027494e5..4119d3ee72eb 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -98,6 +98,17 @@ enum fid_type {
 	 */
 	FILEID_FAT_WITH_PARENT = 0x72,
 
+	/*
+	 * 64 bit inode number, 32 bit generation number.
+	 */
+	FILEID_INO64_GEN = 0x81,
+
+	/*
+	 * 64 bit inode number, 32 bit generation number,
+	 * 64 bit parent inode number, 32 bit parent generation.
+	 */
+	FILEID_INO64_GEN_PARENT = 0x82,
+
 	/*
 	 * 128 bit child FID (struct lu_fid)
 	 * 128 bit parent FID (struct lu_fid)
-- 
2.34.1

