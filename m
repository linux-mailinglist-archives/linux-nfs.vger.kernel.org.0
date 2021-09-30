Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910E941E25E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Sep 2021 21:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhI3Tqd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Sep 2021 15:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344306AbhI3Tq2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 Sep 2021 15:46:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DE2061A02;
        Thu, 30 Sep 2021 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633031084;
        bh=EY24fpBVL99yG0J83RltG5mV6+xwvzl7aL6Tz9CH4o0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCsh1GceskLevwfGqxg7Z0/uVDqJcVP1Fu7e0RTarWNxEHN6wJ6o/SUNZE936W+tD
         3/qc9+A4gXcXXt+gtoSfEuIXk6k9ACq/Vp2+aT5R3QD59L3DS/aKv0Mm4XdVh/byHg
         nM4tX3/0GURAvU7BAfDzVrP/4DLWWWY+swK4Bb0iBuDfoU2u4UOPE4L2+/tvBwJIxz
         7pXdQjohsTnP8qVibFN3pXZX2yOhEv9NllIb42Z9iyWySUqWKOoVAqVD0UjLpPmznK
         g+24LEvhIJMAPXgjFSb/mkeZzd4jfZvRuX4nbhAItu4fYuRn/W8G3WND/WORRvGqVM
         h9ePepzNIGFiw==
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: Fix a warning for nfsd_file_close_inode
Date:   Thu, 30 Sep 2021 15:44:42 -0400
Message-Id: <20210930194442.249907-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930194442.249907-1-trondmy@kernel.org>
References: <20210930194442.249907-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 7629248fdd53..be3c1aad50ea 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -542,7 +542,7 @@ nfsd_file_close_inode_sync(struct inode *inode)
 }
 
 /**
- * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
+ * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
  * Walk the whole hash bucket, looking for any files that correspond to "inode".
-- 
2.31.1

