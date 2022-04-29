Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C079514E6F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377985AbiD2O53 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377980AbiD2O53 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 10:57:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70C2BE9C5
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 07:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5718961F91
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9DDC385A7
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 14:54:09 +0000 (UTC)
Subject: [PATCH 6/6] SUNRPC: Use RMW bitops in single-threaded hot paths
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:54:08 -0400
Message-ID: <165124404878.1060.12201901556265807507.stgit@bazille.1015granger.net>
In-Reply-To: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
References: <165124376329.1060.17013198516228928515.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
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

I noticed CPU pipeline stalls while using perf.

Once an svc thread is scheduled and executing an RPC, no other
processes will touch svc_rqst::rq_flags. Thus bus-locked atomics are
not needed outside the svc thread scheduler.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c                       |    7 ++++---
 fs/nfsd/nfs4xdr.c                        |    2 +-
 net/sunrpc/auth_gss/svcauth_gss.c        |    4 ++--
 net/sunrpc/svc.c                         |    6 +++---
 net/sunrpc/svc_xprt.c                    |    2 +-
 net/sunrpc/svcsock.c                     |    8 ++++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +-
 7 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9dbce52f0f33..3895eb52d2b1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -970,7 +970,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * the client wants us to do more in this compound:
 	 */
 	if (!nfsd4_last_compound_op(rqstp))
-		clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+		__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
@@ -2650,11 +2650,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	cstate->minorversion = args->minorversion;
 	fh_init(current_fh, NFS4_FHSIZE);
 	fh_init(save_fh, NFS4_FHSIZE);
+
 	/*
 	 * Don't use the deferral mechanism for NFSv4; compounds make it
 	 * too hard to avoid non-idempotency problems.
 	 */
-	clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	__clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 
 	/*
 	 * According to RFC3010, this takes precedence over all other errors.
@@ -2769,7 +2770,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 out:
 	cstate->status = status;
 	/* Reset deferral mechanism for RPC deferrals */
-	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	__set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index da92e7d2ab6a..61b2aae81abb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2411,7 +2411,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	argp->rqstp->rq_cachetype = cachethis ? RC_REPLBUFF : RC_NOCACHE;
 
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
-		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
+		__clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
 
 	return true;
 }
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index c2ba9d4cd2c7..bcd74dddbe2d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -900,7 +900,7 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	 * rejecting the server-computed MIC in this somewhat rare case,
 	 * do not use splice with the GSS integrity service.
 	 */
-	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	/* Did we already verify the signature on the original pass through? */
 	if (rqstp->rq_deferred)
@@ -972,7 +972,7 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	int pad, remaining_len, offset;
 	u32 rseqno;
 
-	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
 	priv_len = svc_getnl(&buf->head[0]);
 	if (rqstp->rq_deferred) {
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 557004017548..57245c776d17 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1238,10 +1238,10 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		goto err_short_len;
 
 	/* Will be turned off by GSS integrity and privacy services */
-	set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+	__set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 	/* Will be turned off only when NFSv4 Sessions are used */
-	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
-	clear_bit(RQ_DROPME, &rqstp->rq_flags);
+	__set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+	__clear_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	svc_putu32(resv, rqstp->rq_xid);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index f9d9922f1629..a93b7c18e4a0 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1241,7 +1241,7 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 	trace_svc_defer(rqstp);
 	svc_xprt_get(rqstp->rq_xprt);
 	dr->xprt = rqstp->rq_xprt;
-	set_bit(RQ_DROPME, &rqstp->rq_flags);
+	__set_bit(RQ_DROPME, &rqstp->rq_flags);
 
 	dr->handle.revisit = svc_revisit;
 	return &dr->handle;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 05452318afec..b3c9740cfd35 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -298,9 +298,9 @@ static void svc_sock_setbufsize(struct svc_sock *svsk, unsigned int nreqs)
 static void svc_sock_secure_port(struct svc_rqst *rqstp)
 {
 	if (svc_port_is_privileged(svc_addr(rqstp)))
-		set_bit(RQ_SECURE, &rqstp->rq_flags);
+		__set_bit(RQ_SECURE, &rqstp->rq_flags);
 	else
-		clear_bit(RQ_SECURE, &rqstp->rq_flags);
+		__clear_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 /*
@@ -1008,9 +1008,9 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_ctxt   = NULL;
 	rqstp->rq_prot	      = IPPROTO_TCP;
 	if (test_bit(XPT_LOCAL, &svsk->sk_xprt.xpt_flags))
-		set_bit(RQ_LOCAL, &rqstp->rq_flags);
+		__set_bit(RQ_LOCAL, &rqstp->rq_flags);
 	else
-		clear_bit(RQ_LOCAL, &rqstp->rq_flags);
+		__clear_bit(RQ_LOCAL, &rqstp->rq_flags);
 
 	p = (__be32 *)rqstp->rq_arg.head[0].iov_base;
 	calldir = p[1];
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 94b20fb47135..199fa012f18a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -602,7 +602,7 @@ static int svc_rdma_has_wspace(struct svc_xprt *xprt)
 
 static void svc_rdma_secure_port(struct svc_rqst *rqstp)
 {
-	set_bit(RQ_SECURE, &rqstp->rq_flags);
+	__set_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 static void svc_rdma_kill_temp_xprt(struct svc_xprt *xprt)


