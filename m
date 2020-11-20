Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE482BB775
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgKTUjn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgKTUjl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:41 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1848C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:39 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so8134709qtp.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KG1XMB68Vhrd94qT642sYNbrTggfZvnl108j+8fzkKw=;
        b=HWIZbrQWY6PWg8OyGJnNzoxd1bzRzBODYizO1/s7OgjiPQKc/9yw0Bl8KxXSYAMEUA
         cg2kVfv+o45rPiUTlIbCQHLVSGXQZdBKTP2YXdL508nUegb2YlQ+/eEbWy6VfyHybODk
         hgYxf2OeDJHfRGHJbWmufQvWp2DPZ1TfEggrTaXEb21V3sGLMjzfQUGnQGOxYYhWs3aH
         13sFlzk43m6O+GJCzkx/V49gBIkZ24mReg/8sN6tvZUUnzpbZXCoHORSv3EWmI/f8QeJ
         oKywmAV0a+vDu9WYcH7qCj9r+subEDAevU1AeHInZU47JF1YwY6cdMS1QxuV8u0B59JO
         5kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KG1XMB68Vhrd94qT642sYNbrTggfZvnl108j+8fzkKw=;
        b=lHixeJqfW25zEKpzazDaxdg75ypxY0Kf6fRJTww5y+1zDooCv4LJbTydddi5bS4rLw
         srTYeKP5FKUlzxhvbdbJ7ihorwnn0Pu4RTSeJiu2VdKitMhpqMXJvyJGhzsNIDgCwpnp
         YTc99FnTsEz1259sH68zaBqrR+shHuGu8RNwKwkE4nxNPDbgh2NeiNI4PYKzH2XCeqYQ
         6x09Atn/QjkKsaewcyLvDcHKjszwcmjqYkJWKupiRJkVGcdPl7HtAbJDOt36WESndPhY
         wuUdx2vGf2gPZo/DZ2M+Pa09jWUz8M1E+lWYJQVExK85Jhzbm90JOW+DaGzZ5kbmfrC+
         bl0A==
X-Gm-Message-State: AOAM533B1lBXOjFYj0EvydZU1fmUr4bh7YL80zR6Yx/y9Xoe0wgVpUNG
        wItVizlxxJvKvywRgdE5pe+cstPzpgI=
X-Google-Smtp-Source: ABdhPJy/GXHxiKV5UQ3OF/0zvxP5I793JB8LUkqRHgUlLhl3PeltNNvSZIWVaEUDmhDAwuBycBizxQ==
X-Received: by 2002:aed:3c42:: with SMTP id u2mr18574440qte.159.1605904778774;
        Fri, 20 Nov 2020 12:39:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d48sm3071669qta.26.2020.11.20.12.39.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:38 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdbXO029401
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:37 GMT
Subject: [PATCH v2 066/118] NFSD: Replace READ* macros in
 nfsd4_decode_secinfo_no_name()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:37 -0500
Message-ID: <160590477710.1340.13270366442263923361.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e4ff29ab918c..1e9bd20faa96 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1302,17 +1302,6 @@ nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
-static __be32
-nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
-		     struct nfsd4_secinfo_no_name *sin)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	sin->sin_style = be32_to_cpup(p++);
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *setattr)
 {
@@ -1858,6 +1847,14 @@ nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 }
 #endif /* CONFIG_NFSD_PNFS */
 
+static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
+					   struct nfsd4_secinfo_no_name *sin)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


