Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63256601282
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJQPLS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJQPLM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 11:11:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A50F2B
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 08:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D5C5B818FE
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 15:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4967BC433C1;
        Mon, 17 Oct 2022 15:03:01 +0000 (UTC)
Subject: [PATCH v3 7/7] NFSD: Trace delegation revocations
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 17 Oct 2022 11:03:00 -0400
Message-ID: <166601898032.1714.6436112092997327373.stgit@manet.1015granger.net>
In-Reply-To: <166601838800.1714.17970169995665888062.stgit@manet.1015granger.net>
References: <166601838800.1714.17970169995665888062.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

Delegation revocation is an exceptional event that is not otherwise
visible externally (eg, no network traffic is emitted). Generate a
trace record when it occurs so that revocation can be observed or
other activity can be triggered. Example:

nfsd-1104  [005]  1912.002544: nfsd_stid_revoke:        client 633c9343:4e82788d stateid 00000003:00000001 ref=2 type=DELEG

Trace infrastructure is provided for subsequent additional tracing
related to nfs4_stid activity.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    2 ++
 fs/nfsd/trace.h     |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9ebf99498647..aaae2e460039 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1401,6 +1401,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	WARN_ON(!list_empty(&dp->dl_recall_lru));
 
+	trace_nfsd_stid_revoke(&dp->dl_stid);
+
 	if (clp->cl_minorversion) {
 		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4921144880d3..23fb39c957af 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -561,6 +561,61 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
 DEFINE_STATESEQID_EVENT(preprocess);
 DEFINE_STATESEQID_EVENT(open_confirm);
 
+TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
+TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
+TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
+TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
+TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
+TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
+TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
+
+#define show_stid_type(x)						\
+	__print_flags(x, "|",						\
+		{ NFS4_OPEN_STID,		"OPEN" },		\
+		{ NFS4_LOCK_STID,		"LOCK" },		\
+		{ NFS4_DELEG_STID,		"DELEG" },		\
+		{ NFS4_CLOSED_STID,		"CLOSED" },		\
+		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
+		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
+		{ NFS4_LAYOUT_STID,		"LAYOUT" })
+
+DECLARE_EVENT_CLASS(nfsd_stid_class,
+	TP_PROTO(
+		const struct nfs4_stid *stid
+	),
+	TP_ARGS(stid),
+	TP_STRUCT__entry(
+		__field(unsigned long, sc_type)
+		__field(int, sc_count)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+	),
+	TP_fast_assign(
+		const stateid_t *stp = &stid->sc_stateid;
+
+		__entry->sc_type = stid->sc_type;
+		__entry->sc_count = refcount_read(&stid->sc_count);
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+	),
+	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s",
+		__entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation,
+		__entry->sc_count, show_stid_type(__entry->sc_type)
+	)
+);
+
+#define DEFINE_STID_EVENT(name)					\
+DEFINE_EVENT(nfsd_stid_class, nfsd_stid_##name,			\
+	TP_PROTO(const struct nfs4_stid *stid),			\
+	TP_ARGS(stid))
+
+DEFINE_STID_EVENT(revoke);
+
 DECLARE_EVENT_CLASS(nfsd_clientid_class,
 	TP_PROTO(const clientid_t *clid),
 	TP_ARGS(clid),


