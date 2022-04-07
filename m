Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5984F876B
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbiDGSy3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 14:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347004AbiDGSy2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 14:54:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84141834C7
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 11:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A4C4B82607
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17760C385A4
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357545;
        bh=/0aHu6lQWcAuZqBeYBDiYAEFbo9Ggxhgm5iutTtf7Hk=;
        h=From:To:Subject:Date:From;
        b=SDcnVMfLbr+aSEPwFqg7aZkAFSZbnz6k82XQ+CLcrblWe6zIMFCAA0smiFNDjx88K
         tZt6Kg/YaY+86TfVbAEyuWeMHGvQlPaZgV8dzFUED9iIinKZmb82BmSuxv8AWiNSmZ
         Vu8ko4R7oCgGQO7MyJuWCPloZGYNzGjkl9kyVmFduOyrXOOm2kTSbJk8PVDQZMFBnk
         6SoqjDuqREqysIRsbKBXV2eFXNszEC6cLYBBvY4LoPyKU7SEvHSo1R6rTWY2FtIaTv
         Te439vwdBRl82URiJXrLV3fYNor/BIQPmRsheWK5HNelHiIzo6cTjLNJ6aSRU/ikzB
         BkewS50iFPfsg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/8] NFSv4.2: Fix missing removal of SLAB_ACCOUNT on kmem_cache allocation
Date:   Thu,  7 Apr 2022 14:45:54 -0400
Message-Id: <20220407184601.1064640-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
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

From: Muchun Song <songmuchun@bytedance.com>

The commit 5c60e89e71f8 ("NFSv4.2: Fix up an invalid combination of memory
allocation flags") has stripped GFP_KERNEL_ACCOUNT down to GFP_KERNEL,
however, it forgot to remove SLAB_ACCOUNT from kmem_cache allocation.
It means that memory is still limited by kmemcg.  This patch also fix a
NULL pointer reference issue [1] reported by NeilBrown.

Link: https://lore.kernel.org/all/164870069595.25542.17292003658915487357@noble.neil.brown.name/ [1]
Fixes: 5c60e89e71f8 ("NFSv4.2: Fix up an invalid combination of memory allocation flags")
Fixes: 5abc1e37afa0 ("mm: list_lru: allocate list_lru_one only when needed")
Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index ad3405c64b9e..e7b34f7e0614 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -997,7 +997,7 @@ int __init nfs4_xattr_cache_init(void)
 
 	nfs4_xattr_cache_cachep = kmem_cache_create("nfs4_xattr_cache_cache",
 	    sizeof(struct nfs4_xattr_cache), 0,
-	    (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+	    (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD),
 	    nfs4_xattr_cache_init_once);
 	if (nfs4_xattr_cache_cachep == NULL)
 		return -ENOMEM;
-- 
2.35.1

