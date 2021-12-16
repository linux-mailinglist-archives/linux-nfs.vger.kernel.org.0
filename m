Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A1F4780FD
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhLPXyh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:54:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56504 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhLPXyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:54:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4E1B1F37F;
        Thu, 16 Dec 2021 23:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UN33ikAoXajq5CI0zBofFyR8XobeBM2LQz3kaqJLOi8=;
        b=MMSyLL6EF220adA5CA7TM22/UFSkJZQp7lQ587G2eUT03U+MWSVZSJyHVvp8XRqgvDsAtw
        XA+OKQsqNAtxoMxbnWkGTNbrzvSlwjaLb3+NhHC8ivAno2ISM0cBHfsW0lUnJ7McAof59g
        VvXnaleXzF5dNuLkqYvN4cgISEnzPDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UN33ikAoXajq5CI0zBofFyR8XobeBM2LQz3kaqJLOi8=;
        b=typf5Kg/zxn17ZRHbU5b5gPIy954GXSE/v+Cgz6k3Ej6zydN26iNuVGaNYCcRxa8wo7Pu+
        3xBdXpDQJ8itDmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6180A13EFD;
        Thu, 16 Dec 2021 23:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0EWWB7jRu2EXXAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:54:32 +0000
Subject: [PATCH 18/18] NFS: swap-out must always use STABLE writes.
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Dec 2021 10:48:23 +1100
Message-ID: <163969850347.20885.5566025433915169963.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
must always use FLUSH_COND_STABLE.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/direct.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index eeff1b4e1a7c..1317465150a6 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -790,7 +790,7 @@ static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops = {
  */
 static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 					       struct iov_iter *iter,
-					       loff_t pos)
+					       loff_t pos, int ioflags)
 {
 	struct nfs_pageio_descriptor desc;
 	struct inode *inode = dreq->inode;
@@ -798,7 +798,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	size_t requested_bytes = 0;
 	size_t wsize = max_t(size_t, NFS_SERVER(inode)->wsize, PAGE_SIZE);
 
-	nfs_pageio_init_write(&desc, inode, FLUSH_COND_STABLE, false,
+	nfs_pageio_init_write(&desc, inode, ioflags, false,
 			      &nfs_direct_write_completion_ops);
 	desc.pg_dreq = dreq;
 	get_dreq(dreq);
@@ -904,6 +904,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct nfs_direct_req *dreq;
 	struct nfs_lock_context *l_ctx;
 	loff_t pos, end;
+	int ioflags = swap ? FLUSH_COND_STABLE : FLUSH_STABLE;
 
 	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
@@ -946,7 +947,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 	if (!swap)
 		nfs_start_io_direct(inode);
 
-	requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
+	requested = nfs_direct_write_schedule_iovec(dreq, iter, pos, ioflags);
 
 	if (mapping->nrpages) {
 		invalidate_inode_pages2_range(mapping,


