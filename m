Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C17B3414
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjI2N7Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 09:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2N7P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 09:59:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F6DB
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 06:59:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E722C433C7;
        Fri, 29 Sep 2023 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695995953;
        bh=5OcLGyi8ZK+P310haybX1H+5u659zCcIaFCGHdeV/RM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Srtcgo8rhjwzVAc+gSf/4isxjMLtWPQZi3rp/rxHkRL7AXzg++56Ur4caJ+DkclJx
         hsfFFnNVkP6E3MAERGr+nOx6WpH6xgxOt3VBYETdRcytzUfEEM1Xzze5gYQS8mf6kB
         IRY2KRqfPqr+lHr0sIq/R6O/FrWk/+OJOni0H3w8MVzOS/3NWdVWHNo6uoA3+hqRbv
         THtmrrRlr8uxnA0f7pDwBPmzWuB4RPteXNx2pzHuMjmA4C238RqRAa/hoDqAJ9z83q
         CKCBu1K42Nm5q5YgwykXz0rgIubtWRU892XOanWerIyqY0/wsWD/d4PT6/fWv49bhZ
         2BTfEmJl65yqw==
Subject: [PATCH v1 4/7] NFSD: Add nfsd4_encode_open_write_delegation4()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 09:59:12 -0400
Message-ID: <169599595225.5622.1769103727125659736.stgit@manet.1015granger.net>
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

Make it easier to adjust the XDR encoder to handle new features
related to write delegations.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   59 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f411fcc435f6..f7e5f54fda00 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4118,6 +4118,37 @@ nfsd4_encode_open_read_delegation4(struct xdr_stream *xdr, struct nfsd4_open *op
 	return nfsd4_encode_open_nfsace4(xdr);
 }
 
+static __be32
+nfsd4_encode_nfs_space_limit4(struct xdr_stream *xdr, u64 filesize)
+{
+	/* limitby */
+	if (xdr_stream_encode_u32(xdr, NFS4_LIMIT_SIZE) != XDR_UNIT)
+		return nfserr_resource;
+	/* filesize */
+	return nfsd4_encode_uint64_t(xdr, filesize);
+}
+
+static __be32
+nfsd4_encode_open_write_delegation4(struct xdr_stream *xdr,
+				    struct nfsd4_open *open)
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
+	/* space_limit */
+	status = nfsd4_encode_nfs_space_limit4(xdr, 0);
+	if (status != nfs_ok)
+		return status;
+	return nfsd4_encode_open_nfsace4(xdr);
+}
+
 static __be32
 nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  union nfsd4_op_u *u)
@@ -4152,32 +4183,8 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 		/* read */
 		return nfsd4_encode_open_read_delegation4(xdr, open);
 	case NFS4_OPEN_DELEGATE_WRITE:
-		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
-		if (nfserr)
-			return nfserr;
-
-		p = xdr_reserve_space(xdr, XDR_UNIT * 8);
-		if (!p)
-			return nfserr_resource;
-		*p++ = cpu_to_be32(open->op_recall);
-
-		/*
-		 * Always flush on close
-		 *
-		 * TODO: space_limit's in delegations
-		 */
-		*p++ = cpu_to_be32(NFS4_LIMIT_SIZE);
-		*p++ = xdr_zero;
-		*p++ = xdr_zero;
-
-		/*
-		 * TODO: ACE's in delegations
-		 */
-		*p++ = cpu_to_be32(NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE);
-		*p++ = cpu_to_be32(0);
-		*p++ = cpu_to_be32(0);
-		*p++ = cpu_to_be32(0);   /* XXX: is NULL principal ok? */
-		break;
+		/* write */
+		return nfsd4_encode_open_write_delegation4(xdr, open);
 	case NFS4_OPEN_DELEGATE_NONE_EXT: /* 4.1 */
 		switch (open->op_why_no_deleg) {
 		case WND4_CONTENTION:


