Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380862B1E27
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgKMPGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPGO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:14 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E87AC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:14 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j31so6830248qtb.8
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DrEfwe10/FqTv98FnWzExppu2Y9ZUK9TWxyRDDbGDz0=;
        b=krxpWg4QmdhOBiZCRgp3vkK7kyEh4Z6TiokKAO/RMgIXsMlBpOsw2OX5yJjWVObKQY
         kbHkuWQ92OzOpkrq+5YkIlwjKn9hwms7wXxVgmaczz1SYHX/OJmNPiGqLmY9BsM5n6K0
         9Y6O5a4kcEW+MBROk5rmyZget6rtxUUCQNPvNtMptZ9qmbwPGqmw7WOL2pQ7TIA+XaYn
         x5kU/q26YWmEm1epXrSZfGtI6H+JhwJy3Agm5w6qcAakBMb73qUl6TiH9/STu0p9K90A
         NXmRgZxWgLS9Tb4UK/8lIzX8tx6ALk6PF0T1aic7p+ZnnKx0L+w1QZjlXKgP42Ey8CWs
         2tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DrEfwe10/FqTv98FnWzExppu2Y9ZUK9TWxyRDDbGDz0=;
        b=p2UPSW6BIOf1KRb6A5kVoJvUadUaUwOUjk0a21V9kMU4Mwc04eswUGmyGnl8cwT3D3
         MPzmkbaiVLHuePDTGuNO8SbbLwV3UGVo5G+YgPUtcWgIUkFThMzwV70cXA/z6dhM5IWw
         wFwRduL2hjtVU3RJK+f68tYX1d2mbfITvd0RfrpGcg0yHvQx24+gZadHfzd3oGi+b+cS
         WBIODNT6smoe/JYgstrPl3DqDwrZ0T9lKMOPbCYhmu10cSKLe9I3wOFOTweCsvQBv1B7
         58cb9zs7EQXLrkLeoiNoKObVTXGnjtOWYtjpW9C9u+9eO6AAV1DIqg3juiGZFaGZLm7y
         Pqrg==
X-Gm-Message-State: AOAM530THzSxxWGl99nsgDVXpx33rpf+R92EgeFCNmKB96RDnZE7rkit
        5pw1XBToat/YNqxHfla3Pf4vIgR1d9c=
X-Google-Smtp-Source: ABdhPJwkWuOot43XRen7Cuj8gOrv2z4aqgB8lsa+N/G8PbN7zE2NRJMgaYRbRDF2NVgazjXOGQNwnA==
X-Received: by 2002:ac8:4685:: with SMTP id g5mr2382970qto.173.1605279971133;
        Fri, 13 Nov 2020 07:06:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u12sm2457362qka.21.2020.11.13.07.06.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:10 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF69Mc032766
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:09 GMT
Subject: [PATCH v1 43/61] NFSD: Replace READ* macros in
 nfsd4_decode_free_stateid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:09 -0500
Message-ID: <160527996924.6186.3615250265473544578.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a6b7533947dc..c752924e2cdf 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1689,13 +1689,7 @@ static __be32
 nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 			  struct nfsd4_free_stateid *free_stateid)
 {
-	DECODE_HEAD;
-
-	READ_BUF(sizeof(stateid_t));
-	free_stateid->fr_stateid.si_generation = be32_to_cpup(p++);
-	COPYMEM(&free_stateid->fr_stateid.si_opaque, sizeof(stateid_opaque_t));
-
-	DECODE_TAIL;
+	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
 static __be32


