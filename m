Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C347B3413
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 15:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjI2N7K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2N7J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 09:59:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A23DB
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 06:59:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64D1C433CB;
        Fri, 29 Sep 2023 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695995947;
        bh=O6JAotND+8gteUF8xnnr7PwIjoK7phrfdZziEun4m04=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o/qzNUzFaAwsEvKRLYlWx8oTcMPgWoWR7vflH+KoRR1YUK+Bkst517yQ7+wW4kRYz
         kEBftZ6ntEIhlBiDcJHapzE48el5o+me1f9gLS0b+9qquU2XNKKp7mCfRaw2swjm8n
         Xnli4QzZmlofbwM60INsu/l/hJrCnWF3+NmlU10nw2wGf+Oox09jr4houaSI46cKZ9
         QoLiQr9ZSfVayb4C6bKesCM6Q7eWT6I3lH60K3Pu5TRgNxAvMXjEtVdLjFu1M051Zn
         +I9JMBXEEabT7LG+qrmt0ciGZlYmeIGyZp7VWQikSUc51EyNivFXnzBI6/5OOCIY8n
         +XIEn96bP6J/g==
Subject: [PATCH v1 3/7] NFSD: Add nfsd4_encode_open_read_delegation4()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 09:59:05 -0400
Message-ID: <169599594587.5622.94747681619250190.stgit@manet.1015granger.net>
In-Reply-To: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
References: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Refactor nfsd4_encode_open() so the open_read_delegation4 type is
encoded in a separate function. This makes it more straightforward
to later add support for returning an nfsace4 in OPEN responses that
offer a delegation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    6 +++--
 fs/nfsd/nfs4xdr.c   |   61 ++++++++++++++++++++++++++++++++++++++-------------
 fs/nfsd/xdr4.h      |    2 +-
 3 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 22e95b9ae82f..b1118050ff52 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5688,11 +5688,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct path path;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
-	open->op_recall = 0;
+	open->op_recall = false;
 	switch (open->op_claim_type) {
 		case NFS4_OPEN_CLAIM_PREVIOUS:
 			if (!cb_up)
-				open->op_recall = 1;
+				open->op_recall = true;
 			break;
 		case NFS4_OPEN_CLAIM_NULL:
 			parent = currentfh;
@@ -5746,7 +5746,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
 	    open->op_delegate_type != NFS4_OPEN_DELEGATE_NONE) {
 		dprintk("NFSD: WARNING: refusing delegation reclaim\n");
-		open->op_recall = 1;
+		open->op_recall = true;
 	}
 
 	/* 4.1 client asking for a delegation? */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ee8a7989f54f..f411fcc435f6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4074,6 +4074,49 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfsd4_encode_change_info4(xdr, &link->li_cinfo);
 }
 
+/*
+ * This implementation does not yet support returning an ACE in an
+ * OPEN that offers a delegation.
+ */
+static __be32
+nfsd4_encode_open_nfsace4(struct xdr_stream *xdr)
+{
+	__be32 status;
+
+	/* type */
+	status = nfsd4_encode_acetype4(xdr, NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE);
+	if (status != nfs_ok)
+		return nfserr_resource;
+	/* flag */
+	status = nfsd4_encode_aceflag4(xdr, 0);
+	if (status != nfs_ok)
+		return nfserr_resource;
+	/* access mask */
+	status = nfsd4_encode_acemask4(xdr, 0);
+	if (status != nfs_ok)
+		return nfserr_resource;
+	/* who - empty for now */
+	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_encode_open_read_delegation4(struct xdr_stream *xdr, struct nfsd4_open *open)
+{
+	__be32 status;
+
+	/* stateid */
+	status = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
+	if (status != nfs_ok)
+		return status;
+	/* recall */
+	status = nfsd4_encode_bool(xdr, open->op_recall);
+	if (status != nfs_ok)
+		return status;
+	/* permissions */
+	return nfsd4_encode_open_nfsace4(xdr);
+}
 
 static __be32
 nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
@@ -4106,22 +4149,8 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	case NFS4_OPEN_DELEGATE_NONE:
 		break;
 	case NFS4_OPEN_DELEGATE_READ:
-		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
-		if (nfserr)
-			return nfserr;
-		p = xdr_reserve_space(xdr, 20);
-		if (!p)
-			return nfserr_resource;
-		*p++ = cpu_to_be32(open->op_recall);
-
-		/*
-		 * TODO: ACE's in delegations
-		 */
-		*p++ = cpu_to_be32(NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE);
-		*p++ = cpu_to_be32(0);
-		*p++ = cpu_to_be32(0);
-		*p++ = cpu_to_be32(0);   /* XXX: is NULL principal ok? */
-		break;
+		/* read */
+		return nfsd4_encode_open_read_delegation4(xdr, open);
 	case NFS4_OPEN_DELEGATE_WRITE:
 		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
 		if (nfserr)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index aba07d5378fc..c142a9b5ab98 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -389,7 +389,7 @@ struct nfsd4_open {
 	u32		op_deleg_want;      /* request */
 	stateid_t	op_stateid;         /* response */
 	__be32		op_xdr_error;       /* see nfsd4_open_omfg() */
-	u32		op_recall;          /* recall */
+	bool		op_recall;          /* response */
 	struct nfsd4_change_info  op_cinfo; /* response */
 	u32		op_rflags;          /* response */
 	bool		op_truncate;        /* used during processing */


