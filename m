Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3427C5737
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjJKOoT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 10:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjJKOoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 10:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E376A4
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697035416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VuWI80C20i7PJV6KMNwxtQYzd52tczI2bNhvyMzQlMM=;
        b=g5FS36pinbAMQG2CjnPEYq+lYC+2cVuWdiXLig+can+BQVNhm9XoPje/U/yxIQdYFDKStQ
        Vvh7GJQmlVAysVhjvPmkdBeaX9bVtk07nJ/mcUyFJ1mzENl1yitomLmh7DR18/0jS0SOCx
        O9qtDYZ81UNxERuANA/butz+zqhnub4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-hkhF-BtWMvaU2WCQnQXDuQ-1; Wed, 11 Oct 2023 10:43:28 -0400
X-MC-Unique: hkhF-BtWMvaU2WCQnQXDuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 690A23822E8A;
        Wed, 11 Oct 2023 14:43:27 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.9.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21D8A9A;
        Wed, 11 Oct 2023 14:43:27 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Dai Ngo <dai.ngo@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH] NFS: Fix potential oops in nfs_inode_remove_request()
Date:   Wed, 11 Oct 2023 10:43:26 -0400
Message-ID: <9ce2991a161ce2bd9c5c7f5f8eb39b6d05c0b0b2.1697034691.git.bcodding@redhat.com>
In-Reply-To: <CAFX2Jfmxee0c77kQ8WOAyKbVM55e2f0P-8y4Vc3Nf_=t+kZFKw@mail.gmail.com>
References: <CAFX2Jfmxee0c77kQ8WOAyKbVM55e2f0P-8y4Vc3Nf_=t+kZFKw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Scott Mayhew <smayhew@redhat.com>

Once a folio's private data has been cleared, it's possible for another
process to clear the folio->mapping (e.g. via invalidate_complete_folio2
or evict_mapping_folio), so it wouldn't be safe to call
nfs_page_to_inode() after that.

Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 7720b5e43014..9d82d50ce0b1 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -788,6 +788,8 @@ static void nfs_inode_add_request(struct nfs_page *req)
  */
 static void nfs_inode_remove_request(struct nfs_page *req)
 {
+	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
+
 	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
 		struct address_space *mapping = folio_file_mapping(folio);
@@ -802,7 +804,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	}
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
-		atomic_long_dec(&NFS_I(nfs_page_to_inode(req))->nrequests);
+		atomic_long_dec(&nfsi->nrequests);
 		nfs_release_request(req);
 	}
 }
-- 
2.41.0

