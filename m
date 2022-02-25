Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97714C4DE6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiBYSfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiBYSfQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350271B0C60
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CADC4B8330A
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A119C340F0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814082;
        bh=dAwumqNCKPnGHYh6b3185ZydIfe0DxBHTta72NTR/+8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EZMZmUmJNvdHP1wmBrVRLGBVFKdevcxPatxG1TpFwyAS3/Erc8Hsv2rBLRK9SgPrR
         sm0l7krz+6ZjAvcKCKp7YSz59ls1zPwF2ZiwnuefZCJO1w4ug8sSF2SF9hFUwYqij3
         jeXoQId4NhBVZP52QpwH9hOvgougTFvG/JCMMx9pA45FEiAQC+cWjzp4qufZyBeqPU
         UzoRdQkL5P0OgXkQVhDGqA4J6jJbICxKJSh3wEEKevmijMVPumHXP1X+jaw2lvHs3+
         LNMWSoh91Q+kefHeOrkgwgJomKMpsN2cXbx6Y3fwwv8xG1izG3cANdGeJEdyupm/Sy
         4BmaFkXT2mV4g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 16/24] NFS: Readdirplus can't help lookup for case insensitive filesystems
Date:   Fri, 25 Feb 2022 13:28:21 -0500
Message-Id: <20220225182829.1236093-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-16-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
 <20220225182829.1236093-10-trondmy@kernel.org>
 <20220225182829.1236093-11-trondmy@kernel.org>
 <20220225182829.1236093-12-trondmy@kernel.org>
 <20220225182829.1236093-13-trondmy@kernel.org>
 <20220225182829.1236093-14-trondmy@kernel.org>
 <20220225182829.1236093-15-trondmy@kernel.org>
 <20220225182829.1236093-16-trondmy@kernel.org>
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

If the filesystem is case insensitive, then readdirplus can't help with
cache misses, since it won't return case folded variants of the filename.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 403dbfc36a39..feaf19240db1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -684,6 +684,8 @@ void nfs_readdir_record_entry_cache_miss(struct inode *dir)
 
 static void nfs_lookup_advise_force_readdirplus(struct inode *dir)
 {
+	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+		return;
 	nfs_readdir_record_entry_cache_miss(dir);
 }
 
-- 
2.35.1

