Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193F62B1E24
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgKMPF4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPF4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:56 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FF8C0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:56 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q7so4683582qvt.12
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=p5i/cE20hWPfjsz2NLW2vH2PtR7eGvbAwQ024Hme+8c=;
        b=dmWIDDbwsdL3B6MiwPki2nvdppNmcFHH94FuIqiZznFL4PQBt3BzD6IC38GRQNTk88
         eEAHA2fZsEZZjnXR2oofmx0R2HLOjBCC1mCabS24dEKOi3wcIjXbE2cw0phUbxbjZUlp
         X/uXr3E68FIffL3KqYDk0sQZ9NaHB1HpcCVuSpWBs8sNVnjnLZwZdHNtPRVm9nblZwdX
         1RYoiEqXV7umtpXaybTb60IdjErATF4qfVmQXgYFMCSl8YIVnqPrxYqPrNPTkqTymsmA
         6Q3kCXoru3Gbs2SQydAWrIxq3Fuqsu+NaYZyps0WPrZW3SwvgVajugblZbnvJ1ORY0Bv
         4YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=p5i/cE20hWPfjsz2NLW2vH2PtR7eGvbAwQ024Hme+8c=;
        b=SWQYjLOZx77dRZkQpfq8Kdkx9AuXLt2ZXmQDXMkKRSCJ9U82I2391iI7xQViG+v4Ca
         jcjuiRpITua8p9SguLbw4GtsmS2N6OUgy7xLXzCKweBv1rz+z/+DyCcfH7bGqPpH6/Zo
         a0ieBbH44L3QuI0JbMNymdGPrRkSQs2b4RLhjx2x+1gnbmdUbPnUd3zP8n4zxSvXbwbR
         WjPUWQqkwRjC57Ia4UgL2sZuJmPnGVOqaczy7Ugml9XWEWjiV5MJNyYJDvWFQFd9mJrG
         Ugs+hCc1i5V0ctczXbGJn7IkSVbn4Czh5n3C4oxhyJ/cKFM8klwsHB3SLSgD32EyfIw7
         aiIQ==
X-Gm-Message-State: AOAM532gKfRARqVnB3nQoiJ6TpEgOaHngHjxFtWMwS5mYn/famYr2wdg
        g2oaL7imdrD4kosSaXdE8Lrzs6m+0Rw=
X-Google-Smtp-Source: ABdhPJy8tQVDihHhv86JMJRRbKYWZgTZq8lIzI5bdLMYzA4zb94JI9jQsGzNd+wX9XvvZhN8UFfZtQ==
X-Received: by 2002:a05:6214:a8f:: with SMTP id ev15mr2618133qvb.20.1605279955179;
        Fri, 13 Nov 2020 07:05:55 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f189sm6778809qkb.84.2020.11.13.07.05.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:54 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5rul032757
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:53 GMT
Subject: [PATCH v1 40/61] NFSD: Replace READ* macros in
 nfsd4_decode_exchange_id()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:53 -0500
Message-ID: <160527995338.6186.13917579604098004455.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d3e238b538d0..6897078bde82 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1567,8 +1567,8 @@ static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)
 {
-	DECODE_HEAD;
-	int dummy;
+	__be32 status;
+	u32 dummy;
 
 	status = nfsd4_decode_verifier4(argp, &exid->verifier);
 	if (status)
@@ -1577,16 +1577,16 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 	if (status)
 		goto out;
 
-	READ_BUF(4);
-	exid->flags = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &exid->flags) < 0)
+		goto xdr_error;
 
 	status = nfsd4_decode_state_protect4_a(argp, exid);
 	if (status)
 		goto out;
 
-	READ_BUF(4);    /* nfs_impl_id4 array length */
-	dummy = be32_to_cpup(p++);
-
+	/* nfs_impl_id4 array length */
+	if (xdr_stream_decode_u32(argp->xdr, &dummy) < 0)
+		goto xdr_error;
 	if (dummy > 1)
 		goto xdr_error;
 
@@ -1605,7 +1605,12 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 		if (status)
 			goto xdr_error;
 	}
-	DECODE_TAIL;
+
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


