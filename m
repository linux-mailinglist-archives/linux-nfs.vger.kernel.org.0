Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3861897E
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 21:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiKCUW5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKCUW5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 16:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1511F2DC
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 13:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF79B61FC4
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 20:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D641C433D6
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 20:22:55 +0000 (UTC)
Subject: [PATCH v1 2/2] NFSD: Re-arrange file_close_inode tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Nov 2022 16:22:54 -0400
Message-ID: <166750697425.1646.11770177003223505657.stgit@klimt.1015granger.net>
In-Reply-To: <166750689663.1646.10478083854261038468.stgit@klimt.1015granger.net>
References: <166750689663.1646.10478083854261038468.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that we have trace_nfsd_file_closing, all we really need to
capture is when an external caller has requested a close/sync.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |   17 ++++++-----------
 fs/nfsd/trace.h     |   45 ++++++++++++++++-----------------------------
 2 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index cf1a8f1d1349..7be62af4bfb7 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -706,14 +706,13 @@ static struct shrinker	nfsd_file_shrinker = {
  * The nfsd_file objects on the list will be unhashed, and each will have a
  * reference taken.
  */
-static unsigned int
+static void
 __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
 {
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
 		.inode	= inode,
 	};
-	unsigned int count = 0;
 	struct nfsd_file *nf;
 
 	rcu_read_lock();
@@ -723,11 +722,9 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
 		if (!nf)
 			break;
 
-		if (nfsd_file_unhash_and_queue(nf, dispose))
-			count++;
+		nfsd_file_unhash_and_queue(nf, dispose);
 	} while (1);
 	rcu_read_unlock();
-	return count;
 }
 
 /**
@@ -742,11 +739,9 @@ static void
 nfsd_file_close_inode(struct inode *inode)
 {
 	struct nfsd_file *nf, *tmp;
-	unsigned int count;
 	LIST_HEAD(dispose);
 
-	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode(inode, count);
+	__nfsd_file_close_inode(inode, &dispose);
 	list_for_each_entry_safe(nf, tmp, &dispose, nf_lru) {
 		trace_nfsd_file_closing(nf);
 		if (!refcount_dec_and_test(&nf->nf_ref))
@@ -765,11 +760,11 @@ void
 nfsd_file_close_inode_sync(struct inode *inode)
 {
 	struct nfsd_file *nf;
-	unsigned int count;
 	LIST_HEAD(dispose);
 
-	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode(inode, count);
+	trace_nfsd_file_close(inode);
+
+	__nfsd_file_close_inode(inode, &dispose);
 	while (!list_empty(&dispose)) {
 		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index e41007807b7e..ef01ecd3eec6 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1099,35 +1099,6 @@ TRACE_EVENT(nfsd_file_open,
 		__entry->nf_file)
 )
 
-DECLARE_EVENT_CLASS(nfsd_file_search_class,
-	TP_PROTO(
-		const struct inode *inode,
-		unsigned int count
-	),
-	TP_ARGS(inode, count),
-	TP_STRUCT__entry(
-		__field(const struct inode *, inode)
-		__field(unsigned int, count)
-	),
-	TP_fast_assign(
-		__entry->inode = inode;
-		__entry->count = count;
-	),
-	TP_printk("inode=%p count=%u",
-		__entry->inode, __entry->count)
-);
-
-#define DEFINE_NFSD_FILE_SEARCH_EVENT(name)				\
-DEFINE_EVENT(nfsd_file_search_class, name,				\
-	TP_PROTO(							\
-		const struct inode *inode,				\
-		unsigned int count					\
-	),								\
-	TP_ARGS(inode, count))
-
-DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode_sync);
-DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode);
-
 TRACE_EVENT(nfsd_file_is_cached,
 	TP_PROTO(
 		const struct inode *inode,
@@ -1238,6 +1209,22 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
 
+TRACE_EVENT(nfsd_file_close,
+	TP_PROTO(
+		const struct inode *inode
+	),
+	TP_ARGS(inode),
+	TP_STRUCT__entry(
+		__field(const void *, inode)
+	),
+	TP_fast_assign(
+		__entry->inode = inode;
+	),
+	TP_printk("inode=%p",
+		__entry->inode
+	)
+);
+
 TRACE_EVENT(nfsd_file_fsync,
 	TP_PROTO(
 		const struct nfsd_file *nf,


