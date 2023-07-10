Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838CE74DC74
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGJR2s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjGJR2q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 13:28:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E27FB6;
        Mon, 10 Jul 2023 10:28:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 266BE6732D; Mon, 10 Jul 2023 19:28:40 +0200 (CEST)
Date:   Mon, 10 Jul 2023 19:28:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: NFS workload leaves nfsd threads in D state
Message-ID: <20230710172839.GA7190@lst.de>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com> <20230710075634.GA30120@lst.de> <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com> <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Only found a virtualized AHCI setup so far without much success.  Can
you try this (from Chengming Zhou) in the meantime?

diff --git a/block/blk-flush.c b/block/blk-flush.c
index dba392cf22bec6..5c392a277b9eb2 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -443,7 +443,7 @@ bool blk_insert_flush(struct request *rq)
 		 * the post flush, and then just pass the command on.
 		 */
 		blk_rq_init_flush(rq);
-		rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
+		rq->flush.seq |= REQ_FSEQ_PREFLUSH;
 		spin_lock_irq(&fq->mq_flush_lock);
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
 		spin_unlock_irq(&fq->mq_flush_lock);
