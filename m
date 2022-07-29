Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A155853EE
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiG2QsB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbiG2Qrq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 12:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE5289A5C
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 09:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB24A61E42
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 16:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1461EC433D7;
        Fri, 29 Jul 2022 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659113237;
        bh=n9HWKM1++3/ZSOAmtfQeTNj5i1yKF+OmvDQ0orfgGDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2Qa7PWQ6pWaCFUi4pcDa2fXTaNlLRi/rkk8LhErg0D4GFPDgmpSjPr6B7ygGONcJ
         en+yn5dYZSTW+3ERvl5Q3YgRQCFcgluRToswxIiDbHz2+h092GVD0pnEOozLNVMvA4
         /y+0emEjv/oPX7tQRtdosUzUbhIIk6TtnJPJCerbNA34NI1RkeU9DWfMgjCZvQ/J0j
         ZPCcKXHOT2Bb96Iu/En8deMwQh+u5LBQwqceIDeat+OXG0x3dlLDZH8xWsI8q9Quva
         jjeohz48uHOFG7LFaRUh0454XYxjsgX3rP5J9iMtE5IoTWJOLfyVXAKWAwWuDT0IXj
         1SPkuVzw1cMgw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] nfsd: print nf pointer in some nfsd_file tracepoints
Date:   Fri, 29 Jul 2022 12:47:14 -0400
Message-Id: <20220729164715.75702-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729164715.75702-1-jlayton@kernel.org>
References: <20220729164715.75702-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 38fb1ca31010..e9c5d0f56977 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -803,19 +803,21 @@ TRACE_EVENT(nfsd_file_alloc,
 	),
 	TP_ARGS(nf),
 	TP_STRUCT__entry(
+		__field(const void *, nf)
 		__field(const void *, nf_inode)
 		__field(unsigned long, nf_flags)
 		__field(unsigned long, nf_may)
 		__field(unsigned int, nf_ref)
 	),
 	TP_fast_assign(
+		__entry->nf = nf;
 		__entry->nf_inode = nf->nf_inode;
 		__entry->nf_flags = nf->nf_flags;
 		__entry->nf_ref = refcount_read(&nf->nf_ref);
 		__entry->nf_may = nf->nf_may;
 	),
-	TP_printk("inode=%p ref=%u flags=%s may=%s",
-		__entry->nf_inode, __entry->nf_ref,
+	TP_printk("nf=%p inode=%p ref=%u flags=%s may=%s",
+		__entry->nf, __entry->nf_inode, __entry->nf_ref,
 		show_nf_flags(__entry->nf_flags),
 		show_nfsd_may_flags(__entry->nf_may)
 	)
@@ -834,6 +836,7 @@ TRACE_EVENT(nfsd_file_acquire,
 
 	TP_STRUCT__entry(
 		__field(u32, xid)
+		__field(const void *, nf)
 		__field(const void *, inode)
 		__field(unsigned long, may_flags)
 		__field(unsigned int, nf_ref)
@@ -845,6 +848,7 @@ TRACE_EVENT(nfsd_file_acquire,
 
 	TP_fast_assign(
 		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->nf = nf;
 		__entry->inode = inode;
 		__entry->may_flags = may_flags;
 		__entry->nf_ref = nf ? refcount_read(&nf->nf_ref) : 0;
@@ -854,8 +858,8 @@ TRACE_EVENT(nfsd_file_acquire,
 		__entry->status = be32_to_cpu(status);
 	),
 
-	TP_printk("xid=0x%x inode=%p may_flags=%s ref=%u nf_flags=%s nf_may=%s nf_file=%p status=%u",
-			__entry->xid, __entry->inode,
+	TP_printk("xid=0x%x nf=%p inode=%p may_flags=%s ref=%u nf_flags=%s nf_may=%s nf_file=%p status=%u",
+			__entry->xid, __entry->nf, __entry->inode,
 			show_nfsd_may_flags(__entry->may_flags),
 			__entry->nf_ref, show_nf_flags(__entry->nf_flags),
 			show_nfsd_may_flags(__entry->nf_may),
@@ -873,6 +877,7 @@ TRACE_EVENT(nfsd_file_create,
 	TP_ARGS(rqstp, may_flags, nf),
 
 	TP_STRUCT__entry(
+		__field(const void *, nf)
 		__field(const void *, nf_inode)
 		__field(const void *, nf_file)
 		__field(unsigned long, may_flags)
@@ -883,6 +888,7 @@ TRACE_EVENT(nfsd_file_create,
 	),
 
 	TP_fast_assign(
+		__entry->nf = nf;
 		__entry->nf_inode = nf->nf_inode;
 		__entry->nf_file = nf->nf_file;
 		__entry->may_flags = may_flags;
@@ -892,8 +898,8 @@ TRACE_EVENT(nfsd_file_create,
 		__entry->xid = be32_to_cpu(rqstp->rq_xid);
 	),
 
-	TP_printk("xid=0x%x inode=%p may_flags=%s ref=%u nf_flags=%s nf_may=%s nf_file=%p",
-		__entry->xid, __entry->nf_inode,
+	TP_printk("xid=0x%x nf=%p inode=%p may_flags=%s ref=%u nf_flags=%s nf_may=%s nf_file=%p",
+		__entry->xid, __entry->nf, __entry->nf_inode,
 		show_nfsd_may_flags(__entry->may_flags),
 		__entry->nf_ref, show_nf_flags(__entry->nf_flags),
 		show_nfsd_may_flags(__entry->nf_may), __entry->nf_file
@@ -1060,19 +1066,21 @@ DECLARE_EVENT_CLASS(nfsd_file_gc_class,
 	),
 	TP_ARGS(nf),
 	TP_STRUCT__entry(
-		__field(void *, nf_inode)
-		__field(void *, nf_file)
+		__field(const void *, nf)
+		__field(const void *, nf_inode)
+		__field(const void *, nf_file)
 		__field(int, nf_ref)
 		__field(unsigned long, nf_flags)
 	),
 	TP_fast_assign(
+		__entry->nf = nf;
 		__entry->nf_inode = nf->nf_inode;
 		__entry->nf_file = nf->nf_file;
 		__entry->nf_ref = refcount_read(&nf->nf_ref);
 		__entry->nf_flags = nf->nf_flags;
 	),
-	TP_printk("inode=%p ref=%d nf_flags=%s nf_file=%p",
-		__entry->nf_inode, __entry->nf_ref,
+	TP_printk("nf=%p inode=%p ref=%d nf_flags=%s nf_file=%p",
+		__entry->nf, __entry->nf_inode, __entry->nf_ref,
 		show_nf_flags(__entry->nf_flags),
 		__entry->nf_file
 	)
-- 
2.37.1

