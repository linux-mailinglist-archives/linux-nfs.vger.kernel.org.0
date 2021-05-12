Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ACF37CAD6
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhELQcW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238774AbhELQGR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:06:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D0F161CF0;
        Wed, 12 May 2021 15:35:09 +0000 (UTC)
Subject: [PATCH v2 02/25] NFSD: Fix TP_printk() format specifier in
 nfsd_clid_class
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:35:09 -0400
Message-ID: <162083370909.3108.7574236781139213561.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 9a6944fee68e ("tracing: Add a verifier to check string
pointers for trace events"), which was merged in v5.13-rc1,
TP_printk() no longer tacitly supports the "%.*s" format specifier.

These are low value tracepoints, so just remove them.

Reported-by: David Wysochanski <dwysocha@redhat.com>
Fixes: dd5e3fbc1f47 ("NFSD: Add tracepoints to the NFSD state management code")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 fs/nfsd/nfs4state.c |    3 ---
 fs/nfsd/trace.h     |   29 -----------------------------
 2 files changed, 32 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b517a8794400..6abe48dee6ed 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7229,7 +7229,6 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp;
 
-	trace_nfsd_clid_reclaim(nn, name.len, name.data);
 	crp = alloc_reclaim();
 	if (crp) {
 		strhashval = clientstr_hashval(name);
@@ -7279,8 +7278,6 @@ nfsd4_find_reclaim_client(struct xdr_netobj name, struct nfsd_net *nn)
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp = NULL;
 
-	trace_nfsd_clid_find(nn, name.len, name.data);
-
 	strhashval = clientstr_hashval(name);
 	list_for_each_entry(crp, &nn->reclaim_str_hashtbl[strhashval], cr_strhash) {
 		if (compare_blob(&crp->cr_name, &name) == 0) {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 781af519b40c..f0ee18202de0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -534,35 +534,6 @@ DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
 DEFINE_NET_EVENT(grace_start);
 DEFINE_NET_EVENT(grace_complete);
 
-DECLARE_EVENT_CLASS(nfsd_clid_class,
-	TP_PROTO(const struct nfsd_net *nn,
-		 unsigned int namelen,
-		 const unsigned char *namedata),
-	TP_ARGS(nn, namelen, namedata),
-	TP_STRUCT__entry(
-		__field(unsigned long long, boot_time)
-		__field(unsigned int, namelen)
-		__dynamic_array(unsigned char,  name, namelen)
-	),
-	TP_fast_assign(
-		__entry->boot_time = nn->boot_time;
-		__entry->namelen = namelen;
-		memcpy(__get_dynamic_array(name), namedata, namelen);
-	),
-	TP_printk("boot_time=%16llx nfs4_clientid=%.*s",
-		__entry->boot_time, __entry->namelen, __get_str(name))
-)
-
-#define DEFINE_CLID_EVENT(name) \
-DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
-	TP_PROTO(const struct nfsd_net *nn, \
-		 unsigned int namelen, \
-		 const unsigned char *namedata), \
-	TP_ARGS(nn, namelen, namedata))
-
-DEFINE_CLID_EVENT(find);
-DEFINE_CLID_EVENT(reclaim);
-
 TRACE_EVENT(nfsd_clid_inuse_err,
 	TP_PROTO(const struct nfs4_client *clp),
 	TP_ARGS(clp),


