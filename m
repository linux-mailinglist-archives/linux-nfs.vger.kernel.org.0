Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22766379319
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhEJPxp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhEJPxp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08C3E615FF;
        Mon, 10 May 2021 15:52:39 +0000 (UTC)
Subject: [PATCH RFC 10/21] NFSD: Replace the nfsd_deleg_break tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:52:39 -0400
Message-ID: <162066195924.94415.4581490923389520515.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Renamed so it can be enabled as a set with the other nfsd_cb_
tracepoints. And, consistent with those tracepoints, report the
address of the client, the client ID the server has given it, and
the state ID being recalled.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    2 +-
 fs/nfsd/trace.h     |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b41ecec15e5b..27768a7ed23b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4620,7 +4620,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
-	trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
+	trace_nfsd_cb_recall(&dp->dl_stid);
 
 	/*
 	 * We don't want the locks code to timeout the lease for us;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 15cacbdac411..13ab373aaa75 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -459,7 +459,6 @@ DEFINE_STATEID_EVENT(layout_recall_release);
 
 DEFINE_STATEID_EVENT(open);
 DEFINE_STATEID_EVENT(deleg_read);
-DEFINE_STATEID_EVENT(deleg_break);
 DEFINE_STATEID_EVENT(deleg_recall);
 
 DECLARE_EVENT_CLASS(nfsd_stateseqid_class,
@@ -978,6 +977,37 @@ TRACE_EVENT(nfsd_cb_done,
 		__entry->status)
 );
 
+TRACE_EVENT(nfsd_cb_recall,
+	TP_PROTO(
+		const struct nfs4_stid *stid
+	),
+	TP_ARGS(stid),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		const stateid_t *stp = &stid->sc_stateid;
+		const struct nfs4_client *clp = stid->sc_client;
+
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+		if (clp)
+			memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+				sizeof(struct sockaddr_in6));
+		else
+			memset(__entry->addr, 0, sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x stateid %08x:%08x",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation)
+);
+
 TRACE_EVENT(nfsd_cb_notify_lock,
 	TP_PROTO(
 		const struct nfs4_lockowner *lo,


