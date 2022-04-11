Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D34FC6DF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Apr 2022 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiDKVmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Apr 2022 17:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbiDKVmw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Apr 2022 17:42:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530633A3A
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 14:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F5F561704
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 21:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906E7C385A3;
        Mon, 11 Apr 2022 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649713237;
        bh=qPudaQAYHUtYnkzoLgfPWcStuGfd0CEvlH41urmdpiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXIQedSNy6UQIAPF7o4Xj0qLk+OvHZepSpOsSunh2Wyb5GfacjFL8BSMdCDAjXKWZ
         Xi2EmgZBCBWWPddmiKJ7j3r2vPow9VrBrDTv0gYDgCnpfl6B89qupHxfL/T7yXyiZi
         QqZHipgF/am1rBaXs08Vansc2QPCDiML/9HB31sCkeYvbsSkuCI70FVvaWMTzlC2vy
         /hfDEFhPtg48f6DEZ/4NDv9dDQTePX4CivTXv7a3aC+HjNMysr/JVg7O4lgFRMaIhb
         jn57XVwWI9t9/btuwIFSq3MXBEm+qINMl2Sg28cPKBc6Xdmuhk8+KA1L9i893owbSz
         Dku2codsJR7mQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH v2 4/5] NFS: Do not report flush errors in nfs_write_end()
Date:   Mon, 11 Apr 2022 17:33:45 -0400
Message-Id: <20220411213346.762302-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411213346.762302-4-trondmy@kernel.org>
References: <20220411213346.762302-1-trondmy@kernel.org>
 <20220411213346.762302-2-trondmy@kernel.org>
 <20220411213346.762302-3-trondmy@kernel.org>
 <20220411213346.762302-4-trondmy@kernel.org>
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

If we do flush cached writebacks in nfs_write_end() due to the imminent
expiration of an RPCSEC_GSS session, then we should defer reporting any
resulting errors until the calls to file_check_and_advance_wb_err() in
nfs_file_write() and nfs_file_fsync().

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with generic one")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8211a7aa799c..16ddb258eef3 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -386,11 +386,8 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 		return status;
 	NFS_I(mapping->host)->write_io += copied;
 
-	if (nfs_ctx_key_to_expire(ctx, mapping->host)) {
-		status = nfs_wb_all(mapping->host);
-		if (status < 0)
-			return status;
-	}
+	if (nfs_ctx_key_to_expire(ctx, mapping->host))
+		nfs_wb_all(mapping->host);
 
 	return copied;
 }
-- 
2.35.1

