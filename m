Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833107EF1AD
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjKQLZY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 06:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjKQLZX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 06:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8528A131
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700220319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xe/u3nfBzX7MivjnKud0JI8n4zYuwq4AWzE0imDEXhY=;
        b=T/kPxLMBlN0m2sA+TziohyYKxTb3mpGO0RO5FNZt62CHizUZuv7d8OMTmqzxZT0N+gret2
        pR/C713TeHm1TS9p38c9rNgLkhJpmhIlZf06Bh2EGaI2pYi5J6tARLcW4H9GjYHCL2VRzQ
        ajRHUwmzD+dEbv+ZH1mITJpEJc+fczM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-disnBCg5Pj2jT_4ZYZkJ_Q-1; Fri,
 17 Nov 2023 06:25:16 -0500
X-MC-Unique: disnBCg5Pj2jT_4ZYZkJ_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5642338116E0;
        Fri, 17 Nov 2023 11:25:16 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B45E92026D4C;
        Fri, 17 Nov 2023 11:25:15 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] pNFS: Fix the pnfs block driver's calculation of layoutget size
Date:   Fri, 17 Nov 2023 06:25:13 -0500
Message-ID: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700220277.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of relying on the value of the 'bytes_left' field, we should
calculate the layout size based on the offset of the request that is
being written out.

Reported-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Fixes: 954998b60caa ("NFS: Fix error handling for O_DIRECT write scheduling")
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/blocklayout/blocklayout.c | 5 ++---
 fs/nfs/direct.c                  | 5 +++--
 fs/nfs/internal.h                | 2 +-
 fs/nfs/pnfs.c                    | 3 ++-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 943aeea1eb16..c1cc9fe93dd4 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -893,10 +893,9 @@ bl_pg_init_write(struct nfs_pageio_descriptor *pgio, struct nfs_page *req)
 	}
 
 	if (pgio->pg_dreq == NULL)
-		wb_size = pnfs_num_cont_bytes(pgio->pg_inode,
-					      req->wb_index);
+		wb_size = pnfs_num_cont_bytes(pgio->pg_inode, req->wb_index);
 	else
-		wb_size = nfs_dreq_bytes_left(pgio->pg_dreq);
+		wb_size = nfs_dreq_bytes_left(pgio->pg_dreq, req_offset(req));
 
 	pnfs_generic_pg_init_write(pgio, req, wb_size);
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index f6c74f424691..5918c67dae0d 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -205,9 +205,10 @@ static void nfs_direct_req_release(struct nfs_direct_req *dreq)
 	kref_put(&dreq->kref, nfs_direct_req_free);
 }
 
-ssize_t nfs_dreq_bytes_left(struct nfs_direct_req *dreq)
+ssize_t nfs_dreq_bytes_left(struct nfs_direct_req *dreq, loff_t offset)
 {
-	return dreq->bytes_left;
+	loff_t start = offset - dreq->io_start;
+	return dreq->max_count - start;
 }
 EXPORT_SYMBOL_GPL(nfs_dreq_bytes_left);
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9c9cf764f600..b1fa81c9dff6 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -655,7 +655,7 @@ extern int nfs_sillyrename(struct inode *dir, struct dentry *dentry);
 /* direct.c */
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
 			      struct nfs_direct_req *dreq);
-extern ssize_t nfs_dreq_bytes_left(struct nfs_direct_req *dreq);
+extern ssize_t nfs_dreq_bytes_left(struct nfs_direct_req *dreq, loff_t offset);
 
 /* nfs4proc.c */
 extern struct nfs_client *nfs4_init_client(struct nfs_client *clp,
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 84343aefbbd6..9084f156d67b 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2729,7 +2729,8 @@ pnfs_generic_pg_init_read(struct nfs_pageio_descriptor *pgio, struct nfs_page *r
 		if (pgio->pg_dreq == NULL)
 			rd_size = i_size_read(pgio->pg_inode) - req_offset(req);
 		else
-			rd_size = nfs_dreq_bytes_left(pgio->pg_dreq);
+			rd_size = nfs_dreq_bytes_left(pgio->pg_dreq,
+						      req_offset(req));
 
 		pgio->pg_lseg =
 			pnfs_update_layout(pgio->pg_inode, nfs_req_openctx(req),
-- 
2.41.0

