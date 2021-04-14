Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BDC35F539
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbhDNNoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351612AbhDNNoY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 618B36120E
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407843;
        bh=9VuDnCFm3maQ+Cqaa143l09LCyEAuunSAc2xZV4yGlc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YXKnSvmlTzExCDkXqAFxIjjmdRL6tr9JcxJTJlJwmgnsTRVhMVmF8hd8k0qm9dGNC
         hQHhKI9nOj27eK79K6w9mozP3W+Oxp085Vce55kQcOOLI8sFDddKVpqtr44NpcrJiK
         CucXyGdHjPwhTMAffgUE8uMw6bHdKfsDlCvELGjnrkMlBR2KfdD0CiPHleaGdrjftd
         wmnIXuHgqBYqW8HWcP8CbRmT9kkzmwKwMM2oP8UuMpHsspiDZtRi0n97M/2ILIs1Kp
         w419aVg4No6ihjFj3iTm+iWHnfHJ7wHfWTU9yx9lL7UrU7QI0UT+JDXOaQAytMkmPs
         RKa+HZWKQm89A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 19/26] NFSv4: Don't modify the change attribute cached in the inode
Date:   Wed, 14 Apr 2021 09:43:46 -0400
Message-Id: <20210414134353.11860-20-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-19-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
 <20210414134353.11860-13-trondmy@kernel.org>
 <20210414134353.11860-14-trondmy@kernel.org>
 <20210414134353.11860-15-trondmy@kernel.org>
 <20210414134353.11860-16-trondmy@kernel.org>
 <20210414134353.11860-17-trondmy@kernel.org>
 <20210414134353.11860-18-trondmy@kernel.org>
 <20210414134353.11860-19-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When the client is caching data and a write delegation is held, then the
server may send a CB_GETATTR to query the attributes. When this happens,
the client is supposed to bump the change attribute value that it
returns if it holds cached data.
However that process uses a value that is stored in the delegation. We
do not want to bump the change attribute held in the inode.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 61d1174935b6..3bf82178166a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -764,9 +764,6 @@ static void nfs_inode_add_request(struct inode *inode, struct nfs_page *req)
 	 * with invalidate/truncate.
 	 */
 	spin_lock(&mapping->private_lock);
-	if (!nfs_have_writebacks(inode) &&
-	    NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE))
-		inode_inc_iversion_raw(inode);
 	if (likely(!PageSwapCache(req->wb_page))) {
 		set_bit(PG_MAPPED, &req->wb_flags);
 		SetPagePrivate(req->wb_page);
-- 
2.30.2

