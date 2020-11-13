Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C572B1E01
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKMPDz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgKMPDz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:55 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520DC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:55 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id j31so6824310qtb.8
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ucamVjvC0tfxLJKzNovDuj/v5WLm6p+0P1wiZNeN7Ec=;
        b=IY3RVMHSUgzZnIWf4jXuFETeDVV+PR8IvasL7cyXW+ZUjK3iFbzOg5DC/jXMoR6cea
         WmHB2OdNQqj1z7CPP4Rc+rK5tFyHHsQX61d7wdF4yvD1FPgrzVmiAc/LfQYL0InU4RD/
         BPBs6fKGybGM3wqXEgMsnFkLcWmJhnIyKH09/BrZ9BhsBdnh+dKlpbADkvYpppPgVaF5
         3IfeG8lyiTc+z+El5ah4hVW9wzPDjcXxQR11so4ylrvwZSNpEHTIiKTh/CuAjeTZoKlt
         1wZtTaBV3p7zA9gFUQDf4Vux5LkT11WQAd/+vZ3OwKVPoN2eYpR+zfUtea1GxUYLxCu4
         9PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ucamVjvC0tfxLJKzNovDuj/v5WLm6p+0P1wiZNeN7Ec=;
        b=WjA1j36WO2tkXJRJx1HSLHfqdb03m2MTPll0ZvJ7pZcHZR5TkYzcPGOxlamZJOkEkM
         o7xrkCLGvXPIg1dG0GNGbbyHJ2mgztzNxBRJxziT+fI1N+IxUnimYSrLfGU6sKj/Itkf
         E/fPFq5hHhGAcdNCcTjl8hPSliEqOIyx9a++stShfmcLH2SobajDnQgwCooerhAuYM66
         OAHVD+Vv0axppzSXC8AgCSU0t2bls3EMMdvsot9CO92KyTD70x5gQLgxHHK498TDtcQf
         UzqimAndJmZ0q/d3u6PjVHzsJ3ovB/yAKqADt3Qk5+E7+jadvw/dNbhNiGeakrKNlr5/
         2s7Q==
X-Gm-Message-State: AOAM531WvL2a32gSPeBHznC1EY+x6SIjGvVwsEvOf6beu3ItEB8mRAjl
        grnxRm/qCImINZDl2fw6+Orie/DPNu8=
X-Google-Smtp-Source: ABdhPJyyvxR7oLnj6/QQzHhdgRpHy4wGqdDM+GNp3ogaYSubdRxBXIiAsb1gOR8Jysyxc8g8N4/U5w==
X-Received: by 2002:ac8:8c7:: with SMTP id y7mr2314906qth.278.1605279834096;
        Fri, 13 Nov 2020 07:03:54 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q15sm6776646qki.13.2020.11.13.07.03.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:53 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3q5O032688
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:52 GMT
Subject: [PATCH v1 17/61] NFSD: Replace READ* macros in nfsd4_decode_time()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:52 -0500
Message-ID: <160527983260.6186.16461032871828686896.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6bb6ffa676b7..69ff666a5695 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -262,17 +262,22 @@ static __be32 nfsd4_decode_component4(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
+nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 {
-	DECODE_HEAD;
+	__be32 *p;
 
-	READ_BUF(12);
+	p = xdr_inline_decode(argp->xdr, sizeof(__be64) + sizeof(__be32));
+	if (!p)
+		goto xdr_error;
 	p = xdr_decode_hyper(p, &tv->tv_sec);
 	tv->tv_nsec = be32_to_cpup(p++);
 	if (tv->tv_nsec >= (u32)1000000000)
-		return nfserr_inval;
-
-	DECODE_TAIL;
+		goto inval_arg;
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+inval_arg:
+	return nfserr_inval;
 }
 
 static __be32
@@ -413,7 +418,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
 			len += 12;
-			status = nfsd4_decode_time(argp, &iattr->ia_atime);
+			status = nfsd4_decode_nfstime4(argp, &iattr->ia_atime);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
@@ -432,7 +437,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
 			len += 12;
-			status = nfsd4_decode_time(argp, &iattr->ia_mtime);
+			status = nfsd4_decode_nfstime4(argp, &iattr->ia_mtime);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
@@ -1417,7 +1422,7 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			goto xdr_error;
 
 		/* nii_date */
-		status = nfsd4_decode_time(argp, &exid->nii_time);
+		status = nfsd4_decode_nfstime4(argp, &exid->nii_time);
 		if (status)
 			goto xdr_error;
 	}
@@ -1649,7 +1654,7 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
 	READ_BUF(4);
 	timechange = be32_to_cpup(p++);
 	if (timechange) {
-		status = nfsd4_decode_time(argp, &lcp->lc_mtime);
+		status = nfsd4_decode_nfstime4(argp, &lcp->lc_mtime);
 		if (status)
 			return status;
 	} else {


