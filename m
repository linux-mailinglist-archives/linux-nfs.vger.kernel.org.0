Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE8A379323
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhEJPyW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhEJPyW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:54:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10A4F615FF;
        Mon, 10 May 2021 15:53:16 +0000 (UTC)
Subject: [PATCH RFC 16/21] NFSD: Remove nfsd_clid_inuse_err
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:53:16 -0400
Message-ID: <162066199628.94415.2243973916757591987.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This tracepoint has been replaced by nfsd_clid_cred_mismatch and
nfsd_clid_verf_mismatch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 2c0392f30a86..bc495876e4ae 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -624,30 +624,6 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
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


