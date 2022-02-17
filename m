Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996C4BACC4
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 23:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbiBQWjt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 17:39:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbiBQWjs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 17:39:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9077E811B9
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 14:39:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05C24CE303F
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 22:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C861C340EB
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 22:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137570;
        bh=OEaWlQura1Zo3jLczETAEUmVQFXQqWShYTiOvBTsLUA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OveIbU+lqrqwC3Yg7RbJlwNTAJkvNrIxH+nQGzS4ycxnUFQ90kC1qnCb9E75Aj5An
         t/rjQNxHXBc0Dwcdc103arijzoK23J286Dd5K/OoB2JzBM9D4BaGuE5QWVgaGI6IpG
         rvcyLJmw2Z6+OnU+GdohdV2LciYrQhkpy5UpH8zxTMIJZaMlo2z1NsfVaS8m8xKTJy
         cnW3t/Uf+UWhSvdHEENpI/sjjdtCb/XCuhwiLN08JFdCojG0O28FTX32K3WayIvVHy
         BpE6byUNo2qZSOWDRuynJ+kDyiHCpCikzFsrYOLO8yeeFl3kmubN9vOdACqE3KPsd+
         IFBrZOgp9PTeQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/5] NFS: Simplify nfs_readdir_xdr_to_array()
Date:   Thu, 17 Feb 2022 17:33:20 -0500
Message-Id: <20220217223323.696173-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217223323.696173-2-trondmy@kernel.org>
References: <20220217223323.696173-1-trondmy@kernel.org>
 <20220217223323.696173-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Recent changes to readdir mean that we can cope with partially filled
page cache entries, so we no longer need to rely on looping in
nfs_readdir_xdr_to_array().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b0ee3a0e0f81..10421b5331ca 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -864,6 +864,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
 	unsigned int dtsize = desc->dtsize;
+	unsigned int pglen;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -881,28 +882,20 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	if (!pages)
 		goto out;
 
-	do {
-		unsigned int pglen;
-		status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie,
-						pages, dtsize,
-						verf_res);
-		if (status < 0)
-			break;
-
-		pglen = status;
-		if (pglen == 0) {
-			nfs_readdir_page_set_eof(page);
-			break;
-		}
-
-		verf_arg = verf_res;
+	status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie, pages,
+					dtsize, verf_res);
+	if (status < 0)
+		goto free_pages;
 
+	pglen = status;
+	if (pglen != 0)
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
-		desc->buffer_fills++;
-	} while (!status && nfs_readdir_page_needs_filling(page) &&
-		page_mapping(page));
+	else
+		nfs_readdir_page_set_eof(page);
+	desc->buffer_fills++;
 
+free_pages:
 	nfs_readdir_free_pages(pages, array_size);
 out:
 	nfs_free_fattr(entry->fattr);
-- 
2.35.1

