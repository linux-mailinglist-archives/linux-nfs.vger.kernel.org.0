Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0162BB755
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgKTUiK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731533AbgKTUiK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:10 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65DC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:09 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so10218806qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ermSJ/DR3rVl9OtAsOrxcTZAU4uf5dwIk/aNR9PjGuE=;
        b=hU7co9auB/ycvzCk4bBbaPtA+7UcwyQJqN8LGvm7suvY7uKvNquBrHSung56aRpQa4
         fG2RFM3Xwg0i4u3Y1utygEu1pdddZL4SfqKhio5kDvC7vH0DqxwMuyhPMw2PZ73yflMt
         3VnwISJxCaN856AqAd5C+567oraSA0FZIvck3/I9hw8panD0Ddss+J9luHQWmHIAJ7c7
         p+lBIJihJRtxglFy/epikdH4O4xD4GT5E5Anljc+fe32lzbu9e50c/XOmy00DYmLGL6h
         92guJ5Hyjgxi1zs4eSiqyKKkjnd2u0C3l8zkyTUC6zKv9qatEgCKALpiWikYRd38clxr
         2mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ermSJ/DR3rVl9OtAsOrxcTZAU4uf5dwIk/aNR9PjGuE=;
        b=GxZRH52+Kk5kiYEwCbeeSezkIh67vhyjqCQK2H38IkmfsGXYoZsdzmXabztKMFqOOh
         9nEpHpaQ9VimP+hsB4eg6S7qjF+2sjIc7sYLgBcgwK4MxnCDJW229Gl/TD1meapu5Cxu
         xrxDTARj1AJjLSDdp+asuTW21r63nh7aVYnLlzKDEScMedk86BDhIyimDiMpPXW81UGF
         SaKWqskvoTrpvRdsTC4OR6OOW5F8F+UdY9ojZXd4E7ilbX6dFKeN1TvNdIPuFOheWXox
         HPpbxYoBoFGj8UJdcBFtPX+Wxt29Nt8k2Aee9UInEIpZf+M61z2qmMLoJuXs+3JxHySt
         pu5g==
X-Gm-Message-State: AOAM532402Si6CuBuTMApKZK/G4E8k1yt07hOk8t5N6JdUdY0pKYZcOh
        Prz3bAgssQQZAaMGfzinr4vwKlUFY9g=
X-Google-Smtp-Source: ABdhPJxBeF+vRXjcvEzLBpeKr20c419UeUFk5K3cBQMv2HDg4EwtHqb+Ja6gWVZjD8fkicQScX6fAg==
X-Received: by 2002:a05:620a:14a5:: with SMTP id x5mr16919410qkj.263.1605904688654;
        Fri, 20 Nov 2020 12:38:08 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o15sm2597643qtw.64.2020.11.20.12.38.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:08 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKc7DV029349
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:07 GMT
Subject: [PATCH v2 049/118] NFSD: Replace READ* macros in nfsd4_decode_write()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:06 -0500
Message-ID: <160590468692.1340.6542502883753961142.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 69262f9ea5a5..65c34bb52d16 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1341,22 +1341,23 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 static __be32
 nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &write->wr_stateid);
 	if (status)
 		return status;
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &write->wr_offset);
-	write->wr_stable_how = be32_to_cpup(p++);
+	if (xdr_stream_decode_u64(argp->xdr, &write->wr_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &write->wr_stable_how) < 0)
+		return nfserr_bad_xdr;
 	if (write->wr_stable_how > NFS_FILE_SYNC)
-		goto xdr_error;
-	write->wr_buflen = be32_to_cpup(p++);
-
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &write->wr_buflen) < 0)
+		return nfserr_bad_xdr;
 	if (!xdr_stream_subsegment(argp->xdr, &write->wr_payload, write->wr_buflen))
-		goto xdr_error;
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


