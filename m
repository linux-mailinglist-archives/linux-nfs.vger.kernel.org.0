Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B972B1E29
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKMPGY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPGX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:23 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F94C0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:23 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so9029109qkq.6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JzEkf301vBxksCdSOI+3LD73ofrahQzDQV1IM/I4/b0=;
        b=EUOBnw+UUqxjLEug7rk4q1dT7TCbGIeZz7wtR0/HgOkXPrWLw8bfatV88A0JxQe9JY
         7TeRgAjAOsvse3JIxPTrdHqdM24JP0+tLwPKBbsITfNO68QjVdULCO3/kHncn90DtAsm
         SfHc37rQLEff/HKkKzCcKhGH8emH83Zlr3h8fgyKR+onyPCDPbkqQs+G38jMV5bGkyxY
         VEJBRLGShnCc5D3zh5FpPJI0YfzP71tM1tA6Krh+6oPh5o3kQec/l13VcoS3VEve8USX
         xpnAHt7jj2CQ3Ttg6GCCPNioL3QwbzK4ObEwttAMlu4iDpU2rkCoEe17TVnTuoU5sOCD
         MTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JzEkf301vBxksCdSOI+3LD73ofrahQzDQV1IM/I4/b0=;
        b=ID4WGzYsX/jHNhE2FB0Dyhg9Cpqf2LtKMgsZvBYUxsbOhZUkVOG+iKffTk/+bo1dzG
         xbqkoFtxaZgavP8LRhEP3TCjao/RlDcKfmadHnCTOX6/oftdVn/LLcOU4SBK2lbaomnt
         WEv9cI+PJNNTxutvvE11hATRXqT2eBIei0VjMcrbeR9mAob28MCn1BKqGn0PA7DDj4ww
         A8uUHpMAZrVdhycO7G9VFANrgaCT5c4LeipnqbsQB3UPyREsMwrAGunuKSAmVI7FHGZT
         NzvqXO9X+Wcjo0lIEwfSdalVW6DHs+v7NPyD5tXf7DxfCrH286T8hW2Q2H3sutDcoZvI
         HAAQ==
X-Gm-Message-State: AOAM530Hsh7MbyzUmHRYKUjygV6oCElYSyTO1QkPj52fFSSHsqfYybpV
        U5gnNrV/LyhHGKr/uvT47IENLy1ZIrs=
X-Google-Smtp-Source: ABdhPJwTmRlOm8iLGTeSaBZzePgTjwQ6m3ij7oclk6t8SaL3sUa8ktYczdbpiiiqMfzIkucSQu/jzw==
X-Received: by 2002:a05:620a:95d:: with SMTP id w29mr2236337qkw.76.1605279981420;
        Fri, 13 Nov 2020 07:06:21 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q3sm6869661qkf.24.2020.11.13.07.06.20
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:20 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6JmY000304
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:19 GMT
Subject: [PATCH v1 45/61] NFSD: Replace READ* macros in
 nfsd4_decode_layoutcommit()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:19 -0500
Message-ID: <160527997981.6186.2244400303133940403.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   99 +++++++++++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 44ffcaac3c8e..7ef6baf9c3b7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1806,6 +1806,57 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	return nfserr_bad_xdr;
 }
 
+static __be32
+nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
+		struct nfsd4_layoutcommit *lcp)
+{
+	__be32 *p, status;
+
+	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_seg.length) < 0)
+		goto xdr_error;
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32));
+	if (!p)
+		goto xdr_error;
+	lcp->lc_reclaim = (*p == xdr_zero) ? 0 : 1;
+	status = nfsd4_decode_stateid4(argp, &lcp->lc_sid);
+	if (status)
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_newoffset) < 0)
+		goto xdr_error;
+	if (lcp->lc_newoffset) {
+		if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_last_wr) < 0)
+			goto xdr_error;
+	} else
+		lcp->lc_last_wr = 0;
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32));
+	if (!p)
+		goto xdr_error;
+	if (xdr_item_is_present(p)) {
+		status = nfsd4_decode_nfstime4(argp, &lcp->lc_mtime);
+		if (status)
+			goto out;
+	} else {
+		lcp->lc_mtime.tv_nsec = UTIME_NOW;
+	}
+	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
+		goto xdr_error;
+	if (lcp->lc_up_len > 0) {
+		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
+		if (!lcp->lc_up_layout)
+			goto xdr_error;
+	}
+
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutget *lgp)
@@ -1830,54 +1881,6 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 	DECODE_TAIL;
 }
 
-static __be32
-nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
-		struct nfsd4_layoutcommit *lcp)
-{
-	DECODE_HEAD;
-	u32 timechange;
-
-	READ_BUF(20);
-	p = xdr_decode_hyper(p, &lcp->lc_seg.offset);
-	p = xdr_decode_hyper(p, &lcp->lc_seg.length);
-	lcp->lc_reclaim = be32_to_cpup(p++);
-
-	status = nfsd4_decode_stateid4(argp, &lcp->lc_sid);
-	if (status)
-		return status;
-
-	READ_BUF(4);
-	lcp->lc_newoffset = be32_to_cpup(p++);
-	if (lcp->lc_newoffset) {
-		READ_BUF(8);
-		p = xdr_decode_hyper(p, &lcp->lc_last_wr);
-	} else
-		lcp->lc_last_wr = 0;
-	READ_BUF(4);
-	timechange = be32_to_cpup(p++);
-	if (timechange) {
-		status = nfsd4_decode_nfstime4(argp, &lcp->lc_mtime);
-		if (status)
-			return status;
-	} else {
-		lcp->lc_mtime.tv_nsec = UTIME_NOW;
-	}
-	READ_BUF(8);
-	lcp->lc_layout_type = be32_to_cpup(p++);
-
-	/*
-	 * Save the layout update in XDR format and let the layout driver deal
-	 * with it later.
-	 */
-	lcp->lc_up_len = be32_to_cpup(p++);
-	if (lcp->lc_up_len > 0) {
-		READ_BUF(lcp->lc_up_len);
-		READMEM(lcp->lc_up_layout, lcp->lc_up_len);
-	}
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutreturn *lrp)


