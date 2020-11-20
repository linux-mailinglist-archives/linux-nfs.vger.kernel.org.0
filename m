Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9009F2BB727
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgKTUfD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbgKTUfD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:03 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB73C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:03 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so10238034qke.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NDvCnlUBKTH8BONeWvYh6YYL70z+xBpgUT1AqFmxRuc=;
        b=ZnP/5fH2nB7DP9D01quGAQ6LaErHNzTMLZ8oLfxkUtJfj2PCXY+CU1W7uvpSoT/a4I
         nLsFHr6ZXx3/vjlLM5/BFd/V+DCqsLv2+T3tTsc3HBUqEUuDzO4JYqTVYh/V5e7Vvme7
         2KGA5NCMBqd5P/e+ZNI4TO8tZE0zq4YDyXbsszJRHnLCtVmvZtRqYKTJAPYHJjhmi/wY
         ZsgEo7F73QTDdkgj+jTUguMVQJZzgsc03jpS1uYx4EO+b0Dj9YZPkaGqEm9CPU9ch5kG
         FHgc8+N+1naUdHY5EhFeX9jPAdDbQ3MPpgo5Em75Pl8Ndl/dmqxArHiSMXwobOt0pJA0
         qPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=NDvCnlUBKTH8BONeWvYh6YYL70z+xBpgUT1AqFmxRuc=;
        b=mIhvF/EsWdiOLssfLfqpnnihVoASqa7M5AINZuAjvf7Nz4OPI2o/OCPrJhE2v5KGh3
         JQLKLUWpw+4Mv+lImeN2cXlUbWv3HAwHZTOItM3LGGrfQLmbImCfFRsIeOMZAhV2FQGS
         hh6msjFV1FrDZ8MbZk+OyqYbzTKm4UuRAsUGDZat2ud5qyd9+zI14QpfrjDzXgCxn4RG
         466vUjszTf80/S1omytHPsQj4Tp1xK4edSMRUYKEQjqeabg5tFSQTLNptsMFJyIpk2A7
         2rJUug7ScLGEc52lme572BG1fbczxNicj9d4UgU4Y5EpKcyplccdJockPTlbzWkyMHC4
         oIDw==
X-Gm-Message-State: AOAM532qs1XQD7ZR2hLB6jngjpENrJtTgZfT3oPZy2MPwv6nQAisZS2S
        f/hC8e2FYLfjDqU6JQ8OQKVMH5u353U=
X-Google-Smtp-Source: ABdhPJzS5QmYqoPfTv6uUWMozrKZO3qvwI6WlsS8huBUtrHLeSwoXN63Cqj9dyPMz9wnt+Fb5XvoKA==
X-Received: by 2002:a37:6554:: with SMTP id z81mr17887423qkb.423.1605904502150;
        Fri, 20 Nov 2020 12:35:02 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w30sm2818683qkw.24.2020.11.20.12.35.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:01 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZ0hU029244
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:00 GMT
Subject: [PATCH v2 014/118] NFSD: Replace READ* macros that decode the fattr4
 owner attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:00 -0500
Message-ID: <160590450038.1340.17798254082792701410.stgit@klimt.1015granger.net>
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
index 821a03121d22..7e9c1112cfea 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -358,11 +358,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		iattr->ia_valid |= ATTR_MODE;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
-		READMEM(buf, dummy32);
-		if ((status = nfsd_map_name_to_uid(argp->rqstp, buf, dummy32, &iattr->ia_uid)))
+		u32 length;
+
+		if (xdr_stream_decode_u32(argp->xdr, &length) < 0)
+			return nfserr_bad_xdr;
+		p = xdr_inline_decode(argp->xdr, length);
+		if (!p)
+			return nfserr_bad_xdr;
+		status = nfsd_map_name_to_uid(argp->rqstp, (char *)p, length,
+					      &iattr->ia_uid);
+		if (status)
 			return status;
 		iattr->ia_valid |= ATTR_UID;
 	}


