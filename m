Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC45761CF5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjGYPIy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 11:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjGYPIt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 11:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1DA1BDB
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690297694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJLvBknNMarmLDrQxoPD0sclub/8yQR/F2hhXB1vAZE=;
        b=FUSGKRrHFFnNFy1OjB2AcdR7XoT7ISUypOrlnu7XKuLJipa+V1c2RgAru9DeSFAhnCaU1R
        Nzp2tppmw7/vMWYpZaY9r3lWRZvf52ZNdRVSXQUGxxMQbKN2lX2FVXSR8AW438U0QUL3dU
        J9FObiRnhpoig1nnn63jJxy1NEJMi3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-6KHNgpnkP4eR0JciBSAf-w-1; Tue, 25 Jul 2023 11:08:09 -0400
X-MC-Unique: 6KHNgpnkP4eR0JciBSAf-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F188835154;
        Tue, 25 Jul 2023 15:08:08 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.8.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FE78200BA7C;
        Tue, 25 Jul 2023 15:08:08 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
        id 05CD96272B; Tue, 25 Jul 2023 11:08:08 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFS: Fix potential oops in nfs_inode_remove_request()
Date:   Tue, 25 Jul 2023 11:08:07 -0400
Message-ID: <20230725150807.8770-2-smayhew@redhat.com>
In-Reply-To: <20230725150807.8770-1-smayhew@redhat.com>
References: <20230725150807.8770-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Once a folio's private data has been cleared, it's possible for another
process to clear the folio->mapping (e.g. via invalidate_complete_folio2
or evict_mapping_folio), so it wouldn't be safe to call
nfs_page_to_inode() after that.

Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f4cca8f00c0c..489c3f9dae23 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -785,6 +785,8 @@ static void nfs_inode_add_request(struct nfs_page *req)
  */
 static void nfs_inode_remove_request(struct nfs_page *req)
 {
+	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
+
 	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
 		struct address_space *mapping = folio_file_mapping(folio);
@@ -800,7 +802,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		nfs_release_request(req);
-		atomic_long_dec(&NFS_I(nfs_page_to_inode(req))->nrequests);
+		atomic_long_dec(&nfsi->nrequests);
 	}
 }
 
-- 
2.41.0

