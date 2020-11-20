Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC22BB74A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgKTUhc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbgKTUhc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:32 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F1C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:32 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id n132so10244838qke.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bINWdid4826TqRTJcejOeR/TT+q5ab2GJmDQQsXOwCI=;
        b=M+5TmV35qydJlerfoONb3SWOSedrydW5TzXVBPPXSk0bHDfvSnuhEuAaDUAWM6Ar9m
         MPl32v56hTpqFpn75bSlIw+dvQDFj5gyDU0cLxnP9Hy/SM/rBYZrlNYaLbjE5KSqUyU6
         ShIFGipgKtCTJ2wiizExI5psALXR67OrrCFPs9E4C5MDjrlCyPatvptmZnRWSI/HC1ub
         d/TsTjSXVrMAs1D+LVxPmdLRXwvIYwNww3vopKPmBI6rLVFQM3mIq36LzIXWD381ICW4
         WDHKxujt8yEnewfs0ZfcY/iJ2uxjyI/3kZBehqxd4OwcS7yZonmqlOBmfD0LbzGTodTD
         qlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bINWdid4826TqRTJcejOeR/TT+q5ab2GJmDQQsXOwCI=;
        b=RzYCg/en6wnSQk6X7FCx9NFJuJd7tMH8MoRoam+kjEoaGI2DkLqOE+6n29lij2BS5M
         /4sahx0eYrCdC4QEiQ6GZHSaknnd2/nA4dMizoTojN8QRJAAtIRDr8mVmTZdGUfvTJSJ
         NQ0rdeLZ//v/Lswryn01H0o/LyEm4VdrvkmRoLWcQvdjpS28+uwOEIdPIajT2kZzGP3Z
         R2eerCFWLvcuePV7fgHGOczd4+HSVXLSiaUkEQUqhz3CBpielIOix0dxQOII6AYz5BX4
         x0grqAX6evPY0vZ3MTRopinepi7PS+2HP/LjzIwZJye8OZyr/lcMOjvcQ5vQd0RpE1er
         LrKg==
X-Gm-Message-State: AOAM532hx1zsZBDvjsA5MgfbgUFcDx4wwjxH6CSwvuL5Zbn6FMGFVanZ
        SN0jR95UqaLoBfBviB5CQbVUN4D7kZU=
X-Google-Smtp-Source: ABdhPJxSZsJc/3hf20iaNqIZyQVrEbDLR6561YqfEl2FLGADuwWIV2vmjhhKn+KgE2/GTfbqmew5yQ==
X-Received: by 2002:a05:620a:22eb:: with SMTP id p11mr19542337qki.224.1605904651262;
        Fri, 20 Nov 2020 12:37:31 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k4sm2740260qki.2.2020.11.20.12.37.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:30 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbTN3029328
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:29 GMT
Subject: [PATCH v2 042/118] NFSD: Replace READ* macros in
 nfsd4_decode_remove()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:29 -0500
Message-ID: <160590464945.1340.2353090260642464897.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3a7b615aef62..964cfe3d9409 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1201,16 +1201,7 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 static __be32
 nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	remove->rm_namelen = be32_to_cpup(p++);
-	READ_BUF(remove->rm_namelen);
-	SAVEMEM(remove->rm_name, remove->rm_namelen);
-	if ((status = check_filename(remove->rm_name, remove->rm_namelen)))
-		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &remove->rm_name, &remove->rm_namelen);
 }
 
 static __be32


