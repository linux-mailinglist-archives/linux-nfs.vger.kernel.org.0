Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73C02BB739
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbgKTUgS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731177AbgKTUgS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:18 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F0EC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:18 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id u4so10180176qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IJjz3jJHkCfaA2LkK6cZURxL3SqsRpzARIYRCAZMufs=;
        b=Tp5yIxf6VNIpkcc7nzHttAMfm21nnWzv0xH7hkAl9ckun/LDD9b0B9y+2zHK7PASMB
         lKIzgBN2d3nPEJUjjEVt+AEQIu+9ObkUzd1ZAyhgcluYvsnLSCR7siZf20vN4VoQBvQ/
         aBPFBilUm60cbaBkW5TnH7wKEy8h3drA/2ooQMOpE1z36lHb9LhjZ9h4LTbknmgmtjPu
         PU0vwglFG5D/YZ6+MLnipQ/YXK0YgEbVnW6jb7eAmGcX+tM0gbaVEM5RHsUzVSxJutcD
         Va9GtmgB/FETPV426qR/cgdxBI0cpCqxJ8hq2ighD+S+tqf5BkUOyW7sg2U8FFJoSl7Y
         pW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IJjz3jJHkCfaA2LkK6cZURxL3SqsRpzARIYRCAZMufs=;
        b=Hd60Md+cinLS5PrTeBZHggfZvdRVhHe66XXUbHl5gYbvPlZzSieVveR8PK7BwGLzWy
         0M3bj81ZREBZp6NZ3ZZYthBctpACSSQrVp/dYBdBbdLyR/kqraixRORzYsNKuusqT4gg
         AfsNfRo8p+K7yyJdNHCa0el6iURCZb7fsvbhtT8ltJbD4w3ISxRLPrTmY+244/2mG+cC
         RvTtSsFBYQSbYbzhKmflm6C5dB62tRuINqofAz0981qNpTDtGKboF0tMOhU/mOwQg/H0
         jHKTGYFxZekkQHupZdXEQC1v0aQ+K5Hh5DO+oJ32JZk1qIqnSmV+sw0mvM/8NcUI2acw
         H9OA==
X-Gm-Message-State: AOAM53363xTF0IFSY/Bx+yftCNflOLZvTcdtjmUewaoIbUyURvIrYCT/
        7oeXH65x8dyIf0kJNlKSRbkJT5glE4Q=
X-Google-Smtp-Source: ABdhPJzBznkl2Zus5HhQqp8b/dpyOpw+uhlRybyNEa4Y8LCiJgmrsxiNsqgz48WP2EXgnZnozYTzaQ==
X-Received: by 2002:a37:9c83:: with SMTP id f125mr18715143qke.149.1605904577041;
        Fri, 20 Nov 2020 12:36:17 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r127sm2874794qke.64.2020.11.20.12.36.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:16 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKaFuG029286
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:15 GMT
Subject: [PATCH v2 028/118] NFSD: Replace READ* macros in nfsd4_decode_locku()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:15 -0500
Message-ID: <160590457518.1340.5099419399810339068.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a465fb04d9ac..9b532e500e55 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -856,21 +856,23 @@ nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 static __be32
 nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(8);
-	locku->lu_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_type) < 0)
+		return nfserr_bad_xdr;
 	if ((locku->lu_type < NFS4_READ_LT) || (locku->lu_type > NFS4_WRITEW_LT))
-		goto xdr_error;
-	locku->lu_seqid = be32_to_cpup(p++);
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_seqid) < 0)
+		return nfserr_bad_xdr;
 	status = nfsd4_decode_stateid4(argp, &locku->lu_stateid);
 	if (status)
 		return status;
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &locku->lu_offset);
-	p = xdr_decode_hyper(p, &locku->lu_length);
+	if (xdr_stream_decode_u64(argp->xdr, &locku->lu_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &locku->lu_length) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


