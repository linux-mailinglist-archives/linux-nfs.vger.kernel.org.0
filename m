Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B667158DF54
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbiHISpc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345762AbiHISpK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 14:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620D82F661
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 11:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1725612A1
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 18:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3488FC43140
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660069163;
        bh=GVaIsCyWR1JiyAbhCXS3YtIUu26ALH5Uo5MX7yUJt8E=;
        h=From:To:Subject:Date:From;
        b=aNgJMyutcxMQBEDro6ysBJ0I8dYzaPCyEmcNbBReI0GQ4CqHYqVsNvy9/61aWKWeu
         s/fmLK87ldQWZ+9zY0lAmhtjsJevIYgsHOcpK/O23VSgPjaIUqlvTRDxe0imqbOjdD
         84U8B0o6Tx7TzbOZr9557FQe9OyC4E1u0SOr4JGkMGlMqlficgy0q8FyVUpsnrfSA/
         1b1bIEsCbbnfe9zuDBQk7lGAqqCWmIJOBYjjWQ/Pd19QqhQwnW5fAebholsmnOpKgC
         f8oWHV5oVmQJxNFE77I8KGlRIEyoTBMAotUhjN3Uq7QcG2nr472IsfmA4op7qSCI46
         aCa3wJUhfCVZg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Improve write error tracing
Date:   Tue,  9 Aug 2022 14:13:15 -0400
Message-Id: <20220809181317.20348-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Don't leak request pointers, but use the "device:inode" labelling that
is used by all the other trace points. Furthermore, replace use of page
indexes with an offset, again in order to align behaviour with other
NFS trace points.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h        | 36 +++++++++++++++++++++---------------
 fs/nfs/write.c           |  8 +++++---
 include/linux/nfs_page.h |  3 +--
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8bd0c13a7c4b..731eecfdf49a 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1447,44 +1447,50 @@ TRACE_EVENT(nfs_writeback_done,
 
 DECLARE_EVENT_CLASS(nfs_page_error_class,
 		TP_PROTO(
+			const struct inode *inode,
 			const struct nfs_page *req,
 			int error
 		),
 
-		TP_ARGS(req, error),
+		TP_ARGS(inode, req, error),
 
 		TP_STRUCT__entry(
-			__field(const void *, req)
-			__field(pgoff_t, index)
-			__field(unsigned int, offset)
-			__field(unsigned int, pgbase)
-			__field(unsigned int, bytes)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(unsigned int, count)
 			__field(int, error)
 		),
 
 		TP_fast_assign(
-			__entry->req = req;
-			__entry->index = req->wb_index;
-			__entry->offset = req->wb_offset;
-			__entry->pgbase = req->wb_pgbase;
-			__entry->bytes = req->wb_bytes;
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->offset = req_offset(req);
+			__entry->count = req->wb_bytes;
 			__entry->error = error;
 		),
 
 		TP_printk(
-			"req=%p index=%lu offset=%u pgbase=%u bytes=%u error=%d",
-			__entry->req, __entry->index, __entry->offset,
-			__entry->pgbase, __entry->bytes, __entry->error
+			"error=%d fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld count=%u", __entry->error,
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->offset,
+			__entry->count
 		)
 );
 
 #define DEFINE_NFS_PAGEERR_EVENT(name) \
 	DEFINE_EVENT(nfs_page_error_class, name, \
 			TP_PROTO( \
+				const struct inode *inode, \
 				const struct nfs_page *req, \
 				int error \
 			), \
-			TP_ARGS(req, error))
+			TP_ARGS(inode, req, error))
 
 DEFINE_NFS_PAGEERR_EVENT(nfs_write_error);
 DEFINE_NFS_PAGEERR_EVENT(nfs_comp_error);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 4adf2b488da1..4a3796811b4b 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -592,7 +592,8 @@ nfs_lock_and_join_requests(struct page *page)
 
 static void nfs_write_error(struct nfs_page *req, int error)
 {
-	trace_nfs_write_error(req, error);
+	trace_nfs_write_error(page_file_mapping(req->wb_page)->host, req,
+			      error);
 	nfs_mapping_set_error(req->wb_page, error);
 	nfs_inode_remove_request(req);
 	nfs_end_page_writeback(req);
@@ -1000,7 +1001,7 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 		nfs_list_remove_request(req);
 		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags) &&
 		    (hdr->good_bytes < bytes)) {
-			trace_nfs_comp_error(req, hdr->error);
+			trace_nfs_comp_error(hdr->inode, req, hdr->error);
 			nfs_mapping_set_error(req->wb_page, hdr->error);
 			goto remove_req;
 		}
@@ -1882,7 +1883,8 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 			(long long)req_offset(req));
 		if (status < 0) {
 			if (req->wb_page) {
-				trace_nfs_commit_error(req, status);
+				trace_nfs_commit_error(data->inode, req,
+						       status);
 				nfs_mapping_set_error(req->wb_page, status);
 				nfs_inode_remove_request(req);
 			}
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index f0373a6cb5fb..ba7e2e4b0926 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -202,8 +202,7 @@ nfs_list_entry(struct list_head *head)
 	return list_entry(head, struct nfs_page, wb_list);
 }
 
-static inline
-loff_t req_offset(struct nfs_page *req)
+static inline loff_t req_offset(const struct nfs_page *req)
 {
 	return (((loff_t)req->wb_index) << PAGE_SHIFT) + req->wb_offset;
 }
-- 
2.37.1

