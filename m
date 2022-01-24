Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA64977F4
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbiAXDzZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:55:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47144 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiAXDzZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:55:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 314321F3A0;
        Mon, 24 Jan 2022 03:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKekh97n0i6AmpeVDE22svCq5nXmamLchP56LCBUk8Y=;
        b=cghIZ+kikeLgdtBbznxHOS+3WEdmBrO58IXPnQI2796gYuTKI0vwTkL6GMNqI2mYUIIeU6
        ReNJlFXbDr6Eb54AwmHUbjX4yrIkQyU1S2kMSlYL4L6gRIdVymk3q/9Cqx7AimvDYswQYI
        nxCqilDbnGhP6QAEsarThDH0Sw84OTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996524;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKekh97n0i6AmpeVDE22svCq5nXmamLchP56LCBUk8Y=;
        b=pyWYRf1SlHJfVNvJ5zVKWKuw4WN+JbjrZRekAoxXuyjygtU2r+5TTggEeP2gXDcVFJ3xIg
        XpH/SY4pzZRfnFAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E76D13305;
        Mon, 24 Jan 2022 03:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g+iONygj7mFHRgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:55:20 +0000
Subject: [PATCH 22/23] NFS: swap-out must always use STABLE writes.
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
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299611287.26253.13462969110743208198.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
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
index 43a956d7fd62..29c007b2a17a 100644
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
@@ -905,6 +905,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct nfs_direct_req *dreq;
 	struct nfs_lock_context *l_ctx;
 	loff_t pos, end;
+	int ioflags = swap ? FLUSH_COND_STABLE : FLUSH_STABLE;
 
 	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
@@ -947,7 +948,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 	if (!swap)
 		nfs_start_io_direct(inode);
 
-	requested = nfs_direct_write_schedule_iovec(dreq, iter, pos);
+	requested = nfs_direct_write_schedule_iovec(dreq, iter, pos, ioflags);
 
 	if (mapping->nrpages) {
 		invalidate_inode_pages2_range(mapping,


