Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872412BB786
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgKTUkv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbgKTUkv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:51 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB8C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:49 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so10226394qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UYbZi3OMFErnEz09Wuzkp3V6XENwa6DGvM6duYdOzoU=;
        b=BegGf7s2RTwKwQZ843flLvT84MDegnE3eRRaFH1H1eP9zKoH46HLPGZ0Io4j9/NCUL
         JmFjgbQ3XTmemUFiLdV7vy3eRkdJZqfynFzzqQGuIKYyVGXLQgb9ODH83Te3jyvfJG0O
         S4gVk09MY0uITR+imraJivc+LjQqRg2meKanYEujW1AR1zY29Ohwh3U48NzDZJpzP1kZ
         neS+Qy8c80RhCsbOrjKPmeL0zxeiuAX2NZ5Cw1ywSjz08DMFswfd4wrtjpC29QCJPjZA
         uQbWvIrNwFfl5m8Z89wfEnDU/qs7ZDEWLI0h7lW6Z5VlZqnC/yPm1y7mmRQyRY5pciU7
         cNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UYbZi3OMFErnEz09Wuzkp3V6XENwa6DGvM6duYdOzoU=;
        b=c3DtJB3ousg5MZAK00lkCv526CMtRPOSdDomUbKMbz5zcS1lK+b/eedYYOMJAYmKZt
         uBQ8qlf+zLjsXjNyKoHB4E7xJ9GuGDJvH8+h7YCvOw6Y+XI8fL82S9QSoQm69v+vu6uH
         zS9Ph2/gAJLApQcwphaq5uAsMkU7rFN/Tz0smu2JcY2hvkEJ14WBeFvbZKcPitUcl36A
         KhAn73YrNa1kMbGn5KyEFkwo4vmb50XUXShFPLE4p4mgNXMNqejCRAyDvTs2x4fCHo1J
         A937VPV9L9Jq8x3LAkD8t6hL8/fOcFQyFEF5h+569F66vC2GkwJem0n/IjW01UMcSEul
         amlw==
X-Gm-Message-State: AOAM531Aiiijd23WKnDtYeMjAsXvOL/tVBkxZB+xiZr2Km2kt62IqZ1Y
        2Zm/u5PiLbiiFT4J74+wI7sgnedXUAs=
X-Google-Smtp-Source: ABdhPJzrl6HJWHhyIVHJfTuJ1FC2YtL9+gInmF15ywddEpunEBAsqe/LMOMQHeHGOlBWJ27wLGEqRA==
X-Received: by 2002:a05:620a:1087:: with SMTP id g7mr17963177qkk.457.1605904848353;
        Fri, 20 Nov 2020 12:40:48 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k4sm2746165qki.2.2020.11.20.12.40.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:47 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKekP4029450
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:46 GMT
Subject: [PATCH v2 079/118] NFSD: Replace READ* macros in
 nfsd4_decode_compound()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:46 -0500
Message-ID: <160590484650.1340.1386741469268410722.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 +
 fs/nfsd/nfs4xdr.c  |   70 ++++++++++++++++++++++------------------------------
 fs/nfsd/xdr4.h     |    2 +
 3 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 07756483aa70..b1a3f5cc8319 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3282,7 +3282,7 @@ int nfsd4_max_reply(struct svc_rqst *rqstp, struct nfsd4_op *op)
 void warn_on_nonidempotent_op(struct nfsd4_op *op)
 {
 	if (OPDESC(op)->op_flags & OP_MODIFIES_SOMETHING) {
-		pr_err("unable to encode reply to nonidempotent op %d (%s)\n",
+		pr_err("unable to encode reply to nonidempotent op %u (%s)\n",
 			op->opnum, nfsd4_op_name(op->opnum));
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 84c95a255826..da9b458cf9dc 100644
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
@@ -2327,40 +2305,51 @@ nfsd4_opnum_in_range(struct nfsd4_compoundargs *argp, struct nfsd4_op *op)
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
-
-	if (argp->taglen > NFSD4_MAX_TAGLEN)
-		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &argp->taglen) < 0)
+		return nfserr_bad_xdr;
+	max_reply += XDR_UNIT;
+	argp->tag = NULL;
+	if (unlikely(argp->taglen)) {
+		if (argp->taglen > NFSD4_MAX_TAGLEN)
+			return nfserr_bad_xdr;
+		p = xdr_inline_decode(argp->xdr, argp->taglen);
+		if (!p)
+			return nfserr_bad_xdr;
+		argp->tag = svcxdr_tmpalloc(argp, argp->taglen);
+		if (!argp->tag)
+			return nfserr_jukebox;
+		memcpy(argp->tag, p, argp->taglen);
+		max_reply += xdr_align_size(argp->taglen);
+	}
+
+	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
+		return nfserr_bad_xdr;
+
 	/*
 	 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
 	 * here, so we return success at the xdr level so that
 	 * nfsd4_proc can handle this is an NFS-level error.
 	 */
 	if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
-		return 0;
+		return nfs_ok;
 
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops = kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
 		if (!argp->ops) {
 			argp->ops = argp->iops;
 			dprintk("nfsd: couldn't allocate room for COMPOUND\n");
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		}
 	}
 
@@ -2371,9 +2360,8 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		op = &argp->ops[i];
 		op->replay = NULL;
 
-		READ_BUF(4);
-		op->opnum = be32_to_cpup(p++);
-
+		if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
+			return nfserr_bad_xdr;
 		if (nfsd4_opnum_in_range(argp, op))
 			op->status = nfsd4_dec_ops[op->opnum](argp, &op->u);
 		else {
@@ -2415,7 +2403,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
 		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
@@ -5325,7 +5313,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	if (op->status && opdesc &&
 			!(opdesc->op_flags & OP_NONTRIVIAL_ERROR_ENCODE))
 		goto status;
-	BUG_ON(op->opnum < 0 || op->opnum >= ARRAY_SIZE(nfsd4_enc_ops) ||
+	BUG_ON(op->opnum >= ARRAY_SIZE(nfsd4_enc_ops) ||
 	       !nfsd4_enc_ops[op->opnum]);
 	encoder = nfsd4_enc_ops[op->opnum];
 	op->status = encoder(resp, op->status, &op->u);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index facc5762bf83..2c31f3a7d7c7 100644
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


