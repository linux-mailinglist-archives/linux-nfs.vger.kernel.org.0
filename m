Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8D2EAE61
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbhAEPbe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbhAEPbd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:33 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E40C061795
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id p12so14792361qvj.13
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BOxgS0FJ1NzLgI6F21JD/o0tzVIZ/CHmLCW+HnYPLt4=;
        b=QiDuI0rN1TNiDnZy0qErbMuBLDsfjDSsUmtctMEzE0uoUICHye56kwkluH8KEWfrB/
         oi9Lag4Bq94j9vm9rjKGfLJqt7NyXelUvn3/psT/uiLvLeOuztOcU/jGBqhfwlVfq+/B
         GregwaNLyAC1F9tP0zw4s0kNMaeZ+qwgZLNJsNeIoVhtVIF4fqr4m9VsT2hteC5X1dc5
         mIcyRewp7HBytQVhKwbpZI5omIjS1HNEo/oJ04D8lHGaTH2ZhKpZx0lLFyL+RB9tHPbo
         K8PvCCX98lF+aTexDIqnljUPTjk5wg11lSYS7WJf/B4ID0AKAH3WeRTzOKl193yz5A6H
         nYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BOxgS0FJ1NzLgI6F21JD/o0tzVIZ/CHmLCW+HnYPLt4=;
        b=cezZx1zRQLILP/YWd1FZzl5ZLeyNaBNLbofSwMdkcVMm2MGI2gGWlDFjJv//slR27k
         hluYZt4+U/n7Z8OSo5AwCnT6EgeZHBo+ovJZIbfQOGRTaxXNQZzPi5nYJ0RpnZ2rYJ4O
         Jxbmw447JM1Iua7EmN6ZndqhaC4yzMiZQSEy83m+WVdtWSnbFCasZe0vQ3OH3PVyQR0D
         6wcGMnHbK+7Lmc0xQVFmvonhl8ib+HPW5Hmx2B+OK+m6X6G57snYC14i64Fp2YeRvqs5
         CwRlbbmHbHGs6h8Nl1fG0SQHnqdwHz5gwzMO0soN0riILIzdz8hQeDbj17tHZNPQn/xR
         SLpA==
X-Gm-Message-State: AOAM532CJ2cSXkf/IeIp6knUR3JXzOnh9QnZ4K81Yp4OdaibZcfaSey0
        yekreflC5u4luaMPV7VW4DNtEKL/PM0=
X-Google-Smtp-Source: ABdhPJw48f00pZzi2FRQrjTiy1Haz5FEqUrhGyALuczKJAi37qoFodTwFbWjUkCbXt4+StpNXLEeGQ==
X-Received: by 2002:ad4:4f41:: with SMTP id eu1mr140948qvb.1.1609860677600;
        Tue, 05 Jan 2021 07:31:17 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v4sm62029qth.16.2021.01.05.07.31.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:16 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVFw3020874
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:15 GMT
Subject: [PATCH v1 18/42] NFSD: Update the MKDIR3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:15 -0500
Message-ID: <160986067582.5532.3518167003498333903.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 559344c95de9..45975fdb033e 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -605,14 +605,12 @@ nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_createargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh)) ||
-	    !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-	p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs3(xdr, &args->fh,
+					&args->name, &args->len) &&
+		svcxdr_decode_sattr3(rqstp, xdr, &args->attrs);
 }
 
 int


