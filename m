Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F238F2BB792
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbgKTUln (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbgKTUlm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:42 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812F2C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:42 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so8082182qte.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zDHlJFShehBJ5q3rk0/vPtJFyYq9axb9YDkwUwvA/p8=;
        b=Im9sMlJHzrVisXRtybyKQOViK9qEOKvQ0UaMI5Sdh09HUh1ckliHFREY7xxjFYkvCo
         2Kn+7IodRH1rPsMiKeTbuinuXqRwsaxpDoxMa7wEbqo6eF0nxNHRUFY0pUQsKUT1WllA
         HfE6bwjcIghIIavgmKL96nxTRVR1Cqb5BCgCW08nnv0LhaFcuTXIcggSmqBjlNdrwge+
         ygGLr1nV29k9W8p50DwyQb9H4Xr7Ss6ou6cohObsSAN5ICNY7/KOURZHUDMfKTpGbfPj
         rauRncA9UMYrLleGCpF8/X165uv2Wi4OlzSAMvwutyKdfyUBzUFLXsxgrIeG1aunAylh
         18Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zDHlJFShehBJ5q3rk0/vPtJFyYq9axb9YDkwUwvA/p8=;
        b=e38fBGYz8MXRRWuiyvG/1CPmKg58gUX2vi9Zl/kPzGbtZuPl87Kp92yCYexzYjcX+A
         HFVpNDkkJjQLvBfE02+WXdJ7Fn9Ce75MpxdcLFODfZdTCKN6L+9xQdkPGgC3wyYnymPC
         5pYAvQn50HuAq12oDyYE0OH+DY8pznjxhSTjNPZXpxljc6J0h7/DqPGn7qJe55c0840J
         KVqlhwIFcoHiB2rNkaT4mRBLAJSyhjnYA+zrCMt0PE8/Dbmf6Jrcp9b/fLPKChLLUsoY
         RtjE8HZ1c8Z7+O4174ORVSqkHuT5ah8bavCfArmBZQzablw+HFwUqo3X8dKwxob2yxVD
         HBvA==
X-Gm-Message-State: AOAM531lyX1L01bx17P0vwfZv2jmOUqT6X3kxVrq1DbR+pP0GdoLHnuD
        PwccjySZrkxP6qvBrTELBUe4vsoqngU=
X-Google-Smtp-Source: ABdhPJwxvk60SXr2YeiOjCgyMLHpikdhM/zgfhSgtoiAE76f7DXmJC1c4M8z0BNqTovnApWpB2LiYw==
X-Received: by 2002:a05:622a:d4:: with SMTP id p20mr17845338qtw.172.1605904901444;
        Fri, 20 Nov 2020 12:41:41 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r89sm2770055qtd.16.2020.11.20.12.41.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:40 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKfd7t029480
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:39 GMT
Subject: [PATCH v2 089/118] NFSD: Update the NFSv3 DIROPargs decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:39 -0500
Message-ID: <160590489973.1340.18263417706725689257.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index a74c309ad429..763bac27cfda 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -117,6 +117,40 @@ decode_filename(__be32 *p, char **namp, unsigned int *lenp)
 	return p;
 }
 
+static enum xdr_decode_result
+svcxdr_decode_filename3(struct xdr_stream *xdr, char **name, unsigned int *len)
+{
+	u32 size, i;
+	__be32 *p;
+	char *c;
+
+	if (xdr_stream_decode_u32(xdr, &size) < 0)
+		return XDR_DECODE_FAILED;
+	if (size == 0 || size > NFS3_MAXNAMLEN)
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, size);
+	if (!p)
+		return XDR_DECODE_FAILED;
+
+	*len = size;
+	*name = (char *)p;
+	for (i = 0, c = *name; i < size; i++, c++) {
+		if (*c == '\0' || *c == '/')
+			return XDR_DECODE_FAILED;
+	}
+
+	return XDR_DECODE_DONE;
+}
+
+static enum xdr_decode_result
+svcxdr_decode_diropargs3(struct xdr_stream *xdr, struct svc_fh *fhp,
+			 char **name, unsigned int *len)
+{
+	if (!svcxdr_decode_nfs_fh3(xdr, fhp))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_filename3(xdr, name, len);
+}
+
 static __be32 *
 decode_sattr3(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 {
@@ -357,13 +391,10 @@ nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_diropargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len);
 }
 
 int


