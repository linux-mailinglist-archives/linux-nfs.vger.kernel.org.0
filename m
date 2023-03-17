Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5344B6BEF50
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCQRNV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCQRNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 13:13:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226683E0B1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 10:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B86FEB82659
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 17:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFE6C433D2;
        Fri, 17 Mar 2023 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679073192;
        bh=/IA/gBF5xdU3bBX70lcMXr9SpAVguVGLlxmjWi6J9I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNpUWrozIlxGm2uym1vQuvYebt0X6r7SLDbtuMEvjX+mtl0Zf9n64MxZIpFE1wta+
         3f7a5Wb1Pu6TG4xo0hiugMAImPW0v3SyymmLht8a+ca2wc2q2MfXkCE/T0Cfx+9Uok
         o53KZH2kKuCMsq0zFx+VMNQ1oaWQBfvrbMgQ0CISsD4sYtds+DRzlOJaeX6FI6U7q3
         Yxy2rcggBk3ebmzhixD+u4lvAjHO+BoTDn62aYIHFEpXwVyv6/10Bi7BlT0YjDhQnd
         UdY0Mej7lnvShKa6sqIFHIs68tKQkJGZ5Le77mLgNfqML0+Rc/AIL/NaBRCis4BlSU
         1GKgCQ/2phqmw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dcritch@redhat.com, d.lesca@solinos.it,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 2/2] sunrpc: add bounds checking to svc_rqst_replace_page
Date:   Fri, 17 Mar 2023 13:13:09 -0400
Message-Id: <20230317171309.73607-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171309.73607-1-jlayton@kernel.org>
References: <20230317171309.73607-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If rq_next_page ends up pointing outside the array, then we can corrupt
memory when we go to change its value. Ensure that it hasn't strayed
outside the array, and have svc_rqst_replace_page return -EIO without
changing anything if it has.

Fix up nfsd_splice_actor (the only caller) to handle this case by either
returning an error or a short splice when this happens.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c              | 23 +++++++++++++++++------
 include/linux/sunrpc/svc.h |  2 +-
 net/sunrpc/svc.c           | 14 +++++++++++++-
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 97b38b47c563..0ebd7a65a9f0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -939,6 +939,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 	struct page *page = buf->page;	// may be a compound one
 	unsigned offset = buf->offset;
 	struct page *last_page;
+	int ret = 0, consumed = 0;
 
 	last_page = page + (offset + sd->len - 1) / PAGE_SIZE;
 	for (page += offset / PAGE_SIZE; page <= last_page; page++) {
@@ -946,13 +947,23 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 		 * Skip page replacement when extending the contents
 		 * of the current page.
 		 */
-		if (page != *(rqstp->rq_next_page - 1))
-			svc_rqst_replace_page(rqstp, page);
+		if (page != *(rqstp->rq_next_page - 1)) {
+			ret = svc_rqst_replace_page(rqstp, page);
+			if (ret)
+				break;
+		}
+		consumed += min_t(int,
+				  PAGE_SIZE - offset_in_page(offset),
+				  sd->len - consumed);
+		offset = 0;
 	}
-	if (rqstp->rq_res.page_len == 0)	// first call
-		rqstp->rq_res.page_base = offset % PAGE_SIZE;
-	rqstp->rq_res.page_len += sd->len;
-	return sd->len;
+	if (consumed) {
+		if (rqstp->rq_res.page_len == 0)	// first call
+			rqstp->rq_res.page_base = offset % PAGE_SIZE;
+		rqstp->rq_res.page_len += consumed;
+		return consumed;
+	}
+	return ret;
 }
 
 static int nfsd_direct_splice_actor(struct pipe_inode_info *pipe,
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 877891536c2f..9ea52f143f49 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -422,7 +422,7 @@ struct svc_serv *svc_create(struct svc_program *, unsigned int,
 			    int (*threadfn)(void *data));
 struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
-void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
+int		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index fea7ce8fba14..d624c02f09be 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -843,8 +843,19 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
  * When replacing a page in rq_pages, batch the release of the
  * replaced pages to avoid hammering the page allocator.
  */
-void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
+int svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 {
+	struct page **begin, **end;
+
+	/*
+	 * Bounds check: make sure rq_next_page points into the rq_respages
+	 * part of the array.
+	 */
+	begin = rqstp->rq_pages;
+	end = &rqstp->rq_pages[RPCSVC_MAXPAGES];
+	if (WARN_ON_ONCE(rqstp->rq_next_page < begin || rqstp->rq_next_page > end))
+		return -EIO;
+
 	if (*rqstp->rq_next_page) {
 		if (!pagevec_space(&rqstp->rq_pvec))
 			__pagevec_release(&rqstp->rq_pvec);
@@ -853,6 +864,7 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
 
 	get_page(page);
 	*(rqstp->rq_next_page++) = page;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
 
-- 
2.39.2

