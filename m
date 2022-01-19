Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E12493214
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jan 2022 01:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiASA5K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 19:57:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49936 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiASA5J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 19:57:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C17161458
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jan 2022 00:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B117EC340E0;
        Wed, 19 Jan 2022 00:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642553828;
        bh=lwZjYxHdL17Btq7TCjVq1JX7DCUb5NgkLIBkus5dGto=;
        h=From:To:Cc:Subject:Date:From;
        b=NsnIzgYx66AKI3OFH7DSxahTeEppK9MLYRB3UYcHnZJmW1pgmZ40fFBhZfgGySDwz
         CQ/qy3G4X+xepgvHm9A8uOCV0KiBTvmJANZVO0ukjygYazu2UtZGt7uY3tnMUiWgB/
         lyRYouLWCA4qA41Np9Q4BZJhgx32mCbz3KbSK2kJy6fHZ9yDi1EorIjIGGevyNX8On
         ZMryQTHSCeYvpXrVjbwk7MGNyUULpoPDcqzLVsw5tiPP0UXOZxBtLqdQsQvZS3Rd+x
         xQ6LXgQlmaLuXudq6l5LEDg8VtcbboX9RwwgjKulO4ux6Xxi+CZfkdkTMAXA4zoMLp
         6mc8PZRKI1A3A==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Don't skip directory entries when doing uncached readdir
Date:   Tue, 18 Jan 2022 19:52:16 -0500
Message-Id: <20220119005216.246686-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we initialise desc->cache_entry_index correctly in
uncached_readdir().

Fixes: d1bacf9eb2fd ("NFS: add readdir cache array")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cbf1a304ca18..07ad7095fffb 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1041,6 +1041,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 		goto out;
 
 	desc->page_index = 0;
+	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
 	desc->duped = 0;
 
-- 
2.34.1

