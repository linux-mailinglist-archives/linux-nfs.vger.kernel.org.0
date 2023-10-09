Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB27BE948
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377350AbjJISaB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377444AbjJISaA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 14:30:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4E39C
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 11:29:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6115C433C8;
        Mon,  9 Oct 2023 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876198;
        bh=e8C+zaRDSuMRUp6H+jm9oq1sMelTB5aR4pznaq8phQM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QXpn+btTRoRL+REaUpr8NzjPjikl9LHqr8FZTmbLhrEaZrmVGcqjRXcNIv31rHZ31
         PezC09hLd3t1DGT9Rj+nTb6s6o3mPw6YUVjIX9WP9dLxnYa/cWsgditXxaz/bQ48Z6
         PDWMJqXgYlJ9ih240h7JRoEry11vFcKyS8qkcY0Mjjg00rKJ0S1l518dePcut7xOs0
         3ctmy5rV9lHFyb8U96bWJ+NbWTE7BS3eRytoOyftAHTH8ioDQY1XeMioTpNiQllvW3
         OP5X4CXfGnDRlMcKt5p8DH4gk59s/4K1q8aGFATc9cgsDBRpOLf8KDa3UafnBn8hnt
         zHLZTbTzYvzlA==
Subject: [PATCH v1 3/8] NFSD: Clean up nfsd4_encode_exchange_id()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 14:29:56 -0400
Message-ID: <169687619650.41382.2300873367664515608.stgit@oracle-102.nfsv4bat.org>
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

Restructure nfsd4_encode_exchange_id() so that it will be more
straightforward to add support for SSV one day. Also, adopt the use
of the conventional XDR utility functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  129 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 55 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 085f4bda5c58..85044cdcf2a7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4729,77 +4729,96 @@ nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr,
 }
 
 static __be32
-nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
-			 union nfsd4_op_u *u)
+nfsd4_encode_state_protect_ops4(struct xdr_stream *xdr,
+				struct nfsd4_exchange_id *exid)
 {
-	struct nfsd4_exchange_id *exid = &u->exchange_id;
-	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
-	char *major_id;
-	char *server_scope;
-	int major_id_sz;
-	int server_scope_sz;
-	uint64_t minor_id = 0;
-	struct nfsd_net *nn = net_generic(SVC_NET(resp->rqstp), nfsd_net_id);
+	__be32 status;
 
-	major_id = nn->nfsd_name;
-	major_id_sz = strlen(nn->nfsd_name);
-	server_scope = nn->nfsd_name;
-	server_scope_sz = strlen(nn->nfsd_name);
+	/* spo_must_enforce */
+	status = nfsd4_encode_bitmap4(xdr, exid->spo_must_enforce[0],
+				      exid->spo_must_enforce[1],
+				      exid->spo_must_enforce[2]);
+	if (status != nfs_ok)
+		return status;
+	/* spo_must_allow */
+	return nfsd4_encode_bitmap4(xdr, exid->spo_must_allow[0],
+				    exid->spo_must_allow[1],
+				    exid->spo_must_allow[2]);
+}
 
-	if (nfsd4_encode_clientid4(xdr, &exid->clientid) != nfs_ok)
-		return nfserr_resource;
-	if (xdr_stream_encode_u32(xdr, exid->seqid) < 0)
-		return nfserr_resource;
-	if (xdr_stream_encode_u32(xdr, exid->flags) < 0)
-		return nfserr_resource;
+static __be32
+nfsd4_encode_state_protect4_r(struct xdr_stream *xdr, struct nfsd4_exchange_id *exid)
+{
+	__be32 status;
 
-	if (xdr_stream_encode_u32(xdr, exid->spa_how) < 0)
+	if (xdr_stream_encode_u32(xdr, exid->spa_how) != XDR_UNIT)
 		return nfserr_resource;
 	switch (exid->spa_how) {
 	case SP4_NONE:
+		status = nfs_ok;
 		break;
 	case SP4_MACH_CRED:
-		/* spo_must_enforce bitmap: */
-		nfserr = nfsd4_encode_bitmap4(xdr,
-					exid->spo_must_enforce[0],
-					exid->spo_must_enforce[1],
-					exid->spo_must_enforce[2]);
-		if (nfserr)
-			return nfserr;
-		/* spo_must_allow bitmap: */
-		nfserr = nfsd4_encode_bitmap4(xdr,
-					exid->spo_must_allow[0],
-					exid->spo_must_allow[1],
-					exid->spo_must_allow[2]);
-		if (nfserr)
-			return nfserr;
+		/* spr_mach_ops */
+		status = nfsd4_encode_state_protect_ops4(xdr, exid);
 		break;
 	default:
-		WARN_ON_ONCE(1);
+		status = nfserr_serverfault;
 	}
+	return status;
+}
 
-	p = xdr_reserve_space(xdr,
-		8 /* so_minor_id */ +
-		4 /* so_major_id.len */ +
-		(XDR_QUADLEN(major_id_sz) * 4) +
-		4 /* eir_server_scope.len */ +
-		(XDR_QUADLEN(server_scope_sz) * 4) +
-		4 /* eir_server_impl_id.count (0) */);
-	if (!p)
-		return nfserr_resource;
+static __be32
+nfsd4_encode_server_owner4(struct xdr_stream *xdr, struct svc_rqst *rqstp)
+{
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	__be32 status;
 
-	/* The server_owner struct */
-	p = xdr_encode_hyper(p, minor_id);      /* Minor id */
-	/* major id */
-	p = xdr_encode_opaque(p, major_id, major_id_sz);
+	/* so_minor_id */
+	status = nfsd4_encode_uint64_t(xdr, 0);
+	if (status != nfs_ok)
+		return status;
+	/* so_major_id */
+	return nfsd4_encode_opaque(xdr, nn->nfsd_name, strlen(nn->nfsd_name));
+}
 
-	/* Server scope */
-	p = xdr_encode_opaque(p, server_scope, server_scope_sz);
+static __be32
+nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
+			 union nfsd4_op_u *u)
+{
+	struct nfsd_net *nn = net_generic(SVC_NET(resp->rqstp), nfsd_net_id);
+	struct nfsd4_exchange_id *exid = &u->exchange_id;
+	struct xdr_stream *xdr = resp->xdr;
 
-	/* Implementation id */
-	*p++ = cpu_to_be32(0);	/* zero length nfs_impl_id4 array */
-	return 0;
+	/* eir_clientid */
+	nfserr = nfsd4_encode_clientid4(xdr, &exid->clientid);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* eir_sequenceid */
+	nfserr = nfsd4_encode_sequenceid4(xdr, exid->seqid);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* eir_flags */
+	nfserr = nfsd4_encode_uint32_t(xdr, exid->flags);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* eir_state_protect */
+	nfserr = nfsd4_encode_state_protect4_r(xdr, exid);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* eir_server_owner */
+	nfserr = nfsd4_encode_server_owner4(xdr, resp->rqstp);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* eir_server_scope */
+	nfserr = nfsd4_encode_opaque(xdr, nn->nfsd_name,
+				     strlen(nn->nfsd_name));
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* eir_server_impl_id<1> */
+	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+		return nfserr_resource;
+
+	return nfs_ok;
 }
 
 static __be32


