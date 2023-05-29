Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522A714B89
	for <lists+linux-nfs@lfdr.de>; Mon, 29 May 2023 16:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjE2OGd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 May 2023 10:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjE2OGb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 May 2023 10:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D2EA
        for <linux-nfs@vger.kernel.org>; Mon, 29 May 2023 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685369132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z+rrwHN03QPS6TAetT3cVJlQgmklbmOfMVH/q5lnNv0=;
        b=OU4M2h9LIvLCAyHdbqzQO1JdPyHx4TTN9ziLqoSY+Hgx6YHYmPdN40oYv/KRFYryAxj2wc
        km2D4wbW/V+nljp/voXHEEwfPBXDqaIUiTeBJV6JJjC1P71bSesn4dVnqpCNMYPUQR9YVl
        4duz7rUQ9Gzc5aeiYNtc1VKUHNllr7g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-tbWKZ1xmO92H88NZPlLmtg-1; Mon, 29 May 2023 10:05:31 -0400
X-MC-Unique: tbWKZ1xmO92H88NZPlLmtg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-513f4c301e8so3469834a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 29 May 2023 07:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685369130; x=1687961130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+rrwHN03QPS6TAetT3cVJlQgmklbmOfMVH/q5lnNv0=;
        b=apyniE4/DYz/1BRcyR8yHvpUvKfLiy7H6HFpTk6Kbr/A9Iady3XOlGmyGO8UbXGQgy
         MxSjClx/d3/bPlr+UzJOsJYrAGLdWkj0v/4XG/wJDjEkxJA4fxY/eutzLyjtTIVi0bYQ
         drtp1rCQdv48y1GyQf+e9lob8BtYbDno8hXzHu63isEfnW9XmCEFMxTRGFs/oySIzfgV
         p8QnCwveCkRfAWotSgkXmoUzfzAUuYFXzz1wR4LMqB9fwenTyKl9872oneeqXQCwLZRQ
         8zkA2g1+gOuB7bNxHTRNY1CBKOcMZFBL2P5/QQnuw9qtizlhLGL46P9E76hoW7w7iC71
         KiUQ==
X-Gm-Message-State: AC+VfDyK6h9L+I9s1I+K6O3kWl5Wsje/fvBh7zJaFocxi2YtGa1NvWi1
        0Jexgxmiu/Qf8eZx+pO/E744EXgKDbv9JcStVHR997QixNoCsxhmcA3anXf6ppYvewciFWm/9MD
        l+Y6N+BDMnLMNsJ6+3WAZDKMSoHc+Tko=
X-Received: by 2002:a05:6402:128a:b0:514:a5f7:a6d1 with SMTP id w10-20020a056402128a00b00514a5f7a6d1mr1023558edv.1.1685369130245;
        Mon, 29 May 2023 07:05:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BVTv/vNlk+GNBLP9/KnNH3y8jD+JkOXokGh6P5yxpManP78VN1nCJFoTE1H/HG92XEd2H6w==
X-Received: by 2002:a05:6402:128a:b0:514:a5f7:a6d1 with SMTP id w10-20020a056402128a00b00514a5f7a6d1mr1023540edv.1.1685369129968;
        Mon, 29 May 2023 07:05:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id y24-20020aa7d518000000b005149e90115bsm1082330edq.83.2023.05.29.07.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 07:05:29 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH] selinux: make labeled NFS work when mounted before policy load
Date:   Mon, 29 May 2023 16:05:27 +0200
Message-Id: <20230529140527.901242-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, when an NFS filesystem that supports passing LSM/SELinux
labels is mounted during early boot (before the SELinux policy is
loaded), it ends up mounted without the labeling support (i.e. with
Fedora policy all files get the generic NFS label
system_u:object_r:nfs_t:s0).

This is because the information that the NFS mount supports passing
labels (communicated to the LSM layer via the kern_flags argument of
security_set_mnt_opts()) gets lost and when the policy is loaded the
mount is initialized as if the passing is not supported.

Fix this by noting the "native labeling" in newsbsec->flags (using a new
SE_SBNATIVE flag) on the pre-policy-loaded call of
selinux_set_mnt_opts() and then making sure it is respected on the
second call from delayed_superblock_init().

Additionally, make inode_doinit_with_dentry() initialize the inode's
label from its extended attributes whenever it doesn't find it already
intitialized by the filesystem. This is needed to properly initialize
pre-existing inodes when delayed_superblock_init() is called. It should
not trigger in any other cases (and if it does, it's still better to
initialize the correct label instead of leaving the inode unlabeled).

Fixes: eb9ae686507bc5 ("SELinux: Add new labeling type native labels")
Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c            | 58 ++++++++++++++++++++---------
 security/selinux/include/security.h |  1 +
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 99ded60a6b911..d600616a9e6d1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -605,6 +605,13 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	u32 defcontext_sid = 0;
 	int rc = 0;
 
+	/*
+	 * Specifying internal flags without providing a place to
+	 * place the results is not allowed
+	 */
+	if (kern_flags && !set_kern_flags)
+		return -EINVAL;
+
 	mutex_lock(&sbsec->lock);
 
 	if (!selinux_initialized()) {
@@ -612,6 +619,10 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
 			   server is ready to handle calls. */
+			if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
+				sbsec->flags |= SE_SBNATIVE;
+				*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
+			}
 			goto out;
 		}
 		rc = -EINVAL;
@@ -619,12 +630,6 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			"before the security server is initialized\n");
 		goto out;
 	}
-	if (kern_flags && !set_kern_flags) {
-		/* Specifying internal flags without providing a place to
-		 * place the results is not allowed */
-		rc = -EINVAL;
-		goto out;
-	}
 
 	/*
 	 * Binary mount data FS will come through this function twice.  Once
@@ -757,7 +762,17 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * sets the label used on all file below the mountpoint, and will set
 	 * the superblock context if not already set.
 	 */
-	if (kern_flags & SECURITY_LSM_NATIVE_LABELS && !context_sid) {
+	if (sbsec->flags & SE_SBNATIVE) {
+		/*
+		 * This means we are initializing a superblock that has been
+		 * mounted before the SELinux was initialized and the
+		 * filesystem requested native labeling. We had already
+		 * returned SECURITY_LSM_NATIVE_LABELS in *set_kern_flags
+		 * in the original mount attempt, so now we just need to set
+		 * the SECURITY_FS_USE_NATIVE behavior.
+		 */
+		sbsec->behavior = SECURITY_FS_USE_NATIVE;
+	} else if (kern_flags & SECURITY_LSM_NATIVE_LABELS && !context_sid) {
 		sbsec->behavior = SECURITY_FS_USE_NATIVE;
 		*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 	}
@@ -868,13 +883,6 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
 	int set_rootcontext =	(oldsbsec->flags & ROOTCONTEXT_MNT);
 
-	/*
-	 * if the parent was able to be mounted it clearly had no special lsm
-	 * mount options.  thus we can safely deal with this superblock later
-	 */
-	if (!selinux_initialized())
-		return 0;
-
 	/*
 	 * Specifying internal flags without providing a place to
 	 * place the results is not allowed.
@@ -882,18 +890,31 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	if (kern_flags && !set_kern_flags)
 		return -EINVAL;
 
+	mutex_lock(&newsbsec->lock);
+
+	/*
+	 * if the parent was able to be mounted it clearly had no special lsm
+	 * mount options.  thus we can safely deal with this superblock later
+	 */
+	if (!selinux_initialized()) {
+		if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
+			newsbsec->flags |= SE_SBNATIVE;
+			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
+		}
+		goto out;
+	}
+
 	/* how can we clone if the old one wasn't set up?? */
 	BUG_ON(!(oldsbsec->flags & SE_SBINITIALIZED));
 
 	/* if fs is reusing a sb, make sure that the contexts match */
 	if (newsbsec->flags & SE_SBINITIALIZED) {
+		mutex_unlock(&newsbsec->lock);
 		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context)
 			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 		return selinux_cmp_sb_context(oldsb, newsb);
 	}
 
-	mutex_lock(&newsbsec->lock);
-
 	newsbsec->flags = oldsbsec->flags;
 
 	newsbsec->sid = oldsbsec->sid;
@@ -1394,8 +1415,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	spin_unlock(&isec->lock);
 
 	switch (sbsec->behavior) {
+	/*
+	 * In case of SECURITY_FS_USE_NATIVE we need to re-fetch the labels
+	 * via xattr when called from delayed_superblock_init().
+	 */
 	case SECURITY_FS_USE_NATIVE:
-		break;
 	case SECURITY_FS_USE_XATTR:
 		if (!(inode->i_opflags & IOP_XATTR)) {
 			sid = sbsec->def_sid;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 8746fafeb7789..0b9c2c25413ba 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -65,6 +65,7 @@
 #define SE_SBPROC		0x0200
 #define SE_SBGENFS		0x0400
 #define SE_SBGENFS_XATTR	0x0800
+#define SE_SBNATIVE		0x1000
 
 #define CONTEXT_STR	"context"
 #define FSCONTEXT_STR	"fscontext"
-- 
2.40.1

