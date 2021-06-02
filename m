Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA49239895B
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 14:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFBMZC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 08:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhFBMZB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 08:25:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE9C06174A;
        Wed,  2 Jun 2021 05:23:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id jz2-20020a17090b14c2b0290162cf0b5a35so3337385pjb.5;
        Wed, 02 Jun 2021 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61g9R/SKW/xm7il3qPI05FSd7d+7M0NWtrU6rmPq764=;
        b=UeCgZ/dl3En00cmYUN2qlBuOEnsvZEShLbNlMBFh47nfAboFuPVMr6cFMFio+eunyq
         4gEVrG5igNLqlAIIkrrHnapGVzTam71B4EP6EVGAFwdJ800Q3rGMfQYXWiRYO1CfqKdh
         Rcfg3vgXfZLTHveyW2KSJK0Nv38UVAVxwjXnWnm2M7Vt7gso0kKpBKjUjjjv1LXxX8jx
         IYjMuhvhyJetFTwLAIMqpG0a/Y834RA3+7qQJLcTJlH5+mmVyv334QuBsh2roBGyvriO
         dgN3Rbww7eVGbbKKgXrcgsbYtCSBiL1CMhZSG1twDLF51NYUCVe2IEJFx6AZxMwmY3lc
         fIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61g9R/SKW/xm7il3qPI05FSd7d+7M0NWtrU6rmPq764=;
        b=qW8Y2hTdWNApQUK27qp91wYuE9c+Am/2V4Ow/soBLWTsaL08li+OTFJajYvzHRzRQl
         rgym3khHBRo/m42uYD+SdUk2eqTm8Yug97tIIqAaq1Mbo+tsfUdMmBBpjtV13RtZERnK
         4kGtfhxU3CS2hVLXQeICDoEE22rEjLEJf2hpz+vt5QHBWSb4g1d/yiBrn1bfbcyTAbsK
         4irMLC/xOUGxSVluevB0GxG0XAzvPi+6GWarTmTdMS4NiJfIG4BEaNczuuhMdpKiFVyU
         vj8CPoRDqJD4ouvMPNb9EL0FBRshf77dw7LxVwM6Bu19OPJSQALcJK2zS3T6d4mGNPZn
         /oTA==
X-Gm-Message-State: AOAM531Ckxt1JLy6uN0R+WY2/ncgmB5J3ZTMyPP8eqmmAKf5NQ4imLTG
        epb0hqRZl0hlee9B7UUmulwIFnafP1DYYjB1qsg=
X-Google-Smtp-Source: ABdhPJwGR1WJNulFIuAVi2mNytnkij3AnwS5zf1TWhgGy6Im64WSY05Qf4ac4AXqIcMehQeBYP6oEg==
X-Received: by 2002:a17:902:a988:b029:101:86c3:df24 with SMTP id bh8-20020a170902a988b029010186c3df24mr24046315plb.64.1622636597398;
        Wed, 02 Jun 2021 05:23:17 -0700 (PDT)
Received: from localhost.localdomain ([84.17.41.94])
        by smtp.gmail.com with ESMTPSA id m13sm16736401pgq.1.2021.06.02.05.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:23:16 -0700 (PDT)
From:   Alex <zgxgoo@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        zgxgoo@gmail.com
Subject: [PATCH] =?UTF-8?q?fs/nfs:=20fix=20some=20-Wmissing-prototypes=20w?= =?UTF-8?q?arnings=20we=20get=20a=20warning=20when=20building=20kernel=20w?= =?UTF-8?q?ith=20W=3D1:=20=20=20fs/nfs/nfs4file.c:318:1:=20warning:=20no?= =?UTF-8?q?=20previous=20prototype=20for=20=E2=80=98nfs42=5Fssc=5Fopen?= =?UTF-8?q?=E2=80=99=20[-Wmissing-prototypes]=20=20=20fs/nfs/nfs4file.c:40?= =?UTF-8?q?2:6:=20warning:=20no=20previous=20prototype=20for=20=E2=80=98nf?= =?UTF-8?q?s42=5Fssc=5Fclose=E2=80=99=20[-Wmissing-prototypes]?=
Date:   Wed,  2 Jun 2021 05:21:37 -0700
Message-Id: <20210602122137.1161772-1-zgxgoo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add the missing declaration in head file fs/nfs/nfs4_fs.h to fix this.

Signed-off-by: Alex <zgxgoo@gmail.com>
---
 fs/nfs/nfs4_fs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 0c9505dc852c..0cb79afa0a63 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -656,4 +656,10 @@ static inline void nfs4_xattr_cache_zap(struct inode *inode)
 
 
 #endif /* CONFIG_NFS_V4 */
+
+/* nfs4file.c */
+#ifdef CONFIG_NFS_V4_2
+struct file *nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh, nfs4_stateid *stateid);
+void nfs42_ssc_close(struct file *filep);
+#endif
 #endif /* __LINUX_FS_NFS_NFS4_FS.H */
-- 
2.25.1

