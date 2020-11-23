Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764802C1622
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgKWULZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732692AbgKWULX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:11:23 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD800C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:23 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g17so14382136qts.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AEIvx+SfYdCWj4v4dAdxH+w+eUkq4jQPWI0bSgr0+rk=;
        b=hmLl0qSNrjDOIV83+hRtxnWTJEWkrVcusCytus3erCHh6vkNSlDigYSuq91500lr6N
         nwm31ME9QvdtLuZpA6BniWbF5wdDqProguS3pqdA/7dQA5ptYORCikVCu8XuVks+784w
         7Vilu93J0jytjzvdRnu6Mdyh9fsph/Vedu/Hkx0RtD30ubfskSl4/rKWSmNFXLJBTYXS
         DLxWQLTOw2rC2ycu7zUVOIx0Tw+0v9P/WYf2Wn0yNNyse14omcLNLvQ9pXu2qMuZcnpd
         6o9HGqAw8zhkNEcEP7v5FYl18dqyxxiTZyWFQ0OfC7lzgHS1aR/Tk6bIeovJECUlFUtV
         XHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AEIvx+SfYdCWj4v4dAdxH+w+eUkq4jQPWI0bSgr0+rk=;
        b=PpKV1AvJxAOrDShMrSFIGLDZQh5wVAbIL63vJAC3/q0S4p2RsLw5OwinhBdZtbDO50
         DGVyZPs54wHT3h6ukqCjH3ZfzXwhVSNaWIogZ2HzYRHsLBVGbyBljbEXErDhJGj/8NLb
         vaZQovDAd5cnhXHIOtBbgT+niGvU2ISo4NaWuEg18VfYxkqn9pZ7Z2NlPsHDnfve+K1i
         /sOKR6P7xzk8ABiHmpJEeTpLb/NHOSqx97iLJK6YZsEyA5giLRkTjioXbC8ItMNNWxEA
         NveG0CLQwk890Nj+aC8WnIdq8YY/SWF3PpC+CBr2BvQs/c5j1hSn976VMSoD1/WaEJkN
         iXAA==
X-Gm-Message-State: AOAM533xZdn6kNlZqfVx5CPvyuULSHAxMqdOLUamOlNVlXHErrr6iMaR
        vz8eTOTArKIWrcXT0p7uN/gGWKl56BQ=
X-Google-Smtp-Source: ABdhPJyAiBNzclYZIRYGWAlmwuSslWr8mMSw0S9Z3y/oKY6RIj+2tVFZ4XpE/tpbAHIbRvYrSoDe0g==
X-Received: by 2002:ac8:594c:: with SMTP id 12mr934434qtz.224.1606162282561;
        Mon, 23 Nov 2020 12:11:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w21sm3203082qki.6.2020.11.23.12.11.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:11:21 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKBKTO010536
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:11:20 GMT
Subject: [PATCH v3 84/85] NFSD: Replace READ* macros in
 nfsd4_decode_compound()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:11:20 -0500
Message-ID: <160616228082.51996.11001416060770878467.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

And clean-up: Now that we have removed the DECODE_TAIL macro from
nfsd4_decode_compound(), we observe that there's no benefit for
nfsd4_decode_compound() to return nfs_ok or nfserr_bad_xdr only to
have its sole caller convert those values to one or zero,
respectively. Have nfsd4_decode_compound() return 1/0 instead.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   69 ++++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9dc67cf58684..1e81c8e1e98a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -186,28 +186,6 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
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
@@ -2372,43 +2350,54 @@ nfsd4_opnum_in_range(struct nfsd4_compoundargs *argp, struct nfsd4_op *op)
 	return true;
 }
 
-static __be32
+static int
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
+		return 0;
+	max_reply += XDR_UNIT;
+	argp->tag = NULL;
+	if (unlikely(argp->taglen)) {
+		if (argp->taglen > NFSD4_MAX_TAGLEN)
+			return 0;
+		p = xdr_inline_decode(argp->xdr, argp->taglen);
+		if (!p)
+			return 0;
+		argp->tag = svcxdr_tmpalloc(argp, argp->taglen);
+		if (!argp->tag)
+			return 0;
+		memcpy(argp->tag, p, argp->taglen);
+		max_reply += xdr_align_size(argp->taglen);
+	}
+
+	if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
+		return 0;
+
 	/*
 	 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
 	 * here, so we return success at the xdr level so that
 	 * nfsd4_proc can handle this is an NFS-level error.
 	 */
 	if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
-		return 0;
+		return 1;
 
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops = kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
 		if (!argp->ops) {
 			argp->ops = argp->iops;
 			dprintk("nfsd: couldn't allocate room for COMPOUND\n");
-			goto xdr_error;
+			return 0;
 		}
 	}
 
@@ -2420,7 +2409,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		op->replay = NULL;
 
 		if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
-			return nfserr_bad_xdr;
+			return 0;
 		if (nfsd4_opnum_in_range(argp, op)) {
 			op->status = nfsd4_dec_ops[op->opnum](argp, &op->u);
 			if (op->status != nfs_ok)
@@ -2467,7 +2456,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 	if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
 		clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
 
-	DECODE_TAIL;
+	return 1;
 }
 
 static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
@@ -5479,7 +5468,7 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 	args->ops = args->iops;
 	args->rqstp = rqstp;
 
-	return !nfsd4_decode_compound(args);
+	return nfsd4_decode_compound(args);
 }
 
 int


