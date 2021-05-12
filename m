Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4037CADC
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhELQc3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238994AbhELQG7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:06:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA97661D04;
        Wed, 12 May 2021 15:35:29 +0000 (UTC)
Subject: [PATCH v2 05/25] NFSD: Remove trace_nfsd_clid_inuse_err
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:35:28 -0400
Message-ID: <162083372885.3108.2212428008275286184.stgit@klimt.1015granger.net>
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

This tracepoint has been replaced by nfsd_clid_cred_mismatch and
nfsd_clid_verf_mismatch, and can simply be removed.

Reported-by: David Wysochanski <dwysocha@redhat.com>
Fixes: dd5e3fbc1f47 ("NFSD: Add tracepoints to the NFSD state management code")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 fs/nfsd/trace.h |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 7e2fce504a2d..b5bf792575d5 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -594,30 +594,6 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
 	)
 );
 
-TRACE_EVENT(nfsd_clid_inuse_err,
-	TP_PROTO(const struct nfs4_client *clp),
-	TP_ARGS(clp),
-	TP_STRUCT__entry(
-		__field(u32, cl_boot)
-		__field(u32, cl_id)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
-		__field(unsigned int, namelen)
-		__dynamic_array(unsigned char, name, clp->cl_name.len)
-	),
-	TP_fast_assign(
-		__entry->cl_boot = clp->cl_clientid.cl_boot;
-		__entry->cl_id = clp->cl_clientid.cl_id;
-		memcpy(__entry->addr, &clp->cl_addr,
-			sizeof(struct sockaddr_in6));
-		__entry->namelen = clp->cl_name.len;
-		memcpy(__get_dynamic_array(name), clp->cl_name.data,
-			clp->cl_name.len);
-	),
-	TP_printk("nfs4_clientid %.*s already in use by %pISpc, client %08x:%08x",
-		__entry->namelen, __get_str(name), __entry->addr,
-		__entry->cl_boot, __entry->cl_id)
-)
-
 /*
  * from fs/nfsd/filecache.h
  */


