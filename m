Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D222BB765
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgKTUiw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbgKTUiw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:52 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD7C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:51 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id i12so8141096qtj.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nFWEfB5Bp3Oh1ragw37OYASFp46sha0ksjZh9Eof5EM=;
        b=lC+NPN13EMmUSbCX5hDNq1yiVuGMN9nl2JSaQkrZCK6lXOMEaf6NlkVkzybZua391/
         ZOXIlY1/4eOKJeNmvrPGfCOkUu1eh6HCI1xf2TjkI041iCH9waBlqHF286b1HB4Z1LrH
         nH7R6jORuCgwz8h+3lva1QPgUinG8u5DsKSZPrCqjkR6V8h5EFuGK4oxUj90DKiWeaiH
         1D7Un04tBLOEKri1t2B5HnSytViGXQWhSGij2w56/tjGt5kfg8ILs1/Vw3yf5vTTNRLP
         spFS1HEmsAKr98ON0Q3sqxmzmHpGnfEzKkJHw3Yat8miSeDJDQU5lpDZmkzc4W8BVRKX
         byew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nFWEfB5Bp3Oh1ragw37OYASFp46sha0ksjZh9Eof5EM=;
        b=LV5YwJciROp4JT0kOgfahrUWQN99B006+/FFD+KQpN0QzCniCt3SyILrR/Nj2QdpcZ
         vKY8qk1JRplDlWcRs2asuk2eC8FDHp82TMXNpwTSuknIz3xi7upgKekh4ivf+XLImZDq
         zEUV0cY7cWQ5io+FaziHFMCrTEGM7jt6ZkM7QuEtwh/kqnY6JNWyseNO7lmOCq6coiZ7
         qBQNAcJcnqfjBdOtCVCDZNz2WUrywj8QAdDcd3qcB/xBuI0cAq6GP+ZJX07x7o9OH5py
         vEQ42FN3C7I4/6aCEXpzLxVShZqRJAnKp+w2AfDUsfXkpvHKgTdlgq5TWzsWAka6PVXG
         3D1Q==
X-Gm-Message-State: AOAM532Sq81ik+DtXfjQQ9x5tLOe4dlfkRxlJ0CI4Spkml1zkxYdCS18
        2PpkZnrIRCZtu9CSXdWoAuoOJS5/1eg=
X-Google-Smtp-Source: ABdhPJxLY5V9xy68ehAMsrSYxPGAqcXB04TQptZl9SKaEa7xbIJvlnN5u8sfD1fjvUHBc+JLOjugOA==
X-Received: by 2002:ac8:734c:: with SMTP id q12mr7144404qtp.239.1605904730875;
        Fri, 20 Nov 2020 12:38:50 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g143sm2804444qke.102.2020.11.20.12.38.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:50 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKcnMB029374
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:49 GMT
Subject: [PATCH v2 057/118] NFSD: Add a helper to decode nfs_impl_id4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:49 -0500
Message-ID: <160590472921.1340.11956801625475654595.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   63 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bb2e83ad61a4..18b41af204a6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1499,12 +1499,47 @@ static __be32 nfsd4_decode_state_protect4_a(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_nfs_impl_id4(struct nfsd4_compoundargs *argp,
+			  struct nfsd4_exchange_id *exid)
+{
+	__be32 status;
+	u32 count;
+
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+	switch (count) {
+	case 0:
+		break;
+	case 1:
+		/* Note that RFC 8881 places no length limit on
+		 * nii_domain, but this implementation permits no
+		 * more than NFS4_OPAQUE_LIMIT bytes */
+		status = nfsd4_decode_opaque(argp, &exid->nii_domain);
+		if (status)
+			return status;
+		/* Note that RFC 8881 places no length limit on
+		 * nii_name, but this implementation permits no
+		 * more than NFS4_OPAQUE_LIMIT bytes */
+		status = nfsd4_decode_opaque(argp, &exid->nii_name);
+		if (status)
+			return status;
+		status = nfsd4_decode_nfstime4(argp, &exid->nii_time);
+		if (status)
+			return status;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)
 {
-	DECODE_HEAD;
-	int dummy;
+	__be32 status;
 
 	status = nfsd4_decode_verifier4(argp, &exid->verifier);
 	if (status)
@@ -1517,29 +1552,7 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 	status = nfsd4_decode_state_protect4_a(argp, exid);
 	if (status)
 		return status;
-
-	READ_BUF(4);    /* nfs_impl_id4 array length */
-	dummy = be32_to_cpup(p++);
-
-	if (dummy > 1)
-		goto xdr_error;
-
-	if (dummy == 1) {
-		status = nfsd4_decode_opaque(argp, &exid->nii_domain);
-		if (status)
-			goto xdr_error;
-
-		/* nii_name */
-		status = nfsd4_decode_opaque(argp, &exid->nii_name);
-		if (status)
-			goto xdr_error;
-
-		/* nii_date */
-		status = nfsd4_decode_time(argp, &exid->nii_time);
-		if (status)
-			goto xdr_error;
-	}
-	DECODE_TAIL;
+	return nfsd4_decode_nfs_impl_id4(argp, exid);
 }
 
 static __be32


