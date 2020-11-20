Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14682BB796
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbgKTUmE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbgKTUmE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:04 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F85C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:03 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r7so10230012qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EK1EF1WypRQJEN/mZfcN9BJ3mwAQGyQt3Hcg09sao24=;
        b=ChQvBI+tCS30VW8F1BKg8DpBfAWQQuM1i02erYn8h6Td4CQJTp/15q+2R6D4TP68z3
         E3eLzErUdR3BHKp8lwXcuqae5nz4DUid5t/9AyLh9OHMjCn/a/Cp2JYQVcbT3PLtMIZN
         hb9zyed5KKPy1o+iRPTYyluuEIm7NIXocF+qJVjWaQbZtXTaVKZvwvRyxKS2xE362qyw
         as9372WSobf5M4Bgh6KN1IF0nwBw1vWCQRHjM17S9VS4yZQm0N+z5VVWM83eNZafDxIR
         2a5oc+hSCsLzLfn0UfUCcSwP8LR28YxJKCE446Pveq0T3MFa1JKRv5Of5y50viF71oWN
         VuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EK1EF1WypRQJEN/mZfcN9BJ3mwAQGyQt3Hcg09sao24=;
        b=ccAMVypTw+yw+HtVPFpFGw2FKKMwRJ9uoe6vIxlT72MwIr0KYOU9jKJPgdxw7F8yjc
         Amq7isbYlm06kRPh0w4XkqZ14oFgIUvVZ1iQXve2Zq1iqcuMM0RUnm0Dpgnquxmwj0Hf
         1h1//z/tQzkEN60Nwv3NQ4JRtlbAStcN0Us/ry7MDfTOdqMvla3Q4zlikBpRHd9lkTsR
         FT76lt/l5TjXM0Cz3ZRG0YmdizxXV9sBR19qBZ2O/e93r+hrewO5n4itP3WuQ1HuslFn
         /ZOj8sIGMS/FrNAXoQUEDXbBNtNBIEqwpZwVO7BwYw4E0ea81Hvmnl23EGOX6IorCx+D
         MnCg==
X-Gm-Message-State: AOAM530QUfSIFnmf72bVbpT96fy5yzXLDSTYpiAevNkthJNo1fha07i5
        E0joexex8imMBR0Ugq87doiU7O7XGf4=
X-Google-Smtp-Source: ABdhPJy9Ss0Z3JvAKMaQgu1UNq5BASKuCZ1tDbdlgzKFaT/4UIoG+tQzElsdPe3l+qUtLbDODybTqQ==
X-Received: by 2002:a05:620a:228a:: with SMTP id o10mr17938812qkh.111.1605904922824;
        Fri, 20 Nov 2020 12:42:02 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l91sm2782127qte.28.2020.11.20.12.42.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:02 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKg1al029492
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:01 GMT
Subject: [PATCH v2 093/118] NFSD: Update the CREATE3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:01 -0500
Message-ID: <160590492114.1340.10030051796236992956.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 5c46ab972a23..ba1b24f54443 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -587,26 +587,26 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-
-	switch (args->createmode = ntohl(*p++)) {
+	if (!svcxdr_decode_diropargs3(xdr, &args->fh, &args->name, &args->len))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->createmode) < 0)
+		return XDR_DECODE_FAILED;
+	switch (args->createmode) {
 	case NFS3_CREATE_UNCHECKED:
 	case NFS3_CREATE_GUARDED:
-		p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
-		break;
+		return svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
 	case NFS3_CREATE_EXCLUSIVE:
-		args->verf = p;
-		p += 2;
+		args->verf = xdr_inline_decode(xdr, NFS3_CREATEVERFSIZE);
+		if (!args->verf)
+			return XDR_DECODE_FAILED;
 		break;
 	default:
-		return 0;
+		return XDR_DECODE_FAILED;
 	}
-
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
 int


