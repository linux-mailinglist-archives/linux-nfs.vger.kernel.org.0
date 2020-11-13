Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D162B1DFA
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKMPDV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKMPDT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:19 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A1CC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:18 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so4697424qvb.6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pM0PO+aDwWs+bvXXts7opUXIQ+5lV4ayeYZ6oNz/u5E=;
        b=kp+WM69SiVrGpCWBLZNyiRjjtlpbjDhb9X2nKKUrDEot/xLXqfKilS98omr/7V/jmA
         OqEs5Cy+h7oXG4aQMUZuXKI7sID3gYvjF7qJ/E+PqeLj4HRwW46mlLch5HwMca1vA72A
         /pmWwLAh75axELAZdCHiLa4GijsxkSo9v6/fhP/xk4wO02T8A8aGr3JlKdyp2FSUev6v
         Z/s8uSWH9y0+GjlyDSOzR+JAsBLoTJANM+XIxEJzmhnDTlC8A1bfNuSyKSAM2OD56c9r
         qpG5pLfUG3zNtZP/FFnoTaTLeEqv2vi4rJEvRUYQuEWZhfeck1s1tyDOgYGusU/Jv++M
         Vg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=pM0PO+aDwWs+bvXXts7opUXIQ+5lV4ayeYZ6oNz/u5E=;
        b=GErr2EZm75aU4jV892Rg0MCdxLjaIxmJAIWyyiRmoTCOuX9pgR3x/mKLed3XCrYbF4
         3nw32x/d+1HmsCae5BNXkQ0R0ZVd/uvQGcFtQbWV+JuWBlNsek2miRwiNjQ4ueF/z3oe
         KXjWif5qm1fRj9EUc0fje8Zsg9mPMjMYd1Q0Jf0FK65nFI+3mh+o77P4+SrDRyllF3IF
         2aQOQC3/E+ZWlMD8Bvk/W6Wq/Ufr65vzCqaZQYU1FSyNssHwc4GxPnrH+JzyWZKgXg3/
         NnQYwNenDPgqpbwkM30nD98d3otIMjJ8wFnP3ytTNltG6uFy5SqyNme4NX7DZ2LCGYH+
         CCig==
X-Gm-Message-State: AOAM5306Lrgxhvq1Kgo4pRfzQeYZC88+aCRRBkErbtnpfppStaaXreoC
        YXf31fAv+UfUongqPCz3XSXwjGYJV2s=
X-Google-Smtp-Source: ABdhPJwgGY0XasAQhuSToIIo8mYjqxFvyMxNzS6J5qTTSnMKvuKkAhldMtIdsc8P9oKTdQme3GB5Ag==
X-Received: by 2002:a0c:d414:: with SMTP id t20mr2859804qvh.34.1605279797669;
        Fri, 13 Nov 2020 07:03:17 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e22sm6483316qtq.38.2020.11.13.07.03.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:17 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3GGf032667
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:16 GMT
Subject: [PATCH v1 10/61] NFSD: Replace READ* macros in nfsd4_decode_bitmap()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:16 -0500
Message-ID: <160527979624.6186.5009509470610259534.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   57 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3cd5b2c843d8..bc36c746b293 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -246,29 +246,29 @@ nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 }
 
 static __be32
-nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
+nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval,
+		     u32 bmlen)
 {
-	u32 bmlen;
-	DECODE_HEAD;
+	__be32 *p;
+	u32 len, i;
 
-	bmval[0] = 0;
-	bmval[1] = 0;
-	bmval[2] = 0;
+	for (i = 0; i < bmlen; i++)
+		bmval[i] = 0;
 
-	READ_BUF(4);
-	bmlen = be32_to_cpup(p++);
-	if (bmlen > 1000)
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		goto xdr_error;
+	if (len > 1000)
 		goto xdr_error;
 
-	READ_BUF(bmlen << 2);
-	if (bmlen > 0)
-		bmval[0] = be32_to_cpup(p++);
-	if (bmlen > 1)
-		bmval[1] = be32_to_cpup(p++);
-	if (bmlen > 2)
-		bmval[2] = be32_to_cpup(p++);
+	p = xdr_inline_decode(argp->xdr, len << 2);
+	if (!p)
+		goto xdr_error;
+	for (i = 0; i < len && i < bmlen; i++)
+		bmval[i] = be32_to_cpup(p++);
 
-	DECODE_TAIL;
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32
@@ -282,8 +282,9 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 
 	DECODE_HEAD;
 	iattr->ia_valid = 0;
-	if ((status = nfsd4_decode_bitmap(argp, bmval)))
-		return status;
+	status = nfsd4_decode_bitmap4(argp, bmval, 3);
+	if (status)
+		goto out;
 
 	if (bmval[0] & ~NFSD_WRITEABLE_ATTRS_WORD0
 	    || bmval[1] & ~NFSD_WRITEABLE_ATTRS_WORD1
@@ -665,7 +666,8 @@ nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegretu
 static inline __be32
 nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
 {
-	return nfsd4_decode_bitmap(argp, getattr->ga_bmval);
+	return nfsd4_decode_bitmap4(argp, getattr->ga_bmval,
+				    ARRAY_SIZE(getattr->ga_bmval));
 }
 
 static __be32
@@ -1060,7 +1062,9 @@ nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *read
 	COPYMEM(readdir->rd_verf.data, sizeof(readdir->rd_verf.data));
 	readdir->rd_dircount = be32_to_cpup(p++);
 	readdir->rd_maxcount = be32_to_cpup(p++);
-	if ((status = nfsd4_decode_bitmap(argp, readdir->rd_bmval)))
+	status = nfsd4_decode_bitmap4(argp, readdir->rd_bmval,
+				      ARRAY_SIZE(readdir->rd_bmval));
+	if (status)
 		goto out;
 
 	DECODE_TAIL;
@@ -1206,7 +1210,9 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 {
 	DECODE_HEAD;
 
-	if ((status = nfsd4_decode_bitmap(argp, verify->ve_bmval)))
+	status = nfsd4_decode_bitmap4(argp, verify->ve_bmval,
+				      ARRAY_SIZE(verify->ve_bmval));
+	if (status)
 		goto out;
 
 	/* For convenience's sake, we compare raw xdr'd attributes in
@@ -1285,12 +1291,13 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 		break;
 	case SP4_MACH_CRED:
 		/* spo_must_enforce */
-		status = nfsd4_decode_bitmap(argp,
-					exid->spo_must_enforce);
+		status = nfsd4_decode_bitmap4(argp, exid->spo_must_enforce,
+					      ARRAY_SIZE(exid->spo_must_enforce));
 		if (status)
 			goto out;
 		/* spo_must_allow */
-		status = nfsd4_decode_bitmap(argp, exid->spo_must_allow);
+		status = nfsd4_decode_bitmap4(argp, exid->spo_must_allow,
+					      ARRAY_SIZE(exid->spo_must_allow));
 		if (status)
 			goto out;
 		break;


