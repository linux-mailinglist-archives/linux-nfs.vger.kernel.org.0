Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68E02B1E10
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgKMPEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgKMPEs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:48 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F7C0617A7
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:48 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id z3so3249179qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=z6R7j/ErAQpQVywmAvZWNTxAOEZj+FGX4EmAZkvMQFc=;
        b=ja3Lu2KOy2BuOFXkzL2lUUWk5YUS1WrCd0ke75rF1JPSD47BkCy4pBaisbU6MGCrE/
         k3Sl5uDr4D8MMyKZ53FqPPvSRHmpdR3DLkGWOydBZqrrIfHNBZopy380Egi8pdxglddX
         nTB0vKzyjD2b3sigE2pWbYMA6tIW4jIZjL+X4CTdWpt5sdOBGXa4+8zO+BFbDDc7M6Dx
         w5wJ86eOivuIw5U4psj8fG3fuvLYNzVdeZDHqnZW3iJGhH/PKcdA8gt/Bpo5TAjMLgjf
         bmanaRWfAJpyZ8Xixhw1pZjaXPoxkmysxqQ3rgbh+5g78Lhbhg5/PSTYGsEliEhAkBUm
         RsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=z6R7j/ErAQpQVywmAvZWNTxAOEZj+FGX4EmAZkvMQFc=;
        b=TMytb9v1CmPxcp89rGxJ1LYD0ENnA/8nVMjy30Idt3ItZiPkRGvmoLjt/jlXtY1OAR
         D3hZbf+k0kpqaNW+1rXVIDiOYLVi9LPffjT60vmag2I4TkBVD2wPugpKnCj7w9lgFWfD
         8KRDbDwjUcHShdnto9fXJsxySOF1Cu0D+LOYvPUubqO7Jdno73gDLMmhZZsUs3vaeLb5
         EQLwkOm3xFnt7twooWs7zBm9Hvl6Zfc7/KH6Kx5kKxlRoqQNew5Zs7eoXHIZ+W3zJKhk
         YC1ip6lNcgmXsEv7XQNGkuIISq+x//Ixq/SopYd6/KfNbfzFm9BkZcqdSp31ZW6PzyKd
         wivg==
X-Gm-Message-State: AOAM531/W0/lrtajS9szodKIUbLqi5avql1hRWWb8kN8wzGPDnVtn4Pw
        +cuPEDPj8THV0Pgy9t1jydXRIfU5ehY=
X-Google-Smtp-Source: ABdhPJyxXocjT06QsIw2ANOUkWRP9V84oDurTfyQBfYFwgihfjbnXJiZdnewZ9cApwZ+Pw/xVzx8Lw==
X-Received: by 2002:aed:2ce1:: with SMTP id g88mr2379038qtd.299.1605279886809;
        Fri, 13 Nov 2020 07:04:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r89sm1049933qtd.16.2020.11.13.07.04.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:46 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4jJE032718
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:45 GMT
Subject: [PATCH v1 27/61] NFSD: Replace READ* macros in nfsd4_decode_renew()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:45 -0500
Message-ID: <160527988514.6186.8509161893732755229.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index aa71baacabba..e7b43bc69af9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1246,15 +1246,7 @@ nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename
 static __be32
 nfsd4_decode_renew(struct nfsd4_compoundargs *argp, clientid_t *clientid)
 {
-	DECODE_HEAD;
-
-	if (argp->minorversion >= 1)
-		return nfserr_notsupp;
-
-	READ_BUF(sizeof(clientid_t));
-	COPYMEM(clientid, sizeof(clientid_t));
-
-	DECODE_TAIL;
+	return nfsd4_decode_clientid4(argp, clientid);
 }
 
 static __be32


