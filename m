Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58A381148
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhENT61 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhENT61 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:58:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27A2A613DE;
        Fri, 14 May 2021 19:57:15 +0000 (UTC)
Subject: [PATCH v3 20/24] NFSD: Add an nfsd_cb_offload tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:57:14 -0400
Message-ID: <162102223440.10915.12953935731144404054.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record the arguments of CB_OFFLOAD callbacks so we can better
observe asynchronous copy-offload behavior. For example:

nfsd-995   [008]  7721.934222: nfsd_cb_offload:
        addr=192.168.2.51:0 client 6092a47c:35a43fc1 fh_hash=0x8739113a
        count=116528 status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <kolga@netapp.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 ++
 fs/nfsd/trace.h    |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f4ce93d7f26e..426b232ca9fd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1497,6 +1497,8 @@ static int nfsd4_do_async_copy(void *data)
 	memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
 	nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
 			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
+	trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid,
+			      &copy->fh, copy->cp_count, copy->nfserr);
 	nfsd4_run_cb(&cb_copy->cp_cb);
 out:
 	if (!copy->cp_intra)
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 921323f88322..1fb56433043d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1053,6 +1053,42 @@ TRACE_EVENT(nfsd_cb_notify_lock,
 		__entry->fh_hash)
 );
 
+TRACE_EVENT(nfsd_cb_offload,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		const stateid_t *stp,
+		const struct knfsd_fh *fh,
+		u64 count,
+		__be32 status
+	),
+	TP_ARGS(clp, stp, fh, count, status),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+		__field(u32, fh_hash)
+		__field(int, status)
+		__field(u64, count)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+		__entry->fh_hash = knfsd_fh_hash(fh);
+		__entry->status = be32_to_cpu(status);
+		__entry->count = count;
+		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x stateid %08x:%08x fh_hash=0x%08x count=%llu status=%d",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation,
+		__entry->fh_hash, __entry->count, __entry->status)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


