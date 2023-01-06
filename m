Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E406605D6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 18:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjAFRns (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 12:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAFRnq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 12:43:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BD276EDA
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 09:43:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983B361EE2
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 17:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB94BC433D2
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027019;
        bh=rKh4k3o7kKtkPHULv/T2Fjo2TWkap7PlYAPYEzx11gI=;
        h=Subject:From:To:Date:From;
        b=B03CjJVef+FMSZsjyfuWi+OcNUGf5jGcA+JP4+fdNM1yskDWNYXUqjUCr3oP77U46
         Q5yukB9YvIj3O7G4QlJ1lRQQ5c5J14b5+Ud9dAz2bCGyBxYegpQ39Mrr0/YTBzYCk2
         1ZTFuZm10DhEwwzBEqnSLVSb+fHujGCRXtSC2XLkbkEJfrTJFsqz4OCRdJ/26O4eAZ
         ULW0bKR6j3P23BLHnWRt5fSxzIMTPDyFgdw5xU5TJ8Je7M6b1/oBhs5mF+1O19cUqy
         h9WZO6QnxWQpHr59Ghh69nxHi691gUb6SdfwdlF/oxNqVejFnq3nkGPyUEb8fgieDN
         rNm/Nv4gOk+YQ==
Subject: [PATCH v1] Revert "SUNRPC: Use RMW bitops in single-threaded hot
 paths"
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 06 Jan 2023 12:43:37 -0500
Message-ID: <167302701777.4221.807573588471189662.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The premise that "Once an svc thread is scheduled and executing an
RPC, no other processes will touch svc_rqst::rq_flags" is false.
svc_xprt_enqueue() examines the RQ_BUSY flag in scheduled nfsd
threads when determining which thread to wake up next.

Found via KCSAN.

Fixes: 28df0988815f ("SUNRPC: Use RMW bitops in single-threaded hot paths")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c                       |    7 +++----
 fs/nfsd/nfs4xdr.c                        |    2 +-
 net/sunrpc/auth_gss/svcauth_gss.c        |    4 ++--
 net/sunrpc/svc.c                         |    6 +++---
 net/sunrpc/svc_xprt.c                    |    2 +-
 net/sunrpc/svcsock.c                     |    8 ++++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +-
 7 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bd880d55f565..9b81d012666e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -937,7 +937,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * the client wants us to do more in this compound:
 	 */
 	if (!nfsd4_last_compound_op(rqstp))
-		__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+		clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
@@ -2607,12 +2607,11 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	cstate->minorversion = args->minorversion;
 	fh_init(current_fh, NFS4_FHSIZE);
 	fh_init(save_fh, NFS4_FHSIZE);
-
 	/*
 	 * Don't use the deferral mechanism for NFSv4; compounds make it
 	 * too hard to avoid non-idempotency problems.
 	 */
-	__clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 
 	/*
 	 * According to RFC3010, this takes precedence over all other errors.
@@ -2734,7 +2733,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 out:
 	cstate->status = status;
 	/* Reset deferral mechanism for RPC deferrals */
-	__set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ebb4d02a42ce..97edb32be77f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2523,7 +2523,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	argp->rqstp->rq_cachetype = cachethis ? RC_REPLBUFF : RC_NOCACHE;
 
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
-		__clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
+		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
 
 	return true;
 }
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 148bb0a7fa5b..acb822b23af1 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -923,7 +923,7 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	 * rejecting the server-computed MIC in this somewhat rare case,
 	 * do not use splice with the GSS integrity service.
 	 */
-	__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	/* Did we already verify the signature on the original pass through? */
 	if (rqstp->rq_deferred)
@@ -990,7 +990,7 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	int pad, remaining_len, offset;
 	u32 rseqno;
 
-	__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	priv_len = svc_getnl(&buf->head[0]);
 	if (rqstp->rq_deferred) {
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 8f1b596db33f..b1da586c4476 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1243,10 +1243,10 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		goto err_short_len;
 
 	/* Will be turned off by GSS integrity and privacy services */
-	__set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 	/* Will be turned off only when NFSv4 Sessions are used */
-	__set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
-	__clear_bit(RQ_DROPME, &rqstp->rq_flags);
+	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	clear_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	svc_putu32(resv, rqstp->rq_xid);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 2106003645a7..c2ce12538008 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1238,7 +1238,7 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 	trace_svc_defer(rqstp);
 	svc_xprt_get(rqstp->rq_xprt);
 	dr->xprt = rqstp->rq_xprt;
-	__set_bit(RQ_DROPME, &rqstp->rq_flags);
+	set_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	dr->handle.revisit = svc_revisit;
 	return &dr->handle;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2fc98fea59b4..e833103f4629 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -298,9 +298,9 @@ static void svc_sock_setbufsize(struct svc_sock *svsk, unsigned int nreqs)
 static void svc_sock_secure_port(struct svc_rqst *rqstp)
 {
 	if (svc_port_is_privileged(svc_addr(rqstp)))
-		__set_bit(RQ_SECURE, &rqstp->rq_flags);
+		set_bit(RQ_SECURE, &rqstp->rq_flags);
 	else
-		__clear_bit(RQ_SECURE, &rqstp->rq_flags);
+		clear_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 /*
@@ -1008,9 +1008,9 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_ctxt   = NULL;
 	rqstp->rq_prot	      = IPPROTO_TCP;
 	if (test_bit(XPT_LOCAL, &svsk->sk_xprt.xpt_flags))
-		__set_bit(RQ_LOCAL, &rqstp->rq_flags);
+		set_bit(RQ_LOCAL, &rqstp->rq_flags);
 	else
-		__clear_bit(RQ_LOCAL, &rqstp->rq_flags);
+		clear_bit(RQ_LOCAL, &rqstp->rq_flags);
 
 	p = (__be32 *)rqstp->rq_arg.head[0].iov_base;
 	calldir = p[1];
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 199fa012f18a..94b20fb47135 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -602,7 +602,7 @@ static int svc_rdma_has_wspace(struct svc_xprt *xprt)
 
 static void svc_rdma_secure_port(struct svc_rqst *rqstp)
 {
-	__set_bit(RQ_SECURE, &rqstp->rq_flags);
+	set_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 static void svc_rdma_kill_temp_xprt(struct svc_xprt *xprt)


