Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAF2BB738
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgKTUgN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731177AbgKTUgN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:13 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8811C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:12 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d28so10172520qka.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/s/arfaHoDYCO8KO5awtvsWLZgT/HYouOXH0F8xby4s=;
        b=DwJIK3wSxfNZ+2T9MB3dGN311IZ9wrtWZ+U2X8mIDyMOe535emELvCWax12eF5oxim
         10knqozZZqcgD1KZrz+Ovd39HTiCBSgfpRIya1nMm6cZDgOCkg63gaRulLEduSwLTbDz
         OPevK7t7vEpan7gjk5J12pc1xReKwYJUSs8mtb1NPwkiLGRcJs4p5SoG3J8In0GdYqqo
         4P87EMWuys47vJ9QvEziQqsUXqbm7lnxQAJvC0BIiLS4/Ot0BAy2IT0Xsok5zrX8Slj8
         l17j420l0hcDuytQRwOPZZKkdvrINOZ1MgleYcp6mcnxBkeiLNT/L6e70l/3xeh0VsoB
         +gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/s/arfaHoDYCO8KO5awtvsWLZgT/HYouOXH0F8xby4s=;
        b=tivlrqVV6oIFfOTnjFUY/evXLlWzQ1ZbW3J0ClrcAUYtGVbcOSyn68oV77urauvg8H
         SMa1qu2WvAXNpUs9zzq2QrOqwsmhmfdLRWOCCzoGkPU/Yj4iunouU6ImCGS2fI4IVmhI
         afRN8MZbrkPoG6nbMei3h01bJvZMw46+c96EaoV46bWDigpYrIVGD8fIZMo42cfiV8ub
         G+I6LzY25Sw8FXYAavs2R+YYPkj7LnxVDUCbq6oU6Xgnf3sH+RqrgjBcN1QtYtxr4nxa
         D4gQ+LyEPhSyiSGOQi617hmxcowqNM6Jvsv4qtGXG//Kqx3krBJ6RgPc/saSEfLY8sAC
         Iz7A==
X-Gm-Message-State: AOAM532rtNnEXWyBSPEAZ0uP+0HPD4x1V7wUo2CQWwIXUZ1afWVmHyJT
        2kbR63ThLiqncdyn0PmagXE9FlKhQt0=
X-Google-Smtp-Source: ABdhPJwbeSRyGmVFiOfjCLAMYOC66+FcM+Yu6pe2SpqQmcLfEzSLJkeLhiS2A3BbhQW6QB9FcCUzqw==
X-Received: by 2002:a37:6451:: with SMTP id y78mr18898623qkb.500.1605904571707;
        Fri, 20 Nov 2020 12:36:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p72sm2885248qke.110.2020.11.20.12.36.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:10 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKa946029283
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:09 GMT
Subject: [PATCH v2 027/118] NFSD: Replace READ* macros in nfsd4_decode_lockt()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:09 -0500
Message-ID: <160590456986.1340.14336898333340009932.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 83a8f872ae9a..a465fb04d9ac 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -841,20 +841,16 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 {
-	DECODE_HEAD;
-		        
-	READ_BUF(32);
-	lockt->lt_type = be32_to_cpup(p++);
-	if((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
-		goto xdr_error;
-	p = xdr_decode_hyper(p, &lockt->lt_offset);
-	p = xdr_decode_hyper(p, &lockt->lt_length);
-	COPYMEM(&lockt->lt_clientid, 8);
-	lockt->lt_owner.len = be32_to_cpup(p++);
-	READ_BUF(lockt->lt_owner.len);
-	READMEM(lockt->lt_owner.data, lockt->lt_owner.len);
-
-	DECODE_TAIL;
+	if (xdr_stream_decode_u32(argp->xdr, &lockt->lt_type) < 0)
+		return nfserr_bad_xdr;
+	if ((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lockt->lt_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lockt->lt_length) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_state_owner4(argp, &lockt->lt_clientid,
+					 &lockt->lt_owner);
 }
 
 static __be32


