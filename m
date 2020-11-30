Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4A92C907D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgK3WEH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3WEH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:04:07 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052ECC0613D6
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:27 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n132so12508404qke.1
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZSNI8VYDjpJp4/4zDkWO9TfGwHU1P+knHFkHkZXmGo=;
        b=WP6BclLFYzT3V/LWGAHNhEoksyLPlCWvWgm680VJBo8yQUZ3cCR4iH8DDxH8/9al33
         gcLmXHTFZ1/BuD5BdvsUFo8LXLQM9xwKjCgHX3//1yolCm+ab2Jy0dNYPfVGYdGklE29
         q0pFOa3J/gW6mnFhU5b1QSEMlDtRmID3mglTPKR7nySQxgsQYGOVBWV+LX5NHbD154fA
         q3MGbjP7Wh4N123MF6HWBhWlMWt9/PFpMiQ0SMgo7urfLv4Z/kV7aCWP4N9MlJoD3zOE
         Zfhh36WMS8bSsalQMdd//GDN7GKywaB0JsLAT8I2HlDvXSCIXcHnmXwOLTdl2874cadn
         +4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZSNI8VYDjpJp4/4zDkWO9TfGwHU1P+knHFkHkZXmGo=;
        b=dqOSsALybEQLwkOnCQIViHb/Xh37KHM0VbO77OOXHORzHBl6VYkOiMiE+CG8alYBnJ
         Cm/SxGEYxm/OCXuv6G4vT6wGu5//yT0KKNuuDwtksXiTxU3V9sJC6eZbuwrdJ1SFvBwl
         QzIx/cVU28RUnLwkuCl/7CO1UBwBsHqJ3aKMbol5xxny7gBAket+qYM6nnwFsml7svo+
         ++KkWzzCU6sLywut5hU39uFw78jwYA4KFhfGrjqkiIpOmV8qpYJbGAJHNZSNQ+CgfgE4
         HrfVBnfjLvf0bh/i0Bjy0FF2NT1ehlbwzqDnOXzPX+DT5yDNxbLBJPDghXr2MR2Blxm1
         wJ/Q==
X-Gm-Message-State: AOAM532odpNUMY2l3lxgf2Npk3t4Og2Su5nTby3VDf/HHtR7Qki9kN+M
        HuQLt3xdrSZ5X2q4iqmaBw==
X-Google-Smtp-Source: ABdhPJzCysQ9tnEfVrlE/8LbItrlBnEd2cidEEi6ZG7odmVJvv84JugtrMpVn59fIuWGC5yeocy51w==
X-Received: by 2002:a05:620a:113b:: with SMTP id p27mr18691209qkk.29.1606773806156;
        Mon, 30 Nov 2020 14:03:26 -0800 (PST)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id q62sm17642886qkf.86.2020.11.30.14.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:03:25 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/6] exportfs: Add a function to return the raw output from fh_to_dentry()
Date:   Mon, 30 Nov 2020 17:03:17 -0500
Message-Id: <20201130220319.501064-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130220319.501064-4-trond.myklebust@hammerspace.com>
References: <20201130220319.501064-1-trond.myklebust@hammerspace.com>
 <20201130220319.501064-2-trond.myklebust@hammerspace.com>
 <20201130220319.501064-3-trond.myklebust@hammerspace.com>
 <20201130220319.501064-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order to allow nfsd to accept return values that are not
acceptable to overlayfs and others, add a new function.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/exportfs/expfs.c      | 32 ++++++++++++++++++++++++--------
 include/linux/exportfs.h |  5 +++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 2dd55b172d57..0106eba46d5a 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -417,9 +417,11 @@ int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_fh);
 
-struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
-		int fh_len, int fileid_type,
-		int (*acceptable)(void *, struct dentry *), void *context)
+struct dentry *
+exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
+		       int fileid_type,
+		       int (*acceptable)(void *, struct dentry *),
+		       void *context)
 {
 	const struct export_operations *nop = mnt->mnt_sb->s_export_op;
 	struct dentry *result, *alias;
@@ -432,10 +434,8 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 	if (!nop || !nop->fh_to_dentry)
 		return ERR_PTR(-ESTALE);
 	result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
-	if (PTR_ERR(result) == -ENOMEM)
-		return ERR_CAST(result);
 	if (IS_ERR_OR_NULL(result))
-		return ERR_PTR(-ESTALE);
+		return result;
 
 	/*
 	 * If no acceptance criteria was specified by caller, a disconnected
@@ -561,10 +561,26 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 
  err_result:
 	dput(result);
-	if (err != -ENOMEM)
-		err = -ESTALE;
 	return ERR_PTR(err);
 }
+EXPORT_SYMBOL_GPL(exportfs_decode_fh_raw);
+
+struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
+				  int fh_len, int fileid_type,
+				  int (*acceptable)(void *, struct dentry *),
+				  void *context)
+{
+	struct dentry *ret;
+
+	ret = exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type,
+				     acceptable, context);
+	if (IS_ERR_OR_NULL(ret)) {
+		if (ret == ERR_PTR(-ENOMEM))
+			return ret;
+		return ERR_PTR(-ESTALE);
+	}
+	return ret;
+}
 EXPORT_SYMBOL_GPL(exportfs_decode_fh);
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index d829403ffd3b..846df3c96730 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -223,6 +223,11 @@ extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent);
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 	int *max_len, int connectable);
+extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
+					     struct fid *fid, int fh_len,
+					     int fileid_type,
+					     int (*acceptable)(void *, struct dentry *),
+					     void *context);
 extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 	int fh_len, int fileid_type, int (*acceptable)(void *, struct dentry *),
 	void *context);
-- 
2.28.0

