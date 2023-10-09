Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5BB7BE94B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377541AbjJISaV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376869AbjJISaT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 14:30:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17AA3
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 11:30:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B358BC433C7;
        Mon,  9 Oct 2023 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876218;
        bh=HpAXGxo0ErJy1sbLEDpNwIWhCnaEjYunk5UMryvnEfE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QzKfXcXauOjGGLNRVYyPTgfv9FzJBNQmo0L6v4h+KRdX4Q2hK31QdHeBm6h4qZxjF
         0v8J6sHaPdwdOJHKVBm8zlPkU1yqlW8Mw+79G4+VvsmfurGeddbkZP6dusZ8IBxT2P
         hnRw5TvVIilbqVYiYFekptUdDRl+q2puZ+glnVFJFtxeO5ceTwysyugdqga3/9Mgoq
         zwrj0BYMAsiXMqC1qoXs5nJsYpYkLiPjtmBE3PvcNXGzVfSTh7HmdQG1LgJj9g3jCq
         6Dm7gkLM7hvG4NkbJLOcaS1R51ZTG77nqnfPbrBlBiXl/8Q87tEEgehZLxsGwC1f+/
         itXjLYliI2bLw==
Subject: [PATCH v1 6/8] NFSD: Clean up nfsd4_encode_copy_notify()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 14:30:16 -0400
Message-ID: <169687621644.41382.6990732924730724555.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
References: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Replace open-coded encoding logic with the use of conventional XDR
utility functions.

Note that if we replace the cpn_sec and cpn_nsec fields with a
single struct timespec64 field, the encoder can use
nfsd4_encode_nfstime4(), as that is the data type specified by the
XDR spec.

NFS4ERR_INVAL seems inappropriate if the encoder doesn't support
encoding the response. Instead use NFS4ERR_SERVERFAULT, since this
condition is a software bug on the server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    4 +-
 fs/nfsd/nfs4xdr.c  |  106 ++++++++++++++++++++--------------------------------
 fs/nfsd/xdr4.h     |    3 -
 3 files changed, 44 insertions(+), 69 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 60262fd27b15..0bb046ebc6c5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1939,8 +1939,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		return status;
 
-	cn->cpn_sec = nn->nfsd4_lease;
-	cn->cpn_nsec = 0;
+	cn->cpn_lease_time.tv_sec = nn->nfsd4_lease;
+	cn->cpn_lease_time.tv_nsec = 0;
 
 	status = nfserrno(-ENOMEM);
 	cps = nfs4_alloc_init_cpntf_state(nn, stid);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b9339a1452c8..fdb7dafa7f27 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2575,6 +2575,19 @@ nfsd4_encode_change_info4(struct xdr_stream *xdr, const struct nfsd4_change_info
 	return nfsd4_encode_changeid4(xdr, c->after_change);
 }
 
+static __be32 nfsd4_encode_netaddr4(struct xdr_stream *xdr,
+				    const struct nfs42_netaddr *addr)
+{
+	__be32 status;
+
+	/* na_r_netid */
+	status = nfsd4_encode_opaque(xdr, addr->netid, addr->netid_len);
+	if (status != nfs_ok)
+		return status;
+	/* na_r_addr */
+	return nfsd4_encode_opaque(xdr, addr->addr, addr->addr_len);
+}
+
 /* Encode as an array of strings the string given with components
  * separated @sep, escaped with esc_enter and esc_exit.
  */
@@ -5128,43 +5141,42 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 }
 
 static __be32
-nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct nl4_server *ns)
+nfsd4_encode_netloc4(struct xdr_stream *xdr, const struct nl4_server *ns)
 {
-	struct xdr_stream *xdr = resp->xdr;
-	struct nfs42_netaddr *addr;
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, 4);
-	*p++ = cpu_to_be32(ns->nl4_type);
+	__be32 status;
 
+	if (xdr_stream_encode_u32(xdr, ns->nl4_type) != XDR_UNIT)
+		return nfserr_resource;
 	switch (ns->nl4_type) {
 	case NL4_NETADDR:
-		addr = &ns->u.nl4_addr;
-
-		/* netid_len, netid, uaddr_len, uaddr (port included
-		 * in RPCBIND_MAXUADDRLEN)
-		 */
-		p = xdr_reserve_space(xdr,
-			4 /* netid len */ +
-			(XDR_QUADLEN(addr->netid_len) * 4) +
-			4 /* uaddr len */ +
-			(XDR_QUADLEN(addr->addr_len) * 4));
-		if (!p)
-			return nfserr_resource;
-
-		*p++ = cpu_to_be32(addr->netid_len);
-		p = xdr_encode_opaque_fixed(p, addr->netid,
-					    addr->netid_len);
-		*p++ = cpu_to_be32(addr->addr_len);
-		p = xdr_encode_opaque_fixed(p, addr->addr,
-					addr->addr_len);
+		/* nl_addr */
+		status = nfsd4_encode_netaddr4(xdr, &ns->u.nl4_addr);
 		break;
 	default:
-		WARN_ON_ONCE(ns->nl4_type != NL4_NETADDR);
-		return nfserr_inval;
+		status = nfserr_serverfault;
 	}
+	return status;
+}
 
-	return 0;
+static __be32
+nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
+			 union nfsd4_op_u *u)
+{
+	struct nfsd4_copy_notify *cn = &u->copy_notify;
+	struct xdr_stream *xdr = resp->xdr;
+
+	/* cnr_lease_time */
+	nfserr = nfsd4_encode_nfstime4(xdr, &cn->cpn_lease_time);
+	if (nfserr)
+		return nfserr;
+	/* cnr_stateid */
+	nfserr = nfsd4_encode_stateid4(xdr, &cn->cpn_cnr_stateid);
+	if (nfserr)
+		return nfserr;
+	/* cnr_source_server<> */
+	if (xdr_stream_encode_u32(xdr, 1) != XDR_UNIT)
+		return nfserr_resource;
+	return nfsd4_encode_netloc4(xdr, cn->cpn_src);
 }
 
 static __be32
@@ -5257,42 +5269,6 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfserr;
 }
 
-static __be32
-nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
-			 union nfsd4_op_u *u)
-{
-	struct nfsd4_copy_notify *cn = &u->copy_notify;
-	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
-
-	if (nfserr)
-		return nfserr;
-
-	/* 8 sec, 4 nsec */
-	p = xdr_reserve_space(xdr, 12);
-	if (!p)
-		return nfserr_resource;
-
-	/* cnr_lease_time */
-	p = xdr_encode_hyper(p, cn->cpn_sec);
-	*p++ = cpu_to_be32(cn->cpn_nsec);
-
-	/* cnr_stateid */
-	nfserr = nfsd4_encode_stateid4(xdr, &cn->cpn_cnr_stateid);
-	if (nfserr)
-		return nfserr;
-
-	/* cnr_src.nl_nsvr */
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
-		return nfserr_resource;
-
-	*p++ = cpu_to_be32(1);
-
-	nfserr = nfsd42_encode_nl4_server(resp, cn->cpn_src);
-	return nfserr;
-}
-
 static __be32
 nfsd4_encode_seek(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  union nfsd4_op_u *u)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 947345d8490d..3147b92c7216 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -754,8 +754,7 @@ struct nfsd4_copy_notify {
 
 	/* response */
 	stateid_t		cpn_cnr_stateid;
-	u64			cpn_sec;
-	u32			cpn_nsec;
+	struct timespec64	cpn_lease_time;
 	struct nl4_server	*cpn_src;
 };
 


