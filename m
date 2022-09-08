Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617225B291B
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIHWOE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 18:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiIHWOC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 18:14:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F08E1098FD
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 15:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FF91B822A4
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B5DC433D6
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:13:55 +0000 (UTC)
Subject: [PATCH v4 3/8] NFSD: Add tracepoints to report NFSv4 callback
 completions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 18:13:54 -0400
Message-ID: <166267523469.1842.1189895674276197366.stgit@manet.1015granger.net>
In-Reply-To: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
References: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
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

Wireshark has always been lousy about dissecting NFSv4 callbacks,
especially NFSv4.0 backchannel requests. Add tracepoints so we
can surgically capture these events in the trace log.

Tracepoints are time-stamped and ordered so that we can now observe
the timing relationship between a CB_RECALL Reply and the client's
DELEGRETURN Call. Example:

            nfsd-1153  [002]   211.986391: nfsd_cb_recall:       addr=192.168.1.67:45767 client 62ea82e4:fee7492a stateid 00000003:00000001

            nfsd-1153  [002]   212.095634: nfsd_compound:        xid=0x0000002c opcnt=2
            nfsd-1153  [002]   212.095647: nfsd_compound_status: op=1/2 OP_PUTFH status=0
            nfsd-1153  [002]   212.095658: nfsd_file_put:        hash=0xf72 inode=0xffff9291148c7410 ref=3 flags=HASHED|REFERENCED may=READ file=0xffff929103b3ea00
            nfsd-1153  [002]   212.095661: nfsd_compound_status: op=2/2 OP_DELEGRETURN status=0
   kworker/u25:8-148   [002]   212.096713: nfsd_cb_recall_done:  client 62ea82e4:fee7492a stateid 00000003:00000001 status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4layouts.c |    2 +-
 fs/nfsd/nfs4proc.c    |    4 ++++
 fs/nfsd/nfs4state.c   |    4 ++++
 fs/nfsd/trace.h       |   39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 2c05692a9abf..3564d1c6f610 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -658,7 +658,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 	ktime_t now, cutoff;
 	const struct nfsd4_layout_ops *ops;
 
-
+	trace_nfsd_cb_layout_done(&ls->ls_stid.sc_stateid, task);
 	switch (task->tk_status) {
 	case 0:
 	case -NFS4ERR_DELAY:
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d43beb732987..2a193e84e422 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1621,6 +1621,10 @@ static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
 				 struct rpc_task *task)
 {
+	struct nfsd4_cb_offload *cbo =
+		container_of(cb, struct nfsd4_cb_offload, co_cb);
+
+	trace_nfsd_cb_offload_done(&cbo->co_res.cb_stateid, task);
 	return 1;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c5d199d7e6b4..561f3556b1d2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -357,6 +357,8 @@ nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
 static int
 nfsd4_cb_notify_lock_done(struct nfsd4_callback *cb, struct rpc_task *task)
 {
+	trace_nfsd_cb_notify_lock_done(&zero_stateid, task);
+
 	/*
 	 * Since this is just an optimization, we don't try very hard if it
 	 * turns out not to succeed. We'll requeue it on NFS4ERR_DELAY, and
@@ -4743,6 +4745,8 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
 
+	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
+
 	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
 	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
 	        return 1;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 0c35a1a844e6..ec8e08315779 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1448,6 +1448,45 @@ TRACE_EVENT(nfsd_cb_offload,
 		__entry->fh_hash, __entry->count, __entry->status)
 );
 
+DECLARE_EVENT_CLASS(nfsd_cb_done_class,
+	TP_PROTO(
+		const stateid_t *stp,
+		const struct rpc_task *task
+	),
+	TP_ARGS(stp, task),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+		__field(int, status)
+	),
+	TP_fast_assign(
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+		__entry->status = task->tk_status;
+	),
+	TP_printk("client %08x:%08x stateid %08x:%08x status=%d",
+		__entry->cl_boot, __entry->cl_id, __entry->si_id,
+		__entry->si_generation, __entry->status
+	)
+);
+
+#define DEFINE_NFSD_CB_DONE_EVENT(name)			\
+DEFINE_EVENT(nfsd_cb_done_class, name,			\
+	TP_PROTO(					\
+		const stateid_t *stp,			\
+		const struct rpc_task *task		\
+	),						\
+	TP_ARGS(stp, task))
+
+DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_recall_done);
+DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_notify_lock_done);
+DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_layout_done);
+DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_offload_done);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


