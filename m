Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203102EAE6D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbhAEPcQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbhAEPcQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:16 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4FBC061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:00 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z9so21066530qtn.4
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PfR+145Cl/h2AjN8p5PmJphXz5XskRvy/bZry0aSnnc=;
        b=iC5Sg15kKUejRn4Ji0+7Jxc3aWab+jgS/5LZ92I0kLSCM8BugI11RYPQfHFZw0cKwC
         7ZfEOs3z9rABkJZT5LvWMQfO0CjDdoxbe8KWaLI5Iy2mQfwhk5uWNhn2hd8aYbr6Legf
         k3KIGtFgW8puPYRbrek3fvMHPUBSMvWyFWkR6ZDO0bi9XSte4P2GqxOK6fBWaM9x6WBp
         DRsKfWcH+epTRm/3M5eCC3jr04SXm4SLCos++IR0YDSNfF8TYgVQzsFcJAc5J5YfGGPs
         ISudTkdKrzAUGhPAhImrz+Lu/XoBx+0FwrdmaCtoKNe3X19hH147EfTLwWNORIiyaKMb
         lPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PfR+145Cl/h2AjN8p5PmJphXz5XskRvy/bZry0aSnnc=;
        b=HTostrRU/ZZ+l6p0h0tbqPH92i/8PMlFnOfOCkxAncmjnQzJwwqCofKj+uGyOVq8Tu
         x5iAL9h87MHbMTRz19lcmo0TRdvU7MYaYG8YveW+TbsV/O5PFpAeOYtYxJfU+W+8Rbzq
         ipNFZspaeBiphjqPpPZG6Wnn8nopwQrv2RNy3HMx7r5aGocgnRX2l0qaFBrncQUbd1iU
         I9lp4CvtfRi8ua4TCYDiGzwQkHhewaD4hwrtl9I94xrovbYrEsGnRTEu7drQstR7v1uq
         IBPRjK6/oDO2NiylEUH0d7Mf8RQT25tF02OGJdX0VN2yeCDPpUuotQ9JynH2lnCHwOZ/
         OlZA==
X-Gm-Message-State: AOAM532u47dD8uZUX3bH1+fmrR3bq2Eks8ldlyq7aXtT7OG/BPmqhab7
        5bjyQPxd4CCLzoZIjS4USYPwLzqeHxY=
X-Google-Smtp-Source: ABdhPJyJX4EzhUBIVXmx5vLTMta2Z0/z2YUDoV4jF+6gyQ+dSZbI9PUS796JVbjeDcCMdIQeOQajCw==
X-Received: by 2002:ac8:7954:: with SMTP id r20mr83529qtt.78.1609860719868;
        Tue, 05 Jan 2021 07:31:59 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i13sm135812qkk.83.2021.01.05.07.31.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVvo6020898
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:57 GMT
Subject: [PATCH v1 26/42] NFSD: Update the NFSv2 READDIR argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:57 -0500
Message-ID: <160986071797.5532.6943162493512709242.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As an additional clean up, move code not related to XDR decoding
into readdir's .pc_func call out.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 3d72334e1673..7b33093f8d8b 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -381,15 +381,17 @@ nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_readdirargs *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->cookie) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
 		return 0;
-	args->cookie = ntohl(*p++);
-	args->count  = ntohl(*p++);
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 /*


