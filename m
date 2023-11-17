Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9257EF1AE
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 12:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbjKQLZ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 06:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbjKQLZZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 06:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC1AA6
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 03:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700220320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmxcxjCyX6EuIuA8vnWgEiyczIWN1WCsXiLjcHiiB/c=;
        b=VQkN6WDqNtcOmddnkhIQm5ONnzLQ8+BIlG7TvnAZdA53kkLdwswywJ9MqfqssfoVMPYld2
        FpBFfNZIzHRuV7YdYnWmd7TE4j0TEWE+xOM3t4r/0dD7Ah06gtS9FvxFckJZw+on4RMCx6
        F5lN6cvTNUodi4wieva3QbEqIt6IExk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-fnJpsfd5PcuVzx8h0e4HtA-1; Fri, 17 Nov 2023 06:25:17 -0500
X-MC-Unique: fnJpsfd5PcuVzx8h0e4HtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FFF283BA86;
        Fri, 17 Nov 2023 11:25:17 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8741F2026D4C;
        Fri, 17 Nov 2023 11:25:16 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFS: drop unused nfs_direct_req bytes_left
Date:   Fri, 17 Nov 2023 06:25:14 -0500
Message-ID: <0bdf152bc69f7dcf91c9c70ffcbab92ac03682f0.1700220277.git.bcodding@redhat.com>
In-Reply-To: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700220277.git.bcodding@redhat.com>
References: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700220277.git.bcodding@redhat.com>
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

Now that we're calculating how large a remaining IO should be based
on the current request's offset, we no longer need to track bytes_left on
each struct nfs_direct_req.  Drop the field, and clean up the direct
request tracepoints.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/direct.c   | 6 ++----
 fs/nfs/internal.h | 1 -
 fs/nfs/nfstrace.h | 6 ++----
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 5918c67dae0d..c03926a1cc73 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -369,7 +369,6 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			bytes -= req_len;
 			requested_bytes += req_len;
 			pos += req_len;
-			dreq->bytes_left -= req_len;
 		}
 		nfs_direct_release_pages(pagevec, npages);
 		kvfree(pagevec);
@@ -441,7 +440,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 		goto out;
 
 	dreq->inode = inode;
-	dreq->bytes_left = dreq->max_count = count;
+	dreq->max_count = count;
 	dreq->io_start = iocb->ki_pos;
 	dreq->ctx = get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
 	l_ctx = nfs_get_lock_context(dreq->ctx);
@@ -874,7 +873,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			bytes -= req_len;
 			requested_bytes += req_len;
 			pos += req_len;
-			dreq->bytes_left -= req_len;
 
 			if (defer) {
 				nfs_mark_request_commit(req, NULL, &cinfo, 0);
@@ -981,7 +979,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 		goto out;
 
 	dreq->inode = inode;
-	dreq->bytes_left = dreq->max_count = count;
+	dreq->max_count = count;
 	dreq->io_start = pos;
 	dreq->ctx = get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
 	l_ctx = nfs_get_lock_context(dreq->ctx);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index b1fa81c9dff6..e3722ce6722e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -936,7 +936,6 @@ struct nfs_direct_req {
 	loff_t			io_start;	/* Start offset for I/O */
 	ssize_t			count,		/* bytes actually processed */
 				max_count,	/* max expected count */
-				bytes_left,	/* bytes left to be sent */
 				error;		/* any reported error */
 	struct completion	completion;	/* wait for i/o completion */
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 4e90ca531176..03cbc3893cef 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1539,7 +1539,6 @@ DECLARE_EVENT_CLASS(nfs_direct_req_class,
 			__field(u32, fhandle)
 			__field(loff_t, offset)
 			__field(ssize_t, count)
-			__field(ssize_t, bytes_left)
 			__field(ssize_t, error)
 			__field(int, flags)
 		),
@@ -1554,19 +1553,18 @@ DECLARE_EVENT_CLASS(nfs_direct_req_class,
 			__entry->fhandle = nfs_fhandle_hash(fh);
 			__entry->offset = dreq->io_start;
 			__entry->count = dreq->count;
-			__entry->bytes_left = dreq->bytes_left;
 			__entry->error = dreq->error;
 			__entry->flags = dreq->flags;
 		),
 
 		TP_printk(
 			"error=%zd fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%zd bytes_left=%zd flags=%s",
+			"offset=%lld count=%zd flags=%s",
 			__entry->error, MAJOR(__entry->dev),
 			MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle, __entry->offset,
-			__entry->count, __entry->bytes_left,
+			__entry->count,
 			nfs_show_direct_req_flags(__entry->flags)
 		)
 );
-- 
2.41.0

