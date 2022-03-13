Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2694D772B
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiCMRNO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiCMRNM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A0139CDD
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 120136122A
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D2CC340F4
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191524;
        bh=Y1ipazY3pl3WZgPz62B3OLONuRP4E1z7/Fuod/m3bP0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=peoOXRne408WXzODUcGL3YLVWWkS6IlDY4PdWBg7ZsdgRuWtAHQMrYSoXsr+IsVuj
         3OPzvJH7aLngK0g83Il7mIOD1IViaKatolh0+CzKXsA+VGscW0c6ZB1Y9rEE8RficK
         HsgiMiNHaLXOQQKTuhUMAhNaCI2tQspAPOspFXFdw3f6roZz+kx4Rb6J8RM393Gwfw
         95aMhdbUsmxF2dyxjufhFINduLAjbG0c53gAjmQKIzhMq6y0LcAB/LEEs+HtTn5SNh
         DSiz2IpfJ8IYNhTa9aw6bT4TJLTehMjeCf+mNGw+uQFfHoq6H8Gn14DEo7WjGxAicT
         GfRdjqSXyw7GA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 02/26] NFS: constify nfs_server_capable() and nfs_have_writebacks()
Date:   Sun, 13 Mar 2022 13:05:33 -0400
Message-Id: <20220313170557.5940-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-2-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

