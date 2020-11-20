Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0C2BB7A1
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgKTUnD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKTUnC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:02 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87428C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:02 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id a13so10251605qkl.4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2eTSmBY4E9XQiOKQqjOI701cyVedx2LDmxNwrJJ3iv0=;
        b=kd1et1RqvDid7Czli1HAdf/ER3223f18McYmXicPMVMCu+o2Swv9CIRw89qEa5rkXi
         btWknGPhkwmrOTeL4sNFSmoRvY2ai+q2Zf3YSrzzVcDXOWT7HTuCOQ4liTyRCM7zrVX+
         UHRq6D9yJotLVpYmNKMnFRspI1XuIo6FQx9rFQ4bLZ/IlLVMVvvgaTMSGrVoLdXOorSx
         Ng9hD0ZImPJ9yK6JtHlZjZx7D76c60k/BHaaTVasOX8rE7dsBIFH7i5Q/CW5y+5ReOqQ
         3nYBzfCExtbG/+TAYGtcIme7j74fE9DUu7eIzlGDOn8RPg4l+aZ/ITWjCNLLmYIrkbWp
         2+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2eTSmBY4E9XQiOKQqjOI701cyVedx2LDmxNwrJJ3iv0=;
        b=SKZzapyBqMigPwfTlxEwuYoLgQ5HHsfZB8dB+A87AnsqrqO2OFyH2VVFCCMH5LWJxn
         90yV2ewzY9hUa08xI6F2zU0R7dbdYNUNQvLBRdXBg+FXrcRqrjxVsMDvB5LMF+gJavEU
         W7+lKbTYp86v7rxrV+aQshvgvmH+UqAiJEarzFkBJPYUj5iGbINhSWjgfeXXjMkdJI3N
         NBwYap3AefPSrz1fF27XfDmVz6U9mlplXCpnytFKRZwBx/WH8BQgUA2d5U/+6E5Wd3F+
         9rsL2tShCR+yEFZUQNKari7OlLYSdvVlni6J6gGGNkOPzbfsnhYCMrxJkCw0eDyE1NqL
         2fhw==
X-Gm-Message-State: AOAM533P5ioX/u7NWI8rhbUV7/VdxJsKgi8waFCWV7uB8TMm/lLF+6+F
        DOMRpdBemx/13elyXyPWDCuZIS+N00U=
X-Google-Smtp-Source: ABdhPJzI2YDWRLRthlQXBuhXO5CneGYYItqeAjms+c107AVNN70T12j7akqp5Uc9wkc3WvVpnzE83w==
X-Received: by 2002:a37:506:: with SMTP id 6mr18193688qkf.412.1605904981500;
        Fri, 20 Nov 2020 12:43:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k15sm2719352qke.75.2020.11.20.12.43.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:00 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgxR6029526
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:59 GMT
Subject: [PATCH v2 104/118] NFSD: Update the NFSv2 RENAME argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:59 -0500
Message-ID: <160590497982.1340.7936056535783631669.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 9986b4ea78f4..94c637a0a24d 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -339,15 +339,12 @@ nfssvc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_renameargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->ffh))
-	 || !(p = decode_filename(p, &args->fname, &args->flen))
-	 || !(p = decode_fh(p, &args->tfh))
-	 || !(p = decode_filename(p, &args->tname, &args->tlen)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	if (!svcxdr_decode_diropargs(xdr, &args->ffh, &args->fname, &args->flen))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_diropargs(xdr, &args->tfh, &args->tname, &args->tlen);
 }
 
 int


