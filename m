Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9147B2C15A7
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgKWUGD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgKWUGC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:06:02 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36E6C061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:02 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f27so4790704qtv.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+C9OJnuEYoXcbVXmnzeB8sVuBQr/3jK7A/BGCrmeWk8=;
        b=NKS8h1r7S/LfjRLGSvZn46AaTjdDQUuebcA+ZD1inn0+8YDTVUXthkl4FLPg1ChGq0
         1GNSwoqBs33l8oI+dHq5AOzeFyybRgIQSv21wn7UCGfih7f5hyTQEI29cANOWO3DdF00
         vUNIo2CJL8f2WNvZofB/0AJ0aG+j71+EqSqxMpUQZt1kq0tvmZ2ACPIouMfEP8f7FbZv
         FxLP4A4/QdsqqXLbTqSrT4aQ2/6RrfjjKJZetf0UJIHcdg4i22TBMA7pkJ5uOZPLfmr7
         UJLREHX9d2E4u2WclCETIdKmKA22yZYCpC8wXfm+O9onl4beC3sdKKvbx1BCyYlwhsIy
         w3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+C9OJnuEYoXcbVXmnzeB8sVuBQr/3jK7A/BGCrmeWk8=;
        b=Sthw3cuce6a9cQc+Wr+55/IQSrtg3zXeVL87V9ncvYxX3j2AkqAuXDrsRePrCe1LCZ
         YSKvQBH4mbc58K8bI96pC1XoOnBg5IJPKNBGSsLjzs3DoM3uFtyvontk2UCc6lVsvYyt
         Y7AHBM+fPm8077iJCgttt35Xfa2+LYiGpDMvjXEMejFUiyXzZJi5Uqf2X7oBJaLboXEv
         vrcGUeRtgJxcUj2wHyBdCAC7QCN0ee6vZ/zr3dY3DVVMJsmpSUsCZ1ZVk5KtCqL0RmdM
         2Z1yOEd5TETMaFKWsi3ETzlkI2qpz9QifdgKXWkuxF1QxiF/nZXDgK/7kp/tHakK/XPW
         qrRA==
X-Gm-Message-State: AOAM530eWvgvAqSQb1T8BXOBpeejthsBDDI6iyFh8rG+00DA9tIgDbvg
        AguFv2vZXaaThp3K51QXBHU95P9ZXmQ=
X-Google-Smtp-Source: ABdhPJwlSiiOIcvx9bzMS4GJEKasiL725u9Z4e6mI+QHCvWL2gQnHkIPciO36/q6bW6rhMMsNo1bDg==
X-Received: by 2002:ac8:5411:: with SMTP id b17mr850381qtq.281.1606161961741;
        Mon, 23 Nov 2020 12:06:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b197sm10546161qkg.65.2020.11.23.12.06.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:01 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK60Wm010337
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:00 GMT
Subject: [PATCH v3 23/85] NFSD: Replace READ* macros in nfsd4_decode_link()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:00 -0500
Message-ID: <160616196011.51996.16491219201037247295.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 52e461969f09..472d715e8632 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -779,16 +779,7 @@ nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *geta
 static __be32
 nfsd4_decode_link(struct nfsd4_compoundargs *argp, struct nfsd4_link *link)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	link->li_namelen = be32_to_cpup(p++);
-	READ_BUF(link->li_namelen);
-	SAVEMEM(link->li_name, link->li_namelen);
-	if ((status = check_filename(link->li_name, link->li_namelen)))
-		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &link->li_name, &link->li_namelen);
 }
 
 static __be32


