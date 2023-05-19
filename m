Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56295709610
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 13:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjESLRa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjESLR1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 07:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C981510C6
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 04:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53AEC656E5
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 11:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A3BC433EF;
        Fri, 19 May 2023 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684495045;
        bh=qxqvGwTqrZSZBSQOemnZkZlqkd+6FylAk1UlwxMcZkM=;
        h=From:To:Cc:Subject:Date:From;
        b=ABOLMzGXCQBKBgjOMttiY3FVm6oMc8HZ5l5Wi7Y3jcFCdcX9HBCfSVSQoKtjVTZFE
         y6FREIBSTVWKy8Eu5FseLdGAjbNcIOJHT0uhT6IuhU5q+wDAtWFCESiS2/M90ci+4d
         n46zKTwc0SkqgUpbwo3FYPRyYXzR0rS3Bw0miP5EGxrmNN7ftoze0KBZj7HIaJirOz
         3D2IfOpIhrNiHTELwPfmb8NIs6z/hNBpEo6O3U42St8Li/PsNXUl7svSVBgZsncnz/
         YrYvTgE1fzW4WzWeegPYQVMTo52QW0c6JNJSso/L6DY4BYyec5Yb8d3Pt4ThAynZOO
         VVlESJcVr3fsQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr fails
Date:   Fri, 19 May 2023 07:17:23 -0400
Message-Id: <20230519111723.20612-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd calls fh_getattr to get the latest inode attrs for pre/post-op
info. In the event that fh_getattr fails, it resorts to scraping cached
values out of the inode directly.

Since these attributes are optional, we can just skip providing them
altogether when this happens.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ccd8485fee04..e8e13ae72e3c 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -623,16 +623,9 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 
 	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
-	if (err) {
-		/* Grab the times from inode anyway */
-		stat.mtime = inode->i_mtime;
-		stat.ctime = inode->i_ctime;
-		stat.size  = inode->i_size;
-		if (v4 && IS_I_VERSION(inode)) {
-			stat.change_cookie = inode_query_iversion(inode);
-			stat.result_mask |= STATX_CHANGE_COOKIE;
-		}
-	}
+	if (err)
+		return;
+
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 
@@ -660,15 +653,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 		printk("nfsd: inode locked twice during operation.\n");
 
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	if (err) {
-		fhp->fh_post_saved = false;
-		fhp->fh_post_attr.ctime = inode->i_ctime;
-		if (v4 && IS_I_VERSION(inode)) {
-			fhp->fh_post_attr.change_cookie = inode_query_iversion(inode);
-			fhp->fh_post_attr.result_mask |= STATX_CHANGE_COOKIE;
-		}
-	} else
-		fhp->fh_post_saved = true;
+	if (err)
+		return;
+
+	fhp->fh_post_saved = true;
 	if (v4)
 		fhp->fh_post_change =
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
-- 
2.40.1

