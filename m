Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA622BB734
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgKTUfv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbgKTUfv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:51 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA7C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:51 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k4so10162355qko.13
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KsqcxCQFDd4GFX51/pGCqM+CtfAlKt+kTbA+7evFQvY=;
        b=XYTQbjBJnmMtwEve87erNAILONkxPEfLX8O2GsWZ3U+JxfNsUVDqzEyFpdr7YOqCcy
         vUep/3GNUJyw1+AVxt9BzgpAUwYN9uWoJrIeiC5a4BqsIbz9qcmc9jbKeXPhXQ/QehBh
         lBo/wmWBfnQoR5s7rmXdgB7NpOkf0nGy9DR9Zeuz4O358sYccpXW84K3Xi/n65aQuemd
         vBd6ncG0Rz2Drd/ZfEgNQAB24RuExzcgf+37JTbLHiC/+lqxElN/wnFvn19nG0qeKGuC
         7kfq1y77lGK6fHFaFIrBgsaNLMGsycW09eoxnng1xifbR/MJ2O707GZHvq66lHh5HJWP
         SGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KsqcxCQFDd4GFX51/pGCqM+CtfAlKt+kTbA+7evFQvY=;
        b=r+/owBwBFlNLybO6VyaNyemvQ9oT2ti8rR6ABZBDlkF5AS1YtdGrUt3pwDaDSO6LnB
         AHD9k5X0hYstD6zaesMNn1ykedQkZTJEFP8kirxY6S/Ds8xs5y9yVXkNdvBtgQbu/Fjr
         2rf1hQi59tYYqFYjbz8HiMDAPcV4qA28gud6Qw4QD3RJA/cv31eqFRp3VPhScuFTSB+/
         +XNUsugZdXFxqHXrm1SGo6fedgf72kCgCDwYfSsciLgvzlT5zA2JicnwZqOogi+R64vh
         lBlpEIHrjfAT2HB/A/DCRaJnBoaZgM3LqZdag0+WR0Jg/arZD6tJasXqEAF6lHf1TMt7
         a4BA==
X-Gm-Message-State: AOAM530Nj/K1KSvt6dQOKb66aKrx8TbhXtnaaYCAWvdQzz4FgfnM+50T
        L9MY1UmDH3cawxikGksFkh/qsFHfA4w=
X-Google-Smtp-Source: ABdhPJxHJvNbG5yyy3NWQ383WS/pdmdBH0/22NEG/o7is594n04esv3eaVaVwuqxCOLBeXP03Hq3sQ==
X-Received: by 2002:a37:9d48:: with SMTP id g69mr18126714qke.398.1605904550382;
        Fri, 20 Nov 2020 12:35:50 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d3sm2647510qth.70.2020.11.20.12.35.49
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:49 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZmL8029271
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:48 GMT
Subject: [PATCH v2 023/118] NFSD: Relocate nfsd4_decode_opaque()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:48 -0500
Message-ID: <160590454868.1340.9283263045389488150.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enable nfsd4_decode_opaque() to be used in more decoders, and
replace the READ* macros in nfsd4_decode_opaque().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8c0d4c4d7b42..ec2cad8477e0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -205,6 +205,33 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
 	return ret;
 }
 
+
+/*
+ * NFSv4 basic data type decoders
+ */
+
+static __be32
+nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
+{
+	__be32 *p;
+	u32 len;
+
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		return nfserr_bad_xdr;
+	if (len == 0 || len > NFS4_OPAQUE_LIMIT)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, len);
+	if (!p)
+		return nfserr_bad_xdr;
+	o->data = svcxdr_tmpalloc(argp, len);
+	if (!o->data)
+		return nfserr_jukebox;
+	o->len = len;
+	memcpy(o->data, p, len);
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_component4(struct nfsd4_compoundargs *argp, char **namp, u32 *lenp)
 {
@@ -890,22 +917,6 @@ static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 	return nfserr_bad_xdr;
 }
 
-static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	o->len = be32_to_cpup(p++);
-
-	if (o->len == 0 || o->len > NFS4_OPAQUE_LIMIT)
-		return nfserr_bad_xdr;
-
-	READ_BUF(o->len);
-	SAVEMEM(o->data, o->len);
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 {


