Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B242A3DE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 14:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhJLMJN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 08:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhJLMJM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 08:09:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47606C061570;
        Tue, 12 Oct 2021 05:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ds1TpatCKmlIoP2vvOOOFQ9Th//N+SKm31s/+8rpr3E=; b=BH3qElzXEx1tRJTllHa9mV5zu8
        1SEeR3ib9NIoBjkv7S0SS2R9Ef55OfgIG9Y0zOVqfVdie7hHGlQFFS7FENtRgE+sqxjk8iDBH+P+M
        34o7ByhXO2461mQWohsf0GK7z9aAQpt6VAvqLuRBe54S7rA8JyKUqfmpRcKYxQAaZUdJTA6C4sqHG
        w5THzM2mwScZJFZI+jF4LaP2SI4aoU8StnKS8E41viQF+ovrE4+6qD9iIvT9+On5cU7xuwkhOjsG3
        8v50BAztY+J8ahIKNM+4O2KdSooRWi+eTqxWc5+/iDUCDVG4uRWu8EnxzXeGEBD9pj8rOJ/E5lHrC
        OsuhFA+w==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maGXQ-006ToD-3t; Tue, 12 Oct 2021 12:06:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 1/7] block: add a ->get_unique_id method
Date:   Tue, 12 Oct 2021 14:04:39 +0200
Message-Id: <20211012120445.861860-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012120445.861860-1-hch@lst.de>
References: <20211012120445.861860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a method to query query uniqueue IDs from block devices.  It will be
used to remove code that deeply pokes into SCSI internals in the NFS
server.  The implementation in the sd driver itself can also be much
nicer as it can use the cached VPD page instead of always sending a
command as the current NFS code does.

For now the interface is kept very minimal but could be easily
extended when other users like a block-layer sysfs interface for
uniquue IDs shows up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17705c970d7e1..81f94a7c54521 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1188,6 +1188,7 @@ struct block_device_operations {
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
+	int (*get_unique_id)(struct gendisk *disk, u8 id[16], u8 id_type);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.30.2

