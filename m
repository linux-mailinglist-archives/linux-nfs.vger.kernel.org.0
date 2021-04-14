Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13835F639
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhDNOcC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 10:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhDNOcC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 10:32:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F7BF61139;
        Wed, 14 Apr 2021 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618410700;
        bh=Hh3fbl/bAs++f8chcCzydInEgco/SmR/JtG6SNRbGr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pi5GEJSgg/2z7cgFKrOBtuKYxPPR5iy1fRn/rEv7QUBnL+Ts7SlU9BwOTFvQTNq4y
         OJ+I+EEoGGKmB2ICT7l7VggvMXfWLKjBXvfP03qgTRItGzCpmyGen1FoO8oLG97A1a
         h36/ZmgpRbT85+gxe3TTFwO+Z3/mvnhuJuFn3CLe41ialOlIGwLgp3CHf8vowEeoq1
         /gwhfImXOdaYClsgmcjI8ZlvBkQNUnfTXRmneFUP9Hsv3xx97wrNjBN/I+zE2Pw6rU
         PkExHbQhcDNM87VrIwuCmHjEYyxELKvNzgfqZAzVbNPMHjRYW+heMVSm8z67XexTS/
         wdMtv9cymf3zw==
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Olga Kornievskaia <kolga@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv42: Don't force attribute revalidation of the copy offload source
Date:   Wed, 14 Apr 2021 10:31:38 -0400
Message-Id: <20210414143138.15192-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414143138.15192-1-trondmy@kernel.org>
References: <20210414143138.15192-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When a copy offload is performed, we do not expect the source file to
change other than perhaps to see the atime be updated.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 3875120ef3ef..a24349512ffe 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -390,12 +390,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 	}
 
 	nfs42_copy_dest_done(dst_inode, pos_dst, res->write_res.count);
-
-	spin_lock(&src_inode->i_lock);
-	nfs_set_cache_invalid(src_inode, NFS_INO_REVAL_PAGECACHE |
-						 NFS_INO_REVAL_FORCED |
-						 NFS_INO_INVALID_ATIME);
-	spin_unlock(&src_inode->i_lock);
+	nfs_invalidate_atime(src_inode);
 	status = res->write_res.count;
 out:
 	if (args->sync)
-- 
2.30.2

