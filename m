Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2EF2C15AC
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgKWUG3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgKWUG3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:29 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB0BC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:29 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so14334406qtp.7
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oMBp0l5ZIbayyU9TIa/DdEj+TEEASDrEhSoGu12Mdvo=;
        b=oPXxyqCMTagawatDsHIFkPqvBPgvga/zWZLBrI5MMNw+BxirlpcFQvHR8zqOa2CnBu
         ASCR6mNhtUDffu+JB94me4Gf1fnlCC2z3KScIeCjhMRO+ZcsBZ+V5aFJ/VTIJc38/WOU
         lbpH+twurEFmBpnvTNC7249I5yQHx2gUrM/B4ucXuKmBvl+PaDIfkzlIZTQiHzrE5Gtw
         PrGx7tbSHu3W4/Y9RhlqLAW6dvBU7Dc47NHJUgCyCXgJVz8CUyEaXhqYpR0s5MB2ZJZG
         akvDgNYoeG/UNWm+RWiTSXTVR9d/WyVYfsCrnStMt6HfEMVYhWhkCrW6Nx4c4NBOhNUT
         Dl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=oMBp0l5ZIbayyU9TIa/DdEj+TEEASDrEhSoGu12Mdvo=;
        b=biR0V3Lkc9PepX/XmS7wTi17/OsoupO4W4aBKJUeWe7qz/QdwMGiaXzaiZKnQWxxoF
         wxpxeoI+esg2o7mu9M19TCplcZPev6ZDu6WAC8SFNWJgsSjZtSmbDSWO0RQyjWXrwLcS
         JPQ89xHiZAcPfPcRIx707QajMLfEGZnsRr1BT8enhz+kiTULsROX0wB35ZWwvNNwBUy3
         4Yra99jJpUKpen61vUKVI+SMIdYtsir5V+uqWQ7XB9AouP7ccAZ2HnZM17x236O2VhLh
         gpHg5TXbNZkdLPIt83h4SLblwT1yBjQ/Yn71UGE0b5w4Z0Vk7k8V+R9/ICbxDYUVdJyB
         lmlw==
X-Gm-Message-State: AOAM533Mb2ywOiTTUCVWk71ZoNwsybgfqwiCKNIQLcOUkBhp4yKsInZ2
        qqkHVH+qelvThrmsFO29+CCZ47KlJQ8=
X-Google-Smtp-Source: ABdhPJwqZ+mM8penVSDzVpGuXCG2W1CtWJLeSCckk5/gELHMxbl+A8qQBBbb5sV+b0fGb508TuS8XQ==
X-Received: by 2002:ac8:590f:: with SMTP id 15mr889768qty.249.1606161988198;
        Mon, 23 Nov 2020 12:06:28 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a85sm10632572qkg.3.2020.11.23.12.06.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:27 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6QMZ010352
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:26 GMT
Subject: [PATCH v3 28/85] NFSD: Replace READ* macros in nfsd4_decode_lockt()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:26 -0500
Message-ID: <160616198654.51996.6109418844758808320.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 884ab920bcf8..e2bdc69db4f9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -894,20 +894,16 @@ nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 {
-	DECODE_HEAD;
-		        
-	READ_BUF(32);
-	lockt->lt_type = be32_to_cpup(p++);
-	if((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
-		goto xdr_error;
-	p = xdr_decode_hyper(p, &lockt->lt_offset);
-	p = xdr_decode_hyper(p, &lockt->lt_length);
-	COPYMEM(&lockt->lt_clientid, 8);
-	lockt->lt_owner.len = be32_to_cpup(p++);
-	READ_BUF(lockt->lt_owner.len);
-	READMEM(lockt->lt_owner.data, lockt->lt_owner.len);
-
-	DECODE_TAIL;
+	if (xdr_stream_decode_u32(argp->xdr, &lockt->lt_type) < 0)
+		return nfserr_bad_xdr;
+	if ((lockt->lt_type < NFS4_READ_LT) || (lockt->lt_type > NFS4_WRITEW_LT))
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lockt->lt_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lockt->lt_length) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_state_owner4(argp, &lockt->lt_clientid,
+					 &lockt->lt_owner);
 }
 
 static __be32


