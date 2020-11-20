Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5202BB750
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgKTUhn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbgKTUhn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:43 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBB0C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:43 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id e14so5330448qve.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3G5VUcPDf4sDfCyQBkrV47uCXx9GhaLkmVjhvjJWN8E=;
        b=OOtsBU2/DLYP2xV6mIjBp8+EVap1ny022vSBpWU+FByBgSEPM2oxFqVpAIhXHWeHVf
         iAdxYBmpwIhd7aWhhR/UF8//CTBheiSZjnn3KNtWuqJei6rraClDI9pKwZTugd+XAPZC
         oVQbXznJ/PuDvzisKQ8B9i3P6JW73nBcvlzWJYyTOXjAw3hg/a4fwZnHl6s305oSiyad
         ecYANKWCQy0YqAZkihJXxnPl+8ZLRFY946fSC8lRuK44M5WdPxkGZ8V2UOdaA/M226S8
         R7RchlLNVpV/xbiB+RvdWohv/woTn0YY8dW1AiL/S/c54BfSKsS3xHSy9I2Rd+am6wj1
         FibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3G5VUcPDf4sDfCyQBkrV47uCXx9GhaLkmVjhvjJWN8E=;
        b=mlMVfoBvhofoVOanOEOCa9tnjyASVLaWbuP0aRkI60yq4xj9446AlStl2YJmz58LJA
         f23qRKJwOlVFMbzv5zBVVYDW4sJCJPY5JrjQhlOHD9J1hiEvNGck414/1zUXaxGHVPqv
         KZAV5qVUDOwtjoUAeSzzcX+uon5Ijw0Ifzf+ZWDoSHYK+iimtITO8zM1ah8MjP4tzMxu
         lYHtG4azgOyUkUUPTPk7ifAHu1dsfsClLXEPHHv8tFl4fWyslRD6hrkQiEjsc6mNOJ65
         tjzP2zOhXtHDF6IPVy7oCTPUocI1GfYm+gpfuPO0AQRebvN9/DJKhJGK8ywXwaouoa0F
         buvQ==
X-Gm-Message-State: AOAM5302BcDkaD1rZR80UCsSxFCMgoqX5qDsj3Rvv94XWpy1tS5lAXJU
        2HXEoKU5JsgOwbCoW1u5yGMJBq/k3xw=
X-Google-Smtp-Source: ABdhPJxoFMUsxz4Y8TC6HL6TQMCC336P4yJBkli57Y1Mc7leAIAhO2okJZxyPTIuCnEnLFE5z4D7uA==
X-Received: by 2002:a0c:c583:: with SMTP id a3mr18458108qvj.2.1605904662081;
        Fri, 20 Nov 2020 12:37:42 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r125sm2621871qke.129.2020.11.20.12.37.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:41 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbeoD029334
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:40 GMT
Subject: [PATCH v2 044/118] NFSD: Replace READ* macros in nfsd4_decode_renew()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:40 -0500
Message-ID: <160590466023.1340.5442107413838909526.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0c78f115dac9..19e8a61c8409 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1218,15 +1218,7 @@ nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename
 static __be32
 nfsd4_decode_renew(struct nfsd4_compoundargs *argp, clientid_t *clientid)
 {
-	DECODE_HEAD;
-
-	if (argp->minorversion >= 1)
-		return nfserr_notsupp;
-
-	READ_BUF(sizeof(clientid_t));
-	COPYMEM(clientid, sizeof(clientid_t));
-
-	DECODE_TAIL;
+	return nfsd4_decode_clientid4(argp, clientid);
 }
 
 static __be32


