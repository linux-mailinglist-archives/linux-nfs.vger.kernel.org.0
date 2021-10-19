Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA17433036
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 09:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhJSH4v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhJSH4u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 03:56:50 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675CFC06161C;
        Tue, 19 Oct 2021 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zwsoBId8IcnSgwMOFnvrbUriZK7O2i5DeoGRxyH3eME=; b=dvFnBpMjPHZhbrQJ4nOP29ex+P
        vbzm6itDON3P7R73QZ6m9rN5Zyf7y/7e35NU8Np0oim0ugRhqqFXXyQC3ILP1NI+UG5vUoevD3+V5
        7Z3iOXkOElIO+ExsKbY36heqf5qeXm0u6ma3nHsj7oViRyLU6nCmf9gbUfDcZA4GPbYfI7Qpcfydp
        yHOqZ84RL5v3jpOdxWu79dpVf9v9JOatJet+tbov8Z7VskuaBFZg+EWByf20b8pEi4D1X51UHbOOi
        jDghPrx1yIlmsi8/YIajvbwIEdidiUGxGcnb2kiwIpHNO5yORRagScouxBl9AtkCs+fHB6gRNaHd+
        p0NX+jpw==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjxE-000TB5-8e; Tue, 19 Oct 2021 07:54:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/7] block: remove the initialize_rq_fn blk_mq_ops method
Date:   Tue, 19 Oct 2021 09:54:17 +0200
Message-Id: <20211019075418.2332481-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019075418.2332481-1-hch@lst.de>
References: <20211019075418.2332481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Entirely unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-core.c       | 9 +--------
 include/linux/blk-mq.h | 5 -----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0c2e11411d03..52a460d0aeb2a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -606,16 +606,9 @@ EXPORT_SYMBOL(blk_get_queue);
 struct request *blk_get_request(struct request_queue *q, unsigned int op,
 				blk_mq_req_flags_t flags)
 {
-	struct request *req;
-
 	WARN_ON_ONCE(op & REQ_NOWAIT);
 	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PM));
-
-	req = blk_mq_alloc_request(q, op, flags);
-	if (!IS_ERR(req) && q->mq_ops->initialize_rq_fn)
-		q->mq_ops->initialize_rq_fn(req);
-
-	return req;
+	return blk_mq_alloc_request(q, op, flags);
 }
 EXPORT_SYMBOL(blk_get_request);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 656fe34bdb6cd..649be3f21d740 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -565,11 +565,6 @@ struct blk_mq_ops {
 	void (*exit_request)(struct blk_mq_tag_set *set, struct request *,
 			     unsigned int);
 
-	/**
-	 * @initialize_rq_fn: Called from inside blk_get_request().
-	 */
-	void (*initialize_rq_fn)(struct request *rq);
-
 	/**
 	 * @cleanup_rq: Called before freeing one request which isn't completed
 	 * yet, and usually for freeing the driver private data.
-- 
2.30.2

