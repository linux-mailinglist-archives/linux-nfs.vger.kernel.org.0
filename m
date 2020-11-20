Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DF52BB728
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgKTUfJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgKTUfI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:08 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569FC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:08 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r7so10210151qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qHqdvjtxdc66aVDj1632nYW9ENPmpSnViYBEpu5vhzc=;
        b=p7Few09oTY3+gwkUWK8nTeMGH1K/4FSiWwbAuYyRl8VZybW6TCJJXlluINODn0GLID
         qJDopGdjbzgmaxp7qCrivnJkX+eCEPWU3LzfAHzzOL9m72VTReCkS/kDf/k7oYF/3iDc
         bMA3/ZLdo+F5AbXppG0pnNBT5Gs0PLg0oULz8XRFmb5khAyfZiL6BSHHTpo8y39+fleE
         eRBEsy+7JHXf4Y8wrowuh9PO6OEhdsOFZzaB4H/A9VTzcGIcP2H4RjJ2qQHDdM9+XNAE
         guvMEqhQM3n+SpKxb2C3RzVX6HSbdBxsfnojUL6VE3CzFP6jYHKeYXmuWCWBC4HJR9aL
         5biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qHqdvjtxdc66aVDj1632nYW9ENPmpSnViYBEpu5vhzc=;
        b=sF60d53FOa15zI0Ay/Y6h1zhuGR7BEtlznFgb04nFgvl6do+Tvn3tsK/A6jiiv6HqA
         xJthlSm+h7rRalzNbdjgNY4HGcl/+MHYBkiFqB5+1JEJonV4A3uw1YMG4/37iE14kSH3
         x75IY+TxzhNQRTxiqiqVx5ZST9ucQfP2o/el+EcR+hCPUDFm9rIzK/gPFT6609xlmZ3R
         pl8EbNr1+eNkiQEaDUqtp3JE7S1mXt714jct7JZcFK8Yx0e7OtWEuIrlGKs0v9gBIQcS
         xgyPzWmqrcKftkhdDMGYgOlDyfusnLT+083HrVpBiuN98aSvdMftnZOIDfSquw96cuSk
         8c+g==
X-Gm-Message-State: AOAM532RN5Y17oOuaq+ZKEi/QiK2geeb34O9PhwHzbL/jAHt9USrL2SN
        v6uMTK1N7yY3k1yM83OCcvicoeGpjVI=
X-Google-Smtp-Source: ABdhPJxp/W9JDA1sa1hq710T45RbFuEZIcr5g9ifalGDAVpu/Lf09Akp3aLI//KtNti9/ZP8pYa3Cg==
X-Received: by 2002:a37:d16:: with SMTP id 22mr17986511qkn.335.1605904507445;
        Fri, 20 Nov 2020 12:35:07 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x5sm2682962qtx.61.2020.11.20.12.35.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:06 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZ51G029247
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:05 GMT
Subject: [PATCH v2 015/118] NFSD: Replace READ* macros that decode the fattr4
 owner_group attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:05 -0500
Message-ID: <160590450574.1340.13284729078070940578.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7e9c1112cfea..53cd69ff54f7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -372,11 +372,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		iattr->ia_valid |= ATTR_UID;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER_GROUP) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
-		READMEM(buf, dummy32);
-		if ((status = nfsd_map_name_to_gid(argp->rqstp, buf, dummy32, &iattr->ia_gid)))
+		u32 length;
+
+		if (xdr_stream_decode_u32(argp->xdr, &length) < 0)
+			return nfserr_bad_xdr;
+		p = xdr_inline_decode(argp->xdr, length);
+		if (!p)
+			return nfserr_bad_xdr;
+		status = nfsd_map_name_to_gid(argp->rqstp, (char *)p, length,
+					      &iattr->ia_gid);
+		if (status)
 			return status;
 		iattr->ia_valid |= ATTR_GID;
 	}


