Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274AB2B1E39
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKMPH1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgKMPH0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:26 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFAC0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:26 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id v20so1426454qvx.4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=H355uMOS88su4O0oJUFwVT+hG+CgLa5JlEEt+7u26vs=;
        b=XewjJM9DDtknkrjIQCr0mGSCWs/XobE9goMeocIu3hGapLXUpvmCgkb47vBpeSkI+o
         jeKaG8gubKL92GxOCSTtQ+F80yeUa0b/2lrzNRk+kLiCagpRpmJRHD8tXoTjr+U9xu0Q
         YSzcLR8eegDaGcbXXsHzdYocev963rMZ4BwSegEs4invGG31+6w1Ssw81znRDEe+kXH8
         ydu+oFKJJHrAFElzR3VOTipcMzA5mHVbA16aiuYv2o6rlK8YjgpQ1Co0dHutX6j3alyF
         wdS7bZKfzPRPa8quPRYfFAUDBhrlWhvIECX6p3KzX9kr8KgO//7NqUAyao2SSXwp7mzb
         UDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=H355uMOS88su4O0oJUFwVT+hG+CgLa5JlEEt+7u26vs=;
        b=NlCWno72REsCpjmhKvoW5EEdbm/oPDrLtpWl5ZKh+II1Hr0pRyK3cDecbtCt/fX5dr
         HrYNeNmH1SM5U16kcrtPX5qf9IPikrdg49Vlp+YhI5NfJuJ0IKrSZaW/eKUCcDsVAuhj
         USw8+MiLjbJ+eYNsj1Il2rhiJ6g9daorRCLOq3rUoGlUq+5pN0GjfhPjPHFpCcykVdOO
         hdNICx8ie3aSjcKKSkptPEhx5BX7FOd7T5vMhsNkIkdqlY24eG3mqjNCK771PBfDnDpT
         U1YYuEp7nezv7di2SC7XRiRfrsIxCDjBS42G/9nQ90lSbBcfj+hzdGv5Es392SZS4yHV
         3zvA==
X-Gm-Message-State: AOAM532DyG92+IHWSCuJurCAO7LCPUfuaXvI9TKle9HyCSLvHzI/y9zf
        10H4eKcNSjQsOfNBTYU/fYqhTXOXJ88=
X-Google-Smtp-Source: ABdhPJyllFHkLJMSuDsP0wdb4oW6Q2Qhg9Eyd5vm/Iv7SBd7bx8rWx0DZGNHeEuoUSP8I/YXJk3JKw==
X-Received: by 2002:ad4:5691:: with SMTP id bc17mr2800268qvb.30.1605280045242;
        Fri, 13 Nov 2020 07:07:25 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e10sm7274567qkn.126.2020.11.13.07.07.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:24 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF7NFZ000340
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:23 GMT
Subject: [PATCH v1 57/61] NFSD: Replace READ* macros in
 nfsd4_decode_xattr_name()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:23 -0500
Message-ID: <160528004347.6186.13036251358322566533.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1f7eb2f67390..12b90251fbf5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2187,12 +2187,12 @@ nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
 static __be32
 nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
 {
-	DECODE_HEAD;
 	char *name, *sp, *dp;
 	u32 namelen, cnt;
+	__be32 *p;
 
-	READ_BUF(4);
-	namelen = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &namelen) < 0)
+		goto xdr_error;
 
 	if (namelen > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN))
 		return nfserr_nametoolong;
@@ -2200,12 +2200,12 @@ nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
 	if (namelen == 0)
 		goto xdr_error;
 
-	READ_BUF(namelen);
-
+	p = xdr_inline_decode(argp->xdr, namelen);
+	if (!p)
+		goto xdr_error;
 	name = svcxdr_tmpalloc(argp, namelen + XATTR_USER_PREFIX_LEN + 1);
 	if (!name)
-		return nfserr_jukebox;
-
+		goto nomem;
 	memcpy(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
 
 	/*
@@ -2225,7 +2225,11 @@ nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
 
 	*namep = name;
 
-	DECODE_TAIL;
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
 }
 
 /*


