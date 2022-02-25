Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68BA4C4DCF
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiBYSfS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiBYSfM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6B1A8CB7
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5A63B8330B
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F83C340F2
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814076;
        bh=Y1ipazY3pl3WZgPz62B3OLONuRP4E1z7/Fuod/m3bP0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=szgFg42qXBc2xL3pV9VWINxGdEzqIZ6G/PFuHwJ/M4JG5xIV9HIFEheFJAN1PXhFa
         q93JsDCLedKvORP5MvRwGx33vxDYbc2uN8BnzDmqBwUREq64aOaJ80Fm/bSDaByuJa
         ORWyABMSb/8I4SQPs+F6goldj9LQTBy7qnkSb8zbSlAVTN51x6z7LnV3xtQCWrMDgT
         eMGZUGOg+qLct4tI2GTVixzP6jdBvsfCX1slio2yYAKhBpUxDbmkldGVXBL7sndu1z
         FjA+PxRa36FEnlVsS705zTu0sGheFosGhNhFRvkhYlpE22ZUpobHaO3Bg0AQolHSXc
         VsQeV3guxwdBA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 02/24] NFS: constify nfs_server_capable() and nfs_have_writebacks()
Date:   Fri, 25 Feb 2022 13:28:07 -0500
Message-Id: <20220225182829.1236093-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-2-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/nfs_fs.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 72a732a5103c..6e10725887d1 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -363,7 +363,7 @@ static inline void nfs_mark_for_revalidate(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
-static inline int nfs_server_capable(struct inode *inode, int cap)
+static inline int nfs_server_capable(const struct inode *inode, int cap)
 {
 	return NFS_SERVER(inode)->caps & cap;
 }
@@ -587,12 +587,11 @@ extern struct nfs_commit_data *nfs_commitdata_alloc(bool never_fail);
 extern void nfs_commit_free(struct nfs_commit_data *data);
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
-static inline int
-nfs_have_writebacks(struct inode *inode)
+static inline bool nfs_have_writebacks(const struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		return atomic_long_read(&NFS_I(inode)->nrequests) != 0;
-	return 0;
+	return false;
 }
 
 /*
-- 
2.35.1

