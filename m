Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9009558C9C8
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Aug 2022 15:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbiHHNwv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbiHHNwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 09:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D60BE18
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 06:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D0F60B37
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB80C433D6
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:52:49 +0000 (UTC)
Subject: [PATCH v3 3/7] NFSD: Trace NFSv4 COMPOUND tags
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 08 Aug 2022 09:52:48 -0400
Message-ID: <165996676808.2637.9770513652557583090.stgit@manet.1015granger.net>
In-Reply-To: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
References: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Linux NFSv4 client implementation does not use COMPOUND tags,
but the Solaris and MacOS implementations do, and so does pynfs.
Record these eye-catchers in the server's trace buffer to annotate
client requests while troubleshooting.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/trace.h    |   21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3895eb52d2b1..e622e1c5a8e1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2678,7 +2678,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 	rqstp->rq_lease_breaker = (void **)&cstate->clp;
 
-	trace_nfsd_compound(rqstp, args->opcnt);
+	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
 		op = &args->ops[resp->opcnt++];
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b6f3c1366a82..c5f3b5740bbf 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -84,19 +84,26 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
 
 TRACE_EVENT(nfsd_compound,
-	TP_PROTO(const struct svc_rqst *rqst,
-		 u32 args_opcnt),
-	TP_ARGS(rqst, args_opcnt),
+	TP_PROTO(
+		const struct svc_rqst *rqst,
+		const char *tag,
+		u32 taglen,
+		u32 opcnt
+	),
+	TP_ARGS(rqst, tag, taglen, opcnt),
 	TP_STRUCT__entry(
 		__field(u32, xid)
-		__field(u32, args_opcnt)
+		__field(u32, opcnt)
+		__string_len(tag, tag, taglen)
 	),
 	TP_fast_assign(
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
-		__entry->args_opcnt = args_opcnt;
+		__entry->opcnt = opcnt;
+		__assign_str_len(tag, tag, taglen);
 	),
-	TP_printk("xid=0x%08x opcnt=%u",
-		__entry->xid, __entry->args_opcnt)
+	TP_printk("xid=0x%08x opcnt=%u tag=%s",
+		__entry->xid, __entry->opcnt, __get_str(tag)
+	)
 )
 
 TRACE_EVENT(nfsd_compound_status,


