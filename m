Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7C61897D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 21:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKCUWy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 16:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKCUWv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 16:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112341F2D2
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 13:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B4361F3E
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 20:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E00C433D6
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 20:22:48 +0000 (UTC)
Subject: [PATCH v1 1/2] NFSD: Add an nfsd_file_fsync tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Nov 2022 16:22:48 -0400
Message-ID: <166750696798.1646.13192363976207504637.stgit@klimt.1015granger.net>
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

Add a tracepoint to capture the number of filecache-triggered fsync
calls and which files needed it. Also, record when an fsync might
trigger a write verifier reset.

Examples:

<...>-97    [007]   262.505611: nfsd_file_free:       inode=0xffff888171e08140 ref=0 flags=GC may=WRITE nf_file=0xffff8881373d2400
<...>-97    [007]   262.505612: nfsd_file_fsync:      inode=0xffff888171e08140 ref=0 flags=GC may=WRITE nf_file=0xffff8881373d2400 ret=0
<...>-97    [007]   262.505623: nfsd_file_free:       inode=0xffff888171e08dc0 ref=0 flags=GC may=WRITE nf_file=0xffff8881373d1e00
<...>-97    [007]   262.505624: nfsd_file_fsync:      inode=0xffff888171e08dc0 ref=0 flags=GC may=WRITE nf_file=0xffff8881373d1e00 ret=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    5 ++++-
 fs/nfsd/trace.h     |   31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 19af18d386a2..cf1a8f1d1349 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -334,10 +334,13 @@ static void
 nfsd_file_fsync(struct nfsd_file *nf)
 {
 	struct file *file = nf->nf_file;
+	int ret;
 
 	if (!file || !(file->f_mode & FMODE_WRITE))
 		return;
-	if (vfs_fsync(file, 1) != 0)
+	ret = vfs_fsync(file, 1);
+	trace_nfsd_file_fsync(nf, ret);
+	if (ret)
 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 736a99448d66..e41007807b7e 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1238,6 +1238,37 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
 
+TRACE_EVENT(nfsd_file_fsync,
+	TP_PROTO(
+		const struct nfsd_file *nf,
+		int ret
+	),
+	TP_ARGS(nf,ret),
+	TP_STRUCT__entry(
+		__field(void *, nf_inode)
+		__field(int, nf_ref)
+		__field(int, ret)
+		__field(unsigned long, nf_flags)
+		__field(unsigned char, nf_may)
+		__field(struct file *, nf_file)
+	),
+	TP_fast_assign(
+		__entry->nf_inode = nf->nf_inode;
+		__entry->nf_ref = refcount_read(&nf->nf_ref);
+		__entry->ret = ret;
+		__entry->nf_flags = nf->nf_flags;
+		__entry->nf_may = nf->nf_may;
+		__entry->nf_file = nf->nf_file;
+	),
+	TP_printk("inode=%p ref=%d flags=%s may=%s nf_file=%p ret=%d",
+		__entry->nf_inode,
+		__entry->nf_ref,
+		show_nf_flags(__entry->nf_flags),
+		show_nfsd_may_flags(__entry->nf_may),
+		__entry->nf_file, __entry->ret
+	)
+);
+
 #include "cache.h"
 
 TRACE_DEFINE_ENUM(RC_DROPIT);


