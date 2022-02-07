Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A14ACBA8
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiBGVw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 16:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243124AbiBGVwW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 16:52:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF3C0612A4
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 13:52:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE5A5CE12F4
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 21:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C55C340EF
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644270738;
        bh=mDJ7+c9NiDpAXTUCW6B1Fr5ZbiEdZ3/+U/lP202Mz5o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N2BKNwfCcMlBdYV+kfHHBGasi5GT0WVwyQ9GXCCOHmtdZTDMMKReoZAofSZOkyPXe
         a3gGdZb0LHnvwGa4ftXxe1NHStFJzUzi6Nch/aPG2B02rGaeoyDHTHUnqGcZGzmd9E
         XK3ni5S0fav4W/Dqcfc5NkNDwHVUaepRT1Y9ySvtYH3dMCahy9UwCIyJsV92thwcWz
         BIXIE1w4O564bLPfWBAu/3qz2lTWSbxlekrnpfu4ywvxXbvs5UT664NhyTwOFDypl6
         /3ZseNb86222XUMsR3SdwRWcUvEXLgI37NB1qwdNXqL00pv3G3dN88F9JdpKdAG6n/
         tAwQkchn1Mlaw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Simplify nfs_readdir_xdr_to_array()
Date:   Mon,  7 Feb 2022 16:46:10 -0500
Message-Id: <20220207214610.803566-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207214610.803566-2-trondmy@kernel.org>
References: <20220207214610.803566-1-trondmy@kernel.org>
 <20220207214610.803566-2-trondmy@kernel.org>
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

Recent changes to readdir mean that we can cope with partially filled
page cache entries, so we no longer need to rely on looping in
nfs_readdir_xdr_to_array().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c8b62c231080..33eb3a8f0c71 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -868,6 +868,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
 	unsigned int dtsize = desc->dtsize;
+	unsigned int pglen;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -885,27 +886,19 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
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
+	status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie,
+					pages, dtsize, verf_res);
+	if (status < 0)
+		goto free_pages;
 
+	pglen = status;
+	if (pglen != 0)
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
-	} while (!status && nfs_readdir_page_needs_filling(page) &&
-		 page_mapping(page));
+	else
+		nfs_readdir_page_set_eof(page);
 
+free_pages:
 	nfs_readdir_free_pages(pages, array_size);
 out:
 	nfs_free_fattr(entry->fattr);
-- 
2.34.1

