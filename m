Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728324AFC1F
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 19:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbiBISyZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 13:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbiBISyI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 13:54:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DD0C1038D5
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 10:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88C7EB82386
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02410C340F2
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644432579;
        bh=9Dkqpz9icKHWvPFSnPQopHVqWpz+abyAU5GPmJFxVv0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QpD6+/vaIROpzZF2n3teoxuiRQB5hk0XLi1WLoW4pQfHhsSzeSOy1iUS0/NTHFmiL
         qPpsPGzyv7VMssTdFqBIJlcdoSVrTK0hdtrJ6h49XLcujZsdGpwZY6XTZGhLxDFu0o
         ZO283J/G8nAGywas8/Ykgt0a7KCSR7L60KbOdXACttK7WkD7I5mrhJiRzzn2q89ui1
         ecDTebLYmnWhddT7LMcI/COQ5nATTWrW7FRJH3yvs/az3A5qJ2anBbOFusTJWLdz+R
         +vzWhmXLvRd5C7TFGXCSK85ZEtxvel+6zPzfTZel5+iU0QRU5hsyigZ3nD7SHQJw8V
         kyXZd+BC3Le5Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] NFS: Simplify nfs_readdir_xdr_to_array()
Date:   Wed,  9 Feb 2022 13:42:51 -0500
Message-Id: <20220209184251.23909-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209184251.23909-2-trondmy@kernel.org>
References: <20220209184251.23909-1-trondmy@kernel.org>
 <20220209184251.23909-2-trondmy@kernel.org>
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
 fs/nfs/dir.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1323eef34f7e..b4f6c0cf8df9 100644
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
+	status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie,
+					pages, dtsize, verf_res);
+	if (status < 0)
+		goto free_pages;
 
+	pglen = status;
+	if (pglen != 0)
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
-		desc->buffer_fills++;
-	} while (!status && nfs_readdir_page_needs_filling(page) &&
-		 page_mapping(page));
+	else
+		nfs_readdir_page_set_eof(page);
+	desc->buffer_fills++;
 
+free_pages:
 	nfs_readdir_free_pages(pages, array_size);
 out:
 	nfs_free_fattr(entry->fattr);
-- 
2.34.1

