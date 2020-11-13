Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD02B1E3D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKMPHo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgKMPHn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:43 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C7DC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:43 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h15so8992828qkl.13
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2udU+k42nj7AHqpsPJS5UzjEd83YyLvzDJNvz9lQzPQ=;
        b=r1NZKlvy7NcbgLU+I34Imyyii7fY+Oh+htm9R1u35S4CC/nBAqaOUc0Q3AuQsjiCvf
         OPbs3z/Oz/ngX4ZVzg0Or0eGifja9oOwyXMRm+9OuWAnUdzQ/KcVTxJHwBmRpQj92jCM
         Cl1xQilzJm0v5zSczd5IKnKmARSz48D6niFlqlelmUPmkD/8QMxpnzpO7KkASOxocH1R
         JZSsh1w+554bq/JQUBCITUQlPWu4Ad+TttNvy24cRbo9QadTTjbwY2Aw2RVPLLgrbUPd
         9TVlLLXqWAhpdNGIi9KArlft6t4yyUx30MmzbHmxwc1LwdUxKQi/B1VCuZeenMd5Lljl
         Rshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2udU+k42nj7AHqpsPJS5UzjEd83YyLvzDJNvz9lQzPQ=;
        b=jmwm5EpnbepXl8y1JWSEMGzFgRrVEuicD+ebJQoabfrDb6IGEr5d3US7bQs9BJeWqV
         yGuJ7fCtoAK7zxgFBbNEVP2bCB+r7ICJeGWVzhzmP+r+oMwn2r3mdpVXk+SaQHb3XIDK
         tZQFY7jOQr7tgidDp4TCu2E7aD962i3iW+CGlCBNyddG3f1DDkWb8JgN3NTSANyTbYCY
         +2qu3QeopkQYVWia7SzU/qzoBxiWOY1V2dqjdFCRXpF10Dsd3dG4a2UwRvws7ssPBoRN
         Z/WcGK/V4NPxngzQPn7n6AJp76qUz+jWR0EvcRyC813l8oTox+49tFv22e9HIE7yDjFU
         cdWw==
X-Gm-Message-State: AOAM531wIb7bXcSWzhdFQOX5mUtQSDJrHpZo1uRSXkHWNzLVuaphJfX/
        jK0xkNUSIrdyhSODsd+GOp62vFA1a4U=
X-Google-Smtp-Source: ABdhPJwSgJyZFhnYgAzwbwH25WJeMAUJ+mzgyoBFN8mWhfRkmguBAF5+IByvAWWTtMJd0io1pORsdw==
X-Received: by 2002:a37:82c5:: with SMTP id e188mr2318576qkd.58.1605280060979;
        Fri, 13 Nov 2020 07:07:40 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o63sm6578912qkd.96.2020.11.13.07.07.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:40 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF7d6B000349
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:39 GMT
Subject: [PATCH v1 60/61] NFSD: Replace READ* macros in
 nfsd4_decode_compound()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:39 -0500
Message-ID: <160528005934.6186.2184546567789022367.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/nfs4xdr.c  |   67 +++++++++++++++++++++++-----------------------------
 fs/nfsd/xdr4.h     |    2 +-
 3 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b810d048c5f8..205e1b3ce629 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3281,7 +3281,7 @@ int nfsd4_max_reply(struct svc_rqst *rqstp, struct nfsd4_op *op)
 void warn_on_nonidempotent_op(struct nfsd4_op *op)
 {
 	if (OPDESC(op)->op_flags & OP_MODIFIES_SOMETHING) {
-		pr_err("unable to encode reply to nonidempotent op %d (%s)\n",
+		pr_err("unable to encode reply to nonidempotent op %u (%s)\n",
 			op->opnum, nfsd4_op_name(op->opnum));
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4332b16cfdc8..3ab248433f44 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -184,28 +184,6 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
 	return p;
 }
 
-/**
- * savemem - duplicate a chunk of memory for later processing
- * @argp: NFSv4 compound argument structure to be freed with
- * @p: pointer to be duplicated
- * @nbytes: length to be duplicated
- *
- * Returns a pointer to a copy of @nbytes bytes of memory at @p
- * that are preserved until processing of the NFSv4 compound
- * operation described by @argp finishes.
- */
-static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
-{
-	void *ret;
-
-	ret = svcxdr_tmpalloc(argp, nbytes);
-	if (!ret)
-		return NULL;
-	memcpy(ret, p, nbytes);
-	return ret;
-}
-
-
 /*
  * NFSv4 basic data type decoders
  */
@@ -2462,33 +2440,43 @@ nfsd4_opnum_in_range(struct nfsd4_compoundargs *argp, struct nfsd4_op *op)
 static __be32
 nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 {
-	DECODE_HEAD;
 	struct nfsd4_op *op;
 	bool cachethis = false;
 	int auth_slack= argp->rqstp->rq_auth_slack;
 	int max_reply = auth_slack + 8; /* opcnt, status */
 	int readcount = 0;
 	int readbytes = 0;
+	__be32 *p;
 	int i;
 
-	READ_BUF(4);
-	argp->taglen = be32_to_cpup(p++);
-	READ_BUF(argp->taglen);
-	SAVEMEM(argp->tag, argp->taglen);
-	READ_BUF(8);
-	argp->minorversion = be32_to_cpup(p++);
-	argp->opcnt = be32_to_cpup(p++);
-	max_reply += 4 + (XDR_QUADLEN(argp->taglen) << 2);
+	if (xdr_stream_decode_u32(argp->xdr, &argp->taglen) < 0)
+		goto xdr_error;
+	argp->tag = NULL;
+	if (unlikely(argp->taglen)) {
+		if (argp->taglen > NFSD4_MAX_TAGLEN)
+			goto xdr_error;
+		p = xdr_inline_decode(argp->xdr, argp->taglen);
+		if (!p)
+			goto xdr_error;
+		argp->tag = svcxdr_tmpalloc(argp, argp->taglen);
+		if (!argp->tag)
+			goto nomem;
+		memcpy(argp->tag, p, argp->taglen);
+	}
 
-	if (argp->taglen > NFSD4_MAX_TAGLEN)
+	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
 		goto xdr_error;
+	max_reply += 4 + xdr_align_size(argp->taglen);
+
 	/*
 	 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
 	 * here, so we return success at the xdr level so that
 	 * nfsd4_proc can handle this is an NFS-level error.
 	 */
 	if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
-		return 0;
+		goto out;
 
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops = kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
@@ -2506,8 +2494,8 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		op = &argp->ops[i];
 		op->replay = NULL;
 
-		READ_BUF(4);
-		op->opnum = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
+			goto xdr_error;
 
 		if (nfsd4_opnum_in_range(argp, op))
 			op->status = nfsd4_dec_ops[op->opnum](argp, &op->u);
@@ -2550,7 +2538,12 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
 		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
 
-	DECODE_TAIL;
+out:
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
 }
 
 static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
@@ -5460,7 +5453,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	if (op->status && opdesc &&
 			!(opdesc->op_flags & OP_NONTRIVIAL_ERROR_ENCODE))
 		goto status;
-	BUG_ON(op->opnum < 0 || op->opnum >= ARRAY_SIZE(nfsd4_enc_ops) ||
+	BUG_ON(op->opnum >= ARRAY_SIZE(nfsd4_enc_ops) ||
 	       !nfsd4_enc_ops[op->opnum]);
 	encoder = nfsd4_enc_ops[op->opnum];
 	op->status = encoder(resp, op->status, &op->u);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 232529bc1b79..749c2d711d21 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -615,7 +615,7 @@ struct nfsd4_copy_notify {
 };
 
 struct nfsd4_op {
-	int					opnum;
+	u32					opnum;
 	const struct nfsd4_operation *		opdesc;
 	__be32					status;
 	union nfsd4_op_u {


