Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937062B1E34
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgKMPHH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKMPHG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:06 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D75C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:05 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so9019035qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XL6s6Tk4i4MrxWO3yZZ103RWXK3hxp8dnouqOicAbuc=;
        b=qx4QSQDhzzsDMAtAWxtuBA8q8aXIYAqpuUpqUkIKMN34ZTkxdRKpcWBvqMzEQfCy6w
         zVySt+0jKf5cHUmI0/0skfA87qXr9jshPkYMMeTg2C91Lw4frFTSVBudEWsD2TP+pXzL
         xKiyiOxQTCggq9q4rBJghpdI2cSK9SfXlaWDYs9u9bCUlxqRaegImvGpgY/4FodQMD8+
         an3DV/IoX1DMWjXpgghfFH9+wY5AO9TLI/tuM4Q2n/6Vg9d/6bGOPI+9ZaHjpeyJCbaO
         1OWuBowRnT6ccet1ykXLH70WOykDaHLRELPRmKMCNGI+aqJXFk4Zm/TrenGHLz+1oz3l
         xcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=XL6s6Tk4i4MrxWO3yZZ103RWXK3hxp8dnouqOicAbuc=;
        b=mc/8WLmJ8dPdaWNPPzv2pWrGeXM8nyw502Lkb2cTRPh02XJ1+i5kXfOygDnF6pAppK
         QXycngj6BCmHgQ/g1lIYFcQcuJ26j5IhlxCL/VtBmJ4tclcOKR4seoNAHoRmfd+S4niZ
         N57YQnJIhDBmHNhIJ2MQgEdYw5kvyY1W4O+Q13yawPuXrz5WmZAUiJ10xxn7cwFPPrKj
         1A3Vgo3vRn4LY+qdrKGScjk4OapENmQ9k+hG6omAS48hlSFbQEn0HtmgWpMJWfeiKSMA
         6w2meO88yYcQTXb15MIGicpojUGak5pDL2JRaZCk4Rigj51gnYYPqHwybBxSu9A7+m0F
         a1iQ==
X-Gm-Message-State: AOAM532oSn37ugK9/7M6yxP2aaKi7Ia4FxJDQlrdtmXpXU8X2U7qWASk
        f5YHLdewvz6B3b137AbcV9SGFzR1D8s=
X-Google-Smtp-Source: ABdhPJzRWg2f7b/3Fi4y94VX2kP6p2Bk0M5eUQoXQVc9aOVomyQDFcmOzJlk9FQ+WKkejE3K4hB4Qw==
X-Received: by 2002:a37:5f42:: with SMTP id t63mr2397575qkb.236.1605280024058;
        Fri, 13 Nov 2020 07:07:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r89sm1053847qtd.16.2020.11.13.07.07.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:03 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF72kb000328
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:02 GMT
Subject: [PATCH v1 53/61] NFSD: Replace READ* macros in
 nfsd4_decode_fallocate()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:02 -0500
Message-ID: <160528002232.6186.12736242667821000001.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 94e96bf09cc1..9afdb83c5c23 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1948,17 +1948,21 @@ static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &fallocate->falloc_stateid);
 	if (status)
-		return status;
-
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &fallocate->falloc_offset);
-	xdr_decode_hyper(p, &fallocate->falloc_length);
+		goto out;
+	if (xdr_stream_decode_u64(argp->xdr, &fallocate->falloc_offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &fallocate->falloc_length) < 0)
+		goto xdr_error;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


