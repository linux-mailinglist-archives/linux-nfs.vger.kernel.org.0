Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1296C6616B3
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjAHQbZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjAHQbG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:31:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FCD2708
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:31:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FC8DB801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14CCC433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195460;
        bh=8TSO+zKjhsVabbyNtckRYRzcLooLsQtVJnH5HqPnLV4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=jU/ynSLDPhV64E5/475BJkzRM63Bo/yU+2e+g6d71N6cE5OrhjERUL4v8nhVyUodq
         Ms8ttho7cv7xceuU+MRivxES151hmmIj8HVyX/EUAf9IPD8SW3ad/uEDTmsaIHau6J
         Kx1skCCvZ0Dm00uJ7/6tJ9kJIhuEESAIFeCMiGsRiA8/+bzaJyrsqZS2xuhGBmpLK+
         Q/8tJ8+NCF5A4jRRJZFCVcOTOyCYci/i+IzAq6LHUbWmZ3q5/Y+dmr3evjuCcQlDpo
         5jQtlGsR1Zi5Dt+kcwxSpINu/egPOFBU9hWXTtqH/ShdFHZS8moh5doWgF64G+1YXh
         JdkAi6YGjN0zQ==
Subject: [PATCH v1 25/27] SUNRPC: Refactor RPC server dispatch method
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:30:59 -0500
Message-ID: <167319545904.7490.3650656071864510603.stgit@bazille.1015granger.net>
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
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

Currently, svcauth_gss_accept() pre-reserves response buffer space
for the RPC payload length and GSS sequence number before returning
to the dispatcher, which then adds the header's accept_stat field.

The problem is the accept_stat field is supposed to go before the
length and seq_num fields. So svcauth_gss_release() has to relocate
the accept_stat value (see svcauth_gss_prepare_to_wrap()).

To enable these fields to be added to the response buffer in the
correct (final) order, the pointer to the accept_stat has to be made
available to svcauth_gss_accept() so that it can set it before
reserving space for the length and seq_num fields.

As a first step, move the pointer to the location of the accept_stat
field into struct svc_rqst.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c             |    4 ++--
 fs/nfs/callback_xdr.c      |    4 ++--
 fs/nfsd/nfscache.c         |    2 +-
 fs/nfsd/nfsd.h             |    2 +-
 fs/nfsd/nfssvc.c           |    4 ++--
 include/linux/sunrpc/svc.h |    5 +++--
 net/sunrpc/svc.c           |   10 +++++-----
 7 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 642e394e7a2d..0b28a6cf9303 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -685,15 +685,15 @@ module_exit(exit_nlm);
 /**
  * nlmsvc_dispatch - Process an NLM Request
  * @rqstp: incoming request
- * @statp: pointer to location of accept_stat field in RPC Reply buffer
  *
  * Return values:
  *  %0: Processing complete; do not send a Reply
  *  %1: Processing complete; send Reply in rqstp->rq_res
  */
-static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+static int nlmsvc_dispatch(struct svc_rqst *rqstp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
+	__be32 *statp = rqstp->rq_accept_statp;
 
 	if (!procp->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index b4c3b7182198..13b2af55497d 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -980,11 +980,11 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 }
 
 static int
-nfs_callback_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+nfs_callback_dispatch(struct svc_rqst *rqstp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
 
-	*statp = procp->pc_func(rqstp);
+	*rqstp->rq_accept_statp = procp->pc_func(rqstp);
 	return 1;
 }
 
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index ef5ee548053b..041faa13b852 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -509,7 +509,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
  * nfsd_cache_update - Update an entry in the duplicate reply cache.
  * @rqstp: svc_rqst with a finished Reply
  * @cachetype: which cache to update
- * @statp: Reply's status code
+ * @statp: pointer to Reply's NFS status code, or NULL
  *
  * This is called from nfsd_dispatch when the procedure has been
  * executed and the complete reply is in rqstp->rq_res.
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 93b42ef9ed91..a7de2ffe943b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -86,7 +86,7 @@ bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
  * Function prototypes.
  */
 int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred);
-int		nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp);
+int		nfsd_dispatch(struct svc_rqst *rqstp);
 
 int		nfsd_nrthreads(struct net *);
 int		nfsd_nrpools(struct net *);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index dfa8ee6c04d5..ff10c46b62d3 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1022,7 +1022,6 @@ nfsd(void *vrqstp)
 /**
  * nfsd_dispatch - Process an NFS or NFSACL Request
  * @rqstp: incoming request
- * @statp: pointer to location of accept_stat field in RPC Reply buffer
  *
  * This RPC dispatcher integrates the NFS server's duplicate reply cache.
  *
@@ -1030,9 +1029,10 @@ nfsd(void *vrqstp)
  *  %0: Processing complete; do not send a Reply
  *  %1: Processing complete; send Reply in rqstp->rq_res
  */
-int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+int nfsd_dispatch(struct svc_rqst *rqstp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
+	__be32 *statp = rqstp->rq_accept_statp;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 32eb98e621c3..f40a90ca5de6 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -251,6 +251,7 @@ struct svc_rqst {
 
 	void *			rq_argp;	/* decoded arguments */
 	void *			rq_resp;	/* xdr'd results */
+	__be32			*rq_accept_statp;
 	void *			rq_auth_data;	/* flavor-specific data */
 	__be32			rq_auth_stat;	/* authentication status */
 	int			rq_auth_slack;	/* extra space xdr code
@@ -337,7 +338,7 @@ struct svc_deferred_req {
 
 struct svc_process_info {
 	union {
-		int  (*dispatch)(struct svc_rqst *, __be32 *);
+		int  (*dispatch)(struct svc_rqst *rqstp);
 		struct {
 			unsigned int lovers;
 			unsigned int hivers;
@@ -389,7 +390,7 @@ struct svc_version {
 	bool			vs_need_cong_ctrl;
 
 	/* Dispatch function */
-	int			(*vs_dispatch)(struct svc_rqst *, __be32 *);
+	int			(*vs_dispatch)(struct svc_rqst *rqstp);
 };
 
 /*
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index bb58915622ca..3c194e6f8f5e 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1232,9 +1232,9 @@ svc_process_common(struct svc_rqst *rqstp)
 	const struct svc_procedure *procp = NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_process_info process;
-	__be32			*p, *statp;
 	int			auth_res, rc;
 	unsigned int		aoffset;
+	__be32			*p;
 
 	/* Will be turned off by GSS integrity and privacy services */
 	__set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
@@ -1314,8 +1314,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	trace_svc_process(rqstp, progp->pg_name);
 
 	aoffset = xdr_stream_pos(xdr);
-	statp = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT);
-	*statp = rpc_success;
+	rqstp->rq_accept_statp = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT);
+	*rqstp->rq_accept_statp = rpc_success;
 
 	/* un-reserve some of the out-queue now that we have a
 	 * better idea of reply size
@@ -1324,7 +1324,7 @@ svc_process_common(struct svc_rqst *rqstp)
 		svc_reserve_auth(rqstp, procp->pc_xdrressize<<2);
 
 	/* Call the function that processes the request. */
-	rc = process.dispatch(rqstp, statp);
+	rc = process.dispatch(rqstp);
 	if (procp->pc_release)
 		procp->pc_release(rqstp);
 	if (!rc)
@@ -1332,7 +1332,7 @@ svc_process_common(struct svc_rqst *rqstp)
 	if (rqstp->rq_auth_stat != rpc_auth_ok)
 		goto err_bad_auth;
 
-	if (*statp != rpc_success)
+	if (*rqstp->rq_accept_statp != rpc_success)
 		xdr_truncate_encode(xdr, aoffset);
 
 	if (procp->pc_encode == NULL)


