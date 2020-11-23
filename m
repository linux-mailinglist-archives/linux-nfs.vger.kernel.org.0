Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991612C1636
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgKWUM0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731794AbgKWUKF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:05 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487E4C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:05 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so18235805qke.8
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7SIeL2JJXEWAu2oUfB3SEbTHlCZXi/YUOEAb5EOSfkc=;
        b=aZKHGwIWRQ5NlKftee2YHEbLWoEI+xD4gtdlxqEOjqrFeSC+CFTaN2guptENCNB12B
         SR3wAjjgCStRJv4wqSqufYOEo80LHiSf3FPSa3cWf+vJ89yYUCYHDwH11gpHjfucCKSX
         aN32pLRLUsEZWWGSrx4+Zg8mOubFpQVHtXJ2QoJid7ZPHAiJ88Wu/VNXzVL2vNNNAZ5+
         o6UKELzNT0D9vWEhJLd1qam5EPi/erboraQsf6Lab5qh6IJn9kHO8UvIOOcwUFZ7c+Wk
         YY+1yx4NhkA+OAIoU5l19BQE7b2AccCjnq22i+UjAMWWYay/Veulo1C5mUe1WJUt7vAY
         auxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7SIeL2JJXEWAu2oUfB3SEbTHlCZXi/YUOEAb5EOSfkc=;
        b=VML3R6bY1O1PqyTTWimO+7Yq3HE2UHykvMuBuRVUnApgbuAc1y27bmSv1IWDd9bn+3
         4/pqqoVAM3rpbykuFokzNfJxntdeN5fIObh6bTTdFIkr/wj1jrbIfwYyFITBZ5Qkmqep
         UNZL+TkAzGV6uZU7I/2htnzprEvP9iKqRwWcl0Sve8sOsE2WK+hjt0lerZac8hD6s63L
         nnvIIwdprJlxy3R0jg+A3jx8e64eAdRHvS3Iufg9sLxhSTeaYEsPwu3AYfFe/FFMzq3J
         rWGQPMfJGlGUexer4zUWrkAEjilfP7FUFrEjwLjAUIImeaF4nDJlInOFYYksgTDySMrX
         cZrw==
X-Gm-Message-State: AOAM532J4hRucy8TI23cNMYh1LgOFUNB+gF6LYNCkyA/1umwvBcymaJa
        CDsz+/iokiSmJ/THTO89e/7PVY6BWKU=
X-Google-Smtp-Source: ABdhPJwyQAoRSlw2HXQI7+jT76ojvzOlXqJR4Mxm0z3XyYiY89Sp1DhpoPOc7mRA2rRTLGQCvr2maA==
X-Received: by 2002:a05:620a:12ca:: with SMTP id e10mr1226294qkl.209.1606162204221;
        Mon, 23 Nov 2020 12:10:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c27sm10190087qkk.57.2020.11.23.12.10.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:03 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKA2rk010491
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:02 GMT
Subject: [PATCH v3 69/85] NFSD: Replace READ* macros in
 nfsd4_decode_sequence()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:02 -0500
Message-ID: <160616220244.51996.226421916291445047.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 903abb421e88..04f2a9941972 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1738,22 +1738,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32
-nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_sequence *seq)
-{
-	DECODE_HEAD;
-
-	READ_BUF(NFS4_MAX_SESSIONID_LEN + 16);
-	COPYMEM(seq->sessionid.data, NFS4_MAX_SESSIONID_LEN);
-	seq->seqid = be32_to_cpup(p++);
-	seq->slotid = be32_to_cpup(p++);
-	seq->maxslots = be32_to_cpup(p++);
-	seq->cachethis = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_stateid *test_stateid)
 {
@@ -1915,6 +1899,26 @@ static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
+		      struct nfsd4_sequence *seq)
+{
+	__be32 *p, status;
+
+	status = nfsd4_decode_sessionid4(argp, &seq->sessionid);
+	if (status)
+		return status;
+	p = xdr_inline_decode(argp->xdr, XDR_UNIT * 4);
+	if (!p)
+		return nfserr_bad_xdr;
+	seq->seqid = be32_to_cpup(p++);
+	seq->slotid = be32_to_cpup(p++);
+	seq->maxslots = be32_to_cpup(p++);
+	seq->cachethis = be32_to_cpup(p);
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


