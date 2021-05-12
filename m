Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FFB37CAFE
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbhELQd3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239292AbhELQHt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:07:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 241486195D;
        Wed, 12 May 2021 15:37:14 +0000 (UTC)
Subject: [PATCH v2 21/25] NFSD: Add an nfsd_cb_offload tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:37:13 -0400
Message-ID: <162083383324.3108.10588134404860505853.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record the arguments of CB_OFFLOAD callbacks so we can better
observe asynchronous copy-offload behavior. For example:

            nfsd-995   [008]  7721.934222: nfsd_cb_offload:      addr=192.168.2.51:0 client 6092a47c:35a43fc1 fh_hash=0x8739113a

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <kolga@netapp.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c |    1 +
 fs/nfsd/trace.h    |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f4ce93d7f26e..2ce7cb90a941 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1497,6 +1497,7 @@ static int nfsd4_do_async_copy(void *data)
 	memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
 	nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
 			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
+	trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid, &copy->fh);
 	nfsd4_run_cb(&cb_copy->cp_cb);
 out:
 	if (!copy->cp_intra)
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 9db47d0dd0d9..002623282e93 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1050,6 +1050,36 @@ TRACE_EVENT(nfsd_cb_notify_lock,
 		__entry->fh_hash)
 );
 
+TRACE_EVENT(nfsd_cb_offload,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		const stateid_t *stp,
+		const struct knfsd_fh *fh
+	),
+	TP_ARGS(clp, stp, fh),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+		__field(u32, fh_hash)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+		__entry->fh_hash = knfsd_fh_hash(fh);
+		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x stateid %08x:%08x fh_hash=0x%08x",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation,
+		__entry->fh_hash)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


