Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C486B2BB780
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbgKTUkd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbgKTUkd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:33 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A48C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:33 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so10275181qkf.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mJ2HlXmzLdua8xXPawn1jQrGyTpFQ4w0pBIrXpQTteU=;
        b=GdF7k7Z6g6SSJ/d+5v4vjaburyYftUl6UWnN5O6GXP6Sm0a1vGuxRAUVh7f5R7p/Sg
         8h0o0FJYzZRvDxYafh6GH2tN1RA6TipG+Pw3t1iLmgAFGw0I0eBahigJ6AhyXmkpCDwc
         Llr1PRLb4MdNwayyAIlgIDhV0p+7ppcm4QGkiJLbCvUDi/0FQ5fyaPVy6zo8niTWncq5
         GU2vLuKRBDiHKCDthpROb6jP+0cRFd0aD4nlh9aqLOIFBUQnQ4P6pexGAK8jYp/U2kMK
         IyavCjdHSy6GZDnwKvPJnw2WTcihbQydZl+B9EnwXFsjvChI41cCxlHeVBR9DANCmUCY
         fLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mJ2HlXmzLdua8xXPawn1jQrGyTpFQ4w0pBIrXpQTteU=;
        b=FOYZwW5vcrzWV2HwDG0bTv+oiEEhUf8mHAzi8Nu9WuSMJzA51b+JzaOxrq8iLeDyu1
         7sCyQg24GAIvDXxvAvCNYWAht4YKLx9RT70ZVS/eo/4wjjGc6UITfyUY6diWgol6ra+E
         CG/EtBOUyV1PTCW+6Ej9PHD48i4M48EsV3Q1pxmuySe3nJ7xJO4TLfJklGEdBw/wAqw0
         I1/eq0cUV7uD9Ld1kXHvT34cGziAZsbD2oMCJwBaPOBHwajKFrHUi6NL7LR7A6sAGiAA
         VSxgqj1uXuWRh5vHzq2Hzo6eu0KCQpw0hUaAqBwXKXYS3qKxTNDm7+EIx6NTV+o8SMcw
         sHXw==
X-Gm-Message-State: AOAM5325+sRsJqOzQPzecyWEcpy7m85U5jLQ5OzMpiYgZ3R4ysTur4Z0
        uOvvorH3+CuPiEanXIET4Eb5axmRbGE=
X-Google-Smtp-Source: ABdhPJzYVmAx0hwgTb4+gU9CcUOH2LTzkoLrFonU69qQ5UPzY4EvpVPjx6iSh+jZRk9cMN8enHUp6g==
X-Received: by 2002:ae9:f70e:: with SMTP id s14mr18076491qkg.340.1605904832123;
        Fri, 20 Nov 2020 12:40:32 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l7sm2808235qtp.19.2020.11.20.12.40.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:31 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKeUxX029441
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:30 GMT
Subject: [PATCH v2 076/118] NFSD: Replace READ* macros in
 nfsd4_decode_xattr_name()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:30 -0500
Message-ID: <160590483026.1340.6535630375900060370.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 520a3c78ea5b..e1f8de971c0a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2069,25 +2069,22 @@ nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
 static __be32
 nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
 {
-	DECODE_HEAD;
 	char *name, *sp, *dp;
 	u32 namelen, cnt;
+	__be32 *p;
 
-	READ_BUF(4);
-	namelen = be32_to_cpup(p++);
-
+	if (xdr_stream_decode_u32(argp->xdr, &namelen) < 0)
+		return nfserr_bad_xdr;
 	if (namelen > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN))
 		return nfserr_nametoolong;
-
 	if (namelen == 0)
-		goto xdr_error;
-
-	READ_BUF(namelen);
-
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, namelen);
+	if (!p)
+		return nfserr_bad_xdr;
 	name = svcxdr_tmpalloc(argp, namelen + XATTR_USER_PREFIX_LEN + 1);
 	if (!name)
 		return nfserr_jukebox;
-
 	memcpy(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
 
 	/*
@@ -2100,14 +2097,14 @@ nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
 
 	while (cnt-- > 0) {
 		if (*sp == '\0')
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		*dp++ = *sp++;
 	}
 	*dp = '\0';
 
 	*namep = name;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 /*


