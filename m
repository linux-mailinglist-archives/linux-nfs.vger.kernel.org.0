Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1958DF50
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 20:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbiHISpJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 14:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344522AbiHISo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 14:44:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9B2ED4A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 11:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3A62B81711
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 18:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CE6C433D7
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660069164;
        bh=Or3nf67bzcBAEODBENzEqKQXEjcAgwia8Cdn9pnC2xo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Liu0+M09yX1s/q06YuvekHy0CAXfO1q30CHidQz8qK6z2aDA7cDtK1JHVOYvLkGPk
         A1OUQkOdeLBVzY+2ITneoxShl2elKBl7KxZy6aDBQA45YZlYi16Wi+/D3iKPax71Ws
         PHu+zmYeMrWhUo3Hvf7DT/vSFUj7666IxL1qJJzGh0bsBoMvFYWfuNgwxuWf8hx6cr
         YeNEYGhTCPCholGiXGhm7IpBBmGoB0tmjQFPOAL8JfhmdgqRMVyv4SML1XnXzqsb9l
         oKU+1+uv0/wEA7yCMD5kzBi6VA2cN/mpMgNSpMxajsIs8KfGt8+uouo3LbpLz9xJuQ
         ggvtjUQcowufg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Improve readpage/writepage tracing
Date:   Tue,  9 Aug 2022 14:13:17 -0400
Message-Id: <20220809181317.20348-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809181317.20348-2-trondmy@kernel.org>
References: <20220809181317.20348-1-trondmy@kernel.org>
 <20220809181317.20348-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Switch formatting to better match that used by other NFS tracepoints.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8e87cf8e5e78..8c6cc58679ff 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1137,7 +1137,7 @@ TRACE_EVENT(nfs_readpage_done,
 			__field(u32, arg_count)
 			__field(u32, res_count)
 			__field(bool, eof)
-			__field(int, status)
+			__field(int, error)
 		),
 
 		TP_fast_assign(
@@ -1146,7 +1146,7 @@ TRACE_EVENT(nfs_readpage_done,
 			const struct nfs_fh *fh = hdr->args.fh ?
 						  hdr->args.fh : &nfsi->fh;
 
-			__entry->status = task->tk_status;
+			__entry->error = task->tk_status;
 			__entry->offset = hdr->args.offset;
 			__entry->arg_count = hdr->args.count;
 			__entry->res_count = hdr->res.count;
@@ -1157,14 +1157,13 @@ TRACE_EVENT(nfs_readpage_done,
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%u res=%u status=%d%s",
+			"error=%d fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld count=%u res=%u%s", __entry->error,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->arg_count,
-			__entry->res_count, __entry->status,
-			__entry->eof ? " eof" : ""
+			__entry->res_count, __entry->eof ? " eof" : ""
 		)
 );
 
@@ -1184,7 +1183,7 @@ TRACE_EVENT(nfs_readpage_short,
 			__field(u32, arg_count)
 			__field(u32, res_count)
 			__field(bool, eof)
-			__field(int, status)
+			__field(int, error)
 		),
 
 		TP_fast_assign(
@@ -1193,7 +1192,7 @@ TRACE_EVENT(nfs_readpage_short,
 			const struct nfs_fh *fh = hdr->args.fh ?
 						  hdr->args.fh : &nfsi->fh;
 
-			__entry->status = task->tk_status;
+			__entry->error = task->tk_status;
 			__entry->offset = hdr->args.offset;
 			__entry->arg_count = hdr->args.count;
 			__entry->res_count = hdr->res.count;
@@ -1204,14 +1203,13 @@ TRACE_EVENT(nfs_readpage_short,
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%u res=%u status=%d%s",
+			"error=%d fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld count=%u res=%u%s", __entry->error,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->arg_count,
-			__entry->res_count, __entry->status,
-			__entry->eof ? " eof" : ""
+			__entry->res_count, __entry->eof ? " eof" : ""
 		)
 );
 
@@ -1323,7 +1321,7 @@ TRACE_EVENT(nfs_pgio_error,
 		__field(u32, arg_count)
 		__field(u32, res_count)
 		__field(loff_t, pos)
-		__field(int, status)
+		__field(int, error)
 	),
 
 	TP_fast_assign(
@@ -1332,7 +1330,7 @@ TRACE_EVENT(nfs_pgio_error,
 		const struct nfs_fh *fh = hdr->args.fh ?
 					  hdr->args.fh : &nfsi->fh;
 
-		__entry->status = error;
+		__entry->error = error;
 		__entry->offset = hdr->args.offset;
 		__entry->arg_count = hdr->args.count;
 		__entry->res_count = hdr->res.count;
@@ -1341,12 +1339,12 @@ TRACE_EVENT(nfs_pgio_error,
 		__entry->fhandle = nfs_fhandle_hash(fh);
 	),
 
-	TP_printk("fileid=%02x:%02x:%llu fhandle=0x%08x "
-		  "offset=%lld count=%u res=%u pos=%llu status=%d",
+	TP_printk("error=%d fileid=%02x:%02x:%llu fhandle=0x%08x "
+		  "offset=%lld count=%u res=%u pos=%llu", __entry->error,
 		MAJOR(__entry->dev), MINOR(__entry->dev),
 		(unsigned long long)__entry->fileid, __entry->fhandle,
 		(long long)__entry->offset, __entry->arg_count, __entry->res_count,
-		__entry->pos, __entry->status
+		__entry->pos
 	)
 );
 
@@ -1406,7 +1404,7 @@ TRACE_EVENT(nfs_writeback_done,
 			__field(loff_t, offset)
 			__field(u32, arg_count)
 			__field(u32, res_count)
-			__field(int, status)
+			__field(int, error)
 			__field(unsigned long, stable)
 			__array(char, verifier, NFS4_VERIFIER_SIZE)
 		),
@@ -1418,7 +1416,7 @@ TRACE_EVENT(nfs_writeback_done,
 						  hdr->args.fh : &nfsi->fh;
 			const struct nfs_writeverf *verf = hdr->res.verf;
 
-			__entry->status = task->tk_status;
+			__entry->error = task->tk_status;
 			__entry->offset = hdr->args.offset;
 			__entry->arg_count = hdr->args.count;
 			__entry->res_count = hdr->res.count;
@@ -1432,14 +1430,14 @@ TRACE_EVENT(nfs_writeback_done,
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%u res=%u status=%d stable=%s "
-			"verifier=%s",
+			"error=%d fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld count=%u res=%u stable=%s "
+			"verifier=%s", __entry->error,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->arg_count,
-			__entry->res_count, __entry->status,
+			__entry->res_count,
 			show_nfs_stable_how(__entry->stable),
 			show_nfs4_verifier(__entry->verifier)
 		)
@@ -1547,7 +1545,7 @@ TRACE_EVENT(nfs_commit_done,
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(loff_t, offset)
-			__field(int, status)
+			__field(int, error)
 			__field(unsigned long, stable)
 			__array(char, verifier, NFS4_VERIFIER_SIZE)
 		),
@@ -1559,7 +1557,7 @@ TRACE_EVENT(nfs_commit_done,
 						  data->args.fh : &nfsi->fh;
 			const struct nfs_writeverf *verf = data->res.verf;
 
-			__entry->status = task->tk_status;
+			__entry->error = task->tk_status;
 			__entry->offset = data->args.offset;
 			__entry->stable = verf->committed;
 			memcpy(__entry->verifier,
@@ -1571,12 +1569,12 @@ TRACE_EVENT(nfs_commit_done,
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld status=%d stable=%s verifier=%s",
+			"error=%d fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld stable=%s verifier=%s", __entry->error,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			(long long)__entry->offset, __entry->status,
+			(long long)__entry->offset,
 			show_nfs_stable_how(__entry->stable),
 			show_nfs4_verifier(__entry->verifier)
 		)
-- 
2.37.1

