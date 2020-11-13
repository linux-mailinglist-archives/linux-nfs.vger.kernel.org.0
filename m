Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698B82B1E2A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKMPGc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPGc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:32 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F0DC0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:28 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id e5so4712489qvs.1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Kxxhvv7LNn8h6yHJQcGLez7tMmRC+uCc/jjD4ahgeUg=;
        b=fCv+8u99EHVw4Z7XZ35hXz40IwWxQEm3IUW69gW8+4mKc37llsIk3ghCCKR7+yMij6
         M4dqsAIsJOARRcC60/W+pmfn1XQh9nRlXz8H/x0Lu+dMt5DKHAuYxhB4oQ7Ne7rKuEXd
         bAeh6/HEscIIxUxFvuNAIhHaaGAxMYGpHdgRr5/cmiphKOIrIL/Fr4Ox7ehxv3OyE9It
         e6lffuXgqFAXKD7JE0QicchtRqC6VujQTPvcf2a1lEfhxhMyZ523QrB7/9FPBuyjOf/L
         GtBms/QL31TYCZlQv2IzX4zfHubdiZkRYg/I+XpL/gVOwrvXP7PQ2wvsBlR/exjiIQnl
         qiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Kxxhvv7LNn8h6yHJQcGLez7tMmRC+uCc/jjD4ahgeUg=;
        b=tjryLLhr5sI8fjiim8KT7qpbAw7DHtw0uDrmbUWDO6oF8Am7gPF0Cr5kkwOvaMiaPj
         Gs4PJEHfdrWX/pFBzK0R2M6xRPSOl84NG8wuIBjflrQby3ibynT6uWKEvV67f/yRTl+2
         BU/EiMOB0NNP3+ICEGYJBgVRAZS0aD1/PMv4Z0lO9nMsQphKJr1m3dMHmQIpRqKh/dt1
         ramwIR46KcxG9j0sDr2HINe45GBBdrbWA0M2xKofP2cHjAm1qFCPd4UuO9bcLlvLSkmW
         mJ8+XfwEZWMJxomqfLwCXPHDgznJlJkd+/1ONvHI+5Xxq+jQ2fqL80/qQ5pYXUe/bn/Q
         Acww==
X-Gm-Message-State: AOAM533QhGWh30svvUZr3ErsYKRgykni1uy+rfr0++/tn45b1XsjBfF6
        UdOsbjvFGAiLUffOI4lC6ldxPwzU3IE=
X-Google-Smtp-Source: ABdhPJw7xejWG1xbV/gObV7dwCb6jD+XjVnuzcMc10tdz9SPj3OsueXo2fpkSyw3Jr49cmbf3pW8Mw==
X-Received: by 2002:a0c:c583:: with SMTP id a3mr2634009qvj.2.1605279986912;
        Fri, 13 Nov 2020 07:06:26 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k17sm6917228qkj.51.2020.11.13.07.06.25
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:26 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6PCS000307
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:25 GMT
Subject: [PATCH v1 46/61] NFSD: Replace READ* macros in
 nfsd4_decode_layoutget()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:25 -0500
Message-ID: <160527998510.6186.3544084346307927373.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7ef6baf9c3b7..c48fa1427421 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1861,24 +1861,31 @@ static __be32
 nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutget *lgp)
 {
-	DECODE_HEAD;
-
-	READ_BUF(36);
-	lgp->lg_signal = be32_to_cpup(p++);
-	lgp->lg_layout_type = be32_to_cpup(p++);
-	lgp->lg_seg.iomode = be32_to_cpup(p++);
-	p = xdr_decode_hyper(p, &lgp->lg_seg.offset);
-	p = xdr_decode_hyper(p, &lgp->lg_seg.length);
-	p = xdr_decode_hyper(p, &lgp->lg_minlength);
+	__be32 status;
 
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_signal) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_layout_type) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_seg.iomode) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_seg.offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_seg.length) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_minlength) < 0)
+		goto xdr_error;
 	status = nfsd4_decode_stateid4(argp, &lgp->lg_sid);
 	if (status)
-		return status;
-
-	READ_BUF(4);
-	lgp->lg_maxcount = be32_to_cpup(p++);
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_maxcount) < 0)
+		goto xdr_error;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


