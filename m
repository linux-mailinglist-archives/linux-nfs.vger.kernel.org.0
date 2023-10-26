Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156D7D89C7
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 22:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjJZUpu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZUpt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 16:45:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324131A5;
        Thu, 26 Oct 2023 13:45:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4079ed65471so10035325e9.1;
        Thu, 26 Oct 2023 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698353144; x=1698957944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+449a2LMBVKr6t6FQ1OLh0S7RzytdzZPG5w+nkbqKw=;
        b=S+OrD9pAzRXORgLTRgLk/EOFIe3kFTRpJNkHlOYu8LxFpg3/HIAQFG5VDpGw2aoW90
         dPUDAkI6bsOyJmHGmVPKHnFM1WMb+Mab1AxQd5oZxWv9JN4MJJx5T0tmkIaBIb94z1Zc
         z+lJen8x4HxVJWt/eXSPzBKbPOe4qnUdKtbKIXRhFTPAon9t0SSjWx8rb2nNOrkzek3N
         X43YzieQJR5Hlo2g+M+i/dx+O4FxVYoFrpGdy8sskKbx49zAbTvN+M52aRUch0XJZvMA
         FWajU5HA1GYJURddiGwSpuIdOj4VqZRh9D2cxFhUDQkD+3nof2cc9BqxCZHFHhuzH6SJ
         LpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698353144; x=1698957944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+449a2LMBVKr6t6FQ1OLh0S7RzytdzZPG5w+nkbqKw=;
        b=rBMPsqLj5AGxEeCuKpaDQUE6ooG6HEIbOBHKTMeP1VvK9H+2wlXpHukAKHiR3nH+6Z
         o2u4AvCnm/qcCz5n8dP3Pg6Q/2Sn6U8S+CRs2184ZwlovwMZudpTTIgPeVLva5K9XtLY
         5gYYk/6c9T92ShG6p2mDHzzMhlwEJS5ggDswWZeig2Cr1Moh/4lo3+zhCVXzEYlCZNVw
         tU6TVrbbq9C3Dly4rTB8j3tiMqJuBjpUQWLD7/wH2fB3I3Cg+ZobmTPN5Ljt13d8w4s7
         YePU5NSxmI0A4aENCU11MrFUYuAgnw5zRLICQtMavg/GEAVI1He2mxwzghdgFvGyJu8F
         JVLA==
X-Gm-Message-State: AOJu0Ywfx7Fx6+tfLtuqaz4q2J8GOvOHD7g06QPscmZ9hoRbFo0yFdXf
        e4vNqCnBDn+hyc0OyP5i10I=
X-Google-Smtp-Source: AGHT+IFy+KJdB0xGlQxV53fIOH7wGZbdMRjer9mS5u8S9fWbuRh56qvprHOPo/NfR4hkUKslWsI8IA==
X-Received: by 2002:a05:600c:154e:b0:405:4a78:a890 with SMTP id f14-20020a05600c154e00b004054a78a890mr754321wmg.8.1698353144271;
        Thu, 26 Oct 2023 13:45:44 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id i39-20020a05600c4b2700b00405391f485fsm3393155wmp.41.2023.10.26.13.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:45:43 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] fs: fix build error with CONFIG_EXPORTFS=m or not defined
Date:   Thu, 26 Oct 2023 23:45:40 +0300
Message-Id: <20231026204540.143217-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Many of the filesystems that call the generic exportfs helpers do not
select the EXPORTFS config.

Move generic_encode_ino32_fh() to libfs.c, same as generic_fh_to_*()
to avoid having to fix all those config dependencies.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310262151.renqMvme-lkp@intel.com/
Fixes: dfaf653dc415 ("exportfs: make ->encode_fh() a mandatory method for NFS export")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

Soaking f_fsid in linux-next started to bring goodies.
Please feel free to apply the fix as is or squash it.

Thanks,
Amir.

 fs/exportfs/expfs.c      | 41 ----------------------------------------
 fs/libfs.c               | 41 ++++++++++++++++++++++++++++++++++++++++
 include/linux/exportfs.h |  9 ++-------
 3 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 7d9fdcc187b7..3ae0154c5680 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -342,47 +342,6 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
 	return error;
 }
 
-/**
- * generic_encode_ino32_fh - generic export_operations->encode_fh function
- * @inode:   the object to encode
- * @fh:      where to store the file handle fragment
- * @max_len: maximum length to store there (in 4 byte units)
- * @parent:  parent directory inode, if wanted
- *
- * This generic encode_fh function assumes that the 32 inode number
- * is suitable for locating an inode, and that the generation number
- * can be used to check that it is still valid.  It places them in the
- * filehandle fragment where export_decode_fh expects to find them.
- */
-int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
-			    struct inode *parent)
-{
-	struct fid *fid = (void *)fh;
-	int len = *max_len;
-	int type = FILEID_INO32_GEN;
-
-	if (parent && (len < 4)) {
-		*max_len = 4;
-		return FILEID_INVALID;
-	} else if (len < 2) {
-		*max_len = 2;
-		return FILEID_INVALID;
-	}
-
-	len = 2;
-	fid->i32.ino = inode->i_ino;
-	fid->i32.gen = inode->i_generation;
-	if (parent) {
-		fid->i32.parent_ino = parent->i_ino;
-		fid->i32.parent_gen = parent->i_generation;
-		len = 4;
-		type = FILEID_INO32_GEN_PARENT;
-	}
-	*max_len = len;
-	return type;
-}
-EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
-
 #define FILEID_INO64_GEN_LEN 3
 
 /**
diff --git a/fs/libfs.c b/fs/libfs.c
index 8117b24b929d..38950cce135b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1310,6 +1310,47 @@ ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
 }
 EXPORT_SYMBOL_GPL(simple_attr_write_signed);
 
+/**
+ * generic_encode_ino32_fh - generic export_operations->encode_fh function
+ * @inode:   the object to encode
+ * @fh:      where to store the file handle fragment
+ * @max_len: maximum length to store there (in 4 byte units)
+ * @parent:  parent directory inode, if wanted
+ *
+ * This generic encode_fh function assumes that the 32 inode number
+ * is suitable for locating an inode, and that the generation number
+ * can be used to check that it is still valid.  It places them in the
+ * filehandle fragment where export_decode_fh expects to find them.
+ */
+int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
+			    struct inode *parent)
+{
+	struct fid *fid = (void *)fh;
+	int len = *max_len;
+	int type = FILEID_INO32_GEN;
+
+	if (parent && (len < 4)) {
+		*max_len = 4;
+		return FILEID_INVALID;
+	} else if (len < 2) {
+		*max_len = 2;
+		return FILEID_INVALID;
+	}
+
+	len = 2;
+	fid->i32.ino = inode->i_ino;
+	fid->i32.gen = inode->i_generation;
+	if (parent) {
+		fid->i32.parent_ino = parent->i_ino;
+		fid->i32.parent_gen = parent->i_generation;
+		len = 4;
+		type = FILEID_INO32_GEN_PARENT;
+	}
+	*max_len = len;
+	return type;
+}
+EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
+
 /**
  * generic_fh_to_dentry - generic helper for the fh_to_dentry export operation
  * @sb:		filesystem to do the file handle conversion on
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 21bae8bfeef1..e0e69dafaa43 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -294,17 +294,12 @@ extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 /*
  * Generic helpers for filesystems.
  */
-#ifdef CONFIG_EXPORTFS
 int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
 			    struct inode *parent);
-#else
-#define generic_encode_ino32_fh NULL
-#endif
-
-extern struct dentry *generic_fh_to_dentry(struct super_block *sb,
+struct dentry *generic_fh_to_dentry(struct super_block *sb,
 	struct fid *fid, int fh_len, int fh_type,
 	struct inode *(*get_inode) (struct super_block *sb, u64 ino, u32 gen));
-extern struct dentry *generic_fh_to_parent(struct super_block *sb,
+struct dentry *generic_fh_to_parent(struct super_block *sb,
 	struct fid *fid, int fh_len, int fh_type,
 	struct inode *(*get_inode) (struct super_block *sb, u64 ino, u32 gen));
 
-- 
2.34.1

