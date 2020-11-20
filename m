Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7252BB74F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgKTUhi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731345AbgKTUhh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:37 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A5C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:37 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so10183794qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GI76cyr4oe7xQm7VhTwMq1ywtSac9z6BYM24bW5aHVo=;
        b=jR3CI/GyYWzdpN+0LzS0g4upLGcTbCqOPQpVGfmrz/oT4yIWQ888lFsYqA1GSowxR0
         0+X4nJCezbNSi1h6n3IIjc2WmiCVxc5q8D2dLs/7lhEHNhlEaJSliwFWfGPZIcMcgANF
         W3cB4SVB8Sw/li+bXf2qReSEUh+hIrVMl0zTZ2EnYJ0QVSWCbQ3oJ1Frz7JpDvl9zf01
         Az1vHY7YCj+g/PmEIROrh7vzJKzbRaPBJe1JexRwLZUUXusW9fNZq4mg7uRxIGRoovOM
         dmpouEKsj1htMaOt6TWea2VHPvD5yBj030uNlZnV2idP2VMr1k5p2QQVlProGK5zMJIl
         gApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GI76cyr4oe7xQm7VhTwMq1ywtSac9z6BYM24bW5aHVo=;
        b=pXuiTSZ8mpMDD4aDkjmBnZU2Zwoso/zYiExVMy4rse0wYqNEjIoobdIcgAy1msdbRd
         sIyE9Gllej9JgllxAn3PDTkJq7Azg8P1WmT56b3pOlDhDjQYF8k/AIMXHsenoOdViNMG
         1KxTmLoRc2cEopQFIgLVhG4NqpwladPgtVALQx+miZY7ni/0uWWtG8FkPUu+I+KvLOjs
         IHrGa4xvS9y462ZrQ0+hFzB4D2Z4bdam3ZMWWjUjgMCarn7f5L6RzDn9dzyEa+26GikE
         PGtRutAqh0+dmu4L0nBRakwkj81ctO6YG0UY4IILjAoAZFxsF6Yu2XrSK99BAkICfZ4h
         YWVg==
X-Gm-Message-State: AOAM532JJUidMhZjJvFHlrN+NNsRvKau/1i7Ar4FH2O1u3Bw9eicHr94
        6SsfLOt+93j1EYIth4wayD6ChYhLPnk=
X-Google-Smtp-Source: ABdhPJybrjdOYGlBFVSaLRyE+Iz2a26IqIdQMhKEcovIdTipHLl2g/D5GNLxxsgwtTMR7KeblJvHLw==
X-Received: by 2002:a05:620a:627:: with SMTP id 7mr18145227qkv.354.1605904656653;
        Fri, 20 Nov 2020 12:37:36 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o187sm2887170qkb.120.2020.11.20.12.37.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:35 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbYMx029331
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:34 GMT
Subject: [PATCH v2 043/118] NFSD: Replace READ* macros in
 nfsd4_decode_rename()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:34 -0500
Message-ID: <160590465484.1340.825247480078962188.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 964cfe3d9409..0c78f115dac9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1207,22 +1207,12 @@ nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove
 static __be32
 nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(4);
-	rename->rn_snamelen = be32_to_cpup(p++);
-	READ_BUF(rename->rn_snamelen);
-	SAVEMEM(rename->rn_sname, rename->rn_snamelen);
-	READ_BUF(4);
-	rename->rn_tnamelen = be32_to_cpup(p++);
-	READ_BUF(rename->rn_tnamelen);
-	SAVEMEM(rename->rn_tname, rename->rn_tnamelen);
-	if ((status = check_filename(rename->rn_sname, rename->rn_snamelen)))
-		return status;
-	if ((status = check_filename(rename->rn_tname, rename->rn_tnamelen)))
+	status = nfsd4_decode_component4(argp, &rename->rn_sname, &rename->rn_snamelen);
+	if (status)
 		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &rename->rn_tname, &rename->rn_tnamelen);
 }
 
 static __be32


