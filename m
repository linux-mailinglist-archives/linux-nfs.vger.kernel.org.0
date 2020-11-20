Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49EB2BB72E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbgKTUf0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbgKTUf0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:26 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5CC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:24 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so8121964qts.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=w51jTsJ+0/q08obYUG4zM8CWxFvmc80MCCnQwrMkxBg=;
        b=pfTudrO+rRKMpUr3iGwIBKHITyuDSNubIGP0VuDJimFZGTXirrQz3uLs8ci4GWH1MV
         RptLYkxCkzIiE795w6IGGlMuDxw699uqaHsJoi9mTNQy+WIhoZwKDgNfERe0ejZVBAz9
         DOtI+BqLBy1Wdjdr9iGo5cUilbWyHYaY1sRPKAL8TO0oBV4BsUdPlS2iexS1lDZIhpDr
         wg2yq8XrjyW+N/XBCFv2Tt1R5o0lE+es4sQvN53oX/IBgd5KUJ2TwGue57FvVAvNruMj
         3nkLMLKPvGab5VB0kGxi/HZL4yEIz+GOzOl8OIyetnuUaIIPm/RRDkfElNUcE9tH4fYf
         oUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=w51jTsJ+0/q08obYUG4zM8CWxFvmc80MCCnQwrMkxBg=;
        b=KsN9Hzx8QDRlXrBrIHFHTOd/neaJIvtXdMXH4snGP9a2AcRAXwo+/VIjB0G6NYREz6
         lJW0WBnUbuvt/kzLZt0AjFTjjhHOXyGIHAMmxheapMfflnGOEJcwAWiRAknREezqSxC4
         mGCG8BdiVkY1fpAVNfScy8BWbP1NtdECutZTWopxmi714vB1tCrFlULfL3y/Xe17NFCv
         wMHWg2yk84ikyLJkkeSkrv1mo1OHQ2zr1R3peCUEVvgJQ/ZzmMEE/cerQZWogT4RLrP2
         zKrrdweGTbHaZh5o/KOBbIpeD6yq7NWZKt/HdhLRpDqdwWYqx6Uwve4xA/3k7XAAObDL
         b+nQ==
X-Gm-Message-State: AOAM533lLx3UoPfFVH9P4L8lAvFWNDFA3VMUuPIxFuxfF6S4IIyBRQc9
        ZKmynYN8WZy/5Mcdn/EWZH1JmrVQtL4=
X-Google-Smtp-Source: ABdhPJxZRD7qRj757vSfAqMzSZaY9qz4SVtt8N5uQOyl3Bu0Qb0xMRv777xHqz8lVfWWRVzx7elN2g==
X-Received: by 2002:ac8:5c4e:: with SMTP id j14mr18596780qtj.241.1605904523689;
        Fri, 20 Nov 2020 12:35:23 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g9sm2765922qtq.21.2020.11.20.12.35.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:23 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZL3O029256
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:21 GMT
Subject: [PATCH v2 018/118] NFSD: Replace READ* macros that decode the fattr4
 umask attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:21 -0500
Message-ID: <160590452194.1340.6979108487209267027.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a5207a36199c..046fe62bfa29 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -356,7 +356,6 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 {
 	unsigned int starting_pos;
 	u32 attrlist4_count;
-	u32 dummy32;
 
 	DECODE_HEAD;
 	iattr->ia_valid = 0;
@@ -472,13 +471,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 			return status;
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
+		u32 mode, mask;
+
 		if (!umask)
-			goto xdr_error;
-		READ_BUF(8);
-		dummy32 = be32_to_cpup(p++);
-		iattr->ia_mode = dummy32 & (S_IFMT | S_IALLUGO);
-		dummy32 = be32_to_cpup(p++);
-		*umask = dummy32 & S_IRWXUGO;
+			return nfserr_bad_xdr;
+		if (xdr_stream_decode_u32(argp->xdr, &mode) < 0)
+			return nfserr_bad_xdr;
+		iattr->ia_mode = mode & (S_IFMT | S_IALLUGO);
+		if (xdr_stream_decode_u32(argp->xdr, &mask) < 0)
+			return nfserr_bad_xdr;
+		*umask = mask & S_IRWXUGO;
 		iattr->ia_valid |= ATTR_MODE;
 	}
 


