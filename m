Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58E2BB745
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgKTUhG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgKTUhF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:05 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DECC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:05 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so10182339qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cCwZMcRVLNCZUbfO1LP00KapJf3rsrCBDtrD1UCtcyQ=;
        b=FMLdawGJ1lgjsGc9K9yX8uOdkJv49iRWGZvbgIwr9O5hKQEtYwt3W3n2P9MCig0aCl
         PoK4XaZbF2Y2QNWxKwDWoWf4uP5o+BMnfjZf7lB7fpOk8Pp1+O4XjuBPMLfCEEefCIye
         O7ffZ6Ievfw9/LpZQe0O2DIz8RI9Ug9wj5p/dwnQ6Wm7ymRyNs67l8vwsjGoxJyosUNs
         a/Tfz8aEbh/OmsjdEdnO+UT0FT1304U2nqJTZR4xBCFZ86zWZBVHxC9NvCj7SWu1skpM
         DvLnUKLKv9PH4GOzb5pp1NNclF2FHHJLEvGgHTgUI2m8rsmQtn+ODkfXVb/MgwKxY2Gt
         b/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=cCwZMcRVLNCZUbfO1LP00KapJf3rsrCBDtrD1UCtcyQ=;
        b=ntf1Yeze+uZY+ewU7HtRNjRni+GjawoepqjZOzXAevLErwkvAZJBqsimnCoE2/0nE3
         b0IpnfkaFr6b3yaecbuvSz5qCd9c1z875pmECLVgIQB/aIQ8yhu3hWSKifV/dEABOxzJ
         VadNQT0Uictn8dkrbuGwKtFyb4UqyTcWlLp+6AAPBJxUSws+wahU4w2QpcNJQYUbxG12
         oD31XuYokCkJCU2R8AGpeZQL9hZwqisxUwoDbwGJicHmkLgPKfD/oJdtuxGpypo5nFxm
         HK5PyDaqyxmicZpcFKUpruvUKPbnBNVasLbGFqj13I5kZ7nXSe03c5RmMDs4GQ6azvGt
         VX3g==
X-Gm-Message-State: AOAM5311CdnY8eS/DSfglWuz225x8zXn7J9+WVcVM2Js+NdL3SGA87Iw
        jNJPocgl9ZkoqLxMUMnkdpc5nG8mFOc=
X-Google-Smtp-Source: ABdhPJxWS/mpRXVjcNke3ZlXclcU7Fau8wcE1wWBQKP3YsbUqV8xep3qQVcNGEzcL14PzO/HC6wDrQ==
X-Received: by 2002:a05:620a:11a4:: with SMTP id c4mr19013719qkk.8.1605904624316;
        Fri, 20 Nov 2020 12:37:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i4sm2688386qtw.22.2020.11.20.12.37.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:03 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKb2jU029313
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:02 GMT
Subject: [PATCH v2 037/118] NFSD: Replace READ* macros in
 nfsd4_decode_open_confirm()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:02 -0500
Message-ID: <160590462284.1340.4278129418229040413.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f6fb167c7715..ad3f392de382 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1102,7 +1102,7 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 static __be32
 nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_confirm *open_conf)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
@@ -1110,10 +1110,10 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 	status = nfsd4_decode_stateid4(argp, &open_conf->oc_req_stateid);
 	if (status)
 		return status;
-	READ_BUF(4);
-	open_conf->oc_seqid = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &open_conf->oc_seqid) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


