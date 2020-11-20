Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ECA2BB76F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgKTUjf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730886AbgKTUje (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:34 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F39C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:34 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id e14so5332979qve.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UMjN38ndoKFHRcaUc3cGj/K26T9bzxmJKlQVRgKnIfY=;
        b=cIKc/ueZaZCh1lLEt+a/2FpNZS7n7NMvDumo2WbtQ4HrFS6uKL6Pq0RQGiaG27samK
         ZJtXw6VpQkTQCF44hdMGaeZGFS06MuIqKrOenF+949jbU+AGfUqLREwuG0+xf+F+pyxV
         INuF2wDdSvVYfubxRmTRdZYI7SFKCEN7vJShIc0gRNrGCmiDNJxQ0czaQoVMP6pQ4fZf
         rOBd+IAMT0+RjxWP7NTmu29mdTiqZ+3Mt08S5iYDhKcQ3sOhoK1Gr3BZNMe0r9BTThe+
         CY8DvVE7Pp9IJtsv9P5dDLHEbDAALk5Kk8nQTLhLxugRAX4T6nDaRF2Ii1I5m7uVMFnI
         JhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UMjN38ndoKFHRcaUc3cGj/K26T9bzxmJKlQVRgKnIfY=;
        b=izeV0oRIU4EzuuhIvA1m6mNseq8GOwRNxYzgFpzbjzS4GXCyPuRXTWiGU2LfZKCy+u
         SSX9PqywQYd0lcdsPlDRTVa8DtbnY4Qv5eJEh3gWIL3wUQjKmQhrczLp2q/mIseKfjgS
         uRFigKqTnk2+blwrsXX+CFxi2DefgDSt+3oBFSaAbSendvaIF+7yhb500JvJLuL8MZVU
         1zLMCBvHuYlBCi3bQB0EX8kv5KC2afyAu5qML6BnVPwD8QnPdPMXgFG+Xctm1XqsU8el
         csjc6Om1qnHG1WNdFgJ7PjQzPQ2P7tHr1fbZ1+zZjp7jVSXpBP8WGxxquOuFUIWEOvZm
         eGXQ==
X-Gm-Message-State: AOAM533b88jpgCv9/E2OlEI7dFdURi4YjwchV55326gdywfwfc7wqGIt
        WwXNAyuDLrZRmnJg1xltqY0dDcTMnO4=
X-Google-Smtp-Source: ABdhPJzhDek8ybILOMb9iJcaWFbYU1mcMDAXlGPejOz3pJq+A0RaNVqw2lCYZsJUUVBmmVR5yPK21A==
X-Received: by 2002:a0c:9003:: with SMTP id o3mr2075739qvo.62.1605904773463;
        Fri, 20 Nov 2020 12:39:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q15sm2741822qki.13.2020.11.20.12.39.32
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:32 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdV38029398
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:31 GMT
Subject: [PATCH v2 065/118] NFSD: Replace READ* macros in
 nfsd4_decode_layoutreturn()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:31 -0500
Message-ID: <160590477177.1340.2179693473939435787.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   72 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8add9b5242f1..e4ff29ab918c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -605,6 +605,43 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_layoutreturn4(struct nfsd4_compoundargs *argp,
+			   struct nfsd4_layoutreturn *lrp)
+{
+	__be32 status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_return_type) < 0)
+		return nfserr_bad_xdr;
+	switch (lrp->lr_return_type) {
+	case RETURN_FILE:
+		if (xdr_stream_decode_u64(argp->xdr, &lrp->lr_seg.offset) < 0)
+			return nfserr_bad_xdr;
+		if (xdr_stream_decode_u64(argp->xdr, &lrp->lr_seg.length) < 0)
+			return nfserr_bad_xdr;
+		status = nfsd4_decode_stateid4(argp, &lrp->lr_sid);
+		if (status)
+			return status;
+		if (xdr_stream_decode_u32(argp->xdr, &lrp->lrf_body_len) < 0)
+			return nfserr_bad_xdr;
+		if (lrp->lrf_body_len > 0) {
+			lrp->lrf_body = xdr_inline_decode(argp->xdr, lrp->lrf_body_len);
+			if (!lrp->lrf_body)
+				return nfserr_bad_xdr;
+		}
+		break;
+	case RETURN_FSID:
+	case RETURN_ALL:
+		lrp->lr_seg.offset = 0;
+		lrp->lr_seg.length = NFS4_MAX_UINT64;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 #endif /* CONFIG_NFSD_PNFS */
 
 static __be32
@@ -1811,34 +1848,13 @@ static __be32
 nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutreturn *lrp)
 {
-	DECODE_HEAD;
-
-	READ_BUF(16);
-	lrp->lr_reclaim = be32_to_cpup(p++);
-	lrp->lr_layout_type = be32_to_cpup(p++);
-	lrp->lr_seg.iomode = be32_to_cpup(p++);
-	lrp->lr_return_type = be32_to_cpup(p++);
-	if (lrp->lr_return_type == RETURN_FILE) {
-		READ_BUF(16);
-		p = xdr_decode_hyper(p, &lrp->lr_seg.offset);
-		p = xdr_decode_hyper(p, &lrp->lr_seg.length);
-
-		status = nfsd4_decode_stateid4(argp, &lrp->lr_sid);
-		if (status)
-			return status;
-
-		READ_BUF(4);
-		lrp->lrf_body_len = be32_to_cpup(p++);
-		if (lrp->lrf_body_len > 0) {
-			READ_BUF(lrp->lrf_body_len);
-			READMEM(lrp->lrf_body, lrp->lrf_body_len);
-		}
-	} else {
-		lrp->lr_seg.offset = 0;
-		lrp->lr_seg.length = NFS4_MAX_UINT64;
-	}
-
-	DECODE_TAIL;
+	if (xdr_stream_decode_bool(argp->xdr, &lrp->lr_reclaim) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_layout_type) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_seg.iomode) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_layoutreturn4(argp, lrp);
 }
 #endif /* CONFIG_NFSD_PNFS */
 


