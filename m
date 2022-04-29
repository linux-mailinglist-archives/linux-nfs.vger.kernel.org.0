Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BC4513FAF
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 02:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350820AbiD2AsD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 20:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbiD2AsC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 20:48:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3350FBB902;
        Thu, 28 Apr 2022 17:44:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCA8121872;
        Fri, 29 Apr 2022 00:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651193084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrU/wsC8sdfT/R0JtZvwzkc1EUgEvszFC5tR6hfJPHE=;
        b=HcAEspUL3B+9CGfESTkkWyVHLwjkJyuXcPrNSc2itnNpsG4afpKgD2fceNteEvGeIDzDkF
        vam2Q7ZjD4Gu5lf4cLuh8wj+2UI/XuhK0NK7Izl6oYOI2DyEklQM6ZBCinCG9RVEBqv6mY
        w/P+5PydmAsMkqnfWIlJG5nPcjgdwrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651193084;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrU/wsC8sdfT/R0JtZvwzkc1EUgEvszFC5tR6hfJPHE=;
        b=pAN5MwCEnPu7JYa0cLy1RgMWnMu44JE2gGqZNmMinRWucAubigJnhLMMABEnAgm3z3Cafp
        P+EvQ9EmCJq+XnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A593513491;
        Fri, 29 Apr 2022 00:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ljwOGfo0a2IrSgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Apr 2022 00:44:42 +0000
Subject: [PATCH 1/2] MM: handle THP in swap_*page_fs()
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:43:34 +1000
Message-ID: <165119301488.15698.9457662928942765453.stgit@noble.brown>
In-Reply-To: <165119280115.15698.2629172320052218921.stgit@noble.brown>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Pages passed to swap_readpage()/swap_writepage() are not necessarily all
the same size - there may be transparent-huge-pages involves.

The BIO paths of swap_*page() handle this correctly, but the SWP_FS_OPS
path does not.

So we need to use thp_size() to find the size, not just assume
PAGE_SIZE, and we need to track the total length of the request, not
just assume it is "page * PAGE_SIZE".

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_io.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index c132511f521c..d636a3531cad 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -239,6 +239,7 @@ struct swap_iocb {
 	struct kiocb		iocb;
 	struct bio_vec		bvec[SWAP_CLUSTER_MAX];
 	int			pages;
+	int			len;
 };
 static mempool_t *sio_pool;
 
@@ -261,7 +262,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 	struct page *page = sio->bvec[0].bv_page;
 	int p;
 
-	if (ret != PAGE_SIZE * sio->pages) {
+	if (ret != sio->len) {
 		/*
 		 * In the case of swap-over-nfs, this can be a
 		 * temporary failure if the system has limited
@@ -301,7 +302,7 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 		sio = *wbc->swap_plug;
 	if (sio) {
 		if (sio->iocb.ki_filp != swap_file ||
-		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
+		    sio->iocb.ki_pos + sio->len != pos) {
 			swap_write_unplug(sio);
 			sio = NULL;
 		}
@@ -312,10 +313,12 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 		sio->iocb.ki_complete = sio_write_complete;
 		sio->iocb.ki_pos = pos;
 		sio->pages = 0;
+		sio->len = 0;
 	}
 	sio->bvec[sio->pages].bv_page = page;
-	sio->bvec[sio->pages].bv_len = PAGE_SIZE;
+	sio->bvec[sio->pages].bv_len = thp_size(page);
 	sio->bvec[sio->pages].bv_offset = 0;
+	sio->len += thp_size(page);
 	sio->pages += 1;
 	if (sio->pages == ARRAY_SIZE(sio->bvec) || !wbc->swap_plug) {
 		swap_write_unplug(sio);
@@ -371,8 +374,7 @@ void swap_write_unplug(struct swap_iocb *sio)
 	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
 	int ret;
 
-	iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages,
-		      PAGE_SIZE * sio->pages);
+	iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages, sio->len);
 	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
 	if (ret != -EIOCBQUEUED)
 		sio_write_complete(&sio->iocb, ret);
@@ -383,7 +385,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
 	int p;
 
-	if (ret == PAGE_SIZE * sio->pages) {
+	if (ret == sio->len) {
 		for (p = 0; p < sio->pages; p++) {
 			struct page *page = sio->bvec[p].bv_page;
 
@@ -415,7 +417,7 @@ static void swap_readpage_fs(struct page *page,
 		sio = *plug;
 	if (sio) {
 		if (sio->iocb.ki_filp != sis->swap_file ||
-		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
+		    sio->iocb.ki_pos + sio->len != pos) {
 			swap_read_unplug(sio);
 			sio = NULL;
 		}
@@ -426,10 +428,12 @@ static void swap_readpage_fs(struct page *page,
 		sio->iocb.ki_pos = pos;
 		sio->iocb.ki_complete = sio_read_complete;
 		sio->pages = 0;
+		sio->len = 0;
 	}
 	sio->bvec[sio->pages].bv_page = page;
-	sio->bvec[sio->pages].bv_len = PAGE_SIZE;
+	sio->bvec[sio->pages].bv_len = thp_size(page);
 	sio->bvec[sio->pages].bv_offset = 0;
+	sio->len += thp_size(page);
 	sio->pages += 1;
 	if (sio->pages == ARRAY_SIZE(sio->bvec) || !plug) {
 		swap_read_unplug(sio);
@@ -521,8 +525,7 @@ void __swap_read_unplug(struct swap_iocb *sio)
 	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
 	int ret;
 
-	iov_iter_bvec(&from, READ, sio->bvec, sio->pages,
-		      PAGE_SIZE * sio->pages);
+	iov_iter_bvec(&from, READ, sio->bvec, sio->pages, sio->len);
 	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
 	if (ret != -EIOCBQUEUED)
 		sio_read_complete(&sio->iocb, ret);


