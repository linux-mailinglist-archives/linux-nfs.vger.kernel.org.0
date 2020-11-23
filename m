Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA912C161E
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgKWULU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728805AbgKWULS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:11:18 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F08C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:18 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 9so5250361qvk.9
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JchyUwTBcuGJcQ6GG8x1ugIgrFCQiEFYJIn5kih66pk=;
        b=DpBF08nCv8AJvsx6yrNH8hWUcmQ+scbPWVAj1RefX5bUKuaxjt+i7oJb9465lw3k4T
         FUIpBLQYt81Ss3IoEhsm3KEovlbqFETfuOtR7DqxMfnhGhKpweJHYbQ7ib3zUuYHcWoF
         JMRvXAH2geK5M5/l0mypq21BtB9gc/AA0+E7bDt7dSptkOSj+tbG1jcvZieuNyAM2RHm
         28JoMR7IudY8VVwyI4+8cvTRKreM84Oz8mWjNxf3CwAdfIZDnGVgiaKsrt0heS5mNurK
         gXrtalPpTmJt1V8twNUViu8FIALhmCF1imOv+/iGnhbLgHpydE9jdrR7ZQwQUGLdKniF
         yuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JchyUwTBcuGJcQ6GG8x1ugIgrFCQiEFYJIn5kih66pk=;
        b=av5bfXyioGtsz5Qj8B1jsT7zGI2N8Ns6cQhXMujLWLqUzbMLjB/JVnT8A1ImsxYjb1
         gUVfby+7NA8vEX47xjRWR9oRllOAZHXKzwoeplit5cWl+D7xCo17mppUYqg2we4WqPTW
         BbMEP5WG6UCsOLnoel/+osyQ8fA9hzL0CBHC8tiBlK6Kye2S7rcELltHOLEJfLcZMgcA
         O43oJQJqGqPX6T3r8Dwl3pr6FfEYGMRsGTEKE2kSw7bgmmsyB+n5HGeNtCVzduNw2XSZ
         exuj7jx5HMVz7YrydwcEvxmr7sPYSbjz9ct207jK/v6+U1XJMQyIeOkpTMqqMQKOBBUY
         5Xsg==
X-Gm-Message-State: AOAM5332mK13r4TuduzHEKGCfo9vqzZXLE15KX3VoOB5ZmjsAuVhJsYd
        wIkNbYlphWHJS8Pz+qrNZgozNIQexUA=
X-Google-Smtp-Source: ABdhPJyE/99I8qSrLSZ6SMffGv1WbGdV4raDw20+kGk0Qh7Bs37YmiSEsJyU7hvswNFxRmGuYkugRQ==
X-Received: by 2002:a0c:90a1:: with SMTP id p30mr1203070qvp.38.1606162277136;
        Mon, 23 Nov 2020 12:11:17 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b18sm8830232qtr.84.2020.11.23.12.11.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:11:16 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKBF5O010533
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:11:15 GMT
Subject: [PATCH v3 83/85] NFSD: Make nfsd4_ops::opnum a u32
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:11:15 -0500
Message-ID: <160616227547.51996.3683957349728629041.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Avoid passing a "pointer to int" argument to xdr_stream_decode_u32.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    2 +-
 fs/nfsd/nfs4xdr.c  |    7 +++----
 fs/nfsd/xdr4.h     |    2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 56d074a6cb31..73e717609213 100644
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
index 8163c529e497..9dc67cf58684 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2419,9 +2419,8 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		op = &argp->ops[i];
 		op->replay = NULL;
 
-		READ_BUF(4);
-		op->opnum = be32_to_cpup(p++);
-
+		if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
+			return nfserr_bad_xdr;
 		if (nfsd4_opnum_in_range(argp, op)) {
 			op->status = nfsd4_dec_ops[op->opnum](argp, &op->u);
 			if (op->status != nfs_ok)
@@ -5378,7 +5377,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
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


