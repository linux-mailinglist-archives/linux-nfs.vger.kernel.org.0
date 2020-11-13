Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462F02B1E18
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgKMPFP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPFO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:14 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388AC0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:14 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id z3so3250339qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RzY1AXh14UuN+4OJCPUoWXLaQbfFmrECoub0hPAxNsc=;
        b=AeXu5RnTuHzdqPenzz/S58InzNGcqlPNZFNMC1ISlXaspXUlhk6fmw6KXb7SpoW5SI
         EEwMGRDj2xJYeWF9Z5ZUyFE+3IhuxOKydgbANaIWGwAdGgYXxORREVcBRdl6SKLwqxwn
         tCDxpfDWVL3kYq59tP18GPFvkVGcwGTxs2TXWDqUcWCyR4PghR/Y/EGdc5Eqqmi5aA/w
         FxBYrMalfbEn1F9p8SxCiaqzeFxJ7XDh7ut2yQ6rFaZ/AFuq/OE12XZCtUMlM8DKlntq
         fmgzWOXtlyx0p2H7BzKRco8eBqIYkyEyizJoLVZRsVo4efixZ0CYPxLMESl0mmnWX0z9
         xbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RzY1AXh14UuN+4OJCPUoWXLaQbfFmrECoub0hPAxNsc=;
        b=ZPqNV7xJnZcDqoKkgJM5/2TwYXYQiBKhpj0u6s3ZTlmUjPWp9MZQIeXtOg1dE+CdzD
         SNB/9VnuxfFfCkIJubtJMpq7ZdQ7f0NNCAA4pfgW0o5Vl8bCF2+GBVrTGZYPxWVQ5n4a
         4y6kdcJ80ZN/PC/c1DQPJcDYNlacewL1L2rHneAHuURinlxjJakzai1NMbyIEzioVJcr
         qYqbu1agakfvFrMntUOgw0vDwA52DWZwda7AK2iuYCk955kVIcAOcD25RzwWsfmoMHVO
         iEiuAPeYs/6wrZ67yrcp/Ec8APpNBJBQUKLlGY6MfhK4f7bCRYDzsn/oKHG+OqELyjxa
         qjEw==
X-Gm-Message-State: AOAM532wH6aDaNzxs28K6IObmqQArx8o5+f4f9oSXYb1ScTfoGY0cIbY
        KrMosvIvJY7mvhML8Q6uH1e58CXAC9A=
X-Google-Smtp-Source: ABdhPJwwt9tG9aXPHKEZDCeUNxVTLhDjczsKzjb3u1X/pD7bvJVDv2ws2mYeFGdCwPOn9RUoXhplug==
X-Received: by 2002:aed:3ba6:: with SMTP id r35mr2357738qte.269.1605279913287;
        Fri, 13 Nov 2020 07:05:13 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 203sm6871948qkd.25.2020.11.13.07.05.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:12 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5BAd032733
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:11 GMT
Subject: [PATCH v1 32/61] NFSD: Replace READ* macros in nfsd4_decode_write()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:11 -0500
Message-ID: <160527991153.6186.3728345021042537746.stgit@klimt.1015granger.net>
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
index 71a9bdb67d06..db63cd46b9b1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1387,22 +1387,27 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 static __be32
 nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &write->wr_stateid);
 	if (status)
-		return status;
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &write->wr_offset);
-	write->wr_stable_how = be32_to_cpup(p++);
+		goto out;
+	if (xdr_stream_decode_u64(argp->xdr, &write->wr_offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &write->wr_stable_how) < 0)
+		goto xdr_error;
 	if (write->wr_stable_how > NFS_FILE_SYNC)
 		goto xdr_error;
-	write->wr_buflen = be32_to_cpup(p++);
-
+	if (xdr_stream_decode_u32(argp->xdr, &write->wr_buflen) < 0)
+		goto xdr_error;
 	if (!xdr_stream_subsegment(argp->xdr, &write->wr_payload, write->wr_buflen))
 		goto xdr_error;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


