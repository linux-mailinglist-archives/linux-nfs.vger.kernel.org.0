Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEA14C1DB4
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiBWVXg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbiBWVUG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0E54ECDA
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F3C26189D
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5603AC340F1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651177;
        bh=xz8FVkRXo0VWPTOYUY4Y5rtOlouiXfwThWdtaTUBv6g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jWNDYiS45pOxng56y/0f8aCxTewYq40iaiQPhSJl1Fs8D6NpwaxEZ9Gn/GrkMsqFr
         LLmjHtmHgU29xOmkJCL5vtTJrKq35AJlQ3bjDiobgw1Iu5E6hTLG6BVxL/urDbGR9v
         bcGoHukGZYlCQpz9mMy37qtB3opWDWFew7pUp0RH59s6FVZbwi9O5jRWHmiuaK/gbb
         5GjppolMSiV0L1mtNdAhT2a7Yz/ux1Dl5nGaSWaRUNJjJYgzUK1qNHez5UPe6Etbth
         6x1NSQholUtR7slowvvOphjdE/bQKuw0/6DrAvGvh1aySlhKPriOqTpX1/qBCPTZpy
         BlUPXHxUCMznQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 14/21] NFS: Readdirplus can't help lookup for case insensitive filesystems
Date:   Wed, 23 Feb 2022 16:12:58 -0500
Message-Id: <20220223211305.296816-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-14-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
 <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org>
 <20220223211305.296816-10-trondmy@kernel.org>
 <20220223211305.296816-11-trondmy@kernel.org>
 <20220223211305.296816-12-trondmy@kernel.org>
 <20220223211305.296816-13-trondmy@kernel.org>
 <20220223211305.296816-14-trondmy@kernel.org>
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
index e7942fbe3f50..a9098d5a9fc8 100644
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

