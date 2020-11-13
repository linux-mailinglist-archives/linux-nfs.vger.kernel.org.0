Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F662B1E30
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgKMPGy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKMPGy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:54 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6130FC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:54 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d9so9018444qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=njexyQIniMAi/zh5QdNc8eP0n/Xpio6g+aUYiFGkmlE=;
        b=Cl+BspW8MGmEEhVDwYMn11BPzUjws7t4NuFf3rUv9MOcx+hDVMQ3Bp/xtf7bSj4utr
         FMb+JSmwGYapXmOPty8Nr6lcZqYzuMDcWeSCt+oGGHljdjXgJmNdgOlxiJaUf489mXlo
         UYurwVv365KMeCxpkQUMt/HF5KTRajRWIMeAlZJNuyHW3dgV/Q78P4YmSRz3aZl2L+LJ
         0lZARzLtmyrh8oE6JHWQRzFb7009Oh6+Ye5s6ls6PbNG20n2+eHTa8Q7d71PERrJijC3
         dqzrjzVaA+PfUKm1gY+lpMPXWxfCwWivgO+dLH4d7xqDS0nOloE682Y5YRiAYEZJXK5r
         t0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=njexyQIniMAi/zh5QdNc8eP0n/Xpio6g+aUYiFGkmlE=;
        b=UIAxnQKV0qI92G5FKlJL2Mb/+UujAjitjuwmmXpHqJOZ4pyuz17iNvuw/6/bgLCI9R
         Kzb1sv9UI960AWxGl8vZ4G4gibAYH3PCwUCs1Ayug4yZm6D2hEuYmQsp35JdwiBh+PSn
         jtKvqei3CLqPJdkSrnHjHUhpY9FWXPHVAM5sTaznCXBUBWTL3vr7cU0l3upeCmX+9w5X
         R0vD7/bToLcqolE7kkYgp6kXOrX9eJ3JLrl7AvPKgoB1kgGhHsAVJdmdZcJqsMzU9jWl
         0dnNhZER/JAipty4uX6p6PFPS+6i0BqlP/U3CyaEYrSwoWtXvXriQFFbr9fFI1/fm1Lz
         zIrQ==
X-Gm-Message-State: AOAM533xXYS+noV4lm7oqw1OUCuorQF1CutcRbD79ldGSIi5MAA0RRiP
        WLzU2kOwmuy2YEmP+86K7c8I7uyC9Ig=
X-Google-Smtp-Source: ABdhPJy3FR3ja5tTSkemlNdbsxJIphUv1EnYeWKLVTAyeJ3clnGLmPv7D1CGaE7jml7u/WMCP6rmNQ==
X-Received: by 2002:a37:b483:: with SMTP id d125mr2312490qkf.456.1605280013324;
        Fri, 13 Nov 2020 07:06:53 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z16sm7353273qka.18.2020.11.13.07.06.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:52 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6pJ6000322
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:51 GMT
Subject: [PATCH v1 51/61] NFSD: Replace READ* macros in
 nfsd4_decode_destroy_clientid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:51 -0500
Message-ID: <160528001160.6186.16007038815137189510.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 4e9f911366ef..c69dbe8f5ff2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1698,16 +1698,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp, struct nfsd4_destroy_clientid *dc)
-{
-	DECODE_HEAD;
-
-	READ_BUF(8);
-	COPYMEM(&dc->clientid, 8);
-
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, struct nfsd4_reclaim_complete *rc)
 {
 	DECODE_HEAD;
@@ -1952,6 +1942,11 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 	return nfserrno(-ENOMEM);
 }
 
+static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp, struct nfsd4_destroy_clientid *dc)
+{
+	return nfsd4_decode_clientid4(argp, &dc->clientid);
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


