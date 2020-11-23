Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856C12C1620
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgKWULW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732613AbgKWULO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:11:14 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035F1C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:13 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so14381578qts.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4UEevN2uridC4rd22mTHJg89O0CJblgI8EsCgqcRg08=;
        b=Ci6TfQ0vrr7gKAnADbx4ZXbZY8vPXrLW0YaLk+8na3omc440SvaxNxbvAzx8cMgKmP
         v8lkS/eajO3avy+I/R32RF5Va58SYiLspYYH8XZiKbITEjfE1USUBrq09EMZhXaE68jN
         owMh0GKyCTb2tTyq1nNc0DfaFQ0cY7d/3JNNmqKwvslj5Zp2FOtFKCnI5V9yJRY4Uk44
         /w4cINLBU7NOpTHAV6Qzp7JP3zjxOTmC15bWIATm3Ya2xXssm+ygMQhqYLQnE+lUc+tE
         b+tmu1L7C3m3HxJTmd5Mgv+oqwEZYmooumn+B0yvPNbW7TOT7mQL6QCHIguZsK4PiTfo
         hSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=4UEevN2uridC4rd22mTHJg89O0CJblgI8EsCgqcRg08=;
        b=Js/CAcq/xAt/yTCJxFRodd0+BVbVtMJuyb1lxXlgGq/ittp1NrZVDT2Iot6lx7LOLZ
         fMmr5QEh9nUDKexaRLuIHX/cO8VCv8P47ll5aOVvehFSw5RD89JG6SuaQeylFPTUzU3Q
         MFfnQwZvcmTFP7COjl8rEKscsDPVGEWfE+9Fr0mcJTorjoHXccO++tLpkAEPauhmRV/G
         ZGgkOWtqnZAufrHKYbp6UXYSFOipiT+Pj+6lxn7mLGpQiZO3E0Qi/g2VSq6nSCBkHFsH
         0+xP+W4Ui/apGIIleCgu5ADcwFuwCWwA14Z0TNdKAe+V/xY7Yat8xFraGJcCQmT+yz4c
         1i5g==
X-Gm-Message-State: AOAM5319QctNO/aCWyx8NjmQNkIsDDGs5suAlO1+YggwWXSHHP5fPhcI
        rXBmhSrez1P7fHiOIJUgUYLLLESUHbI=
X-Google-Smtp-Source: ABdhPJyw5RsdtR5h0niILALRWz14WNYaE5sZLaTNuANUODNOexy4qP4rtAy1p59h+H97qumkU3zf5w==
X-Received: by 2002:aed:22c5:: with SMTP id q5mr930109qtc.234.1606162271911;
        Mon, 23 Nov 2020 12:11:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 199sm10562167qkm.62.2020.11.23.12.11.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:11:11 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKBAuO010530
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:11:10 GMT
Subject: [PATCH v3 82/85] NFSD: Replace READ* macros in
 nfsd4_decode_listxattrs()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:11:10 -0500
Message-ID: <160616227012.51996.1314752989338362514.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2f47fef17b59..8163c529e497 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2223,11 +2223,10 @@ static __be32
 nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 			struct nfsd4_listxattrs *listxattrs)
 {
-	DECODE_HEAD;
 	u32 maxcount;
 
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &listxattrs->lsxa_cookie);
+	if (xdr_stream_decode_u64(argp->xdr, &listxattrs->lsxa_cookie) < 0)
+		return nfserr_bad_xdr;
 
 	/*
 	 * If the cookie  is too large to have even one user.x attribute
@@ -2237,7 +2236,8 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 	    (XATTR_LIST_MAX / (XATTR_USER_PREFIX_LEN + 2)))
 		return nfserr_badcookie;
 
-	maxcount = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &maxcount) < 0)
+		return nfserr_bad_xdr;
 	if (maxcount < 8)
 		/* Always need at least 2 words (length and one character) */
 		return nfserr_inval;
@@ -2245,7 +2245,7 @@ nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
 	maxcount = min(maxcount, svc_max_payload(argp->rqstp));
 	listxattrs->lsxa_maxcount = maxcount;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


