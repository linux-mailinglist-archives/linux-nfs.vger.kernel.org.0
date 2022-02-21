Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40174BDBE3
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379986AbiBUQP2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 11:15:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379985AbiBUQPZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 11:15:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6909D23BD4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 08:15:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D8FDB811B3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D2BC36AE3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645460099;
        bh=Y1ipazY3pl3WZgPz62B3OLONuRP4E1z7/Fuod/m3bP0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jSa31iufpB+Ewwj0vhREioQ6W0pADnMKnSbc8KboXKrMmocwULOCCdE9BnlMBUWDG
         kbKNVaKJeQVLKM+mGVhVy73coqUgJvGp2U01g6J+S58YNnT2UZ6kimjiG8ofyDheVM
         m8xVEv1PGVUxhwyrIhDAQ1GfXGcujjkz+DVfIqkf1KojkHPVVD9Zl2dBM/SrHVs5Y2
         ys5wLXy/k4G7ZDKv/f5BnEL26m9OlWVGkQ0jmyKTJJuBxiN9Q6mjaulPFMu7M8TOIL
         /jisxr9qAS4RoowK3D0spzX+gFL0Z6ZpfonfkpNgjsccM+gBsJtvg9uVlITu0tDnCb
         uJo4YNVJ45AKg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 01/13] NFS: constify nfs_server_capable() and nfs_have_writebacks()
Date:   Mon, 21 Feb 2022 11:08:39 -0500
Message-Id: <20220221160851.15508-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221160851.15508-1-trondmy@kernel.org>
References: <20220221160851.15508-1-trondmy@kernel.org>
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

