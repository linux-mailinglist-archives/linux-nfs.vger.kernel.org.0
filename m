Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7E2BB744
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgKTUhA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgKTUhA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:00 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CDDC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:00 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so10214675qkd.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oJXRxUG0qmK8loJ5U8+JVkEXskPWALN1NdUFRBB9cBk=;
        b=PJnZwuwYy7mWd7y/vgUA/mYGZOrlBvs5XIKzwdkH0fq2WgIwOV4PQ9FFm1YygRqzTS
         67GKBbP87YaRBdZW/WVaFnQX7h+cH/VKuMm65M8NFnlacQJ2pAeiFkBGjCefQfY035mE
         eR5Lh7Qt24RfubMFT0F+JmlPv7tSVueeNV7dIJIxpNRRZQGZdcqsaXGBlbIa7cRp6pTP
         NJXGpQsjm4k3D76wHytSqYNj2iUuNFv4Sufx+CGACeum1yZ6/eWR1shJxLJYJylNpc7w
         UjEWelCIA0iHf45rd/sriRmXJlsBgMarKkgB/vnXfKNDVKFBlxTVx0rSIK7FK30XAodp
         9PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=oJXRxUG0qmK8loJ5U8+JVkEXskPWALN1NdUFRBB9cBk=;
        b=JEJy8XHtOc1GKoWlCigXc/qTJIAgoRNDx0ZBDVRUDmtvcdEE/u40Tz0joNXzHceFZ9
         i9SY7EScoPN9szjpXMBRO+d0UHisS7zecSzZfsB/BzHAKgryUylMdfxXDnoCeW+msBgm
         nnTzPsz/3bskICjD+sPlYNs3UFOnaZiFbL2OISu+fjyTDaz48rB3haGdIHYHILjCVoHc
         EM59uf11W0T/uY3t8RELpUSrY2MABQ8L1TEPXNS+pTcgCnJo96kDDOO4fB0QUgS7I17H
         3wTARKHUnrRNguW+iIrGkVzigE0AIrPF8OATAl2tg1yvw4eIhAIZXtRZ0sJi4cS3wNfY
         R9+Q==
X-Gm-Message-State: AOAM531jNSB4uq++wkmQtwPQ8lNgnkvLlCcIORhzXyF89pHYT3x2cMD9
        /xHsVl6J3d/5R+IatppEpamgJ4WwdzE=
X-Google-Smtp-Source: ABdhPJzPB58aJkCVTc64OPYljgnJu7krK2XwrL1Du/4ZTitOF3g0rdMjefKn/Fn7XrKC44GuqBi6JA==
X-Received: by 2002:a05:620a:f84:: with SMTP id b4mr18101900qkn.22.1605904619240;
        Fri, 20 Nov 2020 12:36:59 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u31sm2871876qtu.87.2020.11.20.12.36.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKavGJ029310
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:57 GMT
Subject: [PATCH v2 036/118] NFSD: Replace READ* macros in nfsd4_decode_open()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:57 -0500
Message-ID: <160590461752.1340.15397108103776849920.stgit@klimt.1015granger.net>
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
index 32929a1106a2..f6fb167c7715 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1071,7 +1071,7 @@ nfsd4_decode_open_claim4(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 {
-	DECODE_HEAD;
+	__be32 status;
 	u32 dummy;
 
 	memset(open->op_bmval, 0, sizeof(open->op_bmval));
@@ -1079,28 +1079,24 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	open->op_openowner = NULL;
 
 	open->op_xdr_error = 0;
-	/* seqid, share_access, share_deny, clientid, ownerlen */
-	READ_BUF(4);
-	open->op_seqid = be32_to_cpup(p++);
-	/* decode, yet ignore deleg_when until supported */
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_seqid) < 0)
+		return nfserr_bad_xdr;
+	/* decode, yet ignore deleg_want until supported */
 	status = nfsd4_decode_share_access(argp, &open->op_share_access,
 					   &open->op_deleg_want, &dummy);
 	if (status)
-		goto xdr_error;
+		return status;
 	status = nfsd4_decode_share_deny(argp, &open->op_share_deny);
 	if (status)
-		goto xdr_error;
-	READ_BUF(sizeof(clientid_t));
-	COPYMEM(&open->op_clientid, sizeof(clientid_t));
-	status = nfsd4_decode_opaque(argp, &open->op_owner);
+		return status;
+	status = nfsd4_decode_state_owner4(argp, &open->op_clientid,
+					   &open->op_owner);
 	if (status)
-		goto xdr_error;
+		return status;
 	status = nfsd4_decode_openflag4(argp, open);
 	if (status)
 		return status;
-	status = nfsd4_decode_open_claim4(argp, open);
-
-	DECODE_TAIL;
+	return nfsd4_decode_open_claim4(argp, open);
 }
 
 static __be32


