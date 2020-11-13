Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EB82B1E05
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKMPEM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMPEL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:11 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07231C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:11 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id t191so9031015qka.4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UjrhjxcUN9c0UXHlv7afSsmV4W02b6jenOnKHdReaBY=;
        b=AI7cGEXuXtRXDOHSANTnkxAPQ6Ikfbt6Q6RpQCOeV16l0psCEuUwvRzog6f+K5s3dY
         4zg2PKuc4mBviZT2qeJjtAUuk/1FT1rkaUU/Fc5f8vhpPSE5zMkHsHZGVkAb69bay5Zq
         L8NlTDCMzb5WE/1D404ziU20DSVGEuOZMOF3iWtzzLs947PKH+Oy6CzXaQXRJ4NOOh6j
         R5bzoDBTYxM07m0mbDmn1NEADoRH/CppKcd95QDe8mflThhhQkL9u4Yv/hyWz/VXRSTc
         1zNl7blBE/OddX1LJNfv+69TexpMMaFqr7Aknlq3F0wEI/c9fBX49Pr0PjpM5Mwm2JHm
         Xidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UjrhjxcUN9c0UXHlv7afSsmV4W02b6jenOnKHdReaBY=;
        b=TsETHU3IfzaFuyzC508tmGgdbnGaILLCln75U4g6xbYy7G0ITq8ngiJ053BouRgZqK
         8trX5ISacDbQwno2Ac8MAVLZecMizhZpP7eMP3IhDu46AtCSj1Je4XU3dNNqFuWIDvws
         Q7OeTG+W0a4c12MzPXz3+nY2F/ZOVejhVNluCHV7Ne82heOvZ7wWpMLUhY84tuEiTxuh
         HFjR1QHbDgv7YJR1El981eCB9MICbyYbHGAmZIDH1XS+0H/G4ctQrRVEMnCn5m6f1XU2
         ZuQEnzgwsu9ZRcb24nwH/gl0cQPhrQF73fPuzKQwhwOOgHaRBaA+WI3GVh3xvWwDRh5Z
         97OA==
X-Gm-Message-State: AOAM532SXKUoYBkwNoOlmGxRXTAKACy7L6PX71zTDnISfeAzlsa1IPVz
        3vItIoCIwD+ya9WOCNlbDTpUpMFtaTA=
X-Google-Smtp-Source: ABdhPJw+UGVL3M5n9nRvM6DroLS0Ce5zXLLT2Ero57HsKNB0MLwLZFP+x6kW3pBuprgYO7S26kiWNA==
X-Received: by 2002:a37:946:: with SMTP id 67mr2181199qkj.304.1605279849893;
        Fri, 13 Nov 2020 07:04:09 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 199sm2310642qkj.61.2020.11.13.07.04.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:09 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF48rN032697
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:08 GMT
Subject: [PATCH v1 20/61] NFSD: Replace READ* macros in
 nfsd4_decode_open_confirm()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:08 -0500
Message-ID: <160527984824.6186.3658550944136540072.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2ff3dfaca4a1..b4f23d1fd85e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1100,18 +1100,22 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 static __be32
 nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_confirm *open_conf)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
 	status = nfsd4_decode_stateid4(argp, &open_conf->oc_req_stateid);
 	if (status)
-		return status;
-	READ_BUF(4);
-	open_conf->oc_seqid = be32_to_cpup(p++);
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &open_conf->oc_seqid) < 0)
+		goto xdr_error;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


