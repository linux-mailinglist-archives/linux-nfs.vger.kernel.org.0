Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC712BB793
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbgKTUls (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbgKTUls (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:48 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4555C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:47 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so10202312qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xmNMNloWuQykysGcG8jFbNAa4qupzahWyr3djQKPmMg=;
        b=HEN6e80oG0V0aEyB2dvJxqpVfZrf+16I9Fq3f+CBrBzPPp+FEj92H1yNdy/zl6ZZ4a
         mVyHhBPp3Lccn2S0t3YqFI+d6N84MpTEw10OVDs2/U+TIn9s6P1ukneyudocfK8GjvJy
         gKEIBiuaciqZ4xSImNbKjMzepbU3B8WP6uo+GczNu9Cqgb+5iB0/ks55uqcbKGEEDKKC
         7wpxfw3lbzev3B9DNBPVYpvXJpFrN1RHAl6M/VgQZa9TCwP9WjTi244QNlMcVPn9WYxe
         y0UXpUKES1OC650K1y87Aagsj/1yGrKiZ7xxml1HNijLywIkoS4p1jsrbkL2kY9s1UJa
         XUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=xmNMNloWuQykysGcG8jFbNAa4qupzahWyr3djQKPmMg=;
        b=g+M908tlXjfZCiGM5rlLEACrVZJjZ/5U61S5E06PyBKGTA6xp7785yDmIVQVPrt8dW
         zWMQ3VAvB+WoLdCuCDZDzjfShTaJQxIQpdvaFBDhraDt3vxVxciJFH5J9KY0ZcyCWcpt
         xd9KeWQMW/skH9nbCYixN9pL05UpgXmqbGKAXjd495hPe6nICaxmL9MJFYAdvifrclQU
         J6rej1sC5l/IFOfCjLCxP4/5L+UOoHs8zwi8vobIrP9pacapqRNjW/lAxF7fQcjQAjpm
         EIBY0UJRnv/RtEuUul0FALd/3VlLygNepCRDQWOOtPbCzkvC2ocqQdXEMe22PkRzkqiX
         ia1A==
X-Gm-Message-State: AOAM532IrbAAiXDFSo056z8EvacJf9XR/EOl1wbSEsMcQnIapmvjbF7q
        HSWN+yRX3uJqfXEW3OwlGcixuuOHMSc=
X-Google-Smtp-Source: ABdhPJyKHfVaCCt5ml6F3mrzvEGc8eDxJvsU/nMbUWnsFoqN1ABG1g68ubIasAnnERoL/jsT7ZBjNg==
X-Received: by 2002:a37:e40b:: with SMTP id y11mr19117610qkf.29.1605904906790;
        Fri, 20 Nov 2020 12:41:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g9sm2723241qti.86.2020.11.20.12.41.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:46 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKfj3T029483
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:45 GMT
Subject: [PATCH v2 090/118] NFSD: Update the RENAME3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:45 -0500
Message-ID: <160590490507.1340.11081683796515808744.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 763bac27cfda..f941bd740963 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -557,15 +557,12 @@ nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_renameargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->ffh))
-	 || !(p = decode_filename(p, &args->fname, &args->flen))
-	 || !(p = decode_fh(p, &args->tfh))
-	 || !(p = decode_filename(p, &args->tname, &args->tlen)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_diropargs3(xdr, &args->ffh, &args->fname, &args->flen))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_diropargs3(xdr, &args->tfh, &args->tname, &args->tlen);
 }
 
 int


