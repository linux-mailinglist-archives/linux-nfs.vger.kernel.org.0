Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171284AB485
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 07:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbiBGGPv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 01:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352095AbiBGEtQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 23:49:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A94C043181;
        Sun,  6 Feb 2022 20:49:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1FD3210E8;
        Mon,  7 Feb 2022 04:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644209353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RjmMA1NrNB1dcX8VlrCIeURT/zjbUyKgTSkkvTTrZ4=;
        b=eH4GEA19qQ07ImRUOY2A8Sm2l4231phSU/9mIfpFmNGSBtN/OXjXOLrrPmN7/7gZBO9LOU
        znkMvj6r5hd7Bp8KTHQm/KjMzjhkUiPV9Q3+bx8G1KBxzb65nFaj4VRcI6tZcCQtbMR76J
        8TPio5UkYLoXB+d/+vSet5L5w5cH1FU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644209353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RjmMA1NrNB1dcX8VlrCIeURT/zjbUyKgTSkkvTTrZ4=;
        b=gg+Xt3GS+NULgkfMEQ5/eDYBs276HjW/e20Y9e5NxQtC0tLeRLB/8gCLHZiJqdYdH5eMew
        OACLY5ZojWUu/3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA35D1330E;
        Mon,  7 Feb 2022 04:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PnInKcakAGKgNQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 04:49:10 +0000
Subject: [PATCH 21/21] NFS: swap-out must always use STABLE writes.
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Feb 2022 15:46:01 +1100
Message-ID: <164420916125.29374.15563574398247024921.stgit@noble.brown>
In-Reply-To: <164420889455.29374.17958998143835612560.stgit@noble.brown>
References: <164420889455.29374.17958998143835612560.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The commit handling code is not safe against memory-pressure deadlocks
when writing to swap.  In particular, nfs_commitdata_alloc() blocks
indefinitely waiting for memory, and this can consume all available
workqueue threads.

swap-out most likely uses STABLE writes anyway as COND_STABLE indicates
that a stable write should be used if the write fits in a single
request, and it normally does.  However if we ever swap with a small
wsize, or gather unusually large numbers of pages for a single write,
this might change.

For safety, make it explicit in the code that direct writes used for swap
must always use FLUSH_STABLE.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/direct.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index c5c53219beeb..4eb2a8380a28 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -791,7 +791,7 @@ static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops = {
  */
 static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 					       struct iov_iter *iter,
-					       loff_t pos)
+					       loff_t pos, int ioflags)
 {
 	struct nfs_pageio_descriptor desc;
 	struct inode *inode = dreq->inode;
@@ -799,7 +799,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	size_t requested_bytes = 0;
 	size_t wsize = max_t(size_t, NFS_SERVER(inode)->wsize, PAGE_SIZE);
 
-	nfs_pageio_init_write(&desc, inode, FLUSH_COND_STABLE, false,
+	nfs_pageio_init_write(&desc, inode, ioflags, false,
 			      &nfs_direct_write_completion_ops);
 	desc.pg_dreq = dreq;
 	get_dreq(dreq);
@@ -945,11 +945,13 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 	pnfs_init_ds_commit_info_ops(&dreq->ds_cinfo, inode);
 
 	if (swap) {
-		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
+		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos,
+							    FLUSH_STABLE);
 	} else {
 		nfs_start_io_direct(inode);
 
-		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
+		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos,
+							    FLUSH_COND_STABLE);
 
 		if (mapping->nrpages) {
 			invalidate_inode_pages2_range(mapping,


