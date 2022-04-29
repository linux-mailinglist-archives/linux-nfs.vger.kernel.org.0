Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3F3514E6C
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377330AbiD2O5X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377979AbiD2O5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 10:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BCABF940
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 07:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 032F161F91
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60212C385AF
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:53:57 +0000 (UTC)
Subject: [PATCH 4/6] NFSD: Trace filecache opens
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:53:56 -0400
Message-ID: <165124403642.1060.16894910752694908104.stgit@bazille.1015granger.net>
In-Reply-To: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
References: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
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

Instrument calls to nfsd_open_verified() to get a sense of the
filecache hit rate.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    5 +++--
 fs/nfsd/trace.h     |   28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 24772f246461..a7e3a443a2cb 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -995,10 +995,11 @@ nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nf->nf_mark = nfsd_file_mark_find_or_create(nf);
 	if (nf->nf_mark) {
-		if (open)
+		if (open) {
 			status = nfsd_open_verified(rqstp, fhp, may_flags,
 						    &nf->nf_file);
-		else
+			trace_nfsd_file_open(nf, status);
+		} else
 			status = nfs_ok;
 	} else
 		status = nfserr_jukebox;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 242fa123e0e9..feb6e6f834b6 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -784,6 +784,34 @@ TRACE_EVENT(nfsd_file_acquire,
 			__entry->nf_file, __entry->status)
 );
 
+TRACE_EVENT(nfsd_file_open,
+	TP_PROTO(struct nfsd_file *nf, __be32 status),
+	TP_ARGS(nf, status),
+	TP_STRUCT__entry(
+		__field(unsigned int, nf_hashval)
+		__field(void *, nf_inode)	/* cannot be dereferenced */
+		__field(int, nf_ref)
+		__field(unsigned long, nf_flags)
+		__field(unsigned long, nf_may)
+		__field(void *, nf_file)	/* cannot be dereferenced */
+	),
+	TP_fast_assign(
+		__entry->nf_hashval = nf->nf_hashval;
+		__entry->nf_inode = nf->nf_inode;
+		__entry->nf_ref = refcount_read(&nf->nf_ref);
+		__entry->nf_flags = nf->nf_flags;
+		__entry->nf_may = nf->nf_may;
+		__entry->nf_file = nf->nf_file;
+	),
+	TP_printk("hash=0x%x inode=%p ref=%d flags=%s may=%s file=%p",
+		__entry->nf_hashval,
+		__entry->nf_inode,
+		__entry->nf_ref,
+		show_nf_flags(__entry->nf_flags),
+		show_nfsd_may_flags(__entry->nf_may),
+		__entry->nf_file)
+)
+
 DECLARE_EVENT_CLASS(nfsd_file_search_class,
 	TP_PROTO(struct inode *inode, unsigned int hash, int found),
 	TP_ARGS(inode, hash, found),


