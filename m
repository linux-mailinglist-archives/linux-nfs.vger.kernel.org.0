Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673534ADF5F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 18:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiBHRUz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 12:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359306AbiBHRUy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 12:20:54 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC67C061578
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 09:20:53 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l14so3023958qtp.7
        for <linux-nfs@vger.kernel.org>; Tue, 08 Feb 2022 09:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgrS1yZYeAwNAn9ocXquWQBwkXeVl2RWfwPW6c8S0+8=;
        b=TD/bicTa+RN3hX3ebjIyA5GZd0rVwscfDfxL1BMVlRN+hzBcSPPEyacvTDnhSiqXu4
         1wDulHpCuUfMDzCDL9soHx0rLKSCXbJBAPCvMBAZq1l3Z3hIwMSVVSAVtdbYVwUsiUlE
         TZ+rsGnkbArl7hkDZFuyt+3vDV32v+CybqhOho37NmzO+smGAlRJScZTi4fs6k5tzzXl
         2LIaJH3Kt2amlszAApDEByeTIbIToFxVwrppl/yZc70Jj4I8dtwzHCkAPmsI3HVl7pSh
         T+Ml3ilQ8afQdPksgM88vYLy5CYNrYZgVm/u0NlbkhoW6b++2IkpKOoPhovi67v6LHeG
         ruCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgrS1yZYeAwNAn9ocXquWQBwkXeVl2RWfwPW6c8S0+8=;
        b=lDbIPt1P+NoAdEXyBmfAicwi6QP3LawXl7DbGwu7FBoY9MOm15Wl1oo63dRE8yS3ur
         5yiLu9mJZhRVmhCDR6T06tVQcoD1oIgz5SKtjQY2Itmtk0Bc+bJdlnkrIIXFmOxVInU7
         UnRmuSsIB38LHIbe66CP4JKvl79cy83oxzOj7+P0p/2O2P6+PCV1BDsdPiC83+H+ibPN
         WZgwyR6sRAvRPUXj5FN/Tpx1toOGCxqxpHMSW6NURnGsmvAjyf7hvhwzB+qdVNFXRZSo
         KPUiAz2/tv9LOC7cvDFaZvr0W+XzVHbiojx4aOxb0R5RXCKQaBvbtcDdbErLrX6J2jW8
         JwNQ==
X-Gm-Message-State: AOAM530TueOlM1+QXVsYtojhD977PrGu7SGQeX2ZQCtQ6awVDFtN8JAi
        XUxymLOeqXlRR7LklrTxHvuJOQWPZg==
X-Google-Smtp-Source: ABdhPJxiDMStBaNleR1daF3+0gxONwslKwHViUWFfaHMZFsNna8j6tloMxmT2eMAYmjsgdDWu+3eKg==
X-Received: by 2002:ac8:7f4d:: with SMTP id g13mr3784391qtk.173.1644340852293;
        Tue, 08 Feb 2022 09:20:52 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id z19sm7951918qtj.77.2022.02.08.09.20.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:20:51 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Remove an incorrect revalidation in nfs4_update_changeattr_locked()
Date:   Tue,  8 Feb 2022 12:14:44 -0500
Message-Id: <20220208171444.1388246-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In nfs4_update_changeattr_locked(), we don't need to set the
NFS_INO_REVAL_PAGECACHE flag, because we already know the value of the
change attribute, and we're already flagging the size. In fact, this
forces us to revalidate the change attribute a second time for no good
reason.
This extra flag appears to have been introduced as part of the xattr
feature, when update_changeattr_locked() was converted for use by the
xattr code.

Fixes: 1b523ca972ed ("nfs: modify update_changeattr to deal with regular files")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 62b7e27d825b..0add19a814fd 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1229,8 +1229,7 @@ nfs4_update_changeattr_locked(struct inode *inode,
 				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
 				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
-				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR |
-				NFS_INO_REVAL_PAGECACHE;
+				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR;
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	}
 	nfsi->attrtimeo_timestamp = jiffies;
-- 
2.34.1

