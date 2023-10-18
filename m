Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC957CD8BB
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjJRKAT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRKAS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 06:00:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA573FA;
        Wed, 18 Oct 2023 03:00:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c4fe37f166so80706581fa.1;
        Wed, 18 Oct 2023 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697623214; x=1698228014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9l5t0OpbtbVMsdsvL20hfPgYiDYZf4mDCwLUlENNJ70=;
        b=XioeH3B+XJDORhKMlvzI7A4cMvrt4DVNnidaOetwy1EhWYGwn/q33Mpm46yUIrtHxH
         iDSMPr0SIEPqqMXprvamedomsmeCOB5phoe5q8je29b4YaRAZMqME/Iruje3AD1cDhx5
         KHD9rKIajmwXt4WxyO232QYQhENZbkMCxV9wI3j73H8Ap401spjYWsIUKwpfhhAMyTyC
         0XFSLXQMSDpmmC8UjUj10j3ttfFW83wdmCPIM7ACham6gF5nEdscUpz+FNuNiBC3pURP
         OL/ap6yJJEQLx4WMeKA8cGakX84fx3W8NLu+Dz1SFFr+RHC0GJG/bG2rX3gPkdjdtK4z
         DTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623214; x=1698228014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9l5t0OpbtbVMsdsvL20hfPgYiDYZf4mDCwLUlENNJ70=;
        b=crVBTgws95WPzE7K/O5L+K9KSWomWzp5xytJXwSZb4s8WIrMTfem8ROvDJjh974D6f
         JhnW/SImz20UVnoHfkj4sVPJ/4Es7F4WViaNYh6VM2vcoGqeTf4TeQL9KIsfCHLgW+he
         43PYZCOnWMePwNxO3p9argFkwwV3T/LLY3dgOpSK2GcuuPzRYFryrXxNy5qI5Fqw1DEU
         D6NWhnw2fYo5/7ZBdl9F2lRuve3ys4/K9zrRUNs9r3FDkW8yWDvenKlRsK51HCGX0GTB
         CVQUYc9kIoMQaBTem2iuiZS3KPsx/ElaV8iICEp4Se0WKs3B/u1MK9b9OrGeHsfkXLmS
         kbjg==
X-Gm-Message-State: AOJu0YzJvrtTd+tB36RrDIeL0y7luZpOco3fziMx1rNAfbLIi1L4SYOK
        hMZzl1NdnE17AZJ1CZ8/DbOcV8BKDH0=
X-Google-Smtp-Source: AGHT+IFyfA82o+JXQwx40P1ZbvHycg61RAP4gsafsuMAfIN60tD6EMZeYbQOxfX7iiMQ33z1H+P+FQ==
X-Received: by 2002:a2e:9bd3:0:b0:2bf:e9e8:de23 with SMTP id w19-20020a2e9bd3000000b002bfe9e8de23mr3239029ljj.16.1697623213998;
        Wed, 18 Oct 2023 03:00:13 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id y34-20020a05600c342200b004063977eccesm1222017wmp.42.2023.10.18.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:00:13 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] exportfs: support encoding non-decodeable file handles by default
Date:   Wed, 18 Oct 2023 13:00:00 +0300
Message-Id: <20231018100000.2453965-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018100000.2453965-1-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
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

AT_HANDLE_FID was added as an API for name_to_handle_at() that request
the encoding of a file id, which is not intended to be decoded.

This file id is used by fanotify to describe objects in events.

So far, overlayfs is the only filesystem that supports encoding
non-decodeable file ids, by providing export_operations with an
->encode_fh() method and without a ->decode_fh() method.

Add support for encoding non-decodeable file ids to all the filesystems
that do not provide export_operations, by encoding a file id of type
FILEID_INO64_GEN from { i_ino, i_generation }.

A filesystem may that does not support NFS export, can opt-out of
encoding non-decodeable file ids for fanotify by defining an empty
export_operations struct (i.e. with a NULL ->encode_fh() method).

This allows the use of fanotify events with file ids on filesystems
like 9p which do not support NFS export to bring fanotify in feature
parity with inotify on those filesystems.

Note that fanotify also requires that the filesystems report a non-null
fsid.  Currently, many simple filesystems that have support for inotify
(e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
used with fanotify in file id reporting mode.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c      | 30 +++++++++++++++++++++++++++---
 include/linux/exportfs.h | 10 +++++++---
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 30da4539e257..34e7d835d4ef 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -383,6 +383,30 @@ int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
 }
 EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
 
+/**
+ * exportfs_encode_ino64_fid - encode non-decodeable 64bit ino file id
+ * @inode:   the object to encode
+ * @fid:     where to store the file handle fragment
+ * @max_len: maximum length to store there
+ *
+ * This generic function is used to encode a non-decodeable file id for
+ * fanotify for filesystems that do not support NFS export.
+ */
+static int exportfs_encode_ino64_fid(struct inode *inode, struct fid *fid,
+				     int *max_len)
+{
+	if (*max_len < 3) {
+		*max_len = 3;
+		return FILEID_INVALID;
+	}
+
+	fid->i64.ino = inode->i_ino;
+	fid->i64.gen = inode->i_generation;
+	*max_len = 3;
+
+	return FILEID_INO64_GEN;
+}
+
 /**
  * exportfs_encode_inode_fh - encode a file handle from inode
  * @inode:   the object to encode
@@ -401,10 +425,10 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 	if (!exportfs_can_encode_fh(nop, flags))
 		return -EOPNOTSUPP;
 
-	if (nop && nop->encode_fh)
-		return nop->encode_fh(inode, fid->raw, max_len, parent);
+	if (!nop && (flags & EXPORT_FH_FID))
+		return exportfs_encode_ino64_fid(inode, fid, max_len);
 
-	return -EOPNOTSUPP;
+	return nop->encode_fh(inode, fid->raw, max_len, parent);
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 21eeb9f6bdbd..6688e457da64 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -134,7 +134,11 @@ struct fid {
 			u32 parent_ino;
 			u32 parent_gen;
 		} i32;
- 		struct {
+		struct {
+			u64 ino;
+			u32 gen;
+		} __packed i64;
+		struct {
  			u32 block;
  			u16 partref;
  			u16 parent_partref;
@@ -246,7 +250,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 
 static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
 {
-	return nop && nop->encode_fh;
+	return !nop || nop->encode_fh;
 }
 
 static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
@@ -259,7 +263,7 @@ static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 {
 	/*
 	 * If a non-decodeable file handle was requested, we only need to make
-	 * sure that filesystem can encode file handles.
+	 * sure that filesystem did not opt-out of encoding fid.
 	 */
 	if (fh_flags & EXPORT_FH_FID)
 		return exportfs_can_encode_fid(nop);
-- 
2.34.1

